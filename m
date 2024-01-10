Return-Path: <bpf+bounces-19302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBB18291BE
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3555AB244F8
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002381111;
	Wed, 10 Jan 2024 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK1ewSEO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6163D;
	Wed, 10 Jan 2024 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336746c7b6dso3212420f8f.0;
        Tue, 09 Jan 2024 17:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704848829; x=1705453629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kzeKZQ2q2UJ+/AdvmSxOy2poTn653uHKZFwHZADhUA=;
        b=PK1ewSEOyIhnYsEFalGRfMoGuaz15quBsfYIuMyxwfCj+0jXEk8XfwKudmKM97wiwG
         ayh9qDDbmtlfvuCb/X29SBRDTcSCKifE0vUgen+7T6chdjFYl2Y9nsxHOIVeL6zhRlp6
         /ZByq1XXTxVNcn20YscSv3+LS2OYw8mm74cM0fg4PbiWzrHWdGM282kUFR1uPPrImqgi
         0SY2nkzGdTjrhc/3WRV7esa5V0Gfy+AAononmtwHmZvMo3L3AnV4Ure5CiWBACruLHyZ
         VJHTjYGEj6OSJoZRez70ySLVctPatFs8CHvrj43oc+Bb88j44lnwurtxj2tKgoPejeYE
         nOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848829; x=1705453629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kzeKZQ2q2UJ+/AdvmSxOy2poTn653uHKZFwHZADhUA=;
        b=fgYKYpT9f3L/v7GGOiWlhdoGkS80dqTsFJU6c/+uYDQvnTXh1l62/hYXRJ8krR7a7s
         cWvUDojeLvRWkbNLvFPaBxCMU08Pl57/NoVA2u1ZKMjzNFLIoLCzxMmg0s/4Y5znWFmN
         fkfJbgYzgoQoBr6296er169Z/oSU5GEoH9vfG/8Z4/2jqWhyipr15oGTJbrIRWF8uVc6
         htqI9+5MFU3mzlrDyAqFmrXffPEgcDnuJGprufoMDIXVTJcFi+rBqy2LFGlUJEckNanI
         IjmCyfuHtzoXgj3AXvM9kP5DvPFtUxoVnKbbD6HVOA5UNuh/sHHgWGw6FY7yngrygYrX
         dWqQ==
X-Gm-Message-State: AOJu0YzKdhQP4gzB6cFCg5b7EMScXUZ9yYyS6i21OyYNsSRDFsqrm84B
	I1Rb2JRGceZfT93uY1UyeQ7OY2SdC3DH8oXKmNw=
X-Google-Smtp-Source: AGHT+IGV9WLPuMXKi0Vbgm70R8j+bSkmHafpkKxqf6u31ilHScPgFRoWafpi6OVIQX3HQmXo9PxPT49v8PnjBlEELgk=
X-Received: by 2002:a5d:453a:0:b0:336:9689:bc70 with SMTP id
 j26-20020a5d453a000000b003369689bc70mr78104wra.44.1704848829109; Tue, 09 Jan
 2024 17:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103185403.610641-1-brho@google.com> <20240103185403.610641-3-brho@google.com>
 <ZZa1668ft4Npd1DA@krava> <f3dd9d80-3fab-4676-b589-1d4667431287@linux.dev>
 <e5e52e0a-7494-47bb-8a6a-9819b0c93bd8@google.com> <781a86b1-c02b-4bb8-bc79-bfbd4f2ff146@google.com>
In-Reply-To: <781a86b1-c02b-4bb8-bc79-bfbd4f2ff146@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jan 2024 17:06:57 -0800
Message-ID: <CAADnVQ+BOBh-XnsCPWHUCkwhAe41TxPRm9Nqi2r39WnJh3iF6g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add inline assembly
 helpers to access array elements
To: Barret Rhoden <brho@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:02=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 1/4/24 16:30, Barret Rhoden wrote:
> [snip]
> >>
> >> The LLVM bpf backend has made some improvement to handle the case like
> >>    r1 =3D ...
> >>    r2 =3D r1 + 1
> >>    if (r2 < num) ...
> >>    using r1
> >> by preventing generating the above code pattern.
> >>
> >> The implementation is a pattern matching style so surely it won't be
> >> able to cover all cases.
> >>
> >> Do you have specific examples which has verification failure due to
> >> false array out of bound access?
> >
> [ snip ]
>
> >
> > I'll play around and see if I can come up with a selftest that can run
> > into any of these "you did the check, but threw the check away" scenari=
os.
>
> I got an example for this, and will include it in my next patch version,
> which I'll CC you on.
>
> If we can get the compiler to spill the register r1 to the stack (L11 in
> the asm below), it might spill it before doing the bounds check.  Then
> it checks the register (L12), but the verifier doesn't know that applies
> to the stack variable too.  Later, we refill r1 from the stack (L21).

This is a known issue.
It's addressed as part of Maxim's series:
https://patchwork.kernel.org/user/todo/netdevbpf/?series=3D815208

