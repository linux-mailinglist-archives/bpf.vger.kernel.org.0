Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8355059C058
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiHVNTb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiHVNTa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 09:19:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECBD140A7
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s11so13835475edd.13
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=v5wa0sDhiXcOHOmZYvW1r3YmLcJ/blrvBOQMDTMbYHc=;
        b=mkIkFvxUa7Y5SKWsBMfGMOwGR8DqLnoNaxCMdaoBK/Lhxvma4zwwRv7lTgSZAZviLv
         TSEWqhgqy2+I5iVCQ9CAFFKk+ALjFsvvwwVodIFdN6xo6iEw89C42njWNe9TA8otucLA
         8GWV4pB8SfIGEmdGtGw4pw9R/jhaIx06iNwBac/m6cGHprnyXibxXzU5F9A6MhmxP8Cy
         OZ5DzSmPXMUtnBQlZFByy6MRALLdZfYENgzG/xDF6lxDTLgCDyPSGcrq8aVGaVPe+oQb
         xv8EIyNUDV5nR8xd+8tyAbr27is4roheE7qeKXXMMClUsUx8t86/HQ5kUZSQAm89wLEG
         1b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=v5wa0sDhiXcOHOmZYvW1r3YmLcJ/blrvBOQMDTMbYHc=;
        b=yidK/lUZ0JfOpveZ0qJQBG87pS5OqyR3p/rbB6Fc9+FQrxN8PrApUtpqhBhA4DlC1u
         3XQtTeUtjf6fhJu2vkjvfiIA3KZb5IsHOotxtN0WpUDfabG+t4kbjuWckAifMpKl/5JK
         AxCQFacGsnmOVl9Biyj8LMZ6zM27jVLXbGjRyeJUbh9JBVssx5Gv3EWIZHzZNfpZ7FWV
         IGLmsaDjieBMKARXY/GMDgfgeXjT/LGRBvkrRsTJs4ixpqO8sY2+T0S15SHqi+yHlRP7
         is63Yoe3TfasqGABwZ4c2Kdx3ftbP9WxFRBXmSWdEswNIaLemrLfDp7M4jMCswZxB92i
         Exhw==
X-Gm-Message-State: ACgBeo29khuiummAUJwdjkLzZ3z34uYQ0D8rinDT1E/I4tbLgRbRElmN
        olTGwCayLmT47uXyrLG+DziiuL6hxm0=
X-Google-Smtp-Source: AA6agR6xqroIz0AK0yjCCAW+Be+Avb5Sp6m7Jsz2YZzZkcwSDUSeQl5jpOfvFg/9n+acHDVfw869Rg==
X-Received: by 2002:a05:6402:3320:b0:446:84c2:a796 with SMTP id e32-20020a056402332000b0044684c2a796mr8012422eda.346.1661174367562;
        Mon, 22 Aug 2022 06:19:27 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id s13-20020a05640217cd00b00445f660de5csm8164087edy.85.2022.08.22.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 06:19:27 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 1/3] bpf: Move bpf_loop and bpf_for_each_map_elem under CAP_BPF
Date:   Mon, 22 Aug 2022 15:19:21 +0200
Message-Id: <20220822131923.21476-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822131923.21476-1-memxor@gmail.com>
References: <20220822131923.21476-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=memxor@gmail.com; h=from:subject; bh=i9XsXlrauYqZVhAtHZgDG3t3go7UNmDH/TPP+h/wWnk=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjA4GpHdVpVhYSQrcoRERNcValxamu2SeAqeJu7v3j OZeqE06JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwOBqQAKCRBM4MiGSL8RypXhD/ 0RtR6Y6KdqpnSBNhniK6zhw8OF+xccwWM1bGgPgP5mXz2QzdXiC9mfaifAYi4pB2BrIgaW53aNoPev csQ2v77+5TkVino2KI1+hlW3gudlhZn6LRokLmiAvDoXMec7uPtc2huK/jiEPUOH4vGNzgZXbp1dCB Zt1EkgWvX7iL67WwOHULijKqcHPzjCjjXdjaIDtTqMFF7Q2dgWJAg988XRcXH5Wsfhun+PYRrDW6Ot NMEEOzxvgaehzi0pMvwYC75LO6JUtGuVNX9HUZ5E0d+P2z+6VPWaVGNCbw9482cQ6NcvF66DCHbAct jzehjre/rCTD/uinObR2mqm44rJIFQ0t6xg/8vM8twTwthvNBz4RVinL6KyVCcOCeS9f+om2OysFe4 8YsOluc3yYU3ynUu5m3CvZW3riV8DeehKRTXc6Oh29bnGOlZCv7YKlj8DW1iPefYH1VUr5+ZIs1MSp yZMybWEq06E61Kdh8rLaNvT/fCH5bw93627BPqIlGpE5l7Jh4oaF71aTjvjEu3ub4J09qpwcm5Aw69 cESOKJKcCRUTS25tqMZVmdeH4CDAQzrxelGygFRWqMWqtgZRy/kVI6PEqs2V8H+u+l6dnWXyx/gejx +RokUYps3JVTF8Szr6sqsEcLvoDl+mNHV0ndUBFv4QOHtODVWya1hajgPCmA==
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

They would require func_info which needs prog BTF anyway. Loading BTF
and setting the prog btf_fd while loading the prog indirectly requires
CAP_BPF, so just to reduce confusion, move both these helpers taking
callback under bpf_capable() protection as well, since they cannot be
used without CAP_BPF.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1f961f9982d2..d0e80926bac5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1633,10 +1633,6 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_ringbuf_submit_dynptr_proto;
 	case BPF_FUNC_ringbuf_discard_dynptr:
 		return &bpf_ringbuf_discard_dynptr_proto;
-	case BPF_FUNC_for_each_map_elem:
-		return &bpf_for_each_map_elem_proto;
-	case BPF_FUNC_loop:
-		return &bpf_loop_proto;
 	case BPF_FUNC_strncmp:
 		return &bpf_strncmp_proto;
 	case BPF_FUNC_dynptr_from_mem:
@@ -1675,6 +1671,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_timer_cancel_proto;
 	case BPF_FUNC_kptr_xchg:
 		return &bpf_kptr_xchg_proto;
+	case BPF_FUNC_for_each_map_elem:
+		return &bpf_for_each_map_elem_proto;
+	case BPF_FUNC_loop:
+		return &bpf_loop_proto;
 	default:
 		break;
 	}
-- 
2.34.1

