Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF304B9231
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 21:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiBPUUA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 15:20:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiBPUT7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 15:19:59 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3291280EF8
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:19:46 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso3484886pjg.0
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 12:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oEKhu3AVMTjlWK6nVq9+oGoLMqA4v6iKEqxnr5V0r/Q=;
        b=q1bRG898u+gnb4ZNOSWNurfQ5AFUoaHeLEsNWBUEXfLMhxa4TsiGwhqw3roGogQvKf
         oSOo8jp5DAwixWuvUgiyapvb3WfoaZKN6iH70hK5g9SE65yOy9BltgaggM9UNfoBv/JK
         ekQVGnqIICjr3QTlhDR1TB11P337OUYihgsRqQfjklCqYAinS/PEUFkSKrfBnK/TYUvO
         ioVNu0MV4P/rJE7i96lYznb0ERMi0PN5rOZKxtUjtDNIWNkvET3EJHBncMQGnDCRcSt+
         6Rk4yzHCIo+UT4H3D/SyddyayvRSipd8nphLAqmIUNLQvUDl9XR1JifDyxpAXCdeG28t
         LXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oEKhu3AVMTjlWK6nVq9+oGoLMqA4v6iKEqxnr5V0r/Q=;
        b=1EINKklLArZa6QY5O93/CA462Dby9Ouh3DYxk6r5+SOPsRBF7a+1FNC3Wpap6OGvyi
         qEiFXN7jdkrafFSG4sT8D3/TIKuBlU6+1Ldiq3Iz4Eag3s/cL7riwyvPKwyowOHD3FBD
         YHgLI5npSdUuiR6lXju8aTM40KOMdwtcbWW0JvIeSiQBY9Pzzd91K5nHEwe8AFdxZQ2c
         mh1jB5YU/fZNFSXt8SGcfstUEIVtHO1w7eeOA6+/FetwKnpSaf+sCJ/xKp70SJjJtEje
         xTI0T7OlUhZeF190lIkg3c3NPXcNRvn++Dmr4Cemdx5Mgy+YeGeLZtaNRFSsUQ+EXJpn
         LpVQ==
X-Gm-Message-State: AOAM530/o9/he1p2wdWgzdpu4w/WsKGM/m9LQADvCDlZ29sK9ZkTR0kD
        TTO+hTyuaINlHqLaBLO7bR5gzJzlQX4=
X-Google-Smtp-Source: ABdhPJxPEUbpb51ygnBz7+Nbw8M5P2igXvLr0T4BHGDo0ixbkLeyVTJAfD6lSD1sjYbAZeBFCUoCBQ==
X-Received: by 2002:a17:90a:1548:b0:1b9:d1b7:bb1a with SMTP id y8-20020a17090a154800b001b9d1b7bb1amr3644153pja.125.1645042786150;
        Wed, 16 Feb 2022 12:19:46 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id l21sm45337187pfu.120.2022.02.16.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:19:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
Subject: [PATCH bpf v2] Fix crash due to OOB access when reg->type > __BPF_REG_TYPE_MAX
Date:   Thu, 17 Feb 2022 01:49:43 +0530
Message-Id: <20220216201943.624869-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
function") added kfunc support, it defined reg2btf_ids as a cheap way to
translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
member of bpf_reg_type enum to after the base register types, and
defined other variants using type flag composition. However, now, the
direct usage of reg->type to index into reg2btf_ids may no longer fall
into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
and kernel crash on dereference of bad pointer.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Hao Luo <haoluo@google.com>
Fixes: c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
--
v1 -> v2
 - Use base_type(reg->type) && !type_flag(reg->type) (Alexei)
---
 kernel/bpf/btf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e16dafeb2450..3e23b3fa79ff 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5688,7 +5688,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 			}
 			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
-		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
+		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
+			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
 			const struct btf_type *reg_ref_t;
 			const struct btf *reg_btf;
 			const char *reg_ref_tname;
@@ -5706,7 +5707,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				reg_ref_id = reg->btf_id;
 			} else {
 				reg_btf = btf_vmlinux;
-				reg_ref_id = *reg2btf_ids[reg->type];
+				reg_ref_id = *reg2btf_ids[base_type(reg->type)];
 			}

 			reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id,
--
2.35.1

