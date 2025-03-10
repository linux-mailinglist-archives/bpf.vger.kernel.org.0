Return-Path: <bpf+bounces-53773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718E1A5A736
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 23:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183883A9A0B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027431D9A50;
	Mon, 10 Mar 2025 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbcVbJDc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3A40BF5
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645917; cv=none; b=jz9gxFg2QSgGFZ3GTAFRA7W6y40kKflewYCxVQEcdObWB3lvYGH/W3qsLXgaug5FEjA3OY4Y0pdGeD8KsBaT02nT/orB6VAmMm981eH/aK+/PoS7j36JGhSaoGTD1i8cHPUVaAFrJPJZzW3Jb2VNFINexCe8omjIJ4XzHaebGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645917; c=relaxed/simple;
	bh=FViW56UXS+wiX8x/Td//iht1TACl5GFoovMzlLaeMhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0MWqlCWUkLFeymT5HS054raUcZq8Ya2Bjx/LLnVtaecJXgTjTwzcpmTPmeWd1WkECZdNtIU39fkUzis1V1PQEOeQX5lB2Z2s1XX8yGplafupxKMcgpCFpgcLL5/sxjEeUwWsVpgWbLgDzRYqIs4jrbq6bR5RNXCGAG3m7YjM5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbcVbJDc; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47509ac80cbso21908401cf.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741645915; x=1742250715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIg9XMQmzEvJno/MgkMxBzd1jni7htg+2SxEd9/4hrs=;
        b=ZbcVbJDcv14YeVv5B6ABZ/sDs45JFh2EHPDmXvuPZ3jiv9c2UtRUWNGwTLX62vkR7G
         4zCPiOfdMOIg4snWNLo2SV8WCadSRzKD2usizUllaFx2V+Qq6ySv5d7djFP6W8uJzyS1
         86N6/cBZebx1sfIh/WIkdnkDSJGxR1Zzv3eJyYm3OkUl8jCoGeicpL8JPr2blZ3CUQWA
         q7PK4/SZbgY7xxpyjeOxo8q1gAC4zYm1I542izS2nXL2DE1hLA214AvwnIBcURGFP7DL
         lM/0YhLKeBX2TeR1v1qSbWYbCn5uAjCpTiY2kvxFISN8DCSlpJeJyMh8mOym3WCZeCuG
         n/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645915; x=1742250715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIg9XMQmzEvJno/MgkMxBzd1jni7htg+2SxEd9/4hrs=;
        b=evZ+IDP57JzwIJ2X42YRO4VQ2TqL9psOIWcntoqN0V/vuGhkChzd3+zFJyMoKBeMrg
         cpXAZXsgtLXfmo4QDUKnMBt0Ky8mJNN6UyMTtUNMO4fZEbd1L5enQFFmoRikzj9UC1aX
         pzwhytYPilRclS+vflb9rb6QUguXv0VvdBgbNeNqeYMW4eumcZ8Hm4gVUwLqRKf9KFN6
         /yv2OrcZgHA0lybo7Kv6KpCx5SeY4xqRxNgPeQpiwio+Imkp1+KhSBm81E6rr8bfeyeN
         vj8UQdLYMloVPjjxBrBLIM1XzN8dafBMCeFOxUa3KN1+S3xaawNvIGEreNrDD6o4nPq4
         l0WA==
X-Gm-Message-State: AOJu0YyrgSWFkbBRbeKWdc6rnmp+a8sjcwlQCUynZB2PaPqBclfQNg5r
	RNLP3sBoXjyN++y2owQv4ki3A74dwT86C9IDrVWGV6jxeHwFITOR2M6DycTjO5pHvWayNcrANUJ
	dC9PXOCzT3iIEN+oXpQXJrd8srkE=
X-Gm-Gg: ASbGnct+tDjyWfJV4h+HYA83zeoetd7MVZX3f6/ArjhF9+IqBrxSDP1W6WnOQdb3B0H
	DY4jgei4dQZv4x1gckzX6T6zLdcm0c2Zq8frhXbSpLiRl0cbuPPlL80tBsVn52tUpzjWcwNUUkk
	xOnKQ9VTSa0nktkvc4L6RWgc8jL3zhk+o18XM8tiWejz4zSz45r0bLcp6m3WE=
X-Google-Smtp-Source: AGHT+IFAVB9oy0OIFjeT9qgsp6CC85ZuOnHurnQxP1FeCilKwO46cHbQ0Bpabv7i96uhr/XXGAHafas8A4XALHy0b34=
X-Received: by 2002:ac8:7f56:0:b0:474:fa6e:ff4a with SMTP id
 d75a77b69052e-47618aeffefmr235409741cf.44.1741645914471; Mon, 10 Mar 2025
 15:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>
 <Z8oXIhptXWhbCeCF@pop-os.localdomain> <CAK3+h2ys8ivcnnd=em7QZRWqqmtSuqy4xEiDoV6+9ccOzJHu4w@mail.gmail.com>
 <Z89c+5k3sRX8Al1I@pop-os.localdomain>
In-Reply-To: <Z89c+5k3sRX8Al1I@pop-os.localdomain>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 10 Mar 2025 15:31:43 -0700
X-Gm-Features: AQ5f1JqQT2z2xC7GiMqgHWdwkj8qNYWL5UzhnRpR3ZvyTHRZAdOvsb_gEHYCpP4
Message-ID: <CAK3+h2zi+xKb3mqZeUm2jjiBzgq86F8jMDz4g3GRyQDk+U5p=Q@mail.gmail.com>
Subject: Re: [BUG?] loxilb tc BPF program cause Loongarch kernel hard lockup
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:43=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Thu, Mar 06, 2025 at 08:04:14PM -0800, Vincent Li wrote:
> > Sorry I had a type error on the loongarch mailing list address, correct=
ed it.
> >
> > On Thu, Mar 6, 2025 at 1:44=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.=
com> wrote:
> > >
> > > On Wed, Mar 05, 2025 at 04:51:15PM -0800, Vincent Li wrote:
> > > > Hi,
> > > >
> > > > I have an issue recorded here [0] with kernel call trace  when I st=
art
> > > > loxilb, the loxilb tc BPF program seems to be loaded and attached t=
o
> > > > the network interface, but immediately it causes a loongarch kernel
> > > > hard lockup, no keyboard response. Sometimes the panic call trace
> > > > shows up in the monitor screen after I disabled kernel panic reboot
> > > > (echo 0 > /proc/sys/kernel/panic) and started loxilb.
> > > >
> > > > Background: I ported open source IPFire [1] to Loongarch CPU
> > > > architecture and enabled kernel BPF features, added loxilb as LFS
> > > > (Linux from scratch) addon software, loxilb 0.9.8.3 has libbpf 1.5.=
0
> > > > which has loongarch support [2]. The same loxilb addon runs fine on
> > > > x86 architecture. Any clue on this?
> > > >
> > > > [0]: https://github.com/vincentmli/BPFire/issues/76
> > > > [1]: https://github.com/ipfire/ipfire-2.x
> > > > [2]: https://github.com/loxilb-io/loxilb/issues/972
> > > >
> > >
> > > Thanks for your report!
> > >
> > > I have extracted the kernel crash log from your photo with AI so that
> > > people can easily interpret it.
> > >
> >
> > Nice to know AI could do that :)
> >
> > > From a quick glance, it seems related to MIPS JIT. So it would be
> > > helpful if you could locate the eBPF program which triggered this and
> > > dump its JIT'ed BPF instructions.
> > >
> >
> > This is call trace from Loongarch CPU so related to Loongarch BPF JIT.
> > the kernel seems to lockup immediately right after attaching to the
> > network interface. to dump the JIT'ed BPF instructions, maybe just
> > load the BPF program, but not attach it so I can dump the BPF
> > instructions?
>
> Yes!
>
> You can load the eBPF program which triggered the crash manually without
> attaching it, using commands similar to the following:
>
> # Load the program without attaching it
> sudo bpftool prog load hello.o /sys/fs/bpf/hello
>
> # List programs to find its ID
> sudo bpftool prog list
>
> # Dump JIT instructions (replace 123 with your actual program ID)
> sudo bpftool prog dump jited id 123
>
>
> Thanks.

I got it, with the help of LoxiLB maintainer, I am able to only load
the tc BPF program without attaching to the interface when starting
the loxilb process, the kernel call trace shows bpf program
tc_packet_func, I assume that is the program to cause the lockup, here
is the jited tc_packet_func link [0] which has 13064 lines, not sure
it is going to be helpful

[0] https://github.com/user-attachments/files/19171378/tc_packet_func-jited=
.txt

