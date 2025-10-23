Return-Path: <bpf+bounces-71955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26CC0272E
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426813A81B5
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CC2DF146;
	Thu, 23 Oct 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l09m59LP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D222DAFC8
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236928; cv=none; b=Qxk28wTB2fd/Vy1qWIiohMPFNXpzwty5uHb9o1XJBbzGBvWZA18ABV9VmJwlbSyuM2HoyWLeBA3acpnkFhm2XaNC0jEEKnftkZmk/V5SN0s6ybyzBLk5n+WKcrCjXI5WhNufg9QqAMVngMZPxCKJy7OfUldGZUw4+eBCzZr8YlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236928; c=relaxed/simple;
	bh=63NV+cUupyziu+omg8nqL0ixV1A3QIcHdqVlAw7Dagc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fExAcBHFK5iqWe9lJiapJQ/IFmlZJwomuMa6mkC6ZQju0puhkDAWCc2J/zxKynEyh1wRYPj8iJH6F8GKmWyFLcUZUpfrff22q9SZZ9UAjyU0Q9mRSJ4Djeoo/bYj0bKN4EdTO/OUWLJraX/0OYv2bPEjseAJdQ9NIATrHsrCWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l09m59LP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1105523a91.0
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236926; x=1761841726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Em8aVnsPg6h7N7/uWYB8oyJdXyJBUaoBp3birjoLGA=;
        b=l09m59LPlMAblhcaxNMxYTk9aT/FbdRZ92+CkvrD6cCW4Dzp+WM7MjaJqVyojuZou4
         337/nFoNqWYbYPMISXs5LkwpzkXwD8CO45rLWL3pGhrcTfikbYPFBVV6FtneDEZ3oWBC
         T372xt6gM62Q6g44amFRyfZSBQF38jfOZz0QWqGpnqWdEuGZbQFJLgkCDmoxuvMylqnA
         qafr7oM6T1TLQqbnHZk+EYVNUfdO29AsSEX3qsD6TgACUfHDxxydXCCMrJNx8Q6fkjkk
         kjDhYJ/TBMxjNlLAsaNQHoR1acg+dyInebpj2e8TpBo69I+mMwqw0dDFFWQ8ET5RULdp
         ZPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236926; x=1761841726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Em8aVnsPg6h7N7/uWYB8oyJdXyJBUaoBp3birjoLGA=;
        b=d9a+QXobRtsbd/aNydQkIdUlS2gqkwBKdlhIWbYbO5NufX5/Q1GPsozVKk06eyPBBy
         7txbmW2hS6B8O29r5The85pAJSJyI+IGUNcHnYSzCoaVeLq84CKxHLsb+ceNaHVGxfsH
         qMw1Sk+PNqfL8iSBN2gAku2y+iZT7+6+fKCaSGEI2Ez1wQnxTSAhFTTUcJEXDoEd0QrY
         K5GeIk2gRH1rl/CFcIABmNP5T6NadHEm8h32QbRU40lpYchFF+k1H4x4Ga02Q/iYj0Ov
         UD25WxtzkHcvLE0mH75P3BBWHvK9mgnKeJh+LQ/Z6Wg0CULcqca9SZXuAaOUtE6Bj2kh
         XFdA==
X-Forwarded-Encrypted: i=1; AJvYcCUKGUHOvLP+sACpoizq3T99LYjEP+P4JQX3DcmzDx6ZtMtkYmzfXgO3f3nJi4xhMlC0Azs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKvEPzXaAgAi940nRHO/Q7kd4eud76gFFWvNa7cH0BECg8sxM
	Nl/bGQCANkynKIk+LiLQxtIPOeuLdT+ywxDWSDvuxOTTafGu1EZTVlmNF1T6tAbzxENPF7vqTvn
	uShINncEdhzAT9mN6VwNVtkYd+5x7B6BZaQ==
X-Gm-Gg: ASbGncsHAPkExl9EFS10LFWULpoIpPFvEGIBDJgYsH8jRsYHgYb6FIhpem98+5OOc8t
	9bYWbSyqB2JsrUCrgtui/vE9thx5d1nre+6Yul1NjA+RfECWICyLtqkhNy0XqlU1rOqtFH140zM
	0A0m+7RijO9zlgxfBaSyJYZAjPW/EpmUA/igzczqlwlkMUMFkr1xAl3PTXMeHeL35GW5/mYRUBM
	0/VhfC+Dx1uKryIWEnuRXCwRO0mtjn7Sg3E029q5AkExzl24WW62fn0PqHpBylOxB+TLTzNB9n0
X-Google-Smtp-Source: AGHT+IFlAVTw+Jxi+v6C1/6Bf81dYfI+9RDj02EdZzIhjQpUiAelOtgUEgVhekEHrknrIsV5fyIhFUoBeT1x6+CMKoU=
X-Received: by 2002:a17:90b:3ec1:b0:33b:a5d8:f198 with SMTP id
 98e67ed59e1d1-33bcf90b791mr29528595a91.25.1761236926084; Thu, 23 Oct 2025
 09:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com> <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
In-Reply-To: <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Oct 2025 09:28:30 -0700
X-Gm-Features: AS18NWAlx_LP4MbVy4TD6faRRP3spZFTyP2d7dWDF5qL_JOwSX3QL17uG_zT1tA
Message-ID: <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 23, 2025 at 3:35=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Thu, Oct 23, 2025 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> > > > On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > > > This patch implements sorting of BTF types by their kind and na=
me,
> > > > > > enabling the use of binary search for type lookups.
> > > > > >
> > > > > > To share logic between kernel and libbpf, a new btf_sort.c file=
 is
> > > > > > introduced containing common sorting functionality.
> > > > > >
> > > > > > The sorting is performed during btf__dedup() when the new
> > > > > > sort_by_kind_name option in btf_dedup_opts is enabled.
> > > > >
> > > > > Do we really need this option?  Dedup is free to rearrange btf ty=
pes
> > > > > anyway, so why not sort always?  Is execution time a concern?
> > > >
> > > > The issue is that sorting changes the layout of BTF. Many existing =
selftests
> > > > rely on the current, non-sorted order for their validation checks. =
Introducing
> > > > this as an optional feature first allows us to run it without immed=
iately
> > > > breaking the tests, giving us time to fix them incrementally.
> > >
> > > How many tests are we talking about?
> > > The option is an API and it stays with us forever.
> > > If the only justification for its existence is to avoid tests
> > > modification, I don't think that's enough.
> >
> > I get your point, thanks. I wonder what others think?
>
> +1 to Eduard's point.
> No new flags please. Always sort.
>
> Also I don't feel that sorting logic belongs in libbpf.
> pahole needs to dedup first, apply extra filters, add extra BTFs.
> At that point going back to libbpf and asking to sort seems odd.

Correct, I'd also not bake sorting into libbpf. Sorting order should
be determined by pahole (or whatever other producer of BTF) after all
the information is collected. So btf_dedup shouldn't sort.

But I think we should add a new API to libbpf to help with sorting.
I'd add this:

int btf__permute(struct btf *btf, int permutation, int permutation_sz);

With the idea that libbpf will renumber and reshuffle BTF data
according to permutation provided by the caller. Caller should make
sure that permutation is a valid one, of course.

 (we can also extend this to allow specifying that some types should
be dropped by mapping them to zero, I think I wanted something like
that for BTF linker at some point, don't remember details anymore; but
that's definitely not in v1)

This is useful for sorting use case (pahole build an index from old
btf type ID to new btf type ID -> libbpf shuffles bytes and renumbers
everything), but can be applied more generally (I don't remember now,
but I did have this idea earlier in response to some need for BTF
reshuffling).

Speaking of flags, though. I think adding BTF_F_SORTED flag to
btf_header->flags seems useful, as that would allow libbpf (and user
space apps working with BTF in general) to use more optimal
find_by_name implementation. The only gotcha is that old kernels
enforce this btf_header->flags to be zero, so pahole would need to
know not to emit this when building BTF for old kernels (or, rather,
we'll just teach pahole_flags in kernel build scripts to add this
going forward). This is not very important for kernel, because kernel
has to validate all this anyways, but would allow saving time for user
space.

