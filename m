Return-Path: <bpf+bounces-62434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9473AF9AFC
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 21:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D6C16A15F
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B81DE4F1;
	Fri,  4 Jul 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ3Fm2eB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4120ED
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751656031; cv=none; b=d5f36yKZwDQmx99yJw1HC7ATyhBZuKHFTOXpMtm8wxyky1qkddKytaK53s1CtUrROwPdz9btjMWtaoxFxhf9MIBb5jqpkABCNDzkBigwzRN2fZjE6jvS0WdxzLmUMWiYTFYvkC5bKf6Sh8/I7NepgG08A4tL+3+JCX5zbdVcVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751656031; c=relaxed/simple;
	bh=H1h7Vl3Q1LAgdAAsVBIt6TYhscWy3LT3CEW0LW+o9oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITHYAetIgRaVFvxcdUtGDnw5az+vwt9LpdFR5aMJyuR4bEPfVfkQHD0irirmad8rC9CGxMl6FCRJnhb/rpNH8ZepP5KiKsKkS8XVr19GCwZpFsD9TqLILyjZejQJXcaBkzUe028rAvGnGF/4JAwlMmqNIskmf55EDtYI+1ZnyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ3Fm2eB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00a1so11638385ad.3
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751656029; x=1752260829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RCcsM7eaXayS/xKEXnYqal99ERnxWBNeOKqr/iUlVsk=;
        b=OZ3Fm2eBt/UAIGHC3LJnJsgLNc9LCSpYS7G/WLK6wOAMisVHJs+T2CAJMOaV/HF7o0
         IK2aRdFlJuH/gsR0eudrJwa4Ti9T68TSJoj4L5KMNoVm0vf4vh/k/3SFbGtwfP45FP4z
         39G309ezAspUCHPQZl2esecS4NdEytEArnUOGhhSL/Mp9kEUdErVrz7sI/uYnvNAr/sU
         ql/dauf8S6zbfMpCHb+xbbrMC0vTLcSDkimHrm3f0Tayd3rFCrPFSe+w8Shafsf3OuFN
         65jiXMsJYYi7MkMJYI1/dOeI5U1MuMCSMyODDZraQvWC3ziyBFXrDsMJrRMGltwz48eY
         sL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751656029; x=1752260829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCcsM7eaXayS/xKEXnYqal99ERnxWBNeOKqr/iUlVsk=;
        b=NBRaLqqq9X+0Rr6VBun0KpN2k6n0NyU9Ddowgmis7aAvfSCH2HyndQuEmJWYgMc5Gm
         Rk8+j19e3JfLNbBmtlBKmchk5rkVvvE98hejRQIoa5KN6uf3Bh447u5kDS6IfhQjCyp3
         lphvNAKaItXyLYZGItkG1lcea1DhAVhzMig9XqLxTOwf9Cy8V68ztax9SYhWNz+SFZj7
         5f7cHEYftkrJbW4TeUSSMPEvv6onpu1m0vJE7Nu31qjNGkToc0ijKvYp51hu0Afc/Njc
         tU1bZlYxMmm+NK5ntvXVUz32OcQAvq1ktAk6jAgHZPpoNU/rntYItkrDmw2DQocEYTjM
         /YWQ==
X-Gm-Message-State: AOJu0Yx/7IN8jw1AlfOoKcJPhEL9S5fzzGS3GMc2DZGE8zCEMjrZtigH
	R8Qr3aKEiM5Ie3mG2K75VgoxeDnpByhq1LeQ88Cs6KtUqJkgC1WXAm4B
X-Gm-Gg: ASbGnctiLomyqjH1qMevslBE4AdY6dhRUzk4WzhU6CHfUsk/qXmsGS5h/yOSNV+puDG
	p1cUBVbb65YbM/2mPIEsjxjkw79WDbvwGic2gknxEkQMNLauJOEhMZaPyG20bkCMZ94PiezratQ
	Y83dQ5LL62IBlP33nPJivcK/3x9EpSCH5HVzFTC1LSXZEpFIFNpvODjSVbVDx2ztzLUqDjfOca/
	/da3wQUJph4eZeaUH6fbOBL16QsGC4j0mOtwHDyxAKFKOocQ2HmEOLGlAOxdusdnn35h5Pc4JI0
	CXGxpRqdf0dJSTCkGfXcUSmt7oQWshwRFsc6Vm+WbdaNSSRhCPQW+2XZIQ==
X-Google-Smtp-Source: AGHT+IGZxSzCEcDRG4s24jysinwKeFKfiytf0V9WKjJwSwtT+VGOcczG8NC5GY13nPEFIl3qtRpJAw==
X-Received: by 2002:a17:902:f543:b0:234:d2fb:2d0e with SMTP id d9443c01a7336-23c86067147mr60979015ad.10.1751656029169;
        Fri, 04 Jul 2025 12:07:09 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e9cbsm26400645ad.179.2025.07.04.12.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 12:07:08 -0700 (PDT)
Message-ID: <a8f522a0e9eaf060727b7782d700f998efaa757c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski
	 <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 04 Jul 2025 12:07:06 -0700
In-Reply-To: <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-5-eddyz87@gmail.com>
	 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
	 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com>
	 <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
	 <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 20:50 +0200, Kumar Kartikeya Dwivedi wrote:
> On Fri, 4 Jul 2025 at 20:33, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Fri, 2025-07-04 at 11:28 -0700, Eduard Zingerman wrote:
> > > On Fri, 2025-07-04 at 20:03 +0200, Kumar Kartikeya Dwivedi wrote:
> > >=20
> > > [...]
> > >=20
> > > > > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verif=
ier_env *env, int subprog)
> > > > >                         sub->args[i].btf_id =3D kern_type_id;
> > > > >                         continue;
> > > > >                 }
> > > > > +               if (tags & ARG_TAG_UNTRUSTED) {
> > > > > +                       int kern_type_id;
> > > > > +
> > > > > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > > > > +                               bpf_log(log, "arg#%d untrusted ca=
nnot be combined with any other tags\n", i);
> > > > > +                               return -EINVAL;
> > > > > +                       }
> > > > > +
> > > > > +                       kern_type_id =3D btf_get_ptr_to_btf_id(lo=
g, i, btf, t);
> > > >=20
> > > > So while this makes sense for trusted, I think for untrusted, we
> > > > should allow types in program BTF as well.
> > > > This is one of the things I think lacks in bpf_rdonly_cast as well,=
 to
> > > > be able to cast to types in program BTF.
> > > > Say you want to reinterpret some kernel memory into your own type a=
nd
> > > > access it using a struct in the program which is a different type.
> > > > I think it makes sense to make this work.
> > >=20
> > > Hi Kumar,
> > >=20
> > > Thank you for the review.
> > > Allowing local program BTF makes sense to me.
> > > I assume we should first search in kernel BTF and fallback to program
> > > BTF if nothing found. This way verifier might catch a program
> > > accessing kernel data structure but having wrong assumptions about
> > > field offsets (not using CO-RE). On the other hand, this might get
> > > confusing if there is an accidental conflict between kernel data
> > > structure name and program local data structure name.
> >=20
> > Maybe just add __arg_untrusted_local and avoid ambiguity?
>=20
> That might be less ambiguous, sure. But I don't see why the fallback
> would be confusing.
> It might be nice if we can support it without asking users to learn
> about the difference between the two tags, but if it's too ugly we can
> go with explicit local tag.
> A user can have a struct without preserve_access_index now and having
> the same name as the kernel struct, and the program will load things
> at potentially wrong offsets.
> If the same type exists, the program would fail compilation in C due
> to duplicate types.
> Are there any other cases where it might be a footgun that you anticipate=
?

Well, basically two cases assuming that program does not use vmlinux.h:

  struct kernel_type { // assume kernel type has 'i' at another offset
    int *i;
  };

  __weak int global(struct kernel_type *p __arg_untrusted) {
    return p->i[7]; // assume no CO-RE relocation for &p->i
  }

In this case, if kernel BTF is searched first verifier can catch that
access to 'i' is bogus. However, that is not necessary if one assumes
that verifier should only check for errors that can bring down the
kernel.

Another case:

  // assume there is kernel type with the same name, but program
  // author does not know about that and does not use vmlinux.h,
  // thus avoiding compilation error.
  struct accidental_kernel_type {
    int *i;
  };

  __weak int global(struct accidental_kernel_type *p __arg_untrusted) {
    return p->i[7];
  }

In this case user would not expect any errors at load time.

Hm.
Maybe just always use program BTF?

> > > Supporting bpf_core_cast for both prog BTF and kernel BTF types is no=
t
> > > trivial because we cannot disambiguate local vs kernel types.
> > > IIRC module BTF types probably don't work either but that's a differe=
nt story.
>=20
> > I can add bpf_rdonly_cast_local() as a followup, do you remember
> > context in which you needed this?
>=20
> Adding Matt.
>=20
> Not long ago we were discussing iterating over the bpf linked list
> since support doesn't exist in the kernel and it was safe in the
> specific context to iterate over the list.
> Ofcourse, we could add iteration support in the kernel, but another
> approach would be the ability to subtract offset from node to arrive
> at an untrusted pointer to type in prog BTF (that was allocated using
> bpf_obj_new).
> But bpf_core_cast didn't work there, so we ended up discarding that appro=
ach.
> Not to get hung up on this specific example, but I think it would be
> useful in general.

I see, makes sense.
That should be possible now using bpf_rdonly_cast(..., 0) but one
would need to explicitly cast each pointer in this way.

