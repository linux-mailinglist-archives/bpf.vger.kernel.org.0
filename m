Return-Path: <bpf+bounces-31008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE288D5F5A
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9F41F24519
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45B149C76;
	Fri, 31 May 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqGtQAiS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7A17554
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150556; cv=none; b=lJRX9unHIfn60s+oqsJPTMqzliGoJePsiNmpFCeGOZ7dvm19kUipsYvMZma/cRIWhFDTzRDCj0JOpUwJaymMyX+NpUgDyuFGy5CFaCEUQQP4beT1zhhVFV1/Gyg9U0hnQg50hOEo1py3JoWJ3Znd77iyCx4jTECZIWD1TeNeh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150556; c=relaxed/simple;
	bh=e1SYhcuKraD1xKh4F2eTmybtyvKsDfq1A14bzEoeQKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcDr311RKr8YKWStwZdNUN7Nj4V0X2L34T49rle+KDGQKu/a/7pVU+DICTycEiBOhfA2o2O7e2m2tzISNbCZP8y3sLi0QksmY1SCCFvu0VSOKoVBcMjREawF5kY1jnrJVLVpuCCbB+JYKNit6veEKPgFeLLbEwtPDcmJHIMZm1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqGtQAiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548E8C116B1;
	Fri, 31 May 2024 10:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717150555;
	bh=e1SYhcuKraD1xKh4F2eTmybtyvKsDfq1A14bzEoeQKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QqGtQAiSADvF2dtzji8ZxM+zF8+QTNWb4jRkGeM8eOv2ZcmBOR2ZtbF1C0ykmVfp4
	 VPWLVgxt3OjAAuKQdhCNjr07f7/tq7QcHntL/8SJGzjrIn1jNjveJueIAcvo92zCfz
	 Nb7Yi43LQoQnEq2XyXdNqZUb9S7r4Ntc4IG0XQSI0LvIVxyWH6gxbinMhcyIl4/3eM
	 UaxdBeRtgabilWiIYoQcvhBjNEiXrWXYsqSh1fq2LRVcRbM2Ex03NS7/fHRuP9E6bL
	 /YakgumkSEAHYIyRFoubdFDS5l7suvOItzMWocf8Kwv8IPM5Qiv3K9U5LQa6km7B8R
	 mCo/1Za5iYeLw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Make session kfuncs global
Date: Fri, 31 May 2024 12:15:50 +0200
Message-ID: <20240531101550.2768801-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
by Sebastian [1].

Instead of adding more ifdefs, making the session kfuncs globally
available as suggested by Alexei. It's still allowed only for
session programs, but it won't fail the build.

[1] https://lore.kernel.org/bpf/20240531071557.MvfIqkn7@linutronix.de/T/#m71c6d5ec71db2967288cb79acedc15cc5dbfeec5
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Fixes: 5c919acef8514 ("bpf: Add support for kprobe session cookie")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..cc90d56732eb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3519,7 +3519,6 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 }
 #endif /* CONFIG_UPROBES */
 
-#ifdef CONFIG_FPROBE
 __bpf_kfunc_start_defs();
 
 __bpf_kfunc bool bpf_session_is_return(void)
@@ -3568,4 +3567,3 @@ static int __init bpf_kprobe_multi_kfuncs_init(void)
 }
 
 late_initcall(bpf_kprobe_multi_kfuncs_init);
-#endif
-- 
2.45.1


