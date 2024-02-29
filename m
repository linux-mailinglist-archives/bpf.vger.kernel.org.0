Return-Path: <bpf+bounces-23042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546E86C7FB
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 12:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC88A285FE4
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27507C6CD;
	Thu, 29 Feb 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjWcCOpw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2827B3F7
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205778; cv=none; b=C1lUjMKwz+39a/+rP69gLe0QK9v8+j0+RONOmp18H93fwIF32Eg/mOuMu7ipiD6MgAQ1i3SSe0Kr6Nby5OO+Ok20y/fQoan3si9e7EPbWq3y5N42Vgs5BlQw6zFrBqCrncb1Wi6Tm2gwAeXMELaIFAd1whVP0THwbnBg86N8Ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205778; c=relaxed/simple;
	bh=aN5B/H3+aZeNnIsVU4Fcp9tC0qKK8AlTy2KT5pNL5xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edt9/F6HSGzsBis9n7zob1+DpW5AQFUndXg53biocx6fEM/dNuQu0eVJsH1maw6aqIYM9KI+88PKXrtQz7C1phDgaI141G1j7RMjStW5CsE+xYp6J5XvbBElTTsj1Es0/kRNtwLvdGk6IXNycNVsalFMN4iUggexBe144aSr/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjWcCOpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709205775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4AaMILcAo/s2GpBCqX/kzMxFVWfEPCtHz/bU15AMqJI=;
	b=RjWcCOpwwGWwIlXLmGMdPRtJBJzXsBpYpS/dB/IFn95Fk27zejqRFsubBwoOJYpuXBvvA9
	ZmmspZEp/GQJJncY4bI1QWzNAYnuWxbmScvoY7sJ6SNSg/N6oA/DW5cydUVc0vvDzj0aNC
	rVW1MMQSP0/pxmGrOtFZU5ZvGETlXtY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-IG1cqQecMV6XYgka_eCJvw-1; Thu, 29 Feb 2024 06:22:53 -0500
X-MC-Unique: IG1cqQecMV6XYgka_eCJvw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-563e6dd8d64so581589a12.2
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 03:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205772; x=1709810572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AaMILcAo/s2GpBCqX/kzMxFVWfEPCtHz/bU15AMqJI=;
        b=TLjfLvb/CzcpWCbk0BqK57g1chhluD/xfOTe5+f/ICs3r00a1JBZzxQWu3eeNtCNk4
         gqMLbafdieobaO0bWeTf4J69dwTwsoXZzINtLeq/3oY4kDNjEsd0VYsm6SHF9bejfIvX
         n+bU4aaUZw/xkHstcDZn9QHEJmYpNA2BYZk4YrSNE+NTmzq8YeSm8aFDXoO5KIEnb19u
         MtPAbK9207hgvG5o6JAhZYi7M6rqGuNQ84W1y5aIyHzyYkBtl+jQyIoB9f1qEStQkoL8
         DTtqZrXK4X1Iio7e+pJm73wBhSXYea+fMdHiqU9j0616NQvuirsPJ/yORyiHk9QQUpvF
         yRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwH3Ghxd82bFqp4viXZbiKbfJwQ0VDTGVIzePRsLMgTIi3L2e1rl29Ck8SLWVA+XXtU785gMz8dSUnLkzmXR9kizu
X-Gm-Message-State: AOJu0Yw/h7MoPUA9jeuot0kRAcCp59rs37JnA90eIQhwjQnHhe7q7A7s
	RxqVYvHgQstCnG9IxOBPXorYeZYwZWLF1zLs3l94v7klJOkDGZ3tyRyRuPD10amUA2OkstaF2So
	gPdLXrL0jBRdcIecKFbfHCDOV+4g2pj11MjaJ7grbhkOso8vS1A==
X-Received: by 2002:a05:6402:5286:b0:565:980d:5ba9 with SMTP id en6-20020a056402528600b00565980d5ba9mr1238817edb.32.1709205772691;
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWtwvu15XXKVpkHaqc/yrzkeUn8gBKDeYBaPwKJ8aGqoukPrClCfzkmnCoXOP4JvHFiIPMGg==
X-Received: by 2002:a05:6402:5286:b0:565:980d:5ba9 with SMTP id en6-20020a056402528600b00565980d5ba9mr1238799edb.32.1709205772353;
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h7-20020aa7de07000000b005664afd1185sm524972edv.17.2024.02.29.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9347A112E806; Thu, 29 Feb 2024 12:22:51 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: Fix hashtab overflow check on 32-bit arches
Date: Thu, 29 Feb 2024 12:22:48 +0100
Message-ID: <20240229112250.13723-3-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229112250.13723-1-toke@redhat.com>
References: <20240229112250.13723-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hashtab code relies on roundup_pow_of_two() to compute the number of
hash buckets, and contains an overflow check by checking if the resulting
value is 0. However, on 32-bit arches, the roundup code itself can overflow
by doing a 32-bit left-shift of an unsigned long value, which is undefined
behaviour, so it is not guaranteed to truncate neatly. This was triggered
by syzbot on the DEVMAP_HASH type, which contains the same check, copied
from the hashtab code. So apply the same fix to hashtab, by moving the
overflow check to before the roundup.

The hashtab code also contained a check that prevents the total allocation
size for the buckets from overflowing a 32-bit value, but since all the
allocation code uses u64s, this does not really seem to be necessary, so
drop it and keep only the strict overflow check of the n_buckets variable.

Fixes: daaf427c6ab3 ("bpf: fix arraymap NULL deref and missing overflow and zero size checks")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/hashtab.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 03a6a2500b6a..4caf8dab18b0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -499,8 +499,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 							  num_possible_cpus());
 	}
 
-	/* hash table size must be power of 2 */
-	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
 
 	htab->elem_size = sizeof(struct htab_elem) +
 			  round_up(htab->map.key_size, 8);
@@ -510,11 +508,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		htab->elem_size += round_up(htab->map.value_size, 8);
 
 	err = -E2BIG;
-	/* prevent zero size kmalloc and check for u32 overflow */
-	if (htab->n_buckets == 0 ||
-	    htab->n_buckets > U32_MAX / sizeof(struct bucket))
+	/* prevent overflow in roundup below */
+	if (htab->map.max_entries > U32_MAX / 2 + 1)
 		goto free_htab;
 
+	/* hash table size must be power of 2 */
+	htab->n_buckets = roundup_pow_of_two(htab->map.max_entries);
+
 	err = bpf_map_init_elem_count(&htab->map);
 	if (err)
 		goto free_htab;
-- 
2.43.2


