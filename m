Return-Path: <bpf+bounces-74814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B5C66906
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 490D6298A7
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158B26E6F5;
	Mon, 17 Nov 2025 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnhTdCVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D0240611
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422583; cv=none; b=OPaCG8IpY6cZu6TTIXc/R06elsDIEUf0hnhJOWsHiaQQqQ9B2HI/bs5jZdog/2+3OoepVS2TZVwHQRapDnc4cVFYIaggmZIQSB9r3ng4tJcmtmWGFGQwNr3EAKV2GFEWL8DrHnxTMwqElgbAo0L+4TPNRBiR6Hw7xJTwZKDRHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422583; c=relaxed/simple;
	bh=dvDswBxG/btwda3Ai60E1wT6+jXBfwo3Ud4F9hlCrdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LumsSSU9MugMNuzHpP1DnQjhuSTolRbEVDTgI+0+MJOBbm6xq9BGUJZdB75ksGisPeWtICCXYKcSFw3KJ56ZmvL0mKNq8xTB3V4IGgUBoUp+NmHc9RtPXI516aVVx8xrOOdYAzS/JxtQveJQBdwRxC5cBJ7ASpiJ8ipoVB+Tdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnhTdCVM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47789cd2083so33778095e9.2
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 15:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763422580; x=1764027380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD2j0INhVFK9W4YyL9gKWByj8HQYLmc3TcGpp9WolVw=;
        b=gnhTdCVMdYLKFB/51VJnqhWQ1qQPLnyHm7Xz4yRhsQbfdI2JcSkwlnhVVnInIRalcZ
         7v9HB+XzFAjcFqlkx3rdft/rSCSYLXaCklJnddLJs5VnINSVjVH0o/auoMwiDmz9DF5P
         bGZXwvuUBudquqpg4oNNhDWSjn3F9sZ7jLzD3HrUgO77hAfMknsSAPla9+sGpxB8pQ4r
         51wAsiZY/u/6G7ykcEo+RSEQqOUrp3r0mxWUejQfEPByu3UEvgXhrrQoDBNQD+jKQ8Mn
         tuzxN//Ly2AIaUV4w0CeRRu7XFkXuqwzJZvqlQwQON+qM7dr8SwpFA1g0cemSbOAKCRZ
         4jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763422580; x=1764027380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wD2j0INhVFK9W4YyL9gKWByj8HQYLmc3TcGpp9WolVw=;
        b=QUdZvGc3UE5LFgJtDKA5ll5XnoCfWkL2sC8RaowVy5DzH3Jjv7oHOwRzwwHX5X7wb4
         tGsHTJb2zKHl3Ugb2OExAGO9VyrZVf6DneJVyBVujkgPeGLZhVIX36zZK7WbKzgtsHpE
         QuAJuqbX0k/1FaeYZ7O+DmDj6LIJF+CPOjVqEKR2aD3vDuf+m5/yn8/zNK63n7nM9b3I
         eDijnBadtkKmwK/L4niCZLe7v6qkm/iLEVqSdZrBAqJiICXcz2/bcKJ3+eE0KLk6ohQi
         t8ERdlt2in5tnmO7hJXdnH5bycKU2k0IFzNuJXDaA+WC3fgfganG0A6dAfJzv8fVzdCT
         vtzA==
X-Gm-Message-State: AOJu0YxKNntgFswrzgvhzTR224MGBX6rHCpXFKvNkgtRH8hIAe00IhCD
	QDI0gBK9BxTAXFdfhmMGIST386WtYW0IWBdNpt4bjcjnHE1s825bqNiNLlesceERRPsOXcqzgN8
	Ts4LnmsbdltMjd9F/I8ParhO7bdhy/yk=
X-Gm-Gg: ASbGncvBbqc+Ax5yfmnNC5ck9e93ONS3U2IuAW81c0OwjTmiWv84SEYgEHIKrw70Imv
	T3vqjrnsvDd6W3oEoI7t3YcER6ghXpvyWbApB7LAc6KDN1XXicIwu5RSLg3aaq9CchyYDCd8qHg
	F5rc1nSPJm2eTXoTn9uMoHGpgCaaxS2rwGPDDD9se54aAQ9Go/gmpicy4vsD3D+gM1bNnovWLRP
	+BUexGQJUqhaIlsN6fVBhsagam4YyLZfX9h9TXmvGatWPQHYPT7r9kDZLo8GI4Ql++WHt2/RGqt
	k4tWwlvf
X-Google-Smtp-Source: AGHT+IHWmwKsJOJq7Cro7aBvFC3PbCIZnNHuABuErCA0Fb/nyzdx3fF/EEiqnshVY7WD1ncXFTqvGYKjjFGOE5zQYAI=
X-Received: by 2002:a05:600c:1d19:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4778fe50bb3mr108159915e9.4.1763422579560; Mon, 17 Nov 2025
 15:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
 <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com> <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
In-Reply-To: <CAMB2axPEmykdt2Wcvb49j1iG8b+ZTxvDoRgRYKmJAnTvbLsN9g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Nov 2025 15:36:08 -0800
X-Gm-Features: AWmQ_bl1Mcu2D_uXpTbT6jUHtda0p1E6L-Tev-DafrdteNWz5zoJfwVWpvdPCHc
Message-ID: <CAADnVQ+FC5dscjW0MQbG2qYP7KSQ2Ld6LCt5uK8+M2xreyeU7w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Amery Hung <ameryhung@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:37=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> On Fri, Nov 14, 2025 at 6:01=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > >
> > >
> > > -       if (smap->bpf_ma) {
> > > +       if (smap->use_kmalloc_nolock) {
> > >                 rcu_barrier_tasks_trace();
> > > -               if (!rcu_trace_implies_rcu_gp())
> > > -                       rcu_barrier();
> > > -               bpf_mem_alloc_destroy(&smap->selem_ma);
> > > -               bpf_mem_alloc_destroy(&smap->storage_ma);
> > > +               rcu_barrier();
> >
> > Why unconditional rcu_barrier() ?
> > It's implied in rcu_barrier_tasks_trace().
>
> Hmm, I am not sure.
>
> > What am I missing?
>
> I hit a UAF in v1 in bpf_selem_free_rcu() when running selftests and
> making rcu_barrier() unconditional addressed it. I think the bug was
> due to map_free() not waiting for bpf_selem_free_rcu() (an RCU
> callback) to finish.
>
> Looking at rcu_barrier() and rcu_barrier_tasks_trace(), they pass
> different rtp to rcu_barrier_tasks_generic() so I think both are
> needed to make sure in-flight RCU and RCU tasks trace callbacks are
> done.
>
> Not an expert in RCU so I might be wrong and it was something else.

Paul,

Please help us here.
Does rcu_barrier_tasks_trace() imply rcu_barrier() ?

