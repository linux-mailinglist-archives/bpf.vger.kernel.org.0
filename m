Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2228356584B
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 16:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiGDOJC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiGDOJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 10:09:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC816321
        for <bpf@vger.kernel.org>; Mon,  4 Jul 2022 07:08:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so3567268pjn.0
        for <bpf@vger.kernel.org>; Mon, 04 Jul 2022 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACfoXSj1CfToA6OoRzL6FcX7n2xKgaruEGnzou6JEgM=;
        b=ckaWGo+R5M3jr3kYjSOwIDza/g6Tu8GFSfwCNPIe7zy70j0/aEpbNA+0yxE+Bt7Zna
         3vNCmJu78PSD7yirkbNTKexGJaVpuaM6neIJF7YcFX6qPoA5HNEuVMlz4oNi5h9gHgNK
         HuWSN5e7xKoNaGTVmhK1AIWOvFOCB4jotafP1/XbMcHyyecxm8PUDTGYpCuvoZdKtKHs
         XGEiDH48z3JULy1HguYEADDwmY71r62QlKuKWrDniPT7VMm4NIqy8B6b5KMdvxphwOCG
         iCguSS4qAYQUFtbHtAFPgk6xG2zpOqAqeSW+bAVzq20J1xRq6sjsxnGnRKb00AFJ5+ZA
         tMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACfoXSj1CfToA6OoRzL6FcX7n2xKgaruEGnzou6JEgM=;
        b=d+cL06RgxAxDMJyHX3qLMVXVLHjcj0O0NvLBNlFRbdUvJqX2Gk59pICGq7G9VDZr1U
         iIM+zk+8oYiDTvLCUjeQqoY/bziV2grvMvgH/yBLsLnk1HyGTxiomeZNxxFSgdNQSLl/
         BubIeJ0RnCzS3olMSAugDhVTtG1GzNlIOF63S6LIdoebhXTKUay6M+j6pe2zUiU+39LD
         FGdZTBWS4JyQXhUDAiVssuyQb18dNbbKmJa3KYEx/ZZ2VF5BGHBOLCCaNCgIl7/oR6nh
         Y/UxJh79DUtZO2Yif3IxGRgVEOmgW0awsaOR/Dg19j2BbUGEY8BOcZiHdHKcyt04fr6k
         067w==
X-Gm-Message-State: AJIora+Km70elCVJspgFtHCKNTpo9UyGx+JBFtY51Dm4MkRjID5Ze/vR
        Ypy88FE4gS5X5cHFCGkaHNvGB/ZEvmw=
X-Google-Smtp-Source: AGRyM1vZ1EcOuKO9oqU3Pe01gOBJa4TWMNvwYMzQY5B5xY49IWsd+8IXHLsEs17anvVxvj95lyKisQ==
X-Received: by 2002:a17:902:db11:b0:16a:6381:f6f3 with SMTP id m17-20020a170902db1100b0016a6381f6f3mr35709553plx.108.1656943738933;
        Mon, 04 Jul 2022 07:08:58 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id q23-20020aa79837000000b00528369c7824sm6933987pfl.13.2022.07.04.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:08:58 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com
Subject: [PATCH bpf-next] libbpf: Error out when missing binary_path for USDT attach
Date:   Mon,  4 Jul 2022 22:08:50 +0800
Message-Id: <20220704140850.1106119-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The binary_path parameter is required for bpf_program__attach_usdt().
Error out when user attach USDT probe without specifying a binary_path.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8a45a84eb9b2..5e4153c5b0a6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10686,6 +10686,12 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
 		return libbpf_err_ptr(-EINVAL);
 	}

+	if (!binary_path) {
+		pr_warn("prog '%s': USDT attach requires binary_path\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
 	if (!strchr(binary_path, '/')) {
 		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
 		if (err) {
--
2.30.2
