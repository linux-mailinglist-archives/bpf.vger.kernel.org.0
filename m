Return-Path: <bpf+bounces-40775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7848598E137
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28177B233BF
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4B1D12EF;
	Wed,  2 Oct 2024 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J31U/jtP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E71D0DF7
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888116; cv=none; b=Uisr/hNizPKue69hjS+7qgZ9Z+6njNE21hDX4ACgoGWq0slH1KoW5mFSbTr7ADW3ve0nS1oq3Wyy7VsynmAO7YV3u5Xcl0zIIcsPfXKghXjbJARRFHEtJ2oxXNHD+2lkgB+hIupXk6XBlV2RYcvfIw/N40jj75BoP0lQm4dNcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888116; c=relaxed/simple;
	bh=2rFuyThHxWP57junGefKRDEji5JiZL0EJcKFBgesle8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu66SgtRBfi8d9Dm/rVAuUbLn+0eu7aTxiwPKbqQq4ZWZb9ZOy40Fqx3Vrf7koGnVqQpQlOlqRPWCzu9QCOShiS+aL681ES2uUhivfkjkjiPlEiM4aWtDfSM+8qNK2+gf6LfOBjC5eeozmcjvDe0ITvYok0ca1NqUnQGT+tOwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J31U/jtP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cd46f3a26so56620835e9.2
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888113; x=1728492913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCN1fWvxKwrTO+buEfXZLop43hrpA2k2kewTKpLd3kw=;
        b=J31U/jtPKl7r9XMH2TsXe/WaIMOiI4M1YtJ+hIowaUAkR8Fq2h3L5I2LeMKfr2vEiy
         +nCLi/A20eWOsrv7RdcURRZQDGTYEmvcThkpAIi1Xaz3tGldzYtm6gMoC02tWFHBksOD
         +zOD3UOmgpanOAN1qqAj1EuKt6CCHozo6K5cSY05dbE1+ZkTEnQ5AcpFfr1yi/rVVfO7
         AfdpZ+ToB3No+TIE/5FWhhAkGh7uvk5fah7zvNBzyZW62u8zddi9xCLn99hY/7Bl1oyH
         JtUb2J21MEv4e+U9CYOgoomu19RdrS0h7N0EfDCQf0JKwrvBEiPVnqb4WX6hjtCPQScK
         JDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888113; x=1728492913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCN1fWvxKwrTO+buEfXZLop43hrpA2k2kewTKpLd3kw=;
        b=cvVuzFnjtvNGgre9GJ7fDPIuyfyd6Q3ICS5BC6Cs4ZLmJ3uQ4mZbiT7vfRBZvvv7/Y
         dxXo7BwMnCubb2h3GBGX3+Air451EpJTxB2SWIaKRP2gOWer3aikfEZlsfPwjMOxm9Gg
         05bHu4E19FiZxqGsOHvK04SZoDo85B/2032yXeyq6dW5ztmyf/dhSQl6e3Uzk0intQDm
         aapBakErS9xqU/yen40CkEj4n9+/GFs7tayejPnpSaiMnbxDSac5hILfHgpuZmOfWyzN
         ER5Xo2F+Vb8/6tsGb46JddFGT2+LxMhUyG6PecMA75QB6uIaPBgrukOiib9tkgCgBFMg
         wUaw==
X-Forwarded-Encrypted: i=1; AJvYcCUO/W8sR0rgBbdvS3ukS5+c3hFKr/NAgaHCEe3j4o06V3I6U3uKTk9A0ykcQ147TMnkxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7lQ7oDYHM93EV0yF2x5T0cutdJ60yLbj/Sf+KOs1N0fQEltP
	YG+LWNQPocsRGAYTJvrg8niPz9b5J0584SOQAkte2h0a6zkm+YykIyRdtXa345iRK4hSN8bwkxE
	/uSv3KfNrmGlVGxYmZCpA8lH18QA=
X-Google-Smtp-Source: AGHT+IGiMKbkRLAd0LFeoyurrYoUobJ2cvltehAY8EgRTAWzLuGN15tb/dNOgsip44ejzpMX7bM+KXPaaWr5iYv7dX0=
X-Received: by 2002:adf:f04e:0:b0:37c:ccbe:39ae with SMTP id
 ffacd0b85a97d-37cfba078ddmr2329761f8f.48.1727888112545; Wed, 02 Oct 2024
 09:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com> <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com>
In-Reply-To: <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Oct 2024 09:55:01 -0700
Message-ID: <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:12=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> On 10/1/24 19:40, Andrii Nakryiko wrote:
> > On Tue, Oct 1, 2024 at 10:34=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Tue, Oct 1, 2024 at 10:04=E2=80=AFAM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Tue, Oct 1, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> >>>>>
> >>>>> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> Right now, the only way to pass dynamically sized anything is thro=
ugh
> >>>>>> dynptr, AFAIU.
> >>>>>
> >>>>> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffi=
x,
> >>>>> e.g. used for bpf_copy_from_user_str():
> >>>>>
> >>>>> /**
> >>>>>  * bpf_copy_from_user_str() - Copy a string from an unsafe user add=
ress
> >>>>>  * @dst:             Destination address, in kernel space.  This bu=
ffer must be
> >>>>>  *                   at least @dst__sz bytes long.
> >>>>>  * @dst__sz:         Maximum number of bytes to copy, includes the =
trailing NUL.
> >>>>>  * ...
> >>>>>  */
> >>>>> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, cons=
t void __user *unsafe_ptr__ign, u64 flags)
> >>>>>
> >>>>> However, this suffix won't work for strnstr because of the argument=
s order.
> >>>>
> >>>> Stating the obvious... we don't need to keep the order exactly the s=
ame.
> >>>>
> >>>> Regarding all of these kfuncs... as Andrii pointed out 'const char *=
s'
> >>>> means that the verifier will check that 's' points to a valid byte.
> >>>> I think we can do a hybrid static + dynamic safety scheme here.
> >>>> All of the kfunc signatures can stay the same, but we'd have to
> >>>> open code all string helpers with __get_kernel_nofault() instead of
> >>>> direct memory access.
> >>>> Since the first byte is guaranteed to be valid by the verifier
> >>>> we only need to make sure that the s+N bytes won't cause page faults
> >>>
> >>> You mean to just check that s[N-1] can be read? Given a large enough
> >>> N, couldn't it be that some page between s[0] and s[N-1] still can be
> >>> unmapped, defeating this check?
> >>
> >> Just checking s[0] and s[N-1] is not enough, obviously, and especially=
,
> >> since the logic won't know where nul byte is, so N is unknown.
> >> I meant to that all of str* kfuncs will be reading all bytes
> >> via __get_kernel_nofault() until they find \0.
> >
> > Ah, ok, I see what you mean now.
> >
> >> It can be optimized to 8 byte access.
> >> The open coding (aka copy-paste) is unfortunate, of course.
> >
> > Yep, this sucks.
>
> Yeah, that's quite annoying. I really wanted to avoid doing that. Also,
> we won't be able to use arch-optimized versions of the functions.
>
> Just to make sure I understand things correctly - can we do what Eduard
> suggested and add explicit sizes for all arguments using the __sz
> suffix? So something like:
>
>     const char *bpf_strnstr(const char *s1, u32 s1__sz, const char *s2, u=
32 s2__sz);

That's ok-ish, but you probably want:

const char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz);

and then to call strnstr() you still need to strnlen(s2, s2__sz).

But a more general question... how always passing size will work
for bpftrace ? Does it always know the upper bound of storage where
strings are stored?

I would think __get_kernel_nofault() approach is user friendlier.

