Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7169E8D3
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjBUUG4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBUUGy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:06:54 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0627997
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:53 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id f13so21417614edz.6
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKxKQ9sJzV8fykIuAK7NqDRbhBj4NpFuno90ez4gL84=;
        b=SPyGFmu/PE5tccHyDhwlmkvMBKGdvNR8TCQklSJ7U/0wwvq7aLXokhMkB7fMs6fNxh
         ojXuoQ78g9H9QfbiNlwZ4dtR8iYVCibK+heSggMD/xntemAmogZCkFxkc3ET5rkj7jJX
         p3/0hXJpRjZ0PQVnZZuDu4xlSxscgQfaRkHmzZP/8BnAl9S43wcvONCPkeB5l3B1UhQU
         71O91n7N9aq+ep6PFDxrDb8GEGWpmU9aiUme+hDJgdqlRTTVFbZ6m9zF9Vq/coZ2JmK4
         3If3Lpqt/nHqmk2p5ezVRYydEYm+EdhWlQWF1pmn7rWrYkyCmci3QuFQD6koTWVvCzF1
         jyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKxKQ9sJzV8fykIuAK7NqDRbhBj4NpFuno90ez4gL84=;
        b=60gcbAUIleEREBieuyEYFgyBPbtMV3kkj5IvYm8l5DW2d0txlC7WoJ3FU8sNP92Fbo
         LYTfXR+7CpnztqCnPejrXaO+aJ7nfqX1WhBIYMAmNqRyOXUKDz1evj3SwDIWK0s4YzhR
         lyEP7Miz8dAC3wpl0fYbbJw+kcyH8Ju6WrCznbenWl4wtz8ZMeuSdRxfMQ7u21Jd/cgM
         yXUKaKSmG8DNFaQc2bpl40fyJ86j0sXmypUhouX9ZpHywjhhJHwXaN6VsqdMLf/qI0hA
         ATJeI2CFmlKVX9TPJf/y4NVKgsNHoloeEDNy6SIUhAhfQ32HnJQC548con6IU56s3eFM
         nopA==
X-Gm-Message-State: AO0yUKUt8QNzM4fjVtzMvhNs6/VFKx1ggYE52XMT75WveDL9XB+bqapC
        W5inXCv4HBXNBtNU2fnxFCAK0pjiuCR+ew==
X-Google-Smtp-Source: AK7set+z0UC1jrYhOyjneVJ/vFhDcYdf2F45VelJymo+zjYpaxFronaUnn1zQLWwaj4A8ZNGuXAnrA==
X-Received: by 2002:a17:907:98b1:b0:8e4:96c4:94a with SMTP id ju17-20020a17090798b100b008e496c4094amr1037751ejc.56.1677010012001;
        Tue, 21 Feb 2023 12:06:52 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:6d0])
        by smtp.gmail.com with ESMTPSA id u4-20020a1709060b0400b008c607dd7cefsm4385714ejg.79.2023.02.21.12.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:06:51 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 3/7] bpf: Annotate data races in bpf_local_storage
Date:   Tue, 21 Feb 2023 21:06:42 +0100
Message-Id: <20230221200646.2500777-4-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221200646.2500777-1-memxor@gmail.com>
References: <20230221200646.2500777-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=memxor@gmail.com; h=from:subject; bh=30/AAcSNo2Q5iYQoDav5BEz50DtTtdsaIGwvWTJd5tQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj9SRLHQZnoUYeVaSBhDu/63T8K3Eq+JSqs4jVdf7G 0pHGjKqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/UkSwAKCRBM4MiGSL8RyoPTEA C6xkasGfZmUegv3OfN3C3l+EHpZQymhD7vpPSetkYQ5GWwPH8+Eu3b8rV9usH/V2DdDLIQE+iSTqQU 8aI6f/pQhZhiWC6BW9vNNQ1ZswXpaaM39GfwcAaem9C+dlSdPW7uPNY1mFUcspHDnphYt0iP5RDaJK 1m39Sb65ZlfX77aqM+3bKAx3z6/WXHVFs+TETWba7QhZfae+S1OdxxGWWcpqqdPcoXNnPOdH1oxSeP 3bizQGnt30J4rRhE1Vpa5J+IccdKQxjfnd0hbJsiHsDv9+dWUkArkFW+B9REBSIvkW6t+Ky9WOxpj8 o5igvAPX/HjXdMJKepXqGHSjdQM6sFcpFPu9kDZgW8WhQLlOralLVvyjCa88TfuZOIN4JYagVPCPxb jyprQr2ougfDdaVXNCuQ5k31vgmbGOElcv3TB0/ywrCLGwS1DKs18uVi9XeRfKD11bE3vC0nREiQyS gxr7PVmU2rKdS0JsF2xgjRgPJLzSb6Nuu3lOqNbQ4Rr3wVuuWEJRVhx14urf+lddJT6W+ySVtAVGu1 lyA3WecADJg5i0hoyP3MmHFrMGeX2TKp0YfxNq+dMXH97eozUJVlLcq3wO4MPoDtBO+AgJS4dw3yum HUBq7FsDa9rGg0s3pWNYh4otWIFAKu6nNj6QnsH4sSMgMFWnG7VccWoSVw9g==
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

There are a few cases where hlist_node is checked to be unhashed without
holding the lock protecting its modification. In this case, one must use
hlist_unhashed_lockless to avoid load tearing and KCSAN reports. Fix
this by using lockless variant in places not protected by the lock.

Since this is not prompted by any actual KCSAN reports but only from
code review, I have not included a fixes tag.

Cc: Martin KaFai Lau <martin.lau@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 2803b85b30b2..2f61b38db674 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -51,11 +51,21 @@ owner_storage(struct bpf_local_storage_map *smap, void *owner)
 	return map->ops->map_owner_storage_ptr(owner);
 }
 
+static bool selem_linked_to_storage_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->snode);
+}
+
 static bool selem_linked_to_storage(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->snode);
 }
 
+static bool selem_linked_to_map_lockless(const struct bpf_local_storage_elem *selem)
+{
+	return !hlist_unhashed_lockless(&selem->map_node);
+}
+
 static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 {
 	return !hlist_unhashed(&selem->map_node);
@@ -182,7 +192,7 @@ static void __bpf_selem_unlink_storage(struct bpf_local_storage_elem *selem,
 	bool free_local_storage = false;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_storage(selem)))
+	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return;
 
@@ -216,7 +226,7 @@ void bpf_selem_unlink_map(struct bpf_local_storage_elem *selem)
 	struct bpf_local_storage_map_bucket *b;
 	unsigned long flags;
 
-	if (unlikely(!selem_linked_to_map(selem)))
+	if (unlikely(!selem_linked_to_map_lockless(selem)))
 		/* selem has already be unlinked from smap */
 		return;
 
@@ -428,7 +438,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
-- 
2.39.2

