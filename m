Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC9674A58
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 04:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjATDoA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 22:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjATDny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 22:43:54 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BFAEDB7
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:53 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7846890pjg.4
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 19:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoWooIhorualD/dUDPJYQZFrDqrpIAeU3u/bnIZ1h4E=;
        b=jIclV2b9DiWkC/iLscNR0YQWz5E+BqcGMhRxDfAAEM0/OuxwAI/qv2j44xg0P/Va5Q
         7qDwp+SYHsoKQGl/PMIrRGoSPyEkzkJVYOJdzMIysScFGdUF3wKhfK7p2HQIyssqXGBm
         17JpUOR0Zk0XIThX55LnCJHohjCvuJKsmTdJY7t2gQ0Jk/a7XSaeP1emeHzEj9FHZL0j
         OizgSrCXlok9nVz9kLF3L7Vd1a2TFUj6lLZ3+/Sqv6hxvLvpE5at/qOCMAlKhmGNy7X6
         sjd7OHcb5a+R2JqgtUOGkB6jUnxobe1vtxD4y4JGZ/4tzQlOs7PpB8OyzxDoSNyasF5G
         fz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoWooIhorualD/dUDPJYQZFrDqrpIAeU3u/bnIZ1h4E=;
        b=MlpvGWhSoxzltU6+dii0xV9taZmY7jkj4T02e2hbxSgTBTBh8L4WGMSt3tzXShfjUD
         zlcmJRAtIwhmEQFqcZsOuV8HUKkHXEpRUpU5oe5b31r5Cs3VnrZ+LdXjWZRQktJA+5Rs
         XXcTSL+NEdTAjQcNKBnW6KP7vTjses9A2rYL4cK1BwgP8rnbjo6IaL357g40FxapxRun
         +9JZ/2teQrCyfaSj5mTsrRhMJbt5bVj3YS4tvOuHX11WarPhKQzq/8Hu+IlHUbBxiUGt
         DgmrU49CAUFtOtY64gGW0d40k6009ilvIycu3vO428s+mAMZs8fswRU1YnCQZUWBJK+6
         h+Kg==
X-Gm-Message-State: AFqh2kouL+JjwFNqcvr+sQLSxeRJQID7L4iaCIbYAbNMloYhXk+jXoCs
        4RimHRXiE1P0PWp1WSGU4KZUitDkqd0=
X-Google-Smtp-Source: AMrXdXvVwKm0ohHiCSWqdzf/XAXWN+67le4u8uX0/graEtJvGGWIroi137TFFaqUrpZqnCu2COW/EA==
X-Received: by 2002:a05:6a20:d38f:b0:b8:723f:e21b with SMTP id iq15-20020a056a20d38f00b000b8723fe21bmr14574616pzb.3.1674186233263;
        Thu, 19 Jan 2023 19:43:53 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id y14-20020a634b0e000000b00476c2180dbcsm21415255pga.29.2023.01.19.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:43:53 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 11/12] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Fri, 20 Jan 2023 09:13:13 +0530
Message-Id: <20230120034314.1921848-12-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120034314.1921848-1-memxor@gmail.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=memxor@gmail.com; h=from:subject; bh=iON+lJXc9/1194SE26yS2gIj+59nymU6GNzP9SOpqJg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyg2941X5gs3080Qk68TQVWyXHYez/oGY+bpWZd/y LKoZw0iJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8oNvQAKCRBM4MiGSL8Ryhz5EA CAZ4GdBHgrmi6MtMPi2BIPPNgKsiPJ41a1SrrQ6u0VGjXBy6irmYAVLKzZMzn1hmqGaZEKhs+Q2fln mNrfUMQRmPDGuj8pGF2Mtl5S8dexCcGrR2AG8PM5Xfqmp/YLlkiaaQxchxzlqBzYkR07NnHBp5gw5j CiRWwXkWDtlHSBZzKxrdcqWOSZIwRBePvWp+9XAjAKeDCdFCAHygorfYrpMUrbeoutz3Qq2TKhgMUe 1kHH3qZMklZt7QLY89rUHn7Xpj+d/Ihk3Q9stcJ76V1YNfzdMMMUVGb+srPVTren/PsDUdS/D7p8C/ uWSdTCW+kLpE2v7voViX0NKenXZ/lR8tw6Vzpp4NyyEdApt6ksdQjt8CbPYWwEnX2N2DXkMofm5cPj nS0g3TcWHP460J1Z4hPw9pGkppQS/nwiRftune5HmdBTKsM2YqstOhqUrWyxs00ryuMqO4XKpFCji9 lulv72wbgkP+xi441GzqDBXJfpAQKwQdN3jl03Y0K0k5UikKdvYQMYTouBDFNn4+q5+zfc78SP78QR BPMv9lY0e65CJACCuYdeOO7etUv1lFCJ/rchcX36A7urAXWJw+Qbh4PC9WBE3FUsOOFAyOk2EGAQjR poE7p66MeIERh0uRzYjoQVxr/O4sxq78ABhgaLZbYklJXGtCm/BdbFwazGmA==
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
index 9477c238af57..cf2d12329a1e 100644
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
+		"call %[bpf_ringbuf_discard_dynptr];"
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

