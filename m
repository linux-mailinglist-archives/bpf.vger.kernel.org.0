Return-Path: <bpf+bounces-63348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6905B06514
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93CC1887918
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2854B28507B;
	Tue, 15 Jul 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ7uUlho"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE8E1D514B;
	Tue, 15 Jul 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752600253; cv=none; b=hOhFRotoQn8X5lSBUI49JyYs13h2tYPtJQ3HxbzDzUhjVtSDDPs3HoNx3rl9Qx/zayIrCUUitTE9BEr4KVt1rBJZcimGENFsRFAw1ioM5F2+jjfQXXAK0hN80hKHCSGDL2BRKf88pFmlas3w4Tazze+nvJKU88pF0Sisaa1Dndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752600253; c=relaxed/simple;
	bh=a1ajk6ivQ9gs4z1y2vr3lDFbqauo6COR9aN1Ze+u9nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRMjuZ1y87tCyTGGr3DxTfPBMXRL31AhxBMweY2Y4VNatdyU/RTHGyJG/+WTanDiMakT8ZXjrpKrqdEqa4n/tF6SnoGUGno2ie73vWushB6AlbgqhJep+dERr2fiBlNIhHshxwEKSHqktNn73ORtt0974If8h4WBBmcHObGZD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ7uUlho; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4884938b3a.0;
        Tue, 15 Jul 2025 10:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752600251; x=1753205051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/jqVI1RoUbitx8fUJx1/BZ8RYAU7+dho5rCq1Y3BFw=;
        b=AZ7uUlhoAUDVvBLNiCy/RO8qlMRQc3GTOKLmnQgAr7ObIs00voEo7DBQIW++YWyJ0R
         9Ixy4lL49U66mxcbAMibOcBNbZt2iUahT3z+ypDMd4gcBALbqpAwgdCNg9QXW7UOSN1+
         7GmQmOCsTZgXPR4Zho205rF62GiBrOhlYIOcBVDwFYs/jQUFsmkkol0Qa+IUZk9UjzAb
         VTgn4ZrkJV7/6RFu67GRW+Gg2BPI15OnGpZiBTyDwLwlSjlCLaZnypTHE/Y6jWIggTy9
         5MKznC5a/2lPgUFLOVxJmC09EHQBZW9fOqqgG3bf+QXlsU/Fszhui82dXGoINySBASvm
         1VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752600251; x=1753205051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/jqVI1RoUbitx8fUJx1/BZ8RYAU7+dho5rCq1Y3BFw=;
        b=pd5UnmFfp8G5UXHcInCGvuFO8tLx3fQqsXA8QH2gZy/AJXNI83WA11ZLpBfnX4Tc0c
         jwVX23pb1OraMA7I4yj+l0EFavFF7mavbe+9eRnlwH/BqiogCg68hJkSf4OETfkC6Lq8
         GLKprb9UwrQYZ4+r0IVCxnKFCz+cgFXEqCpXkDX0F185Y0J3Bz5zZbGtO6BRFtIGoNW4
         Ry+cZbX23OdRwaytii+UoTSEowKxGW5VGiadyLVCSA87aW+mN2/SOrrMD8FymOnCAuNT
         Pd2+L2as2XYHCdpGtpBLTWP8Y/rIQCTSpEZhKPbb4NENqLCtYP3cxPTDdetQEsaPDYo3
         HFVg==
X-Forwarded-Encrypted: i=1; AJvYcCUcqR8c7nrGvCaGRE036/DYeOSP2LbteNWUflVdI+Ovqm/3GfCI5fymTrvNfyXDFH/tikg=@vger.kernel.org, AJvYcCVkvs3d62djLYv0aTktqEP2DDUXDTeCxSUXqb6pvv2m31kRCl28kOdl/UJB+yIeM0brfnmnant0+hUJijfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxCpv6EI8e8QyBEXdSndhYFcTSARaRQg1Yzn8v20XnGaZ+VYs
	vcYyd9aGDJvaAr4tFl34eTgfn4ZygHGDNqB5Gvhxa5KRo4poM2tG0syLbUGvc9X4lxdCoTYzinT
	apTJRHAgYH+rRlg5xUVDyYcdbmgBHAmI=
X-Gm-Gg: ASbGncv2ne6hcUFHjMN9xyqU7IxbKS0NFTW/ZJx1HXngOIw6fNEBZmB8zvNZyjhMw3v
	6lgnI8Sfz5hKYVORVxrHzM8W/xrdLhs2WCedSp+o26ssV1vYw6Mr+zjkNUWujX7ejDLsKnMScsQ
	ETG8jaF4LKFxD4MiD2NLSTb8P3djm/mubsclPCTv5nYlJYbpdCeclxSBfa8Cosjdo8QdWtqriZr
	P+WQUPBtYPBSBbXMuUeXV+vSCQlC2Ve3w==
X-Google-Smtp-Source: AGHT+IE9eeumIRNyUxafbRszxTrw1fCYg6bl+KqabIqRNP/oMm+qcn9XVtXpgNXBy69KgXxG1ai8sbswpNvC5lOBxSE=
X-Received: by 2002:a05:6a20:430e:b0:231:6ba:881c with SMTP id
 adf61e73a8af0-237d5601bd5mr308088637.6.1752600251256; Tue, 15 Jul 2025
 10:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-16-dongml2@chinatelecom.cn> <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
 <21970a1e-dcda-4c23-af84-553419007a38@linux.dev>
In-Reply-To: <21970a1e-dcda-4c23-af84-553419007a38@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Jul 2025 10:23:57 -0700
X-Gm-Features: Ac12FXy7js9NERiywfc-z0hZo9OfpBmTDB6gLern-KAKM4FPwveBeLKJyUK1FXI
Message-ID: <CAEf4BzY4RaB5n1k7-O5XtCAOc9Rq=sYS1zLt_mDLih=4ypvb7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and
 attach_tracing for tracing_multi
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, jolsa@kernel.org, bpf@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 10:49=E2=80=AFPM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
>
> On 7/15/25 06:07, Andrii Nakryiko wrote:
> > On Thu, Jul 3, 2025 at 5:23=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >> We add skip_invalid and attach_tracing for tracing_multi for the
> >> selftests.
> >>
> >> When we try to attach all the functions in available_filter_functions =
with
> >> tracing_multi, we can't tell if the target symbol can be attached
> >> successfully, and the attaching will fail. When skip_invalid is set to
> >> true, we will check if it can be attached in libbpf, and skip the inva=
lid
> >> entries.
> >>
> >> We will skip the symbols in the following cases:
> >>
> >> 1. the btf type not exist
> >> 2. the btf type is not a function proto
> >> 3. the function args count more that 6
> >> 4. the return type is struct or union
> >> 5. any function args is struct or union
> >>
> >> The 5th rule can be a manslaughter, but it's ok for the testings.
> >>
> >> "attach_tracing" is used to convert a TRACING prog to TRACING_MULTI. F=
or
> >> example, we can set the attach type to FENTRY_MULTI before we load the
> >> skel. And we can attach the prog with
> >> bpf_program__attach_trace_multi_opts() with "attach_tracing=3D1". The =
libbpf
> >> will attach the target btf type of the prog automatically. This is als=
o
> >> used to reuse the selftests of tracing.
> >>
> >> (Oh my goodness! What am I doing?)
> > exactly...
> >
> > Let's think if we need any of that, as in: take a step back, and try
> > to explain why you think any of this should be part of libbpf's UAPI.
>
> I know it's weird. The "attach_tracing" is used for selftests, which I ca=
n
> use something else instead. But the "skip_invalid" is something that we
> need.
>
> For example, we have a function list, which contains 1000 kernel function=
s,
> and we want to attach fentry-multi to them. However, we don't know which
> of them can't be attached, so the attachment will fail. And we need a way=
 to
> skip the functions that can't be attached to make the attachment success.

The right answer here is you need to know what's attachable and what's
not, instead of just ignoring attachment failures somewhere deep
inside libbpf API. Filter and check before you try to attach. There is
/sys/kernel/tracing/available_filter_functions and some similar
blacklist file, consult that, filter out stuff that's not attachable.

We won't be adding libbpf APIs just to make some selftests easier to
write by being sloppy.

>
> This should be a common use case. And let me do more research to see if
> we can do such filter out of the libbpf.

I have similar issues with retsnoop ([0]) and do just fine without
abusing libbpf API.

  [0] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c=
#L749

>
> Thanks!
> Menglong Dong
>
>
> >
> >> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 97 ++++++++++++++++++++++++++++++++++++----=
--
> >>   tools/lib/bpf/libbpf.h |  6 ++-
> >>   2 files changed, 89 insertions(+), 14 deletions(-)
> >>
> > [...]
> >

