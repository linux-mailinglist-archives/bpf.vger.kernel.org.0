Return-Path: <bpf+bounces-52128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D7A3E9A0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A798516FCDD
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02F32C8E;
	Fri, 21 Feb 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKVK9LJs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01D35955
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099822; cv=none; b=qew6+xvypMQTqqQ9X+Hrice2KjXggIRPVsbwFw83yepAFiWJxg4kp1T6Wsp/8XuqKuadwgs9OUoPSAXvvyExMivjCfdxh556Sn+3qwSXyQtQKNX93bkbHE4uEhmYbQ/xFdHcCE/LvKZdMFp0MCumRZKFkn+8GO9MFs+op5mm1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099822; c=relaxed/simple;
	bh=r0JK9i2ktjyiozSegnOolY02LLaDgI4q9yqYsxCVxjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mlzm4WMsyf0peorZNyvRtSz2Q3FBkvDOCM65JUhSJOu9+xQB7V9ylXtPH2hCmkWNNnqZzQmlm47vBR8k23WGE6OpGNdOC/E8c4BvrT3lEtOEPuIhm/iiDvsPHnLcXW18La1dQuwxY7Xqibvk5XO4VYL4eiktAnHYIiJUJNpFlf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKVK9LJs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so3221724a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 17:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099820; x=1740704620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5DtVBmp5a7R2r7lIpxbEDNpWReCv3hdrBluCOX/oc4=;
        b=cKVK9LJsYNkcuq2kpwFKdfvkssdqyFwndUFhjPzJv39UD/gb8TorD8c3YV579X39eK
         9t2aP10XkeyJaxYnU7IrVtBrCwK7dObIs4SYWTiabhkeKqE1/sRfDNAZImZHA4sAAHDp
         v35pRMQ9jfLqU3Pv9Q50CLHaS2CuVscro5CMsljpS9UljC6axjK6p00jU+tTIUekFD1E
         mD49g3hu3fjU0O02IH3MPFwRAiyNmt4S0TWMqgExLJgvtbu8JbMDS4vHOcj34m1vobAC
         +0B2ZH+G3PuBVwJSn4N7+2P4rsOV1W7IwZhdckf/MOol2dWfgo4VG0xSnXwDFFRMZ72m
         /bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099820; x=1740704620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5DtVBmp5a7R2r7lIpxbEDNpWReCv3hdrBluCOX/oc4=;
        b=mP0sGj8F65GmdfH5gSwtYCkSY3B7MD3dKXmy6XJSdxXeGn1OaxdS9JTGPd/w+4+IbC
         wNGuHLROSQ/jfErb7Pj+E1tIBaRwVAR8FVG64O56ru1UCcqO6DF8ZhiU+a/k+1yc3C/Z
         OSV8PNZjDS0S8LE3fqlw7jM3kppivXYEXAuV0hDpkVrjTRBhc9R0tz6Va6OAjthwcBH7
         XtZLlCTNSTHrf78Tcgc7C1600ddnzytXp5J+TbA6+A1FXXRSZJGA4YfrXZ0Rmr2MHVXn
         fQXjGnV9pcl5iUEcxVJv+D7GQv2QQgWQFCpwCj+ANZaZZli2wyDpt+tKfMvBAV5k7vbF
         WJvg==
X-Forwarded-Encrypted: i=1; AJvYcCXzGvO6oEem5NrTfX+UZlPWX/NCa13rscnWSq2MKrk6TN0Qpu1a8gxlXOtuadL0R07fUUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypagAe0CWVYy+l1x0nK24+SfrcmDLP340zzEmWeKnc3BbUA0rb
	YJy2q+pi4+06vEtlj5yU6p9VP9xqV30nSBJmyOc0PFvL1dskQtBqJ+xquVFV8GEBtU9GMtj2ZgT
	9zrGv1HAqUsyvNhESnydvYjm6uRg=
X-Gm-Gg: ASbGnct+eXpe41tg/FZ3Foo3KIc12vQTm68wS3B/GVTFWpa5dx1J8JAgSgF9D3zkj3S
	UggHR3VYf5w+GfEX1BtEtPdalmmwv20imTIibUExoH3LfoBHqFQwe/LdjM6cKu/CQy7/KGId9or
	5VyepAk0UKbXwN
X-Google-Smtp-Source: AGHT+IHZZ2KYbGB8ZC2jnwRYoIyKUjPJx3yOky+2O3iJcDWdQ7HTdttSB5gec2bwzEM0gnjeGx/HK6bcKbR9icjMwCI=
X-Received: by 2002:a17:90b:3904:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2fce7b3e0d4mr2084190a91.30.1740099820210; Thu, 20 Feb 2025
 17:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218190027.135888-1-mykyta.yatsenko5@gmail.com>
 <20250218190027.135888-4-mykyta.yatsenko5@gmail.com> <CAEf4BzaxYL1y4wR0KuSouDzmrt610CBwtv0dKp4xbO9LD-t9qg@mail.gmail.com>
 <e65f6a87ca81fd92dec31575e917f9cd4af94c14.camel@gmail.com>
In-Reply-To: <e65f6a87ca81fd92dec31575e917f9cd4af94c14.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 20 Feb 2025 17:03:27 -0800
X-Gm-Features: AWEUYZm36Wy_yLOhaKRy2JvEKhI_NmS__RsuNXJVFgvtRR-tvxBz2zOkLJEadAM
Message-ID: <CAEf4BzZEYFea5i8ZRZRXZiBOpLU5u1SmxmLpRKpDWemLW3MnFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add tests for bpf_dynptr_copy
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 4:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-02-20 at 16:52 -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 18, 2025 at 11:01=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> > >
> > > From: Mykyta Yatsenko <yatsenko@meta.com>
> > >
> > > Add XDP setup type for dynptr tests, enabling testing for
> > > non-contiguous buffer.
> > > Add 2 tests:
> > >  - test_dynptr_copy - verify correctness for the fast (contiguous
> > >  buffer) code path.
> > >  - test_dynptr_copy_xdp - verifies code paths that handle
> > >  non-contiguous buffer.
> > >
> > > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > > ---
> > >  tools/testing/selftests/bpf/bpf_kfuncs.h      |  8 ++
> > >  .../testing/selftests/bpf/prog_tests/dynptr.c | 25 ++++++
> > >  .../selftests/bpf/progs/dynptr_success.c      | 77 +++++++++++++++++=
++
> > >  3 files changed, 110 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing=
/selftests/bpf/bpf_kfuncs.h
> > > index 8215c9b3115e..e9c193036c82 100644
> > > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > > @@ -43,6 +43,14 @@ extern bool bpf_dynptr_is_rdonly(const struct bpf_=
dynptr *ptr) __ksym __weak;
> > >  extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __=
weak;
> > >  extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf=
_dynptr *clone__init) __ksym __weak;
> > >
> > > +/* Description
> > > + *  Copy data from one dynptr to another
> > > + * Returns
> > > + *  Error code
> > > + */
> > > +extern int bpf_dynptr_copy(struct bpf_dynptr *dst, __u32 dst_off,
> > > +                          struct bpf_dynptr *src, __u32 src_off, __u=
32 size) __ksym __weak;
> > > +
> >
> > Do we *need* this? Doesn't all this come from vmlinux.h nowadays?
>
> It does come from vmlinux.h, but this test does not include vmlinux.h
> (and compiles a bit faster because of that).

let's switch to vmlinux.h then instead of manually adding kfunc declaration=
s?

>
> [...]
>

