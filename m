Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1064967625A
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjAUAZ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjAUAZD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:03 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD2C79D3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z31so2070905pfw.4
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqKHgLPVOuLzH7ZCR7QAiED+nBVGYayNRgcRrmJ2ARk=;
        b=ey+lPeMjs+n9uhyzpCsLr05EwUjSMs2Zid4RnLkwSQBb0/7nvjzQ0VNXJapbV/cGhs
         JygdowJ/3qx8wClGCcNXoVeX7Gy3yJgIkKQQhV3EURkxEtH2B+MRSg7/LVwNgClp9YNT
         PGl2zZke4u9wq8FmORcixC9viihPtaeX6CUydvq8nzxX/6JHynxNJlJk1hc9oHMu9nXG
         D0p0vSv5XXqgIOxM6or+dzfc2eV1pasyeXAEKC617nBxtgpJI2Ia2OMzHm93zr9E2UGp
         pGTyRRt7MF4+tBx6r6DUaE1yUP57ejGEPJzN/N0bOU3J4BkBpV3PgoojHAnuiCEb4Hob
         bCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqKHgLPVOuLzH7ZCR7QAiED+nBVGYayNRgcRrmJ2ARk=;
        b=SAwgRpwhS8KxkCjR63o6wobJ90EKSIqNydwxZom/RRgzy+xkoTvwON2FIq4pculvBd
         7eZyXUaX0KyHbZeWnpGleLtebLCL+6mALgzoyOkErCWABziYdbTLxG0eSr0Hf+UEcSSr
         jP02epUGKJx19tOw3hKWRwExT21Kz+dH5R+mplg6IA81AQAAjqdnTVXaEKxSE0WwbB3x
         X6Co1mc66g1Ej8Q4kY582p8eLglxYTIaqv+MK+Fmcwx7v0GPVtjYk/FrssRIWQfKgF4n
         jpIpEhS18z2JHs1oQBqcxyvimNATZKLUC3duKCJi4fRI2whnRMDLrBrs8iMLp/oElJuh
         Ymmg==
X-Gm-Message-State: AFqh2koW/K/E1DZU/8tLHlQ9ELzqUXFien7fk4dBTVyS87YRKmnNDKW0
        qKQL/YtpoaVnLlubj6NPZmy8SMbfQBc=
X-Google-Smtp-Source: AMrXdXvcg3Rij6hKe7rvsyOKzx7no2xh3Yf3n4Nj561XFNPh8cKLcM8AdPyOHeebfbuHdj2F3cjGcQ==
X-Received: by 2002:aa7:8c45:0:b0:584:6bbd:d78c with SMTP id e5-20020aa78c45000000b005846bbdd78cmr17087640pfd.34.1674260600470;
        Fri, 20 Jan 2023 16:23:20 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id 190-20020a6219c7000000b00589d91962d5sm21122336pfz.195.2023.01.20.16.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:20 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 10/12] selftests/bpf: Add dynptr var_off tests
Date:   Sat, 21 Jan 2023 05:52:39 +0530
Message-Id: <20230121002241.2113993-11-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=memxor@gmail.com; h=from:subject; bh=35zrMYiHjIev+NoG4HbRoMpjPSoBEo4hvE45xRAMx28=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkPR7d9Dz+Hqxsm4lJqmrpIOh2VEe9eLixVhUX WICorMeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RynazD/ 9yQItCNLVmDXfASIvd9OHSqtuvvmfkHvu+3Pehgqlm/oyuT2vP6vUKRt4pI5+9qeEnirFG84HQVa57 7Ovyd7ZK9BIa0GrCkiDpyUV5MTDptgsDS666i+IOHMe9NNtHAGOJSOFCh984u18KETONnTn6dI5ivY ut4+udoK5VD7ZzS3XvGl2fI0mLwJb4/oNe0qPeVDcrVWevoKKLvlGWkgkuOwsQHWodRuduZlNT0VsS ZrOq3QuYr+A1RB/qjF/f9jUt+ILwf7JtA2e1EVTFMjfsvPAfBortCtsfA/A6c8EDuwQvc9BsT/ibxU IQLqNWDVgef/KU8wZo02UI7qCl1izm1rlvwEZsC8M1apiPg/uNGxkVPKaZ0KylvCPH7N2jq4NhYNye UZ52cvU9wowUKk1SzOfkf0uqa9YMyiVu4R3/PzC1a5I8LNQ8nbzBm7Jo02Wl8J/DjeeQgGkl/CsXi9 geE+Xn2OSuaLToWBp+Ln+cl9jvuKn271Dkx8TqniS/tca0BZoiEWtNRfXrIKQ4iETK/ejyNkL7P7lF veRwdStzVWBVJ6FjpEWKvQcnXeuC6vv8ekym2WUjLDOV9Yrk86vzexQ7AquYYRgz6hCmWXaNGtDaXT ZXeRPdtT8Xos5913bPBPopY53b0tPe4O03p/ktgHP7czcnwCQazKs/yxTV5Q==
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

Ensure that variable offset is handled correctly, and verifier takes
both fixed and variable part into account. Also ensures that only
constant var_off is allowed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index f1e047877279..2d899f2bebb0 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -794,3 +794,43 @@ int dynptr_pruning_type_confusion(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("dynptr has to be at a constant offset") __log_level(2)
+int dynptr_var_off_overwrite(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r9 = 16;				\
+		 *(u32 *)(r10 - 4) = r9;		\
+		 r8 = *(u32 *)(r10 - 4);		\
+		 if r8 >= 0 goto vjmp1;			\
+		 r0 = 1;				\
+		 exit;					\
+	vjmp1:						\
+		 if r8 <= 16 goto vjmp2;		\
+		 r0 = 1;				\
+		 exit;					\
+	vjmp2:						\
+		 r8 &= 16;				\
+		 r1 = %[ringbuf] ll;			\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -32;				\
+		 r4 += r8;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 r9 = 0xeB9F;				\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 r1 = r10;				\
+		 r1 += -32;				\
+		 r1 += r8;				\
+		 r2 = 0;				\
+		 call %[bpf_ringbuf_discard_dynptr];	"
+		:
+		: __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm_addr(ringbuf)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1

