Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432B62E8CF
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiKQW4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiKQWz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:55:58 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227BE6454C
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:55 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id u6-20020a17090a5e4600b0021881a8d264so1056865pji.4
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI0cSLMpOLZbEZfTLKGuck/t/mpojqsult6wbsm/RSE=;
        b=BLz3MumpGVit8d3jGVSUkxlczr/6dJ09pCifGtXOCYHGWetNHaHG3pkaRSo09RAdoU
         qPhACvjNK+BOC/+J5P9At6XQjt6Nu3y7amm1fwAcZ4OmZrDtaxJKTMc0S5R1+UcLRarw
         71SX3xjeq4V7cYdZsA52BZk0bgjVteZOA62EmZaAv6TmHGebp2dcScUQEvXsPe7fX3mp
         19C2ppVHykLO5rnIr1ZIp9SeFn5/fjVq37NnlIV8EhnQqPOboFpDejIRjqWe0HhxFWMz
         0O1PzOCMqIhlzlpGqDXuB+/J+WNhwzbQgogyuGPUTvOemKO9aunQ7GSOTl9TLlfZ19jd
         6LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI0cSLMpOLZbEZfTLKGuck/t/mpojqsult6wbsm/RSE=;
        b=iQiGAlqFrx856ulOQBS3ji9I8399HKMyukSrmPIcgnMY98kMcYclccMiesnkLzoJhc
         CkSDFdwYjuZrQfSPPhmq8b0tTlUL49GAVTgrm4IA2tTw476U+u0CyYkrrwkG2H9BDDYw
         zKfeQVMTY7yyejSl8uwFjsinbcQAw4Xg/P+8asr4YsjBmVfs1+ys1DHvt5KZjy8RG9BY
         3nxKeHkW9jsCsqY7Mh+X49Kqlz3RamA/EUncEY6/Xz8rPwJCgDtQdLbN6Pj7AZf5At6Q
         TFXHbOcY76FhPk7wRGf6h2FC6GSd8iQn7y18/2eRr01T1W53SiZxU0K+NWBKKNIlsQq8
         uuaw==
X-Gm-Message-State: ANoB5plkICF7Yaadb4sQUh5Lv4/k3rH5HE9RsxK2krZxszik36dX27RU
        7AzHMgQHQgUX9GzTiwBOyaIMeBwtOlM=
X-Google-Smtp-Source: AA0mqf5KxXtXVFD394Hs2dRIiPE4iHqdVdV5ACkhhAsAN7DCsbxyZb+vozzxZQ/dqd3b2rup+fNGYQ==
X-Received: by 2002:a17:902:f152:b0:188:5581:c8de with SMTP id d18-20020a170902f15200b001885581c8demr4654998plb.140.1668725754453;
        Thu, 17 Nov 2022 14:55:54 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b0018863e1bd3csm1950283plg.134.2022.11.17.14.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:55:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 10/23] bpf: Allow locking bpf_spin_lock in inner map values
Date:   Fri, 18 Nov 2022 04:24:57 +0530
Message-Id: <20221117225510.1676785-11-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=memxor@gmail.com; h=from:subject; bh=P1undU+At1PLzL1SYYwDyVj3bpoUrN/Ux1z3PCPdpx8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkbGd5ei57JxekHdh/Q140Pjn7yTFd8i7NCFmoN wsh9V0OJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5GwAKCRBM4MiGSL8RysreD/ 9EXKsZB3mpmw8EBsET/tFVYFh5E0d5y4kb2NNDa+XKCuq6mwarT93wCe7UEn1UNXykML7TUWp0o9S0 WHkLHPuvEoYftCaoytG+cw8VzQCT413u6EMf8HkRFWweRWpm7plvM2EPxiYjfF6dm4z+uJ+oWSOGl4 mQ8hWINLVPmFDx6cGIAFkKSh4ZvTD3L+e9jDtzzYF20YNA0/D4f3YaV3skfHu0WTkzTlJIDlyX06R7 vhxBTMOnNhpqUSS+sXc1OTFHFUuUAiUob8V9DSYprWtjNDtAOdgf2+BspLivx8kq4KTLwdBQNB0/T1 NIsu6MUQ9SDks4lYxD0kgX6FBrsurClX0qcPGnq4NNvXFXoD7wagm9D7/2KPOKQpaZGYJ1B8wUNNoY CLR/aUVpCGnRsjcQsXRqX2wPLTjNfPlIBBe1WZto9AK+Xxh3CIguzrAyE9UCt6XA3S8c/9T3XYVNLg oPvcmHb6HNK+Agc8jSltZxxS1tPFQ9CAk6munnomv+RGvs1d2q+bqVXn7u0Y2lUBhcgpAAaUgS9DZh X7HiD+tZfCmRL/nmelwqSKyVtdvW7M5E5YdkCBUc2HmdunN07dfnyeuZ2Cu8ygozd4KIq7pbaQHHQI ma/e6dkRU0lsEk1IEjOS0uhJQIXrBkEdrykMxyEvUyQnrxoN1Lmm5XBIUcHw==
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
index fae6a6c33e2d..7cce2047c6ef 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -30,11 +30,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		goto put;
 	}
 
-	if (btf_record_has_field(inner_map->record, BPF_SPIN_LOCK)) {
-		ret = -ENOTSUPP;
-		goto put;
-	}
-
 	inner_map_meta_size = sizeof(*inner_map_meta);
 	/* In some cases verifier needs to access beyond just base map. */
 	if (inner_map->ops == &array_map_ops)
-- 
2.38.1

