Return-Path: <bpf+bounces-21522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F27084E7F6
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7B293F9B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317552E415;
	Thu,  8 Feb 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSNm9R1R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE528DC1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417959; cv=none; b=Z7JjGz+eBGV5FwPB/vuBmaFZ/hgI4UCKFRi6RLWBBdXplJuicx41cn6tmHL8SMjJx2NWPydQ/XbKKfYJAi/TDAp1EIZkdiQ76l1XsUtihDy42j8YLSCDXssmNsJfmYzxuG1J4jLtXyHqYpa3OyMW4W4orPzbCTK85wv+eIRO6ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417959; c=relaxed/simple;
	bh=24VPnlyanZViQIemn48tocUO2GE1K3pjHcB6Xbxklsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxVZ2fq5uKrUIPtI0mPLhydQ05cmNF0jEMnzMzE63WtVLQ3wase4H+GpP1YwZ1YqgRwbFO1opYwDNfdXVGExEkHWPpukfCd/odNkqU0GbdDyqA2l5T3/gEZ3qS3q+9Yu5IlGH5bqwCSA52lqCdTDWy2S7g9sFqPYwc8a6dWDy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSNm9R1R; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b0ecb1965so13320f8f.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707417956; x=1708022756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uoidg8jtyamuAXUa0zJiO0kLCu5An00+T5KbzBdmD3M=;
        b=dSNm9R1R19XachyA7gVOWEmeVL5yFj7RuXKTlj0CFZ4N9Pqo0JQGHu4WoIkGtLAZCE
         LDlkdqWBOn8EyC2ptdSRgh9Hm6YWP3/nGkKDuShkGN3642JE1UJbnRhLds7f6auPM+py
         y+KuxJbGoDfFiMS/VTK0Vp6piM4ykx29SVf6EZPLpKjruOadvlfOH+29LPlWpTuCyuG4
         xAb7hXmJP0p+/a4WH+l6scdz1YI0Tm6DBwyFzXDbv/W16uh2nc/g2pfYjLLlyCmW5Xbk
         YUMb0L+CRMC4z7iEwfj2UUhIgGb/DDRKU97TQW1deEhrT2LvZHkd8jhD1yGn5zfmXxtP
         mAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707417956; x=1708022756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uoidg8jtyamuAXUa0zJiO0kLCu5An00+T5KbzBdmD3M=;
        b=PfqYNW84VhHy+KkzIVQBiYff9Gi+G004vzhvSg0hzOT+A4ZeaU+m4VpcnKz6D2VRJk
         FKfM1WTc1A20T+1UyHxLBltIYAA27WN9Ba/IuWaV5GhBkhRXgYpcEskQRH+iiBQK95O2
         qBU/rrNWC6HTDipgq35hEB2rGiP681GoWhXTw1UZ53Y2yNRS9zmHZTKikX8DRpJkEZzK
         OiNEDrLnSkKD2SbcvkFGdA92jggDn8HviXUFlPNM6I14gKNVKA3rVDtZ2ROdX8NgdmT8
         X+VkpfcP7IZZ9KR8TFLbW8KJ1ykU9QvTqZ1xhIlWG9x1wnNUjQaqUdSySb0zrCk+JFn/
         owwg==
X-Gm-Message-State: AOJu0YwE6h7mHxjblNsXsSg3UlH2pg58vhTkujS/sv9jvxrkKT4uWX5g
	eElm79LYGl8UIV0gUfpEIi+Ksi66ZXyINJ2YxWACrFhU26p+27dsEQ7W4BcuAke8oqOY+kyNYsD
	ECZP5e/OWfNiCx6iZCxwhR0QIgM2A8nek3Ig=
X-Google-Smtp-Source: AGHT+IFxiN2IOCoshVTm5pZG4zD0LuOVCO362rjxDyFXTRwL1uu1ge6OeDcy1OxvlVMq6xuzwRoSwDoNM5J9/ceoACo=
X-Received: by 2002:a5d:4b92:0:b0:33b:343c:2e68 with SMTP id
 b18-20020a5d4b92000000b0033b343c2e68mr283345wrt.10.1707417956089; Thu, 08 Feb
 2024 10:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-12-alexei.starovoitov@gmail.com> <CAEf4Bza9gNXfGXuQnvWnoYNA08enBCkqn9uyHtBNdTpZRvn7og@mail.gmail.com>
 <CAADnVQKjkba_wiUJ9wps_k8+TYu_q3Ai5oQ1mnZQmpv+pnPfFw@mail.gmail.com> <CAEf4BzYvgHoBQ0KNFOWoK8XOvRTzGNBM1QsS=zR5iPTq-Z+=4g@mail.gmail.com>
In-Reply-To: <CAEf4BzYvgHoBQ0KNFOWoK8XOvRTzGNBM1QsS=zR5iPTq-Z+=4g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Feb 2024 10:45:44 -0800
Message-ID: <CAADnVQJ-rrx-_tC5ek_wyhNdFw2Ya6o3eN_hpdgFswT=CfuXnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/16] libbpf: Add support for bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:29=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 7, 2024 at 5:38=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 7, 2024 at 5:15=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Tue, Feb 6, 2024 at 2:05=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > mmap() bpf_arena right after creation, since the kernel needs to
> > > > remember the address returned from mmap. This is user_vm_start.
> > > > LLVM will generate bpf_arena_cast_user() instructions where
> > > > necessary and JIT will add upper 32-bit of user_vm_start
> > > > to such pointers.
> > > >
> > > > Use traditional map->value_size * map->max_entries to calculate mma=
p sz,
> > > > though it's not the best fit.
> > >
> > > We should probably make bpf_map_mmap_sz() aware of specific map type
> > > and do different calculations based on that. It makes sense to have
> > > round_up(PAGE_SIZE) for BPF map arena, and use just just value_size o=
r
> > > max_entries to specify the size (fixing the other to be zero).
> >
> > I went with value_size =3D=3D key_size =3D=3D 8 in order to be able to =
extend
> > it in the future and allow map_lookup/update/delete to do something
> > useful. Ex: lookup/delete can behave just like arena_alloc/free_pages.
> >
> > Are you proposing to force key/value_size to zero ?
>
> Yeah, I was thinking either (value_size=3D<size-in-bytes> and
> max_entries=3D0) or (value_size=3D0 and max_entries=3D<size-in-bytes>). T=
he
> latter is what we do for BPF ringbuf, for example.

Ouch. since map_update_elem() does:
        value_size =3D bpf_map_value_size(map);
        value =3D kvmemdup_bpfptr(uvalue, value_size);
...
static inline void *kvmemdup_bpfptr(bpfptr_t src, size_t len)
{
        void *p =3D kvmalloc(len, GFP_USER | __GFP_NOWARN);

        if (!p)
                return ERR_PTR(-ENOMEM);
        if (copy_from_bpfptr(p, src, len)) {
...
        if (unlikely(!size))
                return ZERO_SIZE_PTR;

and it's probably crashing the kernel.

Looks like we have fixes to do anyway :(

