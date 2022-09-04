Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C555AC665
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIDUl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiIDUlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859F2CDFA
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id fc24so4453210ejc.3
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=41J2Bhw1d2PoLlzpMJcqsDlE2bj/Dbn02avQOpVjma8=;
        b=haDXrdeZvan9cpncEWCS4nOY+yt78isgG+rJKIuP6MfoUNYFv5wvoaA0g/J1MSbNpM
         nNwDBBog7yZRnLIrHuwCWnF+NdfwFx9GoeAb44n7h+G0rczSWQdtj+qQKvjSD3WiD0pQ
         ItzD3hdQZohkJqvqfebtKDcvxRyQ45fT6h3ICGKRECpEfsb/Rb0kH8lnLuO4gA8CG5Py
         a2pJP2kwIgOly7tf+DPxAGwEArRDJYh8XsRAK/vm+chzv+wFvqns32XyBvK6jH69Lf7y
         XFiRR1drISls0GMXuX4JMPqbU9UGjLFFoyc4l2eM3xthkePwtpKHDJkxGEi4XV67OkWo
         anOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=41J2Bhw1d2PoLlzpMJcqsDlE2bj/Dbn02avQOpVjma8=;
        b=fzHxyTWR+iXBRO83b7EMfA1tlMqLGL/RtaklPqZgPM0wL/lT15Dz1yIkR5pSUqgV2l
         tC82W/gTXB7no8Q+TQOUKs29OTdnXw675xWdO4VtpUEhIz2VUwNY3Cqn4LXcRGc5EDjN
         uHIb2dtJkyOV6SG2QFX1twHXlDyYr0qWz2W7+8/fPUzyCjBD69Gl7yy+IXNlLzv9spRH
         NnGO5UTg0Gi7KO4O+OYC8iGgNanC6Hf5HlEwhCUq9mourq8fwROKmp1Px5ZLmJ2zaCGD
         QozMRBkvgLEmWIQHojJHQgT9dADPxexadjYtKduIjmr5epVFIXgZm4IpsOkHR8DgUpmH
         ChDg==
X-Gm-Message-State: ACgBeo15FP9Vb9M3UXrVpQ7n/qbMAG/1eXWgpHedGrLzx2DrzoGteZhR
        8/qU/CMe/ESpvt2vZGBbIkkZBFREEikmOw==
X-Google-Smtp-Source: AA6agR5/Zzyrx0n5QWQxrqmqHBQYxvnX3WX1bZ+YACR8gvWUD7ePMoc69jIaDM0Dh9PYPFjZ8x7rWw==
X-Received: by 2002:a17:907:7630:b0:73d:d749:975b with SMTP id jy16-20020a170907763000b0073dd749975bmr32406316ejc.632.1662324112519;
        Sun, 04 Sep 2022 13:41:52 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906300a00b00738795e7d9bsm4112207ejz.2.2022.09.04.13.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 03/32] bpf: Add zero_map_value to zero map value with special fields
Date:   Sun,  4 Sep 2022 22:41:16 +0200
Message-Id: <20220904204145.3089-4-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=memxor@gmail.com; h=from:subject; bh=8lYhH7/GyJKxztZBQ6V4l3x0d0yaWHKbPgjXFxfuGnU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1vfCz/ukTyxbJ8L7URi/5WRmIySkZcSGwjquvT zWapmlOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8RyqgVD/ 9vRXcgd0OxJWz7kFg2bEvjmnYJdDMPgo4Xa1LYH7orLq3lZYhoI7CieeyOLCSvaJLNCsCsklJMgEj1 dDjVhPZ0chaepuOXHngsGQ3dZWBw+m93WyLMECV3arzj+iyC6piPLisHfPdAfAd7nckYzLagMNyAXV CI/C6Iy8W4m+9pJf6GjWLQ2wTdH0g7biYY5CQkVW+TsrlEPwUpul0ofEvTOS0smVxZsHEcpN3WV8b8 pteFlcOGbNpO0Ebz0Ly5qFyjxFK5JR+ngRtZv+K+bkGDTHUV67QK2DpaNMryQBfBMJbppjZRYu38lW kuwMG6/JIi2vD27BQ2DCZhq+qA3MeATFk52KfstP5FV/iEk2appfwXXUbdW//WdJBozivCBqedu5nS 6Vw0Jktb7Ez17/dcEcGfLpjHpsVis7OI69r57/jbzBrIjNatbOxV2fsJW0LWU59qD7JQzN2LOElA/3 AF1K6GazXwW3gRO1RG32ckNr/xmM7tEuGszQVqpwyXpzcgh/jiRroCMUU9bjDCDU3M9Zf0GCxqjTaP Gi6/1iZOuQ5Qu3kZ0YKqdRrxRDhckeUp1yr2k3eTyHFDB8rMt/dkGR7jMh1WKr8HyneRX6iJhEuggC P71yZ1GDv2Eylox+IEIA7mkL64TxLj0BMmezsZW/InGcxC/tutUP4D5/62iA==
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

We need this helper to skip over special fields (bpf_spin_lock,
bpf_timer, kptrs) while zeroing a map value. Use the same logic as
copy_map_value but memset instead of memcpy.

Currently, the code zeroing map value memory does not have to deal with
special fields, hence this is a prerequisite for introducing such
support.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a6a0c0025b46..cdc0a8c1b1d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -329,6 +329,25 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 	__copy_map_value(map, dst, src, true);
 }
 
+static inline void zero_map_value(struct bpf_map *map, void *dst)
+{
+	u32 curr_off = 0;
+	int i;
+
+	if (likely(!map->off_arr)) {
+		memset(dst, 0, map->value_size);
+		return;
+	}
+
+	for (i = 0; i < map->off_arr->cnt; i++) {
+		u32 next_off = map->off_arr->field_off[i];
+
+		memset(dst + curr_off, 0, next_off - curr_off);
+		curr_off += map->off_arr->field_sz[i];
+	}
+	memset(dst + curr_off, 0, map->value_size - curr_off);
+}
+
 void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
-- 
2.34.1

