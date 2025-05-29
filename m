Return-Path: <bpf+bounces-59300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C71AC80E7
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 18:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154D03A541A
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D422CBF7;
	Thu, 29 May 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnvt0VAQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A019343B;
	Thu, 29 May 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536248; cv=none; b=qEokeAlERoxsJlxsmMZnNU05H+TSySIgMc7QtsIkTgxCGcKpBr9nyzT1aUR5MQ/4uR23FmMo+z2t1MrcawozW5vDOb9zZcgAGZqNDeYMXEwhqklDT85QVImJZmGjm2rzibxO0wY9qmKukoemZyfJ7o4pFkADoKNQfZlqyCPng3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536248; c=relaxed/simple;
	bh=7TajUsgHIWM9uxA303PpM9TheYyW0BV6VjilmyDo/Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmJep4b7wVbORs2FPsjuJw2B51E/42Y8Hn6ctelH7mezMskyYjPt86lAX0KQ+iwVxu4Y8XxPPX6CvQk/gvndppBi/mL30cCx+y6jsC4RrVphy96CT5DMcm6o3KHmewa7yjQa8tPmsk8QydTjkE93Bvyp8Sc6fjFEUdrJC15b9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnvt0VAQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cf0025c0so7939155e9.3;
        Thu, 29 May 2025 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536244; x=1749141044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttcPaFdkGOrfwTO6e7DT8MAgrfzwOrN2Rw4Nx/fkuL4=;
        b=lnvt0VAQSt0mMCRcTG9J3Xi3P0LxP2/12KAmBpelLdQisiUuc64/UqBhQBGGGAfCK9
         FQhL2Q+vvm1el7+Mati/zJR+eksJDukwYqAiUw3AcRI8jFpeVfhI2bviKUq0sjf0sSWW
         +mOHx8xXVwJsWsDTunKDoC9fVwUDyCZakytW/j6n/g0ZnCcqYRq11dSBegOoCLMg1cGe
         CcMdZ+r10IxwYkH59VGI2+Myu7hNpfXQTmEPjtOvVz4FgzppCK5rPfMHeLJ0MOdSpPR8
         KPJXN9pDNQKbW6S2YYghrKuh7BB87svONOR7afs2+LDhCesltJ1tPGSdLzdjgm63wsVS
         kA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536244; x=1749141044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttcPaFdkGOrfwTO6e7DT8MAgrfzwOrN2Rw4Nx/fkuL4=;
        b=uV+tbseUhzt/kXBMJxgGqLLIJ5Ef50csAaXRfpNt7+oa3wOagZ+KvKbMft0d0svjVm
         fnXdnyqULYRzdv4niOCszWnuLmpGz4OB1W5ujEIHbZ88lkLuXCDNkZOwe0oRF9ej4xVy
         OA1Tul3gJSpBkTUo1ymCkelffzTCJYr+UTsbObhTBvB/oN2zVVht0jq/NxwcLF25UjPn
         5p4HqaP1gFJdziDRJtYAXsg8swbSNZJlnIuPzj5eOCAS7oDSZ/QjrQH2+6xrKfSVUygG
         0vPWavrbbC5JhURgjVolYfATByAO622yp5bjpBWqIw+btYN5khUOyJ6C2Feuhh5dHTfq
         ZcAg==
X-Forwarded-Encrypted: i=1; AJvYcCUnWev2CilxDRUBCwIZ/m8UjtxBAyLOQOkkR8CY1pzeWoRKr5bEDOL+kCaeSWLEkJeHeVw=@vger.kernel.org, AJvYcCVzM97zUo0Dp+oLx1HmZ9MNv1TdzKyQ0bQcDuku+gM/EkHXjdQsM4tdtIWHIFra40+qcXdK6ZYQaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QVd+jz6NziTVgccW0I7XaPhgG+knD4JmAAdNX7d0vCw2xOPj
	qVl/9zLsnrQSGnm2kzgs1FYtgGYyeMmkBX6OGJAIYLfX8RN8qLzrZ1Jsg8hHbo94N0K3+ZP0Mix
	Sumw/2yST5OfictqoNtHDHAeqS4IsBxA=
X-Gm-Gg: ASbGncuvNlYhvWFYePWO/QSJ6vutRykLuNxnN9jWOoHIG6YL1nKFvPS8SSEqkxJfZtW
	vllaKvObQHQ4pNVODvcRUmmems4j6GRRVsp64frNpO/G4V+zhDQE77kPmsTrLPZj/ddGr1ekYsJ
	FLxir54UWeZXQcrL6/IRpqCceCMwYzjGYdYOM7WQNhARIyRgsxrSbnwxgm5F0=
X-Google-Smtp-Source: AGHT+IH9TxbxFtFt1TSwEkjAL+t29dsspxWQ3R0upxm4K+y3DkLZGdhSoA0LRkiAvM/9mCz5VV0AP3lx6MOziNvA0NI=
X-Received: by 2002:a05:600c:3b87:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-450d651b430mr3927025e9.7.1748536244233; Thu, 29 May 2025
 09:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528095743.791722-1-alan.maguire@oracle.com>
 <20250528095743.791722-4-alan.maguire@oracle.com> <CAADnVQ+GDezR0e+SgqDB5h885Gd500cGYpFs4_LiXpLuD5gYFg@mail.gmail.com>
 <4cc43d09-50d3-4d92-8785-056cae97808d@oracle.com>
In-Reply-To: <4cc43d09-50d3-4d92-8785-056cae97808d@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 May 2025 09:30:33 -0700
X-Gm-Features: AX0GCFs7S0zbu7JaeyoDfiZDLMGcdwHryL73zoDRqX0d9g_6NJZXEn_SrbFUxao
Message-ID: <CAADnVQ+QNFz7OpCS8L-i3OND=09iACF3VdLT+EPPmqXhO8czbA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: use kind layout to compute an
 unknown kind size
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 5:53=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 29/05/2025 06:35, Alexei Starovoitov wrote:
> > On Wed, May 28, 2025 at 2:58=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> This allows BTF parsing to proceed even if we do not know the
> >> kind.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
> >>  1 file changed, 28 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index 43d1fce8977c..7a197dbfc689 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -355,7 +355,29 @@ static int btf_parse_kind_layout_sec(struct btf *=
btf)
> >>         return 0;
> >>  }
> >>
> >> -static int btf_type_size(const struct btf_type *t)
> >> +/* for unknown kinds, consult kind layout. */
> >> +static int btf_type_size_unknown(const struct btf *btf, const struct =
btf_type *t)
> >> +{
> >> +       int size =3D sizeof(struct btf_type);
> >> +       struct btf_kind_layout *k =3D NULL;
> >> +       __u16 vlen =3D btf_vlen(t);
> >> +       __u8 kind =3D btf_kind(t);
> >> +
> >> +       if (btf->kind_layout)
> >> +               k =3D &((struct btf_kind_layout *)btf->kind_layout)[ki=
nd];
> >> +
> >> +       if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->ki=
nd_layout_len)) {
> >> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
> >> +               return -EINVAL;
> >
> > I'm missing the point around kind_layout->flags.
> > I was expecting that this helper and others at least
> > would check that flags =3D=3D 0, but none of it is happening.
> > The patches say that flags is unused and do nothing.
> > Why add flags field at all?
> >
>
> The intent of the flags field is to provide space to add additional
> information about BTF kind encoding that may prove useful. E.g. at time
> of encoding for this kind, was the kind flag supported? Perhaps if the
> size/type field specifies a type or a size might be another useful flag
> setting. But basically the idea is to provide space for additional
> information around kind encoding for future use.

I feel there is a desire to add "flags" as an escape hatch,
but even for this example of "is kflag supported by this kind"
I suspect it would be incompatible to add it later.
Currently kflag is used by some, but not all kinds.
Say, we decide to make kflag meaningful for kind_int.
Currently kernel BTF validator will reject such BTF.
If we add a new flag to kind_laoyout->flags to indicate
that "at the time of encoding this kflag is supported"
the older kernel will ignore kind_layout->flags
and will error on future BTF with int's kflag.
So kind_layout->flags is really only meaningful for user tooling
that may or may not act on it.
Long ago there was an idea to use flags for "is it ok to skip
this unknown kind". imo it's the same issue. If we don't define
this flag now we won't be able to add it later and give it that meaning.
The "ok to ignore" flag will appear, but different versions
of libbpf/bpftool will either ignore it or will act on it.
That breaks the semantics of "ok to ignore".

> So in that context, should we check that flags are 0 now? I'm not sure,
> because in some cases we'd like to have older libbpf be able to handle
> newer kind layouts which might make use of flags.

yeah, if we make libbpf act as not-an-error on flags !=3D 0 and
future version will make use of it, we're introducing an unusual
concept of flags that was never used in the kernel and libbpf.
Maybe it's ok, but I cannot wrap my head around it, since
prior knowledge and concepts don't apply to this scheme.
imo if we want extensibility for kind_layout we better use
known techniques like adding a size_of_kind_layout field to
struct btf_header, so we can add new fields to kind_layout and
do a similar check to bpf_check_uarg_tail_zero().
Then we don't have to add 'flags' there today.
We can add them later and bump the size.
I would also make
__u8 info_sz;
__u8 elem_sz;
to be __u32, since size is already __u32 in btf_type.
There is no need to save these few bytes.
With these two fields libbpf/bpftool can skip unknown kinds.
I would also add name to kind_layout, since extra hundred
bytes of strings is cheap, but warning about unknown kind
will be readable.

