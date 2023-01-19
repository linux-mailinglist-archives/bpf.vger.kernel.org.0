Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17B672EB9
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 03:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjASCPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 21:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjASCPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 21:15:21 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3086D6794B
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:21 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso3342042pjb.0
        for <bpf@vger.kernel.org>; Wed, 18 Jan 2023 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MT64Kw2s7noQGB8gnrRJgRvyqyO0dwBS+rUz2DHLxU=;
        b=g6KSAesa3PZMFfk4gjMBn/uNRkI6K3iU0jU3E0w6TsWPjLRib2Xb7yUCHLC6P30LZv
         ccYipD4G6BuXGxZJZnh1myb7S4P8ex8oVJxkVMGvy3BmMYesPqCGiEDAHzgkA6L80mPw
         coiRAbA9eX5DGHSsnI2HazrGHr3tVvaUm+ucCZM9iyJJAUmZyz6lhcX3lS5PFmTRutE7
         ju1XxDAUtyXxSK6hER6WmOcH1k2EVEE0KyOWSG6GwN3j4ku/9eZc6g5hqq+grlJkXvch
         q4iBNiKXCeXtJbAKkcFERZpUfJw9eNWmoVaaKAJmXN0erp+79mzBcLR4EB6OIT+YvOyK
         k/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MT64Kw2s7noQGB8gnrRJgRvyqyO0dwBS+rUz2DHLxU=;
        b=wVTzQ9CQPxy20u5d/9b5RnjVBXFYE+qS4UedquSZczEv6oX3XzgQd0VhmBV2rH/BVQ
         q3F12oadxKukNb+LAIFIpmZKNk47zNUL7GuAJPSDHtea88oN510nmqZ4y0Sroh0/0ZZ5
         ke3izYtoxn/l9hDm8kOXvmVEcwT/3VwMa3NrVbvKYkVr5xXuhaBoRVXT9dDS3OJnu4hI
         4Ffi6cGThy56YJ2X4CDNKre8C7RNkNAqQNZalb3m+0eShvrsPp67U0v74z/v97WgubKE
         fSN30J149gcNUKJzcxu2H1sIpWn9Ggd3Df5/SEBDze9a2I8LDWpYKtLs2jQOcKNhRC3/
         u3Ag==
X-Gm-Message-State: AFqh2ko8ifx2I0De6ytTHw8At6Sb7Nym6ELhXv+gJ86xxNV86ngRsgqX
        b8mRVvw9BUU9kjFZR37Ossw8jMpwjX4=
X-Google-Smtp-Source: AMrXdXtlKq9hGXTzHMv54Wp/PXddA3ahIFJZkDVsissk/8oZB69VuWNUYomhohGx48fxjNCgOv5jMQ==
X-Received: by 2002:a17:902:da91:b0:188:760f:d831 with SMTP id j17-20020a170902da9100b00188760fd831mr13354531plx.7.1674094520491;
        Wed, 18 Jan 2023 18:15:20 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id q25-20020a631f59000000b004cffa8c0227sm2291825pgm.23.2023.01.18.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:15:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 10/11] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Thu, 19 Jan 2023 07:44:41 +0530
Message-Id: <20230119021442.1465269-11-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119021442.1465269-1-memxor@gmail.com>
References: <20230119021442.1465269-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=memxor@gmail.com; h=from:subject; bh=nJCImzp66liN96YM+JOp3WcmgJw4KR+gjbLZP/XY0WY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyKdASix/tPD73byymQVITMH4aifeVIIKI7fBSfUY jqHzv1SJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8inQAAKCRBM4MiGSL8Ryr9mD/ 96PedKgVkEKl8oYZ1iXzgy18AJ2FBiz4S5e7mNwA1h2HjWOt3VbSX7Uj/LjPe/S/PeMjjWWbdXDtSs Uy3nwqSJbTfvYK4vB2SaMUHEivv9TO7xj4xMD2hjCJnjpKFC/EKiJZa/VfA8SmaqVZFtU9yvPBKYDE QRfvkG6RXTjIVNX1htvvAVkQNk+aoD+JxDs/rvZOaFv4opsbhoobm8MiKQZ4vwHDofUmwEVeH/fcjM jizdD3ksHSnT21l+P9q9dr2Y2ZyIgMbAj+2mWTLwaZ2BBc8GMAcyrVPouMLU4RTMhZZWHYBO1rMiNU bAIMSPGaxeqFVw3ttp/OE5yBYhc6gfC5Kb1MjyYndUNAT0Bl3LSLhC6Spa1Edz2SRP1N4itAaappGQ +ZOA27bXG7gc2ssP7IJs8PtYQZubvnt2vnsyDr5Gl5zTc0zw2zlOmHAFydd9SKeG0q1ub2KGFEdRJj XuIWe74tKDGZs3g8TpS858KRwKYyBkXDY8GdX5lyUkuBHuVOMQvkShJfQd+kEWcHeB/HXzDd4FTkdo it/12CzCKVhtS7xKfLDESpxA6G3TmuXErPmwBZnkD4QPVkVQ5wtC7Uw4R/oxpg/a44mJhmRJR5dZP1 DCg0/HGotC+5mHFf3WRG59AzPxfbeuEeYzD8y2G4UwgdfEDDOX7WuTwo8aMQ==
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

Try creating a dynptr, then overwriting second slot with first slot of
another dynptr. Then, the first slot of first dynptr should also be
invalidated, but without our fix that does not happen. As a consequence,
the unfixed case allows passing first dynptr (as the kernel check only
checks for slot_type and then first_slot == true).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 063d351f327a..e63d25d82b05 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -834,3 +834,69 @@ int dynptr_var_off_overwrite(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
+int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r6 = %[ringbuf] ll;"
+		"r7 = %[array_map4] ll;"
+		"r1 = r7;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r9 = 0;"
+		"*(u64 *)(r2 + 0) = r9;"
+		"r3 = r2;"
+		"r4 = 0;"
+		"r8 = r2;"
+		"call %[bpf_map_update_elem];"
+		"r1 = r7;"
+		"r2 = r8;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 != 0 goto sjmp1;"
+		"exit;"
+	"sjmp1:"
+		"r7 = r0;"
+		"r1 = r6;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -24;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		"*(u64 *)(r10 - 16) = r9;"
+		"r1 = r7;"
+		"r2 = 8;"
+		"r3 = 0;"
+		"r4 = r10;"
+		"r4 += -16;"
+		"call %[bpf_dynptr_from_mem];"
+		"r1 = r10;"
+		"r1 += -512;"
+		"r2 = 488;"
+		"r3 = r10;"
+		"r3 += -24;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call %[bpf_dynptr_read];"
+		"r8 = 1;"
+		"if r0 != 0 goto sjmp2;"
+		"r8 = 0;"
+	"sjmp2:"
+		"r1 = r10;"
+		"r1 += -24;"
+		"r2 = 0;"
+		"call %[bpf_ringbuf_reserve_dynptr];"
+		:
+		: __imm(bpf_map_update_elem),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm(bpf_dynptr_from_mem),
+		  __imm(bpf_dynptr_read),
+		  __imm_addr(ringbuf),
+		  __imm_addr(array_map4)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1

