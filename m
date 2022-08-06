Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6528B58B347
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 03:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiHFBqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHFBqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 21:46:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513620B
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 18:46:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z16so4907234wrh.12
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=px2sdusQetra1BE/Kd6aNLvKp4pABd/kjbgidw4Gjks=;
        b=mZV36IF1M/bIiX3V9oEbRkT6+ZXCQAYIhTgK7XkBLfcqSI70Q4ycaPv4YjtfAO9rtQ
         Nm1AWZx8xL2apoBV0/5COPosdLU16KKvHzZIcLR0OtUYAq5Fkc9i8J8HZyk1n/VYC5zV
         +xX/nBUQFzAV9iGlSGkIi4GCSoP4O9kKpu+/1y6TMnMUXgIc36Ix7WxG8E23z6QxidCu
         YZn9dfbwA80GejXZCTSyZtBi5sh1vRm+nvoz2wZ4KMZqfI8tKJ8bczbP7H67C/xCg9Lb
         Oc7RF+SEzlD5VtXKgoFyRzsGDoEsrdH3gs4XLzbIk0MX4+cQEiIwNkhM18uhdxzUpo9r
         6h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=px2sdusQetra1BE/Kd6aNLvKp4pABd/kjbgidw4Gjks=;
        b=VwVfJMI/HZcjS/Z2cEfxI8q8EF/d9LydIz3qB7ccD4wNNCoOjQjTrH5G0IRrihAKX1
         ohjbLzk8Q3c//FX4ODTlqRXqGS1ZcsBTQH/iSpV8BJ+fOP6kxRytAOCXyOOqIn9FgEci
         enqCiNeTuSQg2wkkDRRCQ0eFStbPV6dd+Ja79IHfT1y7+mKynYnYLoTUJC8j+p3vixHu
         dFZcd0gT/6pGttaR9ZCsYXh0i/qRxpn3uo8HTm6IMnuGIB3wPeyrhHhGlwaBTikWB44e
         EO9AeNoJTG8kT/rb4X0FOzGASYjbaePFPqDtUcXlmbejpzjFbEcfrH3pXrwSMUyPiwvZ
         MW3A==
X-Gm-Message-State: ACgBeo1g+aYCGBRTAotQf4oS8YtPHM0L/knECO6wZ2N/HQfl0JNsalHj
        oxe570IunFgmgAYNbdjOGXYIAW4WBF4=
X-Google-Smtp-Source: AA6agR4kzXXMD/l1fOvq4U9EYm9dePIbk4br12vcVEfk1FueRgcY+9UyiPB8Tobpw1fTw6BesfmhDw==
X-Received: by 2002:a5d:67c1:0:b0:220:7079:78ef with SMTP id n1-20020a5d67c1000000b00220707978efmr5707365wrw.264.1659750369401;
        Fri, 05 Aug 2022 18:46:09 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003a501ad8648sm6512770wmq.40.2022.08.05.18.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 18:46:08 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 2/3] bpf: Don't reinit map value in prealloc_lru_pop
Date:   Sat,  6 Aug 2022 03:46:02 +0200
Message-Id: <20220806014603.1771-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220806014603.1771-1-memxor@gmail.com>
References: <20220806014603.1771-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=memxor@gmail.com; h=from:subject; bh=MHKdHHusG/qo6mzxYxPwmqWOiQY6Z/3gwdT2miImhlw=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi7cfJ/+R0kgrOAnUcxhHBDF38yBHgeC9NNwm92kHk pFuhIsmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYu3HyQAKCRBM4MiGSL8RygetEA DBf2BYiTCnGPdg/2awsfLls6gWj/5X9i2iczRnp8Q4xJ6b1NuhUQQnfpxL2FdfKcrW5smGn6/19DcM zVBF2KpUwnlHwGBZdZPesMeXT3YzyPqUQWre8zsKoKbV141f3wzBIeB5gm62H4Jw5FXGd97QtjhQoa hFM5+QHVgRn+nELDA+A4N03l53831unMdkE3yddykFkOdKOeboy7habpvnv95I8OPLjAGXG9wMav1D 4rYU88YbWrAplfU92JvVk0mw9lKLIGa1xVPNJMjQ7dWr4s3yM6wMnF/ckm1X9pgzEmJ2tX65y66D2z IaU8RyOrLfLmHD7dnKZcCoU2+DG9cGOotT2LI91dzeVDLFAGz89CFjCqsbTMe9psIOzqC/EhHIZ0Hn egUETGVpQZx2xovvWCjm5ST5rsEJkjItgGZtq3XKWkkvyQYD5XU7JZuNnt7CwsjoAkNV3Erjir7zkr zTDlaSdZhXgDnce6XSpYn/4RHAf+3atkkY1str+356mWD6BEzX7Q6eOkPLg5GBV7Ti7TOeXvcZfqRb rz6fcih870ZJLBVascGTDYxSGBgUyQQHnFaWj9R4v7Q9L81VMmFx75SEGslNGcYUomsDOL1rXBBOdq PvbCT9tJB3B21rE3s4kFiRVoyohGd2HW4q6Fq5USYYtoM+GU3dwVoz6IVF3A==
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

The LRU map that is preallocated may have its elements reused while
another program holds a pointer to it from bpf_map_lookup_elem. Hence,
only check_and_free_fields is appropriate when the element is being
deleted, as it ensures proper synchronization against concurrent access
of the map value. After that, we cannot call check_and_init_map_value
again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
they can be concurrently accessed from a BPF program.

Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index da7578426a46..4d793a92301b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -311,12 +311,8 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_htab *htab, void *key,
 	struct htab_elem *l;
 
 	if (node) {
-		u32 key_size = htab->map.key_size;
-
 		l = container_of(node, struct htab_elem, lru_node);
-		memcpy(l->key, key, key_size);
-		check_and_init_map_value(&htab->map,
-					 l->key + round_up(key_size, 8));
+		memcpy(l->key, key, htab->map.key_size);
 		return l;
 	}
 
-- 
2.34.1

