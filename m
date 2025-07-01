Return-Path: <bpf+bounces-62019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4976FAF06AB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234E2483192
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A427702D;
	Tue,  1 Jul 2025 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWXJ66oB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3C23F28D;
	Tue,  1 Jul 2025 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410060; cv=none; b=D2pCrD8ejkcRZAnpmG43OCC+dPm11LfGpf7yjRJqthc0pXIyMDDwaTvD5fBQrXfJqucg+4qdi8qWrujyMKqHNK7OSxdS0B5g4eo+i9YhK1vXyqWe+jyeNo+1iscz65/SazkWbj3zlOGfFX4X+YpGxyuw6EfV6SPwr/x0BFTdcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410060; c=relaxed/simple;
	bh=BfFOBs68JeQYk1q7e48hF/Xe2WhQQeFYHLQC3hg5O2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iymXZNNRsoyy6aJ7sVsiheiPndO0G8hVBer5WIYUfp6tswcLLWB/N623l6nss6sEONGB82z5BgilRCSHDoK6ZL61ufgx1mzRZ/bnQnh92haV9woMicPpeedGsrJAtawR2vQTo7ABn0fAWfA+z4qDYW8ckNLLyU+cLfOEZd0t3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWXJ66oB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e3e0415a7so60166707b3.0;
        Tue, 01 Jul 2025 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751410058; x=1752014858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBHNYo68NWEG2CkgAtv5wIPMjOu/mIg9DJZaW8zmUJE=;
        b=bWXJ66oBRQyCuFeGastjMAGbL3jBCFeA7XNF/hzb7SgKC10qO6VALJWfe01HOHOLOM
         UKxYLROi7Mq1OpPNAS45udITCSgpfxoyaHUNU9PXNsLnvRPRXvpUQLtRPoJL4fNwL0oL
         RET35JjWqddya9KT/gmYZK2+gJLy5Dg9lCRaeshECqAgKH6rnGcN4nL2tHVmgsQ8x40A
         UE4MYwxoJTRjWAucqlPhCsujaURk9Uo3LXEOXMAx2BryGuqFNH3y2mfkbpoYW1oMEqFK
         8goEOg5AXEIYD8o9QoQx03EiNVPWL80k4yH/eXWhl+C+q7sozwxcZhhxQOmFA7LS6utD
         CbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751410058; x=1752014858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBHNYo68NWEG2CkgAtv5wIPMjOu/mIg9DJZaW8zmUJE=;
        b=ibAk1bt0Ph82VC2MusCwDXCTqFZenDYq4sJqQlXGyEW6vjsqImOq2B/TIgMPPM+ehZ
         OZI2yt8ucHSlGNsrOAAwOts17g+jJPuZ/9A07CGIoaN9V5TeNejPzW6lbVO6zgDeVR+Y
         LFaIag+HrFJQmjh6UAgzQlNL+jbLozf3hIOpIsXfKpBR8txghlsOzRwmytJ0vWMQ5UKF
         ILab4CvNGzmftHHKhl2ybdxTtum5B0SlOY9IHx9efS+FcS71rWTbztHbnt6rbOUIjpSC
         a7b85PDwQpvNa2bdDANGHY5FbckMj9Dh9bCOxB2MDKmaiDqXwtmU1YUwDLgdcnScU2oM
         aHpA==
X-Forwarded-Encrypted: i=1; AJvYcCV9MslO7ddiKZUXdSM8ONPtFUVor5g/E0tbVNGLQOjkuqemekmGbADzZNk/6xPfkRc4pqrJNhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2TElvpQ7oCmBA9JNrA4SMMl8Ehl0d3Cndg1nJtBfYmdodnJ6
	1DTXyeuSMYyQ2NeuXbb0ZPDooAULkWOT0fYbry/mSCuZLQYwVJhLi4Qamc5scuY/f/1D8JZCu2j
	dxWucCOiBly+1Fl292AmQceBdDTPBujU=
X-Gm-Gg: ASbGncs6zLHpaWvgC9l6Sb4SJEEn45dghciaanY1uNMGxJ1cWl8tAsuEXCOHtR+D9m/
	uV5o19dVy2yayHkoQt73mn3irn0nse8b/KxMH8Er85v/eQaai4XN2MoPXwggvPUDOkXn7+vyH0X
	KQrnHGLfLT8yCcVlY+vFDHKe7iYSWIQ4H7TM1zDXghzN0ZHYRVR6tZpQrrUyM=
X-Google-Smtp-Source: AGHT+IH+AhxC/ReHnZs7OqgGk3EBPJbnPC01EHvnPb+FIafxkEVGsMynYAIRvxvsiBVkGhQGrLAlcy5oKm7vGvWH3MM=
X-Received: by 2002:a05:690c:7105:b0:70e:77df:f2f9 with SMTP id
 00721157ae682-7164d7f1fe9mr5887377b3.15.1751410057936; Tue, 01 Jul 2025
 15:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627233958.2602271-1-ameryhung@gmail.com> <20250627233958.2602271-2-ameryhung@gmail.com>
 <CAEf4BzYFdiQX3gz8Nd2T2cGm6NCZPzTVCRh+eh_C2gYd=cEMpA@mail.gmail.com>
In-Reply-To: <CAEf4BzYFdiQX3gz8Nd2T2cGm6NCZPzTVCRh+eh_C2gYd=cEMpA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 1 Jul 2025 15:47:24 -0700
X-Gm-Features: Ac12FXwzqslpdsbJ68KlZojcsFCcedhT_QF3_fb4kxGluZ73xDNMPNBXgOVfX1c
Message-ID: <CAMB2axPuRgPg_mhEW7ZbmjexFEqLkfnfSpVHuCZ-j4U3UxYtTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] selftests/bpf: Introduce task local data
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 3:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 27, 2025 at 4:40=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > Task local data defines an abstract storage type for storing task-
> > specific data (TLD). This patch provides user space and bpf
> > implementation as header-only libraries for accessing task local data.
> >
> > Task local data is a bpf task local storage map with two UPTRs:
> > 1) u_tld_metadata, shared by all tasks of the same process, consists of
> > the total count of TLDs and an array of metadata of TLDs. A metadata of
> > a TLD comprises the size and the name. The name is used to identify a
> > specific TLD in bpf 2) u_tld_data points to a task-specific memory regi=
on
> > for storing TLDs.
> >
> > Below are the core task local data API:
> >
> >                      User space                           BPF
> > Define TLD    TLD_DEFINE_KEY(), tld_create_key()           -
> > Get data           tld_get_data()                    tld_get_data()
> >
> > A TLD is first defined by the user space with TLD_DEFINE_KEY() or
> > tld_create_key(). TLD_DEFINE_KEY() defines a TLD statically and allocat=
es
> > just enough memory during initialization. tld_create_key() allows
> > creating TLDs on the fly, but has a fix memory budget, TLD_DYN_DATA_SIZ=
E.
> > Internally, they all go through the metadata array to check if the TLD =
can
> > be added. The total TLD size needs to fit into a page (limited by UPTR)=
,
> > and no two TLDs can have the same name. It also calculates the offset, =
the
> > next available space in u_tld_data, by summing sizes of TLDs. If the TL=
D
> > can be added, it increases the count using cmpxchg as there may be othe=
r
> > concurrent tld_create_key(). After a successful cmpxchg, the last
> > metadata slot now belongs to the calling thread and will be updated.
> > tld_create_key() returns the offset encapsulated as a opaque object key
> > to prevent user misuse.
> >
> > Then, user space can pass the key to tld_get_data() to get a pointer
> > to the TLD. The pointer will remain valid for the lifetime of the
> > thread.
> >
> > BPF programs can also locate the TLD by tld_get_data(), but with both
> > name and key. The first time tld_get_data() is called, the name will
> > be used to lookup the metadata. Then, the key will be saved to a
> > task_local_data map, tld_keys_map. Subsequent call to tld_get_data()
> > will use the key to quickly locate the data.
> >
> > User space task local data library uses a light way approach to ensure
> > thread safety (i.e., atomic operation + compiler and memory barriers).
> > While a metadata is being updated, other threads may also try to read i=
t.
> > To prevent them from seeing incomplete data, metadata::size is used to
> > signal the completion of the update, where 0 means the update is still
> > ongoing. Threads will wait until seeing a non-zero size to read a
> > metadata.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../bpf/prog_tests/task_local_data.h          | 397 ++++++++++++++++++
> >  .../selftests/bpf/progs/task_local_data.bpf.h | 232 ++++++++++
> >  2 files changed, 629 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_d=
ata.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.b=
pf.h
> >
>
> [...]
>
> > +               /*
> > +                * Only one tld_create_key() can increase the current c=
nt by one and
> > +                * takes the latest available slot. Other threads will =
check again if a new
> > +                * TLD can still be added, and then compete for the new=
 slot after the
> > +                * succeeding thread update the size.
> > +                */
> > +               if (!atomic_compare_exchange_strong(&tld_metadata_p->cn=
t, &cnt, cnt + 1))
> > +                       goto retry;
> > +
> > +               strncpy(tld_metadata_p->metadata[i].name, name, TLD_NAM=
E_LEN);
>
> from man page:
>
> Warning: If there is no null byte among the first n bytes of src, the
> string placed in dest will not be null-terminated.
>
> is that a concern?
>

It should be fine as the BPF side uses strncmp. So, a TLD can have a
name that is TLD_NAME_LEN-char long, not including the null
terminator.

> > +               atomic_store(&tld_metadata_p->metadata[i].size, size);
> > +               return (tld_key_t) {.off =3D (__s16)off};
> > +       }
> > +
> > +       return (tld_key_t) {.off =3D -ENOSPC};
>
> I don't know if C++ compiler will like this, but in C just
> `(tld_key_t){-ENOSPC}` should work fine
>

Designated initializers has been supported since C++20, but I can also
just use (tld_key_t){-ENOSPC} to make it less verbose.

> > +}
> > +
> > +/**
> > + * TLD_DEFINE_KEY() - Defines a TLD and a file-scope key associated wi=
th the TLD.
> > + *
> > + * @name: The name of the TLD
> > + * @size: The size of the TLD
> > + * @key: The variable name of the key. Cannot exceed TLD_NAME_LEN
> > + *
> > + * The macro can only be used in file scope.
> > + *
> > + * A file-scope key of opaque type, tld_key_t, will be declared and in=
itialized before
>
> what's "file-scope"? it looks like a global (not even static)
> variable, so you can even reference it from other files with extern,
> no?
>

It is a global variable. File-scope is just the terminology used in
the C language standard
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3220.pdf

> > + * main() starts. Use tld_key_is_err() or tld_key_err_or_zero() later =
to check if the key
> > + * creation succeeded. Pass the key to tld_get_data() to get a pointer=
 to the TLD.
> > + * bpf programs can also fetch the same key by name.
> > + *
> > + * The total size of TLDs created using TLD_DEFINE_KEY() cannot exceed=
 a page. Just
> > + * enough memory will be allocated for each thread on the first call t=
o tld_get_data().
> > + */
>
> [...]

