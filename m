Return-Path: <bpf+bounces-26320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30589E3A4
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E451F23FC6
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5E157489;
	Tue,  9 Apr 2024 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4Ue//W+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D56415699E;
	Tue,  9 Apr 2024 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691292; cv=none; b=tzuqM7tHftFip+7URblToceUk65z6u4lJvFg1CWFrQrTfmvXKSAHFn18wxmOydnR5+fRDy4p+yoMHnqDU9F2F/R+we+V2DG0RT/RNHfB/9CqkQfXZhyG3Or+37MhhMGrNDkxOYSE4DQLNmfFgRmIh02Fso2x4u1jAjJKxJziWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691292; c=relaxed/simple;
	bh=mmPXqmrwcTucEfNP1CWkUUL1KBemF3Ggz3nykg13Mgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PShPzEggRl10+r29rqL1jR2ezFURitVdYwtSYPCXQG8EXZ+WWC62PP5bRAJjq9Sg1VrArey44VDJXBD1KxufvGRh9HC/MS7M0rDK/PFY7DTIcowd/f6yqbrtZrf4+f4dSdD7B3sWaBYK428PYpEQR0/2SvKwePvX1xhdOA0vvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4Ue//W+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-416c1d65038so1863275e9.3;
        Tue, 09 Apr 2024 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712691289; x=1713296089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmPXqmrwcTucEfNP1CWkUUL1KBemF3Ggz3nykg13Mgo=;
        b=C4Ue//W+kjSCAZ2iHGnXfxMS4YX7VdJJZqT+iR/h3MOgd9xrKK+T1qu34JK0JgnYqD
         f1QX8R7lgeZxZU4aYOB4uj3BcMuXjorHlQng/NZ/AcJ2D32OFZ8FdHSovUUMwsg7lTmi
         mvHbv/tYDq3vhuHPEJI/mcVTZZQwXluTZjAt86d/Np/PAhOr3/UxI1kEvKHX9/ZZYwmp
         BTo4uh96VG9F17kQZP2B2/eZKUKRF7mIBFhwyi3hjNOBpgq8QAW23opbTa367nT1SdUM
         uRWzbw+H/fmz9KR6qWmCcf1qT5jU7xtCB3wcDR4BgWXrZYDZNSJy8Y0hQyv8f0/PsdB/
         vqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712691289; x=1713296089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmPXqmrwcTucEfNP1CWkUUL1KBemF3Ggz3nykg13Mgo=;
        b=nTwib81K+8THnqJolP9BvDrK0M99SITMdhM1hxzMgXcHNnKrcvOXVVHT+fhfM2Nsee
         O8++5attASbkOrMRIncOibddy8i30OGI7pDJqjwpRtIzlmUn9AmsOYdDvzVa3aqVQRcG
         3KbjhSdm7JaM3BX+xqCa0ZrmOznaVQH4WiFd274jvmj43+vMBzprLpNX5/lV8TVEhbUL
         Nio/L88fwsFCSnd4MpJSLMSTMhdwU5LQ8X28sJWezhRgh8JpOHM991S6Ofd0lVXmSBxP
         sVagiOwk0d3WSJjAm0fvD1PQg6mVBh1L9sTYIYGMOqdECNeQGVq51mMvnx6NbqUcOZkx
         lCCw==
X-Forwarded-Encrypted: i=1; AJvYcCVuW5mfofZ3q4aRB+84Tw0Co6aXZgsOVWL/YFqGublPiwUNwI9Srbct+9sAv5nTCIDGG81nzaeK/OYcttlOipwtzk2YfJwFqgbAAzt5qgsm7iXXp4/WjHta8Ck3TQ==
X-Gm-Message-State: AOJu0YxXhI7KvzAQ+VrEGnqhbFBL0IJPCBdCASpZabz7xJhmKUKo7yOe
	UCyqJaCEQJjedjAlcUBYKCReWrSFYXu3ykhlJqwRQPmqKDg7eQs3XP6PR40Snv5977HvaM4uvp7
	JV7QUBySkv/fwT0VSTPQlDqhfR6M=
X-Google-Smtp-Source: AGHT+IHWimL8z3u1wsjz2fq+YD8HoFpman4/6pMOU910P8yQXLkoHqZiEK6VxUclTiyYWAllPbxljM539Kkpc1Ja2KM=
X-Received: by 2002:a05:600c:4fd4:b0:414:8e02:e435 with SMTP id
 o20-20020a05600c4fd400b004148e02e435mr481953wmq.3.1712691288789; Tue, 09 Apr
 2024 12:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402193945.17327-1-acme@kernel.org> <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com> <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
 <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
 <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>
 <ZhWMxu8Xq1oAUAoC@x1> <1314495ccf0d31babf408eb539fa2eba70e404a0.camel@gmail.com>
In-Reply-To: <1314495ccf0d31babf408eb539fa2eba70e404a0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Apr 2024 12:34:37 -0700
Message-ID: <CAADnVQ+M_R7F7Ny+aJmtLoK_QggxtEHhEJC5kV0ovXwCaD29sw@mail.gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 12:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-04-09 at 15:45 -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 09, 2024 at 06:01:08PM +0300, Eduard Zingerman wrote:
> > > On Tue, 2024-04-09 at 07:56 -0700, Alexei Starovoitov wrote:
> > > [...]
> >
> > > > I would actually go with sorted BTF, since it will probably
> > > > make diff-ing of BTFs practical. Will be easier to track changes
> >
> > What kind of diff-ing of BTFs from different kernels are you interested
> > in?
> >
> > in pahole's repository we have btfdiff, that will, given a vmlinux with
> > both DWARF and BTF use pahole to pretty print all types, expanded, and
> > then compare the two outputs, which should produce the same results fro=
m
> > BTF and DWARF. Ditto for DWARF from a vmlinux compared to a detached BT=
F
> > file.
> >
> > And also now we have another regression test script that will produce
> > the output from 'btftool btf dump' for the BTF generated from DWARF in
> > serial mode, and then compare that with the output from 'bpftool btf
> > dump' for reproducible encodings done using -j 1 ...
> > number-of-processors-on-the-machine. All have to match, all types, all
> > BTF ids.
> >
> > We can as well use something like btfdiff to compare the output from
> > 'pahole --expand_types --sort' for two BTFs for two different kernels,
> > to see what are the new types and the changes to types in both.
> >
> > What else do you want to compare? To be able to match we would have to
> > somehow have ranges for each DWARF CU so that when encoding and then
> > deduplicating we would have space in the ID space for new types to fill
> > in while keeping the old types IDs matching the same types in the new
> > vmlinux.
>
> As far as I understand Alexei, he means diffing two vmlinux.h files
> generated for different kernel versions. The vmlinux.h is generated by
> bpftool using command `bpftool btf dump file <binary-file> format c`.
> The output is topologically sorted to satisfy C compiler, but ordering
> is not total, so vmlinux.h content may vary from build to build if BTF
> type order differs.
>
> Thus, any kind of stable BTF type ordering would make vmlinux.h stable.
> On the other hand, topological ordering used by bpftool
> (the algorithm is in the libbpf, actually) might be extended with
> additional rules to make the ordering total.

Not looking for perfect ordering.
People check-in vmlinux.h into their repos.
If it's more or less sorted the git diff of updated vmlinux.h will be
a bit more human readable. Hopefully.

