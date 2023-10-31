Return-Path: <bpf+bounces-13720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6A47DD0EE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E2D281117
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40231F945;
	Tue, 31 Oct 2023 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACAIAmlp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303B71D556;
	Tue, 31 Oct 2023 15:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F1AC433C8;
	Tue, 31 Oct 2023 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698767395;
	bh=ptwLXdCn0ccaumT/kPopEMDLG2wWUx3Jgvu71frbDck=;
	h=From:Date:Subject:To:Cc:From;
	b=ACAIAmlpCE0abUrhPB/XsWgklzKUtZcCk/HO7TSB3qnrzQE9WhOAzVMluqEAhTSZc
	 ckAyIOAYCUFJbVmbU5x+/e8NZfTPVZXfzeoPb19uz68m1lSemaSwm4H2K0MN7LtHLb
	 CwIliDkHgt1jToW4EezZvA/QOA5+KWd/k3xoNtxgRhfcsUzKwvLFRcHi6QsIs7QQOJ
	 y19uudAIQ9QSz60WGNBXNrIL3tqvQ3isjKMJBFxKPUwayzxWB0hok9K7rgSphsJq79
	 ZvRxJKBq/AZYw+p9ddgFkhI78DdBNPZqqqePL4A1w2ChMNQHXL/34bbAubvWhZXv9L
	 VKI5xbRcLAijg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 31 Oct 2023 16:49:34 +0100
Subject: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA0iQWUC/x2M0QqDMAwAf0XyvEBqVWS/MvYwa+oCs5ZEhiD+u
 9XHg7vbwViFDZ7VDsp/MVlSAfeoIHw/aWKUsTDUVHtH3uGQI4ZlzvJDVsVghtR20Y8DNX1HUMK
 sHGW7py+4/MTbCu/jOAGEKaWIbgAAAA==
To: Yonghong Song <yonghong.song@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
 Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3822; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ptwLXdCn0ccaumT/kPopEMDLG2wWUx3Jgvu71frbDck=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlQSIf7JzITS5yigKSmkjBEojx4ObevveToHbTO
 HbhWN3Vsy6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUEiHwAKCRD2t4JPQmmg
 c693EADmVd/miwyt3lQhaFzmnmadovlFUo9fUa0ZqvDwzTRA3eiqY1LYjMou+syLNJndFI/e9u/
 1jtiqO+vJ6WvInqW6lJPyhK9Gazo9/+DaSgq+exeB5GFcDDgwU7Ar97dUIvC/kXNKFNucFFsItX
 2ORKGxVnWScKW0e0Sq+csK6DcKrNV4258dB6l8ZULB/7WP7AEBZEMgTxltfFfogNxTS5JtisUFH
 xoWIaW5zpCxJgJ54kcJ5wvDy/OmLMkuNHhTPVbaerFNnqj5peDMQpEwks1226XUq10nMK03Z75/
 HgChOn+Yp8BUYJUh1ZLRHYmn/97bLIYAb8bpSPpwdqe8/A68eIYkCJSXR8+1jkmJqjKfrMCkCQV
 l5Pc0Xg64eQTGVjI0vCeOqIXYTHib62t34yoOGWozvjFq0DH45YmyqVu0WllKyCbrJlw/ZWjyUl
 aCP02+UlApolXNJhrei2wk7/rVCOY16F39LFhqVu4O/g3vwP0LRXeEQkd4MiwLmEpAbTeEN/DCP
 bvNgLKcO8wAqC8XFoP7TV/eVwanwTk+fpHfstswWxmMNn7BjC2GsqSFPQYj+6yjb76WhJbIPObJ
 4os5PrT/QpWmaWvGxA3URiUOJ4i/wsFmKsCpgvV7Cy8MkrpGs9cvhAY+l8zoiFV7ScQp1Xz5DjH
 b4nh7Z2GUs86WCQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
possible to build the kernel without CONFIG_CGROUPS:

  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
  kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |              ^~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
  kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |                                    ^~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
    927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
        |                                                            ^~~~~~
  kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
    930 |         css_task_iter_start(css, flags, kit->css_it);
        |         ^~~~~~~~~~~~~~~~~~~
        |         task_seq_start
  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
  kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
    940 |         return css_task_iter_next(kit->css_it);
        |                ^~~~~~~~~~~~~~~~~~
        |                class_dev_iter_next
  kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
    940 |         return css_task_iter_next(kit->css_it);
        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
  kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
    949 |         css_task_iter_end(kit->css_it);
        |         ^~~~~~~~~~~~~~~~~

This patch simply surrounds with a #ifdef the new code requiring CGroups
support. It seems enough for the compiler and this is similar to
bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
been added in kernel/bpf/helpers.c and in the selftests.

Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 kernel/bpf/task_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 59e747938bdb..e0d313114a5b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -894,6 +894,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 __diag_pop();
 
+#ifdef CONFIG_CGROUPS
+
 struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
@@ -952,6 +954,8 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 
 __diag_pop();
 
+#endif /* CONFIG_CGROUPS */
+
 struct bpf_iter_task {
 	__u64 __opaque[3];
 } __attribute__((aligned(8)));

---
base-commit: f1c73396133cb3d913e2075298005644ee8dfade
change-id: 20231031-bpf-compil-err-css-056f3db04860

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>


