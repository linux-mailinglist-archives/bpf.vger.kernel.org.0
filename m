Return-Path: <bpf+bounces-2623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E487317E8
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 13:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D9F1C20E63
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F313AE5;
	Thu, 15 Jun 2023 11:52:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE312B69
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 11:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06B1C433C8;
	Thu, 15 Jun 2023 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686829960;
	bh=vzXaLtl6SzbvAGUpSSunsAgBa5POCxudf8Ga0otXJQU=;
	h=From:To:Cc:Subject:Date:From;
	b=ETYkAhwtp5kNnRtpjzuT4+P3vKvOR2SXhqd4Q8qIpLEGQl6dYfiqvReb117moKwM0
	 LdRSt8WIYArfD9xxw9VDPZkTSWuHYapMzGO0mAQIHYlfaZalEYEUIxzcXQNxfgplip
	 HFSkXpe4WVm8vK1ciYLuagzQS77bEkvoRMS9V0DxIqX/IpuS3JOBRhOuDHK1QlOQJh
	 ZuVKK4rULuoGZdXfT5urJ5l1fOfaOuLe7P14w9PSeSu6nEAocRDhXIdQXNFJTwFShi
	 /wM/YDUZ9tDa5U3Zf3y+3cTlwxPE9hKOABGrBM2pcfjZYmcgPaBrZrQlZmxvcaKYkJ
	 pRsGyu2GFtomA==
From: Jiri Olsa <jolsa@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] fprobe: Release rethook after the ftrace_ops is unregistered
Date: Thu, 15 Jun 2023 13:52:36 +0200
Message-Id: <20230615115236.3476617-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running bpf selftests it's possible to get following fault:

  general protection fault, probably for non-canonical address \
  0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
  ...
  Call Trace:
   <TASK>
   fprobe_handler+0xc1/0x270
   ? __pfx_bpf_testmod_init+0x10/0x10
   ? __pfx_bpf_testmod_init+0x10/0x10
   ? bpf_fentry_test1+0x5/0x10
   ? bpf_fentry_test1+0x5/0x10
   ? bpf_testmod_init+0x22/0x80
   ? do_one_initcall+0x63/0x2e0
   ? rcu_is_watching+0xd/0x40
   ? kmalloc_trace+0xaf/0xc0
   ? do_init_module+0x60/0x250
   ? __do_sys_finit_module+0xac/0x120
   ? do_syscall_64+0x37/0x90
   ? entry_SYSCALL_64_after_hwframe+0x72/0xdc
   </TASK>

In unregister_fprobe function we can't release fp->rethook while it's
possible there are some of its users still running on another cpu.

Moving rethook_free call after fp->ops is unregistered with
unregister_ftrace_function call.

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/fprobe.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 18d36842faf5..0121e8c0d54e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -364,19 +364,13 @@ int unregister_fprobe(struct fprobe *fp)
 		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
-	/*
-	 * rethook_free() starts disabling the rethook, but the rethook handlers
-	 * may be running on other processors at this point. To make sure that all
-	 * current running handlers are finished, call unregister_ftrace_function()
-	 * after this.
-	 */
-	if (fp->rethook)
-		rethook_free(fp->rethook);
-
 	ret = unregister_ftrace_function(&fp->ops);
 	if (ret < 0)
 		return ret;
 
+	if (fp->rethook)
+		rethook_free(fp->rethook);
+
 	ftrace_free_filter(&fp->ops);
 
 	return ret;
-- 
2.40.1


