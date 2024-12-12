Return-Path: <bpf+bounces-46730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993B69EFC6D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 20:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E62B16DE8A
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 19:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF3198E7B;
	Thu, 12 Dec 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js+zoUjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460C0168497
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734031592; cv=none; b=hNzP+TiASh4JN5y9ndSCbUa8YvGrU5Ug63oyyXKIRMzFX90XR+UZkN+QSxKRFAqMtLPW1gCuOF6sZp6SZRfEktKZnFcwz8nJMiu9KMrvpJHWn5Q/dd2uQZxn0vZW5MzDLU4iFAjVJtkq8ayY26LV07pjHWSiHk2w/SVwWIlflRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734031592; c=relaxed/simple;
	bh=kEd2tOIfD5RKkPHXivIBiLmzg5KGCSwDrDKlyRlw+RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6QG5Lywy5XXfwKbzZylpey0ZXSWHZ0nZodqBl8cUr1WvEuRrFIV/uC2iT/RLRcmibs0K+i4VUbMYhdEzKr5nwRf0QMlAM1zTpfx0AqmrMODMiJD7yAkl6THrTTJGTcDOLWj9YmopBasrQMqak8E2QbXWTolEwrfV0h2f3RzeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js+zoUjd; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso643517a91.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 11:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734031590; x=1734636390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBCrMyjxmEbmVDxGeE1f4I8UZ46QyNKDTwuYf2auiv8=;
        b=js+zoUjdrGjXuc/zCPYAq9kzWTZ2dV/8Sx61yAAggvOufY3n4kYOyYmSsiR87oy5L7
         HACpkfz/GYMm4PrSRQqDJHEobK0Cz1ZS/uUowOfUwLTs5xftDEjVrqK96k1llbUefujC
         SPegIg3TEyyPI6zaaqGwmq8piCuETagiyGuoOEJQvT2bF3oMZnv5AaAbqs0VheWEgUVn
         DT9+m5QJx0xYqEzgPv2B2K/Xd8ueyH6/iwU+Q3CBUs8xAl2rxoi0+Ts3ivu06zea3miQ
         Z5SOWA0S0L+8dh9eFLhgvyVXF1LaqYmt17BXJO8gTuTduvTGeKXNy6pWVGV8avhiGkDE
         ldFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734031590; x=1734636390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBCrMyjxmEbmVDxGeE1f4I8UZ46QyNKDTwuYf2auiv8=;
        b=ok8BfYMtwFg5a0addoiAX47+SVfYFL2XQaPdDeSvs5IjflRui74LjMBsB+Yd4sjUie
         zLlL8os0SnQXAQlmST4RsvUE2viTjeMwThUzOlPi0x9WraLWspc08GZl+2FCPquiuokj
         m678BA/8x3UyhlmHj2fMBkQTvudIqvklSVwoITynRyHpRcvNKkKNKdFtqR8qfIqDPhGk
         ddkJL1bkd33+Y0HGB9sFR4m2LXEWAIQgCxcPKh+dk4Tc8syUke8gNZRtW9KgP6GhSdVf
         Cb8LUQBmKvhTqH8WH37kRNqnm370I1bVGNYybEPia3chYyAVvCZ/2iX0Y+p5VGxEw7yL
         aGag==
X-Forwarded-Encrypted: i=1; AJvYcCWgJzZBipFq8bYusmCQkvlIdFIdgtuCUpuJSjCLTIzwK/q6QReefFNa9KY+qgoDEYlUjs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtP+faMHOrvueDK1K1grJB5tXHncb2XVmdyQF/TCyvFSdv0HVh
	EOkQMcpXTKD78qrI81Epy55XI06QELzw3Ijk+7MOeZBzb8V0g6JlVB7YsxQRD1v2xlluAg3P4Wr
	v52kC91a6XR1lx5bGNlTqk3CTYCU=
X-Gm-Gg: ASbGncuSyzB9/zLUMOBKCuNrRGj7HDvlPmTjTVVicQ4HrwZx7UQO4ruR/sR3mKdLEYv
	3sZaj+/JJDh9C8MwvVdpmpBJhbeiV2+yLPi9sePNszPocicygA2PU4w==
X-Google-Smtp-Source: AGHT+IEm1uvs3x0eR0QFugMoJCF2HMBDfEFYXvo5VNUXoxkj15mkvxX4hgmQfiKtyGRiS8M0vJMPqx0UwYbAxSjM1vk=
X-Received: by 2002:a17:90b:3510:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f13925b1e0mr7684325a91.8.1734031590540; Thu, 12 Dec 2024
 11:26:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-bpf-selftests-mod-compile-v5-1-b96231134a49@redhat.com>
 <173352303103.2814043.17875547914996700881.git-patchwork-notify@kernel.org> <CAP01T744hWcg5i6eShqCUnxVV4F+GJ5cwYN8qVkDVEhzs7ybOg@mail.gmail.com>
In-Reply-To: <CAP01T744hWcg5i6eShqCUnxVV4F+GJ5cwYN8qVkDVEhzs7ybOg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 11:26:18 -0800
Message-ID: <CAEf4BzY+no6bJN8shgOMH=oVKnT_4eWmBX4i1C38-93XGnpngQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Consolidate kernel modules
 into common directory
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, vmalik@redhat.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 7:03=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 6 Dec 2024 at 23:10, <patchwork-bot+netdevbpf@kernel.org> wrote:
> >
> > Hello:
> >
> > This patch was applied to bpf/bpf-next.git (master)
> > by Andrii Nakryiko <andrii@kernel.org>:
> >
> > On Wed, 04 Dec 2024 14:28:26 +0100 you wrote:
> > > The selftests build four kernel modules which use copy-pasted Makefil=
e
> > > targets. This is a bit messy, and doesn't scale so well when we add m=
ore
> > > modules, so let's consolidate these rules into a single rule generate=
d
> > > for each module name, and move the module sources into a single
> > > directory.
> > >
> > > To avoid parallel builds of the different modules stepping on each
> > > other's toes during the 'modpost' phase of the Kbuild 'make modules',
> > > the module files should really be a grouped target. However, make onl=
y
> > > added explicit support for grouped targets in version 4.3, which is
> > > newer than the minimum version supported by the kernel. However, make
> > > implicitly treats pattern matching rules with multiple targets as a
> > > grouped target, so we can work around this by turning the rule into a
> > > pattern matching target. We do this by replacing '.ko' with '%ko' in =
the
> > > targets with subst().
> > >
> > > [...]
>
> I don't have a good way to reproduce this yet, but I'm seeing
> intermittent failures after this patch when running vmtest.sh:
> make: *** No rule to make target 'test_kmods/bpf_testmod.h', needed by
> '/home/kkd/Projects/linux/tools/testing/selftests/bpf/core_reloc.test.o'.
> Stop.
>
> I haven't been able to root cause today, but I will probably try tomorrow=
.

You need `make clean` in selftests if you are switching between
versions of the kernel before and after this change. We record header
dependencies in *.test.d files, and this file changes the location of
bpf_testmod's header. Our makefile can't invalidate this
automatically. If you are switching between commits after this commit
is applied you shouldn't see this problem.

>
> >
> > Here is the summary with links:
> >   - [bpf-next,v5] selftests/bpf: Consolidate kernel modules into common=
 directory
> >     https://git.kernel.org/bpf/bpf-next/c/d6212d82bf26
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
> >

