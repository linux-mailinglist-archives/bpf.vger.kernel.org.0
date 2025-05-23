Return-Path: <bpf+bounces-58845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84921AC2852
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B716F4F5
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 17:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8E2980BE;
	Fri, 23 May 2025 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMvFsIvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2371297A4C
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020425; cv=none; b=DneCd5TpbbWxD+JwgWu0DTD2bS13tuBpqnpBIlEU+papDN88phLtUmMIN2IGPCCuPDX5RHtqi1uF/FjT8rjcQZXgFbvKp4JHS+OZhALMVFQK+xy5zpc+SCm7IN2UOMPXf76ALSRHS8DpGpwxtZ9zRgTe+xZYJ1GTaDHC4mwSKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020425; c=relaxed/simple;
	bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOW+w3YY9WKEzQNva/PpZ/gE8qkBwpiO1A1XVH8J7VI5T208W3JbTcg6hetcEqkxqLYyA4oaxIDp6lydnXyMhbEQNkj9sixa+QPno+Fra9U/k/77AZ9KUGndUWYp5TXErwyhdqyQISIs/IwowbtCY6DnuK30TF4V3tPG1ay+Ku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMvFsIvR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234050cb45bso8825ad.1
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 10:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748020422; x=1748625222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
        b=GMvFsIvRFkw5jOSQUKELMdp3vG5J3omj2HkoA9Gl/g57Cd1dR4yaYFB/ad54YlHDob
         clpUyhL6kpvUcHXFO0uppzUn9AsCX4EfDW7hrtqeje3H3gTAEgXZTsYyYFLbKLGtznBg
         Y7rgPh3W809lzwCs0gmwgjzOSqUatCtIrCP4dgbxxPgRrTlL8RZoj1yoPd/TvGiGM/2m
         cg70+tMGZcUygKrj1Z85J4+X9r8Va1bUve3mdf3HkQwo6ydQUZIkKt6Kj7xBMCHmfk1L
         O3oYiZX7jNJmbLyd8oeiX4i2mHNwGRGSAbgkSYjD0BT8KWMdpbrAGpEpKbzRlwotYsWR
         APFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020422; x=1748625222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6+odg8Uy4SxwN3Tk8MC1g2EyZZcGTBLhKLUpCK3vWw=;
        b=mHr1Wpp3SzIM3AWZrrax6Pc1OoElIkDdZkW7keDGuEV6/3BMfsy3PFOrPvKeLMtkFd
         7gtus0MJ/68TPj/dQmDQf0uppAU8QeUUv3qhpCKSjeZRkBX8OTmnLPHBNKbWr8Q5pXRu
         IcBiNQic/bE2OiobnB3kt4cMGimqEgc/PgKel7uUnzu95GX3n0Pfth7dB7HfPJb6SkYw
         P/B21xiC0CC7NGL6CaJzLwNniywk5BCb3MVH+ZTfu8daURdB/ai709cpBPeL2NG/weo7
         ouTE2SJLjKANM2gAVYk03TZsgIgsAFB/GzzgrXKil5xAA6m87WBCAKlf6aNG3hkSjEwI
         w/hg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRd8HboxWibVDPH78pGI1ejFzkTXmlifD6nvIVBN7glgGuISq0L7BEQ1SXsp1ofxHIn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZ8uvW8Eohwp/LqsTZ6HvqyCKdDb0vg3wA+XQ/JMuIoqrFeC1
	y/U/Gy2wxd/P+aV6SBwlsfnUAGUCNquH+W+Hez0q0iGQYr3qzAsDeY7/JEh2ZVBeUgENdIMWXnD
	vsJZjW1iIJKgVjS/235JcMf9MJ43rXQb7v9dCZHzt
X-Gm-Gg: ASbGncsSk46j95sFW0fMuTKZ7VevoLiEkV6tHwGcvVItQcsMEAoUlhsc3szCXZ9o6bi
	ti8gsgHKqcPc7ZLJtoSAA83rKwi47pkPAwI7oqlmHInLzx5wFjBteqbqfPiMJhHIE6nmc6LqLUr
	yimBeaCpd5esU8bm7JcuG4cBCcK3dYNk4vR3nmdF+2mKsMzenoeIXsHdHUlDMyv1EBOSdFzZVNI
	g==
X-Google-Smtp-Source: AGHT+IHAljnGYXYXNqd9nHJuWOzFhZwP9BJe61GK3nUJDrt7+9et104XIn5ap3VmMUMS9tlMLC62sQxv3IszoNXzfZw=
X-Received: by 2002:a17:903:2348:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-233f34df516mr2604685ad.3.1748020421823; Fri, 23 May 2025
 10:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-14-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-14-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 23 May 2025 10:13:27 -0700
X-Gm-Features: AX0GCFudL84CRA-sCSeMtnKfh8Fbbgk_GwqD2a3SUOuPIpK4U4Fi3ZaEYQxBmmA
Message-ID: <CAHS8izOX0j04=KB-=_kpyR+_HZHk+4hKK-xTEtsGNNHzZFvhKQ@mail.gmail.com>
Subject: Re: [PATCH 13/18] mlx5: use netmem descriptor and APIs for page pool
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> To simplify struct page, the effort to seperate its own descriptor from
> struct page is required and the work for page pool is on going.
>
> Use netmem descriptor and APIs for page pool in mlx5 code.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Just FYI, you're racing with Nvidia adding netmem support to mlx5 as
well. Probably they prefer to take their patch. So try to rebase on
top of that maybe? Up to you.

https://lore.kernel.org/netdev/1747950086-1246773-9-git-send-email-tariqt@n=
vidia.com/

I also wonder if you should send this through the net-next tree, since
it seem to race with changes that are going to land in net-next soon.
Up to you, I don't have any strong preference. But if you do send to
net-next, there are a bunch of extra rules to keep in mind:

https://docs.kernel.org/process/maintainer-netdev.html

--=20
Thanks,
Mina

