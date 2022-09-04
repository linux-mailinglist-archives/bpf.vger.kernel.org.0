Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234305AC668
	for <lists+bpf@lfdr.de>; Sun,  4 Sep 2022 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiIDUmA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Sep 2022 16:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiIDUl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Sep 2022 16:41:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574802CDDB
        for <bpf@vger.kernel.org>; Sun,  4 Sep 2022 13:41:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y3so13513629ejc.1
        for <bpf@vger.kernel.org>; Sun, 04 Sep 2022 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LCcIsE28PR17apWvG/VYGszMraGspsRWy69wEQiqgL0=;
        b=Th1H+7bAyZ1hISAOo3Rp+wMm2ZHDuk6v+TKiMWyb5MRyIIRNlNpvGgfykV+tYOeuhN
         oeoMSDnD4PxIobQV7IHZGvBg89ZhSWKi6j+G7aty8bKWZu6m0jdZOse6uVpAT6SaU5vA
         SMPlOiEtJ6ehXKLpUrh8DWxbum2YaOL4I2ogjoZ8LzoF9TQlMbyv2jVIYfnX20yV7eeb
         10f61I4TSAsATB1XvHNRxKLDOEnxlv/z79n+EuyfRwV/DIY6pjOwoUsDqWt7BttBLbIe
         ZS6zzlnGsBmDX93Es0OdaikpmE/BfqUr7U4Npx2InuOIA3a/t7TV3en2KnDmRpNrP/PP
         6XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LCcIsE28PR17apWvG/VYGszMraGspsRWy69wEQiqgL0=;
        b=tCFclOUwI98EPZOw1mJM7Rm9a+W2A31BXKDsmkmuCa5fCHkWNdv4VAuOaxzRINQoww
         R1TFKGeVW2Mt2zF9aK9F6Ovv9HMHZDAm1drxQKs4VSsAGZygbSEIdn/pZi6YwA4f1ptI
         oTRWgn7YydiQm62znZZNoOf5gKcD9QHYLL456QGXk3O/WaaN1aCLQCBGaaM3teZHpqmp
         rjrOtoESAFDz0qjzwXDxpR5FqgjmW9wNojaFZhz73/mdNOYKDJkq/3KIkgJAX6EE9oTU
         bWA6hJiY9p9NBsxDDewHM2f9pCSoDsyo15Dpi8YzQoHneSs6uX94BS5swQ5TWikSrYVl
         oVbg==
X-Gm-Message-State: ACgBeo3oSIQ5tGkwVIpL7Q81R8q0mBNT7o8/g6cU8tO54uifiT0wHq9t
        HSCppNenLj5fNJaRqH8vsJeVvtIWSyKJ0w==
X-Google-Smtp-Source: AA6agR6rQKR3G6dSHKcZ32nli3Y+jlsheJyAViF+cgZudb5Da+6iICIxzhk2DtbhhF4RN6k+nR5F8g==
X-Received: by 2002:a17:906:7621:b0:750:c4a3:8fcd with SMTP id c1-20020a170906762100b00750c4a38fcdmr9279859ejn.180.1662324115532;
        Sun, 04 Sep 2022 13:41:55 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id kx3-20020a170907774300b007314a01766asm4089018ejc.211.2022.09.04.13.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:41:55 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH RFC bpf-next v1 06/32] bpf: Annotate data races in bpf_local_storage
Date:   Sun,  4 Sep 2022 22:41:19 +0200
Message-Id: <20220904204145.3089-7-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220904204145.3089-1-memxor@gmail.com>
References: <20220904204145.3089-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=memxor@gmail.com; h=from:subject; bh=xMzM4WncBzBEfYlYZjaVh0bCZGkmavLfqaAXRDZCHUE=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjFQ1vfzXk4bIXRODZUbAwBlVSZg1O3Qtws1Mqn3ih DYZY1+OJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYxUNbwAKCRBM4MiGSL8RymxPD/ 4hCdSdtuMPeFNspL3oAbjoNFLPTS1bcegM0QTOTfTAjYuRinqSUdpsl3MQ+r5mGx5cgs8CYGIobBUH AtIg7uHJX7NlIOWqBuA65dTBSp8xIokmUp8CqjOIuZtF3Bp6YxX6mvN5TjsgAA/iizrQaUaixrUM27 e+sqAmYF44fNRWBxzgj/gy/mADj9EbhXrZPfpOvateg0W21JcMVW5TXOVeSmskK1RSKM1DTnfw+37h WPI8uDrlzKwywMEV9P4hrOitJuCi9gVkp6Y7aejeOUIQth1HYgK6FcELSiFOcFaVFZMbCKoElJyReB Pa5j4ggQdvr237w2BEHe1lNsxkTRqw52B9fyxq7VjMVYj2g1GzstJ+JDWu1Ug+uHWbNFWcbiCkKm3K jZaPhneb80kA79JC3jYf9GCtAgfwYoRQq5QU0Nz9IXnUwpc68LMOgXDjWUToe3o9ygCIK+2NYejw8J +niVjUzQ8hj6uMaItTw0wr2JejUJ/4XROHpYa2iY4rVFyoxgMnE7kPRo1LTqHrP7PtZbxh2es00YqB 9n6DvZiAa9Tj69aSzUh+BP9CQ8/ndnh0cuTwNmHN3TAPUJImlQzdjXie9ARnRu3sZY9O2a+X5H/MIg aRXa8xc+HEE4BOxmdxLzDyh8BJsssqxOMLGvzMt7HyIhtzzzfZyoPODV66hQ==
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

There are a few cases where hlist_node is checked to be unhashed without
holding the lock protecting its modification. In this case, one must use
hlist_unhashed_lockless to avoid load tearing and KCSAN reports. Fix
this by using lockless variant in places not protected by the lock.

Since this is not prompted by any actual KCSAN reports but only from
code review, I have not included a fixes tag.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 4a725379d761..58cb0c179097 100644
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
 
@@ -427,7 +437,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		err = check_flags(old_sdata, map_flags);
 		if (err)
 			return ERR_PTR(err);
-		if (old_sdata && selem_linked_to_storage(SELEM(old_sdata))) {
+		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
 			return old_sdata;
-- 
2.34.1

