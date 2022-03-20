Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC4E1C09
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbiCTOba (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiCTOb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 10:31:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088813BF9B
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 07:30:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so4940839pjf.1
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhAWRMBpu3/jvPXwnaz4c07qZfPtdCkoRO8Efu+7FmY=;
        b=U4/aUhRefj/xDnTLEB3zLjjNxRbcZLvcEFj0vr1pXy+ZT5DdhSPDWJAAD3m+3q8SZ2
         EM//g+/UoM/S/CNZbEEHhMrHbWUBr/riP1/BTXLnjFiFMvjB+kj9k0eXVhOYp1QElCr7
         kwvk+8eCDLN7e2GMo6Ij0AkmBgVM9+X1zC4wR67SuixoiALg3eAaH6kSGRSIL2h/O8Qz
         tS5Kcut7yODlymWbW88eDRZjUCxEA/lvP6Nfwmy3hP9p7t3v/d6Zq3GOumyoblHpLx19
         6xbQNVg34ZjWW76nAwJS1ujkoRZwycajkrSiZIfdmub+01T4GhsJw7HnPD96s5qafE+Q
         jT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhAWRMBpu3/jvPXwnaz4c07qZfPtdCkoRO8Efu+7FmY=;
        b=y+iIA/jaM0UbrSoXkQKg8vmZ+C98rS0uyS/BTaRoLye5MLss/UYFjY2cRT8T1HrZKL
         MSRG1vRGAlcEJeZ3lCQshq7r54pw0MvZy+quZ6++kun9I7LvkSrlkwwGC4O4YjFBsQQo
         UhqwXBMP+rz78rb1G4HYpQ0i3u6yPrTzH7BMgQssse7yMF2shsB/4z48ohWA08mLRtAf
         2nKqskUytzHqFPGlrcp/zVVO1kGQCtTQEFfwO5XZqW4aeW10TXCQi6fBulCO0HLrErpC
         32OmiE+XN/idH4/Wz8fYP2tTjFaHj/lq0PPE3S1vFP1YfDHA4s2RoSjMzx9vPOuG8uPT
         ao+g==
X-Gm-Message-State: AOAM531bnfOKkEV5wyioPGWB66vcd5MD60qnxbXKVTq1VmCCW4h7i9Q9
        sanTXOJA53wUPjlSx5Uxvz9InzGoYls=
X-Google-Smtp-Source: ABdhPJy97mvh7GeSQpiRGyL34tGTFoGXY2ljmPR5eHt1IN4MEDgIh/EODU+d7j8+DrcDTm/QnsIIRg==
X-Received: by 2002:a17:90b:3a92:b0:1c6:64a5:a403 with SMTP id om18-20020a17090b3a9200b001c664a5a403mr23485473pjb.89.1647786605374;
        Sun, 20 Mar 2022 07:30:05 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm12124833pga.58.2022.03.20.07.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 07:30:05 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>
Subject: [PATCH bpf-next] bpf: Check for NULL return from bpf_get_btf_vmlinux
Date:   Sun, 20 Mar 2022 20:00:03 +0530
Message-Id: <20220320143003.589540-1-memxor@gmail.com>
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

When CONFIG_DEBUG_INFO_BTF is disabled, bpf_get_btf_vmlinux can return a
NULL pointer. Check for it in btf_get_module_btf to prevent a NULL pointer
dereference.

While kernel test robot only complained about this specific case, let's
also check for NULL in other call sites of bpf_get_btf_vmlinux.

Fixes: 9492450fd287 ("bpf: Always raise reference in btf_get_module_btf")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c          | 6 +++++-
 net/core/bpf_sk_storage.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6d9e711cb5d4..ce212bf39b2b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -534,6 +534,8 @@ static s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p)
 	btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(btf))
 		return PTR_ERR(btf);
+	if (!btf)
+		return -EINVAL;

 	ret = btf_find_by_name_kind(btf, name, kind);
 	/* ret is never zero, since btf_find_by_name_kind returns
@@ -6584,7 +6586,7 @@ static struct btf *btf_get_module_btf(const struct module *module)

 	if (!module) {
 		btf = bpf_get_btf_vmlinux();
-		if (!IS_ERR(btf))
+		if (!IS_ERR_OR_NULL(btf))
 			btf_get(btf);
 		return btf;
 	}
@@ -7180,6 +7182,8 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	main_btf = bpf_get_btf_vmlinux();
 	if (IS_ERR(main_btf))
 		return ERR_CAST(main_btf);
+	if (!main_btf)
+		return ERR_PTR(-EINVAL);

 	local_type = btf_type_by_id(local_btf, local_type_id);
 	if (!local_type)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d9c37fd10809..7520e98a02bf 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -405,6 +405,8 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 		btf_vmlinux = bpf_get_btf_vmlinux();
+		if (IS_ERR_OR_NULL(btf_vmlinux))
+			return false;
 		btf_id = prog->aux->attach_btf_id;
 		t = btf_type_by_id(btf_vmlinux, btf_id);
 		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
--
2.35.1

