Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD3628900
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKNTQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiKNTP7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:15:59 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5426553
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:15:58 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b11so11230927pjp.2
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=RMmxbFDcKLe95zYZ89a1bXqebNK2GuRnttLD5IzGPsjKmYI1z93GLOMjecBnzMKsfy
         uDeCHfK3ubuQYVvHSWt7LAClp+ZWswkTj4T1jszBcSuRv7jwXf5lWoqdvj+Y5rTTFqlE
         6GUCjVCI9nGH6lBYKOorW4ZMTbqhBL+RH3HrklBv4klXCtw2UIk5N63wCBLgAJ/jTBhK
         dGXnf1ixWxx5PnNYtNFzI1b9KatgV+4KBkozVHTDiIawvvvKpPKdS0CtRJZ86VBcvS+F
         DT3FYr2HoasAddgGvYC76Pj05YPRHOqoaSFvEaXAJExhbVuJZCg/e9n83+3BFkhabBcp
         m/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnrYmyFxoGEM6OlddgT2gVaTsDC543yW1/JtZQJqlOM=;
        b=liTTW/2O4bpCesD1rzcpUYlii47klJdpfkvEtuJVW1Jumph+xOZxSEA3kQdfU0kCFT
         EGPUrT3A52k5yN+kJowdSBxw9cjs/0yKQesLlSAZrcMUrBQZP16tBZCEuWUYn3ZfMVQB
         lfIEUyZgQIFnGPXy7X4xWCgrZl1u7rgfX4jHTWs8FiyIE0aL46nnTMWkCKhAaKE+znYr
         KAuvT8xvZyWIIT6KcV3qNxHmhjpxFH2uo7uY/whV2K/8nNrFR+nWkPo7QIY11BdqdJN2
         QFzE36Z2zBm9nUXzgBnvNFo8mAknJqS8oSaWrp4qVOxcV0VRHBcEk3TXNR5ZPb9J6IlT
         5xXA==
X-Gm-Message-State: ANoB5pkt6Yj1hPpqSG9S9yV85qd41Ut3r6sFy2xCjiE52K9dxHrbWCo/
        /wrMg+YqfTFuUtSI5PeebOBaLD8yakWskw==
X-Google-Smtp-Source: AA0mqf6WQzHzei6kOn5uWPY/U0c2mqCgKMAtcV7P/4SnYdZygXPhdV2r64oKIwHvjHJmN537heYCzQ==
X-Received: by 2002:a17:903:40d0:b0:182:2589:db21 with SMTP id t16-20020a17090340d000b001822589db21mr553055pld.151.1668453357623;
        Mon, 14 Nov 2022 11:15:57 -0800 (PST)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001869581f7ecsm7848033pli.116.2022.11.14.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:15:57 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v7 02/26] bpf: Remove BPF_MAP_OFF_ARR_MAX
Date:   Tue, 15 Nov 2022 00:45:23 +0530
Message-Id: <20221114191547.1694267-3-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114191547.1694267-1-memxor@gmail.com>
References: <20221114191547.1694267-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=memxor@gmail.com; h=from:subject; bh=ZTLueoxLQrjQVPDjxfufu3gtMYHhhFj4zDRgWCv34xw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjcpPIKwPAD2afMKABKxB3GU1fQw0uIn5UXRBoG2Y8 3eCPBMaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3KTyAAKCRBM4MiGSL8RytwED/ 9UqAFViECziopPmeJJszU93PTw97fMuLmIGTeDOeDgo9Elx+jW1lAR26suKgCZh7s2FkNuOt1QvMVg y4zMB/YgZq8qKFAF4576MwPPQZ/9RL07TL4PErV/aug2edI+OM6xKPMSa50yxo0qgeICa5aeWCC9Mu 6HWKhB7dsNuZg6qwg9fHvhmmStpPTCfZ8wW0rh4kgL/C5cDYxccszBncR5LkKr9yktAm67A9uLZW92 7eAj9OlHr6Nqd/zZeMGbIoPbw/ieWjsLz+marxtTtVvYu1xUAuBIefHY8JNtIThvUghpRsftbpCI4Q HhyoICMwEgobSEICtt8Da7Tpxb1+ZrAMzXwctwV43Fsrm+AoKUaQa7P6Z296tI//dj0MtX4364+9tT 8Op6CUY1maHIsnXmdvfAvLguYmaq2ejY/WG55V4kE6mdqxC4hRQvdtkxYoyn7gvrdp8/0ctiYYiIQQ gehQy7oyvzGFW88Kv6jQ0MpErE/usW8IJFNpLXWuZC7vz4fKlUB9gvTULJSddNxIsXPm3lHlmf8p5L NxVQoSVUHI5ToYsQwl3r+fMenhXx0grZ494vS5asrFSpueh916U1w4LXl8Q+B11TjAhRX2YJFeoi98 FK0jMFtZBr+DbBe25z7UFLxmDmXo8z7VXtrOiqCjJZhKbH8WUnEGG2qpQyow==
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

In f71b2f64177a ("bpf: Refactor map->off_arr handling"), map->off_arr
was refactored to be btf_field_offs. The number of field offsets is
equal to maximum possible fields limited by BTF_FIELDS_MAX. Hence, reuse
BTF_FIELDS_MAX as spin_lock and timer no longer are to be handled
specially for offset sorting, fix the comment, and remove incorrect
WARN_ON as its rec->cnt can never exceed this value. The reason to keep
separate constant was the it was always more 2 more than total kptrs.
This is no longer the case.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 9 ++++-----
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..1a66a1df1af1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -165,9 +165,8 @@ struct bpf_map_ops {
 };
 
 enum {
-	/* Support at most 8 pointers in a BTF type */
-	BTF_FIELDS_MAX	      = 10,
-	BPF_MAP_OFF_ARR_MAX   = BTF_FIELDS_MAX,
+	/* Support at most 10 fields in a BTF type */
+	BTF_FIELDS_MAX	   = 10,
 };
 
 enum btf_field_type {
@@ -203,8 +202,8 @@ struct btf_record {
 
 struct btf_field_offs {
 	u32 cnt;
-	u32 field_off[BPF_MAP_OFF_ARR_MAX];
-	u8 field_sz[BPF_MAP_OFF_ARR_MAX];
+	u32 field_off[BTF_FIELDS_MAX];
+	u8 field_sz[BTF_FIELDS_MAX];
 };
 
 struct bpf_map {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..12361d7b2498 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3584,7 +3584,7 @@ struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec)
 	u8 *sz;
 
 	BUILD_BUG_ON(ARRAY_SIZE(foffs->field_off) != ARRAY_SIZE(foffs->field_sz));
-	if (IS_ERR_OR_NULL(rec) || WARN_ON_ONCE(rec->cnt > sizeof(foffs->field_off)))
+	if (IS_ERR_OR_NULL(rec))
 		return NULL;
 
 	foffs = kzalloc(sizeof(*foffs), GFP_KERNEL | __GFP_NOWARN);
-- 
2.38.1

