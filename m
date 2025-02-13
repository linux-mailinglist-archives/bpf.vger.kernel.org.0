Return-Path: <bpf+bounces-51355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6CA33722
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 06:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7143A3A4A75
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 05:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7C2063E0;
	Thu, 13 Feb 2025 05:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD7ysUFJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FD23BE
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 05:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739422884; cv=none; b=iLcMmXcWIRvRTw1c7m+8xz9+ozVXj+GUe/2qqkovQTzHMWCY14+Mpsu/bupdCo6hZtRrzGn3zj2277OQbSL3PtkAVY++xu6THB0VfYDJcab8o5NQEB50rp9OERhWtRgoqbfy+Z/Jh67j5Azx9kdko2Uvg4HUkrQOg+UXxeOYomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739422884; c=relaxed/simple;
	bh=WrYbyX546znTgbp12DPslm2Dp5cI2637Mc2SVCTeKOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptwv+xuv/4/RYTmp8cbV2YuTwWRFW/McNHGoIL8P5U/g+kcuae4U7gWcwxyF04GdIe88N70ij9GzkhPzpHUZbfxuaM3GborTyQmQrSFCnfNRJIWNSo7uJjK6myfXEfS7oiWM2CmIiRZcKtMerx2z0JwN55dakevbfxmM60d294Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD7ysUFJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38dcc6bfbccso202931f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 21:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739422880; x=1740027680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lszdCFlwHjtPzZTau7tl1gMzfBqWxJBKDJMn8f+XPXE=;
        b=eD7ysUFJfaYo7eUcu4LMR3UNaQw8PPjB0QvPF4Rsm4yyrqvgOjYLNVZPgRVXAbSTPz
         Nj9VZWirzZd5w2/wl8/2iJuDU6dkkTI6JpM0Bt8/b+t2FZZ6CfPuc3GSyrfiOJZsmfC/
         xG8Zdmk6l4fBMiiQAhEmvsSQWYwEChJ9GEABvTL47HNgBTFvPPma+tO+sQLuA0zWQThj
         SFZFe5+ZsHbnarAxoZNvcg2telVa79nDKBIEzBcHVL2y0Q+Vq/QFV/brpxC9apwvfNY1
         lA6URUtQebW2uK7CDWYCe7XIOEgqa8l1WpFf44pHb9n75OmQlBLLidNFewcsKhnpOhvq
         nBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739422880; x=1740027680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lszdCFlwHjtPzZTau7tl1gMzfBqWxJBKDJMn8f+XPXE=;
        b=ca30n8oX0CSoN7QzVJDRDaawBZfNIVKWKkzfht6o2gUbvoztQxt37cQHvm6BPEvahm
         Z6INWozuUDhjtTfV+95SM5StX8RZk7ttOaBcIaShyfD8CI7MRi5tI4/2pbaZrLTOCzCj
         wq9M7oKt5Qz4SYQMWiXEq8Ey5uuBTmBfSMB7NG8hY3ouLy05ioOnSgAr4cVPzJIm0twp
         WsDXgazQCrSu7Q6648kngzHvkio2h9poxoR+vN+JpIQNYZLiU0I+teu2hmHR+ooMIacu
         pBLnFtI4FlR4fdtVL52WRBleTQGo0j8A7WQA5/EK0JVa2/hZNx4N4uj8nxldxcSuMy94
         UwxA==
X-Gm-Message-State: AOJu0Yyfbp5RBkUxWgZD/qo2jsYw6zeUxjZfUX3RTii+iMBwrJ3Kx/F9
	i6ObqZWpteABcDQN7CXyw+sc9Y/iLvqzMczDjlX8v/GSauKx7bE39yTo3gpJskc4iF4VGyP2613
	VRCPLIdTthCJPiRokCxuoQWrpUdOk6Q==
X-Gm-Gg: ASbGncupJzHRWvaV4IihHRvUPMEGCY0OyqayKdAq0yYk4AbZ/TDrt+JeQQ5i2mX5gn3
	fJlJsmiy9cXyqUcthJG+juT4tYg4RVpzeWPYf0wjvxwKM6NNLceKUCRrV20kCpvvk6ld4aLykuF
	KX/Rkh0zBocxZUuo9z92TpP9fy09sv
X-Google-Smtp-Source: AGHT+IEsjFwRez4Q9iGx3Lix8w2iC/EDFTzol72DXGRAlXsPUW4p9PEgcUjMvTkXjaHO+vAOEE1g1WaI+dAWMq2pG/M=
X-Received: by 2002:a05:6000:1f81:b0:38f:2193:f8c2 with SMTP id
 ffacd0b85a97d-38f219400b7mr3215138f8f.31.1739422880274; Wed, 12 Feb 2025
 21:01:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
 <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
 <CAADnVQJaOJbu9odEqCSRRfhvWtudzdN9_=ZqqO7A-jxQf9ZRJQ@mail.gmail.com> <CAH6OuBQ5o7d1D1Atq7a+gLGcaH5YgpiYQk4tmZe0y3QQneT=CQ@mail.gmail.com>
In-Reply-To: <CAH6OuBQ5o7d1D1Atq7a+gLGcaH5YgpiYQk4tmZe0y3QQneT=CQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Feb 2025 21:01:09 -0800
X-Gm-Features: AWEUYZnOLNVWkAADuWDCTEg1HUlsKoNA4ave5ne0x1KW34BILzNVSI2VVhcNThg
Message-ID: <CAADnVQLe90XW486yXt+LRFeOHh60FL18i+dEJAYBLdgqdrn_cw@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:59=E2=80=AFAM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> On Sat, Feb 8, 2025 at 5:15=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Feb 8, 2025 at 2:39=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > <ritesh@superluminal.eu> wrote:
> > >
> > > On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > > <ritesh@superluminal.eu> wrote:
> > > > >
> > > > > Given this, while it's not possible to remove the wait entirely
> > > > > without breaking user space, I was wondering if it would be
> > > > > possible/acceptable to add a way to opt-out of this behavior for
> > > > > programs like ours that don't care about this. One way to do so c=
ould
> > > > > be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> > > > > something like BPF_F_INNER_MAP_NO_SYNC.
> > > >
> > > > Sounds reasonable.
> > > > The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> > > > is a bit more explicit, but I'm not sure whether it's better.
> > >
> > > I agree the name is a bit cryptic. A related question is whether the
> > > optimization to skip the RCU wait should only apply to the update, or
> > > also to delete. I think it would make sense for it to apply to all
> > > operations. What do you think?
> > >
> > > I also realized the flag should technically apply to the *outer* map,
> > > since that's the map that's actually being modified and synced on, no=
t
> > > the inner map. So I don't think "inner" should be part of the name in
> > > retrospect.
> >
> > BPF_F_UPDATE_INNER_MAP_NO_WAIT suppose to mean update_OF_inner_map.
> >
> > > Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
> > > BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
> > > because the map of maps support code is also located in map_in_map.c,
> > > so that matches nicely. They're both a bit long though. Either way,
> > > the definition of the outer map when using this flag would become
> > > something like:
> > >
> > > struct {
> > >     __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> > >     __uint(max_entries, 4096);
> > >     __type(key, u64);
> > >     __type(value, u32);
> > >     __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
> > > } mapInMap SEC(".maps");
> >
> > Actually we probably should make it similar to BPF_NOEXIST/ANY flag,
> > so it can be passed to update/delete command instead of
> > being a global property of the map.
> >
> > BPF_F_MAP_IN_MAP_NO_WAIT name sounds fine.
>
> Thanks. Making it part of the update/delete flags makes sense. There
> is already something similar in BPF_F_LOCK. Looking at the code, that
> does mean it would probably make the most sense to perform the check
> for such a flag outside of maybe_wait_bpf_programs() and make the
> calls to maybe_wait_bpf_programs() conditional on the flag in
> map_update_elem() / map_delete_elem() / bpf_map_do_batch().

correct.

> >
> > But before we add the uapi flag please benchmark
> > synchronize_rcu_expedited() as Hou suggested.
>
> I'll need to find some time for this, but will do.

pls do.

