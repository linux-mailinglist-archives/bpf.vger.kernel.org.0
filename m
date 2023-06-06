Return-Path: <bpf+bounces-1949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82D4724B09
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 20:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23682810AD
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B760A22E3E;
	Tue,  6 Jun 2023 18:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443719915
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 18:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27886C433EF;
	Tue,  6 Jun 2023 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686075435;
	bh=NRAwuCnQ/k1zoOM/FoA7z14DKwkPpVT9rfhGHnp4WB4=;
	h=From:To:Cc:Subject:Date:From;
	b=GlzWBQuGtTIkgWxSm6conpdPlDg8lnSzJ1UeYGXhs8CP5rAaEDZT6p6HCJSEBdMds
	 vQv1KfZ91Jf57pLZoHXJFWCnw/2zJshlFBa2E32dGBgZVZq5R5z8DYeZRWXvJiHEGx
	 AdOPlW2YtPlukl9/M9ue/dmbKLNvWE2xajxRcBK3wcrHIaYdLFtPVkL+J2NBq7CDqC
	 E73XUtARSL8rZZCqwDHhydkzdCgJ3outWO6SlV89GM9ezIl7Dv5mMlYR3mDcHY67wC
	 xrfdR/DQsUAQFYAlH18mlVtSTZV3wxmPznsqHCwVEURMhKZj4WOuQlfk+NbMF5nIcQ
	 Z7icNA5byfK+Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Anastasios Papagiannis <tasos.papagiannnis@gmail.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Hao Luo <haoluo@google.com>
Subject: [PATCHv2 bpf] bpf: Add extra path pointer check to d_path helper
Date: Tue,  6 Jun 2023 11:17:14 -0700
Message-Id: <20230606181714.532998-1-jolsa@kernel.org>
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
trusted pointers, so the above code would fail even to load.

For the sake of the stable trees and to workaround potentially broken
verifier in the future, adding the code that reads the path object from
the passed pointer and verifies it's valid in kernel space.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
Acked-by: Stanislav Fomichev <sdf@google.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

v2 changes:
  - used copied path object pointer for d_path call [Alexei]
  - added ack [Stanislav]

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9a050e36dc6c..1f4b07da327a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -900,13 +900,23 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 
 BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
 {
+	struct path copy;
 	long len;
 	char *p;
 
 	if (!sz)
 		return 0;
 
-	p = d_path(path, buf, sz);
+	/*
+	 * The path pointer is verified as trusted and safe to use,
+	 * but let's double check it's valid anyway to workaround
+	 * potentially broken verifier.
+	 */
+	len = copy_from_kernel_nofault(&copy, path, sizeof(*path));
+	if (len < 0)
+		return len;
+
+	p = d_path(&copy, buf, sz);
 	if (IS_ERR(p)) {
 		len = PTR_ERR(p);
 	} else {
-- 
2.40.1


