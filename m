Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29E12F3469
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404719AbhALPoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404644AbhALPoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:03 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA2C0617A9
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:51 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id w204so640155wmb.1
        for <bpf@vger.kernel.org>; Tue, 12 Jan 2021 07:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=k9pbdDmCq+Kt2qJMctj6Pr05hMu+91sEgpkcVDGx9/A=;
        b=RjUMTBVUN4Fgn/2wl75pan+QYPDIsOGv5ef2bH0pTtXNXm5egoOUGlXOcNoKyx+3kT
         ybZWT/pCmNJZXKb5Aw6N0dN1E2uEKGnn4Ur0PBnzYQFXNmHirs08ZYX2LDQmlvkAaSgb
         6zH+ZGDheL3UTPVFiqYML1fKOIRYETReDi7FfSSjP0PxeUbvKB7K5Q3qnA5nmmVE3BhY
         D4CBzuXRtwnqBtzIojgAeuB6WZZTGdK/o+hAbiFF0lS3L2prMBUCsvgogNV/CedUxVzj
         Dq7HAUBSGPR5lJGFeYr/pEOPxPpakOi+WlDDNfmOCmBSmTpYtqDRjgokFClGIabgBqe9
         uD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k9pbdDmCq+Kt2qJMctj6Pr05hMu+91sEgpkcVDGx9/A=;
        b=a1YZYcNjRKDHbOVMm/OWvFPc6BngC+40sSb/wAaeNaKQOU3pjCLMYfFp5oZh7RMN3r
         MAPSKw6BK/yMqYuSGp6kngmAJhxBZltEMkwiIyJM9SmnY6AaKxKGG5SNSCbmqW5EnyMw
         lIzIWFdMMq+CMsb1qMAcL1VgMxx4oJq8WHNiqbXz22CqlS4G1LdUEwQngbPgzRyGK1Uf
         lEZSc/54kN1isCji7oYKBsHNuDSsQcG3+lxEGfuhaUe8yREEvai9n8X/YDsaY3nr0JW4
         SCYUC6Ht15rn8PI7cVXkKKKaz5gSlzmCkd5EXVbvI7lw04DVlkSvXwNR5q1X6SG9baE3
         NH1w==
X-Gm-Message-State: AOAM532kPAnfx2RBzMdDFAKnwBnHdgMIS9aBECRdbsFzDE47T7PomJHE
        q+CiIddiqLMDMBB+BlfKlm69XOV5omDKlJe81EJD60+lr+Dd1qZKZ/hcD1pKrE6a76TbpMhsnYa
        Sy5XNtWBrzVO1REGc4DuqiZh+oX87PUlLY0cxMxd+AzzAPmcbrf4oPP5b8A4tVD0=
X-Google-Smtp-Source: ABdhPJzexS3m2Vgf6iamTgmdZIBlljh8LFBWcCgn3fXVpKmwkX4Nit9qmXowlxE2Sncfiih0XL6ZgsQqr8T9vw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:bd43:: with SMTP id
 n64mr4179187wmf.169.1610466169857; Tue, 12 Jan 2021 07:42:49 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:29 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-6-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 05/11] bpf: Move BPF_STX reserved field check into
 BPF_STX verifier code
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I can't find a reason why this code is in resolve_pseudo_ldimm64;
since I'll be modifying it in a subsequent commit, tidy it up.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d562268c1fd1..48e398667a69 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9528,6 +9528,12 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -9940,13 +9946,6 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
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
2.30.0.284.gd98b1dd5eaa7-goog

