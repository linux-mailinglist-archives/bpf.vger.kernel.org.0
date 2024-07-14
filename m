Return-Path: <bpf+bounces-34760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8FA930924
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FC2280EE1
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A2139D04;
	Sun, 14 Jul 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLEI08GH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924151CA81;
	Sun, 14 Jul 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720945773; cv=none; b=ktHZoUHQ44JqC/b1JbYDsKD0bO+NW1l0WlBxzAgjDt56r1nFjfP5QFYQX4K/DgOYU9gqc9GrrHmkyALP19XSj8c7q8ZlnSSwZHxu9XGjRJghRY5Do0F6v6KVxC4DmNJhQBpQ7RJ7DuWorwX+wTlirhCkRS/l4kEKoMt80a6dQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720945773; c=relaxed/simple;
	bh=47kbk80bp7tXVEEQCet5lJPGJOYNcBOP1uYRsf338lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9gln89uKsAm0f2s/Hu8KZbn3t/ImCLdaQQXoiQSDI5rfMV5IpNqCdSILoeDiklPBebfQO90By7Qn12npBvN7V4lS89ZaOCAxo9tylnmZc6bATLHP3+Hgz3Ehd9/iqDK+CPF5gCieEHQe7LBw7RBReS1zFmYA5x0sHNBPGyYLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLEI08GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D9C116B1;
	Sun, 14 Jul 2024 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720945773;
	bh=47kbk80bp7tXVEEQCet5lJPGJOYNcBOP1uYRsf338lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLEI08GHjvSjYoDfNMhXk7LjgkS2AY5hdtYIJbTep3tzlvGho2fIxhi/UziKHrJPz
	 H1SRL6HyO/CETYQ2biAhcBtBrnHZ8KylbqpxgTzv+H+s1diMxqhHJ2av8xHOAF/0KI
	 b4KEYYWTPouAgI+dhvn64hl3W/wp+3goKe6eeGltft4XoX/dVR0et2cbbITz435J7D
	 8Q36P/o5w7apuTfdp3vlO7gCb+HxRTHKG460QfZjtG8l5lLgOkVrWhrghLJDx+odQ0
	 p/1jfEAjhcNvHd2DJ12INIm2b3KKfKsx6rzCe+LrMeHqzuLvJ8Au+HTiaabomqAq+f
	 RMNOzjMpGHvmQ==
From: Naveen N Rao <naveen@kernel.org>
To: <linuxppc-dev@lists.ozlabs.org>,
	<linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>,
	linux-kbuild@vger.kernel.org,
	<linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC PATCH v4 03/17] powerpc64/ftrace: Nop out additional 'std' instruction emitted by gcc v5.x
Date: Sun, 14 Jul 2024 13:57:39 +0530
Message-ID: <a526892b715b5f93db0ea2807c67fc8026fade74.1720942106.git.naveen@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720942106.git.naveen@kernel.org>
References: <cover.1720942106.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gcc v5.x emits a 3-instruction sequence for -mprofile-kernel:
	mflr	r0
	std	r0, 16(r1)
	bl	_mcount

Gcc v6.x moved to a simpler 2-instruction sequence by removing the 'std'
instruction. The store saved the return address in the LR save area in
the caller stack frame for stack unwinding. However, with dynamic
ftrace, we no longer have a call to _mcount on kernel boot when ftrace
is not enabled. When ftrace is enabled, that store is performed within
ftrace_caller(). As such, the additional 'std' instruction is redundant.
Nop it out on kernel boot.

With this change, we now use the same 2-instruction profiling sequence
with both -mprofile-kernel, as well as -fpatchable-function-entry on
64-bit powerpc.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index d8d6b4fd9a14..2ef504700e8d 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -246,8 +246,12 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 		/* Expected sequence: 'mflr r0', ['std r0,16(r1)'], 'bl _mcount' */
 		ret = ftrace_read_inst(ip - 4, &old);
 		if (!ret && !ppc_inst_equal(old, ppc_inst(PPC_RAW_MFLR(_R0)))) {
+			/* Gcc v5.x emit the additional 'std' instruction, gcc v6.x don't */
 			ret = ftrace_validate_inst(ip - 8, ppc_inst(PPC_RAW_MFLR(_R0)));
-			ret |= ftrace_validate_inst(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)));
+			if (ret)
+				return ret;
+			ret = ftrace_modify_code(ip - 4, ppc_inst(PPC_RAW_STD(_R0, _R1, 16)),
+						 ppc_inst(PPC_RAW_NOP()));
 		}
 	} else {
 		return -EINVAL;
-- 
2.45.2


