Return-Path: <bpf+bounces-54398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF5A6987C
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 19:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF82171CB4
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FF820E316;
	Wed, 19 Mar 2025 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzEWuzgP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D319849C;
	Wed, 19 Mar 2025 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410598; cv=none; b=bYUR5KTcgP+dm9iCFxuH9jXptJ6yaTvJxjQXttaYp8DNR1JYu3bYHvKS36pc0y9+94M25Filk4RmcCSRpRdPmkPlzZ+QOGWHHzrP1Nejto0VDhyvNY6FBxcTI8J1n3cOQNyLyCRWfU8VY8OuuaS/RvC8qxkugyFjNWRsDBmxC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410598; c=relaxed/simple;
	bh=QK4UM0a6hYZLGUgxeGdAQVgMTggWz+G51H/KUqDc0i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owCrD4rt8qCmfqwn+7y93pQLzPw1pHoIXaEUbW4mw1zQO5zh3jxHxy0qmrRWFAtyXsGIRRCdnQ5pDAKUJ8txHsUnCRuVX1Oz05kFKLpP291LmL3JBmZ36rs2swqSd2pH7LHN8iGQm2phGhNcgSMzS/MDtiSnifgkJrN6Nhv95ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzEWuzgP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so4703748f8f.2;
        Wed, 19 Mar 2025 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742410595; x=1743015395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pVyXRKqi2f2q6dcqNMaLy81qVcLDE0skAC1kas4RdI=;
        b=dzEWuzgPtpbeREcqw/ImJP7VQE/2FW8/1m5dmuSZaTBsAL11mx94OiBsVW9wGskmwR
         odrk8JM+9ZaVpy11YIowkdRXGcjAWv2p3lpXRZAmb0+QBHA7dQip1YBj9uxSYs1QU2oV
         hM7vP0WloEt7vkSJx2R/5mM0dZmRrrQKaMO8zdZSIINYr2iyOsbtm+4uWFKxgvntPMWA
         M6i+Solkv+CyO7sWs0LvWoOwx31LSon39HT8gKjbv7/6Qjh9CAkor/Uv+0f+fA3jXFGP
         nTiQ9+vyINwqo538y3kAJDVX9zRP0O81y/RhNppq8bcCQkffzUdv7pRQR3wn/FtFeydx
         xNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410595; x=1743015395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pVyXRKqi2f2q6dcqNMaLy81qVcLDE0skAC1kas4RdI=;
        b=w+aU8CKvLwRa6LfhimgaPjjMPmFz6AdEW5mzbwXd6QSo2YuX9NjgmjEiIXmxwzmuNd
         tgRZMPIR07bjCVJSUQObIYbkYq98ScBTLAQQIZDwwpfeGx1k0F+YtWLRp9IVTQ+dAFVo
         WIHAKg04utu2hSWehNlr6MiR6Kmu5UEoljHNoweQXHItUmjiHSgJn/OsDT5bJAEFbnem
         U5W6q7ze/Nb4RppzijCSwcBtQkAykSHkb/M7A4MpImS/Mpob62UYULJSK0TBd1CyNvbh
         G23ZxWYJ87aKNCqYmZtT92uyEr1mQ+GXUL/jm2UKsRwLZlrwd8Iv11Q7jejonn3a2ZGz
         bz9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAkl9B2qgZY1z1fY9xd7m5nwVZsEy2JVBsShAw8iabWQaOWozmVx+qTC8E4lWEOuEFTby4OcXz9lQaqg==@vger.kernel.org, AJvYcCUTrMxJunt0gJ62WnmplnTAcO/t0zj3rov4/e5LrjswSCj7a68kunR6Tb7CbHDtPcv3y99ghkRt+C2bSVuY@vger.kernel.org, AJvYcCVOTpJR+S+o5Ko3o5yDucSUSsfR+m/sij39HFXuDmcG6QjQeNGqrYBJwAK90w1g6XypE6w=@vger.kernel.org, AJvYcCWYXlrHdHOETt7nP4u6SXK14FawVBl2plFDWUpLO5qk7t3UgAWuNU6K+l/EjcFu72hSMcAHOYYg@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQge1DWQO8BD/LozypFIOWUudyYf2J6wwZIxFIAcYU41QVB9m
	KUlcnAbICjwIeuXnxtglEScpsFuRY9609wjtynfchgmGQwMuCL4yZeOQAo9H/asVua6+CWKG9W/
	dwnmPymD+Ic6mw6tuzCTPNzk+7zM=
X-Gm-Gg: ASbGnctpsmpXsOOzgyyZZGsQvbHmrtQpem0h27RfTNVzhdhtUq/2DWGKYgErQNaftg5
	pgYjJMasRkVoIpzG2yQsEvpAQbyhEnSnYA3dwxGQFtzXaljGl1hKdmxIOb0/HrwMO9Drt/Lmikq
	vxvTUaFLjbR0XDOlcQp/jchOn4YiBcKqoqAwkU1BnNFg==
X-Google-Smtp-Source: AGHT+IEYA1KqZVhFZX0olFWxkQHjaRRclBaTPTJhqKlkOkj0rbGCy7Nv4vLYIYYyJKJnJcyLuk0OsxCP3+BVQ1ZOI1k=
X-Received: by 2002:a5d:5f90:0:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-39973b08eeemr4446120f8f.44.1742410594428; Wed, 19 Mar 2025
 11:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com>
 <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
 <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com> <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com>
In-Reply-To: <CAFULd4brsMuNX3-jJ44JyyRZqN1PO9FwJX7N3mvMwRzi8XYLag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Mar 2025 11:56:23 -0700
X-Gm-Features: AQ5f1JqfV-ElB1pMA_QAuJNOA9MgrQVHtGRLbejhynYCLbxsZEIhRjEAGHhFBAk
Message-ID: <CAADnVQ+7GTN0Tn_5XSZKGDwrjW=v3R6MyGrcDnos2QpkNSidAw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 9:06=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Mar 19, 2025 at 3:55=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > > >
> > > > > I've sent a fix [0], but unfortunately I was unable to reproduce =
the
> > > > > problem with an LLVM >=3D 19 build, idk why. I will try with GCC =
>=3D 14
> > > > > as the patches require to confirm, but based on the error I am 99=
%
> > > > > sure it will fix the problem.
> > > >
> > > > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
> > > > Let me give it a go with GCC.
> > > >
> > >
> > > Can confirm now that this fixes it, I just did a build with GCC 14
> > > where Uros's __percpu checks kick in.
> >
> > Great. Thanks for checking and quick fix.
> >
> > btw clang supports it with __attribute__((address_space(256))),
> > so CC_IS_GCC probably should be relaxed.
>
> https://github.com/llvm/llvm-project/issues/93449
>
> needs to be fixed first. Also, the feature has to be thoroughly tested
> (preferably by someone having a deep knowledge of clang) before it is
> enabled by default.

clang error makes sense to me.
What does it even mean to do addr space cast from percpu to normal address:

__typeof__(int __seg_gs) const_pcpu_hot;
void *__attribute____UNIQUE_ID___addressable_const_pcpu_hot612 =3D
    (void *)(long)&const_pcpu_hot;

I'm curious what kind of code gcc generates.

In bpf backend we have the concept of address spaces and there are explicit
instructions generated to convert from one addr space to another.

