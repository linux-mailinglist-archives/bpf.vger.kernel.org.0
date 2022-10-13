Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D445FD4AC
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJMGXZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 02:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMGXY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 02:23:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0A125033
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:22 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so1069661pjo.4
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 23:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iynB/tzG+IhB0+dH46SjaWSl87CIgpxLyW2rshmjGVI=;
        b=IFZCsBzBg0Ehjde6AngoNtvD1c266uWYccx+AgJnIRibcmh91PgE5Iq9jU7gDS/k1T
         qP1GUFvCAxDU3xiksSFwp/Ile+BpSRRXhGpG9I1HNyamvUyTXKPIZtPS3FCrhKTmgnAq
         VTRVc8tFkOYMihzvHKPdK7qkzxN4sgx9rvg3kOjeoANta8EEDBUwQAb4XYiMy/mcUK7V
         wjRgoA/cLMcoFyqswWfEP2g97Fd9pdPOulT9qJ+Vwc3yJIGJbZZjXvoiITU4a974isuD
         FY/RaYLpmAmUrdt4idcyV9J2QG5zk7I7x//sOs8z+Vf5/oRtCOH3rKDM4exiU+d0/awZ
         SIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iynB/tzG+IhB0+dH46SjaWSl87CIgpxLyW2rshmjGVI=;
        b=4O7W61Z6oYoBkHZO/lKEX9FJynDUWy/KbDb+K5VnmnlJ1+aj0ttpLwk0hMl5x56wWv
         hH+GqpfdJ2rFW6ZQ6WBm2puExLgOY3owG87NrHA06pL7TG8YoddoIJ8263AHeZM+4Ro7
         3noztMYVnLQy07x3VAsPgtf3zMlFBJ+j5ZM5fDK75lVXh24nfMe4//syOwuB6o8lGdLl
         KEVYL43GFJXbrr9QVqJvJZWIgSXgsn+gnB5g1GqZc5vZhC/CB1eCYYmvkDL6KkhRFvkz
         gJFu2b88yKQmIHjUfXMZLl+Jc9PUDgQL0fm32Ek5nKA11uOiP3v2rM4Q7+PkeCxo942s
         l2OQ==
X-Gm-Message-State: ACrzQf0tp4eISv5YADLthwl/s9ZYv7QENkbby/JEG9kQrwouYYhtiFsf
        /H3miQiK3df4zQLLvfK3dzneD3+bB3k=
X-Google-Smtp-Source: AMsMyM4641LCJhRXs9a24h6LLSz3cVo576A0bc17YZJ+AV4KKn6aVT4q/A1luQCqRg3Nw7X8QvUy5A==
X-Received: by 2002:a17:902:ce0c:b0:185:36ce:abb6 with SMTP id k12-20020a170902ce0c00b0018536ceabb6mr1633430plg.149.1665642201702;
        Wed, 12 Oct 2022 23:23:21 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id c13-20020a634e0d000000b0042c0ffa0e62sm10644236pgb.47.2022.10.12.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 23:23:21 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v2 02/25] bpf: Allow specifying volatile type modifier for kptrs
Date:   Thu, 13 Oct 2022 11:52:40 +0530
Message-Id: <20221013062303.896469-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013062303.896469-1-memxor@gmail.com>
References: <20221013062303.896469-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=6SUeyuyfZf//MiX/9s7h5HH7OdhEj4ml6JnfXAgYBbY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjR67C8mT9U+PHPqdMSwsIgk2iUjJA2AVz+6qhspMm 2pPPK9KJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY0euwgAKCRBM4MiGSL8RynbTEA DBZlDObFetoUIi9zAsrPRVgm6KfU+TJtT0D3o9q5ks4UHAcXH/cDEsoXA1ZQTvqDaHiYCDy441/n/n OGezEnMJRSZRBec6sstZT5fdLjaYzbNXwGOZ5AntXco6SZuGT9tKtdIxcNbVz9s+0H43Q20IsMoJGB BfrsPOFA6PoB7j6vIYYURLaaGFVG41Qbn0zu3p09R+nztiCJlAP3sfjPlpT2EXxH95wOwM5iDs8nAs Q4tOgdaE2wxd6KWA92ueBQFEwpjHbfmmHs+wpebcBzNjL/0mFruni78/0RpBP5L8Znim2+tBBmF135 PVMVNMNoz/N0zCTy8qvwamgPbPmSMzq/Ez38ogGaOZtSjfb1bFegXDTRPrGfnV2W8hI85CJ1oBpBCH d0dnnB5IAZVPfZEcE2L8SjLl4c8Ec8yI7uZY5Bqc9gjlTtfhUs3zhqqZhQttt9IMZMEACxaEnYFGu3 GbkLJLQHPUf3N+2/eWasctdAPTefrfftf6bxl+LKzLKIx3EDHU0UDa/UmEx/7mo9puqFGpAbOndPa8 OjGoguiG+YHn//0br9ZrQ7jT9ac0tlii4tGSex5MIFzNJIIGQX/glAp/o2Tq50q4v3FCQcIqQvRC2y 8sKAI4XPwxd/0jbbzdYO9rFOEH77KNh9SaOOaAWb79PotyLw8RWUd25uwTnw==
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

This is useful in particular to mark the pointer as volatile, so that
compiler treats each load and store to the field as a volatile access.
The alternative is having to define and use READ_ONCE and WRITE_ONCE in
the BPF program.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h | 5 +++++
 kernel/bpf/btf.c    | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9aababc5d78..86aad9b2ce02 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -288,6 +288,11 @@ static inline bool btf_type_is_typedef(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_TYPEDEF;
 }
 
+static inline bool btf_type_is_volatile(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_VOLATILE;
+}
+
 static inline bool btf_type_is_func(const struct btf_type *t)
 {
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FUNC;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..ad301e78f7ee 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3225,6 +3225,9 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 	enum bpf_kptr_type type;
 	u32 res_id;
 
+	/* Permit modifiers on the pointer itself */
+	if (btf_type_is_volatile(t))
+		t = btf_type_by_id(btf, t->type);
 	/* For PTR, sz is always == 8 */
 	if (!btf_type_is_ptr(t))
 		return BTF_FIELD_IGNORE;
-- 
2.38.0

