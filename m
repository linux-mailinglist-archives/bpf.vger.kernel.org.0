Return-Path: <bpf+bounces-40507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0D98965F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9261F22797
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1483917F505;
	Sun, 29 Sep 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpD8s4hW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76917E472;
	Sun, 29 Sep 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629455; cv=none; b=pNbmb6+MOWbirPGw4k3T4uk5xC7n6QPHtS4uGob0oyMNZtn7EabZYeZJTKhyMTvL8hpIDx1+tXVzBH2rEFnkp7rKLEp6Bbver07gqOcC3rvXzKSI5IU1g6xk93rDY8CF7Ohed0ccospks6VTqBMzuaSKR6bD6jM6oLlsA+HxsoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629455; c=relaxed/simple;
	bh=3dpZuf5mlzMXuAYofDLxF/AN6Y1VKHoIqMffTY+I0mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzaJgLpcpxZjBIshCFAFqYC1e7ScfX2DjqDNc8gFmPN78Upm2sWhyHle2shYhd4VgLScUtYTi7OOGVuI5TpQfWqlKTOw80TXaOuGgCt8DhXGKB8hbHOfay4hfJHT2ag7V/jSHwlcWfAy8ipMfsET32NINsdU08O5JMQIzE92u1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpD8s4hW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cc8782869so33796765e9.2;
        Sun, 29 Sep 2024 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727629452; x=1728234252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KNmNodar/eEa8xt2lx9x8Ctw0w3iXIFOpWndbX0j5o=;
        b=WpD8s4hWpgPPzTYql8DfmR5upX9kIEFwK4xylKSFv3hrsrWZcTrsiOcqXRzNwPS6XF
         XfRYYHZxerhnyq2ViaZYHmxWCkkG+l1Rrg0k7LlimvcO4wNpd/nOqjrL6KPbcrj7HTe4
         UTymJvGDUu6fmc0ieWQ3aaYarItGgsHHNWKEPX0iS1nf02h4U8k9QwjdWX9urDRRQEzk
         J6Y8mMwoHcZxSQJqlzXEZAVgUotYv3pTDG6wHMicnc1YSsQfSzx3+VbdYGdwdJdEbcMg
         HYTxwmHxZ5bD5p95aPmYVm5LP6aJARFxaQaW0YPMnvRzQrGT32LPwU/6OufUuyRiORUD
         0Eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629452; x=1728234252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KNmNodar/eEa8xt2lx9x8Ctw0w3iXIFOpWndbX0j5o=;
        b=H/cFdGeHaSAJCF49jXfKiKtolctNklh7ghTMAEaLgt4o6QWbozviCl7DlasHcgDXAd
         Q57CpTwl9kCl7HXjQQZhD2PjWXoyaP9AYjntxuAQnBKS6Iy1qGWbU6932e3yXmn4l3m+
         JbRlTZuHvGRwF1NAZB0NOqJB2OVlAghmyerKecJGVPMfEippKQLFLbY3Lxo+4NfMDt3d
         qYcAU0w3cL4aaWyOO0Qo9Oolkd8L453UDBd7vo8YVRWJjhciRDNEC4OPQhj2PHx+asQv
         8He8OF+wRbLIu1YUVlgvrFn+fYpKNE19mmIMe1rgDuj+8mEzsSnFlswO1/Diw1b7uNBa
         CV0w==
X-Forwarded-Encrypted: i=1; AJvYcCV01Bd4Qg9HlHfnswJ0I/0Qtw1ad6nLGDX5kvR738ZIDQ7F2J3MpXTdVnSUrpGcM2fciW8sME4pt1KqIic8@vger.kernel.org, AJvYcCVOO0WZjTe0MwfYz1GwPZB9p2tLiVbRPQd0ErBho/fwq/NXxC+2/IMZ0KPH+rLEfAwfqts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCh3T2ISc2Tf21Re2KglTMw4yNNDOLUzzA3ass7p0gse8iuIS
	uwQxSeLtz1mYUZUmIkEkA8jDzwrQlBOp8oPLZ7x4M5tKohCHtX6Jd/xchlafnOvvejzJtm4hMhp
	szChZ7ystThAf0s8A3OpwCBsfTo0=
X-Google-Smtp-Source: AGHT+IG9fdMIzAIyKzOuEVwQI+qzk40+S2RJR82r0eUZgTURwnbYJ2CkT++ONN6gi3TikMVmUxg04i3XP94jUBvFjOM=
X-Received: by 2002:a05:600c:5125:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42f5844b601mr73121615e9.15.1727629451995; Sun, 29 Sep 2024
 10:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927184133.968283-1-namhyung@kernel.org> <20240927184133.968283-2-namhyung@kernel.org>
In-Reply-To: <20240927184133.968283-2-namhyung@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:04:00 -0700
Message-ID: <CAADnVQJBKCHJKqjNe9AHEnSbvAZ5Jf_0ULw=v7v3BEW8Pv=_6w@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 1/3] bpf: Add kmem_cache iterator
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 11:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> +static void *kmem_cache_iter_seq_start(struct seq_file *seq, loff_t *pos=
)
> +{
> +       loff_t cnt =3D 0;
> +       struct kmem_cache *s =3D NULL;
> +
> +       mutex_lock(&slab_mutex);

It would be better to find a way to iterate slabs without holding
the mutex for the duration of the loop.
Maybe use refcnt to hold the kmem_cache while bpf prog is looking at it?

