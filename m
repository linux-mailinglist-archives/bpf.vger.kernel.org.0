Return-Path: <bpf+bounces-1023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C470C2AD
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F291C20B4B
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235A154AB;
	Mon, 22 May 2023 15:46:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963B154A5
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 15:46:15 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC94CD
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 08:46:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso14658955e9.1
        for <bpf@vger.kernel.org>; Mon, 22 May 2023 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684770371; x=1687362371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k44I/f+gf+dvl0fry0xo8Osm/iRzMqqiQS3xmmS6mJI=;
        b=WK3yulLTjoYzxtabAquj0IPZTwceTI3mHAB653d4NRK2yB4/Tm+kM3M1aIILkG3kDq
         JtHb2GWFAwtFOMVJGHYBr0yvOPOKOGrch3/STFT4PlMX1QYehVRl0FnphKU0VbEubb7A
         On9LQ7we6Gu4twOvr07OWVxw7gcSl5cHOqTGdkHjXizy8GnEJf5MDHJT9K1yKDnT4h3K
         GhCa/16TB7g0ZjLI3Wdy87bqlydJdkMiHYzds70GDfIb7jL7FXqiMjtxf/0JuxgQaOwe
         fd8zPA0+9RYfpaCQIVti5uXbZ7J4/WzHE9cB9ThJjSVX9VsvmBADLUvjNkeKgZKoehf3
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684770371; x=1687362371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k44I/f+gf+dvl0fry0xo8Osm/iRzMqqiQS3xmmS6mJI=;
        b=GVJS/4NNesPpwFES51Ar21qn5OOnoBzL4ihb2aRzxqbGnC6IDFPhh165M8R7jSeH06
         xhbz37bqi6CGLNl/5TsVfGFSofXaO2zpW5PakN7cdOuCYxXOQgZFPkub4AJBdlGEY9Ak
         MWsknV3oQjROLWyiqTDk27hyzFJdwYdIHS9Y36Z1ymfrM+z71oqB2HozBsx46PlOQPJ3
         fP5sN3FS9B9qnNX6Zt542wUKElfx/+0ZtAbwDCjRCM1DONbxqkg3j4itoVNqVo+EAX1B
         RljtUVSxnNjTDb/uOk8jfMwU4TBA5NMLAdXr9dchiksoB2jbZ7BFoEV2qEa4nBoB9niG
         cGFg==
X-Gm-Message-State: AC+VfDwbDZ9Mus8ryGdzeZm/MhQWRnuFOyRhl+XMtQa1pxXe9zcIOY3Q
	Ox+kEGV4i1GB34C9qC+ihU3RTCnxj92LDRY4rrSIBQ==
X-Google-Smtp-Source: ACHHUZ7SCEj+B0rnXt642yVGZNaBXaPf524bZNrqZNtcRjOw0Ak6U/eA67pe7aXYQtqjkqdl/26hWw==
X-Received: by 2002:a7b:c4d3:0:b0:3f5:170:30a7 with SMTP id g19-20020a7bc4d3000000b003f5017030a7mr6693148wmk.41.1684770370781;
        Mon, 22 May 2023 08:46:10 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003f4247fbb5fsm11873909wmc.10.2023.05.22.08.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 08:46:10 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf] bpf: fix a memory leak in the LRU and LRU_PERCPU hash maps
Date: Mon, 22 May 2023 15:45:58 +0000
Message-Id: <20230522154558.2166815-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The LRU and LRU_PERCPU maps allocate a new element on update before locking the
target hash table bucket. Right after that the maps try to lock the bucket.
If this fails, then maps return -EBUSY to the caller without releasing the
allocated element. This makes the element untracked: it doesn't belong to
either of free lists, and it doesn't belong to the hash table, so can't be
re-used; this eventually leads to the permanent -ENOMEM on LRU map updates,
which is unexpected. Fix this by returning the element to the local free list
if bucket locking fails.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 kernel/bpf/hashtab.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 00c253b84bf5..9901efee4339 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1215,7 +1215,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value

 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1236,6 +1236,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
 
+err_lock_bucket:
 	if (ret)
 		htab_lru_push_free(htab, l_new);
 	else if (l_old)
@@ -1338,7 +1339,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 
 	ret = htab_lock_bucket(htab, b, hash, &flags);
 	if (ret)
-		return ret;
+		goto err_lock_bucket;
 
 	l_old = lookup_elem_raw(head, hash, key, key_size);
 
@@ -1361,6 +1362,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	ret = 0;
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+err_lock_bucket:
 	if (l_new)
 		bpf_lru_push_free(&htab->lru, &l_new->lru_node);
 	return ret;
-- 
2.34.1


