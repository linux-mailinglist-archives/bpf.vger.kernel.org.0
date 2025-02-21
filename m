Return-Path: <bpf+bounces-52129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB4CA3E9A4
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B751319C73C0
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFA33594F;
	Fri, 21 Feb 2025 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThU0baph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CA717993
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099944; cv=none; b=j1JzjRH8wDiTEyXw6OPXPBsNX8MEdOlOR6Nq5OfknHj+/I0865/LIPWYHphJvsakqhAe+9ZPFfBGP9jko3GP/r7X7J0+p3gdX3z/XTSQQ4zOaammIxpN/Q0pj/K6b/pfelT4k2oUjx0c8oQjKP5yIx8+mnsuuga6RSkFDzDBKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099944; c=relaxed/simple;
	bh=vPfKJmQOsudAbaWCB/GsBX4WywF60CXE8yaV1PsMuuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gADr8Q1EdeZagGqkZAyWbeAUjZt9tZh1YFm3FY0qvtvY6TDGdzSP/ddVe1cBgXI0JrOcs8ZB4hwBbWvE9fY15sMFKe07QtreWKk6vBG9XaMFCGLz6Vtfn4BRTc8DhHfvkxnA3NOWZ+VH9khRKFdf6nhMY+1goINnCeKTmjZ4//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThU0baph; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e5dd164f03fso1567536276.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 17:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740099938; x=1740704738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZpNLDJbxjBhtR8kYO4SpgjqyQ3/pxOLcwyrFCppfcA=;
        b=ThU0baphJjdmpYxBzclr+kCGgkZurr/oEBShoXnY/QjzqEXAgv5YSi5Q0QifMsvf9F
         t3zsk5kmvSohi6rkREUaBlzhm0pR21m6uDbHYdaksUdO0rQLD8mrYR1uEpSn0liGOuZo
         VpFPMfRSt/VnNq1ANLczvlWVyXadfz10Mbnrfd/8AQVjQW1pp0MucfnJGJJRTu17m7r5
         cpp3P3S112BuaNhTxGKRovtd39VcZauONrjLvDur2vCQtisjZVpDrkEofR+jZcZKdzha
         jZMJ9/DosM+FMr1gxzBe8fLLqI2H3HdW/bEXDrB3gW+v1wkCZKGfXnH6RhtDoxIUxspf
         zMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099938; x=1740704738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZpNLDJbxjBhtR8kYO4SpgjqyQ3/pxOLcwyrFCppfcA=;
        b=M/zxpDwzJpl53j2ne185BrAWtdsn5vNASBOYZGYSTwPo6Ms8EqNy2Q7IVW2heyzKap
         sJYcK+G/OQ9rDpNIWaQQ9BHfVW8RhHbep1dM8ompkVMpYGuLwqDpHkci0IhuwQOz9++X
         NaN0BhV/h/6QcOAZsK0KBYrQyKRgdN8cOAQK41oaI6E/qw6Ia7KGstxU4pCQ9XIvQXD9
         xVBbRfAaTi3wn3xEeKxuKrmFiE9vUVbx1GpHmvB2wwU+m0SEwGO4RIfyJ7k4XiApXWHv
         7sYXlviqUqjQ5Cuz6GZIJCJ+6peGTc+pO3TmcfVuEEJhJWSBvgXFi3SmAjUIpU30DPO+
         VSYQ==
X-Gm-Message-State: AOJu0YyEWsKdiKgxoBAezvIX40dP9fGQka9bFvp1xygI68PUySqs1PsX
	2KZO+vWa4oTimkLvMZkrPl496YlGmYm7MzEZzpD+1Q8SyRVUECorLoFN5tnquwOxDOsOdRam7un
	4KUTSKlC0KQ6Vekv4NhDDlccRdVo=
X-Gm-Gg: ASbGncv7QEUy3Of/XuauMFG/DwRLn94B62/mChvFk/tqMy2Ovd34y/ZOlK2dFc3vbjJ
	BNWXN+YyqQGgByNO7+oxLqKqP9yBMMXS9uz4qUgSHGYVyP0kACqcb6uKarsEU6na1SqNXrsNt
X-Google-Smtp-Source: AGHT+IH1cbjgte64kNI5XiarPXjCJTEsyq76tTfgStN4e0+nN8Gxb/YxW3Zuuf2EKn5UwCodfWV6B/B8xqxqsfFqz4A=
X-Received: by 2002:a05:6902:10c7:b0:e5d:bef4:30bb with SMTP id
 3f1490d57ef6-e5e24688606mr1323337276.47.1740099938000; Thu, 20 Feb 2025
 17:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220212532.783859-1-ameryhung@gmail.com> <20250220212532.783859-2-ameryhung@gmail.com>
 <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com> <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
In-Reply-To: <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Feb 2025 17:05:26 -0800
X-Gm-Features: AWEUYZnTHwGQabzzdy64-E25ChYApkKQx_O_qXKGA4vSbz5QkmptYTjhQm-ip2Q
Message-ID: <CAMB2axMjLRNeH=4cm+M5kTKr6b47tOgjCKXVHVXTKbbf6z09TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:34=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Feb 20, 2025 at 3:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2025-02-20 at 13:25 -0800, Amery Hung wrote:
> >
> > [...]
> >
> > Given that prologue and epilogue generation is already tested,
> > it appears that it would be sufficient to add only two tests:
> > 'test_kfunc_pro_epilogue' / 'syscall_pro_epilogue'.
> > Not sure if testing prologue and epilogue generation separately adds
> > much value in this context, wdyt?
> >
>
> Agree. I will only keep the syscall_pro_epilogue test.
>
> > [...]
> >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 6c296ff551e0..ddebab05934f 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind, s=
truct btf **btf_p)
> > >       spin_unlock_bh(&btf_idr_lock);
> > >       return ret;
> > >  }
> > > +EXPORT_SYMBOL_GPL(bpf_find_btf_id);
> >
> > I think this is not necessary, see below.
> >
> > [...]
> >
> > > @@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct b=
pf_link *link)
> > >
> > >  static int st_ops_init(struct btf *btf)
> > >  {
> > > +     struct btf *kfunc_btf;
> > > +
> > > +     bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_id",=
 BTF_KIND_FUNC, &kfunc_btf);
> > > +     bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_release",=
 BTF_KIND_FUNC, &kfunc_btf);
> >
> > Maybe use BTF_ID_LIST for this?
> > E.g. BTF_ID_LIST(bpf_testmod_dtor_ids) in this file, or
> >      BTF_ID_LIST(special_kfunc_list) in verifier.c?
> >
> > (Just in case, sorry if you know this already,
> >  BTF_ID_LIST declares are set of symbols with special suffix/prefix,
> >  at build time tools/bpf/resolve_btfids looks for such symbols and patc=
hes
> >  their values to correspond to BTF ids of specified functions and struc=
tures).
> >
>
> Ah yes. It is an artifact when I was testing a patch for generating
> kfunc in module btf. But since there is no use case, I removed that
> part. I will change it to BTF_ID_LIST. Thanks for catching this.
>

Actually when I use BTF_ID_LIST with a kernel kfunc, I got the warning
below. Since it was not able to resolve the btf id, the test program
failed to load as the generated byte code will contain invalid kfunc
id.

  BTF [M] bpf_testmod.ko
WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
  MOD      bpf_testmod.ko

I am not familiar with how resolve_btfids work, specifically when
building a kernel module. Do you have any suggestions?

Thanks,
Amery

> Thanks,
> Amery
>
> > > +     if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)
> > > +             return -EINVAL;
> > > +
> > >       return 0;
> > >  }
> > >
> >
> >

