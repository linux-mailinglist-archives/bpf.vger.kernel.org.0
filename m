Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03A502D76
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355703AbiDOQHQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355698AbiDOQHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:07:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B81EADF
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q3so7450337plg.3
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZcncKOI1d9UTl2lH3kdY8XOvGPP+O4rntBx2UkzXmgo=;
        b=JMPGHcmBVzAMfCDUhvOJaufmU8vsbzjnyA6pNWBo6VDgFbF7VY6VJr9Lme5ZbaYqIM
         1J5N5m1F7V2kQ1pIZ1u6SG4Nv+whowteqol2p1/c1631RwQsOK6g1iN+3kLo5KpmjfRY
         yK9axefKbmKaYTBJ0qet4y4dPZwNqXm/JDaSW2cEEeJoZtx3dCvLf53++yel6kC2B5is
         UQ1i/gKzupKPt7J4vPrnRD9lq7HezM9a2vFaLXWmFoHE0nkHSrX1Eiu7olW0Ugsa3ISB
         fXRaAwu950y9xW+VLpUwITnAF9yEcvRB6BkclTWqd09OPcBVnhF2YCaRkcSZxP/az28y
         ZyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZcncKOI1d9UTl2lH3kdY8XOvGPP+O4rntBx2UkzXmgo=;
        b=kKNuU8Yt+AJVFZiCDFCv2ASocrO9vI5gAjm+a6dsZDJyD2sXP8zcgmpM2HNB+3/u2+
         L9bRSrRp9boIfyfh+hcUJ1x+w4fzLeyd1OUNUJRy0uMqlKfeKbIqhWsECye9f4VmOcTM
         Bn5eZViPlRWQDdrBbYgcxohXYg0BqeSwlpCf4eYdi60+phcsH+7ND1u/yqaXPCK5nEXR
         kLMPgjL6y0XmyPi7tamSPSkD9m/KJc3qWiZdMxHOkzz8vmUAWu+CxxiK/eBXSYGqE/oo
         54LLy8RJQ4kYf7Fk8Ky3QyC0SGaKqS/sLgGcN5thlcBT0gFJVIzXiYeLYBP+79yjyTE6
         hvYw==
X-Gm-Message-State: AOAM532MY6smrEs6A81gt98pWqp3wKUSw2GtQR9cHuktybA0i+CxMZ1H
        OONazP1L9dOSLjZJ0ldxvRGUMgCuG3U=
X-Google-Smtp-Source: ABdhPJxzbd5BjBd1VazBMaDgot0aBoMYUbLA4TRQv2w5AGi5bFEFvae1ZpJ1uAEjRIGIqGdQ4SR6ew==
X-Received: by 2002:a17:902:8217:b0:156:9c4f:90eb with SMTP id x23-20020a170902821700b001569c4f90ebmr51489716pln.121.1650038687251;
        Fri, 15 Apr 2022 09:04:47 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a670c00b001cbb7fdb9e4sm9056817pjj.53.2022.04.15.09.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:04:47 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 11/13] libbpf: Add kptr type tag macros to bpf_helpers.h
Date:   Fri, 15 Apr 2022 21:33:52 +0530
Message-Id: <20220415160354.1050687-12-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415160354.1050687-1-memxor@gmail.com>
References: <20220415160354.1050687-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; h=from:subject; bh=oANeT/bZI3pMPuEceQ4Mk4ZXAAhu31wl0nGUhMKHh1U=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdC3enbNiqWMaC7rBe+x2ZIIIXon5H7PAl4DNlA +TUfrPWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQgAKCRBM4MiGSL8RysR3D/ 48H/6g/oJkdCZRjb4Mdv85S0Gu23dXZaJ9/WFkh8E1JpfodZDHHlwjk6SSbuUOI4xQxeuhveM5FV9W mV69lPdhl08+ROB1Uz3e1DLyVYzwSWF3KKAJgbMhLPXSwnyA61Uc7ZDXXvic9+aIDdFPpf499TDioU xYwTnXqDNGYEzftHWP0utfMM6dm5GMCgKOD/LTayOt5Nwo4laZoShZJEqNvWYdgzBO2OzdK7HTxlAa lU+V+Pb1g6+NaRincYO8CKcU1jH/NZ1t8VF24K52OVX7pS8328XxoBzqGjqjjt8t3w2PQ+NqBWrrLg xMwN358ev4YHgtkFk9j2QCxCyR1HO98g9RNvBzR3uD8LW6R89U7Vhr3VzzCcuN9P+zNJoDLbQcPoYW FxEHzwMBeLVVnV2WYfCRG4JnJPoS2Fxq4YPLoF5NZw9OvPXVwrg8mfbhmqjpE/5O1gpE6ooTWHgCla uDE648/G3FJCzoeHK2hfpuJw9o3UIb3inogy+Z1LL3WpgelB4FUa/6Jxw90LDjkJfDkh7FPbOhLQOt qggrr/0u8R2bkLItuaGWtEpczwhU9P7C/ryC43SY74yGXLNf7UNTHLl/y/A3xv0bKib9BqNr3oQvVc i+dX4B4TCShhJ9x7pQB1i/HpExVLhFEIbfy9cecgBXFVpuTEKqjoPInazuZg==
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

Include convenience definitions:
__kptr:	Unreferenced kptr
__kptr_ref: Referenced kptr

Users can use them to tag the pointer type meant to be used with the new
support directly in the map value definition.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 44df982d2a5c..bbae9a057bc8 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -149,6 +149,8 @@ enum libbpf_tristate {
 
 #define __kconfig __attribute__((section(".kconfig")))
 #define __ksym __attribute__((section(".ksyms")))
+#define __kptr __attribute__((btf_type_tag("kptr")))
+#define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.35.1

