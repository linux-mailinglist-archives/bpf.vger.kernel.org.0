Return-Path: <bpf+bounces-77129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A1CCE7E4
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 06:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F043034EE8
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 05:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D22C0287;
	Fri, 19 Dec 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaJtZkLR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A628FFE7
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766121052; cv=none; b=tMD5r4TQYelOzURSkdUA17RL2ELu8aDa5weLCkASL687BeK3XHgM0CrMHQyt5k11N0bSTD1FR7LbqdMq7Jde9TaK6spunEiBSuHBmJpYGjOWc2oMCoonrGUJcPz28fjdoHNm9wuNC4a9fjXLAygiRKJlx1rZy+A6A0SlFTzc5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766121052; c=relaxed/simple;
	bh=qEUyizdVX1RksmYQISCMzcUNY+XkJ49aqsaIUBWwhok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqbHvAQZNYF3K4IYRWGSIUcTGmDfsIpbcNHg5xC2DxmFuJjDTk+glOv/HGao1mouvuomKBz/YWO5BhWfBYq6C9vsK17ejVvf9nZs8GWDRmbSGu9omCIWON25GPNMSfgtT2qCQ5emKLM7PflxwyFNTAX6h7YVnC77Alg0m8iSuBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaJtZkLR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b736d883ac4so248810266b.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 21:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766121049; x=1766725849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irhvqlm7Fs7sIy3aRbgFkrNI1veHDT7aD35c7SPPpq4=;
        b=KaJtZkLRo+UiH5AHjYgz/TTOGtLBZKRiYtec59R7FCTP881cJvuJeNFXh2NDr7D9xZ
         DI9vvoftIX4MhNDSvUoZsAstI+XMBxoWUSYTX0GYHJK/8XroJXR2iDD9FQKiW2iQxmGc
         TWQ9JHuPzopwAMM8H+h9t5BFSXRqd6tk3RPxovsHqsNt6k29x3I2hNAnp47Xo+Ciec8Y
         LqSdZTJi7FegGpnF9FwtE4qyhjbPozmXAHIZPh+6SkxXA+cDrebAYj/8fuolNI0EOWXA
         3jrZKn09a6C9MRNJoKC/NvLMGYc+l12Thf/dLJ0jWSBQBFBp9UAv0ZyeeuHqLoaNzEiB
         aUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766121049; x=1766725849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irhvqlm7Fs7sIy3aRbgFkrNI1veHDT7aD35c7SPPpq4=;
        b=HjuNmoDDBDNz/yGazNGewHfsiG1OAGsO7cR9uEV6GAO0SA31IAM1IQ3T/RuXV7/AJt
         9/hOozY1+IYVKJ2IKhtz/ZenGEP8lAo3lgHWA1ZGOjpaStE/fSnNrb5h9jf58mMuzpXs
         9mGBeQP1au3kMqvPwkbxOZ9d6CyOkREXFH0L55PAbRxl8stq68bsPTvfe6epa49oYnwp
         0/wjOhtajYjD1uxyaoe3C2oZHUOPwZPcMprVH9o7MqUnPdVxUpgCDe4OV46yquQaL8Vu
         BGzJSfcz4ka/08dKgTn6YrgFHKl6qIHMbJdKZWp2uCragnYQG/JuMaABhAkGUsXm1mjS
         oOUA==
X-Forwarded-Encrypted: i=1; AJvYcCWzjzBTgMRc2LHDFf99SDZ1Mfv1t7kM0yXZFNUIDjBRcpM+K5t1eBcuRm0GBd6TWHpzz3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiEkdvOxthe158mP9Z/OVjGkr3hfNwz9HaKIu6lzd21wuTHrC
	284AJgfzcVl7VHHIb53b+lS39gZ/arPKvo/aTOoZFvjgadEGUGiDD9jfSHiV+vnaguXWPvLXV8m
	KLRrZRDHpCRktld45PLnSVVYc1YV0To0=
X-Gm-Gg: AY/fxX7L0+//obtK9K5JXa7TEegsXE/uBlMCZ6JVpEPKP78ZMyJSudscfIdJdultT3R
	a35YCb8Z/VR2H4yFmZFqqZNhAIQ5EoFRZLAVYvL+UOTOh0jMNqe3fbdOcbRJQXto56rV8n9Be8c
	fblo6c2IgYq5rwXV6A/7gHEYzP+EzXzuHwEhaKEXyN35H/oKHnc0pQOI1CY/adhhBfv7ndYWsDw
	eimvbqgAnk9YnYFNHMUTUghw9c63gYoftC8AOBm8KTNtVOkP4q2SBu9LLfnUa+Ry1WMDBQi9Igu
	HgbeD8Y=
X-Google-Smtp-Source: AGHT+IF+JpGBqamKonl5nDeXWu9sBLts2jwC6AoTYqagYqU/FG9fkBGULQfDryJ7Hd/dj4Y5cphYmCpkq0vzYvevoA8=
X-Received: by 2002:a17:907:9406:b0:b73:9792:919b with SMTP id
 a640c23a62f3a-b8036f0a57bmr155817966b.13.1766121048665; Thu, 18 Dec 2025
 21:10:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com>
 <20251218113051.455293-8-dolinux.peng@gmail.com> <CAEf4BzZopn6gi=xf-OakYZtyv5bMy9HojSfvGznv1RiOcF5sew@mail.gmail.com>
In-Reply-To: <CAEf4BzZopn6gi=xf-OakYZtyv5bMy9HojSfvGznv1RiOcF5sew@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 19 Dec 2025 13:10:37 +0800
X-Gm-Features: AQt7F2ryWZNkbwvM-uKvlfXy1s4b4Gd-0GjixxW5MZ1wHUKs1CjKQoeRbqZ4O3s
Message-ID: <CAErzpmsfGEDcaiAfYkfKcQStVEajHTP8MdTd4spLpPdBE1+NMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 07/13] btf: Verify BTF Sorting
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:46=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > This patch checks whether the BTF is sorted by name in ascending order.
> > If sorted, binary search will be used when looking up types.
> >
> > Specifically, vmlinux and kernel module BTFs are always sorted during
> > the build phase with anonymous types placed before named types, so we
> > only need to identify the starting ID of named types.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/bpf/btf.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >
>
> please make sure to apply feedback received for libbpf-side
> implementation for kernel-side implementations as well

Thanks, I will do it.

>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0394f0c8ef74..a9e2345558c0 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
> >         return total;
> >  }
> >
>
> [...]

