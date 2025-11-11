Return-Path: <bpf+bounces-74234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E115C4EF14
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE76534CF4A
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064B36B073;
	Tue, 11 Nov 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbbBfMdT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA24736B066
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877409; cv=none; b=IZYAOTe/9fHXy1evQW+/aZgj79I0BPL3Ja6iBybxHK/KImnAHN7w0hM/bvB4cOyTEt0bC0FRdQlUXecYk/SqB+kNzn28j/RVLVRN5ShQj+cGAEthk9haNnMf9FdAHKodyofithuQZhKdLBl47lHmm3VlF4iYKmB+jq4Ih9itHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877409; c=relaxed/simple;
	bh=24EJxqCARFhgrtORlcBU85h3QFbWiqQTA5kKSZEbaRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJrNNJU3iKsEG7VWkct2Nio8LJiCdMxrmr9Elbq6ZzyS7D0qJFYkQIfXyWIukESfVNR3INQWcTr6AZPVomNFIb7i9qEdEfz0RWo9q94SH6K663nE2yhC079LfqfElAY+ZwkUVEKFKF9ftbJI7nvzU7McO0Vu88c/EK/T/nl1FPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbbBfMdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C83FC19421;
	Tue, 11 Nov 2025 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877409;
	bh=24EJxqCARFhgrtORlcBU85h3QFbWiqQTA5kKSZEbaRk=;
	h=From:To:Cc:Subject:Date:From;
	b=EbbBfMdTAlqwbJbgGXUcp+d8SSmmQBDdOvtn2CN67C0DqlyHlhQPK8PyiJFf0JylN
	 hdJ5CpEGDjIZDzH+Coqifh4UpSJcZlkPQ439M5YlTvaJeFufWFk7cFQJZM2JDTTx9u
	 qrOEDEGxb1UE9vpRrGl/6vrcM/EETqj+iJo3SC2HsesF0/5dBoyVhzvN83sapRFHsy
	 G78g/rXt5aHQuJA8A3MwPsFDUnNM7jValMtIEVGpgkzyzbSGFMsfa5TUjzbOtAa3se
	 1MlLJgQrWDYG9AMD2A5tZ64xA8Vtl8MJHkYOR5xuanZ99A+d7peAcHkagOMWIVmVYA
	 uGBb8awF1bd8Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: verifier: initialize imm in kfunc_tab in add_kfunc_call()
Date: Tue, 11 Nov 2025 16:09:47 +0000
Message-ID: <20251111160949.45623-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata about a kfunc call is added to the kfunc_tab in
add_kfunc_call() but the call instruction itself could get removed by
opt_remove_dead_code() later if it is not reachable.

If the call instruction is removed, specialize_kfunc() is never called
for it and the desc->imm in the kfunc_tab is never initialized for this
kfunc call. In this case, sort_kfunc_descs_by_imm_off(env->prog); in
do_misc_fixups() doesn't sort the table correctly.
This is a problem from s390 as its JIT uses this table to find the
addresses for kfuncs, and if this table is not sorted properly, JIT can
fail to find addresses for valid kfunc calls.

This was exposed by:

commit d869d56ca848 ("bpf: verifier: refactor kfunc specialization")

as before this commit, desc->imm was initialised in add_kfunc_call().

Initialize desc->imm to func_id, it will be overwritten in
specialize_kfunc() if the instruction is not removed.

Fixes: d869d56ca848 ("bpf: verifier: refactor kfunc specialization")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---

This bug is not triggered by the CI currently, I am working on another
set for non-sleepbale arena allocations and as part of that I am adding
a new selftest that triggers this bug.

Selftest: https://github.com/kernel-patches/bpf/pull/10242/commits/1f681f022c6d685fd76695e5eafbe9d9ab4c0002
CI run: https://github.com/kernel-patches/bpf/actions/runs/19238699806/job/54996376908

---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1268fa075d4c..a667f761173c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3371,6 +3371,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
+	desc->imm = func_id;
 	desc->offset = offset;
 	desc->addr = addr;
 	desc->func_model = func_model;
-- 
2.47.3


