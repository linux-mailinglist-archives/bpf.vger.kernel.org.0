Return-Path: <bpf+bounces-57956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41995AB1FE4
	for <lists+bpf@lfdr.de>; Sat, 10 May 2025 00:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6E34C8247
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15F4262FED;
	Fri,  9 May 2025 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2fo7f9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE6E2627F9
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829693; cv=none; b=nV4Cra1fApjoGEvnYk3d6JsWS+9QGVZt3xnNfPqYx8TUumSAxtotHAzYC1lDGIKijS+UD/6I3BKeD4LrGdbJA9r4cte/m2dqODsDqzybjkjSEqu+wHygBPeeOH05ss5cPTjb5LLagSk9TyRZEJaQLnXCfLJClGZn4ydBPvIOgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829693; c=relaxed/simple;
	bh=/uoIf7h2FBNHtiJVcUKYQNAOOyaMJSSF/8uZrYPjr3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CS32Ry0Wn6/ZooDmQgy3NlVHoeDxB+ysVtYN0dtsowONZD+mr3Tdlx1IqK7cNyL+Pz35o6hlNlc7O7wHfUSOf1ZrG+GsPTajW//2rIUnwkcG2k5o1t7u4+/OYKYBG6v91tD9D6imgB6czNv3YX78ypec1rdQa0jgdsx/jwgeHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2fo7f9s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso8415e9.1
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746829689; x=1747434489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Dwe+AkRWKyTQFcGk+FB1loDELsepTcogcqqbMFr0lI=;
        b=Y2fo7f9sXyzZcOiTBtCUATTMet+AKI+p++Wesl5zM/rX8H1MDdC5lSvGXM0wGyOO5l
         1t2EIitltY42VpqrUOJiFCqohgk4MVUdaI3HmYWVe/2bdwz+R2gkPNbC6OsqpFMxYGpL
         28Va8rHk/2LsFKB20z2OaHOX5FlMyvXN8U9/jrZRnzINTkHjuYRHAhcdHz5cl+ToMpWj
         hfyTBLudEmbkJZ3LMilecHwhKvH/MbrEVrXxOzhpM91rbYcMZn9yzwpjJnph3p3Ey3Df
         rnAZVn07b1eeywIntxMEZFdfYI8W31TjIFUzqjJO3QcKbaG02k6jeLy/CAr9brbppSYp
         4Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746829689; x=1747434489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Dwe+AkRWKyTQFcGk+FB1loDELsepTcogcqqbMFr0lI=;
        b=gwtnjA4xGOZNG9+riNk+Ds522/HOuqS/CLNU/pb61WNq91DOuGbSAAsoh7q85Ffoa9
         +8TG8eQMqr4HdYR4GS5bMRrNXt3s8Qu/TUAdqx6IF64eRqpL8/fwwPiuvPAqL9X17pHF
         4qitafy4m4rfiQrMNStmVguOUNwR3nXbul3UTyY4SmJ3Ws+8tBqC7XNhV8gZ9B5Hxzy5
         VKDfE4V9J0IRo4i46gfdcXrZFxJe7SkpR4+6NaGCgHBU6yiXwtLEgCmfe+VgHnAjMIkR
         vumTPutLWVAqBcthwjxLMDuldE3coo4qX1+8CvJDq5QWPbAk7qtHVbKar5qC3c9MfieY
         P50w==
X-Forwarded-Encrypted: i=1; AJvYcCXUXw5OX8RKVXA0ZQegeVX/AqLi02Q55CoCbtRJ/q4CFrJshWQXBG6Mn5VJVpuWVFgQSr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpt/aHNaXkl2Bsdv9KAXAPow3x0V+fZbQlpbe2SBHrUOeeUJLo
	EvZv3/79VGlReTOOAn8bRx2YZiRHCaKH558UbkmcQ4WUPZ6vOSbmQoiy3wB1d7ZoypNVV3zmJhb
	YtQ0QL69FUUcz3m/z1as3XSF7ejHpUtA4eRkY
X-Gm-Gg: ASbGnctiaoCzZ6NbpVH/nw0i1WjaqC85iEQYupzFqiQM1UYloNw0+Wm5sUgixkQCwmD
	ngdS2buSGlTF2DPASguiEoOAWWtwAdF2JI56+q48s+PGORpNvrIbmhud5o6OZLgqwr4qSo1veSI
	54AxEMulBroSJiveumpja1ooARe6j4wxU=
X-Google-Smtp-Source: AGHT+IGvqHCr2YbTyc+Q5mGzfoBCTKlc5wlIEM2vVFXqFenxVP+WaJU85XX6Sq5GSXEM+agSTCbYVlJfJ7nbfIdFhI8=
X-Received: by 2002:a05:600c:5009:b0:43d:5b3a:18cc with SMTP id
 5b1f17b1804b1-442de0efd25mr426825e9.2.1746829689429; Fri, 09 May 2025
 15:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508182025.2961555-1-tjmercier@google.com>
 <20250508182025.2961555-6-tjmercier@google.com> <CAPhsuW5WOmyfPqBc_Hn7ApGWP_2uz_cJwyaDWF_VwiHJu9s_1A@mail.gmail.com>
 <CABdmKX2h5cGjNbJshGkQ+2XJ7eOnM+VfbmVr5Pj5c0qfxQA-qg@mail.gmail.com> <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
In-Reply-To: <CAPhsuW7BM=X06Tr+HURsCbD8LwAO=Fdu+ZfKDy6RNK=UNNC1Rg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 9 May 2025 15:27:54 -0700
X-Gm-Features: AX0GCFuz9iFkCIfsshnA0MUw61-2gqEtE-ai4BVujTpqsH3eB8SQA_jIOEXe8bw
Message-ID: <CABdmKX3LMJLTZN8-x8jFAM8p58pg-6P5-B=mHBf98_uAVtxxwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: Add test for open coded dmabuf_iter
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:58=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, May 9, 2025 at 2:43=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
> >
> [...]
> > >
> > > Personally, I would prefer we just merge all the logic of
> > > create_udmabuf() and create_sys_heap_dmabuf()
> > > into create_test_buffers().
> >
> > That's a lot of different stuff to put in one place. How about
> > returning file descriptors from the buffer create functions while
> > having them clean up after themselves:
>
> I do like this version better. Some nitpicks though.
>
> >
> > -static int memfd, udmabuf;
> > +static int udmabuf;
>
> About this, and ...
>
> >  static const char udmabuf_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> > "udmabuf_test_buffer_for_iter";
> >  static size_t udmabuf_test_buffer_size;
> >  static int sysheap_dmabuf;
> >  static const char sysheap_test_buffer_name[DMA_BUF_NAME_LEN] =3D
> > "sysheap_test_buffer_for_iter";
> >  static size_t sysheap_test_buffer_size;
> >
> > -static int create_udmabuf(int map_fd)
> > +static int create_udmabuf(void)
> >  {
> >         struct udmabuf_create create;
> > -       int dev_udmabuf;
> > -       bool f =3D false;
> > +       int dev_udmabuf, memfd, udmabuf;
> .. here.
>
> It is not ideal to have a global udmabuf and a local udmabuf.
> If we want the global version, let's rename the local one.

Ok let me change up the name of the aliasing variable to local_udmabuf.

> [...]
>
> >
> >  static int create_test_buffers(int map_fd)
> >  {
> > -       int ret;
> > +       bool f =3D false;
> > +
> > +       udmabuf =3D create_udmabuf();
> > +       sysheap_dmabuf =3D create_sys_heap_dmabuf();
> >
> > -       ret =3D create_udmabuf(map_fd);
> > -       if (ret)
> > -               return ret;
> > +       if (udmabuf < 0 || sysheap_dmabuf < 0)
> > +               return -1;
>
> We also need destroy_test_buffers() on the error path here,
> or at the caller.

The caller does currently check to decide if it should bother running
the tests or not, and calls destroy_test_buffers() if not.

> > -       return create_sys_heap_dmabuf(map_fd);
> > +       return bpf_map_update_elem(map_fd, udmabuf_test_buffer_name,
> > &f, BPF_ANY) ||
> > +              bpf_map_update_elem(map_fd, sysheap_test_buffer_name,
> > &f, BPF_ANY);
> >  }
> >
> >  static void destroy_test_buffers(void)
> >  {
> >         close(udmabuf);
> > -       close(memfd);
> >         close(sysheap_dmabuf);
>
> For the two global fds, let's reset them to -1 right after close().
>
> Thanks,
> Song

Will do, thanks.

