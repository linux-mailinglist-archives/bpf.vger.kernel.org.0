Return-Path: <bpf+bounces-47728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007439FEC9A
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 05:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF63A1882A7E
	for <lists+bpf@lfdr.de>; Tue, 31 Dec 2024 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537D131E2D;
	Tue, 31 Dec 2024 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJyYwy0O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC442CA9
	for <bpf@vger.kernel.org>; Tue, 31 Dec 2024 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735618169; cv=none; b=TlE/8XV4NRNVutEyzwqWfmsME259PPhtG7jXIw6ywSphJgKeYTP/xsKCCnxh/y+Z8Ni0qn62PYLDrqsAdr/n8ntz5Z4faSJGqI6h3HGrHa/LSMoR9DzmvZQXAc3e4YnmyOvAspKrU7phLFVY5NIpb53eCD0RbYtPSFu0nyC0RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735618169; c=relaxed/simple;
	bh=xm/mdv1zRGVYz2WXyY3LN0AmuzJzH2X2dITD24XIMFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPp867Q4JJZt8hGF4NInq5PP4ADqrXAfGvX38DG8aZNKqkPc6dvPj9W43Pu2DoS5q1p/tUyhweMD5Vv0Cy2isQmiWK7ipjMIA8Go4rCcj4lW5vRpTQDboKFm1SDq80DBPqlnSVdXUJc/KKNBxYk2dVaWUf/rxUvyIkFW8sLWiqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJyYwy0O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e0e224cbso4994094f8f.2
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 20:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735618165; x=1736222965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm/mdv1zRGVYz2WXyY3LN0AmuzJzH2X2dITD24XIMFM=;
        b=nJyYwy0OG5xK1BU3WQZBwIhZe3+gCcvvRlMdcyr5RGR5hA7sOH8wyTeMyBGlV+patX
         k7lnhcW7K1iQDcXNcNApmDB5c66w2dN8m8GrFxd9H6IJWBDHciPdW6vMifoWKoVdD90B
         0lc2vu6zx5kV+y/1Usp2+07qtVLBGFzX1JzRGxahJRlm6plaqgJvRaa6ET3LTlMehs3f
         Q84eFg276Z8uFWQ+j3kyViPUFXdZ35EooDSY2ivxh5NshOZv3h+2YvBenGb+3Md/6kct
         5HJpkvHlo7nNUJFDxnHyozu3biKLt8cJv1zeELOiOOZTKBFkvug5B7N4JQC1WNA0Pszg
         q0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735618165; x=1736222965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm/mdv1zRGVYz2WXyY3LN0AmuzJzH2X2dITD24XIMFM=;
        b=NjUtQEEWI+YWsuPOPcSUy0eAJZ1/nENhpYP4gawcK66RgXKTPEmHUviMHZBGIHFufD
         94NNI7sRHRLjFZRY8UJLwqAFciv5q5KtnhrNXlG0SrPdWGcBiCV7HkzVHjSFYVzCef5b
         AtIJZMfDaDwvhq+O9zXuDEmm0dpZbfW9LvFbqonCT/CLmtHZxnjyEYdkiCi/29Qx8vLD
         CEi1hB52PYSx5lWZNqOzrAPAdyImADYjmv2Co5ePjf6HgYXx4BVaF2Hsb/a4deGKyD4r
         PBoLNorYm0wcsElnSun7UVS69L6D5cmoTLzT0IAq23edR8ZO2bDn2AaGFsFboJe3mkAN
         OObQ==
X-Forwarded-Encrypted: i=1; AJvYcCX686o9iCi4Rl2HpcGj1a/kt1nMDqH9/+2mSG+AFPhzA6xQtTmsnKB5LOHWFsQlyYBOmSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMru7OMYbgFt0bxhtStxlIyU4++FwRj/HrHgZn/J3VG29cc+2
	UwFKz3Px1TnivFd6fvGwmOnXlXTHNaMP4vfQacw8W/z/xtC0yav6dI7n2reBEzBF+JoAfUlydAa
	SckIXIlij9jGxtE11Z3f0o0ZE6Ac=
X-Gm-Gg: ASbGncvnv8UHTVEs0oj9ChhclbhGrkZf9kQPE4ue/I6WJEuzfnIRXD9eD4O/oTYCv9J
	/4bDUZq4hov9Zc37d5BATJz+TR56V859cjHL/VucCAbXTgL5x+Ouu9wGUyzAoGlgaucjUUA==
X-Google-Smtp-Source: AGHT+IFbwN9xYtvUff5p0K6Rf1ttjeKRBFEt6aRUBzYfi+epc9o7bTJGYJg3+gdcLIer1mA0JvF1KPNCK91gBm3DKRE=
X-Received: by 2002:adf:a3d9:0:b0:38a:39ad:3e2f with SMTP id
 ffacd0b85a97d-38a39ad4088mr15275713f8f.2.1735618164451; Mon, 30 Dec 2024
 20:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
 <CA+=Sn1ktCrXZMjrC0b1TNxfz1BnQfG24XUdVuktS8kRWeEP2kA@mail.gmail.com>
 <87v7v0oqla.fsf@gentoo.org> <7ZXLMz0XIsj0YzKNHVoLZ1JrCshOqeGCldUFbX3f8F14s0opaXTpmjfzZH2E10v0b2SFXk2x-DVTN5wGuUqPJQDhA3sOcVm7GeiGzKLRhRI=@pm.me>
 <CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com> <K9N2BZvW85sXom0Rjc28rKGhmfsmBWsFCgcHkOJz3g3ae9YseEPmygt9Nh1eTbIb354-4gGt59x_ONDF4_BWmj4RFdHplByhh_jog6dBymY=@pm.me>
In-Reply-To: <K9N2BZvW85sXom0Rjc28rKGhmfsmBWsFCgcHkOJz3g3ae9YseEPmygt9Nh1eTbIb354-4gGt59x_ONDF4_BWmj4RFdHplByhh_jog6dBymY=@pm.me>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 20:09:13 -0800
Message-ID: <CAADnVQ+sa+LRN7LfkE3LR70KtBrkq5og7DnDHvEK4Fu_PAMKDg@mail.gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski <pinskia@gmail.com>, Sam James <sam@gentoo.org>, 
	Andrew Pinski via Gcc <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Manu Bretelle <chantra@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 5:26=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> > >
> > > #if STDC_VERSION < 202311L
> > > enum {
> > > false =3D 0,
> > > true =3D 1,
> > > };
> > > #endif
> > >
> > > Any drawbacks to this?
> >
> >
> > By special hacking this specific enum in bpftool ?
> > Feels like overkill when just adding -std=3Dgnu17 will do.
>
> Yeah. I've tried both the flag and a btf_dump hack today, and the hack
> is indeed an overkill, assuming we don't care about generating
> C23-compilant vmlinux.h. To conditionalize the declarations both the
> enum and typedef _Bool have to be matched, so it's actually two hacks.
> Although we do use hacks like this, noticed an interesting example
> today [1].
>
> Regardless of how the bool-related error is fixed (with STDC_VERSION
> condition or std flag), I get the same int64 errors with GCC
> 15-20241229 when building selftests/bpf [2].
>
> [1] https://github.com/libbpf/libbpf/blob/master/src/btf_dump.c#L1198-L12=
01

This is more of a workaround for differences in gcc behavior.
There is no way to cure it with a flag.
While in this case -std will work. So use it.
No need for extra hacks.
There is no objective to produce c23 compliant vmlinux.h at the moment.

> [2] https://gist.github.com/theihor/7e3341c5a1e1209a744994143abd9e62

/usr/include/x86_64-linux-gnu/bits/stdint-intn.h
vs
/ci/workspace/bpfgcc.20241229/lib/gcc/bpf-unknown-none/15.0.0/include/stdin=
t.h

looks like a configuration issue.
We can skip test_cls_redirect*.c for now.

