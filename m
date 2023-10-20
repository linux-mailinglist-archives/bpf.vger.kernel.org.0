Return-Path: <bpf+bounces-12817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F217D1082
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C4B1C20F71
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D781BDDC;
	Fri, 20 Oct 2023 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knT9wUf+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A11A59F
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C0C433C7;
	Fri, 20 Oct 2023 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697808477;
	bh=CUPCLoZKlk4Vm8CIWIXYNCFjVcmILxXwZ8VIwc2nQpA=;
	h=From:To:Cc:Subject:Date:From;
	b=knT9wUf+n+I6fPtdBxI/pE5B8NoaxmLwCjW4MFDA4RhXjIClZ2NT83fvwzcj6TNcC
	 8e7WZKf49jBZz1QBSP6ZAhqUocdJum9HcIS8c+D0rBHSrtAL3h0zhH/ugHUZ6gDUKf
	 NhxsCDzl9CANVzEjoe+Ufz83C2eYrdaD6TygJs/weFS16G52SDIutqpUANWRyJidfV
	 RenAWqNjsKcBcjdYKfFTbZ4xaxWAJWPrSaKq3XZyEHwqnOforRXYWJyyuI5hMyU6FW
	 gr2dtfGY47EWnNdQR0ynUfNLhwFcwgy//OXdEfB3rk3FeOzbziG/SKS+U5U20arFUq
	 r8E7p/nd20UXw==
From: Arnd Bergmann <arnd@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: hide cgroup functions for configs without cgroups
Date: Fri, 20 Oct 2023 15:27:35 +0200
Message-Id: <20231020132749.1398012-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When cgroups are disabled, the newly added functions don't build:

kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
      |              ^~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c:925:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
  925 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
      |                                                            ^~~~~~

Hide them in an #ifdef section.

Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/task_iter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 654601dd6b493..15a184f4f954d 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -904,6 +904,7 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
 
+#ifdef CONFIG_CGROUPS
 __bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
 		struct cgroup_subsys_state *css, unsigned int flags)
 {
@@ -947,6 +948,7 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 	css_task_iter_end(kit->css_it);
 	bpf_mem_free(&bpf_global_ma, kit->css_it);
 }
+#endif
 
 __diag_pop();
 
-- 
2.39.2


