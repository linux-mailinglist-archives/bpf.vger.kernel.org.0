Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9A651296
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiLSTQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 14:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiLSTPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 14:15:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B241146C
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:15:31 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so14106812pjr.3
        for <bpf@vger.kernel.org>; Mon, 19 Dec 2022 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VL+Cw79ic0DSYIqULvw4ICgBa1wMjtLZZbVymVogzog=;
        b=GMxEbGBOPSLrF3HqYoE73qZBAKvUQxSV1FbYwvCtgxHJ3tQtIv/QpGi8Tgkjk/0xeS
         Bsj9NiZWfuuZbVKOMBaXJqpNaih/bg7HSF4DJFXItjq8xcCjTGDxU5WyitfBnILwtdvW
         PcnHvpRSqOtmVoaxYv0mUEO7gA+HqtzRg193cU17rCcxkFYlHY/mKqWc1RHpGxbahaIR
         ImK+bOgRMgvAmOtJyGyZuh4vpQ43phJJoo2r50bOQ1kyU2eXIF/Tp+ND8gOzabM1xKr9
         qtSXkjAKGjkdiA6NaJIKE53fqEh8/9G2wq/ivza7naswYjPuG68PJB8A32qLb40iYqUn
         S6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL+Cw79ic0DSYIqULvw4ICgBa1wMjtLZZbVymVogzog=;
        b=q7GPCKarXttCc0vIg/YA2CEpbtGUB1JBVFXtoeWAho5X4arsuDR7cZ3ygsSOv2bQr/
         jY06Q9bwFwm+I1mPBZfJwF1Iu+RClAkvLNvPH7RmRPaN+2LzwaWC6+3MSSq3X5563RV6
         QaNzBhAM0LcmIA8+cm+/ZLvazhNGg+fx7h42EUxkP/we4AYmWL7WllP5M4xFQ7KalCyW
         ET/CHjyy9ORnLw+IvrAdRn1tgDKWpSqLZ4ld1EsvFDyuSxLwwwXqUNtZRuDJIodU3M9z
         sy26v382XBf3EOfeWRumxrhJqM/nmpu5JgT2Z0/1+eD5paY+zwOigeuBR6Y8ImxHh1N/
         8yNA==
X-Gm-Message-State: ANoB5pmUVcZxuEAh+L4+tSv6OlhkS7D5FL+jwidu6VEuSKMH5dZEUcep
        NIDlu4/+zXGdbhz42UGbmlwj44DHI7k=
X-Google-Smtp-Source: AA0mqf4Y/2nsIXWHz4M1SP9FNnfvvyGy3jc2/qYC7wVVsRO/JHfFZjMgSBPEdPoPixHjjBhMCGGBVQ==
X-Received: by 2002:a05:6a20:3b94:b0:ac:98db:d4cb with SMTP id b20-20020a056a203b9400b000ac98dbd4cbmr46580173pzh.41.1671477330015;
        Mon, 19 Dec 2022 11:15:30 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::41f2])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001896af10ca7sm7525799plg.134.2022.12.19.11.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:15:29 -0800 (PST)
From:   Khem Raj <raj.khem@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH v2] libbpf: Fix build warning on ref_ctr_off
Date:   Mon, 19 Dec 2022 11:15:26 -0800
Message-Id: <20221219191526.296264-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Clang warns on 32-bit ARM on this comparision

libbpf.c:10497:18: error: result of comparison of constant 4294967296 with expression of type 'size_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
            ~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

typecast ref_ctr_off to __u64 in the check conditional, it is false on 32bit anyways.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
v2: Typecast ref_ctr_off to __u64 instead of checking platform word size

 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2a82f49ce16f..a5c67a3c93c5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9903,7 +9903,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	char errmsg[STRERR_BUFSIZE];
 	int type, pfd;
 
-	if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
+	if ((__u64)ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
 		return -EINVAL;
 
 	memset(&attr, 0, attr_sz);
-- 
2.39.0

