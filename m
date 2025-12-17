Return-Path: <bpf+bounces-76934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A49CC9D35
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1CB030358CB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04726B777;
	Wed, 17 Dec 2025 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkaIcfeU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358452367AC
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015569; cv=none; b=ivVTVlrA7NYU7vTDqmc7BmqtSyly/vvv1XRJ6N9OJQTK+o0GLKsBikjv7eiThQKkW+dSwUCX0ScAQUGqgiWnBSFqDBMKFYl1UGqzyI0OYHt6NoBdgbHP6n3pE3fmisgV7JFmIkzQLueU1HCMayePHgn/bzv7xoOUU4MDVpeHkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015569; c=relaxed/simple;
	bh=3lf0cbNcd8ggp4JqpU/T5lvycn3RJsC99fKw2zxIM3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI1kHWYVcIYT+32KjlKE+uZucvUl75QUwxnYPQeGlIgknqLCFBk6ErDIfAzfinfGCQUNuiDkpOxFV90Z8EU9A8Qy7e8EoU8VNSFRKYf37geoXLn4cLcy+5Fcl6NJtlBFPvEzang8nthO1hTPxxdLVc6+Huegxfg8bQnyQKD45Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkaIcfeU; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c363eb612so63784a91.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766015567; x=1766620367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lf0cbNcd8ggp4JqpU/T5lvycn3RJsC99fKw2zxIM3Y=;
        b=BkaIcfeUp7P9gxQ3T9bunqfVgL7KFxYGCMrdPUOM9OFFuhAGscEAa2UjZxiF+gDZyt
         9PuDgTNQK4Okz6RwMw3aML6XmmFeKyFOxCkFl9ruyOtBomYzYFRqTr4yAk4sNgmC7839
         uzAmonE/4zDf0zg2HZLnbNiOW52THElO/1YBgpXgG31NkA+wRhNUG844h/+OYB+fH2hB
         tFJj+9craQz3WTvrR9TwSUrnMkRIyFNMv+cdjVODPWdFQvbO/JhI5I8RayZsVyWX+dlN
         iC9ImUSl+ynBoyr9JrmWSpvjkWPkE4vEv9QwvJkpX802UKaYRdl+cy/mlnw1QLeZ1vUP
         OO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766015567; x=1766620367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lf0cbNcd8ggp4JqpU/T5lvycn3RJsC99fKw2zxIM3Y=;
        b=brX5o+0TjN4hbRj3SHCZy689KytlX/gy41UH24CWTvcLD5qQPirPJm84eYINJ+MZTF
         QVRsEpGc+AMFMVVIhjvN91oKYGRdKEZDl6nuwO/ecR3IYcuCLSIWenfGPYBoLIKdftDm
         5OfGv0i+ZOyVtTQtYHDKXmFht//7hrSSBNv4NXYn4UBDQd38/JnNC58BykqfTbDFlzk0
         CfZu7D3T8iLAhn2Nicz66CBRO/U2b/LO5z6Dcec9KIIKyjhoiWbj5i3fCBVN2e1StVsN
         fgoGPT+0mudYZyOC5O8LiS0ptPlFNG5lliTR/R5K2C8vw/MGl6clR2J+Q+qO21QET5/+
         1MEA==
X-Forwarded-Encrypted: i=1; AJvYcCX9eosL8jLI2izYpZSjaA+oGlFLSkAWQln+YFTQ3vSJqAcZqn+hOWai+r4Sj5tu+AAc0eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoSAOy7CB90UYJQdxBSa6J3P3yShtvYgq0rkJoASLDCRl1/VE
	AGZpCulNLsvBJ4kWL3uAFR7jOF9WIP5pp29guGvfmkKaN8U5PxIarxAgbiS84d7GokdHLSf7eTG
	nx1rVSkU8cjoYQcinF5RpdpJ/qbQkMLk=
X-Gm-Gg: AY/fxX6xSJDyGlpWIziOtUXjEjRrQKnGlfAMDMOXDBMkzyu8vsiV6d+uDsgi3ZrFCcr
	4ybDFLKgUOAT9O9puMWckATq0B0NMnuUmkRyyCgdxc5lr2WG/wCnbx7jdVkOnlz7M7SkHbOgSa8
	tCjBK5mz5BGZRE9rX1/etBZNdxrkq/erOcLnlEpEjlhDmWHecEe8+qNuoKboR0qqnvjaDcCvFay
	63V48kjhGo0yuMw4dRoYa7GdNCSCxq1qTweWFONaZIzAos9K2QNJ8aE/+ufZWAgJFVQRFI=
X-Google-Smtp-Source: AGHT+IE5xYuzb8f/V2OHY4suZVuBVa2+k0siOu3dWIJg4VabliTm3GeeWnZDO2DKUZvq+SUttuUpIVRXSioyy0iGkPQ=
X-Received: by 2002:a17:90a:d407:b0:343:c3d1:8b9b with SMTP id
 98e67ed59e1d1-34abd768603mr15931407a91.19.1766015567444; Wed, 17 Dec 2025
 15:52:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com> <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com> <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com> <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com> <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Dec 2025 15:52:35 -0800
X-Gm-Features: AQt7F2rDy4ZXZJTaSjHzqPrX26ZJQxxMtoH1fXJA_Z3bZ0EW9veULlZ2JFQlE30
Message-ID: <CAEf4BzaRxvM9C2+FvUViJqFJPTMTv6uoWc8i1taEzijdJOddwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 17, 2025 at 1:02=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > >
> > > On 17/12/2025 19:35, Eduard Zingerman wrote:
> > > > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> > > >> On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> > > >>
> > > >> [...]
> > > >>
> > > >>> So maybe the best we can do here is something like the following =
at the top
> > > >>> of vmlinux.h:
> > > >>>
> > > >>> #ifndef BPF_USE_MS_EXTENSIONS
> > > >>> #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
> > > >>> #define BPF_USE_MS_EXTENSIONS
> > > >>> #endif
> > > >>> #endif
> > > >>>
> > > >>> ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> > > >>>
> > > >>> That will work on clang and perhaps at some point work on gcc, bu=
t also
> > > >>> gives the user the option to supply a macro to force use in cases=
 where
> > > >>> there is no detection available.
> > > >>
> > > >> Are we sure we need such flexibility?
> > > >> Maybe just stick with current implementation and unroll the struct=
ures
> > > >> unconditionally?
> > > >
> > > > I mean, the point of the extension is to make the code smaller.
> > > > But here we are expanding it instead, so why bother?
> > >
> > > Yeah, I'm happy either way; if we have agreement that we just use the=
 nested anon
> > > struct without macro complications I'll send an updated patch.
> >
> > There is a little bit of semantic meaning being lost when we inline
> > the struct, but I guess that can't be helped. Let's just
> > unconditionally inline then. Still better than having extra emit
> > option, IMO.
>
> tbh I'm concerned about information loss.
>
> If it's not too hard I would do
> #ifndef BPF_USE_MS_EXTENSIONS
> #if __has_builtin(__builtin_FUNCSIG)
> #define BPF_USE_MS_EXTENSIONS
> #endif
>

Concert I have with this is that we'd need to hard-code this
bpftool/vmlinux.h-specific #ifdef/#else/#endif logic (with arbitrary
and custom BPF_USE_MS_EXTENSIONS define use) for -fms-extension
handling inside generic libbpf btf_dump API, which is not supposed to
be vmlinux.h specific.

Wasn't there a way to basically declare -fms-extensions using #pragma
inside vmlinux.h itself? If yes, what's the problem with using it? Why
do we need to work-around anything at all then?

> and it will guarantee to work for clang while gcc will have structs inlin=
ed.
>
> In one of the clang selftests they have this comment:
> clang/test/Preprocessor/feature_tests.c:
> #elif __has_builtin(__builtin_FUNCSIG)
> #error Clang should not have this without '-fms-extensions'
> #endif
>
> so this detection is a known approach.

