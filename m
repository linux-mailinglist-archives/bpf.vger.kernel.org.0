Return-Path: <bpf+bounces-21428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AF84D2A9
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE56285471
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FD9126F02;
	Wed,  7 Feb 2024 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqeXXwXQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9CC126F0C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336787; cv=none; b=U5aJtmshzMZGWc0T6j0zTzRyaqCl1rEOLpPVqFYuMhpqlNjZWjoDcwGSR0dIRNViwLT9O2+agR4W5+F/ZfiLkijAtQzbzCRfRVwMLmTgeoIpL0wO4u4ZY33O4SyjiRclKz41cLi1HygMCo/TpZCq38d6bY7XaC2i83a4joNoriM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336787; c=relaxed/simple;
	bh=rC7314I5bOLnEuFkqogn8RsbixzMaA3GSnijjI58jTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWNzfM6XztxJ0ti1kdQiYbBHliOu5+E7M1krJsH6WGZZjTLUpOsHTMVEQSy+cbACnvZAFUaywZlOdUA3hBLwi5zTigxova3mEAxy0PpjYIMSIpz27v0Jb7XZQqJykld4gLAEfZjvRCcgjJdfNqj342E2aVjJLBNtBdHE8WDY0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqeXXwXQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fe79f1aaaso9539065e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707336784; x=1707941584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fq0m9i8CTTh494YOstb8TqVY8AHpJlrOkTXkdU3/8q8=;
        b=SqeXXwXQGEEyrZ9DcBqVGdiEb2V5GWWviQyUgnMAr27n5JYZILoCMnjklFnLbP0GG5
         BdUtwmyREXYz9+62nHNHcCdgJYImubJhsMN4sBOON5jlIDyVqbuwS/eAPN3ifce1iiN2
         dH1fTj9ai13bxvwUbZtP2IMWU6ZTSrGZRu3vgqui1anXZToblaQx+Ad52aFnuDbMnZO7
         65+CrHvA6xouytXjoXa5bHoUXi/B8iFuho0ywy3x162hjcHA1f7t6oeltOO9hLf/liCz
         K+5hKBj1TGvbHK5IaSMzVU8GXHLHKtjz+2N2qRo9qbO/eQOgKKLKUXDlze8B2lPpx0K2
         +f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707336784; x=1707941584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fq0m9i8CTTh494YOstb8TqVY8AHpJlrOkTXkdU3/8q8=;
        b=UAwl12AnFem6b1AgbqPoTq9/D2m5ArVBBWazOaKy197WdotZ7IZlrL/0+QYRVaCOcR
         DITMZoS6lW53KhCcUkrWjPS0Jy88y5st5RfCI9wjq34QrRWy/4lttObODAZRpUywoDFs
         ilG5N9J5Os63NR00o8UYJLg4GV+Q1KCx+sfCvuhegOcib+pZ5pJ9oLwrVrDi5Qv9Ppcg
         xtcjMcvqx98K1qSmiSKDDdE2x0JxfNaSOaLue1uNUQazAyOoLLcBgtHFTgZxn+DTdncG
         eaNI4IdZVCzw33M3VYiNxeRvVn7aw0ZwMfpSfehiDx5U/Nd6VjWj+81LDwZr0siVzTy9
         GQdg==
X-Gm-Message-State: AOJu0Yx+CCadeTh6qruDoX3+AhfUcsSvVjVw12Mje1uV2KNQn61KUVmD
	vS80ZbDEMWy2MPwbi3ovq9URlzo21mtgjDOeRL3uk3BYY/v/iiXUuVe5hmvzf+nHZ+V3eEBujuv
	4cAVKJwBLOIRFdMYeqJJHOfND+TQ=
X-Google-Smtp-Source: AGHT+IHkSZe05KlX94v5dTGtBC+zaUrcEZ9CtK6kdmJBJ1JSiSHSHWJzkin45YP1TRVpCKSq5yttKe5HEfNvYHgd9O8=
X-Received: by 2002:a5d:47a2:0:b0:33b:4967:4d2 with SMTP id
 2-20020a5d47a2000000b0033b496704d2mr4616162wrb.41.1707336783812; Wed, 07 Feb
 2024 12:13:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com> <m2h6iktpv7.fsf@gmail.com>
In-Reply-To: <m2h6iktpv7.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 12:12:52 -0800
Message-ID: <CAADnVQLXUeGVhS+q6XVe-LP+HoFwrAf0v_+r-orGxFRoA7GRTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/16] bpf: Introduce BPF arena.
To: Donald Hunter <donald.hunter@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:34=E2=80=AFAM Donald Hunter <donald.hunter@gmail.c=
om> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > bpf programs have multiple options to communicate with user space:
> > - Various ring buffers (perf, ftrace, bpf): The data is streamed
> >   unidirectionally from bpf to user space.
> > - Hash map: The bpf program populates elements, and user space consumes=
 them
> >   via bpf syscall.
> > - mmap()-ed array map: Libbpf creates an array map that is directly acc=
essed by
> >   the bpf program and mmap-ed to user space. It's the fastest way. Its
> >   disadvantage is that memory for the whole array is reserved at the st=
art.
> >
> > These patches introduce bpf_arena, which is a sparse shared memory regi=
on
> > between the bpf program and user space.
>
> This will need to be documented, probably in a new file at
> Documentation/bpf/map_arena.rst

of course. Once interfaces stop changing.

> since it's cosplaying as a BPF map.

cosplaying? It's a first class bpf map.

> Why is it a map, when it doesn't have map semantics as evidenced by the
> -EOPNOTSUPP map accessors?

array map doesn't support delete.
bloom filter map doesn't support lookup/update/delete.
queue/stack map doesn't support lookup/update/delete.
ringbuf map doesn't support lookup/update/delete.

ringbuf map can be mmap-ed.
array map can be mmap-ed.
bloom filter cannot be mmaped, but that can easily be added
if there is a use case.
In some ways the arena is a superset of array and bloom filter.
bpf prog can trivially implement the bloom filter inside the arena.
32-bit bounded pointers is what makes the arena so powerful.
It might be one the last maps that we will add,
since almost any algorithm can be implemented in the arena.

> Is it the only way you can reuse the kernel /
> userspace plumbing?

What do you mean?

> > shared with user space. This is use case 3. In such a case, the
> > BPF_F_NO_USER_CONV flag is recommended. It will tell the verifier to tr=
eat the
>
> I can see _what_ this flag does but it's not clear what the consequences
> of this flag are. Perhaps it would be better named BPF_F_NO_USER_ACCESS?

no_user_access doesn't make sense.
Even when prog doesn't convert pointers to nice user pointers,
the whole arena is still mmap-able and accessible from user space.
One can operate it with offsets instead of pointers.

Pls trim your replies.

