Return-Path: <bpf+bounces-40845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1898F4C2
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136EF2828CB
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147D1AAE11;
	Thu,  3 Oct 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1rODBCS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD91A76C8
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974943; cv=none; b=aANxZSn5flcNoI6bPTcVr84gL7NtslBt5kbFUFk5oA1QAE26piCV8vg9FUxeI0T8dfB8jXJy+/7matFl0jXcoG+sBg1LwIoFibWj7mHFqmME1vnBbvFNOf7jJzGTmKB62QvGLxaj4aVYrnWH9QWeCYoktQfPDJ/Vza9stAYwKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974943; c=relaxed/simple;
	bh=0d48+WKzUAnHc8zWF+ijUexUk0me1uipY8ldKToclj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCXYu1Rbz3V8XycvFGT1l6KNtWXgbp4UcOG7n2NIRlTnF51hSBDaxnYOm8XP9azDu9T7R2Zne2lr4/FfpEQXyY7fu4OK/Mvw4IG89cOjSIAMOcN0GcQ9HAtLO1Bkwzb7vjmkQ8IxVcf5KrqE7AOzQifCFr0KOhxAjvR9ym5E5yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1rODBCS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so11834945e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2024 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727974940; x=1728579740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIga+O+B8cSXAG9quQ6+e/kFvzjWcxXas5YwlEuL84Y=;
        b=L1rODBCS9O35yj6hVehUBSCYXF86y7ZMtKM5nJA6lpt3NLApgCdUKIf8vKPHHyQuuM
         mpK5StASfaeUOGa/CntsBxYOktmag3WYhjoT6+6D1i79fiJQRDMHWlhfzWnW0nwuIRnJ
         n6IV+O8eYxXAy6eMVwVRYzaYJ//6b+ybFMD2HSPA6oYiGeJsBMe8kLHI2LituA1M2gUW
         6owjGfi39GusPOoBktodulkqwlz5XNVQ6h15maeHOMKC+5RuyDh9XjmMnqElw74idPtL
         LqMiqktznl9IxQeY4tsVIwfRBhZQ3jqYye697eJO2K9iaDUlOflHJMbtIXWdnUqSoku4
         +O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974940; x=1728579740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIga+O+B8cSXAG9quQ6+e/kFvzjWcxXas5YwlEuL84Y=;
        b=d+0Rr//Yy0mU/p/0+X13hrO6vsAgQyNxLalZaTiuC7VlPoiyEN/TTEWVfweFnZY0Pi
         EkgVwvwuLLl8YyM91sRxgaBxzvgCZbdxmVQYC9UAH9umHDk96WEz+N9uKcqUG7wahO91
         ktr+tt0h9qyJS8emtPWiLXPbkigt5+FVoAzF93VnKBzHg2nURfKaHTpROH44Fv6136q5
         V4W5I9KidgVHNnjaH7Xlw1LzWfB3rDpGKXyFejW4Xa3BQFXPSo8HUfh5bgyDb8QLS+SW
         v/UYHFceEz2QK/6N4/p+Mr/mAep9im1FdHBrRI6snChyu0Yfd9mcrQrUzxCqy/v30BOm
         Zu/g==
X-Forwarded-Encrypted: i=1; AJvYcCVXszkMddVm50VOuV+TtihamN9Y0py28W5MA5/7o5wEF6sP7b0J5J9W7mIMnPJOq96MQ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckWnFXmI4AyYnQJdrL2TKZh74LvyevImOL1+4PwQZ8kRYAY2g
	/f36TxlXkArpt3b2uijX6sA4lqY8UJYZ5KYCyRP0ATF5le56GbBAheQxAY8w/U4XSAzyqtNcky6
	Kq+52JsTXUDTqiIPEfNViCFdX8v0=
X-Google-Smtp-Source: AGHT+IE97kNcrU2qtEtMmjkHOaTEdi6IdzT1vRvftCcCaf303XeSMULxJMB5PkirtvxwD5QE8NrZuwx1KOpt+o41sj4=
X-Received: by 2002:a05:600c:190a:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-42f777ee74cmr48462805e9.23.1727974939751; Thu, 03 Oct 2024
 10:02:19 -0700 (PDT)
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
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com> <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com>
In-Reply-To: <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Oct 2024 10:02:06 -0700
Message-ID: <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
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

On Wed, Oct 2, 2024 at 9:51=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wro=
te:
>
> On 10/2/24 18:55, Alexei Starovoitov wrote:
> > On Tue, Oct 1, 2024 at 11:12=E2=80=AFPM Viktor Malik <vmalik@redhat.com=
> wrote:
> >>
> >> On 10/1/24 19:40, Andrii Nakryiko wrote:
> >>> On Tue, Oct 1, 2024 at 10:34=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Tue, Oct 1, 2024 at 10:04=E2=80=AFAM Andrii Nakryiko
> >>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>
> >>>>> On Tue, Oct 1, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
> >>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>
> >>>>>> On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> >>>>>>>
> >>>>>>> On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
> >>>>>>>
> >>>>>>> [...]
> >>>>>>>
> >>>>>>>> Right now, the only way to pass dynamically sized anything is th=
rough
> >>>>>>>> dynptr, AFAIU.
> >>>>>>>
> >>>>>>> But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suf=
fix,
> >>>>>>> e.g. used for bpf_copy_from_user_str():
> >>>>>>>
> >>>>>>> /**
> >>>>>>>  * bpf_copy_from_user_str() - Copy a string from an unsafe user a=
ddress
> >>>>>>>  * @dst:             Destination address, in kernel space.  This =
buffer must be
> >>>>>>>  *                   at least @dst__sz bytes long.
> >>>>>>>  * @dst__sz:         Maximum number of bytes to copy, includes th=
e trailing NUL.
> >>>>>>>  * ...
> >>>>>>>  */
> >>>>>>> __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, co=
nst void __user *unsafe_ptr__ign, u64 flags)
> >>>>>>>
> >>>>>>> However, this suffix won't work for strnstr because of the argume=
nts order.
> >>>>>>
> >>>>>> Stating the obvious... we don't need to keep the order exactly the=
 same.
> >>>>>>
> >>>>>> Regarding all of these kfuncs... as Andrii pointed out 'const char=
 *s'
> >>>>>> means that the verifier will check that 's' points to a valid byte=
.
> >>>>>> I think we can do a hybrid static + dynamic safety scheme here.
> >>>>>> All of the kfunc signatures can stay the same, but we'd have to
> >>>>>> open code all string helpers with __get_kernel_nofault() instead o=
f
> >>>>>> direct memory access.
> >>>>>> Since the first byte is guaranteed to be valid by the verifier
> >>>>>> we only need to make sure that the s+N bytes won't cause page faul=
ts
> >>>>>
> >>>>> You mean to just check that s[N-1] can be read? Given a large enoug=
h
> >>>>> N, couldn't it be that some page between s[0] and s[N-1] still can =
be
> >>>>> unmapped, defeating this check?
> >>>>
> >>>> Just checking s[0] and s[N-1] is not enough, obviously, and especial=
ly,
> >>>> since the logic won't know where nul byte is, so N is unknown.
> >>>> I meant to that all of str* kfuncs will be reading all bytes
> >>>> via __get_kernel_nofault() until they find \0.
> >>>
> >>> Ah, ok, I see what you mean now.
> >>>
> >>>> It can be optimized to 8 byte access.
> >>>> The open coding (aka copy-paste) is unfortunate, of course.
> >>>
> >>> Yep, this sucks.
> >>
> >> Yeah, that's quite annoying. I really wanted to avoid doing that. Also=
,
> >> we won't be able to use arch-optimized versions of the functions.
> >>
> >> Just to make sure I understand things correctly - can we do what Eduar=
d
> >> suggested and add explicit sizes for all arguments using the __sz
> >> suffix? So something like:
> >>
> >>     const char *bpf_strnstr(const char *s1, u32 s1__sz, const char *s2=
, u32 s2__sz);
> >
> > That's ok-ish, but you probably want:
> >
> > const char *bpf_strnstr(void *s1, u32 s1__sz, void *s2, u32 s2__sz);
> >
> > and then to call strnstr() you still need to strnlen(s2, s2__sz).
> >
> > But a more general question... how always passing size will work
> > for bpftrace ? Does it always know the upper bound of storage where
> > strings are stored?
>
> Yes, it does. The strings must be read via the str() call (which
> internally calls bpf_probe_read_str) and there's an upper bound on the
> size of each string.

which sounds like a bpftrace current limitation and not something to
depend on from kfunc design pov.
Wouldn't you want strings to be arbitrary length?

> > I would think __get_kernel_nofault() approach is user friendlier.
>
> That's probably true but isn't there still the problem that strings are
> not necessarily null-terminated? And in such case, unbounded string
> functions may not terminate which is not allowed in BPF?

kfuncs that are searching for nul via loop with __get_kernel_nofault()
would certainly need an upper bound.
Something like PATH_MAX (4k) or XATTR_SIZE_MAX (64k)
would cover 99.99% of use cases.

