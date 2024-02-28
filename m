Return-Path: <bpf+bounces-22968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F086BC64
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BFB28A48D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EF72932;
	Wed, 28 Feb 2024 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1kJ7GXC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103E13D306
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164609; cv=none; b=JRT8WFH/n249QRr+HHjPIFUe9DKHVNbLBSg+vdw1vHD6J5jzNK8NPWKhDoDrpBd4eh/gHE4S5lmEtNl66/QYszouEGXijC4vgqC/fUTEOjVWY0a/KWCWASRC2AaHaF2U0VkxQACxze541slEIRAKIWmTNULdDACxzy3g7LZ2q9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164609; c=relaxed/simple;
	bh=z/JKThN60n0TAVvKWNIYHYV2N1ULEs6L+WN0zx6WJUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puofNuMKirEbJM74l+BZt2tuzfoa5V8StvGuYdFnIfyf4DWTXYI2yNem33qPVgMQTXhvef0FB4+pyK7GWmz9RvjaBOB+wY1Q8QMeapOGlSC1uRIlBYc6Dv6Ad/AMAnn2u/pQPu/s7upEkJcTPp0Ei1oflZ0gWdvmT9TiHzLotkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1kJ7GXC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-299e4b352cdso188280a91.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709164608; x=1709769408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUAVk52nHf9kkay8+jImDb+CzpEVL/q9CkQNGiWfNEI=;
        b=J1kJ7GXCVu6XolaenPb+ZV/mbba275gk0uKx8cDD0vaI/UdeJeL6nWmWRZjvxd9GAH
         +bap7KOaEhAU7WD1xMiE0REowtQUD0Rkop7OGx9kNh2So/HrWRdSsOY5+9SF9FNioRHY
         /7jkv4I+9IvM//RiZH2HqlfME7hduch25jyeCWyr0cblNkBygiqqyQ0u1srr6Dx5zNLc
         pfAWBF+unKFEc3BtWSlgk8N/ZYOzNbVzgHHZtDwkYg0dakUlnQ34H7kSxWgsf5tNx/J6
         nJbOl2BTO+JIbyUbrIlV6jKtxMSZXgfGuLq/U6EGHshmCDWjDORBIpxK/oOddoBSLDI2
         +xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164608; x=1709769408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUAVk52nHf9kkay8+jImDb+CzpEVL/q9CkQNGiWfNEI=;
        b=jv/RZrtG4KB3/fC5I1Fg/mJbfLMOiionCr6tFt6JYjPgKlO/CiDn6WTAVBrphoZOTt
         /p9BRMGm+Z4LLIQ4ALgSg+dlSA+uxWXfZlqjdBSI/KgCCpObkBTR90qPzDZ5AfezSQpt
         W5gUvMVxR7ArPvUZn0xzVuaokb/WhZ6AODBj9jd5xalzyUr1RMBUCZ8sa8EdzXXcS4ia
         iHTIj2YuTXoR1xZUjHgVkPlO3DlP/PGux5uNualKVy2q5Ubng3YqihCleWXEqXdF/bUT
         dInojAGB13NVPKTM73xmLoTCi2HY1ZmTMgvAUzJdMq4UyI32AEav4q7d7n16UkK8rnjo
         KH5A==
X-Gm-Message-State: AOJu0YxpYZCX0fqvGbZibX6hnmu8RqojZAAqrBPwWjbiiR3kZMolaoLH
	5EWLoyEdb0xrEjCbwjl5vnWZzpovr3ltlXwqvORjF07ENEFWK15NHVpzG9bMk2wT2fdSM/dRlHN
	TjzR/O1xqEMeyNk/2u/3n6rhYv9GoRnjb
X-Google-Smtp-Source: AGHT+IERo6YqnoVY+2jqQ66326VOu7rMSG+gpMCX4WeB58ErSvP4cJSNfidyVBoGBPW3mq6t4YG8nvLOkHKQccrxOTM=
X-Received: by 2002:a17:90a:b281:b0:29a:a3a6:dde7 with SMTP id
 c1-20020a17090ab28100b0029aa3a6dde7mr766038pjr.18.1709164607784; Wed, 28 Feb
 2024 15:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-6-eddyz87@gmail.com>
 <CAEf4BzaDwpTVwc_wTT74EthE5g11URiysNeuu6V+HDKrWXEnfQ@mail.gmail.com> <81fd7d298578b2bbc3d7a117c8e2144adbd0fb4b.camel@gmail.com>
In-Reply-To: <81fd7d298578b2bbc3d7a117c8e2144adbd0fb4b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:56:35 -0800
Message-ID: <CAEf4BzZfPnWr-=q_9kSxsow4XdHeEXg__k3tPrwLfck9jn_p=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 15:40 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > +static libbpf_print_fn_t old_print_cb;
> > > +static bool msg_found;
> > > +
> > > +static int print_cb(enum libbpf_print_level level, const char *fmt, =
va_list args)
> > > +{
> > > +       old_print_cb(level, fmt, args);
> > > +       if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, st=
rlen(EXPECTED_MSG)) =3D=3D 0)
> > > +               msg_found =3D true;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void test_bad_struct_ops(void)
> > > +{
> > > +       struct bad_struct_ops *skel;
> > > +       int err;
> > > +
> > > +       old_print_cb =3D libbpf_set_print(print_cb);
> > > +       skel =3D bad_struct_ops__open_and_load();
> >
> > we want to check that the load step failed specifically, right? So
> > please split open from load, make sure that open succeeds, but load
> > fails
>
> Ok
>
> >
> > > +       err =3D errno;
> > > +       libbpf_set_print(old_print_cb);
> > > +       if (!ASSERT_NULL(skel, "bad_struct_ops__open_and_load"))
> > > +               return;
> > > +
> > > +       ASSERT_EQ(err, EINVAL, "errno should be EINVAL");
> > > +       ASSERT_TRUE(msg_found, "expected message");
> > > +
> > > +       bad_struct_ops__destroy(skel);
> > > +}
> > > +
> > > +void serial_test_bad_struct_ops(void)
> >
> > why does it have to be a serial test?
>
> Because it hijacks libbpf print callback.

each non-serial test runs in its own *process*, there is no
multi-threading here, so it's fine if non-serial test temporarily
hijacks print callback, as long as it restores it properly before
finishing

>
> [...]

