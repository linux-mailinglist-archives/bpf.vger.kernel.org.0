Return-Path: <bpf+bounces-56361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A06A95A97
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8D61895397
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57537188A3A;
	Tue, 22 Apr 2025 01:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeFD46nQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476D11632D7
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286157; cv=none; b=njjsAeknJK+gu6n+vc61oGTTn3fBakkIyW0A4hwKHlnLFImGqnWnAKKcPvllH4eF6SjbCArWlB9lagnfKMmpMYaVh2bK7ktZ/4zynlZJzwkYHGDgIJLX8dMsqKoQ0T0bDVtkKdazDoY6Dyx58zv6ctlKUWKVKceIwn+KZOQz2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286157; c=relaxed/simple;
	bh=HYlAZ9yS9OXdFbNCcGjxswdMQcexrshex8K+z+Wk9Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhR4/ZsZBInL/PbSoQrVco4KjzSPlytGp1iu+Ya+55jKHfwvIinhfNesENymQDUjQl/cInATJBB/Ib7A+jHHq/gXLuGsvpGQDu7erNNAbV57/ETFUmgru6kz63iUCySEHVLE09ZngsUv2zqOTdS9l1z0SC7+EZDptywvQUb1938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeFD46nQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1efc457bso2671964f8f.2
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 18:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745286154; x=1745890954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRIqmiXRuYs/cdH+M2vkWTCD2XdL6esglWBd4HizseQ=;
        b=SeFD46nQjhHZt3EbMFGgqPsUx38DXwE8ydRHHoRXW3K19JSglfT3cxfaExVYx4buNs
         ATjszF7LgFK4Fu/82+147yS6+bQ7iO7iQoy5CW/D+K/Zy1PwxjlZKtGq234JDv45G24N
         3uCMK5AY3XmGieKflnQi1DeKubg6OqeI8TUb9StiBMh+AwGgUKWjg2+KYfv4MIa863BC
         0Qx+rmE39tg6GCGZFSX8kIPK41VDVNt+FgrcBABSBMmv/9ZPJIT9ypZ2kpfQawGPS4Gs
         jv81hHkCSIRQsB1FJYpUNPKni8DRmuFgSgv7JMyv1MYrTPw/fS5He4uLvEqOefPjzebD
         yqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745286154; x=1745890954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRIqmiXRuYs/cdH+M2vkWTCD2XdL6esglWBd4HizseQ=;
        b=qG6yWU7WuBAdGmtYLwLcCAKM6kTLbF3sVe8nvQczXlZ0C13a2XCL26Lt8/ZH8pPdV9
         yFGQ8aqu3aJr3AmLFH4a6g4KTK65JpaoV0wLsqKrG1kMVu3tLGB6EszLkkQQ9Et3Sq+L
         r3ckzy18LeTXAGzFX9YpwzYpep5N74mVXo02vCzeapmycFZmJf1LQdF+loURHaGFfbug
         NO9OjPWpDWCBmNuMU3pYS8df4giZLMg7bZr22uQQE24mPZ2WsvyQA6bSHty0htrJtbin
         X74GWFxM+PcJEgtnVzGsEuQ+FCX3c68vltI+6DAbD2XUcFMehf+vcehUIHb0f/gylhG9
         ko2A==
X-Forwarded-Encrypted: i=1; AJvYcCXzHLBZS/LVwO4gJBfzIuSKUaUSTQwZoiu+0Wr3g1ung0lJ/7zfNhQhNotbAaE8d/W1UQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3QMg1ozD7CJzXh+KJvp1Cd2N8kWOgk16dX626uGKL9H7YIVq
	FggwZo/PEBSv9P/PmJJQ9U1b7C0qY9lGD8re0Rpq3mtDZy0B42zklFWQYtytc4AkcrK0J4D1BMN
	mJO+KgcNYeVI7n3u+4wbnMTojeIQ=
X-Gm-Gg: ASbGncv9lrT+Ck+Lp6fTiAhNJAOEfKbDjn0aw/BLJ8J24dBuZmtoUgqh/TrJyLlando
	CdZL+jSFUxDl8z/Ttu8ECOVgcZet3n8jjC0wieIPY0XU/pfx5JLqgDh0cIqFjU83XHaI+c9L3FA
	j2Kmu5rEe1ECwNxPNhi7bgCshE8Qjg7Ud11icCsQ==
X-Google-Smtp-Source: AGHT+IFSHaNFMFotSfSaXhMW5hEcyGixZ2Ht2Me2+AcUbgvQhIMZQZwwSD95j7FFX8rZaat38WEPxP9ZfDZ1HDRRGj8=
X-Received: by 2002:a05:6000:178b:b0:391:9b2:f48d with SMTP id
 ffacd0b85a97d-39efba6d7f5mr10602199f8f.33.1745286154490; Mon, 21 Apr 2025
 18:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-8-memxor@gmail.com>
 <m2plhbu68v.fsf@gmail.com> <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
In-Reply-To: <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Apr 2025 18:42:23 -0700
X-Gm-Features: ATxdqUFy-REGFZGvNiqYwUlSssISQe6-9xBqoego006-WOKEU-GwPbuR2jpqUpg
Message-ID: <CAADnVQKGxPb4OjT0mNcKzUzs=_gtKmNFy77zEn2qJ7vaVnmRBA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

> > > +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> > > +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> > > +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> > > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> > > +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> > > +BTF_KFUNCS_END(stream_consumer_kfunc_set)
> >
> > This is a complicated API.
> > If we anticipate that users intend to write this info to ring buffers
> > maybe just provide a function doing that and do not expose complete API?
>
> I don't think anyone will use these functions directly, though they
> can if they want to.
> It's meant to be hidden behind bpftool, and macros to print stuff like
> bpf_printk().

I have to agree with Eduard here.
The api feels overdesigned. I don't see how it can be reused
anywhere outside of bpftool.
Instead of introducing mem_slice concept and above kfuncs,
let's have one special kfunc that will take prog_id, stream_id
and will move things into dynptr returning EAGAIN/ENOENT when necessary.
EFAULT shouldn't be possible when the whole
  SEC("syscall")
  int bpftool_dump_prog_stream(void *ctx) {..}
will be one kfunc.
bpf_stream_dtor_ids won't be needed either.
Hard coding such a big logic into one kfunc is not pretty,
and smaller kfuncs/building blocks would be preferred any day,
but these stream_consumer_kfunc_set just don't look reusable.

