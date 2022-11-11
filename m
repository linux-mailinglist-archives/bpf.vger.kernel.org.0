Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF73E62620E
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiKKTee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiKKTec (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:34:32 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB376FB2
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:29 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 130so5687711pfu.8
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvMB46Vqr7eLH23u46H2EgXkWOTOPfK9QqKgaAYTLEg=;
        b=Y7OaUW2ALX2i/u4HzAxZQGSQrJp7VqGBQWiTyG1tqRCt+FychaNRkKXnqNOO63dAUE
         L/ohaV+qhQZaKoTS+agDJXrlBEjVbzLPX1AKO/p+/CG4JULPFJns5GMArcLjiPwWL083
         SucIWoqYrjACC2ouf9ox2R0w6RKcDXGtGmZ3uAQo73DM+DwG/LLP8d+37XOGko0qHDys
         UxnkP+v8SejO8Ubn3Ig6Ch4GrFcqfOz8w12Vw3vc2HXNUxiuAmaH/HjMTZMYr7E8SV4r
         ua8ntv17m4u0yeOmZNzcBEXZilcQVpjXOXSjUnFVjSfxMd+U72Sis8TBnjeAaVjRslOc
         UmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvMB46Vqr7eLH23u46H2EgXkWOTOPfK9QqKgaAYTLEg=;
        b=nzR1pTL3V8yUr7fweRCHCUwpQ60AXXewOxZbEW468u2eP8xUtC/Rbrri1NRmzvnQNR
         /VztPLmvVGLi+bC3jOlfw98uz9zzkwiRaBb67zPzQN/yVWALT3Yo+uBBYqeYDRoS/sTO
         gmwZxzroDhI9IlRQAsm5CKGZOLz8UYmYMTaDNSOqnPkKpdO6jqrxzv0P3HB/mlatX+g8
         86vKNmZVWxVXDjEV4VckVsOMqgOQIFS6SI9eNwSK5Ki9QSNEST3bRWdkRfqTm2WaH6rH
         R8qoP5v68Z0yunnf9SZ5BZ3PsdE0/p6EKCSzy3nMvYKhYIJ1QQxY86c7FTluFnwB8u2d
         YgOg==
X-Gm-Message-State: ANoB5plQw3C+G0d/qo922mlR//Ekek4GCDj41nyR0mDLzEfKMBL5zQC0
        SGiW/YqgLWUwDuKTabFEV45heZMH1wO6BQ==
X-Google-Smtp-Source: AA0mqf6i4hDtvQ1qF24qkGv3+/Do6qo6k6bBfdWr4lzcmvyEVyZii8qVd6z9cRNs0RHTaXuZm7JK0Q==
X-Received: by 2002:aa7:8dc2:0:b0:56b:b520:3751 with SMTP id j2-20020aa78dc2000000b0056bb5203751mr4090116pfr.29.1668195269164;
        Fri, 11 Nov 2022 11:34:29 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902a3c300b0017a018221e2sm2078108plb.70.2022.11.11.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:34:28 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v6 22/26] selftests/bpf: Add __contains macro to bpf_experimental.h
Date:   Sat, 12 Nov 2022 01:02:20 +0530
Message-Id: <20221111193224.876706-23-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193224.876706-1-memxor@gmail.com>
References: <20221111193224.876706-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=memxor@gmail.com; h=from:subject; bh=VcTPpE/Iv5Qqfs22C7MYEC67+XombxopywbBgVHOTXY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjbqIpat2m++oaewJcZt2UDMupXoNxYDkyNqAT1xwv xR2sFL+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY26iKQAKCRBM4MiGSL8Ryo5WD/ 9XAghm5/NCTIj2UYdQk2umfQQkc0it89IWJ+lNICxFF4jJNqNcZ5Fhgf0LnwcJQyI5C554S7WaUbi3 tKnnSUNh01Zt2og/Nej5IL2FjbQ4ZNNJRVWJxhzQ2bl/PEuhLgqRNA0sbCXOM0YLpRVwZsNte32d/Y QztKpJ9zoDzOUwr18zkHee9Pa2cA8D+JKN2+NH7W1TnRjf8KzVW3ayJy6dXFxPn4/iK/CYYPJFxSUf Z/gWkCLxtajJCaqvo0btHL7PA2xeeXU6YVtYXHLMWFi/CpKRX/MJE9x+ZCOjYIWhSmOXlkpzyurmwj U6joYmBAxHlXw28/xdCwToGVoALt0LIZmrV1cmVdxGC9Dkrl47u11jbm83rlG/ndmPwRIXhLfE2B1C yfcQE3FUP+Fg3/EFHd7Ps9moXt/OJU9hop0XKnSWMa0j4DkOVCTcy/TlLO17RhqgvKeBy4bYAVYM90 C8CcrtivfjH15ysfOYNJ80A9B0ZDL7yJxQC14W9bTGrAjqDPKRQAR5QmMhhHd+dyHoDr/kCIewKqNv 89CefMpFeaNUL/u/q1N8LPpFcufLM1JGNl4gME6uSUzTgbsRtwlys8QNUymzvyaG0iAclmvqX3hkpB PB/D66QSytniCrSbDR0BsbmnP6jX1UGxWNXgB5K2KJxBVHjhSrZVT65jDLBQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Add user facing __contains macro which provides a convenient wrapper
over the verbose kernel specific BTF declaration tag required to
annotate BPF list head structs in user types.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index d6b143275e82..424f7bbbfe9b 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -6,6 +6,8 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 
+#define __contains(name, node) __attribute__((btf_decl_tag("contains:" #name ":" #node)))
+
 /* Description
  *	Allocates an object of the type represented by 'local_type_id' in
  *	program BTF. User may use the bpf_core_type_id_local macro to pass the
-- 
2.38.1

