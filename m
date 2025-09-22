Return-Path: <bpf+bounces-69259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1FB927E4
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F167AD47F
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F5316902;
	Mon, 22 Sep 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eikQgZzQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CD2E9EB2
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563843; cv=none; b=KGRbqTHH8PjaXdya0P+BrbIRDQOToFD+tiMxoLb06hAg215h8ql9z6e24Q962+Y/quJphdo0JBAXRppK7SuUrOI8iVhqI+iw8/abfKFpX8Ka2IQMD7spFgLFQW8DYv/9kYsKMaf5IvDO/0YS6CMaEzmD1IXYK+iPHXb6Czl1OQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563843; c=relaxed/simple;
	bh=slFGfPKGwZURLZubLLScksgY1grZxWJBFVnHO2BdenY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikE77pahMf+1J8P5PzPM2yFhNaMhr1sqm3rxW93bFEn0n8gJ9kFTtcwlVq5fXls5esA+a3WbGay0PVxPWfKKVAKJeosIg/Uqm6llHZ3jEi4VRb5OymWAzbKcQPVwV9HnpvaxpRizr/iDMgt2tqHa7LTusAg9m7TZHl5cgKv0Wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eikQgZzQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so3299279f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563840; x=1759168640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tbDeesajdX4+HS9yEUs/0r5jaV6uGkI1si6NnaWB6A=;
        b=eikQgZzQaIoV5vJrN92HEJduOyjjGGcglr7OxQmBFg9hy9yAq74vVIbnd/1ZqAcU4D
         3p7w8uHCYIoZqGyOSRC5V50GGyrQnAHD698+KJtIHNfLI/LM0ayOlju06749X2hVCi4u
         r4O4uahM7+cS0xVfNA0xt5i1/oon6ISsNCYwIdpWNfNl9C052CIOYXjfzTsuvF4Gx48j
         fSH6UN6ZlSqyb8hymbZVOe09/T5U51lh+cNkddo+1sZuNnGKTU+8lX6UUcZTMUFm7CRq
         SLGHuoe3Wtcwvco/HfcXXixf1ifVyIJMxsXeUPNmYNy00qKkWqHnNWY7JnE4BZFu1W5a
         ZBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563840; x=1759168640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tbDeesajdX4+HS9yEUs/0r5jaV6uGkI1si6NnaWB6A=;
        b=cReBTXRVJJQi6kqNUvCyF6vpp0bGiKEtKeCmH5UlJwR6HdLhvOXi5qkpuKjpJ88ULc
         lW3Az1uR7bqkGvili2PABJWzfx6on6jv3QohoUQhBpu/xtRKHlV4Cl9DYfKQsxulizZ1
         NoM1DPr/v9L4g71c/rb1+0pGmpbjNLSOjnVus/3nje+Cy2jvDraCJmc46iFxOD36Al99
         AFDOuMnUjZnUNHNtjvkGPOD+7uITbSBrZHwV52LNDhXyZ8NIebEwrz84Cect/iXB3oOX
         U40+Wu3XvT89AewwwWu3//jNnwg1iRS0D+RU1kIPvXNq+Kx8MQDI1goaGfEOBox4CzoW
         uPDA==
X-Gm-Message-State: AOJu0Yw4vl5Ry0aEwSz8hh8wZcbwHuFP4w7D3Rz07MEqnuYpz4ha/pWs
	IlRoTrr3+ykIx0Fg+Sglppv80fKLo/EzuD4Xi2i2DstHREFyiIlkE2MRJZR48k9ISH8uofYiB3G
	mCMuHH4I1o+tQw6DGhUoX9wk3lXVNIV4=
X-Gm-Gg: ASbGncs9FKfmgq14Al3doaiACqeHN/sHFK5NNxW4ILY8UyvUhdcWYzjwqJ/IpgIIXnW
	D2ip9JJmRorlzaY8F0pF4XEpCdqPpZ18r0PSdOOtGY9Uin1bZPqqbuS/upwT1pjfs/oFlOjOaox
	vuYh/zR4RcFsw0lEtwyv7AyNokSCiHFAmM/H41ZYhomu28E0WUefk2MxmD8UqcVP1fmWlk1C9eJ
	tzeKl7J5YtpxkxApANnQBU=
X-Google-Smtp-Source: AGHT+IGi6TzsUvcLfNXfSs3OeHrurkKo4SpIr8DLWxacH2222BS1dbkcdOjYDJkjwPfrbWs/Tq8HvA6UBe4+lbToEGE=
X-Received: by 2002:a05:6000:230b:b0:3ec:db87:e8a7 with SMTP id
 ffacd0b85a97d-3ee87604765mr10319987f8f.61.1758563839439; Mon, 22 Sep 2025
 10:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com> <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com> <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
 <aNGJT6IosAI7HP+B@mail.gmail.com>
In-Reply-To: <aNGJT6IosAI7HP+B@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 10:57:04 -0700
X-Gm-Features: AS18NWBlTePEHFT3lTbN7S9xpX8M1S6RBP_K5PDP9ITV5DjiYA8WqSbhvToAx_o
Message-ID: <CAADnVQJ=qN+x9vTwU=yskvwoe7vAqe=c7U6nLaKmP1u+jn0s3w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:31=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> On 25/09/22 09:16AM, Alexei Starovoitov wrote:
> > On Mon, Sep 22, 2025 at 3:32=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > > > > +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_pr=
og *prog)
> > > > > +{
> > > > > +       struct bpf_insn_array *insn_array =3D cast_insn_array(map=
);
> > > > > +       int i;
> > > > > +
> > > > > +       if (!valid_offsets(insn_array, prog))
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       /*
> > > > > +        * There can be only one program using the map
> > > > > +        */
> > > > > +       mutex_lock(&insn_array->state_mutex);
> > > > > +       if (insn_array->state !=3D INSN_ARRAY_STATE_FREE) {
> > > > > +               mutex_unlock(&insn_array->state_mutex);
> > > > > +               return -EBUSY;
> > > > > +       }
> > > > > +       insn_array->state =3D INSN_ARRAY_STATE_INIT;
> > > > > +       mutex_unlock(&insn_array->state_mutex);
> > > >
> > > > only verifier calls this helpers, no?
> > > > Why all the mutexes here and below ?
> > > > All the mutexes is a big red flag to me.
> > > > Will stop any further comments here.
> > >
> > > Mutex came here from the future patch for static keys.
> > > I will see how to rewrite this with just an atomic state.
> >
> > I don't follow. Who will be calling them other than the verifier?
> > Some kfunc? I couldn't find that in the patch set.
> > If so, add synchronization logic in the patch set that
> > actually needs it. This one doesn't not. So don't add
> > any mutex or atomics here.
>
> The usage of this map is as follows:
>
>   1. A user creates it and fills in the values using the map_update_eleme=
nt (syscall)
>   2. Then the program is loaded
>
> The map <-> program is 1:1 relation, so I want to prevent users from
>
>   1. Updating the map after the program started loading
>   2. Allowing two programs to use the same map (while, say, loading simul=
taneously)

Then the user space should freeze the map after updating and
before loading.
As far as 1-1 relation, we just landed exclusive map support
that ties a map to one specific program.
This mechanism can be used or 1-1 can be established by the kernel
internally.

> At the same time I want map to be reusable for the same program for the c=
ase
> when the program failed to load and is reloaded with the log buffer.
> So there should be some synchronisation mechanism.
>
> (In future patchset, the bpf(STATIC_KEY_UPDATE) syscall needs to execute.=
 It
> needs to be sure that the map was successfully loaded with the program. B=
ut
> you're right that this doesn't make sense to leak part of this patch into=
 this
> patchset.)

Even when that bit will be available it won't be modifying the map.
At best it will flip flag or bit whether the branch is nop or jmp.
I still don't see a need for mutexes.

