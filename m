Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3AA31D7AE
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 11:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBQKqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 05:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBQKqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 05:46:44 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D65C061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 02:46:03 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id f140so10127339qke.0
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=78wKl4UmJaJIRfmRhvqwr37fPI4YEwDd0BJC7KD0Duo=;
        b=NW3ncGV7dVlWjQQt9hYOpBkeWGdgHnaxK59kSDS7U0Rqsl+ZqN6llmveIat1WYdNUh
         HaPn7EbFjbGX2v2Bli+BavfqAfqzVzmSMV3UuruiXFiazU73B+MIikIfBlLt6BMamucW
         cawj+yDRugnwegNvx3uoX7tecBX4mNdKh3qiJoLc3hrLMUvObe33DsYOSitwKVPHvcvZ
         VokbEtGLzw3fMVSStOqTyTE608oIHXWWNXWH/ePvHIqIvJA0ubPlSaMUfva12kyV4jTX
         IBTV3ylLxs684isxsh/DcPWMIMQTOdVQhyr8OQwTrUxI1l88u/R+PtLR9IT0O/Q7Q08Z
         0wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=78wKl4UmJaJIRfmRhvqwr37fPI4YEwDd0BJC7KD0Duo=;
        b=O6Nik0X8xrbqG2wsGvYCIxL7Od1SKsDKm1sfQlyWvSJd6Drm52QTE1T2DZE7zqxKZe
         nl8sltblbg4UeX0CaRL7Dqm4pXqvKp5HbxXeJnkWjFp9zESMCoShJKh0w5dnQmNthjrX
         2UUiI2usi36rOfoXQW5D2P1qcVrgwsToD2aMHfxWFM7cBlfp7CW9nl2QYqfdiaskrLcL
         ZiX1YEbOI6cTz4/pt9r4/e38ajl+sCV/QpTiTKa7nC3NznpdV3rPfSTUg0wugmUndptx
         aun23P3dhXyx/0A/mPDhiSNHTuTmd5EZGCkRRV23hxIQTNcZ8miUJVyd5yz33fklNiP3
         1zhQ==
X-Gm-Message-State: AOAM533d0MMuH3OWKsOEuFJo9KzOeM1XRWhrFHz20c+JrYGo4S0Y+aaY
        ZF5JaGpez8nFwQHEsIV1eXeKEwDvPXvJR20gjAaOzs3uIhaT+47fZYETzDO0d+CPXws3t4Kfyzy
        n4QwkhuVg66HUe1Dp6Ghg+qjMNNi9eJZzHBXfyVcryoQzPHcPXYv5oCUqE19ocUM=
X-Google-Smtp-Source: ABdhPJwMTzWWWfjRyV5/A/j8gFWIWngMKNBqgec539yTsMwF12rkuJrsc5waQjfQb3GQYLyXPhN9BCw/gE6vuA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:e80d:: with SMTP id
 y13mr23855708qvn.2.1613558762865; Wed, 17 Feb 2021 02:46:02 -0800 (PST)
Date:   Wed, 17 Feb 2021 10:45:09 +0000
Message-Id: <20210217104509.2423183-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] bpf: Rename fixup_bpf_calls and add some comments
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This function has become overloaded, it actually does lots of diverse
things in a single pass. Rename it to avoid confusion, and add some
concise commentary.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 16ba43352a5f..7a8905abf8a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5877,7 +5877,7 @@ static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
 	     aux->alu_limit != alu_limit))
 		return -EACCES;
 
-	/* Corresponding fixup done in fixup_bpf_calls(). */
+	/* Corresponding fixup done in do_misc_fixups(). */
 	aux->alu_state = alu_state;
 	aux->alu_limit = alu_limit;
 	return 0;
@@ -11531,12 +11531,10 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
-/* fixup insn->imm field of bpf_call instructions
- * and inline eligible helpers as explicit sequence of BPF instructions
- *
- * this function is called after eBPF program passed verification
+/* Do various post-verification rewrites in a single program pass.
+ * These rewrites simplify JIT and interpreter implementations.
  */
-static int fixup_bpf_calls(struct bpf_verifier_env *env)
+static int do_misc_fixups(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog = env->prog;
 	bool expect_blinding = bpf_jit_blinding_enabled(prog);
@@ -11551,6 +11549,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 	int i, ret, cnt, delta = 0;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		/* Make divide-by-zero exceptions impossible. */
 		if (insn->code == (BPF_ALU64 | BPF_MOD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_DIV | BPF_X) ||
 		    insn->code == (BPF_ALU | BPF_MOD | BPF_X) ||
@@ -11591,6 +11590,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 		if (BPF_CLASS(insn->code) == BPF_LD &&
 		    (BPF_MODE(insn->code) == BPF_ABS ||
 		     BPF_MODE(insn->code) == BPF_IND)) {
@@ -11610,6 +11610,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			continue;
 		}
 
+		/* Rewrite pointer arithmetic to mitigate speculation attacks. */
 		if (insn->code == (BPF_ALU64 | BPF_ADD | BPF_X) ||
 		    insn->code == (BPF_ALU64 | BPF_SUB | BPF_X)) {
 			const u8 code_add = BPF_ALU64 | BPF_ADD | BPF_X;
@@ -11831,6 +11832,7 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 			goto patch_call_imm;
 		}
 
+		/* Implement bpf_jiffies64 inline. */
 		if (prog->jit_requested && BITS_PER_LONG == 64 &&
 		    insn->imm == BPF_FUNC_jiffies64) {
 			struct bpf_insn ld_jiffies_addr[2] = {
@@ -12641,7 +12643,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
 		ret = convert_ctx_accesses(env);
 
 	if (ret == 0)
-		ret = fixup_bpf_calls(env);
+		ret = do_misc_fixups(env);
 
 	/* do 32-bit optimization after insn patching has done so those patched
 	 * insns could be handled correctly.

base-commit: 45159b27637b0fef6d5ddb86fc7c46b13c77960f
-- 
2.30.0.478.g8a0d178c01-goog

