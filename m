Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32D5FAA16
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJKB15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 21:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiJKB1y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 21:27:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F719C20
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f140so12204737pfa.1
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 18:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeeuPrvbSV8+OpSmUXNYjJmAFcoGuQ2xk5G/It7aN1w=;
        b=htfKV3XCuvk6dkWw6bD3nssLjctq+lSbxgrJ08MTwGuNPaUzt6wL/LeKbR9889eD5b
         PB5coHLJz3crJ30zBUCkr3FsXy+wJdQqaNzRVOyYHgUpuvGqSK0QSYVwPmv/nEAaoJpe
         1b299G/oL1Wc5mU7CZ0jrEiwjCT+4OhjcGWaYntdumG7W0t5YQ6yCXVbCu/vdWvppvLF
         yzpvFd6pEnEINBoflT1EqpPBa/bhmiIdo5rwr3q83/akVkxL997QgBA7Mz1B4pdyB1CR
         vBpitW5ASS9ojCmxlx5NQ/mfNORyZCCGqP8LThSVwGFLMJ1CEE+9sC+XareBzibR6lMA
         SBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeeuPrvbSV8+OpSmUXNYjJmAFcoGuQ2xk5G/It7aN1w=;
        b=2p84bTiT6i2sMVy/RPsa96zfH1RdYbSqOkxbJ3VZXDlqsGQVkZC89NgYvOOIJ27Kyq
         PgZZGwPGvTj0iySLyJMEFGZB1+SM+lpSn0w4qgHehAEdpMFCckPGSgbHNj3qJ+A37xfl
         YudNZwPbKyB6l1aWgqH5HDGZjqCvMxzPF8aqe5z/FF95fFYGKGFjgLUKYTJ+0/2S6um0
         OfE8Rt1Can4THkAR3ybJ3m6y0grV3Y3GsQckbZ5N13/PuuhM/1+Ch4zrmED9DZUJ5zP4
         PRWzusErdRn9vuHrNTTSfLPFat3TCU4b8JZXYx4Da8WJJ/LUD25wn7NNhax/wY3DpThr
         mdwA==
X-Gm-Message-State: ACrzQf2bnYBeZdwlXawOlhhzMa+PTete88AR/H+76hTYrHh/wLMxoYIl
        0cx/81hvU9A0Q3ACRdsa3TIHze58HwGLjQ==
X-Google-Smtp-Source: AMsMyM7vpjfX33dILu8qNaqc5n1BbH96itgwHDabXU+Ij2VuOKKiE16IajAdZueikamGnd7SDmb/Cw==
X-Received: by 2002:a63:6bc5:0:b0:460:bd9a:64b8 with SMTP id g188-20020a636bc5000000b00460bd9a64b8mr11602090pgc.257.1665451672807;
        Mon, 10 Oct 2022 18:27:52 -0700 (PDT)
Received: from localhost ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b0017f7819732dsm6761659plf.77.2022.10.10.18.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 18:27:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v1 21/25] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Tue, 11 Oct 2022 06:52:36 +0530
Message-Id: <20221011012240.3149-22-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011012240.3149-1-memxor@gmail.com>
References: <20221011012240.3149-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=memxor@gmail.com; h=from:subject; bh=tFCf3tJVkBAZyhOyS2quAeBLjHB9Y1CiaRgwLlzX79E=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjRMUbYK2VNUI+2pTeg4h0slbNpe2rQ0TQjT7G1InF WpVOPPSJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0TFGwAKCRBM4MiGSL8Ryic7D/ 423oGjRBWk7ZbYuFNITGhbC9wwTlO+T/mtLbDK6HiE8VybLXy4QMAH+InPGwa6usI/XC3Uzdvy+42d X3If6juPE7vKc/AvhRRkxvZdE7Fwy7vcGmeMDGOyi7geseFlEjbzpC4P+81shHCbQp0qwBAKgYutVi C4jtddRq5vnIynLqlZO6/BQi/4ZE6BOfppLZH+xcqgz0hRX6hsmp/17gsNqC+dZvmMKrR+93YjFpkK FnAE6gRVz+Dtph1P4OVn99e+h9W38Et0tvEVqT89K23FXQjCaH4tDrFJFNyXsldOhF7O2Bli9ZE+qW geXAV10lROvCKKNpjx10hl3zZwXeclAb6yF33p3LlNu0lhEs++Fd9Yq58WA0Bap+4zI9Qy21P8ntx5 j+k5ZJGAuYBU6baQFBOp820bsfX5IqRFNLPoCmrlFAAbaY0/GLHzKTM+kPahkUlXD+UhDCbYCNHoaX 5JfDTrAFTDrIgOkFa1tnQBODwe8P7D5Tgs8LKLEec+ItGd1cSBY11il4O6vM9DQ6TmwTl+tMjZEeNs +uoUkgiIfRTYYpL7Q3KwHAy+wIoP2NNJjYVABad3b98XfAFCrW3T2P1W56Opn1ZASpRTyYvJB+7WXR qzFL66xQqCtkU3jQe3KtQKDDKrmYI5ZQRA+ALtBRj7y7bIIi+/zNCNisqoDg==
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
hence make an exception for local kptrs while still keeping the warning
for other unintended cases that might creep in.

bpf_list_del{,tail} helpers return a local kptr with incremented offset
pointing to bpf_list_node field. The user is supposed to then obtain the
pointer to the entry using container_of after NULL checking it. The
current restrictions trigger a warning when doing the NULL checking.
Revisiting the reason, it is meant as an assertion which seems to
actually work and catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cda854715981..ee3b5b1be622 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10612,15 +10612,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
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

