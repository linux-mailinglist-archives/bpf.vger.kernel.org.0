Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D040D5FD4AF
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJMGXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJMGXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EB120BF2
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 3so1090871pfw.4
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDYhgUZwgh/xcR2tLGyYyMKgJ/P8pYlMedK+snEP8qY=;
        b=nPXLFPkPEQ/7aDktEuzzXa6//sYWCHzposYVlNC5h8JhVDTi/haV7edChYPiwftgok
         bjQz2llNb1mZnpk+9QnTzW/MGiNHMZQsULjARyqUEay/lISKB5IwRp+0Q3iNXnUBmB+c
         si+4Ubw/6brCZ/nODlayrkY81S/o8ENKETqQ+xg8yMeOvFTa/cs3TbFLfAUGjw+Du+T+
         kbn9E6CycH5FK2vmddtFJOQZGw82Ybs3SL2GunpInl92RfM8lxt0tnEln7S4PsuucGd/
         dM3jHIbTjS9+dEXQHFcIn0ZG1tX2uRr+GQL/PjahlBvP22RTq06ITghf9GbxWEfOv+EV
         IFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDYhgUZwgh/xcR2tLGyYyMKgJ/P8pYlMedK+snEP8qY=;
        b=1Nk8dMpL8EFLTxdsOXan5cHZ/1vN4eg4Cep8oCZeqf8Ck1OW2dsAUsEZ5UW6QJMk3Q
         lB6vzOz4ata96saqx5PdZUmUSHjfc6U4Z+kSJHsqj/7CZJsDkQ9+mzyvnxpbfqWUqLW/
         F1BLjqiDQ687Peq8fh5zcROvf9jR/DzxZy2c5fgjnnHvee5cOAG4JUWk6zxxmLh+EIsg
         yYerHMIi9jCi5+UPOwy9qyJtrIfSETO5kMRwt44Ki5dLGFRPFsZKmrhSnntwvjY+VU+2
         hSErA5xmZLcqpyskDOjMqKdSgYN0KoWQFGp375d5ZiDeKpxmqCtX3a817nqNIgcTPaUO
         ZfoA==
X-Gm-Message-State: ACrzQf0UTafM4xUPvk4+OLGZR6SxLfxtvnEgcMAF6azvvqNxwEXIJ7iZ
        lTUZ+jHsfz3MC0830g6WvstGBDmLHsI=
X-Google-Smtp-Source: AMsMyM5gBHQIJ/K6K8VqxE9IKklS2q5UrVqL7LKqw53LjD3NvF472HlafF9A2vGPnZv8k6/Ptutfaw==
X-Received: by 2002:a63:4507:0:b0:43c:9cf4:f1d6 with SMTP id s7-20020a634507000000b0043c9cf4f1d6mr29766434pga.316.1665642212942;
        Wed, 12 Oct 2022 23:23:32 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b00176dd41320dsm11855576plh.119.2022.10.12.23.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:32 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 05/25] bpf: Drop reg_type_may_be_refcounted_or_null
Date:   Thu, 13 Oct 2022 11:52:43 +0530
Message-Id: <20221013062303.896469-6-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=memxor@gmail.com; h=from:subject; bh=mPKR6AX81mePcKInsG+whkH7f0NNvO1Kix+OwJVl2aU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67Dl1J9c1X3O89rwWbgwCmAytO1gDZt+b7KTbDn nJBV0UmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwwAKCRBM4MiGSL8RynHyEA CZFIfhUXSYcC93FsVCZSF34hqXyY5aHk6Nat/WTJO97U1v0vUK6N/8cllM9ws5bowXFciI7OQu5ozG yUxylAUr7HlpSzpr7aSGReZUOE3btYaAfupWi/XQOQ3K2e1BZYrD5KGiEReOsV98lz5Mh4fz58wGU8 2xncUzTs569fNBLZO1veFjxDWuY3Y8ytXWj0YKXUsNzODQrP5xH/0LAWsNGdue579dRZWn1B57P28E +HYCmN8lutEHSh4Yxu6lQhs69DH6p2WO4cJpTOq8IwNiz7NOeH4eokiqEOPta6VMHiN6dFkEAngUZg WeQqm09vTOS5YV1iX7ZPB6yk+dC6E3Ao7KsyNqTNfkTswlucISbFjGUo0SOfIDTA8shsdf5l6rWxz8 OJDz5yGHZd3ohgD01WWFyh6DpAZpzXPhvjfqDyjxkx/J675UKVd/Q56LfrQ5jgg7LmINSMLO83BLkH G4ctVia52pimBfIIx2ULri1EjmRrRypD6/C4CCwPVcO3TZtbNE4y9AZpVFy+7iY69yPQEiZEK9yssS 4RyMDO8NDPL+IXo8wqZeGbeuBkuIax6UkzqCV1/iMTwloQ6hDHeP8upNfARXt5p9MOM7V8R5CejhfI eTOuRawfoESL2H/jUt5/SZCihHU/nyvk68Iqg1UJeAhlmKaVYNQ5Tb4JewTQ==
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

It is not scalable to maintain a list of types that can have non-zero
ref_obj_id. It is never set for scalars anyway, so just remove the
conditional on register types and print it whenever it is non-zero.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bbbd44b0fd6f..c96419cf7033 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -457,13 +457,6 @@ static bool reg_may_point_to_spin_lock(const struct bpf_reg_state *reg)
 		map_value_has_spin_lock(reg->map_ptr);
 }
 
-static bool reg_type_may_be_refcounted_or_null(enum bpf_reg_type type)
-{
-	type = base_type(type);
-	return type == PTR_TO_SOCKET || type == PTR_TO_TCP_SOCK ||
-		type == PTR_TO_MEM || type == PTR_TO_BTF_ID;
-}
-
 static bool type_is_rdonly_mem(u32 type)
 {
 	return type & MEM_RDONLY;
@@ -875,7 +868,7 @@ static void print_verifier_state(struct bpf_verifier_env *env,
 
 			if (reg->id)
 				verbose_a("id=%d", reg->id);
-			if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
+			if (reg->ref_obj_id)
 				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
 			if (t != SCALAR_VALUE)
 				verbose_a("off=%d", reg->off);
-- 
2.38.0

