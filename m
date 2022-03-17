Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F44DC55B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiCQMBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiCQMBp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6C17ADB0
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g19so6602369pfc.9
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Efb60oibuvoJjF/8pYhSd3D7llc1Mb0g4z9xUiz114=;
        b=UKlGskYXO+bl62ha6z+ZlSfLhRryKVsjRYTjsRnUxDiVdyisPNaSlFVyYdv/isgRWg
         D34Jp7CxQOwDLDy4y4idrACwU1jsMgxXF1Ri9ugXayijjYdz8MniYsI5yig+Vknhszmh
         WPrVng/IAWiWevRbsL5dvZCYDH94Nks7FIfowrpbN2Pc8nHQAjtbJjsQhTg/JWjjKi7m
         pQ68UcAIhGM8pV5adx+i94uMQaUAptMssYBP6AYe8wVGPRcdJOzOfYoX5VOE8XC7pg01
         Jr60+nkr7YQcD7HWCZPi7oJS+2YGADTZ+j9RYv/MBX9V0HaBmNv1GIG5HYQhA/HPUkIq
         Bz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Efb60oibuvoJjF/8pYhSd3D7llc1Mb0g4z9xUiz114=;
        b=FlZPem74YZ0i7wGLI29s0fJW+6KDFsH312m1WmzGaiff2nKjG41IBtJeWhJRh8IZS/
         XORh42hHKFe6y+EafgAKpxvOxLI5e1OgzQN52AzwANkCo9YwYUrbiM8bJxApkF1Tc/Mg
         iT0qQ58syEyc6zDxkG3DId7OIRNN5haisnlA9YDKEm6ITvc/nNF6JxcDBWsv7EC4aXOZ
         T8mhsUPUjpECUPrXSjAfs3nE5iVr6aZqgunoxppActh9I0BKAOfAhXlKu7n5+70M1etw
         v47bKNW7B33TkGGFcB1QetMOmwb99MoprI+LwU0laGbBNStugAYiAjyhDyfZ3WALyeAm
         HSQA==
X-Gm-Message-State: AOAM531JbcSQJ64GPmbfZAhsLT90q6sk/1zt+0+V6Psq3JG/37M7Fm6B
        MV8RbO+vdQ4PskQLphA/2ZNt6SZGO5g=
X-Google-Smtp-Source: ABdhPJyiWchIIrxtB2KCZcSYHOjax5M+sReWRm5r6D4mT8MbttfQAuPGP2UNm51kwQr+PYlCZLp3pQ==
X-Received: by 2002:a63:ea48:0:b0:378:af1f:53b4 with SMTP id l8-20020a63ea48000000b00378af1f53b4mr3404524pgk.508.1647518428319;
        Thu, 17 Mar 2022 05:00:28 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id f22-20020a056a0022d600b004f7a0b47b0dsm7481381pfj.109.2022.03.17.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 06/15] bpf: Allow storing user kptr in map
Date:   Thu, 17 Mar 2022 17:29:48 +0530
Message-Id: <20220317115957.3193097-7-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4884; h=from:subject; bh=l8KJ7vvazrS1sXDJl/B8MeicCvCPQRUV4vatJ0t4rNw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjjL9dRoQr6zWP8/ETPU+JH5x9l5QyW6XzDoiV XDdq1BSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RyrhAD/ 0SosNndYTJC2IiHRqhCQTr/Ue17KUCffMXMI0e8DFtRDcqMNItEOiQXaU0lNIwfRyNIl9U/RYJGfKT n5l95gfSzy+eSWB6ENtm6CIS9e1mktTum4IQetn1mvwF3PuhL0GdhzroPygj0LPQrV+lTjtphTxkbN Afk6gDEgxr2OvIERyIqz+qRJ//5oOOzh7K7g9P5271lqXSpAaVq3cJDuVL9gD1AXewcdNQtQurVEBL xsj5kY+5xL7j2IrDE38d55SJtv5E5NL/hrBqSOFTEKyPdlM4b3n9SvOqV3mpttK3QGQjtJMl5u8oXc it5qx8/WBEPLWLJq7KW3vt4B2Ir3kmQA4IYxPVxyZEgoag30Gi9u0wCiZ2wcv6mVnmvzFOaLte98Zx xY/4PTmuBwPPmh7iscHE3dQYYDgfquG2sDs3GfkIT9K4wHmlgTQnxKXdj0WlHR5wWzcS9rBb5eCBR9 rxHcMtFXhgnmhHNNmujP/QGd5ECi6KVuIjkJ9adrihfm2ZXaZoTuLkDgFFdXLeYzKCNDjCic/SnsQX qVaHHi54vgVfLj4V7x4At9P4SD5MWKpm+i7j3zlgv2wkvzh0GBZAKLOeP1CqNhZTXN4MFbi96Y6hqD 9R3tNDMXFJX75iAkfv3PQL7wJg71pFymTfRtIhrez+4VCMcFZgl8cpBd9OHQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently, verifier gained __user annotation support [0] where it
prevents BPF program from normally derefering user memory pointer in the
kernel, and instead requires use of bpf_probe_read_user. We can allow
the user to also store these pointers in BPF maps, with the logic that
whenever user loads it from the BPF map, it gets marked as MEM_USER. The
tag 'kptr_user' is used to tag such pointers.

  [0]: https://lore.kernel.org/bpf/20220127154555.650886-1-yhs@fb.com

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/btf.c      | 13 ++++++++++---
 kernel/bpf/verifier.c | 15 ++++++++++++---
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 433f5cb161cf..989f47334215 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -163,6 +163,7 @@ enum {
 enum {
 	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
 	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
+	BPF_MAP_VALUE_OFF_F_USER   = (1U << 2),
 };
 
 struct bpf_map_value_off_desc {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 04d604931f59..12a89e55e77b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3197,7 +3197,7 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			       u32 off, int sz, struct btf_field_info *info,
 			       int info_cnt, int idx)
 {
-	bool kptr_tag = false, kptr_ref_tag = false, kptr_percpu_tag = false;
+	bool kptr_tag = false, kptr_ref_tag = false, kptr_percpu_tag = false, kptr_user_tag = false;
 	int tags;
 
 	/* For PTR, sz is always == 8 */
@@ -3221,12 +3221,17 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 			if (kptr_percpu_tag)
 				return -EEXIST;
 			kptr_percpu_tag = true;
+		} else if (!strcmp("kptr_user", __btf_name_by_offset(btf, t->name_off))) {
+			/* repeated tag */
+			if (kptr_user_tag)
+				return -EEXIST;
+			kptr_user_tag = true;
 		}
 		/* Look for next tag */
 		t = btf_type_by_id(btf, t->type);
 	}
 
-	tags = kptr_tag + kptr_ref_tag + kptr_percpu_tag;
+	tags = kptr_tag + kptr_ref_tag + kptr_percpu_tag + kptr_user_tag;
 	if (!tags)
 		return BTF_FIELD_IGNORE;
 	else if (tags > 1)
@@ -3241,7 +3246,9 @@ static int btf_find_field_kptr(const struct btf *btf, const struct btf_type *t,
 
 	if (idx >= info_cnt)
 		return -E2BIG;
-	if (kptr_percpu_tag)
+	if (kptr_user_tag)
+		info[idx].flags = BPF_MAP_VALUE_OFF_F_USER;
+	else if (kptr_percpu_tag)
 		info[idx].flags = BPF_MAP_VALUE_OFF_F_PERCPU;
 	else if (kptr_ref_tag)
 		info[idx].flags = BPF_MAP_VALUE_OFF_F_REF;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cc8f7250e43e..5325cc37797a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3521,7 +3521,11 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 	const char *reg_name = "";
 	bool fixed_off_ok = true;
 
-	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU) {
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_USER) {
+		if (reg->type != (PTR_TO_BTF_ID | MEM_USER) &&
+		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_USER))
+			goto bad_type;
+	} else if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU) {
 		if (reg->type != (PTR_TO_BTF_ID | MEM_PERCPU) &&
 		    reg->type != (PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_PERCPU))
 			goto bad_type;
@@ -3565,7 +3569,9 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 		goto bad_type;
 	return 0;
 bad_type:
-	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU)
+	if (off_desc->flags & BPF_MAP_VALUE_OFF_F_USER)
+		reg_type = PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_USER;
+	else if (off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU)
 		reg_type = PTR_TO_BTF_ID | PTR_MAYBE_NULL | MEM_PERCPU;
 	else
 		reg_type = PTR_TO_BTF_ID | PTR_MAYBE_NULL;
@@ -3583,9 +3589,9 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 				 enum bpf_access_type t, int insn_idx)
 {
 	struct bpf_reg_state *reg = reg_state(env, regno), *val_reg;
+	bool ref_ptr = false, percpu_ptr = false, user_ptr = false;
 	struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
 	enum bpf_type_flag reg_flags = PTR_MAYBE_NULL;
-	bool ref_ptr = false, percpu_ptr = false;
 	struct bpf_map_value_off_desc *off_desc;
 	int insn_class = BPF_CLASS(insn->code);
 	struct bpf_map *map = reg->map_ptr;
@@ -3615,8 +3621,11 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 
 	ref_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_REF;
 	percpu_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_PERCPU;
+	user_ptr = off_desc->flags & BPF_MAP_VALUE_OFF_F_USER;
 	if (percpu_ptr)
 		reg_flags |= MEM_PERCPU;
+	else if (user_ptr)
+		reg_flags |= MEM_USER;
 
 	if (insn_class == BPF_LDX) {
 		if (WARN_ON_ONCE(value_regno < 0))
-- 
2.35.1

