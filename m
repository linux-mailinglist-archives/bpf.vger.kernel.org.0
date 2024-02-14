Return-Path: <bpf+bounces-21972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA1854C38
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE41280D45
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207FA5B671;
	Wed, 14 Feb 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbmNXEfq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD85C90D
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923458; cv=none; b=DiVMFeMTs8R11S0ayJWAPpSI9RkDjYm7RIlFmXPZPOGPkIbDl9PaIRgG+9din3b6As8mXNrD1KQFsJGTY34d2/XThjTbQvz5+3mr4cCd4vwgatExNYAoXC3BTwjQlFzGvgRELGKL1XVKiQM8xpBvot9+bidHCOA02CJVVX70JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923458; c=relaxed/simple;
	bh=v2PHgB/y3KnM8yAwjMXmh6chghdENtJrpYwteuh3Ui8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOBq++fAYlMSIKi8D7u8dXC79mBKKtE17+ge3J3a5J7zMCk3ySnK/rD0+91GNfepYIRkULpckLr0ptHDvz3wBH2/WliwF4kvWZ4Y1ezw7j4f//MZnjJe5Cui/C7d+JqazEr2jHJYrHbXjSyVeo9Za2VKlNuHrJWdAVQvtr1B52Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbmNXEfq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so7775819a12.0
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 07:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707923455; x=1708528255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AWZkLf2us1lAFxTy2XX4HHRisAmRshkgQ+pJyeoLs78=;
        b=GbmNXEfqUFsLXcvtJWfKratEySvK8E2KIysGIjhJhheKDm0gnebQiG25Et4z86pvox
         oC62gBodDzr9WKFAoZVEl/vvYmt5KWu6iBpDbX+lG36V5SeqInhlkkbSYoQA9GJvLooB
         2adaXhGd927CqOudE3/kKugOQMmAvgg4HJ7YvoLngCZqwGVcN13CcmmicCN8aK5NL/Ao
         v80XP8+ORbvX/ctCf/wy+wzXVxxImx7FEMHgh4MSPGrXrNAK8OV3pDBqhWuYwPlZI1Oc
         +YDWTOcsRUt8BKj34julKw/1IjJH8Dm5fSgrgOmcy3Izrie2EQR792Qyn7lzIpdrm6Ms
         fZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707923455; x=1708528255;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWZkLf2us1lAFxTy2XX4HHRisAmRshkgQ+pJyeoLs78=;
        b=OP7tQ3Tqvx6lOVVFvuaUv5yRlBajMu9XMWG3P13IBBRRxAhB8KYp9RhEE0E6lYtLsV
         saoEbOVKxKsUQo1ltxwM/RaWjlmnrWcaAAzQNkINEGOe5qud2nrPoKNKiTTQ4/pFAcxa
         GZlr7TzmmZpu26h9OeZo7e6IESN3UVRNE5w49ptyi88feP6pNCOBb4WeqOLDNjmDbpD9
         15ZnCEXNvwtHEtREGBEvfoLscyNgqXs7eEwnGWcuFkSK017XoaJeUxKN7CZnQB0Twjdu
         OUswiOtkjxb+QuAlRe622A526uTi75Vg2EbqovpLa5li3FkVyBGKTxw93SVUsJdAqDci
         QWxw==
X-Gm-Message-State: AOJu0Yyht5bzWOQKgrixQ5eJJk0JgAcnFAMt5sGHWmtY87bnEhUIXEQZ
	uaKKf41e0Xvgz79P5YTiipU5uKnSzkLXwoWZP2qdVbUtWT2RvhqT
X-Google-Smtp-Source: AGHT+IFN5SJsXH9/K61HOo9KJHOgwQ2JquQMvs9X1rk0p7aTytbNjX/HIQiphFFDZJhZDnmpOCVt/Q==
X-Received: by 2002:a17:906:e086:b0:a3b:ff1d:43a1 with SMTP id gh6-20020a170906e08600b00a3bff1d43a1mr2249861ejb.53.1707923455009;
        Wed, 14 Feb 2024 07:10:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTbPzHCKdwgb44WwsnwrGEP2Vumn24N0tjgXhVvsEgy59jb4wtDKsW9buQI4eXebISyrpYhFMofXpOKYf5BWMoGM1vdQhxlvJIXsao1uGDIBG2s0ZzCNs1kKGw70Ci0Jq3Y/9RzpehH6epyxJs2XKlCnfV8JX7im27FvE7AL1hjvZ1G/cqeb2pSWFK4BZK+eBL4SLjBTu3GoWs6SkfZR7lT1lkr6OXLldDH63h0Sx9XavhX+NiYkYfzo0bU5cQ4uZ1/GktTvg1OfwYz2ERkaaC0+gsllTbhtefVY4zE+dnmfbvtxZ7pCZqYFBU2O1rRInYJ5+7FzHa5foiujqOcv+RuZphcVDyP656j0B1xXWeuWE1xbelDRoVEA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id vi13-20020a170907d40d00b00a3ce1bef210sm2263230ejc.28.2024.02.14.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:10:54 -0800 (PST)
Message-ID: <1f64dbe4a9eaa29a46e1985a5534fba14295ed9e.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,  Barret Rhoden
 <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Wed, 14 Feb 2024 17:10:52 +0200
In-Reply-To: <CAADnVQ+jDLDK9TXCjRWsLg9SK4N1VHgiSLoqqdGfvtUpKbmLaw@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
	 <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
	 <CAADnVQ+jDLDK9TXCjRWsLg9SK4N1VHgiSLoqqdGfvtUpKbmLaw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 17:02 -0800, Alexei Starovoitov wrote:
[...]
> > First is regarding initialization data.
> > In bpf_object__init_internal_map() the amount of bpf_map_mmap_sz(map)
> > bytes is mmaped and only data_sz bytes are copied,
> > then bpf_map_mmap_sz(map) bytes are copied in bpf_object__create_maps()=
.
> > Is Linux/libc smart enough to skip action on pages which were mmaped bu=
t
> > never touched?
>=20
> kernel gives zeroed out pages to user space.
> So it's ok to mmap a page, copy data_sz bytes into it
> and later copy the full page from one addr to another.
> No garbage copy.
> In this case there will be data by llvm construction of ".arena.1"
> It looks to me that even .bss-like __arena vars have zero-s in data
> and non-zero data_sz.

I was actually worried about second memcpy increasing RSS unnecessarily,
but I missed that internal map does:

  def->max_entries =3D roundup(data_sz, page_sz) / page_sz;

So that is not an issue as bpf_map_mmap_sz() for internal map is
proportional to data_sz, not full arena.
Sorry for the noise.

