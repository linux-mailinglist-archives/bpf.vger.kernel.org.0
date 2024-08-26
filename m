Return-Path: <bpf+bounces-38094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8795F917
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2671F24E98
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603F8198A17;
	Mon, 26 Aug 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWTLl6Vb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDE2A1D8;
	Mon, 26 Aug 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697765; cv=none; b=WGYaHt+JldpLyZ8DMbqokdIOy8+T0J6B2vGQGvqaQwSo21fTPU/s2vL40RpZX8c6jAsAegWlUSWvjiWmsHyEUeWukcdJAAdeYL6ixp1wYnqXRegIUpJMStdhk/ocXTmTeMpG6grD8FDshsZRXPIZKqKnXC03asugmSSMWITonCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697765; c=relaxed/simple;
	bh=66rvfT30Rd9jNR9KSXQ9M+fDaZbae70XyRnCK42iEJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki16hoeFunPSUxbrg9NCO3v+oGEkp58LpVt07/QrnTMBN+akGd9uVejM+ONFHcPZlz1hkbz/YMVgBojLNcgBr6fZh44225aW/V9QU4oRRZBDy0ZmsJNU4lH0Ru3n7ingW68pHKs6HdAy648HHE4FziiJiN/ZN2XxgE7D0uLEx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWTLl6Vb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334adf7249so5561553e87.3;
        Mon, 26 Aug 2024 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724697762; x=1725302562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OstNSp6UvnPgh3gsd2W7iC/ZExy1qK76QgotQhDcUX4=;
        b=nWTLl6VbPh5Vi+ozOl0aWfPca8gK/4UE6W84mQZfN0gpJiMqYGFb0a1kPZ5oyNS6g4
         wOHxcyBzV81ms3kYIg9GX+fZukB/tb/03zCVXJuCUjyXkAtFfiMN5DTrVIilvB7/smuI
         hdESOfUvW8HefwfHCTj2cvwWXDjbSOsaY+K48RpN1ENjYx7RSVby24MiSsFal84TxQMP
         MzHXEYzs8mzykMoViDgvv0lawlDVDKR6/K3Lfts3A9orhx1PY1hsDFC2gpNdFKJ55Uub
         46z1GYHkUiXA7U0wuakvgQBb+r1U1VlSkDr1aqxk8NKeyyRcXXH2ZpJnpmkTBWhkwENE
         SpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724697762; x=1725302562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OstNSp6UvnPgh3gsd2W7iC/ZExy1qK76QgotQhDcUX4=;
        b=X7sWQa/PVEWi23Vqs5ZYTU9R/vB3XmvYSnw5YFQ1GkS2uA0o5FnS0+mVLemMinJtI5
         0szNWO6El8V3dhhmV+8jiOJuTkKpNOTMa7uYwfizC85y6U8GtczGMVMtHK4Sy3D2BPoo
         cJ/3pgq0I3gABqlQhF2h3t8uzKhMQT9ZfFN2rhtJljB2+756TlBJ38hSTLuD8IrgQpgn
         hrCPSKiSsCKDXgdpVSeHg/iUBUfXhLKIc99imC4WFNO9esZ6bdwhzTAV8VjUbKpN1/Ie
         gW+cqM+TA1l8/vzwMNhf3yCHLkxc9idCdRqn4D+DAqgBNV7Rjqsnt0riPie+i9OiLWJJ
         uCDg==
X-Forwarded-Encrypted: i=1; AJvYcCV4CVd9mEjq2ndDKY+2HYvK7lQ6Wd8+T8i62x2f3ckGdxOTLyi+uJVD9bU4LQ23WuM55rVZU9Zz0Dpy73se@vger.kernel.org, AJvYcCW3B5KmW1JGLrCc8Kb6AFff2F74mFU8+KX2vVZlKUG1HXBYnSst255bIjdjMigdWflPBLIa2X1zOw==@vger.kernel.org, AJvYcCX9sMaBpwdLYEvlPM0fEoGJtNhzw6YCZwvMSyLAUqrzWD55bVHrcS6H+lUrUNYM/rxY0TOWNtfNNrG6w8qT@vger.kernel.org, AJvYcCXd8K/n/Dsn60nbDz374p4q6oOk0aDbj5RaxLum4twsGcOWt222AKcHtjZqpdpcw3C+wCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx85jLkETPHHjYA0//UlEZcEUtOLAbj1C5ytmsSXP+ZLddaBRe+
	O1dJWXcHdj/YclXUsCc3y9B8ZRBYj9TW9YpX1fbyDqJ1PJ2IJlcQs08y6cuUgxeiObvPin8cCFk
	K1B7C26x2hps7KTnhWEjOS7s2JLA=
X-Google-Smtp-Source: AGHT+IE72x4d64Ak9GFyGpL4jDAfhYU2+Jx1i1fyhoAeuCz7ZrO3f1pKyzrpacY0uOb6zDsOzEtHaHUcIJStByIQ1ZI=
X-Received: by 2002:a05:6512:3a93:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5344e4fae12mr171802e87.42.1724697761812; Mon, 26 Aug 2024
 11:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820085950.200358-1-jirislaby@kernel.org> <ZsSpU5DqT3sRDzZy@krava>
 <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org> <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org> <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1> <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org> <Zsy1blxRL9VV9DRg@x1>
In-Reply-To: <Zsy1blxRL9VV9DRg@x1>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 26 Aug 2024 20:42:10 +0200
Message-ID: <CA+icZUWMxzAFtr8vsUUQ9OCR68K=F6d6MANx8HMTQntq494roA@mail.gmail.com>
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org, 
	Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
> > On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> > > I stumbled on this limitation as well when trying to build the kernel=
 on
> > > a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> > > created a swapfile and it managed to proceed, a bit slowly, but worke=
d
> > > as well.
> >
> > Here, it hits the VM space limit (3 G).
>
> right, in my case it was on a 64-bit system, so just not enough memory,
> not address space.
>
> > > Please let me know if what is in the 'next' branch of:
>
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>
> > > Works for you, that will be extra motivation to move it to the master
> > > branch and cut 1.28.
>
> > on 64bit (-j1):
> > * master: 3.706 GB
> > (* master + my changes: 3.559 GB)
> > * next: 3.157 GB
>
> > on 32bit:
> >  * master-j1: 2.445 GB
> >  * master-j16: 2.608 GB
> >  * master-j32: 2.811 GB
> >  * next-j1: 2.256 GB
> >  * next-j16: 2.401 GB
> >  * next-j32: 2.613 GB
> >
> > It's definitely better. So I think it could work now, if the thread cou=
nt
> > was limited to 1 on 32bit. As building with -j10, -j20 randomly fails o=
n
> > random machines (32bit processes only of course). Unlike -j1.
>
> Cool, I just merged a patch from Alan Maguire that should help with the
> parallel case, would be able to test it? It is in the 'next' branch:
>
> =E2=AC=A2[acme@toolbox pahole]$ git log --oneline -5
> f37212d1611673a2 (HEAD -> master) pahole: Teduce memory usage by smarter =
deleting of CUs
>

*R*edzce? memory usage ...

-Sedat-

> Excerpt of the above:
>
>     This leads to deleting ~90 CUs during parallel vmlinux BTF generation
>     versus deleting just 1 prior to this change.
>
> c7ec9200caa7d485 btf_encoder: Add "distilled_base" BTF feature to split B=
TF generation
> bc4e6a9adfc72758 pahole: Sync with libbpf-1.5
> 5e3ed3ec2947c69f pahole: Do --lang_exclude CU filtering earlier
> c46455bb0379fa38 dwarf_loader: Allow filtering CUs early in loading
> =E2=AC=A2[acme@toolbox pahole]$
>
> - Arnaldo
>

