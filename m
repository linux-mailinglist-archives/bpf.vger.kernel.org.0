Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79B628A8F
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiKNUev (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiKNUer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:34:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF55E0A8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:34:45 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B9DE423C3
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668458080;
        bh=WC+NC/bp8exDJsewvJ8oxWxlDpF4ig1RrOTupSn7stI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AFtoIpExSd2eubpbRf5wJWhmT7tYJyCgJGPm2kEjpWM57257OWBBjzCFmreI+fEkc
         ubobirbTtxz1847PdMzf9lQB5gIwec8sUqwwDnvtHtvpxhZCvFh8WWTiLwtoo6lI8B
         9QJj1h5ixEYfKGKx7fM4TLmPwrJqI5R9/BLA6OnJSWozr5HWesIEkO3q72Pgp4EDIm
         wb0hZTbFElnQK4/4RfkncWWIGYDJtv3N9Q4NkVayPcyh/3KBkc/eBtbXvDWgXkiIUV
         tSbYtNVpD20xGqkcympzKpezhrxGlew4BQh0oJGEiiHPpgSNKOFEaEjOxGCvDZoAJS
         M0EfjDo+vcW3w==
Received: by mail-ej1-f69.google.com with SMTP id oz34-20020a1709077da200b007adc8d68e90so5990157ejc.11
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 12:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WC+NC/bp8exDJsewvJ8oxWxlDpF4ig1RrOTupSn7stI=;
        b=t1zPo9Cya9d7RoVr8/qZsgeSX3x9BJKYlB/7Zt2j6nci9dKYZgDUf2uTO9nXP0YaLD
         FS2U7Hf1emKE5k2KQp6LZWANBf/RanTu3KPqwBy3EEHocylBpx7MWS/nUGdCwR2fefwC
         ArghF5zQxYo/5jZk0Ye4/y2yVPgtOUMBrmFnK7ETVCkWTAHeBICpX5sS33varY0f7Cxa
         fnS52s5Jw0M2o8JHmPh0PH1tTR19+f433jnitEsJ5gyxluHH+KUp44mW52jLYHax0YoX
         gR/udWrp5sYYLDdkdgiTL5WCXJ8ZlroeMKxgAgUJcl4Kzn2ikzpTfmmTlHMQJRvZ1Za4
         HUzA==
X-Gm-Message-State: ANoB5pmSA/OhSeiKT7K9oZJGNwyT9wUXSFmf4uSfkiD6EhRejkiDHpr1
        6d9nZBHnguSTnlwYLM30wSN+aaOExy/fqCNksoAI3DO3LugAw5sX+C0hBgiOCVVjw4lH8HKRiLZ
        oRr6SxTXDEzsAbKkDJlWntgAirRpnHQ==
X-Received: by 2002:a17:906:388c:b0:7aa:97c7:2c04 with SMTP id q12-20020a170906388c00b007aa97c72c04mr11621710ejd.191.1668458078753;
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5s/a1Lng3ilCkg3POCMwx76l0spcBD3eOI0wAt+YffElcdeD9WJFZ0nls6iE/3xfYz1CCwNg==
X-Received: by 2002:a17:906:388c:b0:7aa:97c7:2c04 with SMTP id q12-20020a170906388c00b007aa97c72c04mr11621699ejd.191.1668458078551;
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
Received: from localhost.localdomain (host-87-10-120-177.retail.telecomitalia.it. [87.10.120.177])
        by smtp.gmail.com with ESMTPSA id k15-20020a1709063fcf00b007ae32daf4b9sm4572587ejj.106.2022.11.14.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:34:38 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Coleman Dietsch <dietschc@csp.edu>,
        Lina Wang <lina.wang@mediatek.com>,
        Kamal Mostafa <kamal@canonical.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests net: additional fix for kselftest net build error
Date:   Mon, 14 Nov 2022 21:34:31 +0100
Message-Id: <20221114203431.302655-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We need to make sure that bpf_helpers.h is properly generated when
building the net kselftest, otherwise we get this build error:

 $ make -C tools/testing/selftests/net
 ...
 bpf/nat6to4.c:43:10: fatal error: 'bpf/bpf_helpers.h' file not found
          ^~~~~~~~~~~~~~~~~~~
 1 error generated.

Fix by adding a make dependency on tools/lib/bpf/bpf_helper_defs.h.

Moreover, re-add the include that was initially added by commit
cf67838c4422 ("selftests net: fix bpf build error"), otherwise we won't
be able to properly include bpf_helpers.h.

Fixes: 7b92aa9e6135 ("selftests net: fix kselftest net fatal error")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf/Makefile b/tools/testing/selftests/net/bpf/Makefile
index 8ccaf8732eb2..cc6579e154eb 100644
--- a/tools/testing/selftests/net/bpf/Makefile
+++ b/tools/testing/selftests/net/bpf/Makefile
@@ -2,11 +2,15 @@
 
 CLANG ?= clang
 CCINCLUDE += -I../../bpf
+CCINCLUDE += -I../../../lib
 CCINCLUDE += -I../../../../lib
 CCINCLUDE += -I../../../../../usr/include/
 
+bpf_helper_defs.h:
+	@make OUTPUT=./ -C $(OUTPUT)/../../../../tools/lib/bpf bpf_helper_defs.h
+
 TEST_CUSTOM_PROGS = $(OUTPUT)/bpf/nat6to4.o
-all: $(TEST_CUSTOM_PROGS)
+all: bpf_helper_defs.h $(TEST_CUSTOM_PROGS)
 
 $(OUTPUT)/%.o: %.c
 	$(CLANG) -O2 -target bpf -c $< $(CCINCLUDE) -o $@
-- 
2.37.2

