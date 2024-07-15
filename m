Return-Path: <bpf+bounces-34813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC39312F5
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1128E280D00
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E29187342;
	Mon, 15 Jul 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paqvFbpk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B127442;
	Mon, 15 Jul 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042431; cv=none; b=CKWezncLGavY9SdRg+1TmIS3vDsHhQw0DEmogDdOCq5qssiyb4J3yxTB5BDkkWVZXRlp7PgkGHt07VJmPPaQINWVdnBj1A9I54voL5UZNNCLhYozjsnn5/HVOx+myHh6ziZi9YMvQzmYpxtp3hgGZ2fD85mEiQyIdstsP5/Wn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042431; c=relaxed/simple;
	bh=7eguIQ2xoOUfecfsd01wQy5L42kJFfx1H9OSQO5PTTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBZffWvXoaOQsUCkaDzZEja5TZQJKgKm3cwG9lbeXJN1CXgslPdl/J0QNbbF+HXC3OJEC8M9YiOCnf/KU0NZtXknBeEBGSEZoEgHKYuBUyY4ZDlsAY5AFsnx/yeZWNEvRd+GtsmZYe/Hq2wvZ/mg6aS80i04fWTGQ8XqdvT9a3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paqvFbpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EDC4AF12;
	Mon, 15 Jul 2024 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721042431;
	bh=7eguIQ2xoOUfecfsd01wQy5L42kJFfx1H9OSQO5PTTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=paqvFbpkVJS/6Qe+892Fe+C4Yrk9KWu3moT8dLFkE4nbgEEEeZVZYuaR8rI1ANHNO
	 qpPF19g2A5Lys/0pE8cjnbOhGSyxA/h+uC4rvmeO9mAg7izlnxGTH9ZW4biFFSIGJw
	 oEXqPUlDuW9gbilu7axZZDTztLxCJX4x/215Sy3wJDjhZT0wKdjp0Qx4pEbNc3L1ki
	 9ggy6AkwP8BGvjwKggiEzFfkVEz0mKA+Z+jSnUK72gw9GUDh0UpqR95a4jBSLvIV4G
	 NLMmYMB0/pPVKCbdTOffE/QvSP7PlZ929F3EMa5sms4YyYROpJaWLt/f20/XgnIjWu
	 kFfNTVsWNV0FA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52eafec1e84so5573204e87.0;
        Mon, 15 Jul 2024 04:20:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbv/NYkSSmoiv1AKbbkPZJ6wAe85f/Q6jePyOPmC7JIR7HQ9B9Wn7bPLI/QxGxsOnxVuvsoCKSXDKbTHRz9rrZWYpE7flDIhCazesRFFhRVX6+dHTCwNFprk4ArO43bkE/
X-Gm-Message-State: AOJu0YxU5htbgpxODE0IiChXNKsbfiOdxVstc9e6NPGSpUxbDNs+tJBu
	D95+rFF3ZbaIdBtYw/6cN2yY9DWxxgUT0sdqkFJLtSREWpb2Hzkfh5VcVfP9NF8ci/z3uknoKAT
	/1gHOHizN3aqe1GxBAlONdZFuWHs=
X-Google-Smtp-Source: AGHT+IGtsZdqFyTpa304+5S26IRWCs6lxAftK+siku8na9Pil2DzVNnMDzsXHp6bxoEiBiT1jtIPyS37t6LApMB3Pd8=
X-Received: by 2002:a05:6512:3d01:b0:52b:88c3:b2bc with SMTP id
 2adb3069b0e04-52eb99d151bmr14507713e87.48.1721042430066; Mon, 15 Jul 2024
 04:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
 <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com> <21ec0d92-fb99-41b3-b1b9-3b8a4504271c@oracle.com>
In-Reply-To: <21ec0d92-fb99-41b3-b1b9-3b8a4504271c@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 15 Jul 2024 20:19:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-pOi5a5vm4y1vPXh7WH_qtPuvnen3hvp9LrAm4+Q2fg@mail.gmail.com>
Message-ID: <CAK7LNAS-pOi5a5vm4y1vPXh7WH_qtPuvnen3hvp9LrAm4+Q2fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, nathan@kernel.org, 
	nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, asmadeus@codewreck.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:49=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 02/07/2024 08:58, Masahiro Yamada wrote:
> > On Tue, Jul 2, 2024 at 2:32=E2=80=AFAM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >>
> >> Reproducible builds [1] require that the same source code with
> >> the same set of tools can build identical objects each time,
> >> but pahole in parallel mode was non-deterministic in
> >> BTF generation prior to
> >>
> >> dba7b5e ("pahole: Encode BTF serially in a reproducible build")
> >>
> >> This was a problem since said BTF is baked into kernels and modules in
> >> .BTF sections, so parallel pahole was causing non-reproducible binary
> >> generation.  Now with the above commit we have support for parallel
> >> reproducible BTF generation in pahole.
> >>
> >> KBUILD_BUILD_TIMESTAMP is set for reproducible builds, so if it
> >> is set, add reproducible_build to --btf_features.
> >>
> >> [1] Documentation/kbuild/reproducible-builds.rst
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >
> >
> >
> >
> > Does not make sense.
> >
> >
> >
> > KBUILD_BUILD_TIMESTAMP is not a switch for
> > "please enable the reproducible build".
> >
> >
> > KBUILD_BUILD_TIMESTAMP requires the build code
> > to use the given time in the output where timestamps are used.
> >
> > Your patch does not use the timestamp at all.
> >
>
> No, and that's not the intention. It is used as a signal to pahole to
> enable reproducibility in parallel build. There is a cost to this so
> it's not advisable in all scenarios [1]. Is there a kbuild-approved way
> to determine if reproducible builds are in operation?
>
> Alan
>
> [1]
> https://lore.kernel.org/dwarves/20240412211604.789632-12-acme@kernel.org/




Kbuild already provides a standard mechanism.





config DEBUG_INFO_BTF_REPRODUCIBLE
        bool "Generate reproducible BTF"
        depends on DEBUG_INFO_BTF
        depends on PAHOLE_VERSION >=3D 126



pahole-flags-$(CONFIG_DEBUG_INFO_BTF_REPRODUCIBLE) =3D
--btf_features=3Dreproducible_build






Presumably, it is better to add a new section
in Documentation/kbuild/reproducible-builds.rst







--
Best Regards
Masahiro Yamada

