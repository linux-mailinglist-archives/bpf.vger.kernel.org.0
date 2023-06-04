Return-Path: <bpf+bounces-1774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446172178E
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD68281168
	for <lists+bpf@lfdr.de>; Sun,  4 Jun 2023 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83ADDA2;
	Sun,  4 Jun 2023 14:01:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496923C6
	for <bpf@vger.kernel.org>; Sun,  4 Jun 2023 14:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C92C433D2;
	Sun,  4 Jun 2023 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685887268;
	bh=N4OFkIofJcG4jbiBZuJM/QCykJe9kktreLtBi08BAQU=;
	h=From:To:Cc:Subject:Date:From;
	b=jqMaBPppWjwld7hKoaTIAQgPbMaSl19LBnAhB4B1ud4EnbyMZuzkwdsXp2HSn5+iy
	 m/JehzdLvij9nc4i8mO1wt2oWkQrD8yFKhSfkLqxO7Qk2Of0q/Yw3lksQ0Q4V3wt0I
	 XU8iV5jCXxSIfb5u/VfAqrF+UFDsm/n2jf6GVmOuQ8HY08ndA7Sj4X7PxTOc6KhX6m
	 IaOF81WfYVAVyHAgOhwfhd1S8Pkb3xXYi6efQmo2EBM5FwIgOKpTyRtQT2/AWjQUUB
	 NRZ+DVMQzlzFJlQlsi81YUcqUynSwQxbBP4cYiQDnm+udonloqkfGjSPdyC8CYcCIW
	 Y/ZBRPjmeMh3A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>
Subject: [PATCH bpf] bpf: Add extra path pointer check to d_path helper
Date: Sun,  4 Jun 2023 16:01:03 +0200
Message-Id: <20230604140103.3542071-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Anastasios reported crash on stable 5.15 kernel with following
bpf attached to lsm hook:

  SEC("lsm.s/bprm_creds_for_exec")
  int BPF_PROG(bprm_creds_for_exec, struct linux_binprm *bprm)
  {
          struct path *path = &bprm->executable->f_path;
          char p[128] = { 0 };

          bpf_d_path(path, p, 128);
          return 0;
  }

but bprm->executable can be NULL, so bpf_d_path call will crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
  ...
  RIP: 0010:d_path+0x22/0x280
  ...
  Call Trace:
   <TASK>
   bpf_d_path+0x21/0x60
   bpf_prog_db9cf176e84498d9_bprm_creds_for_exec+0x94/0x99
   bpf_trampoline_6442506293_0+0x55/0x1000
   bpf_lsm_bprm_creds_for_exec+0x5/0x10
   security_bprm_creds_for_exec+0x29/0x40
   bprm_execve+0x1c1/0x900
   do_execveat_common.isra.0+0x1af/0x260
   __x64_sys_execve+0x32/0x40

It's problem for all stable trees with bpf_d_path helper, which was
added in 5.9.

This issue is fixed in current bpf code, where we identify and mark
trusted pointers, so the above code would fail to load.

For the sake of the stable trees and to workaround potentially broken
verifier in the future, adding the code that reads the path object from
the passed pointer and verifies it's valid in kernel space.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9a050e36dc6c..aecd98ee73dc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -900,12 +900,22 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
 	p = d_path(path, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
-- 
2.40.1


