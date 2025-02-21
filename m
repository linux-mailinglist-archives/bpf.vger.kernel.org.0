Return-Path: <bpf+bounces-52142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B59A3EAF6
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 04:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926C317F616
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 03:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36E81D5174;
	Fri, 21 Feb 2025 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWYL6gmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF89D23A6
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740106981; cv=none; b=EWxxQP5/aVV7DmtbmdMSjN2PHy7PGT17UHdV2OzW0piiS7K8QhUbqaFVWXkAm0cuExKiNWRHNiVO66pf+TkXNvm3mktj2rF5FlN9kw6FTcG+yeV8azTAToQe81BfL/4nfjomat5w+2Wd+RfJ0ToiXQg5KymKM5jbMfW+00GpqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740106981; c=relaxed/simple;
	bh=DALb1AMxWVXihKWRZDYy5AABdhgulqjvBDUPqtW/cbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSA9D2kWLqBijY8twbMxink3yDf99bw5tPxGnb5CWuSlOoooNJMb5mlX8TB5zqo9l+YVG0sCc9KDeai5mWZN7QQ815NTKlVurrS4GOiaZO/Gno8rDM7pL3w1AkJJH2BuD8XhxoZv1otGjcMJNwtPi3v7+k2vghWfoGsLcQyvwmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWYL6gmB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fa48404207so3375147a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 19:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740106979; x=1740711779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OLaYUjTc8eQbY9CLrCHt9+QGn3gr4w7J5Lih5VaxTIE=;
        b=OWYL6gmBaB9DZek6KUG8UKB+r0JTrYxuH9mi0qmO6JV8+OL4MAlBiNUGECv7otFHdj
         GLNaBbySqFuUuOfNp0sBZ8XA1i5mPOOTrYVG/Pf2qLTV6YzVaTgM5H+/nhIeyLRkC1dx
         pE96Bp7WK0yPPOcyW7o79BAag76YBz1BcADdSJ9s3V5TuX+sY0i1l+T6K4ROFl0KwtDB
         c1StxdU/DX8SXNABrbKuCtNfzT0aY50GGZfxRtWDz2B4cl506l0Uaebbt7YABnEeMe+N
         pJ3ugNMKwzvvsA56nwjEa8EiAtaTlLsTexccy05/00mcrz3ffQlifZ7RC7AoXGw1Coca
         6ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740106979; x=1740711779;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLaYUjTc8eQbY9CLrCHt9+QGn3gr4w7J5Lih5VaxTIE=;
        b=ZlWk5V0Ulml96Iyjvt0B/wVwZIDurSQLYzUW3gYIJKlwf9GUP9isDKMYJ+IYrjUfek
         xZK0OZLV1hKG9q2zPpYBZoQVCqxuAZhjri/e+K/JVuJUwbKiDRk9JusNijshXuyDSp3Z
         Iy4tjxVC/52AI28xNbuKRwF1upOLzXuW0V9yF3o8DvtNa4RV0DoS5HxhKOnWQo5HBvm3
         NKt9Mh3sayms+nq3Ic7u0vEWoWtnu+3V/mbZFkePDYZ3YG2mcPVQ90I82Epv6KTRACCg
         0f6SSRlgs7KAClSX0lOrjyvtg/yBoh9X60D8hhS5syYpuIKz1uWvB4PwyEEaUdlItZsI
         o4Ig==
X-Gm-Message-State: AOJu0YyVBd3iGghehkbW1MS2TM1wZElp/wtnS3pnK/sFs21uX5fqyeuV
	xxYZiEZ7S0ft0+TqBErdnm/8HhatOQL5EIoQ/EX99Lva0GWv0BCV
X-Gm-Gg: ASbGncugMUG5ZniNmaptH4jRuY4PHBa6veGo+K0Vz/w0lOGrV5I5UdiJFJFAmmJNi9P
	SdNJv6+42XDN0bS7CQko/vIG+znYXs0jgQrPI+HnBcuuTAazLLTZnDx3iIz9NYMruSN20PoJ5mQ
	Fy/9koZ5FQmk7ThH9/mGnCCWp+WAyHeOEngJJsNfYrst6aU3NkbblLGf5b7bQ7QKIciXzhZTlEV
	hiuMw6gjY2baiqWxX69QyG52OHe4SrNs81GHhjNtjKmrdVdXTM2KKX8CFBwftdO+2Rib7aF0PzL
	cGaRLJ0vEFOhuim/PnggamM=
X-Google-Smtp-Source: AGHT+IGuGOwUbVK/qlc5PtuHvlvNxIzl2d43ZXcsjxerJ6DagHdZD+WJtx7nizp/wl+z0CMjrvQLTg==
X-Received: by 2002:a17:90b:2e44:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2fce7b0acaamr2267518a91.23.1740106979139;
        Thu, 20 Feb 2025 19:02:59 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb09fcb8sm168677a91.45.2025.02.20.19.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:02:58 -0800 (PST)
Message-ID: <88897fb139f903b9d0aae3291602d1df35b31ea7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test gen_pro/epilogue
 that generate kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, kernel-team@meta.com
Date: Thu, 20 Feb 2025 19:02:54 -0800
In-Reply-To: <CAMB2axMjLRNeH=4cm+M5kTKr6b47tOgjCKXVHVXTKbbf6z09TQ@mail.gmail.com>
References: <20250220212532.783859-1-ameryhung@gmail.com>
	 <20250220212532.783859-2-ameryhung@gmail.com>
	 <e83d842e9f6c5cb6f98fd8cb760ec1c8e17e419a.camel@gmail.com>
	 <CAMB2axNXpctJ8M9VgWJPFWKsMGt-u1cnt_KdXW=wBDNi6npBiA@mail.gmail.com>
	 <CAMB2axMjLRNeH=4cm+M5kTKr6b47tOgjCKXVHVXTKbbf6z09TQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 17:05 -0800, Amery Hung wrote:
> On Thu, Feb 20, 2025 at 3:34=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >=20
> > On Thu, Feb 20, 2025 at 3:10=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Thu, 2025-02-20 at 13:25 -0800, Amery Hung wrote:
> > >=20
> > > [...]
> > >=20
> > > Given that prologue and epilogue generation is already tested,
> > > it appears that it would be sufficient to add only two tests:
> > > 'test_kfunc_pro_epilogue' / 'syscall_pro_epilogue'.
> > > Not sure if testing prologue and epilogue generation separately adds
> > > much value in this context, wdyt?
> > >=20
> >=20
> > Agree. I will only keep the syscall_pro_epilogue test.
> >=20
> > > [...]
> > >=20
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 6c296ff551e0..ddebab05934f 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -606,6 +606,7 @@ s32 bpf_find_btf_id(const char *name, u32 kind,=
 struct btf **btf_p)
> > > >       spin_unlock_bh(&btf_idr_lock);
> > > >       return ret;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(bpf_find_btf_id);
> > >=20
> > > I think this is not necessary, see below.
> > >=20
> > > [...]
> > >=20
> > > > @@ -1410,6 +1493,13 @@ static void st_ops_unreg(void *kdata, struct=
 bpf_link *link)
> > > >=20
> > > >  static int st_ops_init(struct btf *btf)
> > > >  {
> > > > +     struct btf *kfunc_btf;
> > > > +
> > > > +     bpf_cgroup_from_id_id =3D bpf_find_btf_id("bpf_cgroup_from_id=
", BTF_KIND_FUNC, &kfunc_btf);
> > > > +     bpf_cgroup_release_id =3D bpf_find_btf_id("bpf_cgroup_release=
", BTF_KIND_FUNC, &kfunc_btf);
> > >=20
> > > Maybe use BTF_ID_LIST for this?
> > > E.g. BTF_ID_LIST(bpf_testmod_dtor_ids) in this file, or
> > >      BTF_ID_LIST(special_kfunc_list) in verifier.c?
> > >=20
> > > (Just in case, sorry if you know this already,
> > >  BTF_ID_LIST declares are set of symbols with special suffix/prefix,
> > >  at build time tools/bpf/resolve_btfids looks for such symbols and pa=
tches
> > >  their values to correspond to BTF ids of specified functions and str=
uctures).
> > >=20
> >=20
> > Ah yes. It is an artifact when I was testing a patch for generating
> > kfunc in module btf. But since there is no use case, I removed that
> > part. I will change it to BTF_ID_LIST. Thanks for catching this.
> >=20
>=20
> Actually when I use BTF_ID_LIST with a kernel kfunc, I got the warning
> below. Since it was not able to resolve the btf id, the test program
> failed to load as the generated byte code will contain invalid kfunc
> id.
>=20
>   BTF [M] bpf_testmod.ko
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>   MOD      bpf_testmod.ko
>=20
> I am not familiar with how resolve_btfids work, specifically when
> building a kernel module. Do you have any suggestions?

Looks like there is no way.
resolve_btfids is called for module as follows:

  resolve_btfids -b <path-to>/vmlinux bpf_testmod.ko

Where -b specifies base BTF.
However, the bpf_testmod.ko has .BTF.base section, where distilled BTF
is stored. In such case tools/bpf/resolve_btfids/main.c:elf_collect()
overrides base passed from command line, and uses .BTF.base instead.
However, `bpf_cgroup_release` is not referenced in bpf_testmod.c,
thus it does not get into distilled BTF. Hence, its id remains unresolved.
And it cannot be referenced in bpf_testmod.c, because it is not an
exported symbol.

So, for this particular case there are only two options: resolve id
dynamically, as you did, or use a kfunc internal to this module
instead (which should simplify the test, imo).

The broader question if want a capability to use BTF_ID_LIST referring
to kernel functions from modules remains open.

[...]


