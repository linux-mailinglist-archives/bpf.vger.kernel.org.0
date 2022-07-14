Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2952E5749F4
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 12:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGNKDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 06:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiGNKD3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 06:03:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AE5018A
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 03:03:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so1869494wrv.4
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVR4QvVnWBYeVB+iXIwMI+B8KQ5U2fMKvAXlIuNGVgk=;
        b=gBxiXRfaKyTZYwQXKxd95PSTZJ8U3isr4j6eMkW12m5Gr0F5rAZxorcyu9c5nboh48
         xZMdsvhMWfBEtT1sJ/eibvDU2CHtDdZMBOBLqQVkfubHg+nQSEiLRwvRKPf/aJHMq6Yu
         5VOP9BkucjdA3fBIzA+okSB2X8stFOBBvHI7EB2c0mMc6AVs8nU2xJXgoNePx6Ujtp21
         JX1ydSMC5UY0eLLqpfbQ8FdXwdJc+Bzi6zw9SpmAAkjiZx3pgvD1H8i9jcGzfHav6ghS
         RhcOTfaQI6u9+3OJyg4TDtsMRbKXrIQcP7yCSfSXgHfPFcdlOXLx5X87sPiwLwMRlmyJ
         4POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVR4QvVnWBYeVB+iXIwMI+B8KQ5U2fMKvAXlIuNGVgk=;
        b=vXwN7yFBQYTySIXUcN8rz+h58bEKJtIdlZ0n1GuLWVKKYifPAwmOeIWCB/WsCp0eYs
         3iyjXZdCT36V/fCzj9pSmSYxN5bcX9L0em8rY7Tsty57m7vbbRI8XojQXZm0QKsuk7He
         bJYLmHpBtZv/R0/dOUre90K77iKkzFArAYrQyzx046jQ1bg96Z3a0zBWRIy7ajFsleJl
         oD740oqmgwzlK5yoJ5NfPDKm2GDcbYCIlzNPatvm1B9E+KVLHhxyYWGJBNAmOVU4t3Xe
         zSRDO4hDMS/GxxvxBCjGRowLW9ImFLXbv82yTLVdHnPt59JD41uIUkV2Nr2Hx4A8AO9Z
         tN/A==
X-Gm-Message-State: AJIora+Ap+4rPz+bkXIJTEy9X+XLEWcJkZLlIRs5Xchyco1Xo+BCm36K
        rnTTfNZh2Koz6HIPz8RYmo2N/w==
X-Google-Smtp-Source: AGRyM1t9tNgPpIxXmhLGc3c+A2Y86UdmgdxoECL9gDZ/MzRtO+1ATq97eGB6dv9z5+rV7A0CW00nrg==
X-Received: by 2002:adf:e94c:0:b0:21d:81f4:7de2 with SMTP id m12-20020adfe94c000000b0021d81f47de2mr7656872wrn.338.1657793006927;
        Thu, 14 Jul 2022 03:03:26 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d68cf000000b0021d20461bbbsm1053856wrw.88.2022.07.14.03.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:03:26 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] bpf: fix check against plain integer v 'NULL'
Date:   Thu, 14 Jul 2022 11:03:22 +0100
Message-Id: <20220714100322.260467-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When checking with sparse, btf_show_type_value() is causing a
warning about checking integer vs NULL when the macro is passed
a pointer, due to the 'value != 0' check. Stop sparse complaining
about any type-casting by adding a cast to the typeof(value).

This fixes the following sparse warnings:

kernel/bpf/btf.c:2579:17: warning: Using plain integer as NULL pointer
kernel/bpf/btf.c:2581:17: warning: Using plain integer as NULL pointer
kernel/bpf/btf.c:3407:17: warning: Using plain integer as NULL pointer
kernel/bpf/btf.c:3758:9: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eb12d4f705cc..9a6e5f71bbd2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1108,7 +1108,8 @@ __printf(2, 3) static void btf_show(struct btf_show *show, const char *fmt, ...)
  */
 #define btf_show_type_value(show, fmt, value)				       \
 	do {								       \
-		if ((value) != 0 || (show->flags & BTF_SHOW_ZERO) ||	       \
+		if ((value) != (__typeof__(value))0 ||			       \
+		    (show->flags & BTF_SHOW_ZERO) ||			       \
 		    show->state.depth == 0) {				       \
 			btf_show(show, "%s%s" fmt "%s%s",		       \
 				 btf_show_indent(show),			       \
-- 
2.35.1

