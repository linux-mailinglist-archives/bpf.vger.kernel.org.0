Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438AD62950C
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 10:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiKOJ7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiKOJ7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 04:59:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D7DF4E;
        Tue, 15 Nov 2022 01:59:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso9828306wmp.5;
        Tue, 15 Nov 2022 01:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=61NlKiTNTDTVesE8Rv6V0GdCCK+sgb98OdfqledH+Uw=;
        b=qX4VJxyLwawd96elL++aETjrkSldaVvegyD1tQNdcvGcWe+3N4p+PJC+8gfQC0uHXT
         cC8ZU5XEUWLQbx0CUwJ/A/lHTVr77FRihNMlg/LtpOPVqc8/e24U9vLgoSHarSxVAadX
         uDphyW+r4mcr8D7fmWmiVYO05JlkBl4GJ+tryzGRVwanNW/1NIKgnqwOAuQSJKZp3A4B
         /5DyBENYhaa9qQb4xCma/FBa+HFs30RMNwI598N1p9pWlCzkMtNk7CikNInXmL+uGd34
         233AgBJesN2GcRSKpRAp+m9+ulhuZ0eFAkuytSjYnGXq/ukzdz6j9qYPCkFDtxMlUiCs
         dYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61NlKiTNTDTVesE8Rv6V0GdCCK+sgb98OdfqledH+Uw=;
        b=dwL+7ct/v7SglQBw056wjaKqcOsebrYLoNvtF9KaHUxlfuyIBMLRYyqOs7xKDtS7r4
         uv4hiK9ffSjvK8ZBu89Vqe2u//D9iIkAgbEXs4exv73AXanjkkXgFrDzu4ynK8+hhEvf
         q/sFSf8x9zfb9tJF2Fm7M2M/BzT7Yqdm0d8HCgkTDL69hwn8UzYnIGZRsyagfyQ4oVX/
         qhz3cADnxUdfCIGb/1c1/C1o3yOZMj243o+K3TH9KxgIAjDn9hxjvZrQgsWrzVMvgo3o
         QPLBdUQl7UQNjDfKBLknjPsuvOi+5LA3QQN250YHGC4HKDrU1AovFL6yIFqfXTITxJCu
         Dyzg==
X-Gm-Message-State: ANoB5pmWb110ny7ZNu2aGQ369OBcj7EC7KE5pN+VIXAy+AyIiofD4RSG
        Z7r9M6gqsvvWmCeRUD84nTWiedqclrXHhA==
X-Google-Smtp-Source: AA0mqf56Qz3ENxFWWlCFaXoZ07IcXWek/ED1sU8Wdv2BApLayvzB3U3+T+ckj6RgoW/y9tyCgwb/wQ==
X-Received: by 2002:a05:600c:688b:b0:3cf:9efc:a9b7 with SMTP id fn11-20020a05600c688b00b003cf9efca9b7mr883623wmb.10.1668506354121;
        Tue, 15 Nov 2022 01:59:14 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c14:eac2:879e:46a4])
        by smtp.gmail.com with ESMTPSA id e24-20020a5d5958000000b002356c051b9csm11727492wri.66.2022.11.15.01.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:59:13 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v1] docs/bpf: Fix sample code in MAP_TYPE_ARRAY docs
Date:   Tue, 15 Nov 2022 09:59:10 +0000
Message-Id: <20221115095910.86407-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Remove mistaken & from code example in MAP_TYPE_ARRAY docs

Fixes: 1cfa97b30c5a ("bpf, docs: Document BPF_MAP_TYPE_ARRAY")
Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/map_array.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/map_array.rst b/Documentation/bpf/map_array.rst
index b2cceb6c696b..97bb80333254 100644
--- a/Documentation/bpf/map_array.rst
+++ b/Documentation/bpf/map_array.rst
@@ -119,7 +119,7 @@ This example BPF program shows how to access an array element.
             index = ip.protocol;
             value = bpf_map_lookup_elem(&my_map, &index);
             if (value)
-                    __sync_fetch_and_add(&value, skb->len);
+                    __sync_fetch_and_add(value, skb->len);
 
             return 0;
     }
-- 
2.35.1

