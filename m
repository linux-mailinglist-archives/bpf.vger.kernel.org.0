Return-Path: <bpf+bounces-39086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DC496E6AF
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 02:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52053B23A3D
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916278C0B;
	Fri,  6 Sep 2024 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS0VWsnL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA342F32
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581773; cv=none; b=nCT6hAC6A2DksMPs3gCbr8l0Aa6HS+1WzKkdhnx6V9vthmAHo+rCiqaiBcy/P4jqDuf8DoqFGRxiA1rv3op/oSLMVVU8c2VDhPCvkHsmo6JN+YopTpPkKWB57C0V0vKTTR/0PuzIYbDbb6oud1RQ/UmOma83uAnDHnfFPVS8uOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581773; c=relaxed/simple;
	bh=Tt3Ts1qUcnonoHocREhE3v6ydTBhzSTavB02Kz+sKEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfxC4/rYbBQQ2nR5ZBEd8J9pU/7vLqFbTemMQPAGFHECW7IX7aVMGXTWUHSr/6lGUVtIMmVaJ2li9Hwz+zPRUJcz/qmvyn6zmpztKNoIGUjmi4P72udHrDpOjNiDjRDeomKxYXYt60G6dDEOY1lDrP/VzDlI6yPjCAAnXmBRMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS0VWsnL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83597ce5beso234365666b.1
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 17:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725581770; x=1726186570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL+SvofF1ut0t7s4FQ1jJd8KSRqsakx8X0pwBNcKhx8=;
        b=ZS0VWsnLhOiJZ9Xftq+Q52knBZb5BaYtKz9Hg6KE4uiOU081kuwQ9rbP1huJgk9WjY
         CRVXkLbkz8Dbwf+rmD8CFga7s+R86McA5ys7XTKRlHZipq0hVMetcYc2sZj3SzIqV5PZ
         qYk1chl6csCsmWUaiJoapMcO+02mgCHbmP83n3TqM4up20FvRbdoRC2WLjGwTK+EH0zO
         P0jJODgP7uvdwzn2QX0wtwSZNjebKcmgrxqJ0aytn7TuXaCA2hkK5OpzT1ocznL9R9TD
         jWrP6aQpXHO5rvDub/BNQeV/dGir3LMsx2B2Se2Q4Th60iy3ERjXo//C03IlbXpE3h5Z
         aYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581770; x=1726186570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL+SvofF1ut0t7s4FQ1jJd8KSRqsakx8X0pwBNcKhx8=;
        b=F9I9Ka05RNNppK3SafEJMGI2FUe+UWWujStUFTXd8y12rGqjvk/EGJD6tns4dB3gZd
         4zrhibN217sUBdkCz4mchHigEuolMBm1LiuSriStbd02vV304Q5peZTvN8UbxcB64fs7
         XvWjMzAFWZdTc6KB2kP2Th/yk37YIBz6rDCG5T3Q05ojItEHjTqt12D5wlwuY1Lt9hWA
         FPJtUrqC+WDmAw/Mxh8K5MGnZ0i13fuPhoDrtFyvC2NQfwGADCSEJC3d99TWRcmgxYjz
         nMrazjRhHB708CkbliXnLGBdmlPXfvlGjWm7x4W+qrTi7xKnLuX0UDQuwMuNP7VWukbp
         8idQ==
X-Gm-Message-State: AOJu0YxhTz6C/5gvAgO/ppBPBnmAZyjNuNHMRclfIP3K0rK3aSD9y73S
	7g84kvKk66XzUPCnxKzuAj1rYxMg5qAEfA92Ohl/sJ1D40K6LdA7XCQTmialqui37DVKiHWYfmW
	LhackJDlv7YvL0MsLIX95HQaabkc=
X-Google-Smtp-Source: AGHT+IGwjTU76ghMmQwecERqb9pR5/HALY8DPuDmcNZQLjYfYA+ZH+RQP5q+njJXXdhfR+22F1kFEpzCJWN1gOB0Bnc=
X-Received: by 2002:a17:906:d7dd:b0:a86:9fac:6939 with SMTP id
 a640c23a62f3a-a8a8644482bmr92518066b.30.1725581769408; Thu, 05 Sep 2024
 17:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905134813.874-1-daniel@iogearbox.net> <CAADnVQJbqoXHMsC3_67xWXpvX8CjzOoRTTA7h_kZgZNOqNVW5w@mail.gmail.com>
 <14aa3075-2580-ab0d-e90d-bc29d435acd4@iogearbox.net> <ec71766c-d028-c88a-8a77-c9151c28670d@iogearbox.net>
 <e3595f7e-7729-4c6b-ff79-3571b9538355@iogearbox.net>
In-Reply-To: <e3595f7e-7729-4c6b-ff79-3571b9538355@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Sep 2024 17:15:57 -0700
Message-ID: <CAADnVQJ8p7DE8c9VumKR-r5Qk866E_gHwx_XkLqptW17b3=T8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Fix helper writes to read-only maps
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:14=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 9/6/24 12:56 AM, Daniel Borkmann wrote:
> > On 9/5/24 10:27 PM, Daniel Borkmann wrote:
> >> On 9/5/24 9:39 PM, Alexei Starovoitov wrote:
> >>> On Thu, Sep 5, 2024 at 6:48=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>> index 3956be5d6440..d2c8945e8297 100644
> >>>> --- a/kernel/bpf/helpers.c
> >>>> +++ b/kernel/bpf/helpers.c
> >>>> @@ -539,7 +539,9 @@ const struct bpf_func_proto bpf_strtol_proto =3D=
 {
> >>>>          .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >>>>          .arg2_type      =3D ARG_CONST_SIZE,
> >>>>          .arg3_type      =3D ARG_ANYTHING,
> >>>> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> >>>> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> >>>> +                         MEM_UNINIT | MEM_ALIGNED,
> >>>> +       .arg4_size      =3D sizeof(long),
> >>>>   };
> >>>>
> >>>>   BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, f=
lags,
> >>>> @@ -567,7 +569,9 @@ const struct bpf_func_proto bpf_strtoul_proto =
=3D {
> >>>>          .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >>>>          .arg2_type      =3D ARG_CONST_SIZE,
> >>>>          .arg3_type      =3D ARG_ANYTHING,
> >>>> -       .arg4_type      =3D ARG_PTR_TO_LONG,
> >>>> +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> >>>> +                         MEM_UNINIT | MEM_ALIGNED,
> >>>> +       .arg4_size      =3D sizeof(unsigned long),
> >>>
> >>> This is not correct.
> >>> ARG_PTR_TO_LONG is bpf-side "long", not kernel side "long".
> >>>
> >>>> -static int int_ptr_type_to_size(enum bpf_arg_type type)
> >>>> -{
> >>>> -       if (type =3D=3D ARG_PTR_TO_INT)
> >>>> -               return sizeof(u32);
> >>>> -       else if (type =3D=3D ARG_PTR_TO_LONG)
> >>>> -               return sizeof(u64);
> >>>
> >>> as seen here.
> >>>
> >>> BPF_CALL_4(bpf_strto[u]l, ... long *, res)
> >>> are buggy.
> >>
> >> Right, the int_ptr_type_to_size() checks mem based on u64 vs writing
> >> long in the helper which mismatches on 32bit archs.
> >>
> >>> but they call __bpf_strtoll which takes 'long long' correctly.
> >>>
> >>> The fix for BPF_CALL_4(bpf_strto[u]l and uapi/bpf.h is orthogonal,
> >>> but this patch shouldn't make the verifier see it as sizeof(long).
> >>
> >> Ok, so I'll fix the BPF_CALL signatures for the affected helpers as
> >> one more patch and also align arg*_size to {s,u}64 then so that there'=
s
> >> no mismatch.
> >
> > Not fixing up BPF_CALL signatures but aligning .arg*_size to sizeof(u64=
)
> > would fwiw keep things as today. This has the downside that on 32bit ar=
chs
> > one could end up leaking out 4b of uninit mem (as verifier assumes fixe=
d
> > 64bit and in case of write there is no need to init the var as verifier
> > thinks the helper will fill it all). Ugly bit is the func proto is enab=
led
> > in bpf_base_func_proto() which is ofc available for unpriv (if someone
> > actually has it turned on..).
> >
> > Fixing up BPF_CALL signatures for bpf_strto{u,}l where res pointer beco=
mes
> > {s,u}64 and .arg*_size fixed 8b, would be nicer, but assuming this incl=
udes
> > also the uapi helper description, then we'll also have to end up adapti=
ng
> > selftests (given compiler warns on ptr type mismatch) :/
> >
> > One option could be we fix up BPF_CALL sites, but not the uapi helper s=
uch
> > that selftests stay as they are. For 64bit no change, but 32bit archs t=
his
> > will be subtle as we write beyond the passed/expected long inside the h=
elper.
>
> Nevermind, scratch the incorrect last part, only this option would do the
> trick since from bpf pov its bpf-side "long" (as its unchanged in the uap=
i
> header which gets pulled into the prog).

Right. From bpf side 'long *' is ok-sh and it's ok to stay this way
in uapi/bpf.h and from there in bpf_helper_defs.h,
but BPF_CALL(bpf_strol..) needs to change.
And if we fix that we should probably change uapi/bpf.h to stay consistent.
Maybe we should use 'u64 *' everywhere then?

On 32-bit archs bpf_strtol helpers were broken,
since they were converting string to 'long long', but assigning
result into 32-bit 'long *',
so upper bits will be seen as uninited from bpf prog pov.
This series are fixing the error path of uninit, but looks like
non-error path was broken on 32-bit archs too.

Thankfully bpf_strto[u]l are the only helpers that take 'long *'.
Other helpers use 'u64 *' in similar situations.

