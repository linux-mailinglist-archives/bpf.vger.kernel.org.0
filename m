Return-Path: <bpf+bounces-40704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC698C4B5
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A541C24798
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4671CC176;
	Tue,  1 Oct 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBpVEfU6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5D1CB521
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804435; cv=none; b=R1XFXr4IVrlqwaSJioAhfx3c2CkSh2hzxfZHQ3mxcr4Dmyh37pfPUofdffQFHBYzyFBjKVMZM/dI/TIXc2kQLPAnOAA0iYULlFYT5tst9caZutx4WEuiWUZ28/cmWLc+3cAke5cVOJ0eRwUkmBzlHkaQfiY3KDHgnE1AxtPtYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804435; c=relaxed/simple;
	bh=USZbvs4qEALd8GexADyi2FlKE8ylT2lF1s3C+qHoaUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WoW0lPn9+S53daJsv7CSxZikvreoc/ZN4KdEN+/6GiIKVCA4lqpW1h16MxVEiXGJpyGhmqMEzC5US1le7vTZJ1RRegzrAyP9SzZBHnbjW/sQ4w5KDv5VtjdPeF7jw8VOikk+d0SDfiVYRXet/Qemkafu+kodOjY81LsjEI/4Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBpVEfU6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so3898484a91.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727804433; x=1728409233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++MZ55I5Yv3WG290qCURmfw0S39n+wHRocAl4XeyRKE=;
        b=gBpVEfU6KpWs+Ezfk04uRowpshMIUhDHGUAjrDcyeYMdL7O61on+JEhK7AkzqDOnAR
         Dh+Hor575eYDqcbMHRr0H797fZ5xLh7lfyVOxVxlsR+BsiU/yhb5oT1k268q6GO2Ja5V
         9BOHe83FGz99gDBlp6Ys1ZiUX53HHVvx786fn3D4yOiyi4OdUC70vLamrYGLEJWfMToo
         xYFJp1JWK+2CRgHyyxTtaLaG2pO7ir8BfNz29ucXUaRs6xHw2PU3iXz5d0OM58Wkb2uX
         CAf4/YszP8U7GVrFwf0H96dLRTeGN4a8fPZ8hgb+yQB4yqG9esd0XMZO1tLnpzyEYh3h
         XBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727804433; x=1728409233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++MZ55I5Yv3WG290qCURmfw0S39n+wHRocAl4XeyRKE=;
        b=E1AK0JpsBe5BKvXkNr2CpFMgGtSRaVNTBG2xG4bm3nq/3QMbBkEu0W1i+hwss5J+z/
         r6Sudxu6Oy3yxlDmUgcqcKDC+vfubbMjHTtkObNhI7fMM+k7NfRG7l9sLUJZ6ho0KUT5
         PpRcC7dchbehSvcQbpcAOzCnthQ27rIGnOnpUJFuQKKOhG2ZAAe+1rbjyrEjFpFfkBZD
         L6xlxpP+ilN8n0ZaAmNWIyx91mPuLq4Patxl4NP0X5AowH1TAQEwPANgLKKAgA2wUkDA
         djRt/AUDZdi9BTKkwhVShinaGqcegoJuRD4ScDwdSck86kM5roRtrwDni+rMdkc9hZsX
         5uYg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZfOLCalbeyVKXg95z+6+2WU0q0hXWVA30ZF1Ectp92Snf3jP/z4EBrHwzrVqEp+/7lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/9ZUMwdxo9hMNpZrIqC8N/9LpLzSZ6llrzl6waAX3KfsjcdK
	my0ImgX7fpi1yEAUya3r/C8arxGNnJWodv3CHoqVRsRB2HOznn5vN6iq+75iRH+14Q+bz5FyOVJ
	CtoiWIgAquY3aarnHwAn5UD5yF/0=
X-Google-Smtp-Source: AGHT+IEu7m5vBC8vtQQQxBlPdsGHVcV+2PMY8XaGt7QAaHjBQjoHWtMCz+NKlDzBOeKiaQiQYuMd3SFDkAYOXOl/X/8=
X-Received: by 2002:a17:90a:fa01:b0:2e0:d957:1b9d with SMTP id
 98e67ed59e1d1-2e18456b614mr620366a91.13.1727804433136; Tue, 01 Oct 2024
 10:40:33 -0700 (PDT)
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
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com> <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
In-Reply-To: <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:40:21 -0700
Message-ID: <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:34=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 10:04=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 1, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
> > > >
> > > > [...]
> > > >
> > > > > Right now, the only way to pass dynamically sized anything is thr=
ough
> > > > > dynptr, AFAIU.
> > > >
> > > > But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffi=
x,
> > > > e.g. used for bpf_copy_from_user_str():
> > > >
> > > > /**
> > > >  * bpf_copy_from_user_str() - Copy a string from an unsafe user add=
ress
> > > >  * @dst:             Destination address, in kernel space.  This bu=
ffer must be
> > > >  *                   at least @dst__sz bytes long.
> > > >  * @dst__sz:         Maximum number of bytes to copy, includes the =
trailing NUL.
> > > >  * ...
> > > >  */
> > > > __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, cons=
t void __user *unsafe_ptr__ign, u64 flags)
> > > >
> > > > However, this suffix won't work for strnstr because of the argument=
s order.
> > >
> > > Stating the obvious... we don't need to keep the order exactly the sa=
me.
> > >
> > > Regarding all of these kfuncs... as Andrii pointed out 'const char *s=
'
> > > means that the verifier will check that 's' points to a valid byte.
> > > I think we can do a hybrid static + dynamic safety scheme here.
> > > All of the kfunc signatures can stay the same, but we'd have to
> > > open code all string helpers with __get_kernel_nofault() instead of
> > > direct memory access.
> > > Since the first byte is guaranteed to be valid by the verifier
> > > we only need to make sure that the s+N bytes won't cause page faults
> >
> > You mean to just check that s[N-1] can be read? Given a large enough
> > N, couldn't it be that some page between s[0] and s[N-1] still can be
> > unmapped, defeating this check?
>
> Just checking s[0] and s[N-1] is not enough, obviously, and especially,
> since the logic won't know where nul byte is, so N is unknown.
> I meant to that all of str* kfuncs will be reading all bytes
> via __get_kernel_nofault() until they find \0.

Ah, ok, I see what you mean now.

> It can be optimized to 8 byte access.
> The open coding (aka copy-paste) is unfortunate, of course.

Yep, this sucks.

