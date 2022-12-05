Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98164291C
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 14:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiLENRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 08:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiLENQv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74E1BE9D
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 05:16:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so18508390wrl.9
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IifO2YWxrxsA8Kbl8/x2hIyP8xhy79sLALVNORQ9+so=;
        b=IRFrnP0FnrogtpDDCdzVQUDGMI6I4oaatZHIM1uF6JU6QpNHM4DrNQqCWpgLZVlm4o
         DR/hIH8bKU6/dYgkiVbnPrOCsMPZDAlxCdE87AfngUqlbt1EjmnzEwPJ8RJcU46jMGO8
         WzqrhL/3EYWE7P32RNEhak3TRxRYeMhSpbN37axLYeWUJ4FnryPb/tX592sePOmIgGeJ
         N2MYQYUtGyxBigkAuM+kXM0LvUDhrwa3zOuCkkvqyzyIsar1UJUNnuU+7WlgKqAcxQDW
         41W/Uf8JdCc69O9znNJpxVSZDg3xXaqVkcdufJZLYu+TlT2uGau621H6yykQadHIaR2T
         2RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IifO2YWxrxsA8Kbl8/x2hIyP8xhy79sLALVNORQ9+so=;
        b=pVZpcgqzYWUALOcH52ohS9gLJh2eY3Rg0BGda97TK1ukDmOKO9tuC85OhTK8sAAb25
         ihRdonbT6vdoO380Q5cJHexkKR+zxhTnsIKaRAfkJX3qxfMQnSbJirnrQEuDKHg3FyMh
         WLj7Ezd+fMPg3KS+Hz7nCJH39H+0EjRtAsiLBW3llMnCECL3FuRKvPSTRktddcRg5Bpt
         610SV5pvVzIKwusp2WaR/LvohbXYrU59r/IPbjM0I5Lba1E/e7ofuGKsE32tkNqVBC00
         NDh0BoUpnU8smSqLOKioHgGfYyjxXhmTmoDAMjcaleQNf5jte39d8Yfb1m78iBnoaMF8
         SWRg==
X-Gm-Message-State: ANoB5pm3ns/F4TwW0wzQpUQBQhrgRR0KpBUsy0TeoDpHajX/LV6CyAra
        bMw/RAxWnxdh9LEkQXnlICemBYLr902f0WhW
X-Google-Smtp-Source: AA0mqf71F+oLXx2XnnaJwZzi6cLEb/4gbtTJQW6yC4RqjYSbKQ2m09nViuxRDDNbRWsXV/cnN7/ldw==
X-Received: by 2002:a5d:5a12:0:b0:22e:c2a6:d00d with SMTP id bq18-20020a5d5a12000000b0022ec2a6d00dmr44054549wrb.29.1670246203477;
        Mon, 05 Dec 2022 05:16:43 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:48e0])
        by smtp.googlemail.com with ESMTPSA id fc13-20020a05600c524d00b003d04e4ed873sm24710492wmb.22.2022.12.05.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:16:42 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Install all required files to run selftests
Date:   Mon,  5 Dec 2022 14:16:16 +0100
Message-Id: <20221205131618.1524337-2-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
References: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When installing the selftests using
"make -C tools/testing/selftests install", we need to make sure
all the required files to run the selftests are installed. Let's
make sure this is the case.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6a0f043dc410..f6b8ffdde16f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -532,8 +532,10 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/liburandom_read.so			\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
-		       ima_setup.sh verify_sig_setup.sh			\
-		       $(wildcard progs/btf_dump_test_case_*.c)
+		       $(realpath ima_setup.sh) 			\
+		       $(realpath verify_sig_setup.sh)			\
+		       $(wildcard progs/btf_dump_test_case_*.c)		\
+		       $(wildcard progs/*.bpf.o)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
 TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
-- 
2.38.1

