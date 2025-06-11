Return-Path: <bpf+bounces-60327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA0AD58B8
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F743A751F
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E074283151;
	Wed, 11 Jun 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWSY9v3x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118121E485
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652042; cv=none; b=OrO2Vf4oftIjh3YFymqzYRbdZUaL38t9Jwlzk0LAcYOJe12/bjsJc3j4kzZ1pP1o9mfjGff6mhE6+og5nOR1MTkktG5SZ73LOXqf2AE7CGcEB9xJH0m4winqJYHnDnYNlzf609nMwAB89ViibFYsg+Ev1PwRK7oOhwlB6S/n5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652042; c=relaxed/simple;
	bh=w33/us8MO7JoKDOMj1K2I4Qq4KGGb7O/8X5yxnTWJ6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPHqFb5/sIZJw0R2spP6dxl1GJYG5UVnW2l1hfFvN4ch4uOuP5kOCaiLOm0DD4OMUXxWFwIATS1k8fmoFVjtMU/owMa5dNYWMhGyg71+9xjaHz38qDdf6VIN0lEMNbTfZ+J8u0vn7IdLUv8y8BmPP1xDicH7SuYfcpQ7OgREWxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWSY9v3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC6C4CEE3
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652041;
	bh=w33/us8MO7JoKDOMj1K2I4Qq4KGGb7O/8X5yxnTWJ6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AWSY9v3xR1exkRLKZypUrjfTgS7L+73u/IYhycjr/Y/kQ8P5m5wxrbwaMg3fTbHXu
	 h0vkKKhjaKUhoMoz8auugdkW4weEuQs1qVPeb44eh8EE8k0UxnKKJPn6j1pcBflNrR
	 JaLRJVPp0EArc6lbjWgBGiwf/27kdgLzE5FY8o5O36dJRqqsRTkdrxGStIzcPQhoZW
	 H/UekvJSSIJ3tNauR8gRc0YUZ5qsh5rN6DgIu80cpRtdQKPDHad+NjRNGX/hQzqSIk
	 D99zm+6jfEIW+m8rL4WuaG/AaroYjnT0GgJSG1P9+h/faCJur5LoUgOuvUAxTirbJm
	 H5EJdyBoUFzvA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso13258949a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 07:27:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAr1HVqfYcKh7d6TXFGAmaYmazU5Naobm/xoEmJwcEKlC8bqun
	chfa6WQy6q9k5kEArF68gwL4BO8nrI1IuSVZ/8Wx99dTYGOWgxbAus1Rr0SOSJC8dsWVaV+Y9kJ
	AK6HJaHEYsE/taEzecA5o8+azXWtVmZKlCOnXU5u7
X-Google-Smtp-Source: AGHT+IHGnA8bdlBdkDNy5fbaGg55TsdC2JxCgtHudUuSFaKj5HiqDT6/Peo047X/zIVd10Y833hP47vguHQeBQG8AEQ=
X-Received: by 2002:a05:6402:4309:b0:607:f61f:cc2a with SMTP id
 4fb4d7f45d1cf-60863ae5802mr10202a12.18.1749652037181; Wed, 11 Jun 2025
 07:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-8-kpsingh@kernel.org>
 <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
In-Reply-To: <CAADnVQL7Roi1gmAWZFSx-T4YVLtHu2cDneKCkLdBvB2+y_S1Uw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 11 Jun 2025 16:27:06 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
X-Gm-Features: AX0GCFu-SkJ_wE_J4tRZNu2bXqfL8mEQrDouEmkjjBSbHwvtq1KTbS3AQoyqKNw
Message-ID: <CACYkzJ4_NL=U525D56mVcyfxX64BDrkP3FiFotNPQ8+EDKNRQQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 11:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 6, 2025 at 4:29=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrot=
e:

[...]

> >
> > +       if (map->ops->map_get_hash && map->frozen && map->excl_prog_sha=
) {
> > +               err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE,=
 &map->sha);
>
> & in &map->sha looks suspicious. Should be just map->sha ?

yep, fixed.

>
> > +               if (err !=3D 0)
> > +                       return err;
> > +       }
> > +
> > +       if (info.hash) {
> > +               char __user *uhash =3D u64_to_user_ptr(info.hash);
> > +
> > +               if (!map->ops->map_get_hash)
> > +                       return -EINVAL;
> > +
> > +               if (info.hash_size < SHA256_DIGEST_SIZE)
>
> Similar to prog let's =3D=3D here?

Thanks, yeah agreed.

>
> > +                       return -EINVAL;
> > +
> > +               info.hash_size  =3D SHA256_DIGEST_SIZE;
> > +
> > +               if (map->excl_prog_sha && map->frozen) {
> > +                       if (copy_to_user(uhash, map->sha, SHA256_DIGEST=
_SIZE) !=3D
> > +                           0)
> > +                               return -EFAULT;
>
> I would drop above and keep below part only.
>
> > +               } else {
> > +                       u8 sha[SHA256_DIGEST_SIZE];
> > +
> > +                       err =3D map->ops->map_get_hash(map, SHA256_DIGE=
ST_SIZE,
> > +                                                    sha);
>
> Here the kernel can write into map->sha and then copy it to uhash.
> I think the concern was to disallow 2nd map_get_hash on exclusive
> and frozen map, right?
> But I think that won't be an issue for signed lskel loader.
> Since the map is frozen the user space cannot modify it.
> Since the map is exclusive another bpf prog cannot modify it.
> If user space calls map_get_hash 2nd time the sha will be
> exactly the same until loader prog writes into the map.
> So I see no harm generalizing this bit of code.
> I don't have a particular use case in mind,
> but it seems fine to allow user space to recompute sha
> of exclusive and frozen map.
> The loader will check the sha of its map as the very first operation,
> so if user space did two map_get_hash() it just wasted cpu cycles.
> If user space is calling map_get_hash() while loader prog
> reads and writes into it the map->sha will change, but
> it doesn't matter to the loader program anymore.
>
> Also I wouldn't special case the !info.hash case for exclusive maps.
> It seems cleaner to waste few bytes on stack in
> skel_obj_get_info_by_fd() later in patch 9.
> Let it point to valid u8 sha[] on stack.
> The skel won't use it, but this way we can kernel behavior
> consistent.
> if info.hash !=3D NULL -> compute sha, update map->sha, copy to user spac=
e.

Here's what I updated it to:

    if (info.hash) {
        char __user *uhash =3D u64_to_user_ptr(info.hash);

        if (!map->ops->map_get_hash)
            return -EINVAL;

        if (info.hash_size !=3D SHA256_DIGEST_SIZE)
            return -EINVAL;

        if (!map->excl_prog_sha || !map->frozen)
            return -EINVAL;

         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         I think we still need this check as we want the program to
have exclusive control over the map when the hash is being calculated
right?

        err =3D map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
        if (err !=3D 0)
            return err;

        if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) !=3D 0)
            return -EFAULT;
    } else if (info.hash_size) {
        return -EINVAL;
    }




- KP

