Return-Path: <bpf+bounces-33285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B891AFC1
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BBD1F221DE
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E945C16;
	Thu, 27 Jun 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OooG2Dal"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9582E62D
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517072; cv=none; b=BHoAqn4cJtLG6FaZrkvwHMiJF19RSqKsu9iA0pljj1jJITb0LQw7jtRfF8rpgE6nq5+/kXpULpbMfHEz9xS30hUNWH5hu2bMSnEyr5QG6Hhr8gV1w86coRA/yvoVl3ytRXEMbqqZAR+xz7LL9hdJc1/90+6w89rdCsYNFWOjjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517072; c=relaxed/simple;
	bh=LKCAJpaKwvzXOOXv5ON0Cc0rgP0H2YAT/VEJFipgyWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCf9IWY4JSi+NtdQG21YoZoKzRhfST7AgfT/Y/pbutSOO9VwWHU+bHt16N29RikimxrxwzVDg5ujGzlEEO8Q3zkm0VGPOKxdVRmJ+7IDzjQ5rQlWe4bgBaKyD5s2qBcwEw6+UW3IqWiGtIBCccqMb3zg2vEOlzAnugMEb+XIG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OooG2Dal; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-364a39824baso5669916f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719517069; x=1720121869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKCAJpaKwvzXOOXv5ON0Cc0rgP0H2YAT/VEJFipgyWU=;
        b=OooG2DalalsZMjjv0urpD3Za1OxoPy8f2SaptyBwlPQBAuiGHhh6EtmBGieZD3c7i4
         kjv+9kQRcjVnQy3yi8Nsu7R3rhF8pDXY59JdYEPY00M6d5+uWqWy0eFmTdhEA3zKaZqF
         OtiWQavvH4Q38LKtVBZphVfTtC8fyawTN8g+hxoCiRXFXH69uQZRx6ui59VK5F3LuMdw
         Y1WBnZODDu9ri37gy1EL96REwadpF/K3+zLCoqadgWtJECIpfDhTnrkQiSk472+IbAIh
         kZo7p0U9/QILVqAnsZdZj6t1+hqQLXLQgeZ261A2qwB3+eDBrjnT6NmOEcAm4g+dufQh
         FKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719517069; x=1720121869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKCAJpaKwvzXOOXv5ON0Cc0rgP0H2YAT/VEJFipgyWU=;
        b=ZroI1PupHM93PN6AXJF9D6dpcICU7+JPWg9gEWwasqEeo8ygdowf0Ozi2cNCt1Mir8
         d984gmPcqoXa6/3IMOtveL07nZFFv8HxFuwgEX4Lmgb4by7KZRELfdzPFkI/QD08aZcI
         6YePto+QmQxw7YqEXfljAd5ozx58BIb5VV1HNNVa3bUvc9Lrr9wHoMrq2s1jd84CYnQD
         sEkC31V/jXqigUd+H6Czz8QVhY8wSg/5gtwJaeGQ2ydH3fLBp+KcsCSK9iGOwWjW135M
         s8Q3TIUEVHvNEQqG9VR0jAoVGrLYeOy6pZ7orj9PAamSSDanJicMx4XqBspP2z7ViaQx
         NsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7J68z+NfvWqNkW93vzMGKv7JrN74oyRetp4V3MYAJJsEsEL66o7Ej3hULMd1ZqMscmhfFubYp3W9qFmm7krzupdIy
X-Gm-Message-State: AOJu0YyGJOi0THUmLt9wdGWaOTYw/ZgRSi7YE4J9kZLfCP6Un+TtaY1o
	q4+WHra+oEJwwLSGPSDXmzSMXuxl6A6Xx7c2uyuxeK7leqqgej5uPWEq00YJu/ZD9dy1q13sF9q
	MBIOtff2IlfVtevtcWNI7OAoGjiU=
X-Google-Smtp-Source: AGHT+IHOEuCNXQ78SisVMg+wuf/5zJzPK5k7sBRGIZkYP8+1yD9KHhgMh3v59EjtNopUBf0XVI9OdJRTuyffP8R4w4E=
X-Received: by 2002:a05:6000:2ab:b0:366:ec2c:8642 with SMTP id
 ffacd0b85a97d-366ec2c867dmr10344225f8f.10.1719517069365; Thu, 27 Jun 2024
 12:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
 <e51d4765-25ae-28d6-e141-e7272faa439e@huaweicloud.com> <63cb33d1-6930-0555-dd43-7dd73a786f75@huaweicloud.com>
 <CAADnVQLAQMV21M99xif1OZnyS+vyHpLJDb31c1b+s3fhrCLEvQ@mail.gmail.com>
 <b3fab6ae-1425-48a5-1faa-bb88d44a08f1@huaweicloud.com> <CAADnVQKoriZJn7B2+7O6h+Ebg_0VgViU-XXGMQ0ky6ysEJLFkw@mail.gmail.com>
 <3ec5eed2-fe42-5eef-f8b6-7d6289e37ed8@huaweicloud.com> <CAADnVQKJOc-qxFQmc8An6gp6Bq07LSGLTezQeQRX82TS-H4zvg@mail.gmail.com>
 <57e3df33-f49b-5c8b-82b3-3a8c63a9b37e@huaweicloud.com> <CAADnVQ+2JoqJJvinPvKA+4Nm8F9rTrpXBdq4SmbTeq_9bw=mwg@mail.gmail.com>
 <a3eb33c4-b84f-5386-291c-c43d77b39c48@huaweicloud.com> <CAEf4BzZPno3m+G0v8ybxb=SMNbmqofCa5aa_Ukhh2OnZO9NxXw@mail.gmail.com>
 <00605f3d-7cf9-cf83-b611-a742f44a80aa@huaweicloud.com> <CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com>
 <ce6f4648-9073-fd5b-a26b-187863e7070e@huaweicloud.com> <CAADnVQJ0gLSNNCnKeWMrHeoGG8DRG8kBoWxo3y0ubat-PgBcMg@mail.gmail.com>
 <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com>
In-Reply-To: <90a50937-cca2-101a-799a-daf65956e6c1@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jun 2024 12:37:37 -0700
Message-ID: <CAADnVQKCY0UBY9rCOMQc5o-pOj=LR+26cnEJOC+Gx2KiB2Wrvg@mail.gmail.com>
Subject: Re: APIs for qp-trie //Re: Question: Is it OK to assume the address
 of bpf_dynptr_kern will be 8-bytes aligned and reuse the lowest bits to save
 extra info ?
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 7:16=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
> The first version of qp-trie had already supported to use arbitrary
> bytes as key [1]. The lookup performance comparison between qp-trie and

ahh. great. 2 years is a long time :)

> hash-table varies according to the benchmark result in the early
> patch-set [1]. For normal strings (e.g., strings in BTF or kallsyms),
> hash-table performance better. I will try whether or not it is possible
> to work out a hack version for both hash-table and qp-trie to compare
> the lookup performance first.

I think the real life use of qp-trie will demonstrate bigger wins,
since in your example you just sized up hash key_size as 256 (iirc),
but for tools like bpftrace there is no good number.
Users that would want to use file path as a key would ask for 4096,
but that's massive overkill. The hashing of 4096 bytes is going to be
more expensive than a qp-trie walk.
So from usability pov qp-trie is auto-sized while the current hash map
is pretty difficult to use with strings.
dynptrs in a key proposal might help hash map quite a bit.
At the end there will be cases where this new hash map with dynptr
support will work better than qp-trie and the other way around.

