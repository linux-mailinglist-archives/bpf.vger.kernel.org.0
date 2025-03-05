Return-Path: <bpf+bounces-53395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEFBA50C49
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E0F16C5CE
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C7255E43;
	Wed,  5 Mar 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PV6p5hz8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1F253F01
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205579; cv=none; b=E5uFYwdHoFV0eUmpU2YoEzQbnbNWcU68aUvraH3bS5JltzoyxcgVxSSfuwQWKxoGWoNPKGqhNhjO+FxQI8oQTIm7xioNIK0X6pOmTqQ07gWd2pjc7jHJzg64RWVThaAGC57iX6Rp2bzNs4sEzCEhUAWX68q1xULN81/5YoX4PG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205579; c=relaxed/simple;
	bh=zNu+uO+qVUH2lHjGc7UpYzRsUdmyNBFYkU3NKGrAkMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMTGeGza8E9/lpmjU9pOkHGu7Nucjk0bIHXUKVG9+TwSfS9kfdNnHFxHpQgy44SxcxtO2jzv3z4SnHFocYjY4u82q6pZMEIwXaobe3njU9i2huzFvx52x3HaiXkAO3Sk/fBrQ9ubWqfsPFZvBWDn+jO4enjpXFtfcjSISnyKBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PV6p5hz8; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549be93d5eso7721820276.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741205577; x=1741810377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=PV6p5hz8QrMFrM47dGnoPz1YwgyU82UYK5Kmu04FwnzTrDH4creMEB21e9+BqTaTBm
         2tml2F3kDrKZ9Os1fGqrnSvIh7xHTSarCHECwjCUvQZw4vAQr4RXQbbpqY90dA/eAFQl
         tp7BktFTuEHnEaDgfT25PSRLH2kiKL41BGR0J0yKbfxJALYPD2nNE0aW9n95QuEdPaje
         jEcO5xxEa2Ro/EhA10NfRKGLTDcVNz/71bsyyDYVJW1pnmIlu32pZHq3QywQ7hdnJ6XS
         MBUf9cduaVdehx5/dp9HNgo+5JZgpxzKYgm38Vg8Kr8LS2PuAWKK/1904Z0QFXWl7KGJ
         q7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205577; x=1741810377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20bCxuGfaDVAOpC3W+MtKdxzg/x4LtoR169fsBOSxiQ=;
        b=HxXY0bkmvMy1KalQWJK9195RcGGEdB52KQwMVloWovfCfKANqQuUcPAd2fNZ9gdEEG
         rsSfhckIZzry41TB+Al0Z4nWFjEZkweBP0/+LBJ2dh9tLYARzSM1GqEn7+yH5Z1EfGcE
         RneIvKYgJnrZoL2NthQJndTF/PDNHovkKSyyqKr2kgxoGUtSNbkMR2BsqhBLl8psL5xh
         g45X3xyNUpMOho6y5R01QyNFCV1506yzfZQZqb5qywaPfBJsHNkAzcFY1EyaWwj5Ux4n
         8ia1PqdTRr2XnhH4RWSlHf/Uws32Il06YwC1NoG7sGGOFhUyS7GgrEIJppRwarcbTzo3
         HxbA==
X-Forwarded-Encrypted: i=1; AJvYcCVP2W6jAV8ObieaQn9v20loQ/NnQlu27xhnmxcJ/yMl2Y0bxiLJZDafqFTwWE353h0zEEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZHf3BqufvuPs3WWR+2+u8k3g5S177GLvJebc2bWBSNv+uz4x
	/r6kohA/mCceeJCYEccB/S/4me+qlld7SDF2HhWRoaz31bikMOG2zAF0lywQeMaQVSjInvjLEZp
	6qO92i/F2Yv8PWN03k8XllzWA4QXhU0FFVG45
X-Gm-Gg: ASbGncuUcKTL2XRI9p2Xic2oCz5dedvhZt7nP+XzE25/bNQ93zCPi1id+TXhD6eqAZt
	zZ6Gl5NQRhOX7MRubzO6RuGFeXpuNJvyJQ/WlI7Su3gxykAPB/bEUkWYogHWjJeYilrR4n5nwhW
	5COLgmxrm1REDFdOX+fbjLD3CXyA==
X-Google-Smtp-Source: AGHT+IFb1lQWxZfA+3Fj3IIMOvkgMjpy++obS3VPsP4HPWlePPjHMEfo/RAlFL+2ENHWUfAYeV2u1UeTQGpoYyph5bM=
X-Received: by 2002:a05:6902:161b:b0:e5d:d2ce:a40a with SMTP id
 3f1490d57ef6-e611e30582dmr6534407276.34.1741205576740; Wed, 05 Mar 2025
 12:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
 <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com> <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
In-Reply-To: <CAADnVQJL77xLR+E18re88XwX0kSfkx_5O3=f8YQ1rVdVkf8-hQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 15:12:44 -0500
X-Gm-Features: AQ5f1Jp_oXF4bydH-aIRtYZmN6RTF7YwHfbbSgRNBrjTiC_WlFGzFQqTRg_361Q
Message-ID: <CAHC9VhR5NmSU+eanprCk-osSMZnZ+ODwLJKWuqd8e1qDobim7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Song Liu <song@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, Mar 5, 2025 at 8:12=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:
> > > > > Paul Moore <paul@paul-moore.com> writes:
> > > > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > > > <bboscaccy@linux.microsoft.com> wrote:
> >
> > ...
> >
> > > Do we need this in the LSM tree before the upcoming merge window?
> > > If not, we would prefer to carry it in bpf-next.
> >
> > As long as we can send this up to Linus during the upcoming merge
> > window I'll be happy; if you feel strongly and want to take it via the
> > BPF tree, that's fine by me.  I'm currently helping someone draft a
> > patchset to implement the LSM/SELinux access control LSM callbacks for
> > the BPF tokens and I'm also working on a fix for the LSM framework
> > initialization code, both efforts may land in a development tree
> > during the next dev cycle and may cause a merge conflict with Blaise's
> > changes.  Not that a merge conflict is a terrible thing that we can't
> > work around, but if we can avoid it I'd be much happier :)
> >
> > Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
> > and feel free to keep my ACK from this patchset revision.
>
> My preference is to go via bpf-next, since changes are bigger
> on bpf side than on lsm side.

Fine by me, the patch has my ACK already.

--=20
paul-moore.com

