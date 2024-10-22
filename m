Return-Path: <bpf+bounces-42723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531779A95AE
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826DC1C21923
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2712D766;
	Tue, 22 Oct 2024 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoKdlqyA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A335126C04;
	Tue, 22 Oct 2024 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561720; cv=none; b=hPkTDaOq3915gfBD0+llUbBQOr+ugZRSxc1zBKlx04c/T3tmr0EL74nkMbRKUJWKAfIR7d9JsIkBS0eI7LGQ2Wyd85kUQaNERAdfdwGypozlEDYp09/hWA4zZz0xtstAJmFJ/AI8gdeInbEb1Zi63j3LSM+nZlzz5qf3gxHiuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561720; c=relaxed/simple;
	bh=8BxbvwcBJ/putwiaVZPe/BQPdiOescYvnhGJTjeJAvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jbJveDMoLCCVaG6JFOeX3zEV4teAwkmslj6UTpHlFL/7YRzIKrgLcWvm3qm187750SEQVXM4Zvek0NgHztjIAQEW3ha7HKxOya8sVkKOjqkHJGUumOPXkbsDX+9UNI0wguHXw70WVrpWxJBsthICYs6gK74b4vyf2UygrtSqxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoKdlqyA; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5f968230bso1834984b6e.3;
        Mon, 21 Oct 2024 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561717; x=1730166517; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaAv5oQRgd9cX9nyDn360NOTdyHG7mviKBCjVi9eqrk=;
        b=XoKdlqyA50n1GLqGoOe99av8J5FZ4esmtyCLZvrQWcuCkOSi7aadHMq1o70DcITpNz
         fsHzJlgWFUHMYKMwBQeZVU4NrbJ/WnIPRHwet5c2i8d6LfgqlawhjrdW1MZWZMnlhagk
         efu6sebk1YeDNHo739jpGUrG5nsZSxJCN/jeb/zlpz4HaHklVyhA83J5zjRhvYqtgycY
         LlWXB6upIMrytrlZ8OLn0lPMaFfQwHNWm84uPfgZm0kUNwUD8xOCSln9cKxMgo0LPtbU
         9u+99TfoBWcWTRDi3Zn6F/FEOfG8Hd62uURvZkzhUQXrKx+25svoHZqmR2mum5ad/w2B
         1zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561717; x=1730166517;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaAv5oQRgd9cX9nyDn360NOTdyHG7mviKBCjVi9eqrk=;
        b=c8T8qLqIfPyUJ7X5WDhkWhk06P7a6N6kpk5rGl5w42oXmXe+r5LlSOYTomYrKsKoS+
         TwGot/GaHRW8o3vTIbg0sBH+9PRqjsXLu3Fg/f7bZNjwfgQqgjuQ0f+V733UxfE70Qda
         ieRlOlxUuLd/CX4nNPZUIUmoKZYCXQ6z/k9nXhVnGxZOqvnbtIwSGHwWNEMk4tR+cfvX
         rFv6x8hYcHUxsgbp3WaaruE1eOVEvwSRRE/f9x9UtHJoXwacq2immZgx2MuxcUQgKZ3t
         2eD5srCdEGpOfZTIWCOFoYS3Lev52F5IdXPjKS2NuhUu+7NBYBDmM3sSlnJVq8YcdWrf
         Iq5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1I7xUtb9EORS7h4CUYsD9tKbq7BOHWrY5L6Lf7dB27/u0m1WvqOgV+C3aBXiwAS4TSjMdbFfvwQdpjbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nCDBNPTbIFMNrTtmR1m7uA0iLwH/QFO4M1YcGfhSke9NgayE
	MBnPd5PKefdsmmbv4GCdhbdn/X7H0Zdb9FugzK5odetrbZ+9HSal
X-Google-Smtp-Source: AGHT+IE5TBUcFhT+nAKE7if14Xqz2LZbC/N7w+f7KNMHBv7U9j66vBQEtCNlktDGfO3wsticRZakwA==
X-Received: by 2002:a05:6808:2e8d:b0:3e6:143a:fadc with SMTP id 5614622812f47-3e6143afcc9mr6574705b6e.3.1729561717572;
        Mon, 21 Oct 2024 18:48:37 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabda178sm3254598a12.87.2024.10.21.18.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:48:37 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:45:49 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
Message-ID: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
full paths from the root to leaves. For example, consider a trie with
max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
.prefixlen = 8 make 9 nodes be written on the node stack with size 8.

Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRIE map")
Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
---
 kernel/bpf/lpm_trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 0218a5132ab5..9b60eda0f727 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -655,7 +655,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	if (!key || key->prefixlen > trie->max_prefixlen)
 		goto find_leftmost;
 
-	node_stack = kmalloc_array(trie->max_prefixlen,
+	node_stack = kmalloc_array(trie->max_prefixlen + 1,
 				   sizeof(struct lpm_trie_node *),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
-- 
2.43.5


