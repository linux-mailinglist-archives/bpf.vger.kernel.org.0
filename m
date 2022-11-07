Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA24620363
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiKGXKi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiKGXKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E826481
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:32 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so11791896pjl.3
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=KgOT7Q9/WhcFpx7HmJQCURFKisq8GuHdB+gcUvUiBH8DeD/u1BC0rhrFgGZOSSELuy
         jLXZzyUsX4Z0OlGTswbRCvfKlaqAkmrJLx9PfmyrvL/uP1W7GCga9V8J+5N8fR5ZBc73
         tAhSznP6D+KFhlPyCWT4RTTG4Eo3hNHKz0zmow1Py3JjbMzQ/BgA09A37VDtGUlw+BZD
         n1ZpRuQC/0CGBUqDvLVAnNp9+T+5lqMuGKRoQ1UP/Lqlc4+XjoyBLlSMZPjUfEDsmoD+
         OpmZE0VhEIwhm4jugiV4fvDlA+GAgHNi9LqsaXoNNg/Iqd8F6dPGeWHSgc3JfPtEP/Ja
         MDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYvHeXAuVygr4ZcQHncrz4UIBOo5UsmMrsEx+4QLuhc=;
        b=0UnOM3g4pbmReRO0fa0LL22zOhbJ6MjLay/1T7iOs1TZ3C2U5q4WhJv+lDOcTc9YMS
         1OpLBcmPSZ7yMeE1KpoLOQWkcHoZQVrfF2L/KAHajgTIy6MxCLt09e5+uwzxYyrVoNtc
         F1H4JR0Hvqei1FsKhS46dgKO5iHVKFN5AuO8BA1uc4WC2wlmwZy5bcTA16J3C4oFZ9WI
         boopywiMPtuyvn1le7D5KWY3SYiUqYIzfnort6xLoAq7XoeKCg93JXpY4Jelau4QCoxL
         1xQl/qndBPwACqR9/zAqDRfBFx+cmvqpxgJ0z2AzGJRWgSDnsjj/+dYseyTXR9XMV7GO
         CxsA==
X-Gm-Message-State: ACrzQf2HpcJQrdgX66XPrQ+Kf8tpdhBBAYkfPY8zW3Z83Md7rN3hp4TE
        9QCF/hoO7ROacQF/qnUorYkmiPR/91j5cw==
X-Google-Smtp-Source: AMsMyM7j+ETxjKj9zo/dEf4RapWDjtEuoM4oYw/z5ZS2H+XrLRmPG8lAvel1GnxZm7Hkgbu0tpmGPw==
X-Received: by 2002:a17:90a:8a16:b0:213:bc0c:74cd with SMTP id w22-20020a17090a8a1600b00213bc0c74cdmr48425600pjn.28.1667862631949;
        Mon, 07 Nov 2022 15:10:31 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id x190-20020a6231c7000000b0056bbebbcafbsm5030954pfx.100.2022.11.07.15.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:31 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 11/25] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Tue,  8 Nov 2022 04:39:36 +0530
Message-Id: <20221107230950.7117-12-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=memxor@gmail.com; h=from:subject; bh=vEeT2/iSWZHC3KMjxfZP18u7ktP/IseF8QZTy1MJn24=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+2Hwor9e+vDGcaQsSs/hJmvUZYJzEVob7xslb7 HsZAtuOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8Rym53D/ 9qlYUDJT1wnzaBE+mzYdRvr3Vrqic+Flle5d8c5gvvBL8zG131Q5J94G7w4guPFVhd7PbnJ7kEX6Xm Ub8pyKdJPACZyyz1j7K8OcKn26SPlqIrG91HIYVBaUKGxkNTPYkeJRJ4GRluScvFCdEBa6ghMm4I95 4oO2rIyPq4Umf0gBM50n8tkYBgWXp7l3YhybUUPfXxBz9ixn9Y1GAYqt9m4EZgAC224F9FnJe1bham LnEEh7o3DqAfR8RBJNalM+J3P+YZf9QCbvFXZQS1fZZlYde2+EsTC/v8qVEw/jJODqMGFpZ6TKj3ce b05I5Yo5XmgsnxSgEbWXsqhm0seaZ1ni05tWSw0kRvyZa7Vg/VprxjXNzgddOHOjjuoRhkqnPyxnah kATuejJsz38ytwGCSsx8mvLTodEglaF4P7M3QBeqSa87deP+dIoJy7DJg+vw0C2upwmBpbtIe+M7Q0 492/KVPMESi5tm917rNYl6oNG+GOB1MvkyiPURuBBjIeaJjSmb5+dawwExpRSuJpoYdDjSUft+Yszh amxAZCNl+jWwN6hyiZEfLO0V5pG5p57hMw7ATWHCQpOAsvhrc5QsuQIq445qLk3J3n6pgA1i4vRWT+ xB9ApQhQ9+m6S/TaW0MFxdWHrr0m7MpULQg8aYo87J20HX6T1kBPJ0ASnnKA==
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

There is no need to restrict users from locking bpf_spin_lock in map
values of inner maps. Each inner map lookup gets a unique reg->id
assigned to the returned PTR_TO_MAP_VALUE which will be preserved after
the NULL check. Distinct lookups into different inner map get unique
IDs, and distinct lookups into same inner map also get unique IDs.

Hence, lift the restriction by removing the check return -ENOTSUPP in
map_in_map.c. Later commits will add comprehensive test cases to ensure
that invalid cases are rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/map_in_map.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 8ca0cca39d49..f31893a123a2 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -29,11 +29,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		fdput(f);
-		return ERR_PTR(-ENOTSUPP);
-	}
-
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops)
-- 
2.38.1

