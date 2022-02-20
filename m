Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3577C4BCD1E
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 08:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiBTH3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 02:29:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiBTH3T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 02:29:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E779350E2D
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 23:28:58 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q8-20020a17090a178800b001bc299b8de1so667096pja.1
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 23:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDkDp/CINzmrb/qWfBvQU9WnLfUsPonjFOrw8kZTB9s=;
        b=Di8E/qLimU1fCTxQPcFxT4jPV6I57T28m/YSnS8MxBoUOEYT8b5yjpMqmlPYpr2Rci
         gj8Ky2lOtjNsR07z0m9OhJsFNj9wv6DNxJ9q2n7VGocv4JYdmTo6L9zW9OTXf3KQsJ1m
         Poy0CL4VB4JtAxzDn0ILyLW2kQIXsmjlwcNey6kfETnf89+NRyDgq2UwRevmoZXJWp8+
         aJIwuIdPZOpzNLumibNRdBG9Sg8z+m99zMg6qa4Fm6UMsvjaF9pFcAdj3WX+M82ga9EO
         6UNtmcfAzV2LKU0nxG3wtCfE6ckwKYPJrfqeUpV3wEejCHoEwqI/JowGrjYb5gv152I6
         6qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDkDp/CINzmrb/qWfBvQU9WnLfUsPonjFOrw8kZTB9s=;
        b=Hso+QmVw7kU4KpE5gkpQFF7+eg7SKmM6acbdCFjYBxgOhybdL+HKBDO7KPl7K07KWd
         egKhmPvpC75I3RjjQn4hVvdgkrz27Y0if1kOy1KobxPyaPM+S6K5LIKT+QhojrVNkShp
         +e3WhCNjvrzuokZfHQtjIiQT99KYk/KsjJ5vNRvDSEwboVOlTrrXydIe3/Ew7Z8FmqW9
         SveyJHVqR0SSNF7/1WKaW9O6KnnJka3HhOuiiZNlLMZJyHDEGBeGEMJgyAS7t7SMi0I8
         1xtcFAn1615m4OHP4bvvqdWpWOM7BlJsiYg4N+HQq1YNCxl0I+BpGrvfJ6ZBJR6c4ty9
         1P1g==
X-Gm-Message-State: AOAM5318Y4+jyRe/U2NHFGS/p3RusyvsSZ/lw1UEfP4evDkEHe2YIRax
        EqNPXovHYybKVOY/3P3uoZWeEEcr6TUgCY16
X-Google-Smtp-Source: ABdhPJyCaWl+RQgjA0TfLnQqu4V9rkKtFSMqedvVTU/oiKbCP3ynHNSNS8koMgfwOkyG8pfNslwTsA==
X-Received: by 2002:a17:902:ba8a:b0:14e:e8e6:7215 with SMTP id k10-20020a170902ba8a00b0014ee8e67215mr14401618pls.135.1645342138130;
        Sat, 19 Feb 2022 23:28:58 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id u38sm8920074pfg.171.2022.02.19.23.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 23:28:57 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH bpf-next] libbpf: Remove redundant check in btf_fixup_datasec()
Date:   Sun, 20 Feb 2022 15:27:50 +0800
Message-Id: <20220220072750.209215-1-ytcoode@gmail.com>
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

The check 't->size && t->size != size' is redundant because if t->size
compares unequal to 0, we will just skip straight to sorting variables.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ad43b6ce825e..7e978feaf822 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2795,7 +2795,7 @@ static int btf_fixup_datasec(struct bpf_object *obj, struct btf *btf,
 		goto sort_vars;
 
 	ret = find_elf_sec_sz(obj, name, &size);
-	if (ret || !size || (t->size && t->size != size)) {
+	if (ret || !size) {
 		pr_debug("Invalid size for section %s: %u bytes\n", name, size);
 		return -ENOENT;
 	}
-- 
2.35.1

