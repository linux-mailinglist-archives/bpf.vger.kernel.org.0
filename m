Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231025AC67A
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiIDUmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiIDUmR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:42:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC6D2CE0C
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:42:15 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id gb36so13424662ejc.10
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gcQMKN+S/93cn71lJllWLNd5dp5PiiA+5re+BvQFX8k=;
        b=NsA81WnawX6QQPLTVxNI3pWRF8cffUkyvh0MWYEI5taU4M0uRyibdJLBaXJBsM9mlS
         HCiczxHpA5kF5AMwvQ6XFt2QVwZwBMoXYT65FL9oD979642Uh6p/zQSdW2POunCuA8bG
         qWAvxsNhKZ+e2qgRXsEdghvd9+OI+MMCSfD7DXGScGJzMCPbR1kKrRSTkITk/qu6WYW6
         Hg42cBNDqlJ8J7T7kM+XLjZqo12Rwk3/JKzwYKnMHMThzWItWznriTYoaefvNiKQbhlU
         VEcdxyCeEQX+SVr62Bx/3ZNicJIemz9wez1w/eljQMUXk3fm9J0XZsP9mGF1oBVzWSPz
         /Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gcQMKN+S/93cn71lJllWLNd5dp5PiiA+5re+BvQFX8k=;
        b=kCtU/cZrvcc44B0VLTfdjGjCAq5Nbo/MbdKHyA7nHHp8wgJK9IJd5T3qCv6V46jTRk
         pttWxdMw9vbU7dSuNmFQW70f90jRdoUfnknnI4Bo4S1TnFLdsYZOi1qa0IsXqQ9YIAxB
         UehE6LQcB5gpEMAAlqy/6IYl+pY1oCyO5aTko9uIRChgNPkLkVTcCJFbR5S5+fKwLHQ1
         75rDz+v2a5wq/5UZvnLiyTRQ0lbZvGUqS5+NQ46ZHRmGRq6MhufXGPZstYsfmAVwyFVH
         1bikShKvTmVx6B+25yTQUBQb2Vg0rtXIe3eEwkRKVbcLRNOQgud5VQJ2SAs/uiHGrizh
         PZWg==
X-Gm-Message-State: ACgBeo2Qafv/u9nOsHAby0qTkSTh4y5X9iZhT5HsHMWqIhFIBv1nM49u
        J/kcaxzSsnZchE7t/r5E9PGytNq+hJArRw==
X-Google-Smtp-Source: AA6agR50OTLILWiogZvrurMa1pHuFfIe3hhBGh72jgvlZjEBZq61CoGlF8hTybn8ukop3ZQWj9uoUw==
X-Received: by 2002:a17:907:d08:b0:72f:b107:c07a with SMTP id gn8-20020a1709070d0800b0072fb107c07amr33953342ejc.340.1662324134398;
        Sun, 04 Sep 2022 13:42:14 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id ay2-20020a056402202200b0044841a78c70sm5215992edb.93.2022.09.04.13.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:42:14 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 24/32] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Sun,  4 Sep 2022 22:41:37 +0200
Message-Id: <20220904204145.3089-25-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=memxor@gmail.com; h=from:subject; bh=gvumcdChAkhoW8p4ThkpZF/Q8VzLbx5/gPtjyg7rbYc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1x7gH8+mLyp3mbyyRHo8aq/7CkE40OCZcXU98T myoXqUCJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNcQAKCRBM4MiGSL8RyqgAEA Csh3TEEnACtDwIMfQukoRgFwfJCieUKCXDS0EOv0OfvrrLs47ISV1shGhDoJeAp0k0tAxJDF1FWLmd 6PiSBvLF9jDl/CACyOOcJqsOR3MF8iUXNjKb/HhAxPl12nnDTB2YF4pUFyHzC4di5Hk5P3+PVq2ywK +zRDUSMazTwBPeKQfJ1nNomuTNGMUJW7nGteVd0PiujRRb9HW0Soe91TKhnnR80JHlsmvdSGGXG7O2 wMCjvKk4G97MY+7VWvZeXKlssvy3Rvg/fOrne+iMq6PuytRz/2ORMzBMZ+eqJnQCn2577X5wJeEfUD 2xrc4yytpymFWgok3hM0+EyvThmX1qrVtAZ/WXyikfWo730qtAnGGM1IwvGppW7HM7Spj/ZcJLCshU WtVMmd9aTZ5u3sQBmvWgb0s6AbGM98DCg9b2xjYFiliVGvskh0qM/SSvhJqdAquQ9I6vUFPHXgFKWv wuWhNgO+6taM7OHBQGUL/pvtRC6IpB34SuSdERJyhqT4e7KHz7WINKMd5QaoIYwcHNdRHCwrLRSPG8 kVqTBVCoY1Hzm4nWXyQrXWXKkTo3o/QkPduVLSLiVsA7aJBLPDR8PC7IpV0FIDtuz/YMBXCQHhQhdW YKto7mGr0gKVhK6IklhcNmf/0S4nmxR14lra1J2UjRhN4sNoT/KZCcZt1O+Q==
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

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for local kptrs while still keeping the warning
for other unintended cases that might creep in.

bpf_list_pop_{front,back} helpers return a local kptr with incremented
offset pointing to bpf_list_node field. The user is supposed to then
obtain the pointer to the entry using container_of after NULL checking
it. The current restrictions trigger a warning when doing the NULL
checking. Revisiting the reason, it is meant as an assertion which seems
to actually work and catch the bad case! Good job verifier!

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dcbeb503c25c..5e0044796671 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11173,15 +11173,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
+		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
 			/* Old offset (both fixed and variable parts) should
 			 * have been known-zero, because we don't allow pointer
 			 * arithmetic on pointers that might be NULL. If we
 			 * see this happening, don't convert the register.
+			 *
+			 * But in some cases, some helpers that return local
+			 * kptrs advance offset for the returned pointer.
+			 * In those cases, it is fine to expect to see reg->off.
 			 */
-			return;
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.34.1

