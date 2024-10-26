Return-Path: <bpf+bounces-43221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE559B14F1
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 07:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6C7282D51
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 05:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563A31632D9;
	Sat, 26 Oct 2024 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNOAQoqA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CF17C;
	Sat, 26 Oct 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729918971; cv=none; b=Qaufp7fIgWXvjb9FR8v6MX/cwyztY2nPlloDRrKIBzpCecW0j5nn7g0DBfWc86Z0RA2BH4aMGvEVG2O4iHUf5saaogubI6sMXkBO8ZlVMo6Q93JaODAJcak0h21Ejd+JOnC9Q8ehA2B9iRvz6Gmqu74Pw/4q1T9LRAtYlK/RfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729918971; c=relaxed/simple;
	bh=/jegesIMV5h/Wgu6ILE9MpSosDfZ2/idssK/zKj3zU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OMR2Wp/MarBDib0B57llcBN598MMC/jKWXD6upJlGeqc4WDIK9KMMMFXfjT8taV4W5jN3i+Mt84kOiuJNBwaFc9kd2wjDJb/mShokmjYlOGOWYfzyqwm9p4ke/52C9BwntToPLVfFkEeCPdRThZH3eKTV2YRopatb332yzj6auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNOAQoqA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1943770a12.3;
        Fri, 25 Oct 2024 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729918969; x=1730523769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn36Vj1gCAJWmg81v9vfsiQ9AEJyqVLMwrFUP9rTOXs=;
        b=BNOAQoqAbE/KQF4KZL4Ihg912ELyIvzbrZ7Hdl6IINOE5z5j2M9StfdjpHukeG4npx
         i4TjAE2ZFYcdVd9347RCiS636u0jgx9OM2v897BfTyagqKM0wkT5TP3AJqHALyJmVbRp
         0C/ZAqQhSQiT4to/jLOat+7Ba2pruLLISFGq9BPOP4CQXkctYruIfyjIzQNjX/IXIl39
         6btwDIrCUuZMDqv+ESGC71JK6Q5J+u2NaSrF1N7KYAbSu3DYKhdFjm50ajTV8XEHmfKO
         q+qGndAiozEYPHB1ysZLjM45MJT7l1Xd5jg7l6BnYvlYp6ne1FvsqveFjgzOOou9gfLJ
         lNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729918969; x=1730523769;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn36Vj1gCAJWmg81v9vfsiQ9AEJyqVLMwrFUP9rTOXs=;
        b=sxs8CNtr3Un1+84YP8gVLhf7KtpwUG9PRCvlgJlLm3pMT34usuRiSjXESGr4AAbl6X
         ielJcNFowqHewr5mzovAz2I543BWLB8yfmmoWLvTBJ548xsB8H211nGf7C2pw6YRub8D
         Yekj1x/q6Eucmvr5WeJjS57zjQLVKGApD2gF1DPAnGc4aJUs2eO909/d8ut4ODLMazho
         A9XjqkUsKloDWr/nlRO8m3JN/29JVDX7zOmsF3xMqJHn4ydieuAnjL1zvZ6llAoLjbZ3
         HA5a9musb3vU+LtkbblMrs1lLtdE8bCKwWeUmEF8zovvnt0bD7rLUmuFdwMtmrD8sEpZ
         C/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVZvAmLtLy6I9hpijDxkLkerC8EoTNaL0XIO3XKMsEFcIY0I/492MiukAntBS2N3m6A/lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq1ZU8R9guvty7Or/mtPOFuRZIOKhBiOrOg80P0eMcbeWQA56
	99w1XjyKkDHQ97t+1zIkUVhRdvjioLN64Gysk8RRmMfxVaPL5FWXMi2Lfzkv
X-Google-Smtp-Source: AGHT+IETFU2OxryR2LbIKq3GfwseFTs6P+JWYNpmv7ydBKxDSc4fxASQfvOu0gxC+n3M3qWH5CxTog==
X-Received: by 2002:a05:6a21:e85:b0:1d6:fb1b:d08c with SMTP id adf61e73a8af0-1d9a84bcd86mr1854072637.39.1729918969324;
        Fri, 25 Oct 2024 22:02:49 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a4341asm1941855b3a.218.2024.10.25.22.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 22:02:48 -0700 (PDT)
Date: Sat, 26 Oct 2024 14:02:43 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hou Tao <houtao@huaweicloud.com>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 bpf 1/2] bpf: Fix out-of-bounds write in
 trie_get_next_key()
Message-ID: <Zxx384ZfdlFYnz6J@localhost.localdomain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
full paths from the root to leaves. For example, consider a trie with
max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
.prefixlen = 8 make 9 nodes be written on the node stack with size 8.

Fixes: b471f2f1de8b ("bpf: implement MAP_GET_NEXT_KEY command for LPM_TRIE map")
Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@kernel.org>
Tested-by: Hou Tao <houtao1@huawei.com>
---
v1 -> v2: nothing changed
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


