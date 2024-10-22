Return-Path: <bpf+bounces-42770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08E9A9F45
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 11:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1911C2521A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96D199FAB;
	Tue, 22 Oct 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjXhMvob"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7F1991CA
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590880; cv=none; b=SW9hdAOFwr3fr74HpFZAUCvz00MQlPPqpwfZLJxegOG0eyI+lr3VNQfsEdjuA5LbXuyWjBbYubFoaCwpeB+/afv1KRxuaGO3KRlATzG3KO8eh/vYDlXt3VcOA3sGhPubjpen0UIrhjhh+//lAhbhlkGYinPi5eQ79r2eu/LG5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590880; c=relaxed/simple;
	bh=GAGDd9qAHbzHW+QycFdG+EuJQmh2dbWiYdu9oNWGvIk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6PJM9m38pt4Zf4G/EhmFdtGKq1BOY0CgKIcUYJ910GGwkpmuYkp9yli2sWpW/DwVHqHZVp7oAyJ3Q+m6DFUffqZIwAwz/Ej84IGunu5alO6p7Zs6Eamq7y4pa0xvaUMkVWGbZy1PdMAEmZiEMgv5Qd1gPAtJJdVrgOX6xdu1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjXhMvob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nI1J080gJIk57nqPokRMkIaqBAiA6XyP9b3WtLdFdmw=;
	b=UjXhMvoboq94i/LBw9SAebGz3cR/Vgruwt6fjOgJpGWFldUt/lJ8DzlFAubVGoEbbR5L1I
	SZcXNEdjOXx4QyirKmUKDGjrjUHB+ckk1WczOaZDJnbiKjSAA6MnLvn8BwXefv/QrRle5i
	0xiQwXwuabxml4qHYnGJwwJjXlsD394=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-fKWir3jwPHaeXIqUdGh7Sw-1; Tue, 22 Oct 2024 05:54:35 -0400
X-MC-Unique: fKWir3jwPHaeXIqUdGh7Sw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316138aff6so34168935e9.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 02:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590874; x=1730195674;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nI1J080gJIk57nqPokRMkIaqBAiA6XyP9b3WtLdFdmw=;
        b=Rn5oMpcg5wnGXw67Bz+vBFjwVTSVW+WGQdtqRv90Jp8i3sTNhnxK6G+VEN+MbmxSry
         tPc0VqalEGZHXhTMCE4cbbRjZKJRJ8EsX4WnM29X4oA3qtaxsBcSaR1E2y7dStn90uf8
         GHfzW/uIrOprGOmWPhbjtqLqpai4EKmc1oLdDWGu18qzxraQ3Utjejcl3NeKP1GKQG6L
         Z+hExQfl8d7czGfKd8ehPDVvsGbRw7lbG2JS9B4k35mr3JoBAcQhpmnjqsHkxiNjJy86
         b1ItEI3SHlXrs6h48gCP9bzzDymErQfsY3m+Oxez//D0EAMAjfY/1NhfnXaM9rLoSL6n
         rULQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5BsJ6+rfIUSZ++sgHWdVkiczsCFkWhFSDxtL+BYP46biclkn1XYfbxQSEGXF2Cg6aZPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZY9BZWpLXJNj1KpucXbtQ9ihjlT4UTENxjo19Ag4JGGKuXN9
	PQUt0Y+vc1wnKf4ziit/mNo4WR1fa5KTVx/Jo8cpbFL6kWqyEf7RuM4sQ50/CvZvK18/QTW3JgY
	hdYzsfpKXhZgZGRhJI0eEAx2awM/1enRJlFzmA81cDIBpFWD0EA==
X-Received: by 2002:a05:6000:1a52:b0:37d:53a7:a635 with SMTP id ffacd0b85a97d-37ebd3a30b4mr9041580f8f.51.1729590873990;
        Tue, 22 Oct 2024 02:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/MSC0f4a4ghBH8Njw0NZeddYxIlEatBvFumhTXQ8ieD1rzRQxbyN4pCWfCENi2prg9FrCzw==
X-Received: by 2002:a05:6000:1a52:b0:37d:53a7:a635 with SMTP id ffacd0b85a97d-37ebd3a30b4mr9041534f8f.51.1729590873489;
        Tue, 22 Oct 2024 02:54:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb66sm6197474f8f.95.2024.10.22.02.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:54:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 546B0160B2D1; Tue, 22 Oct 2024 11:54:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Puranjay Mohan <puranjay@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Eduard Zingerman <eddyz87@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>, Helge Deller
 <deller@gmx.de>, Jakub Kicinski <kuba@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, netdev@vger.kernel.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Paolo Abeni <pabeni@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Puranjay Mohan <puranjay12@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shuah Khan <shuah@kernel.org>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/5] bpf: bpf_csum_diff: optimize and
 homogenize for all archs
In-Reply-To: <20241021122112.101513-3-puranjay@kernel.org>
References: <20241021122112.101513-1-puranjay@kernel.org>
 <20241021122112.101513-3-puranjay@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 22 Oct 2024 11:54:32 +0200
Message-ID: <874j54iht3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay@kernel.org> writes:

> 1. Optimization
>    ------------
>
> The current implementation copies the 'from' and 'to' buffers to a
> scratchpad and it takes the bitwise NOT of 'from' buffer while copying.
> In the next step csum_partial() is called with this scratchpad.
>
> so, mathematically, the current implementation is doing:
>
> 	result =3D csum(to - from)
>
> Here, 'to'  and '~ from' are copied in to the scratchpad buffer, we need
> it in the scratchpad buffer because csum_partial() takes a single
> contiguous buffer and not two disjoint buffers like 'to' and 'from'.
>
> We can re write this equation to:
>
> 	result =3D csum(to) - csum(from)
>
> using the distributive property of csum().
>
> this allows 'to' and 'from' to be at different locations and therefore
> this scratchpad and copying is not needed.
>
> This in C code will look like:
>
> result =3D csum_sub(csum_partial(to, to_size, seed),
>                   csum_partial(from, from_size, 0));
>
> 2. Homogenization
>    --------------
>
> The bpf_csum_diff() helper calls csum_partial() which is implemented by
> some architectures like arm and x86 but other architectures rely on the
> generic implementation in lib/checksum.c
>
> The generic implementation in lib/checksum.c returns a 16 bit value but
> the arch specific implementations can return more than 16 bits, this
> works out in most places because before the result is used, it is passed
> through csum_fold() that turns it into a 16-bit value.
>
> bpf_csum_diff() directly returns the value from csum_partial() and
> therefore the returned values could be different on different
> architectures. see discussion in [1]:
>
> for the int value 28 the calculated checksums are:
>
> x86                    :    -29 : 0xffffffe3
> generic (arm64, riscv) :  65507 : 0x0000ffe3
> arm                    : 131042 : 0x0001ffe2
>
> Pass the result of bpf_csum_diff() through from32to16() before returning
> to homogenize this result for all architectures.
>
> NOTE: from32to16() is used instead of csum_fold() because csum_fold()
> does from32to16() + bitwise NOT of the result, which is not what we want
> to do here.
>
> [1] https://lore.kernel.org/bpf/CAJ+HfNiQbOcqCLxFUP2FMm5QrLXUUaj852Fxe3hn=
_2JNiucn6g@mail.gmail.com/
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Pretty neat simplification :)

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


