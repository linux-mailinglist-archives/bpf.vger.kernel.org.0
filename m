Return-Path: <bpf+bounces-17690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC0811B5C
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8856282A09
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733E5786D;
	Wed, 13 Dec 2023 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmvWTQn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA399
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:39:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1f5cb80a91so817514666b.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489154; x=1703093954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEe82Zfea4hXicolwmWQp7Qyt3znNGTt7BposGSmn1M=;
        b=WmvWTQn9az8qwbJVcI1occeAQ1/fFhQRvvM/JyBfRDPWEt7VXfELXvpOk+ePVnZxfp
         dDPNHny7X3l/EomkrkAdVjrlPT4oNQk33HelONC9sXX7u2X2kTCNtozRd92w0lVwyfJ/
         viTpHiCbriWNCrc4/i08KF+aXAtc9dVxkd2Sx+LAYp1Npf+HT1VjLMObfhco+2W8DItd
         OrqVEWRKRjyg/2X8L3jez0InQeYoEMkWS39HHCuZcmlzn4XwQrs55rgcG1Kd3265MKNp
         rYBrYEpvsvnRcBA9qfTkhQkmOzsGaMbPMe+ksZYxm2fVdUgTDlbPzWZS/+LcdUHfv9gH
         8qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489154; x=1703093954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEe82Zfea4hXicolwmWQp7Qyt3znNGTt7BposGSmn1M=;
        b=aZC75ixE7wNNMaC23azkSKnue1/7Q/9/u5dB+HhL6XOO3ZVnKojt3tAmeXtrQ1HGmg
         e+5fqbeMYfXTVs8NihM47H5juA355L2nQe9XUypGBZ3s1YvwTozMRZuUPawvTDcP/GMy
         atOloqPQEsmnCGsvG6B6eX+LxjDx1UKiLQhii5YdIitYwgrOLbNfIpjm1wxuNMQ3V2xD
         5v+H1PGdp3ambvXRlDUx1ig+67oSaxPR/L66ZJTDzzGhvysV/b9qRjZkHFt6Yr8Y+5C6
         cQ7qL20z//suj1APYkc6ZvN5YcOgCGn9rPswpmmn0cTe6ClDPVpO0YZV6Eg1qduC5oIu
         R4Cg==
X-Gm-Message-State: AOJu0YySR32jBKj969c8tA1niJAVY0/1G8KM45qXgEPhiwfwZG980nfB
	t2XdBdOu0aqP49GitJM1FMqPf3mlTExFTIGOuDE=
X-Google-Smtp-Source: AGHT+IHBJP9ZZwRmLvMBdjSd94Fl3YxT8mKBrpCK8cPVpxJycyTcE44tmwl75B186VfySPad9i2z4AZqLr8sAlVtMA4=
X-Received: by 2002:a17:906:74d1:b0:a19:a19b:4239 with SMTP id
 z17-20020a17090674d100b00a19a19b4239mr2826515ejl.164.1702489153918; Wed, 13
 Dec 2023 09:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212182547.1873811-1-andrii@kernel.org> <20231212182547.1873811-7-andrii@kernel.org>
 <btj4ywppyvxwmcrvadvbowxug4nktyxjjwnuq2iumrhuyoubn2@z65goyjwwcg2>
In-Reply-To: <btj4ywppyvxwmcrvadvbowxug4nktyxjjwnuq2iumrhuyoubn2@z65goyjwwcg2>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 09:39:01 -0800
Message-ID: <CAEf4BzYQd0Kgr2Q9kHxqbUo41Eo3E9xO8pHffc6KVFn=m4dpiQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/8] libbpf: wire up BPF token support at BPF
 object level
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 10:25:45AM -0800, Andrii Nakryiko wrote:
> > Add BPF token support to BPF object-level functionality.
> >
> > BPF token is supported by BPF object logic either as an explicitly
> > provided BPF token from outside (through BPF FS path or explicit BPF
> > token FD), or implicitly (unless prevented through
> > bpf_object_open_opts).
> >
> > Implicit mode is assumed to be the most common one for user namespaced
> > unprivileged workloads. The assumption is that privileged container
> > manager sets up default BPF FS mount point at /sys/fs/bpf with BPF toke=
n
> > delegation options (delegate_{cmds,maps,progs,attachs} mount options).
> > BPF object during loading will attempt to create BPF token from
> > /sys/fs/bpf location, and pass it for all relevant operations
> > (currently, map creation, BTF load, and program load).
> >
> > In this implicit mode, if BPF token creation fails due to whatever
> > reason (BPF FS is not mounted, or kernel doesn't support BPF token,
> > etc), this is not considered an error. BPF object loading sequence will
> > proceed with no BPF token.
> >
> > In explicit BPF token mode, user provides explicitly either custom BPF
> > FS mount point path or creates BPF token on their own and just passes
> > token FD directly. In such case, BPF object will either dup() token FD
> > (to not require caller to hold onto it for entire duration of BPF objec=
t
> > lifetime) or will attempt to create BPF token from provided BPF FS
> > location. If BPF token creation fails, that is considered a critical
> > error and BPF object load fails with an error.
> >
> > Libbpf provides a way to disable implicit BPF token creation, if it
> > causes any troubles (BPF token is designed to be completely optional an=
d
> > shouldn't cause any problems even if provided, but in the world of BPF
> > LSM, custom security logic can be installed that might change outcome
> > dependin on the presence of BPF token). To disable libbpf's default BPF
> > token creation behavior user should provide either invalid BPF token FD
> > (negative), or empty bpf_token_path option.
>
> Have you considered an external (to the application) way to provide bpffs=
 path
> and enable/disable implicit mode?
> Since libbpf is trying to provide the seamless use of token (just recompi=
ling
> with new libbpf and admin setup) it seems the admin should be able to pic=
k
> the location as well. envvar would be one way.

I haven't considered this yet, but I see the point. I can define a
LIBBPF_BPF_TOKEN_PATH envvar which will be used if the user didn't
explicitly provide a path or token fd through bpf_object_open_opts.
Enable/disable semantics will be the same as
bpf_object_open_opts->bpf_token_path: unset - default value, empty -
disable, otherwise it will point to BPF FS location.

I'll add it as a separate patch in the next revision.

