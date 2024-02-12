Return-Path: <bpf+bounces-21751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE660851C8A
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 19:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E32E283684
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 18:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D93FB0D;
	Mon, 12 Feb 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsYAhSY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4A45BF3
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707761553; cv=none; b=RI0nM0NQi2lCZb2NL7L6Sdu4h0H9pxrMOGVhjKrkm/TfLCDAa8xgFyH52POKDF//BVzSAlaRiIFbpwE4eEloAjyUidIXK1VNpXrmXgn93XX43XchoPmp+HpSTcvVtyFudq5NTO2R941VLGNlEFYJlJ3Hx3QVvo5fWQAy4s266Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707761553; c=relaxed/simple;
	bh=qx2t+2xf1Vkjj7Tz3q+BhACRMcg/P3H4ADCrB2+NUKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lu8QxvBcJhCrrbLFT1CalegW/PsDI6TZcwdnzdAwNFNfgt9xm8FedFIQa9T8N+k6ImcU1XVIbpgRxNkZOY/0c3Q5X53baYokHi08mK6L7j1cW8/Tgy6icvbY8zjJLWcsSzrPsyB84Uz0jvEDuSpATw+RxFd5FYD9His0cA9yEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsYAhSY4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26f73732c5so481855566b.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707761550; x=1708366350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r++RqVTTRmgIAA96TrA9uBfy6z0w+8s1Y0IlIAISWKA=;
        b=DsYAhSY4/3ZY6pDk6lrS535zVCxi9eOafRpMzSr/fMqnpf56sET1NN2LbuHvHf3a77
         0POIFgl/6ZDZVWQKOAxdkeNWlXGutdZlecRs0fsicgXNAbtO+NKfM+4UcY0S6ag5nSOa
         BrmfDufxYnrsyfiJrRSn34YcVXS7WCtt8TBc0b7DqUSRIpm3t6VwJDJwiSBpd79a6L5x
         l3H6qcM9cIZCm3etSa9h29Vc+QXPQ4ZVBnWiRXYsSla1zXlZfDajMVvLtNPNo/FlgaVk
         y7i7rSARhCfSc+AFXZQyo5U6ID3fiGoEHzsd9hRO/WstHdKr+sWmwgnkNf1lX2pJmS8L
         l0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707761550; x=1708366350;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r++RqVTTRmgIAA96TrA9uBfy6z0w+8s1Y0IlIAISWKA=;
        b=L972v5CtNr+un3WyRjbKED7++l+/TzVfaFo53emzEAQGY5/eM7MORd6NztL0Y+lGEB
         IY9YbRs+49YVex4T7psWWfaGQzcp/LYxl0GKaKkm+WfPi9qeVpnqD7QuvN1B0dygZnSN
         oyuGOtqNChENgozeRrr+PacD0cny4yPtKPdIcS4rwUtOvSC6Eb1M0DU/ia3X9hQrxxWO
         xrNDyod1Omd2YnsjUvCuk0zZcR0Yh5++yFQzMHDEtbASOJPT1KM/1v/IuJpwWgsQygL0
         WFaipnSp7Wj02OC1F2+LVcQPWFBvt4mjxocvZ3bR6bx9dRfFOiUxvJ/M4XjWaVMZQrEE
         QxXw==
X-Forwarded-Encrypted: i=1; AJvYcCW7gH/3qNovRrJ2ae0bdK2SM62Q+9V0dvok3NILNyYDa4WtLbBRn3qjDXlGjPQzh84Yokj5sNT3TGfIm12Dhkpd1bTT
X-Gm-Message-State: AOJu0Yzyg07hyjedFvKyVVwJad1ZSewFATZSsxfxi8veuxPkwr7Crlpr
	yMh/JX9j5qZNVSvBB3ziKaGpelr0J1kaWJE7adThbSmyxAwPBY6X
X-Google-Smtp-Source: AGHT+IGsffcSjpQMeW19JrV2Xf+QsmR2my5S7mHLKH+jhdQoICPJ4mPnG7c7REPVTBy+DP1EkzGh6A==
X-Received: by 2002:a17:906:a40b:b0:a3c:31d0:592b with SMTP id l11-20020a170906a40b00b00a3c31d0592bmr4848274ejz.11.1707761549652;
        Mon, 12 Feb 2024 10:12:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqeZpSIOi0t+tR86P4W5Aaq9YfJMHgfLA62n7DEPrgs6jVmdF+3F+919/KglI0xfooT/iw2/g8wfR+G4YXM2/cdfE+fJ5oA/+TVtJlejv0dIFsTo44e4QJeZk8sP6O4tRJHOam3XLjz0hdQWEnS4wKSImpF2min7RGe+a32zxNtt26iT6drcdnth5Zq5tg7orwSiEnS/gmdRywGqlkVUp/Nzf8JAyCGqCtkbhdXjhLeOtQIvRrY5mhBxgn2onP9NFeJviajG/bCvAjCbOEjNUq3pLPHnESATeOWO8EU/iBv/BVqXw1vizqyCKfoAMBv6WDbpsfyK3aoCPXRpjp1dnwWzFMps1o1d7MN00SVvUS0Cv7X9JmL/5+
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bq24-20020a170906d0d800b00a3bd84233b2sm437715ejb.85.2024.02.12.10.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:12:29 -0800 (PST)
Message-ID: <59623808ebfd5ecd48cdb4c07a28326d777e7769.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 tj@kernel.org,  brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Mon, 12 Feb 2024 20:12:27 +0200
In-Reply-To: <20240209040608.98927-13-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-13-alexei.starovoitov@gmail.com>
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

On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
[...]

> @@ -9830,8 +9861,8 @@ int bpf_map__set_value_size(struct bpf_map *map, __=
u32 size)
>  		int err;
>  		size_t mmap_old_sz, mmap_new_sz;
> =20
> -		mmap_old_sz =3D bpf_map_mmap_sz(map->def.value_size, map->def.max_entr=
ies);
> -		mmap_new_sz =3D bpf_map_mmap_sz(size, map->def.max_entries);
> +		mmap_old_sz =3D bpf_map_mmap_sz(map);
> +		mmap_new_sz =3D __bpf_map_mmap_sz(size, map->def.max_entries);
>  		err =3D bpf_map_mmap_resize(map, mmap_old_sz, mmap_new_sz);
>  		if (err) {
>  			pr_warn("map '%s': failed to resize memory-mapped region: %d\n",

I think that as is bpf_map__set_value_size() won't work for arenas.
The bpf_map_mmap_resize() does the following:

static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t n=
ew_sz)
{
	...
	mmaped =3D mmap(NULL, new_sz, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANO=
NYMOUS, -1, 0);
	...
	memcpy(mmaped, map->mmaped, min(old_sz, new_sz));
	munmap(map->mmaped, old_sz);
	map->mmaped =3D mmaped;
	...
}

Which does not seem to tie the new mapping to arena, or am I missing someth=
ing?

