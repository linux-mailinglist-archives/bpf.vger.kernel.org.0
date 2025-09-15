Return-Path: <bpf+bounces-68413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D7EB5841B
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29761AA7189
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616672DAFB7;
	Mon, 15 Sep 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr2NPkVm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDC2D0626
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958950; cv=none; b=LuziPKpSpLUL6qkD36liFsL8Z0dHYOi74pXabeN7u0hXW+RCF1B3+xfRa4hB7bC4IvTarOEQGwXnCPQaYJqQiQJ6fY6CZmfRMfw70zXsl+kG+72njnUpp/37VQLzBvWDV+xTWYwNtK63+m5L51Cf38Lp1jSfVmbI97b075QpI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958950; c=relaxed/simple;
	bh=vy0H2Ph9BPFxzbTZCxPAtHz9T/LngICsnONhEzGQD/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOp88b1e4X7FYO4A0TvNClJzOTF78qbB+CcGbtEyZvdGDgmFfv84gjOWVVn0Y2aUcpgqBXBKW4WU0GTXpoKUIKfzV15mZj5+byH25M82Dhn9cCEYR9L3/GaB8JsGzkHE4/4MVEVFEjE6OfOIvuDzWNTdlCwGpzNl0kMYC7D3FFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr2NPkVm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e9ca387425so1356000f8f.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757958947; x=1758563747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vy0H2Ph9BPFxzbTZCxPAtHz9T/LngICsnONhEzGQD/o=;
        b=fr2NPkVmyMoAExKgC5lRbrqpjd8328OYObFHoCPtcITPxuZM/mq6UVYpZGsxurDrGC
         4R/WKeuu/01q0lJbpQr9V7rAAZv1JGHWxUNQ6lskaolthGzI2BvVf6yUuP/jGdxo8kLi
         x7iiHt/Ri+8yw18XmaSp1GaDGrEM+N1iJIpmUitljLHHnQJpB+FbUOYa55Phafns0Oh0
         cUTYAsebFcBySW6NoBLeH4TwHHHrhY6VsRR898J1vaggksylyHyNzmmm4sT1ZtYl0jjO
         t/ts/SR8AHOh219Fjpk051El3hEjxjvfjxlJac0NUGRO2LBupd5Rb0z5iw7f06Hs+nab
         cCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958947; x=1758563747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vy0H2Ph9BPFxzbTZCxPAtHz9T/LngICsnONhEzGQD/o=;
        b=U0NOXRZqn9AeQVdmlJWeT7auR208puxFnPs56RU/tuwefICBsAf23MFnF1oKA/zX6f
         KNz832iJNNiaJcESJGDY65Sg8x810DbEcY01TKXl5bN+D4ZQVGFKVPZRtGhPri0k+csT
         Lt27VYGKcIJw0Tc6DUQ4A7mK/42AeH2RWbj4BPH+XvSEIP6F/PMWmKfkCp5X9+5e16il
         k5Gu8z2DDVT5GwGG6kKZCS3Jovd5tdxmYK7Ww37A7ifhlV7DcvN9cVbsWMKx+lHwGmTW
         M9Fw+WTpEAf1Vmw+0qig4rFsIuibtslcM7qjSTrq0yyitJ3dY7YXPXN7BjMTnLv5tQs5
         Qd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1nFzkURH+zMj1rronnUrA8Wl36Ndyt2otSzWjKW73FRGya0iXfR0+66fN4bnLSLyh2Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9nrdgzErzqdjnQRPoXdw9QQgxcQwafGgWrezdoq52xgpnMfm1
	eTk/oIoXHI2ijGaYDmfSNttkFDiRYn9ONvdNZkt6+6FoPH5zIw0woRL+hYDr8LHmAkhdw8AoTTv
	j18/3PcB9bXQSRhcielUzL0kYQSpNjwyvQLsu
X-Gm-Gg: ASbGncslZ11I5Tjvx3OxaJIkW2LXSMZmL0f4qK/SZsrz+FDLY0Pe8v5lDdmDQs7bcAd
	McPOfsvimQJ1WI/YebnlSWm5e3hi8MTvWND5gylA8EUx/Yw7BDUo+6Pwh5Iytc1g+V3rpGspjIq
	yKv7iSHz4YGSejg7KMrjueX5uBPganTN6gLfXLJpItPmmbJ9+Qc3+GJX5j2+nMmmfR5YdnePRlc
	kOPRDl+Vi0IfcBa5wXIG18=
X-Google-Smtp-Source: AGHT+IHKsL32/jp6Qm0keA6voznmil/J08npIrpQxJdntWWPmIzTIXtU2Fx3gBQYuMKHv9d149D5CYDpqb+B8VZka4Q=
X-Received: by 2002:a5d:5886:0:b0:3e4:64b0:a776 with SMTP id
 ffacd0b85a97d-3e7659fcbc7mr14668783f8f.52.1757958947152; Mon, 15 Sep 2025
 10:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915024731.1494251-1-memxor@gmail.com> <20250915024731.1494251-3-memxor@gmail.com>
 <aMeuunTYM8c6jp1m@gpd4> <CAP01T74DSRE96FYRCMLghkFJdNPgi-PhoOycQ2fXyYhUF5ngBw@mail.gmail.com>
 <aMfIMOF17vFVrfTt@gpd4>
In-Reply-To: <aMfIMOF17vFVrfTt@gpd4>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 10:55:33 -0700
X-Gm-Features: AS18NWCFL5SKUtUQTl2bYIw7_9eMq_FwOJN-P98rm7m77TMTIg5_3wtiPfjwYL4
Message-ID: <CAADnVQLpYMMhPjxJ1R1GMQ_+yMuZjZxS6XOPR-ntJHHweK8N1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
To: Andrea Righi <arighi@nvidia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:03=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> On Mon, Sep 15, 2025 at 09:13:15AM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 15 Sept 2025 at 08:14, Andrea Righi <arighi@nvidia.com> wrote:
> > >
> > > Hi Kumar,
> > >
> > > thanks for looking at this! Comment below.
> > >
> > > On Mon, Sep 15, 2025 at 02:47:30AM +0000, Kumar Kartikeya Dwivedi wro=
te:
> > > > Add a kfunc annotation 'KF_RET_RCU' to signal that the return type =
must
> > > > be marked MEM_RCU, to return objects that are RCU protected. Natura=
lly,
> > > > this must imply that the kfunc is invoked in an RCU critical sectio=
n,
> > > > and thus the presence of this flag implies the presence of the
> > > > KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will b=
e
> > > > made to make use of this flag.
> > >
> > > I'm not sure we actually need two separate annotations, I can't think=
 of a
> > > case where KF_RCU_PROTECTED would be useful without also having KF_RE=
T_RCU.
> > >
> > > What I mean is: if the kfunc is only meant to be called inside an RCU
> > > critical section, but doesn't return an RCU-protected pointer, then w=
e can
> > > simply add rcu_read_lock/unlock() internally in the kfunc. And for kf=
uncs
> > > that take RCU-protected arguments we already have KF_RCU.
> > >
> > > So it seems sufficient to have a single annotation that implements th=
e
> > > semantic "this kfunc returns an RCU-protected pointer".
> >
> > Yeah, that seems reasonable in general, but we already have iterator
> > APIs (bpf_iter_task_{new,next,destroy}()) that collectively require
> > RCU CS to be open throughout the three calls. That's why I just
> > cleaned up the internal logic for KF_RCU_PROTECTED and made KF_RET_RCU
> > as what you're suggesting (i.e., fold KF_RCU_PROTECTED into it), which
> > I assume will be most useful for the majority of kfuncs that are not
> > iterators.
>
> Right, my suggestion was to fold the KF_RET_RCU semantics into
> KF_RCU_PROTECTED, even if the kfunc doesn't return anything (assuming it'=
s
> possible). Then annotate both iterators and kfuncs that require RCU as
> KF_RCU_PROTECTED. This should handle both, right?

+1 to this suggestion.
I think we can extend KF_RCU_PROTECTED semantics to mean
that the returned pointer is only usable in RCU CS.

