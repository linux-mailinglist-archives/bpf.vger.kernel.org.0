Return-Path: <bpf+bounces-56515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE5CA9964A
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 19:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBC99203B6
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB5A28C5CA;
	Wed, 23 Apr 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZJlo2pY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CA28B50B
	for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428588; cv=none; b=kgD1b/fp+q4eIX9rTKRXoOSspBnTBX8Qyd9f1d18gOlxIwpxFqdmoA90lKfKoev/NdZ7X9MALzzoOOr2QWYdqWaFaxRjshkgIx+GyEUcWk9a4VbjRt5XfQo0H8vs1brceF9qXmZx2AdU5wucXpu9Awiid0dman9SwJ/1LHcEPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428588; c=relaxed/simple;
	bh=2eoCz5Vwboja1E0z+hmUtfdlcsIyszZWzQdnLz4ilZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBr8gMbLQH2445awPXinPDN/pxtJRzUdEcYnL9AFc5cSt9sNCCyKCje9sBDZUSTGuFs37MZgkQhq/Ef1PrUf3qooO5xXAila/T51JY8RH+wnKlbdEv/iGVk6eshwG0zSpq4IeE6cLmxkNZU6N+2XfqxjTTUG6KTmshgeD1264l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZJlo2pY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe808908so4505e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Apr 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745428584; x=1746033384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIH2Y/xRBv399bxbyyQpx3txjQN3EIidmYTSRd0t7U0=;
        b=eZJlo2pYPL/9WLTjRexz5JPX2jypY8IDST+Z8PTWFXwgflI7tfUXq+nFAlFK+mlu9L
         KffhDq6X+lh4YvXM5Unj7JRZ/64AUqWaAgYVUfNcja4mpfTBFIucFeqtlRiYrW5bpC77
         sal5HUvQCSJ0cQL8orft/Xs5va8wYng4KKuwV9ovtkJ6z0TvNZ2sh2BcrY+/n6ZSspyM
         ORwVCBbMEKp9zV3kWGPEpfatxfC9XewXyprTPbFFEyPJB4ruJVCZiMwukV0W6nD5nbNg
         EMujRYastkvCsnmujyJmfLIMukyTcJ3hh/+fV0761/2C3GkWMGo5C5Vy7pBmmJ5T0NAG
         ny7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428584; x=1746033384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIH2Y/xRBv399bxbyyQpx3txjQN3EIidmYTSRd0t7U0=;
        b=oeh6SyUZuG/3K7zuTTl+ZbusUIzvq9wmBZBDDekmxHeKJoCakq9Xedd7lkQEOzAHoN
         1sIEYjx9GxgesDZCRxaojT/GJJGk2U7MJtylumgt7ID3lOkD6b29V8HGqvPjk7StVreP
         LdPHMSLWR5J5EtCEAmJaxi2AlHqsvvawcPpZB24hlPJtre5h/uLwHCvZtAb8l6gzXYxb
         BbZ5vy/ENtq4iEg3dGMLW3GYBw+HjE6RtAgH5OgR3MGQlMRAAYM/BZvb79F7D1ZuiLDT
         WQdpjMUFrbevK9Exk/iLJvW5wNmz6Z0atMkbmcNfmU/clmLhEiCoyZDsMfPuOsn9VyvJ
         XXjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8jYT0sR0fnRhIZDT7nOfjlrUDYAVLucwkFcXEKDWqPk7wZvpmQF7o+GlF1ftahgbVcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudjLHREUe4APvDloqIygjY5Uk+Kg63ZnHisr9iJvTbp/P+uaT
	jZ0LJs7D85r767o4mrZBlFzZbwAV7pYCehg7xZuii1ZgcX3LYtPEnFUaiUcEA3c25NXyuF00rMU
	4qHne3B2KGi49lxO7C/uc1tvnM5XBwJNYGbJ+
X-Gm-Gg: ASbGncvdBC0vJn8jD1DJPIjwNYOXDDo/iHmkSC2nMu8XaNVCg1Ay8RHPhstsxNakCos
	BwlkeE28IG1WScYj2OYlI7ahL7H7zTKCaCk9wk9C8aVtKIzmFenvzEE0FXmBixWB6dNaTY2e7en
	Glbf5MmVjYFgAg41drpaAuetB+P0I1IEiejkq7p6E8iD4hAY6i2CY0
X-Google-Smtp-Source: AGHT+IEel/YT/gnh0VEYAVLvUZfUcOlX9vT6+bEdhBmfMWss5izqapNDBKSe0DOopFndovC2banc6XkwLECVQbHq0Kw=
X-Received: by 2002:a05:600c:1c85:b0:43d:169e:4d75 with SMTP id
 5b1f17b1804b1-44092d44519mr1219535e9.1.1745428583917; Wed, 23 Apr 2025
 10:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW54g5YCmLVX=cc3m2nfQTZrMH+6ZMBgouEMMfqcccOtww@mail.gmail.com>
 <CABdmKX1OqLLsY5+LSMU-c=DDUxTFaivNcyXG3ntD8D0ty1Pwig@mail.gmail.com>
 <CAADnVQ+0PXgm_VuSJDKwr9iomxFLuG-=Chi2Ya3k0YPnKaex_w@mail.gmail.com>
 <CABdmKX1aMuyPTNXD72wXyXAfOi6f58DfcaBDh6uDo0EQ7pKChw@mail.gmail.com> <CAADnVQ+AesNdq_LB+MWxLnHbU08Zrn-8VgwY4+0PKuk7PmRd+w@mail.gmail.com>
In-Reply-To: <CAADnVQ+AesNdq_LB+MWxLnHbU08Zrn-8VgwY4+0PKuk7PmRd+w@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 23 Apr 2025 10:16:12 -0700
X-Gm-Features: ATxdqUGSlAvQmLyJTaMr0DEawjdns0rX87YnkYfV8wWxaP1lEb4mrCvXcX0Kneg
Message-ID: <CABdmKX26VGYxjUh1Gc4TBD71-vGr2MLZdhik36cKStpbG5t7=A@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, android-mm@google.com, simona@ffwll.ch, 
	Jonathan Corbet <corbet@lwn.net>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 22, 2025 at 12:57=E2=80=AFPM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > On Mon, Apr 21, 2025 at 4:39=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 1:40=E2=80=AFPM T.J. Mercier <tjmercier@googl=
e.com> wrote:
> > > >
> > > > > > new file mode 100644
> > > > > > index 000000000000..b4b8be1d6aa4
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/bpf/dmabuf_iter.c
> > > > >
> > > > > Maybe we should add this file to drivers/dma-buf. I would like to
> > > > > hear other folks thoughts on this.
> > > >
> > > > This is fine with me, and would save us the extra
> > > > CONFIG_DMA_SHARED_BUFFER check that's currently needed in
> > > > kernel/bpf/Makefile but would require checking CONFIG_BPF instead.
> > > > Sumit / Christian any objections to moving the dmabuf bpf iterator
> > > > implementation into drivers/dma-buf?
> > >
> > > The driver directory would need to 'depends on BPF_SYSCALL'.
> > > Are you sure you want this?
> > > imo kernel/bpf/ is fine for this.
> >
> > I don't have a strong preference so either way is fine with me. The
> > main difference I see is maintainership.
> >
> > > You also probably want
> > > .feature                =3D BPF_ITER_RESCHED
> > > in bpf_dmabuf_reg_info.
> >
> > Thank you, this looks like a good idea.
> >
> > > Also have you considered open coded iterator for dmabufs?
> > > Would it help with the interface to user space?
> >
> > I read through the open coded iterator patches, and it looks like they
> > would be slightly more efficient by avoiding seq_file overhead. As far
> > as the interface to userspace, for the purpose of replacing what's
> > currently exposed by CONFIG_DMABUF_SYSFS_STATS I don't think there is
> > a difference. However it looks like if I were to try to replace all of
> > our userspace analysis of dmabufs with a single bpf program then an
> > open coded iterator would make that much easier. I had not considered
> > attempting that.
> >
> > One problem I see with open coded iterators is that support is much
> > more recent (2023 vs 2020). We support longterm stable kernels (back
> > to 5.4 currently but probably 5.10 by the time this would be used), so
> > it seems like it would be harder to backport the kernel support for an
> > open-coded iterator that far since it only goes back as far as 6.6
> > now. Actually it doesn't look like it is possible while also
> > maintaining the stable ABI we provide to device vendors. Which means
> > we couldn't get rid of the dmabuf sysfs stats userspace dependency
> > until 6.1 EOL in Dec. 2027. :\ So I'm in favor of a traditional bpf
> > iterator here for now.
>
> Fair enough, but please implement both and backport only
> the old style pinned iterator.

Ok, will do.

> The code will be mostly shared between them.
> bpf_iter_dmabuf_new/_next will be more flexible with more
> options to return data to user space. Like android can invent
> their own binary format. Pack into it in a bpf prog, send to
> bpf ringbuf and unmarshal efficiently in user space.
> Instead of being limited to text output that pinned iterators
> are supposed to do usually.

Also a neat idea!

> You can do binary with bpf_seq_write() too, but it's rare.
>
> Also please provide full bpf prog that you'll use in production
> in a selftest instead of trivial:
> +SEC("iter/dmabuf")
> +int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
>
> just to make sure it's tested end to end and future changes
> won't break it.

The final bpf program should be something pretty close to that, but
I'll start working on the AOSP side as well so I can put up patches.

>
> pw-bot: cr

