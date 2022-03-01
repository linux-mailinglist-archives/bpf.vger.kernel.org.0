Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A44C846B
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 07:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiCAG6j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 01:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAG6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 01:58:37 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB8583A6
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:57 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id bx9-20020a17090af48900b001bc64ee7d3cso1396527pjb.4
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 22:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rbwx3/JEMvdONZQptpxfsn4bSP4z5IpfDsabDdj1tuo=;
        b=hJlEVGTi5+vqrkoCeHJJ5iRRExtZhP/wzjoKlJY+MX4Sy/PvI0fsLJR2EOZzGCXvw9
         7XegpALx6vfu2OL0HXCX5okCxFt09igxgQbLIr7UwhlJEqkiCYA0zrRqxu6dziNeKUTy
         6VU5nlzzZjizM9j0xXs8MzM+Eaa6uV2M4QHyWQrkmMImkRJbWsOjfOCO/I2e4/0cB/bV
         F/GdM8LJ/0GUVDAuw4SCMT0aYmPLg2aC4OMO9eHSxZKll2LONPOh28QhLDDS/UxFbFHt
         DrNNsfcRohFc4sBDUfcEdgEntyrzy4OMYyBkmg7LeADNBzAlXf4lTwTFWwOGi+Cfd0La
         fnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rbwx3/JEMvdONZQptpxfsn4bSP4z5IpfDsabDdj1tuo=;
        b=YPXSuVO5CcXh8w7RUDoWreK05bgjByvFK02+tc1hoIveh8pzv+S08n0ccUvwm44wNE
         nUEHefvvKM4mh6JXddMaZJDFC7FkAwTI53uT0trbdRRY3lpiFpX/Dx7kv7ie5XVOMCSL
         Ebk+a7e2YIrmGzAUIpVvdziLW7LjQfGL6nqR+8E/VJpN+7WIdrWygEch/XqMkDok7hD6
         qavYaSpcGfNx/BX+P3OIJwMzEF7cZXDeJ7Jc8UCdVBdi43+z8A03aIbhc6a7NoRRnHzg
         E+4475M2v4sgECpZNPzb6rCGmwBUshed58Xa+QabKF3d1863rCevZBYZLiD0nUiW6m8c
         Uqsw==
X-Gm-Message-State: AOAM530jPlRd5kItSG78Xbnaz8gsci/WLEim0lFcyEzuB4DAjwzNOwO7
        u7jQXyWNrjfwi6zsvXsX2/UgZA1dArk=
X-Google-Smtp-Source: ABdhPJwt32BcurHJ4LxULO+cGBHUB5rKWK+Dfr7Bp3LSDfOCHgKdOPZRsxW8OympipdC+xB1PJnsQQ==
X-Received: by 2002:a17:90b:2345:b0:1bc:4273:b194 with SMTP id ms5-20020a17090b234500b001bc4273b194mr20557528pjb.108.1646117877137;
        Mon, 28 Feb 2022 22:57:57 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id g22-20020a056a0023d600b004c0ef29dd5bsm15923769pfc.107.2022.02.28.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 22:57:56 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 3/6] bpf: Disallow negative offset in check_ptr_off_reg
Date:   Tue,  1 Mar 2022 12:27:42 +0530
Message-Id: <20220301065745.1634848-4-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301065745.1634848-1-memxor@gmail.com>
References: <20220301065745.1634848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; h=from:subject; bh=Q+5QP2xA4rsFOFzpi3hfl1ictvaY4B5Kxcun3KItefE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiHcO1PZE7/2AeoWobBbH0uYDdbVe19+QluaUd/os8 a5YwfZyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYh3DtQAKCRBM4MiGSL8RymY4D/ oCg5XCyipX6TtJ63/VUbWFswcoAWqDOryR+2VSk1mKsJ7gIdHyM62ucpQmtu1IDWaWmvVDvAllE2PN 06vbLn84973FUAqjfA6leM5Zls2ET9nMJdlRs2rsmyL9dV8G5l7d39W1Z6XzcToL2loMMa02d5hEef YPt7AwV4btfBT2e9aTPYVC2+nllrFB545dffm0FNxdgInMcdpdllP7QI28xYvbLvDWF317dwCYJ90W txe/Rd/afkMcJTY8ljsagYgVTjQuoPeBoG8cgbb3pBRF/cyAM/VbSlJt5ULevlIXxzKPbaCW9s4NIq fLMMPajkKCZ5jeOVM2O3NwGWEUsaMdSA1ZGCLyCqSqlwZFuW5zwZm1K5twDSIeUyDzqFP8bOUany/x MOumnQaJVaTT8voYs3XUoa/3aVD6Ma1IZLhACZY4F0r1K2K8LW5co23hqFnpaiHip6JnfAp8qFVG9n u0qpDaoZxGYjjyu8LV9dYg4Iek4KdpdC+3MMpRHacDIOZUe7GXw8sr98SnGTDbpphOQyU67Oh+FL0O d84dk7IcmY8qZ+mjo+EkhekUA7HW9yd5fnRL9cRQeT2dQdYNnM2ITEs5cbN1G0T7ITBKjP4BuxW2sH bsQbQ1vGyvnaqG18bFvDBMVIcNJBbiVUjHfnjWdMahTkMwg9czz7NyDHBitQ==
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

check_ptr_off_reg only allows fixed offset to be set for PTR_TO_BTF_ID,
where reg->off < 0 doesn't make sense. This would shift the pointer
backwards, and fails later in btf_struct_ids_match or btf_struct_walk
due to out of bounds access (since offset is interpreted as unsigned).

Improve the verifier by rejecting this case by using a better error
message for BPF helpers and kfunc, by putting a check inside the
check_func_arg_reg_off function.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a641e61767b4..9f12a343bb6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3984,6 +3984,12 @@ static int __check_ptr_off_reg(struct bpf_verifier_env *env,
 	 * is only allowed in its original, unmodified form.
 	 */
 
+	if (reg->off < 0) {
+		verbose(env, "negative offset %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
+		return -EACCES;
+	}
+
 	if (!fixed_off_ok && reg->off) {
 		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
 			reg_type_str(env, reg->type), regno, reg->off);
-- 
2.35.1

