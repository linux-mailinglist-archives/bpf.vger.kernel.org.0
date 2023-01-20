Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73F674DAF
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjATHEl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 02:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjATHEk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 02:04:40 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880ED241D9
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:39 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id dw9so4738980pjb.5
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 23:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqzLD9MYr6KiuRpe9sBVIUYjbcoAjTXay8FSvvNcEzA=;
        b=gt/CfO6t5JjH8WUQDRYfLn1I7TT39faaIUUenEuJQNmjG9BL2PWBE0H9aNMCF0Gm5I
         nAmR35nyDyGMxjkFyFFxq+bL9sR/voBSe3TrKq4BMgpVVBMNmXe+f8V12oKfGSSoI06i
         GwoQWJ796thu/yrFNPdLLrudYybSuTX2H/dy6D4eL9fdHxCmkWHVFuE/n63iMzka/Pfb
         MbbPJS1fhuxVWD64Hk2xYQAJsTaKlSjxLneOsP0RjEJLb1zKlrmBq94RlQasRgkkMhg5
         TQC+WFJgDJp0m6/TS7LwEFGA49MahNTdu3U5K4GOmlZBRAuYmu/2kzwF6zAPMOuk9bEm
         nnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqzLD9MYr6KiuRpe9sBVIUYjbcoAjTXay8FSvvNcEzA=;
        b=JD6zEAaVGCl/+nSjh+GBSkipaN5kS97zLAz8toaH6nsUO0r/OIVznda3SlZ74GbREe
         8y5D/MhgKHFaoJdGttSz/Ee4IiaiMHCX2R7JL4agUCZgUEVbW8X9cDG43UoWoXeut2dK
         4YoeRQNx7TV7WDSl/4KalfTBByPQAbYfsOTtIG2eMQVXpnanS3ECbJ9BJw9hcT7iZPRP
         bMuXfBftnS6vR+r27vnNPMOyBm/gf0QeyR3Jbn/VOr/tGtSFY1oU/jYRysXRQryoZq4N
         PaEc2Aej1nIqryTKXE+6ibwAAHyh0EF+QefXhK2ztsSL/hUvtgkW9NqQbo6VnfBDCCtz
         xvfw==
X-Gm-Message-State: AFqh2kovXz9UaTLy6oIPpn8VkQKLPvUxlBo8w6muPsjdf72nEx7h8xq0
        0GdgOGAwv+IDCM4eWR9GuvuSfTQl6qE=
X-Google-Smtp-Source: AMrXdXsLyhjnJh+jqTfhEbfWRM9YZ5TDPsHh8jRgF7xPHpBWUUBVpZPj3HbIq4l4vRXenOq879I7gw==
X-Received: by 2002:a17:90a:4964:b0:223:a079:7354 with SMTP id c91-20020a17090a496400b00223a0797354mr14508867pjh.15.1674198278859;
        Thu, 19 Jan 2023 23:04:38 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a3f8100b00218f9bd50c7sm715471pjc.50.2023.01.19.23.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:04:38 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 11/12] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Fri, 20 Jan 2023 12:33:54 +0530
Message-Id: <20230120070355.1983560-12-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120070355.1983560-1-memxor@gmail.com>
References: <20230120070355.1983560-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=memxor@gmail.com; h=from:subject; bh=vb2M3d6AP1tJHi9lacIFMdvNjgTaEGGdyWxaqNz5OHI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyjzMXtdYoVT+uua2rJKUZ75sLYaxpcQxs+Mg4Z+P 6ikII2eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8o8zAAKCRBM4MiGSL8RysOwEA CzsW2KdhXJk+mUEiM7kB9GWRnJBQYx+WrEBj2hmRaHwsuqvD02VAh+C0SMt8O8HD9Udy5lzD2+hJba U5B0bAwciaUMqWYzJiV6wvUrzcFkm8sAof4lTkpnazxMTTwC0VeXhpLMm1WF7dHekUoCz+TNQ9d0iH rismWlQipzLWVSYCq1kqgy0ICxk/KcoVgsaS0LM5klj/EjuTlDahlqm5+XRixg16VeI2AJ/91XvZ1L FTK/Uu2D08n7OfcHqpO3lN72nXZy0LRb++zKUYzMbvhiYQQZl0N91oS5SEmw/5Y8N1jiz540j1zQrT m2T8fRheMvfBwtDVWgQyB0M+JZwt3InPCSAvhqhIBcvrW869J7HFo+7JQegLYEC9SGfEhr1ngz7gky CV9zCLktQ8oFDH0UdiVPDiBn68Wem9K2Zf0VppNfSQUveuiKHrHeOCgZAFP/qDa5o341na/+mQ+a8s t0CjJQlCESgOY2g8sGXFxhQJ5X4xyt/Em1S/ppxHoAhClhvIdT7lp1H4ZQXECbImD1GUQZDFI/OLcF VKYv+dJsLfJ0t8peGOtKqVVco2A3HjS8j3GaYyBeInG0FPpaFvinMQ9hAWWQbrWBRkwY6fxCnW/bOt 2rk54GryLMrW8K9bJJz4zZCyCzxqpK6NjIvCoyldgfryly4sm1LzH1gNn4jw==
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
index 2d899f2bebb0..1cbec5468879 100644
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
+		"r6 = %[ringbuf] ll;			\
+		 r7 = %[array_map4] ll;			\
+		 r1 = r7;				\
+		 r2 = r10;				\
+		 r2 += -8;				\
+		 r9 = 0;				\
+		 *(u64 *)(r2 + 0) = r9;			\
+		 r3 = r2;				\
+		 r4 = 0;				\
+		 r8 = r2;				\
+		 call %[bpf_map_update_elem];		\
+		 r1 = r7;				\
+		 r2 = r8;				\
+		 call %[bpf_map_lookup_elem];		\
+		 if r0 != 0 goto sjmp1;			\
+		 exit;					\
+	sjmp1:						\
+		 r7 = r0;				\
+		 r1 = r6;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -24;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 r1 = r7;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 call %[bpf_dynptr_from_mem];		\
+		 r1 = r10;				\
+		 r1 += -512;				\
+		 r2 = 488;				\
+		 r3 = r10;				\
+		 r3 += -24;				\
+		 r4 = 0;				\
+		 r5 = 0;				\
+		 call %[bpf_dynptr_read];		\
+		 r8 = 1;				\
+		 if r0 != 0 goto sjmp2;			\
+		 r8 = 0;				\
+	sjmp2:						\
+		 r1 = r10;				\
+		 r1 += -24;				\
+		 r2 = 0;				\
+		 call %[bpf_ringbuf_discard_dynptr];	"
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

