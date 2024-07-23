Return-Path: <bpf+bounces-35330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB093980A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0D21C219E1
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E2137742;
	Tue, 23 Jul 2024 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LehN6+uK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F9EC2
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699370; cv=none; b=dQGxqqsygdUGWMnqEsYUt98TFn+Jx+4rjr8A898cqsmuHAeXLYINSYTeiDEULVHgxyfKDFWN2oVqzIuZvn1uTZtOjDfY+JcH9MlT3pQyUzwCiaLCZ2/Lt5Cn8rYJDbFST7OR/4VxGwSDXgkf0pFAU7cfMgyUggzplr85sErrNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699370; c=relaxed/simple;
	bh=T6bc7yO037YlI0gtSLtKXEgEKutuSd34PXCoLEqQEEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0G0k9e2Y/mKD87Up3f4HJra/AEWgTBW1NYIMI/33rYHWhOiEmvbRZDeogIrDwhvHeQm/4mt0t1XlvLMgC91padGWZk4iY1+lLWdWZxTgU2icZnbc0l96SoSccu0yvEUSkKc16wepr3TVEcA8MmyBg//95nXDYAfwgSVsqqWnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LehN6+uK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a211a272c2so210341a12.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721699369; x=1722304169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7b0MxVkJHFxielChzwbd9gWsZFov4mN5NPvuXIAM0Ms=;
        b=LehN6+uKB/FAQu+VhL1Jg4y1iSrdAGviSXqvIdwkIuVhnsXIvBkO3i2vWAxV1oLKkW
         U76aRaKbomr7zpE6uOAQvz8YkBhQZL2u/ivtK6Ci5Rb2nREjL78SA4WcOGz6O40LDhaQ
         302dW7Yclt4mAL1Xc/HKR3Rhnp3KG+AkaPlyVlJlq8aaBPU3ADaTtG4LTQG9nfcFkD1l
         ASU67doldvUJg2NKOqQslvlhFvhWpvpG+4Z5ypga+H5Bu2Penf8X1Y4EdtEwQJEtA0u/
         ofsGUKCwt7zHLnnXQFLzVr9u69Y7+N6gMLIyV8CUbgxe6OvWFFL/Fdfxhybs74Yb230H
         njSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721699369; x=1722304169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7b0MxVkJHFxielChzwbd9gWsZFov4mN5NPvuXIAM0Ms=;
        b=aRAdTWhTgT/s/TKVoa3ArzzOtYcf1vl+CZT5MO12fVFYjzAJGg3AdoFJfJrdvDbj+l
         4gnrTRHJVmEx1G3JqwOppggJUeGCHFWczokhX6jtyXaGtHc94s878Q2BG5HckLyKZ61W
         +Pxnw04ZS0vjJjYFPXnMoPdFZUV7s46Dct9ukWAej/8rPCj/57fPezkAHy8gTawjc3iP
         fRaZi2Hmp6a6vuLUHvzppNT1pXcMZfer/L9eYGaps76czyFR62RjhxrU2RAsgapu+9aV
         F+6RwJP5PTP0vmjpY4iYnyCCn057EAyYDDjR4hJeDa69qhtjinIsrYEnxkbt16/6aWwf
         vvmg==
X-Forwarded-Encrypted: i=1; AJvYcCXFtbuTdvWIypGxDx/pjnICK0xlIK4tbQqQfr4eony7Y78TpIOi/lkNmU0yOH/qFb/PaUZchhc1O8YFxTXrQYpq++KS
X-Gm-Message-State: AOJu0YzIfjo4QhXTDJYkuKIyQbCEkOIjC0C9DaC/+iHCq/tJJEQQxxFY
	yz+2pCCIP1NS2SVoHzBqHi/yM+sDYMFuMZZzvZYtSth3akva0TQG
X-Google-Smtp-Source: AGHT+IEqiF/Dwck/7l2xwKlBE7vC6wV1VR/Z09aIpF40cMw4nrZMHUkaM75TDqVKnpwUAtLZWqBpbQ==
X-Received: by 2002:a17:902:fb4f:b0:1fb:4f57:6a65 with SMTP id d9443c01a7336-1fdb95d467bmr8019565ad.30.1721699368597;
        Mon, 22 Jul 2024 18:49:28 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28c002sm62402745ad.70.2024.07.22.18.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:49:28 -0700 (PDT)
Message-ID: <8299cc3bf49a1a43de6e453d57733bf4549435b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Date: Mon, 22 Jul 2024 18:49:23 -0700
In-Reply-To: <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
References: 
	<VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
	 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
	 <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com>
	 <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 17:57 -0700, Eduard Zingerman wrote:
> On Mon, 2024-07-22 at 17:39 -0700, Alexei Starovoitov wrote:
>=20
> [...]
>=20
> > Andrii, Ihor,
> >=20
> > not sure what happened, but 'make clean' now takes forever.
> > Pls take a look.
>=20
> It happens under certain conditions, here is a scenario that behaves
> badly for me:
> - two branches:
>   - 'master' at cca09a371fa7
>   - 'tmp' with [0] applied on top of master
> - Steps to repro:
>=20
>     # cd selftests directory
>     $ git checkout tmp
>     $ git clean -xfd .      # be careful
>     $ make -j test_progs
>     $ git checkout master
>     $ make clean
>    =20
> After which output looks as follows:
>=20
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs] access_map_in_map.skel.h
>   CLNG-BPF [test_maps] arena_atomics.bpf.o
>   GEN-SKEL [test_progs] arena_atomics.skel.h
>   ...
>=20
> [0] https://lore.kernel.org/bpf/20240719110059.797546-1-xukuohai@huaweicl=
oud.com/

Here is a funny part.
The switch from 'tmp' to 'master' touches a number of prog_tests/*.c files.
The output of 'make --debug=3Dbasic clean' is:

    Reading makefiles...
    Updating makefiles....
      CLNG-BPF [test_maps] access_map_in_map.bpf.o
      GEN-SKEL [test_progs] access_map_in_map.skel.h

There are .test.d files after test_progs build for tmp.
Because of the include directive:

    include $(wildcard $(TRUNNER_TEST_OBJS:.o=3D.d))

and a dependency:

    $(TRUNNER_TEST_OBJS:.o=3D.d): $(TRUNNER_OUTPUT)/%.test.d:			\
			    $(TRUNNER_TESTS_DIR)/%.c			\
			    ...

make goes ahead and detects that these .test.d files are now outdated.
So, before executing 'clean' recipe it executes recipes to update
.test.d files.


