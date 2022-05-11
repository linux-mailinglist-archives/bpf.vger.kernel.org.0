Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76B523DCB
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbiEKTq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiEKTqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 15:46:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0D2B26E
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q76so2649429pgq.10
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 12:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UKk4+J+Cqei14264Z8gjmNptzgI9k48xoTnQletZIc=;
        b=pSn4d+00CTZSkVur00RDRMouTXzdePxvpeD39MU3k5O06j0O25PE6lBT6kAY3NsLQk
         wmfLLP5144B78L4SZFaYLDKhqRPofOyUOA/hDPZTz0Wsw4hi8zdibhXG4KgDtC+bdJF3
         H4XAiIwedbak13Upa8dqWW72OgayqzKAtFEO8a2PvKPcbZXs0zE7obRTvBZ3xGTQgfv7
         GtKuD1HZY7vuUoqNR1UkLwY5SojkJkM3aqwUwrbU3zD1FaekFo2GmfCWdVY8SqPwwF5I
         LH5r4x20YbFeX9nILMXPbjAmwdJ4JH1nQxw31QUE60sSIg6lOE8F35uRue06PHfi12e7
         5Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UKk4+J+Cqei14264Z8gjmNptzgI9k48xoTnQletZIc=;
        b=15iXOnNuMH9tL8YWWHUUcDbPWTUJcpyT4nubVY/73AzD9q/tAOLrRU+5G68vSxHxT/
         w4MRrge3LKRzLvXN6HZiEgbOtLrL/TxkiGPbYllcROxQxRam4b3bSnB8zjfxZ9CNkWOu
         zu1+JBqILeDGC7UYjP1+vr2eZgtQhKAad4THDur9C4fbw1SZi9kCFDt/qmAJnCdFBI0R
         eAlPKqTjrzy697yF5OanBobWiGtKFf/rHJk4VOoLlh2MNoyLmnaBMBEawJH4JWSMhWYY
         z16Dq4cGC8+mpiLZYCx57tug55SKdtRtRZ8/Vz0siS6MDoY62nfaK0jC998UEBh6v+8A
         YmXg==
X-Gm-Message-State: AOAM531kGsJYREyHxPtfUDFWiIarZCb9pt39or7HcS5dLmzCgeWSoiR4
        lOdcgLh4s4MlKG7PO0zpCFnHxloIqzo=
X-Google-Smtp-Source: ABdhPJwpRNYGoyQMeC52/5une8qS0OjPmSc3yxC/GNB6TW+1y6syBjyNTD60p84UvJemCqkY4EqwYw==
X-Received: by 2002:a05:6a00:18a4:b0:50d:f418:b982 with SMTP id x36-20020a056a0018a400b0050df418b982mr26677268pfh.49.1652298382807;
        Wed, 11 May 2022 12:46:22 -0700 (PDT)
Received: from localhost ([112.79.166.171])
        by smtp.gmail.com with ESMTPSA id d10-20020aa7868a000000b0050dc76281fdsm2107043pfo.215.2022.05.11.12.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:46:22 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 1/4] bpf: Fix sparse warning for bpf_kptr_xchg_proto
Date:   Thu, 12 May 2022 01:16:51 +0530
Message-Id: <20220511194654.765705-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511194654.765705-1-memxor@gmail.com>
References: <20220511194654.765705-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; h=from:subject; bh=3JYoYyvAtl/x65stiiwAXCGWUHk5p8npYvJpASNbpX4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBifBG66RtWAD0TYqTRCHXN7L8QaafnUnLlak2aJ8fD FkE7uwKJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYnwRugAKCRBM4MiGSL8Ryp+jD/ 9NUDfJc6wppZ2qaFNrdNwgQ35HyPEXBh0jh+KA0yUKse0FRQlH0Hm/lZuZtP4cHbWFzFf1upV1BCq5 YHsNUTw1lX7FBLyjQgdFEdcjNnDS4QPsNoWmhRaka78wnMFIb0C8kXipilwj4pGr/u1RuamYyGWK8R llv9kv0DG7V3mVlU4q+uRS+K2+Rykwyfdl4tuhvOGoAa3dXgpdirB+VAayWEYTyVSDzmKgXKEZV2i2 vezC7oYqKVHCO3ig8A3t4bhT7/NV/RuBtejumwFcQCeWRuEkZJAtCns0MnPqIo7Z1F/WdIWMTZX819 G6g2UTgBjjBNNRlL0sxhwKT/rQehNIlvFas4iIe1WB8dMywv7PZDyQMAzVPgeUGPQhyYNNJtzSDDsK YOeQ4c/t2wbSRHFWCMCtTfAS8I72sPPq9LC5PiO9dCD4ntF7b2iWm18XHFVFW+L/hXGBkD0Kkrngp7 MACUHdvRcWOsLl7XqmuNNcZN5m/+nhg5dXE5n90RaMjAY5SOfZH93T14JmjZvjv/Yfi8ysqsYoDfBn k30eU/DRxPSMSn02SMMKUTmX0APnjixYMaFXLYhTjSfYWz6mL/2gUKiYgnF5YfqwPQb6TUgcAVRSub 1QFm/BdNSHmogyVHE9i4ERTD9O8F7iw8szDc3vU7xeY63HYLYiKo4ZdBUCvA==
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

Kernel Test Robot complained about missing static storage class
annotation for bpf_kptr_xchg_proto variable.

sparse: symbol 'bpf_kptr_xchg_proto' was not declared. Should it be static?

This caused by missing extern definition in the header. Add it to
suppress the sparse warning.

Fixes: c0a5a21c25f3 ("bpf: Allow storing referenced kptr in map")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index aba7ded56436..3ded8711457f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2246,6 +2246,7 @@ extern const struct bpf_func_proto bpf_find_vma_proto;
 extern const struct bpf_func_proto bpf_loop_proto;
 extern const struct bpf_func_proto bpf_strncmp_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
+extern const struct bpf_func_proto bpf_kptr_xchg_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
-- 
2.35.1

