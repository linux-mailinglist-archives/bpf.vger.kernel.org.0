Return-Path: <bpf+bounces-522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BD5702E6B
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933F228127C
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D1FC8FA;
	Mon, 15 May 2023 13:38:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D66C8F5
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09335C433EF;
	Mon, 15 May 2023 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684157891;
	bh=HATxZ6JbnsWoKrhS8LgbQ5Ekt4VMh6B46VchWswvVas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a5iVmWiOH8mf+Yh9Z4kFtCnqRbyYYnqONpSm45SOKTIZiV76KBsSReErRZLCy1lps
	 KyAG99PbmyPMsmil9j+QZioO6ad8zREgZ/2bcXAK+y/zBGfOGBC+QtFM8aTFBIOQmE
	 OMgz6J8pfU6Q6CVB8yQg6peAzlkG9u6J6ZeDyohG5Bgc/kbOhISUzFLimZ4EY5w/B1
	 eUWGS8CdtkBbZg3/1fOvAT4Mfeg8jTlVWgxJ+I9yR365qotkF0gvKgMY5Ze/GUINfy
	 IAKC1/g4l4U/JgM4spoNoXV4uhhqq7U86XmIYvNUM9XO4XFVyzS1i6GFtMaBcxv9dR
	 8lUek9nCaA2KQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	David Vernet <void@manifault.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCHv4 bpf-next 01/10] libbpf: Store zero fd to fd_array for loader kfunc relocation
Date: Mon, 15 May 2023 15:37:47 +0200
Message-Id: <20230515133756.1658301-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515133756.1658301-1-jolsa@kernel.org>
References: <20230515133756.1658301-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When moving some of the test kfuncs to bpf_testmod I hit an issue
when some of the kfuncs that object uses are in module and some
in vmlinux.

The problem is that both vmlinux and module kfuncs get allocated
btf_fd_idx index into fd_array, but we store to it the BTF fd value
only for module's kfunc, not vmlinux's one because (it's zero).

Then after the program is loaded we check if fd_array[btf_fd_idx] != 0
and close the fd.

When the object has kfuncs from both vmlinux and module, the fd from
fd_array[btf_fd_idx] from previous load will be stored in there for
vmlinux's kfunc, so we close unrelated fd (of the program we just
loaded in my case).

Fixing this by storing zero to fd_array[btf_fd_idx] for vmlinux
kfuncs, so the we won't close stale fd.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 83e8e3bfd8ff..cf3323fd47b8 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -703,17 +703,17 @@ static void emit_relo_kfunc_btf(struct bpf_gen *gen, struct ksym_relo_desc *relo
 	/* obtain fd in BPF_REG_9 */
 	emit(gen, BPF_MOV64_REG(BPF_REG_9, BPF_REG_7));
 	emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_9, 32));
-	/* jump to fd_array store if fd denotes module BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
-	/* set the default value for off */
-	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
-	/* skip BTF fd store for vmlinux BTF */
-	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 4));
 	/* load fd_array slot pointer */
 	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
 					 0, 0, 0, blob_fd_array_off(gen, btf_fd_idx)));
-	/* store BTF fd in slot */
+	/* store BTF fd in slot, 0 for vmlinux */
 	emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_9, 0));
+	/* jump to insn[insn_idx].off store if fd denotes module BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_9, 0, 2));
+	/* set the default value for off */
+	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), 0));
+	/* skip BTF fd store for vmlinux BTF */
+	emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, 1));
 	/* store index into insn[insn_idx].off */
 	emit(gen, BPF_ST_MEM(BPF_H, BPF_REG_8, offsetof(struct bpf_insn, off), btf_fd_idx));
 log:
-- 
2.40.1


