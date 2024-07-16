Return-Path: <bpf+bounces-34878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA904932016
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 07:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B0B224D8
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 05:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE721799D;
	Tue, 16 Jul 2024 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt7Yev0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC014265
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 05:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721108058; cv=none; b=AFsDpIfSVD6AGI7AylCDA7Au8IHwGDe/b6rRIRi8zCCYdAt74hFxbEP43D9wjfMOcXQJFU+jWz/y5qfZvf5Zz9eP5Oj0kqTBlBFeOlc8huwDI398bCkfLfVTulpluwrllX7ROHYQr18XzdWUm8Z+7FeDFIQBuOq9LWT2gn2cB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721108058; c=relaxed/simple;
	bh=BWYDGGDkJ1T8JdNjH54qMSgyKH4bhwtTpS2p71/pwJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9RvIzH0WJETwRw1qnAa5ZWRh1YTMcbbmGohxDvZSk0OJ90YFduJWwXE4ldlUKHpgRkh3OdhBCJWvNZCMDBUp3UvJoIBr/O9KDzxxAjz3097O0BqGDQvuksAIkWqFqQxZeLImF4mT31ArQhcLVPr5CYbKxibM4dzXSar3P3/A68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt7Yev0X; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65fe1239f12so18801147b3.0
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 22:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721108056; x=1721712856; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkAPNc7UxXzOyccSnCjSf9aden+0hCCcYkV+GkIs5x0=;
        b=Tt7Yev0XY2U+ZdkAyESA1Mwp2jD7e/d+HX5NJ/41vBFlC6Ljdf16jpCKSnqiYUMEcv
         tDReEc3sStN4SaLp5nfO0cIhNPsKB3tYnY3D/k/UN10a/kDSVFdzgt7kJRmhFeAZvRPe
         zyAPH42ntQf4Xpu85x7O4PR+3lQn46xLswjYusJEGV5mpdafnpJrcusIVyy44FvHQMFL
         wfjYZs1oFjNR4Yoihh8PrJrIYVxL5v6STffuDdE5pTwVzxU8mEjcho02XNyfrHGrjPQd
         XZalWRJbQ/2XF/ZEjsXiaYwZfJNGrbrctW1I3PeKlZVh0+2ZpWR7OWiU/odcvu1NaG5L
         oxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721108056; x=1721712856;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkAPNc7UxXzOyccSnCjSf9aden+0hCCcYkV+GkIs5x0=;
        b=f3R/Mf1YX2z0wr5WSirg6oh8u2llVY7a3ZYRzuknbb6XBG9CRhC0CorEMC/GLUqVGj
         l5s8GfxtV/Yr1h012YnBhVaBTtt/SzorJWwJZ9LAqkOrjVFA9HOTS6WaGJ2HLHvK4OED
         iQNtPAR2Z+owH03o01rjzLLyVN4/0talK2mW/uui5A0eMEKuncdjwER0xD66YBwmKGDT
         IW+3jL2o1Y+COYLiqAYW20/A0Uj1vZiM4u7w0xce13vwZ1S0U02kODizH4QK0ut4ZrWB
         0FQHhFaI1bQncwOIz8cZ7TLWGKT9e9MviVukW4K76+rqnzDgX3+wb7z460/mJ2ewTYAZ
         fUVQ==
X-Gm-Message-State: AOJu0Yy7+WKh0pM7yDG2dqcu3aIskHzVvHL47yMwfuZcqfSCR0kyaRkd
	IiPGLmcYal3AxsNDpYewVKzxQ8oeQqfkVdKNs0OVTN6PdNIRu8SJ
X-Google-Smtp-Source: AGHT+IEAaeb2JwPvZHXbsi667o7Evcgsz+EdtXXlx4T8gcnMD78IwEtFv560ttQMBqfW5ZExP0diAw==
X-Received: by 2002:a05:6902:230e:b0:dfe:fac8:b890 with SMTP id 3f1490d57ef6-e05d5dff8a2mr1523652276.28.1721108056007;
        Mon, 15 Jul 2024 22:34:16 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7910f291ee4sm2954748a12.86.2024.07.15.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 22:34:15 -0700 (PDT)
Message-ID: <b660e0becf9b629a4d236ec5c03b8cc0dcdc2502.camel@gmail.com>
Subject: Re: [bpf-next v3 02/12] bpf: no_caller_saved_registers attribute
 for helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
 <jose.marchesi@oracle.com>
Date: Mon, 15 Jul 2024 22:34:10 -0700
In-Reply-To: <CAADnVQJ7MAtt-EZLorjuyhoOFijyff7tNDy4-up0L6pjnrZHvg@mail.gmail.com>
References: <20240715230201.3901423-1-eddyz87@gmail.com>
	 <20240715230201.3901423-3-eddyz87@gmail.com>
	 <CAADnVQJ7MAtt-EZLorjuyhoOFijyff7tNDy4-up0L6pjnrZHvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 18:51 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > @@ -21771,6 +22058,12 @@ int bpf_check(struct bpf_prog **prog, union bp=
f_attr *attr, bpfptr_t uattr, __u3
> >         if (ret =3D=3D 0)
> >                 ret =3D check_max_stack_depth(env);
> >=20
> > +       /* might decrease stack depth, keep it before passes that
> > +        * allocate additional slots.
> > +        */
> > +       if (ret =3D=3D 0)
> > +               ret =3D remove_nocsr_spills_fills(env);
>=20
> Probably should be before check_max_stack_depth() above :)

I thought about it, unfortunately, that would be a half-measure.
There are two places where verifier reports stack depth errors:
- check_stack_access_within_bounds() checks for access outside
  [-MAX_BPF_STACK..0) region within one subprogram;
- check_max_stack_depth() checks accumulated stack depth across
  subprogram calls.

It is possible to move remove_nocsr_spills_fills() before
check_max_stack_depth(), but check_stack_access_within_bounds() would
still report errors for nocsr stack slots, because
check_nocsr_stack_contract() and check_stack_access_within_bounds()
are both invoked during main verification pass and contract validation
is not yet finished.

