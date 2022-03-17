Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D924DC55D
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiCQMCD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCQMCA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:02:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C16181B08
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w4so4224996ply.13
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtX5nO59c5uHTcLbVyw9F/2RJ3pB6ZvRNAKBjdRgnhc=;
        b=oeYZIE3Pg3auZzBHUW46nSdXiP+2CpeBCByCTfgZB2IY2MFeRiWGur47zPLeWqwhRV
         ry8ranorgAgWG1Y6fyEJSUgiGRGirlZoFRdF7brlyCYRFN1nG/DXI1pLHswLiqXg6vhr
         ILz70HGPXtGVSicHvd4cdnO5i86Wjqb+wCTwg/oyLrQmZ1ZdGh6dB+OWPP4Ti+Cx2EsS
         CCUZnct9hylWCxDOTFMgOiwGEbjjXLQB5wf152yGfzHcv8M+TTFaNFSA7DNQXXjAd6gH
         YUGrxv8c60WoUS1EbJsZcTgZ+PSBy+U7mSeAO3lg56DverEgjX5QAEcQ7UKj57enPrzS
         hChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtX5nO59c5uHTcLbVyw9F/2RJ3pB6ZvRNAKBjdRgnhc=;
        b=hLcYNchBg5tKZjL0XfASmMAOkxUwtK1wOKrUYn/0Tccm2e30bmn4ZE5KaP9MYrOIT6
         +/KiSWh4d+br3tKnCF9s3O09bGXduHzfBu7WUD39NVU9oKa7GWdUmI9JMtGnzDqvO0my
         3ar5Nyy3nVIAm8atwXW9oCka45ip4f6K5zBo+yNGzsWNH7V/kCiXDXJbjpJQ7/tztNCB
         OSIcQW0xvc/a5i5MnMXMXJOoXChadeYGhn5fpVBdI0nb74DrxRY8MfDTf8RPdf24Pprd
         zzjcnC6bYQPCh44FMch7w2xHg5a1RSxNilJo+soy2gpxea3s/Ae/0w4BePO9s+u/jrDn
         WnXA==
X-Gm-Message-State: AOAM532aj5zsVCTcU+QGJJmb4eDIon85UuSq59L+6Xt0qTeCVOH6QUzj
        rarPTOZIqTIXP1e0T7vv7/d8tyJ/3sc=
X-Google-Smtp-Source: ABdhPJxsxQw7i5Fxs9uBOEaefoHS6G3XPLrk8Ko/iA+Ws4fFtrChpxVz+YoOel9RoRUkkRJYrVA/OA==
X-Received: by 2002:a17:902:dac5:b0:153:9104:5a28 with SMTP id q5-20020a170902dac500b0015391045a28mr4328845plx.9.1647518441892;
        Thu, 17 Mar 2022 05:00:41 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id d10-20020a63360a000000b0037947abe4bbsm5468488pga.34.2022.03.17.05.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:41 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 09/15] bpf: Always raise reference in btf_get_module_btf
Date:   Thu, 17 Mar 2022 17:29:51 +0530
Message-Id: <20220317115957.3193097-10-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317115957.3193097-1-memxor@gmail.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1862; h=from:subject; bh=bTE3Yy6pETmESB3x8nzqVjmhhlCvNQAzS5FMHklapBU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKjIMHA73kJ0YHPXVtQCUDV+WxkNmW355vyTHWU Dl9LcqeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiowAKCRBM4MiGSL8RyjicD/ 9rjkjO0bBFJJEIYGkjbeLI/slIeaWL2z+dX0LTEi61oRX0n96/4IEWiYPSbGJ4ZVBXQbmiNEWZ1z6W tUB9Sdrqgn0A7+76zmJptXRbXMjdWeQCZWPjrY/EoMGn/imXLWWyTHrg/zGQw6oWmC2wGhpPqT4Zzb HjKKFVnc3qBpR1KRhvun63+i+BuMF9hzqGkjrfJ0J/p/0Zgtqv1ADa6nX5tXCpWLVz12xuOL7a2u7r 4oAgoPLfz8ytFVtSnT/AiCncPcvUxEf/cTNVm6kwHZ6/ejPUD18iMpGyO10Qf2VHS6EEaIUh58AGbF 0ij17NA8iNuKsXynurxvoDK2NfUr9uvJb2Mo3ikvFHd2WiBzibf2PtRa7LyUq3PXJ8zoJMWg34lknR P8GKAEqAwYroiTgXyiF46utN3LTc7jGf0UKMBu5d6+wqzQZMcE4SFkk+W995+wiKfGm4yKbtoXIpF5 1ssoiGhgVpoI7dKpK9w2v+NhTROBgdxY5h1vB16IrtwTvjzIjvWiL0f14NYXTPNpboClcSVGs0Clbl pDk/Mt72ESgOJg6GZuSrCP+aUNsCo3RAR7IjspJ8Tx9bF5HNQ0nSe9+VLv6m+pE029kqtSX6H5LgXt a+SOyvI4e2lNrt5tvsH5eTMKh4e/qWUX2OQvRN+5NXqkQGk3JxfmLfwfjYQw==
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

Align it with helpers like bpf_find_btf_id, so all functions returning
BTF in out parameter follow the same rule of raising reference
consistently, regardless of module or vmlinux BTF.

Adjust existing callers to handle the change accordinly.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 12a89e55e77b..2e51b391b684 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6767,20 +6767,23 @@ struct module *btf_try_get_module(const struct btf *btf)
 	return res;
 }
 
-/* Returns struct btf corresponding to the struct module
- *
- * This function can return NULL or ERR_PTR. Note that caller must
- * release reference for struct btf iff btf_is_module is true.
+/* Returns struct btf corresponding to the struct module.
+ * This function can return NULL or ERR_PTR.
  */
 static struct btf *btf_get_module_btf(const struct module *module)
 {
-	struct btf *btf = NULL;
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;
 #endif
+	struct btf *btf = NULL;
+
+	if (!module) {
+		btf = bpf_get_btf_vmlinux();
+		if (!IS_ERR(btf))
+			btf_get(btf);
+		return btf;
+	}
 
-	if (!module)
-		return bpf_get_btf_vmlinux();
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	mutex_lock(&btf_module_mutex);
 	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
@@ -7018,9 +7021,7 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 
 	hook = bpf_prog_type_to_kfunc_hook(prog_type);
 	ret = btf_populate_kfunc_set(btf, hook, kset);
-	/* reference is only taken for module BTF */
-	if (btf_is_module(btf))
-		btf_put(btf);
+	btf_put(btf);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
-- 
2.35.1

