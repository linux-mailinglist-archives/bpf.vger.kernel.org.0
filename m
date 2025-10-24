Return-Path: <bpf+bounces-71987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13068C043C5
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 05:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32CE3B87C8
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B24261B6E;
	Fri, 24 Oct 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVTpZ9/P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762635B130
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276013; cv=none; b=KKuuuufQ+ZAvd3PKTWMEO45vojVIV4Dw7PAkJEPX/mmzVhXt3qXA9byjAeG2iVCBOlsaQ04dxUsYtf6Y+VqDr8GCIj9hDwAlfIQ9kezV4Bn0cGJQK6qRryLAV75sbA7RyMhb92Hi1GH3SftwzESLuHGYlnmd/BMwMAHcwkjRNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276013; c=relaxed/simple;
	bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS+yb/BCsktl4IscFHy8g8c/I1BQ8VWMb650pvHkS87N1SyxcF51H8N/xr0TwFaq4TWCsnDwWDDbvRPS4RE38YmJwNHTPwYV00dsYvuduuc9eYaRQOqGYgL9jX6GAcrplb7JcUb3MztX+CwrbxJtE1uShlvo7TgHhEd0fRYotNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVTpZ9/P; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e89e689ec7so9833861cf.2
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276010; x=1761880810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
        b=aVTpZ9/PJgMruRXJhXX6rESwt2hxLL1A+hZ62WIs6zV+y/YyEIYceTg9dGUconiVZE
         N0Z3ZSmnXOXoL3z4EsSMfSUsUIOeKRZhk58cFnN0g/YZ/SS8qlXWAJlh+oTtoXZetd4h
         ieSkjVuEan12faQQaOi7+Cza29YBA4K4KIkJA7w9fMR4/ZkWpREyPpk6Ih/OifGUqnXk
         63BOKhoWi8zvsTkKwc47asuOmpmeH7Q1Qiv40eaoL+bz+20Sepjse8HYt/FS8qGnjuYG
         ty2yJB8c9kc0tpIOt7IFbRfUOzmpn/yDgqQFNJYP5HfZgfnCSWUlWn0oHnWSlYNr13yj
         CDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276010; x=1761880810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
        b=SBS682/I7oijstlR8F+C3vz14h0VCAMTeXvtb9KBLGglIab7Opt9ItYWoKtQ1BVnNq
         q4nzlVeGzKMvVOpZprvPlSrc+aFg04eHeR1Uua67tFJ9n6GiA5AlZnPA07ENMW2DB2QZ
         cI9J2bkaMkdBexyGBADf0mBRnOUd51XQYdO62LHkFdkh70zC0EP04TWu69+a3tYfrq9f
         k34jv0FLOy96bKz8QNo4QBXyK115by6dy2vkpHw3hWM7Au+gO2jbHS3ig1m/fbHElRn6
         sUJgJSTPk85ecHgcVIMIfVVk6804eX0gEDBnJwXN46jmmd2QS60wVcHf74Ffs8e3EEwk
         986g==
X-Forwarded-Encrypted: i=1; AJvYcCVV3oBW284SFzI83ISMq+MOXR+wQrLc2tW4XPsXPLdr1qAwqwqxWaoiqIAS3WBh1+hMqvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5UxDWEGiTC8Y9v7VQYl3mviVWth8k/ZwF2FNdiYwSk/uWIgj
	JxS02zRuuXzbkA/ouzrIJ5eL+dJ7reJLkxhXTZbj9+t2Je/XZ7BT4th2lJXRmwXsQ1zDHNI35CQ
	Y7bIGjADv8b9Fm4SZi20r+l2i9Qj7BBE=
X-Gm-Gg: ASbGncs2tCs4odD0/I1gI82/cc/5DC0F+ki77ykiEpSTrINwJ8kA1t+suLZBIy67y61
	pu5GJYyww1VcHF7ZWfNGNm2mdm6KMkbrnXpEHHhn3vBmDmnQwMVpip99hqM36IgbWso1ukFOknl
	FxWWMlr1gbG5aAss3H0u9W6ZAvJJmnQ4MGhiZ4hoUMcw5wekOmSSJVW4gj3Oersv2oSl40lZ2jY
	MIgkuj1EiVQoCkCpq0nrLwnl/AzbhdSi7yEzfB8eRlZgJ78z0qXol+CKdZ+eQ==
X-Google-Smtp-Source: AGHT+IFuKLNzDHgyVnAc5upxNk6bZXC3pluBaw0VdoK1RNjYz8XToqqei8JPDhUGUEGNlSvEelgzXNgrEFpmvuP5MQs=
X-Received: by 2002:ac8:578b:0:b0:4e5:6c5e:430a with SMTP id
 d75a77b69052e-4e89d3a47c8mr340792321cf.64.1761276009998; Thu, 23 Oct 2025
 20:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
 <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
 <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
 <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
 <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
 <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com> <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
In-Reply-To: <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 24 Oct 2025 11:19:55 +0800
X-Gm-Features: AS18NWDBZBREJwKmL2ehSlR-iVb6MBKxIurAqAr9cAYdqWHWbtf1c3KKSrtcx8g
Message-ID: <CAErzpmuY0miq0B5BSF8ueY+NOTGfvcUKPbO4_W3BKX74c5K4rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-10-24 at 11:04 +0800, Donglin Peng wrote:
> > On Fri, Oct 24, 2025 at 10:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> > > > On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag=
 to
> > > > > > > > btf_header->flags seems useful, as that would allow libbpf =
(and user
> > > > > > > > space apps working with BTF in general) to use more optimal
> > > > > > > > find_by_name implementation. The only gotcha is that old ke=
rnels
> > > > > > > > enforce this btf_header->flags to be zero, so pahole would =
need to
> > > > > > > > know not to emit this when building BTF for old kernels (or=
, rather,
> > > > > > > > we'll just teach pahole_flags in kernel build scripts to ad=
d this
> > > > > > > > going forward). This is not very important for kernel, beca=
use kernel
> > > > > > > > has to validate all this anyways, but would allow saving ti=
me for user
> > > > > > > > space.
> > > > > > >
> > > > > > > Thinking more about it... I don't think it's worth it.
> > > > > > > It's an operational headache. I'd rather have newer pahole so=
rt it
> > > > > > > without on/off flags and detection, so that people can upgrad=
e
> > > > > > > pahole and build older kernels.
> > > > > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > > > > Things may change and we will need a new flag and so on.
> > > > > > > I think it's easier to check in the kernel and libbpf whether
> > > > > > > BTF is sorted the way they want it.
> > > > > > > The check is simple, fast and done once. Then both (kernel an=
d libbpf) can
> > > > > > > set an internal flag and use different functions to search
> > > > > > > within a given BTF.
> > > > > >
> > > > > > I guess that's fine. libbpf can do this check lazily on the fir=
st
> > > > > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> > > > >
> > > > > Thank you for all the feedback. Based on the suggestions above, t=
he sorting
> > > > > implementation will be redesigned in the next version as follows:
> > > > >
> > > > > 1. The sorting operation will be fully handled by pahole, with no=
 dependency on
> > > > > libbpf. This means users can benefit from sorting simply by upgra=
ding their
> > > > > pahole version.
> > > >
> > > > I suggest that libbpf provides a sorting function, such as the
> > > > btf__permute suggested
> > > > by Andrii, for pahole to call. This approach allows pahole to lever=
age
> > > > libbpf's existing
> > > > helper functions and avoids code duplication.
> > >
> > > Could you please enumerate the functions you'd have to reimplement in
> > > pahole?
> >
> > Yes. Once the BTF types are sorted, the type IDs in both the BTF and BT=
F ext
> > sections must be remapped. Libbpf provides helper functions like
> > btf_field_iter_init,
> > btf_field_iter_next,
> > btf_ext_visit_type_ids
> > to iterate through the btf_field and btf_ext_info_sec entries that
> > require updating.
> > We will likely need to reimplement these three functions for this purpo=
se.
>
> I think Andrii's suggestion is to have btf__permute in libbpf,
> as it needs all the functions you mention.
> But actual sorting can happen in pahole, then:
> - allocate array of length num-types, initialize it 0..num-types;
> - reorder it as one sees fit;
> - call btf__permute() from libbpf and get all the renamings handled by it=
.

Yes, the first two can be implemented in pahole, while the last one belongs
in libbpf.

>
> [...]

