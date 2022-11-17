Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67B62E1AF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 17:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiKQQ1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbiKQQ02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 11:26:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B878D7B
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o13so2402613pgu.7
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPomuiw38Tc36JRhHYvhQJpHAo45CMYZVjWlALJ2I00=;
        b=Dg8CqbTsbJmIe62NqcjyKdAaeINmHhHFKt4xZESeWvnR0r12AWr+NQq/inDAuTdpVp
         qFzui0WrN3MRuohKppYh+/sO6LNXI0WSkIO//onLrsEmIRvPkjq8utZhX7KHAUjoSIcR
         TtQoyUiyYgloXASBoQEjjuAi9YAYYjc1c8QbdZbORKvZngp7uWVtm/7TMyWvzNFf8TZh
         p7PXQbdHxHAENm7ZLGNUEVJqfDd6ABJI+NFXmAFSF4jwXCgKm+4Abnl+BlK2E1l9ChJi
         6d4CGOW5RmhURvUZai6pJE8ntBNDKl11861eByuXTsqR+Q09fYY59i6tJZkMYqHE1vIi
         MrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPomuiw38Tc36JRhHYvhQJpHAo45CMYZVjWlALJ2I00=;
        b=sCfLyA5UVfCoY84x8ev1EkVmTrndMcvgmuq6qcR4OVCNYjcNdeT9TWwIssI1BORpdr
         aI/6ITek3w+MBnQHQrn1B35Q1xcQ1om7FDdDE0Xa4M5hmlKcZPF0b0634VCbKxx7gRGJ
         VBCKY+rUnJd8tUbNBhkDmIEik3tSk1cDMLMSE1e3IXBrY/UDLL3MiDZ2usQjXRPkONe1
         NbYijeRlCvgY4/eTXGAKF/1j9LBVE9lWS/t+6HvwDvYN3RWucvbmeLraQvInkoRxJh55
         dh05JsjYdJaxgX3nyZ9vLKSFoRa0zYuZIZY0E98nTRJjAuaB9R4DXI/tvQiKBX0RBK3A
         YITw==
X-Gm-Message-State: ANoB5pnSvfGMItsAnET8D3LCeD48n7TuKyyZCsfZG/hQp2ZsB687Ty6u
        o5y8TIXw8lzJsuAx6/n7oMudtteIrZU=
X-Google-Smtp-Source: AA0mqf4vrUyzRNMDnI9ZGMMhO5J3OUoPnz2/uWb3uYlK6Vk67SD4pXTT14Nb9irGlsxM6GnvJmT5Qw==
X-Received: by 2002:a63:5819:0:b0:476:8ce9:be5d with SMTP id m25-20020a635819000000b004768ce9be5dmr2728689pgb.15.1668702341385;
        Thu, 17 Nov 2022 08:25:41 -0800 (PST)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id qe1-20020a17090b4f8100b00210039560c0sm3782053pjb.49.2022.11.17.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:25:41 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v8 15/22] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Thu, 17 Nov 2022 21:54:23 +0530
Message-Id: <20221117162430.1213770-16-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117162430.1213770-1-memxor@gmail.com>
References: <20221117162430.1213770-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2422; i=memxor@gmail.com; h=from:subject; bh=24iLGg5VsnwmsvtaAeQ9jk4cZGNEIECN8xis7P+9mPQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdl7/+mohHswfHDzYNGMTg+MLWeTNlIOxWTD6wKYO D3uPfdGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3Ze/wAKCRBM4MiGSL8Ryr88EA CimqQE9kkpqteqsfZPBWM7MX2ip29yes7rVns0VRPntiQjcuhPF/wBUnxtNbCsDMv/l7NY39Prh/1y sjddwPKpABLtcrYkPcMZBqvisxDH8BWJjGDNB1Vq5GiDuZ9YeNMGMh23L7ibZytsxFhYUcWxY1GwZk T1NqdEb2ZsLfNa+fNGixt3mJvt/wgvo/Q2RgbfzHB0LxYVQ76TT+Qy5fd0DS/35TuFsnb5DFQ3VqCo lQbW+O7Pbz838ucaE4Axc7ceEI1S19bJezUzgPTpN3MyTWqXHfUHR7B/Vdl2EQP5wj6xIe/NrP43U0 s5FfA++1GyzvNadI0qC70o2YGdrTVGy/5nJGbB/M9237Fb1OLbWX4BoT4WwskV72X4s0jgMs3GKIQV NqrnwKz+VyMW9++3UrPXfatKBcAv1aAZLrhqVddfxE+nIKAiS1S4+rUU7ofTVzKY0tozkSURhbp5Yc XI9PztATFHXGpQs9o/39Zp82dSzqB1mLy//G1keLIS4lcLoHJLNSca1HvPfA8S57PY7QEtJ3ZG0rmP iDT0OPsOhtXXlD/l3+AvTKU3umAetqshfUtbblR0gThz831eahVCh0FUL5VwM5eM8f0/fURGJcEqFJ K4pa7xr1XC9oAJgB3+6lyH/TSFbPZDVE1aWujRyHNYWLcONQaBXGMDJSbHCQ==
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

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for PTR_TO_BTF_ID | MEM_ALLOC while still
keeping the warning for other unintended cases that might creep in.

bpf_list_pop_{front,_back} helpers planned to be introduced in next
commit will return a MEM_ALLOC register with incremented offset pointing
to bpf_list_node field. The user is supposed to then obtain the pointer
to the entry using container_of after NULL checking it. The current
restrictions trigger a warning when doing the NULL checking. Revisiting
the reason, it is meant as an assertion which seems to actually work and
catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b96c525fa413..8951f50ae918 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10790,16 +10790,19 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
-			/* Old offset (both fixed and variable parts) should
-			 * have been known-zero, because we don't allow pointer
-			 * arithmetic on pointers that might be NULL. If we
-			 * see this happening, don't convert the register.
-			 */
+		/* Old offset (both fixed and variable parts) should have been
+		 * known-zero, because we don't allow pointer arithmetic on
+		 * pointers that might be NULL. If we see this happening, don't
+		 * convert the register.
+		 *
+		 * But in some cases, some helpers that return local kptrs
+		 * advance offset for the returned pointer. In those cases, it
+		 * is fine to expect to see reg->off.
+		 */
+		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+			return;
+		if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC | PTR_MAYBE_NULL) && WARN_ON_ONCE(reg->off))
 			return;
-		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
 			/* We don't need id and ref_obj_id from this point
-- 
2.38.1

