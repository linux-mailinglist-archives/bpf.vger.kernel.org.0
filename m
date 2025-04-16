Return-Path: <bpf+bounces-56081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC126A90FC0
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D571902B6A
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25B24BBF8;
	Wed, 16 Apr 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ch8in/eh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C923C8CB
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846838; cv=none; b=oHnP9lCh0j1ett8oQ4/jfYpDfxDh8d3A6+JTbRg/0mMVV1mmeob52FgrP78KLAq9kOfkmzY4fTftqCQdXMGCzxDofG33whVDrQDloodhnSydFt6X4ZIIG+46uQWO3TFIw1Xlsuqs2zTf+pGfQwwYLwSUVGGPBC+Bwj8LcohiObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846838; c=relaxed/simple;
	bh=6Mxjt3rihuzILbcLl043WrZ7HaX9/u729SBhzDpJcjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lB/QjuIsWr+7RL+0phg8rI3/+UMjPRpEbWNgrc4eUS3QF8gKriEvis+bVDfnEswAPlGb5+xIpKNui37Fi9ePR9+VyWH8vC6EfpAtisEv710MzqQRc7t50H47uChZsHpXrEN7jXYlHrz76M47XRC2j8s/Nu5aYRE5KC3D+9h4MsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ch8in/eh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso13575e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744846835; x=1745451635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mxjt3rihuzILbcLl043WrZ7HaX9/u729SBhzDpJcjw=;
        b=Ch8in/eh3ikaKrLW1WquO1Qu7R15IWcKwsqxcI4AXdM+nY4ks5HEojSssKb6uX5VYB
         YcJ+BtKD7odQgXwJLQUpGYk4FX9Qpub/q5u8dCmeVz7FF6pUZMmSY6MR+jnD5fh9OMLw
         c2dcmFmsig2d7azQCOuz6WfB4myhN6cumc2k11KWHdbIn+qWKkJwi0FulYQ8UQmg+LkZ
         Ah+dVxv8ckXzJRGF4X4So4jzLkBGF1cw7GNMhXbTeZJfTwuNhBpOV7rCytVDhHoj0V31
         TilqLxYuEvsJllVh5jWaWa8f4H+naD0BcOXeV5ZMaVmVe33JENh0SU73UVJTBO7PEKLr
         L+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846835; x=1745451635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Mxjt3rihuzILbcLl043WrZ7HaX9/u729SBhzDpJcjw=;
        b=e4iawKC9y/C0syLIjwfYJBKaWIX/WWEpH2Ht9qlwLeAWy9A+WTC7l2+/S6uVbHL4nR
         WXWKZ/52X3IQ9cLhoUYbyWGuXaOsV7L4XbecOD5nJu9pIw9+GWT2uPtRPffpFrRsYGOx
         csKd7GTTJcD8KTmhHnhIfgnYEQ/367pMIQEBOxBAsI6lq0Tm49RvBM9DFHBqIpQrE0cj
         F2/TWBpVzZp62yg39hOgXMn/XAyog04vAig8jzBdSHaWS9qQOfRDnIv070IPrwSGiwQy
         9Nx1Twbo/TyMiyckpjJUyVsZe5KID5G9zFWvfKem4mO5uXJdPz32Uzot3L3PWTp5QUZc
         v17w==
X-Forwarded-Encrypted: i=1; AJvYcCU4zW3flhONqREO7aShqL/3RELTS9ZvSns/4CBt+6E/g5R7SM5gYpytyPGitASyGccQpns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJBiPvBX2ztqAhkK0z72p4m0yBBgAM8gO1AO++4AUtFsrccQF
	BWCRZd73RCzed00RwDDh9kgoofrrUjVHSTYSkIno15rmDJEPaX79Ab9cNDAI8J4sdsPCIEZMsMu
	nTi8wzeT6xTAwMNcDZgQUWIgwZNU36bquAict
X-Gm-Gg: ASbGncsPlvyKRw41J8tgvm9YE1BKNjDblMsCZzRJ4Wl7vhaxPL/pL5h8PxjMYJnPbcd
	gbWtkbSRO9ujrN5uwa1gc5HRG+dNNJnyyUQeeIh7+Jdb2qtIR3nUwfCuHndP0JWVp/6DpubrK+X
	uMzk+f1ZYjd2jpqPumEr31Fg1bp6uiMQxOuHmdr7JnjvZ8E8CvVeg=
X-Google-Smtp-Source: AGHT+IHYwzghKbnTQryW+DgZnRoQaoVXvuuAUTPz6qIMWx+I2V7QXqmb5/BgPuRKmM0AahWplsMUsAlWl25L3C8nIj0=
X-Received: by 2002:a05:600c:1910:b0:43d:409c:6142 with SMTP id
 5b1f17b1804b1-44062a3eddamr573455e9.0.1744846834549; Wed, 16 Apr 2025
 16:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
 <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com> <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
In-Reply-To: <CAPhsuW72Q2--E9tQQY8xADghTV6bYy9vHpFQoCWNh0V_QBWafA@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 16:40:22 -0700
X-Gm-Features: ATxdqUFLZu_g7cAHhskZ0L5MamFR6bpu5Vd8u8TDIC07BpRPPZAKqsf2Wefu0qw
Message-ID: <CABdmKX1tDv3fSFURDN7=txFSbQ1xTjp8ZhLP8tFAvLcO9_-4_A@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:08=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Wed, Apr 16, 2025 at 3:51=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > >
> > > IIUC, the iterator simply traverses elements in a linked list. I feel=
 it is
> > > an overkill to implement a new BPF iterator for it.
> >
> > Like other BPF iterators such as kmem_cache_iter or task_iter.
> > Cgroup_iter iterates trees instead of lists. This is iterating over
> > kernel objects just like the docs say, "A BPF iterator is a type of
> > BPF program that allows users to iterate over specific types of kernel
> > objects". More complicated iteration should not be a requirement here.
> >
> > > Maybe we simply
> > > use debugging tools like crash or drgn for this? The access with
> > > these tools will not be protected by the mutex. But from my personal
> > > experience, this is not a big issue for user space debugging tools.
> >
> > drgn is *way* too slow, and even if it weren't the dependencies for
> > running it aren't available. crash needs debug symbols which also
> > aren't available on user builds. This is not just for manual
> > debugging, it's for reporting memory use in production. Or anything
> > else someone might care to extract like attachment info or refcounts.
>
> Could you please share more information about the use cases and
> the time constraint here, and why drgn is too slow. Is most of the delay
> comes from parsing DWARF? This is mostly for my curiosity, because
> I have been thinking about using drgn to do some monitoring in
> production.
>
> Thanks,
> Song

These RunCommands have 10 second timeouts for example. It's rare that
I see them get exceeded but it happens occasionally.:
https://cs.android.com/android/platform/superproject/main/+/main:frameworks=
/native/cmds/dumpstate/dumpstate.cpp;drc=3D98bdc04b7658fde0a99403fc052d1d18=
e7d48ea6;l=3D2008

The last time I used drgn (admittedly back in 2023) it took over a
minute to iterate through less than 200 cgroups. I'm not sure what the
root cause of the slowness was, but I'd expect the DWARF processing to
be done up-front once and the slowness I experienced was not just at
startup. Eventually I switched over to tracefs for that issue, which
we still use for some telemetry.

Other uses are by statsd for telemetry, memory reporting on app kills
or death, and for "dumpsys meminfo".

Thanks,
T.J.

