Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096DC2C1201
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgKWRc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 12:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbgKWRc0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 12:32:26 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B6C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id l7so2775118qkl.16
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xl+fEOAiCuOt6S0ALRoJWOL0gi0KW015PG29XKNNzqM=;
        b=aU5zniRgRokbjz/8yEr78avLriv/+VYRQtoh+g/GQJ7mtVj67hP8GYjZq8u4qd8dh2
         0DWm9GRaF4qdMOaMGnqh/iZTi+9VrzXn29IIX3MUyT3/RZSQQRNNId+k8eDocY8Zb1hI
         J0AjAyD+LPK0U3O2i0MuN+mIC/BNbPf3j0um5thXMDqHqj1hl7CTZHqcbtQ3CfbqY6yR
         GVufAps8jHOfx04S3XsT8SPrwNjbzOOdwbnD7vyF9Brt3p0HI49Z+Z6PaS+h17MkXnG2
         UlpEGR+sxx7L6Mlkq5bRBFGgNIGEvMRQvyj9rTmtbmJfYReHYgvCLbjvf71rHv142j2u
         DGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xl+fEOAiCuOt6S0ALRoJWOL0gi0KW015PG29XKNNzqM=;
        b=DzRH8AI6KgjggY7NT9H9zpTGGXdVvoHcvju83l6QyiSzxt/2LnI0opjW0bjVa4aFw0
         qTSp2LeeAya77kDpbGJjEZm0xDMVKd//HcQwiqL6tUhkC3tKrbNoqc6vXlubYTyz8DKP
         hkBAKIYoKu4M+l/6lB0XIlBKMB4QJfHaJZLpG4xKkndtgWmrV3jOK5YPevU8AHnJyDyV
         sNM0xFpUSGjmEYCwMAb02MlrTR8v4is5PxCigscN6PBms+2uQuVYx+1Zv1aXAIf92kS8
         re5wOzX7FUW7JZ+eOBtgOF70xxUo+R0GZ2yq/NPE0CQbpgVFiPKLNvgE9nMpTLnuiL+f
         JpkQ==
X-Gm-Message-State: AOAM532yVM1TLMclcdS9N0yHpunTrJknTZEsFHrAeG/Ee/XipslopNYA
        Qx0jahcPk5G6s5ni31F9GsHs+2hlZEIWF0tI1k6Brtpm5YDSRAl2RqfI4daqfsP9QbfCsCGAhGX
        i011msI0PEU4UR/LFXWk5CY88KSsV83ym0bwPnUbFmuyRlIAY8K5RlrKE+Tg/4W0=
X-Google-Smtp-Source: ABdhPJxFB1lZT1+GF4Wf0E3sL4S7syuIVNmeGcwuCgaUwQLuMT27mMTDbIcyKAdb9MpLcoCf+pU+GZc0UlWJzQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:4a4:: with SMTP id
 w4mr336958qvz.61.1606152745401; Mon, 23 Nov 2020 09:32:25 -0800 (PST)
Date:   Mon, 23 Nov 2020 17:31:59 +0000
In-Reply-To: <20201123173202.1335708-1-jackmanb@google.com>
Message-Id: <20201123173202.1335708-5-jackmanb@google.com>
Mime-Version: 1.0
References: <20201123173202.1335708-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 4/7] bpf: Move BPF_STX reserved field check into BPF_STX
 verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06885e2501f8..609cc5e9571f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9490,6 +9490,12 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
+			if (((BPF_MODE(insn->code) != BPF_MEM &&
+			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9899,13 +9905,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (BPF_CLASS(insn->code) == BPF_STX &&
-		    ((BPF_MODE(insn->code) != BPF_MEM &&
-		      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-			verbose(env, "BPF_STX uses reserved fields\n");
-			return -EINVAL;
-		}
-
 		if (insn[0].code == (BPF_LD | BPF_IMM | BPF_DW)) {
 			struct bpf_insn_aux_data *aux;
 			struct bpf_map *map;
-- 
2.29.2.454.gaff20da3a2-goog

