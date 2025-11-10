Return-Path: <bpf+bounces-74042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C2C44BE9
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 02:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF7188CB10
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66622D792;
	Mon, 10 Nov 2025 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS3vIvpS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D31E9905
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738980; cv=none; b=uNPOkLAYj0ply6EZSQver9LZSo/emShw1ne0hOLaUY5nnv391xCdfnIuGw5cZwB+0eWHpEwBkaA5RvlVUtnMpmtO1sx4sLgZVONfWkffbe/qiCx+Yhry0CL4/8h7Nyno+92iJYJoSZOQHeIbInCC8Rqn/eD6FBNjyZNDmbcPzQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738980; c=relaxed/simple;
	bh=roeKHosmV5a9D0vtB00ZurrUNmOU0pldpLOfqIPJE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLdZscJK3wKQF+96Xp5kAHrZR83wH/w/Fc0wosSjDLkpV2A12RK/hE+iQzZYpDeZun1dR05uOVxxm2xuKhxa0TViV5gBARIOTsiEpbkGLDcsNBH+wa0KGZo3yYsOE+AZUja9qFeM0NTm3+ev4vrJpuBK55zODExMKdb1LZ4IAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS3vIvpS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7277324054so350167266b.0
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 17:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762738977; x=1763343777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP3DVa4WnhcXTOt0TA+45TQS+vl712XR/n54d7dvW4k=;
        b=eS3vIvpSX6YkRrMDggJ5LsLm8rc/HDINAe1c7i8O9tjmOzsIuU5HmLiYQiGYV5+tgM
         palilX0twSPr8UkOVnxJo/Reaq1BZpTk4Ucm1YS8e+9PEnufoovc9FSqmrxtHkSyTnhG
         ujOOXcRql/4yCuT/WDNI/7s3mjd+EGJFLmNRwroE8IN7NSAVjoHLQzKdvR0fkFrEuf10
         Me8xXN25PMBUCeJAs85rUgkXGGqAijFEiNQ4MHpRtjV6peRNqF8S4hzGaYcsz1IhbQmo
         P7Jn9rKATGjj4trer7PWTu1VnuJHBt6bGOjoQ8L2XBoZVq6d4ux9CAfiDw2QTg+lksGY
         CoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738977; x=1763343777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JP3DVa4WnhcXTOt0TA+45TQS+vl712XR/n54d7dvW4k=;
        b=kXTLLoXgpGxXV5khDVieQdXLaAwZAhCviHy9lOkTEVQXRX6Q0DVjm9upGNyOOTuwNr
         MxEpy7cRGsvFQLsjs041knKaD2O9UslM4SOXBBeEaukUd+pWTZgb2wsd+wfKMNnk76sx
         NXohNl9dIplDyYTChUEP4atG14aCDnCD17yaWo8HOVyYAwzYfuQz9WGDEoRTcGwuy82o
         ++EpRO3Y/oRZ2XT0Ojvk/vDPYevf842JbS1OSvDfYYV74CvVyz+OlvIJlBBiweAkFp6c
         Ehvt34y3J8NI0ZSHC+0k5Okmimx+Jkb3VJ4aLYmEqefPVaxVyXeIIG52/vbr3LJ0zsR6
         5Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCUVs3W1e3hOc8bfUMYU3pCDGOp9UqUY3gv7mYbtCQvo2ZBNa3AvBGdZUjQjCmV2XjTs3qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkWhqWvVcTJjI3tYD6i4FTGPWuDsaNUdKEYN5qenIasUmFMaW
	7gmVw6VPozIpcXN3l2qiE6znTGag5UjJhkAHgntXCtucqPmj6lEF4bhdimVKCM4Pz5JRL4Gy+w8
	ZUFwL/3gghLUE0LkQfeqKYEKvFtKzlg3yaeZ3fzWcZw==
X-Gm-Gg: ASbGncsqhYrzVAo0h7fJ/ftQ1Tkw6VqWxoXlxj2LM9WG/9KF5TP6yfTK6y6e0Lwi2tR
	NPdf0W7QA8zOvY8BVUONlM/0Nt/d/FOCy3MfhKi1p6rtXv4qD+lYWI4nuFaeXrJkiDK2hkLTC2M
	lSWWEreldJUwW4+1sV7u6VieKnOde/YBVVOfjQv3B1QLat9WhZRTXtJEi4Tfg1jruu8I7VgK2VC
	u7G+lxYS5wcJc/dQYStM7elCRhn4Esb3tMFFb+C5knfag+LU8SeT9rEvCKvDWCEGrxLDTzS
X-Google-Smtp-Source: AGHT+IHxalHuUl0diHbHbqSgdtteSP39RbhhDJcfDrHDQLwiewaAgReJxi8MSmaTfP49jHGdIaJy8QVnIJfdydncSCI=
X-Received: by 2002:a17:907:960f:b0:b6d:573d:bbc5 with SMTP id
 a640c23a62f3a-b72e05216a8mr651354766b.37.1762738976855; Sun, 09 Nov 2025
 17:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106131956.1222864-7-dolinux.peng@gmail.com>
 <d57f3e256038e115f7d82b4e6b26d8da80d3c8d8afb4f0c627e0b435dee7eaf6@mail.kernel.org>
 <CAErzpmtRYnSpLuO=oM7GgW0Sss2+kQ2cJsZiDmZmz04fD0Noyg@mail.gmail.com>
 <74d4c8e40e61dad369607ecd8b98f58a515479f0.camel@gmail.com>
 <CAADnVQLkS0o+fzh8SckPpdSQ+YZgbBBwsCgeqHk_76pZ+cchXQ@mail.gmail.com>
 <5a8c765f8e2b4473d9833d468ea43ad8ea7e57b6.camel@gmail.com>
 <CAADnVQKbgno=yGjshJpo+fwRDMTfXXVPWq0eh7avBj154dCq_g@mail.gmail.com> <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
In-Reply-To: <6cbeb051a6bebb75032bc724ad10efed5b65cbf7.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 10 Nov 2025 09:42:44 +0800
X-Gm-Features: AWmQ_bl_xaW29RwtOH8GX4T2QXaqHNL_zJ_DvR2CHtswjBcenwUdIazXf1_6bMs
Message-ID: <CAErzpmtViehGv3uLMFwv5bnRJi4HJu=wE6an6S0Gv2up3vncgA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] btf: Add lazy sorting validation for binary search
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, zhangxiaoqin@xiaomi.com, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:51=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-11-07 at 11:01 -0800, Alexei Starovoitov wrote:
> > On Fri, Nov 7, 2025 at 10:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com>
> > wrote:
> > >
> > > On Fri, 2025-11-07 at 10:54 -0800, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > > > > > @@ -610,7 +674,7 @@ s32 btf_find_by_name_kind(const
> > > > > > > > struct
> > > > > > > > btf
> > > > > > > > *btf, const char *name, u8 kind)
> > > > > > > >                       goto out;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > -     if (btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK) {
> > > > > > > > +     if (btf_check_sorted((struct btf *)btf)) {
> > > > > > >                                   ^
> > > > > > >
> > > > > > > The const cast here enables the concurrent writes discussed
> > > > > > > above.
> > > > > > > Is
> > > > > > > there a reason to mark the btf parameter as const if we're
> > > > > > > modifying it?
> > > > > >
> > > > > > Hi team, is casting away const an acceptable approach for our
> > > > > > codebase?
> > > > >
> > > > > Casting away const is undefined behaviour, e.g. see paragraph
> > > > > 6.7.3.6
> > > > > N1570 ISO/IEC 9899:201x Programming languages =E2=80=94 C.
> > > > >
> > > > > Both of the problems above can be avoided if kernel will do
> > > > > sorted
> > > > > check non-lazily. But Andrii and Alexei seem to like that
> > > > > property.
> > > >
> > > > Ihor is going to move BTF manipulations into resolve_btfid.
> > > > Sorting of BTF should be in resolve_btfid as well.
> > > > This way the build process will guarantee that BTF is sorted
> > > > to the kernel liking. So the kernel doesn't even need to check
> > > > that BTF is sorted.
> > >
> > > This would be great.
> > > Does this imply that module BTFs are sorted too?
> >
> > Yes. The module build is supposed to use the kernel build tree where
> > kernel BTF expectations will match resolve_btfid actions.
> > Just like compiler and config flags should be the same.
>
> There is also program BTF. E.g. btf_find_by_name_kind() is called for
> program BTF in bpf_check_attach_target(). I think it would be fine to
> check program BTF for being sorted at the BTF load time.

[[Resending in plain text format - previous HTML email was rejected]

Thanks for the feedback. Based on the previous discussions, I plan
to implement the following changes in the next version:

1. Modify the btf__permute interface to adopt the ID map approach, as
    suggested by Andrii.

2. Remove the lazy sort check and move the verification to the BTF
    parsing phase. This addresses two concerns: potential race conditions
    with write operations and const-cast issues. The overhead is negligible
     (approximately 1.4ms for vmlinux BTF).

3. Invoke the btf__permute interface to implement BTF sorting in resolve_bt=
fids.

I welcome any further suggestions.

Thanks,
Donglin

