Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C0B4FA67E
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiDIJfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiDIJft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:35:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250126F7
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:33:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j8so9912802pll.11
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pZfLmYbolHwmqXMfr7nqaaE34g3CnbTOWtScfGan094=;
        b=mV8K/WvBSJZLNXa0ZeVxRySds6X/7x2ml081X0XtGt8sRgKrMnD28EQwpVSF3k4UU/
         JJxiROxIdU0kW97EDggFMSqjAg9t9F/C7DeM7QItcE7Jmw0KHTUg7p9h2AtOsoBi9dr2
         7a2HUI0vWS9TmOpgcUiYZHtHQiNwNIc4eRgyGsEn/cZ2IMRopOsDdi73DM76IauVLzN0
         vmS0nfJ3DbTHn1DotcT7UHAWSk8P7usZkezKqJT6NjatCrv6w7lqS5WKGNeFqkVDY0a5
         Hd+1mvwDDK0HlhQ8ffPdFMiUC7Hn3o7NNFrZIY68HCMoa/0BpYqj+WMO0nqJjQ4otulS
         g5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pZfLmYbolHwmqXMfr7nqaaE34g3CnbTOWtScfGan094=;
        b=C3tDdF9zpGzADCHDghv6hapV3/tsrKxIj+AM/lAP9splWWFGe6FULDPxjqlUDEoRss
         1rGXDfLo3iUJstm1X9Z5QkfdzEUQ6rlZaIjlRVhkRLoz/yWyEdeAhJ3Ag103D6+ODx8f
         QiU8xBwhKibQCys5Isp3odN3i58KuUjq7hkc/JQKSHN2YBHDYjKAUfe5rFfRiDM2nX/9
         D7I45shPvJeAopGUOVIvBNrt/YVFh0NFzf8zCgGnBlJNJKDeKDyzNrNWFh9htbdUPSz/
         EJ750WY95cVhs9p/zFPbrao4QFP9DWCOpRJ39q+Hu7i7d0HIcV/iObvok68VQueU4yOc
         iLYA==
X-Gm-Message-State: AOAM530ORAel9hC4PRhY/JeUYrv18HY3YWVaL9VrDdiKYEBkVgAsetFG
        97Z8lkkA1dFWF4OSBEBlVXMdpVHF2xA=
X-Google-Smtp-Source: ABdhPJyz+A5LoZylSsn2X6VaeDJoPqsi226qzE7hXlRBoDcNau9sbOQkZ0e/GuRSyjz29QaubLxWXg==
X-Received: by 2002:a17:90a:8a98:b0:1cb:6b5d:fd37 with SMTP id x24-20020a17090a8a9800b001cb6b5dfd37mr1024447pjn.198.1649496823189;
        Sat, 09 Apr 2022 02:33:43 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id o34-20020a634e62000000b0039cc4376415sm7103413pgl.63.2022.04.09.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:33:42 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 11/13] libbpf: Add kptr type tag macros to bpf_helpers.h
Date:   Sat,  9 Apr 2022 15:03:01 +0530
Message-Id: <20220409093303.499196-12-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409093303.499196-1-memxor@gmail.com>
References: <20220409093303.499196-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; h=from:subject; bh=dtVrckouAMHnmEAd4Rr2OdBAilXX+AUoTjGvaGbi9os=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVF0srejQAaub14DT4bq6Zig06TX+s1CkhTq0CzC 8ntkqcuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRdAAKCRBM4MiGSL8RykacEA DCELWrPF1/dXk8l5i3kTVVC8DaUvFESqgHH57y9uIiw112HoJ4lFMCK+OdbQuDhk8ekoUO4h87vusw nTb/AnJbsW0Fz0sQiIkG3tef8fkUuk9v8HCj3gG28mX0wQBx4fOZUcousADg2Ohp0qC5EwSR2i+2T1 sWhMzvV5KxZWjsUIF+h5fNuneFwbSS0N2eoiQXccIw1UHA0JW+/HVP/57s8IURcYuQpkRxdHI1ph+8 EXEl1Vgsebjdk392L9KTt10/ZmvDJoVyN96Dp4J99pV9LVv6kc4Tx2h0IbS8emcCu87NsgvTrpq4+w wH0Yemxp6mkWvWiIjXzfW1AXY8zi5gRNhnjXF+hcDGjCoMZQi4GWKOFAy7bs62ZYDhMEOEsVN28pRr RwCHj67VGI0PqLL18guqIeWMVIvIis3F0eY3lCVo7VacPZvA6CplrB2WVTzJzW9JL3yeueRvs7SGYA IZpxccrWJPxN7wxPTXfv5ykLr7nC47zYiMyV9TORTGzKa6lqp1bDKak997QnAoXJmm8GkVl8fXhDh8 JQIm2Vj9Fszwa2oKZZk2vdLrYhZh/i3eTEzuxlKJVAycSvPiKpQOm3r/O+BgsgKMCTs7wiFXlxieb+ gmBLjuBiMnz/bEJ5RFT3Z/5BudnwvKP+/Y36zdW3JPd6GTrMdbOALTY4lk5Q==
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
__kptr:		Unreferenced BTF ID pointer
__kptr_ref:	Referenced BTF ID pointer

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

