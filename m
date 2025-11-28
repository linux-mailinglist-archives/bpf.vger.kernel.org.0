Return-Path: <bpf+bounces-75669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B602C90635
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 01:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458D13A95CA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1618554652;
	Fri, 28 Nov 2025 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="RfZfNBBO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D092E63C
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288805; cv=none; b=rDz3aTcxtgwX6YM8mLjHk83K64gEBXijDhg+rovO6O/uvsC1lIRKZoRt2Z4clfjDBoYoAhNgXX12P8tpsXcUhzt8pHNBnUxcPefKyAF0IdY0z1z6PD/Oj3O3Nx/aBU+Pyf8dT2ierm6mkSVIh3hsIm4WVVQFaXkSojGwBlEnmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288805; c=relaxed/simple;
	bh=NOZXxio1bahwalhqp2Ttsh4/B4Xjqih1KmKAAyIBE7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QY1WPEOA/7tykRCcVAJ6aAUvjIXvGE19QvlNpInUtZMqaPS85m1X3s9VmfPVBiRxkcF1+UFHZnFk+fgifPcWMDS1lhm0rhcLjg3C36zAltX2nExIWciCyH7CI0s5R1z22uIZ5y1MyZ3Ye5whdZumjC7qDQrX0OmU8rysgoDmGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=RfZfNBBO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34585428e33so1340551a91.3
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 16:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1764288801; x=1764893601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn5NzbOjnuISxzkvZpbv4GRTREgDcKECN79uc6fXBtk=;
        b=RfZfNBBO+3ceUr5Fgw4owD20cne6qeAOVs08xI7weE84GNTmM3rAbNx2EOoCCQg8OL
         cjg0ldvusXJHK0h5MURHA8pc+/foQ9POdVSCpaHr60U4sop1CqMioVAwn0L/tzcYMfrl
         9IxaVBL4BF8Adhcg4AwCrnCX4+nkqQrvXfyqsQInLEiQ1/WCyr+156wS+GpOkxFeujh7
         lJziNPEHpzm4Y4PFaWfldt3bfslzZRp/xwPZr812TYZ8JvYJKFuUcvwqhKyFFJmhC/aY
         bLszlJXfcD8H0R8a2maakAFSpscqVvmK7bZVMgMbZV+E6D0JzsVelwyjU705hpstzUTM
         6AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288801; x=1764893601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cn5NzbOjnuISxzkvZpbv4GRTREgDcKECN79uc6fXBtk=;
        b=teTle/BLQqLE+MUq5xMVqXpRyMRHZneaGWE1PAbyJwxI18J7ier3nJa437N9w4HbFT
         qP6P3wRArdm2+V1OTUQgd+9q6Hf7ZQTnIZg7kIbLPDoXKla4xMoWz47HvJYfrKwG+045
         AcIY3MsP8N/BinQQvjJWAjD9CY/C/umFTf1zch/s57wirFXNtUlhRUijQgmxYa6CGYr4
         O5trKnvodt3xHcd5eDvRFuk24cIk2+75tRBr+Do+6rbJZpa8RYnAeb64T4vrUsso353j
         7yxF3hclGkmlUhe4+SfQd0XxhridGzcx3T56Vd/Vyru6MygO1AtUETPtLv62zlHFmlqO
         j0kw==
X-Gm-Message-State: AOJu0YwHYDV+dVBOWhKZsvqdamcoxt+C1Zjg8uvM3WWFPxXvjJYaBQkO
	gWUtMKi3XoVgg8QE3NobqkQy3j7z0k/mV4z8el549X6X6hig0GQZN7U0LgqG2dhQOvZOfsVNv/8
	JBOyYznANhGCFAkJ5t9Qgq5OGnencAsnKz66HKNvevLNnzFWc9i3HZck=
X-Gm-Gg: ASbGncvSjCtx7/nIxpJmBlf6uTLUl/nQyG98C6leAsy0mP/F+dH2jE18j7CkcB7Jw+r
	r4vW4vdcI4b2GpjRSbb6eULAupTDo4zw1jPB/n1aMQM31IXD8j2cH5h17zyJHUnZ/nV42mrQn6L
	oHJmxVZ7QWJkV0/liCUBY/RDOPjt2PX5tou/+IsHnyXzO5SPhD7n8k5idRQOu/cTVlQYb3eKE8q
	eI8kOF5SdXpsZGhJYouS227BeBZ4+wTW5NNTFwnIsb+WGwXlPaGwZ3zmGFIc132hIeDXsYV
X-Google-Smtp-Source: AGHT+IF93OdwTiEdZmsu4cjHR2kDzxhdHIKf7Kfo2HW5ni+8A6r9sEPwc/l36zfoXMv5bFiPUl7d6AqeYtBb5XrNowA=
X-Received: by 2002:a17:90a:8b:b0:343:6108:1706 with SMTP id
 98e67ed59e1d1-34733ef70admr20849586a91.17.1764288801290; Thu, 27 Nov 2025
 16:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
 <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
 <CAH6OuBQa2QbCXzksiy5PhTCEYBf6m=w0ZKAUzTptxjgqKC25Mw@mail.gmail.com>
 <CAADnVQJaOJbu9odEqCSRRfhvWtudzdN9_=ZqqO7A-jxQf9ZRJQ@mail.gmail.com>
 <CAH6OuBQ5o7d1D1Atq7a+gLGcaH5YgpiYQk4tmZe0y3QQneT=CQ@mail.gmail.com> <CAADnVQLe90XW486yXt+LRFeOHh60FL18i+dEJAYBLdgqdrn_cw@mail.gmail.com>
In-Reply-To: <CAADnVQLe90XW486yXt+LRFeOHh60FL18i+dEJAYBLdgqdrn_cw@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Fri, 28 Nov 2025 01:13:10 +0100
X-Gm-Features: AWmQ_bmSuP27Y33eWEVhNOuhalB0Tvd8x3DLa3XPHNBVt-A0JMMt9fU3pSftksc
Message-ID: <CAH6OuBQdJ-J6NMW6_6SbvGN4k2nZ+YZ87PAPVMOhUCNsz71Q0Q@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>, 
	Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:01=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 11, 2025 at 2:59=E2=80=AFAM Ritesh Oedayrajsingh Varma
> <ritesh@superluminal.eu> wrote:
> >
> > On Sat, Feb 8, 2025 at 5:15=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Feb 8, 2025 at 2:39=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > <ritesh@superluminal.eu> wrote:
> > > >
> > > > On Sat, Feb 8, 2025 at 4:58=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
> > > > > <ritesh@superluminal.eu> wrote:
> > > > > >
> > > > > > Given this, while it's not possible to remove the wait entirely
> > > > > > without breaking user space, I was wondering if it would be
> > > > > > possible/acceptable to add a way to opt-out of this behavior fo=
r
> > > > > > programs like ours that don't care about this. One way to do so=
 could
> > > > > > be to add an additional flag to the BPF_MAP_CREATE flags, perha=
ps
> > > > > > something like BPF_F_INNER_MAP_NO_SYNC.
> > > > >
> > > > > Sounds reasonable.
> > > > > The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
> > > > > is a bit more explicit, but I'm not sure whether it's better.
> > > >
> > > > I agree the name is a bit cryptic. A related question is whether th=
e
> > > > optimization to skip the RCU wait should only apply to the update, =
or
> > > > also to delete. I think it would make sense for it to apply to all
> > > > operations. What do you think?
> > > >
> > > > I also realized the flag should technically apply to the *outer* ma=
p,
> > > > since that's the map that's actually being modified and synced on, =
not
> > > > the inner map. So I don't think "inner" should be part of the name =
in
> > > > retrospect.
> > >
> > > BPF_F_UPDATE_INNER_MAP_NO_WAIT suppose to mean update_OF_inner_map.
> > >
> > > > Perhaps BPF_F_MAP_OF_MAPS_NO_WAIT or
> > > > BPF_F_MAP_IN_MAP_NO_WAIT? I'm slightly leaning towards the latter
> > > > because the map of maps support code is also located in map_in_map.=
c,
> > > > so that matches nicely. They're both a bit long though. Either way,
> > > > the definition of the outer map when using this flag would become
> > > > something like:
> > > >
> > > > struct {
> > > >     __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
> > > >     __uint(max_entries, 4096);
> > > >     __type(key, u64);
> > > >     __type(value, u32);
> > > >     __uint(map_flags, BPF_F_MAP_IN_MAP_NO_WAIT);
> > > > } mapInMap SEC(".maps");
> > >
> > > Actually we probably should make it similar to BPF_NOEXIST/ANY flag,
> > > so it can be passed to update/delete command instead of
> > > being a global property of the map.
> > >
> > > BPF_F_MAP_IN_MAP_NO_WAIT name sounds fine.
> >
> > Thanks. Making it part of the update/delete flags makes sense. There
> > is already something similar in BPF_F_LOCK. Looking at the code, that
> > does mean it would probably make the most sense to perform the check
> > for such a flag outside of maybe_wait_bpf_programs() and make the
> > calls to maybe_wait_bpf_programs() conditional on the flag in
> > map_update_elem() / map_delete_elem() / bpf_map_do_batch().
>
> correct.
>
> > >
> > > But before we add the uapi flag please benchmark
> > > synchronize_rcu_expedited() as Hou suggested.
> >
> > I'll need to find some time for this, but will do.
>
> pls do.

Sorry for the delay on this. As discussed, I've benchmarked with
synchronize_rcu_expedited(). This is indeed much faster, to the point
that it's fast enough for our use case, now taking 88 microseconds on
average:

Function Name:    map_update_elem
Number of calls:  1439
Total time:           127ms 626=C2=B5s
Maximum:           445=C2=B5s
Top Quartile:       99=C2=B5s
Average:             88=C2=B5s
Median:              75=C2=B5s
Bottom Quartile: 59=C2=B5s
Minimum:           10=C2=B5s

I've submitted a patch with just this change [1]. This is fast enough
for us, and we don't need to go through with the proposed additional
uapi flag as far as we're concerned.

The uapi flag would of course make it even faster, so if you think it
would still be a good idea to add that flag in addition to this
change, I'm happy to make the change and submit it as a separate
patch.

Let me know what you think.

[1] https://lore.kernel.org/bpf/20251128000422.20462-1-ritesh@superluminal.=
eu/T/#u

