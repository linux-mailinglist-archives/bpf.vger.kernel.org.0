Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0669C146
	for <lists+bpf@lfdr.de>; Sun, 19 Feb 2023 16:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBSPxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Feb 2023 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjBSPw6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Feb 2023 10:52:58 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172B346A3
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:57 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id ec23so2812256edb.1
        for <bpf@vger.kernel.org>; Sun, 19 Feb 2023 07:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/1so9i3HBYkTX95EWj7UWd4gR62OCbsarRt0LHkNFw=;
        b=S/z7EYh8pjP8qKoa4uixIseuCZo84G+Z4w2hpMQLnIO+jLyd6QfXsAasNB+veyo3nq
         3rVL35V6IrQVRj+OtBqFlQ1FpqXlITxX1i5+igcERZdk3/5YbD5Mru7x3XzYUq16K4Jg
         jiZcLSgGGhh60yyMC2S3VOorXruyoDNsUDcb5QKO3UnLqARt1VRASzh+Z+aj3fjBXtdx
         vXwSroLg1+22rTAQ2hU6rkOQuygNGAdxIzbaVUO4oJ9X+biJOiTpEzKQ3HL4Gtp1+0jk
         KCxPaVFaYplNu5f1I9tiYh8cZtNn029dFPPnRae2/AUo+bzvNNw7Kg5pkBjHlEq1Y9bg
         o16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/1so9i3HBYkTX95EWj7UWd4gR62OCbsarRt0LHkNFw=;
        b=5FEuLFpXlbI25e6N0OjlAHMCkcq90XE9oPqe3apo2MSRfQGcMzAQzEKfRp2n8oBZNv
         17xCtWtWmp9/gPEJOdpgCdL8opNqapbNsLc5emZkvLHNBwxhnPXPwCjDblB+nfGym32A
         3ZzFRAaLajkQmT5RX8uHdEqJiE7saKfVwkp8F2n7y6yBorG7DPI1JOA+4mRXGZ6IOiso
         qwcxWAORLbHQduG/MUt6hhE0ww6N/QKZUvk3+dOrGONTXs+mA4/Tq5OlkoMQcEiDGf8S
         HVLQkmxJqYCcOjaZ0cFNjtHSASjkfLywAh2EY7pxJC5Up+KETFUYpcnTUJ7OaZq4l6Zy
         BO9w==
X-Gm-Message-State: AO0yUKWfh/n5C6iODRP+wqzRY+tIpRTk4wGtaIbF0tzrJYIhh9bsdLJ6
        EnKTWG/3jtNeizutjj712j1sbcAclZDe4g==
X-Google-Smtp-Source: AK7set+qnTEBr9ffYkb0sxhyIgtmA7CXgbd4MNZKyBoz+tkg0zo23f3EjPvN6Bx2IWsH2TJHcJf+9w==
X-Received: by 2002:a17:907:2da2:b0:889:33ca:70c6 with SMTP id gt34-20020a1709072da200b0088933ca70c6mr11462725ejc.2.1676821975187;
        Sun, 19 Feb 2023 07:52:55 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:8d0])
        by smtp.gmail.com with ESMTPSA id fx11-20020a170906b74b00b008bc8ad41646sm2092397ejb.157.2023.02.19.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 07:52:54 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 3/7] bpf: Annotate data races in bpf_local_storage
Date:   Sun, 19 Feb 2023 16:52:45 +0100
Message-Id: <20230219155249.1755998-4-memxor@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
References: <20230219155249.1755998-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=memxor@gmail.com; h=from:subject; bh=s/dXuZ/+okm2ypKP+JtyKlFMQDFsjWGusg00Wy+v0v8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBj8kUe1zJfouqHU/2z1yOGqj668QLam336h9BlxOhO 1KWys3uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY/JFHgAKCRBM4MiGSL8RymSlD/ kB782p3N22XxbPysej6CQdL9T8Iw4N1U2Yo2cx8B2endI7W4MeSuu1uct55udrvgZ0lpepJMTYAj0V 89s6dcM3WvjxvvsWHpSAUvsVikMg1p+nWba67gW0g7athpxlkcazYeAsSOeX0roSLxMhP06Tx7mKFs 3Ow9uyIgv2iD5EndyUAP2XH7E9Xlgxx95EkpMYGJXnAFRXmYmmjvLBuyYKyny+3GKQM0Z7mE9mB4Nr jT8+gFAFlTPpQavyv9esGnX3bmhiuda7vLQTWfoSF3qW5uWVnSTTC1r6tBwiAhaUrO7GLobuZi7oN8 Oyx7Fum+XlqCdDUsPTMXcdgl2LEyTx4haOej0+1LwOJ3OqAAKOD7FEM3h0b/AIpl3fxMgmmXyM8few IBYKCK/rRVzbozj2ntjtAfv4jUVPDFbQektmuHAyJBSw4osunWRJmPh0kwjyeomQ39Ilv/wol8kKHh DXEtMl8bC/diPUqF4938m+O1iSViWisGPrO6pbSVdebibyA1bQjrKBU2nLWICOAWUUZmeMa4aZViym //xaUJJY9tyZZeSFWEljxrt6gnJGxSQ0p+qXjRgipZcj4FvBaOOZS229YiS6wqzKB6YyXwTMPdoKHZ v2B4mSIzw4QK8DV1FGNJtKl/ZXm6DsAywKZ8tGB/9O+D8M/OganminEED/Aw==
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
index 4521d53d7d4d..6b9039460968 100644
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

