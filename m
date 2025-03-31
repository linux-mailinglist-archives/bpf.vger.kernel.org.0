Return-Path: <bpf+bounces-54992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40989A76DFD
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854A43AACE5
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1685217675;
	Mon, 31 Mar 2025 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD20b+eA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223A18BBBB
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451847; cv=none; b=k3O1bA+NX/kDouFCHok2a8HhiascTTcipdfYx3C8P4rb7+gJ9YdAZ8H/gQY9EA4jDRTe0AQCq/R9wm+gyVU9F0SfF1lGllTaTPjYxzKrwpBisiLuOHhUsYpO95aVuu/u9b+n047dD+OrYL93pmoFIc5PynO3owPd5g14BJgcwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451847; c=relaxed/simple;
	bh=jH9o9LiN768p6wYvk3N/Bm2AhWlpYbBmGvPU6R+pbQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmWIimM4madncMrn5WnUQjvgYGA9Kctyv6M2hocznoFm3m8riMK3agi9fIgh9rjte8LFXq1E6rUlnCJyeX7xLuWO8RvO7idok1mj7F4xpyJfmOugse4+iYijsEkKzbuMEwqvhaVXOhmBXDXFIDQ9xk57i4wo5IJ7fTQdVcvm/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD20b+eA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso7754765a91.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451844; x=1744056644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Axh/dcEJVrEB1Gdu0UUddw5MAjy9I6Pv9wOQgGPNKQ=;
        b=mD20b+eAlQbJqPFDq/vACsrzks7eDSNotHzGGECu2Yn+qT7OjPAWnhV/gPtkUMkgrQ
         QCfoXq9EhtJZKeC0Dsge4JnEfOcQ+M329F3lW0WHcM7jwHDaXpLivlu/693yNzEUiV3K
         oTroS2EHZ3uD8PA/0o9dsUGiYyt9kUFOEUKz8N1lX+qmWp/aEHdw8Sl+NcHw0qB3XnEM
         cmSj/03RWvRJ+kWk8I91KJPgUzfrt6skKfcrMknTKUG2qlpCfhTe4QEg+/wn8xX7Qwzi
         IQ++tRd1Hz5nqFCbDWyyl56z8XuTUAPi9jU6CNVryItTEqF7ZN/Esj5lCHNl6xUDyzvU
         rMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451844; x=1744056644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Axh/dcEJVrEB1Gdu0UUddw5MAjy9I6Pv9wOQgGPNKQ=;
        b=oj5TuIt9ZutgWx8gvQbEhWInGcLby8bdKucqOvUupZUXd266W4BTtR+WbqDAe+hsrY
         M0ZonIQFl157Rgqc4/3mAG/GXJjgeO8/vXgiU7D3VWT3KYC1x7Kst/KUcvTZMGHjfMOi
         qMkQ9Jcqgn4lkcf9fO8683opZEPaj7FRXQrPmNSdn04AWly3m1MQAFG/WfoexWpmZkIW
         4bvpeAs6TNScoBstWkYORqbJ2360If9DJSeb7du2mWlD6lM4F8FlpMnJZn9yvEk2t9iA
         m1MmRuKVrdkMT/MkX8Djxg7/6NisTBTfyzkY0RmsN6bEC19ZgVr2jYLNc0VMJTlhzm0Y
         wxow==
X-Gm-Message-State: AOJu0YxKhbusr8TsLc6soSvCaTiH7LS5OfOx+tUcbjWJ+ejznXzCLgf0
	1xW4gS8mzxGZp/tm5h1KZhf8qHuxsHn+yLzFHFsl85zCo5GfjOgjn1j5EfZPSBvrn1sqk1ds34G
	jxM5sCRxS/nY/vOQk8yHlhq0p9II=
X-Gm-Gg: ASbGncvr9fxhUirOOOD5UYUBn3QXWfESBL4cXYQEJoF8ILGREqTXBuWBuwaVLbJtvZT
	dTrVnLziOR+8DHnB64w8Awe1s+4/H9aeR4hmBfG0fiZaDN9LrER2rI0NSEPBfdM7Qaps0WFdJFP
	3harkfKF3M1J0p01kQrhWPr73wwT/9jkeISLZi4ma63Q==
X-Google-Smtp-Source: AGHT+IEYj9wWgomLWztdRK+jNUZY2p6ThE3G4J9+aW425ZCMhGrzMaElb/HNfBmUJOX7N7l3pi4lXpqLq66RDuVpVDI=
X-Received: by 2002:a17:90b:3a44:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-30532163db8mr19452861a91.33.1743451844254; Mon, 31 Mar 2025
 13:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318143318.656785-1-aspsk@isovalent.com> <20250318143318.656785-11-aspsk@isovalent.com>
 <CAEf4BzZSfzDEMk5uSZ6+QhzGrNpzM7PpPiJ+Ga9yg1rFqMU2SA@mail.gmail.com> <Z+f3vJ4Q2LWSJ8sr@mail.gmail.com>
In-Reply-To: <Z+f3vJ4Q2LWSJ8sr@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 31 Mar 2025 13:10:31 -0700
X-Gm-Features: AQ5f1JqX9f2o5eZXP30Zt3J2xh8-zbvYm29jeZ16k8tAZ5Gqjk6rcwJbZWvsO3s
Message-ID: <CAEf4BzZp83ro2knKQoZEH+8e4+MJfBK_h4EJmdyCLbk4wcANsQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/14] libbpf: add likely/unlikely macros
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 6:33=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> On 25/03/28 01:57PM, Andrii Nakryiko wrote:
> > On Tue, Mar 18, 2025 at 7:30=E2=80=AFAM Anton Protopopov <aspsk@isovale=
nt.com> wrote:
> > >
> > > A few selftests and, more importantly, a consequent changes to the
> > > bpf_helpers.h file use likely/unlikely macros. So define them here.
> > >
> > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > ---
> > >  tools/lib/bpf/bpf_helpers.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.=
h
> > > index 686824b8b413..a50773d4616e 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -15,6 +15,14 @@
> > >  #define __array(name, val) typeof(val) *name[]
> > >  #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __CO=
UNTER__) =3D val } name
> > >
> > > +#ifndef likely
> > > +#define likely(x)      (__builtin_expect(!!(x), 1))
> > > +#endif
> > > +
> > > +#ifndef unlikely
> > > +#define unlikely(x)    (__builtin_expect(!!(x), 0))
> > > +#endif
> > > +
> >
> > this seems useful, maybe send this as a separate patch? I'd roll your
> > BPF selftests manipulation into the same patch to avoid unnecessary
> > code churn
>
> Yes, let me send it separately (+ a comment fix from the patch 01).
>
> The reason I've done this in three patches is 1) every separate patch
> should build 2) I thought that libbpf patches should be separate from
> selftest changes? (=3D how libbpf changes are pulled to github version of
> libvirt?)
>

We do try to keep them separate, but if changes in libbpf need
adjustment in selftests, it's fine to do it in one patch. This has no
bad effects for Github sync, the sync script is smart enough to deal
with that.


> > >  /*
> > >   * Helper macro to place programs, maps, license in
> > >   * different sections in elf_bpf file. Section names
> > > --
> > > 2.34.1
> > >

