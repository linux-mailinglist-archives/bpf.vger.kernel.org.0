Return-Path: <bpf+bounces-64096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801D9B0E40D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB33AA11C8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08793285411;
	Tue, 22 Jul 2025 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnCD0PPf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85828507E;
	Tue, 22 Jul 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212170; cv=none; b=WHlcQTS3Kb+JeiT+d2cyTHVzJPYqaCiYRI1zFjduvi4VsIX3o3rlTkMWXAh22f9d3IM+tmBOcOMTVWBS/QD3tawEogf3ZImXUqnPpc5L3dhxaA1eVwpmqWsTbhgh/ACR+iPwwwUIuwluqoFocDSZzOAYPgFjWYYV2d78SYs3ppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212170; c=relaxed/simple;
	bh=nPRRlFzi/MFAWE4l1h6BQ6YpxRF+fnPS8IT2snHzg+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K7+sdONAty83eyBiYnY2w29EtgXgRMcnZl2t7MMXx5JCl5AGoGc0HoKTAyUuhBLrrtbIzX5B1InNdHkEt1+yl1SMmUY/c7wDCPXx697mnsb2g1kXznIJrY/z6geCHYF/vFRv9EFGJCk1swkZRlnx8PLIZNNFDmA5QG+gazC6/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnCD0PPf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235e1d710d8so63802515ad.1;
        Tue, 22 Jul 2025 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753212166; x=1753816966; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nPRRlFzi/MFAWE4l1h6BQ6YpxRF+fnPS8IT2snHzg+M=;
        b=nnCD0PPfy8L8UE0ai/H500OedJWpr94sOpz+xLoKSDhKcMxL8WUzCriimor7QFDl8s
         G62KlrImgfV57b5nHQS8YSts2UUrzOt6eRQo3f/e6TeJmQzZkkrXl4A8GdPXs9lLaC9b
         1//nEqTh285LBmrZelHV7fj/DbmXh02CKZw2tKGsV+vCE6ZjKnuwtM8xCwrCRaYwDtGF
         khjErLAgo9oHQCxqQUsIDEBq2Q4TFNY1EdXGVZYExcZGQrvbsj0tAAmtf2nIYOT93cyX
         ZGWsDz/wRZqXXlYxJaHAFwQOm4AphdRUssf4CWhcHUAGKmo8fpz8F0JTgmYA4wkwqfT/
         xkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212166; x=1753816966;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPRRlFzi/MFAWE4l1h6BQ6YpxRF+fnPS8IT2snHzg+M=;
        b=Y6p11+IO6qf/DgnmdM+Ull7C69r5podZreD5ulWvu49N1g8pRCeuD7D6mgApuRr0UF
         RLOcG2iJdzuj8LcC3SU77NQIsUqSxbJeXOHjqboPg0tADx8OTScJlUODqccWYu9SHT/R
         u4QivnOLx95Q2mIN5lU6qmqRPmxhcWXFCHf1jP82eSYS4mfEolvj3SJnmKiCZQC/CgGg
         J2DK6ozTDZE1v3bsHmkkq5TZtsT4b/SjlgWEkBYXxt8G6c8GtZarmldToefQZ0nH5A3S
         EX2RZwZkHBv8or5dPD+GF4mUZOxmt5ulUiddr+S7Q7NkznrvCdaArSiD7GOl7a8iY0Vv
         VckA==
X-Forwarded-Encrypted: i=1; AJvYcCU93l9PS0I4CHvvKNO8RRbilhb26EHTfmIhMs/YXfycsh0OpLAHdveR/FN4HxX85k2R702NOB4N@vger.kernel.org, AJvYcCUMoGI7kmmghbyDobmFYQ0uwDL5BzIVkpf5vszNzfm3Fw/Zdv4FsF66hHYs7nhi+pdeva8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcGyKGhfSAwhkgD3+w6bCVfj8KkphUZ14aOwf7B4Q1DKSRAqtQ
	MEdg+KHVHwEPkDCcUeGQvJCIxhXAtISBW5bmhKD6td8FvtxKhJXLFHFo
X-Gm-Gg: ASbGncuJ6RCjqlf8WInkStliCYRJXsMumQNLwjjDhxrBX84CKWRu+irBbzXNU5qU9cK
	eGOGG1LxG2j2QqY3HXD4IcXS+QcXb1fywlXfNptmxPZs1g5dB1GlADdgQy2ACB194dXZFZi55UJ
	dREWdTHXGLw/53O825HgXweD+wuxip/Y21SM7+8wy3zdKufP+ZFtWXXphzFnAaVMV9cMLHS20TI
	hIABquubgarUkkT+hbSMJPeEk96YxWDKSe0RoLy1S3KMalbhBDPnjhzF2sR62CewggZqOpTP9mV
	s7MwMgfvlfsi6xbYpe+jHTUPcUIODS5I3N5UU4Gg56R76Jz8QBHvy9B/1PiR9l3ezGf7V6vrfSx
	xNL/O50qCQUEJzWhQzM6+b4V6N8c3
X-Google-Smtp-Source: AGHT+IEQy9nRlnkXXcl4GZCMRPbmVoad/npYGc06ZCPKWomnYv/JylvSPwoueVt5TLTE8Cbeh44Gpw==
X-Received: by 2002:a17:903:fab:b0:235:779:edfe with SMTP id d9443c01a7336-23f981b4139mr2353125ad.43.1753212166414;
        Tue, 22 Jul 2025 12:22:46 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d7asm81880235ad.1.2025.07.22.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:22:46 -0700 (PDT)
Message-ID: <6f7ee402cc9c84b8c9a6747141dc3f7ff866e737.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/10] selftests/bpf: Cover verifier checks
 for skb_meta dynptr type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 12:22:43 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-5-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-5-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> dynptr for skb metadata behaves the same way as the dynptr for skb data
> with one exception - writes to skb_meta dynptr don't invalidate existing
> skb and skb_meta slices.
>=20
> Duplicate those the skb dynptr tests which we can, since
> bpf_dynptr_from_skb_meta kfunc can be called only from TC BPF, to cover t=
he
> skb_meta dynptr verifier checks.
>=20
> Also add a couple of new tests (skb_data_valid_*) to ensure we don't
> invalidate the slices in the mentioned case, which are specific to skb_me=
ta
> dynptr.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

