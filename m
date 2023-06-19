Return-Path: <bpf+bounces-2841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81273559B
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 13:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FD61C20983
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 11:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9622D2F1;
	Mon, 19 Jun 2023 11:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80873C146
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 11:20:34 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CFDF9
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:20:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b4fef08cfdso14717265ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687173632; x=1689765632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHwcK4+G1+pHJr/AemM31vH7TcoiQYXrJjZnbqSfWkU=;
        b=b2x+MiU0PNvIKQ+guvqmHOmI9F6CAu+aBiwIh+pcKMDRkv5FSecZnrBIhRQxGQVxgr
         8jqozfaP6xvU6hamhUGx4GUfkighFMxNE29OAp+uEkAGPE51+JZ2kiA9LRbssoyd2dmH
         WvWSYb24P+BcJZWxR8dSv7bAiOgWqJ3Xp0yvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687173632; x=1689765632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHwcK4+G1+pHJr/AemM31vH7TcoiQYXrJjZnbqSfWkU=;
        b=kML9lDzaTJDnoziBUcvSwgbJFpKtTPxYt/s2TCFP1izN4aF5ez19PPDeqXBmtbhwbZ
         FpoyMnWRdK/3jNrWSvgtwRRqGERSpZp7hxs897Vk2PvagcuqupLAgcvIzn+XbM3tyemF
         ra99tSu4xeYxbsIAhPnBjoRMEtrE3CYD+nsScKWXIhwc6WDwOT9ewesLuB/zLDsLS9fZ
         dX2xcoWJCwQQLCZpQ7sQW7QV03GCuR3mS3UT2s7N2rLkWuJerFYzHMAeRmrrAhfI9CUv
         JN8021oCNqN/aMPlcMys8jWksxxCVp/1YzGsmtSNMFvwRFGMAWP1wtu2ueX5EEZjLgra
         al1A==
X-Gm-Message-State: AC+VfDx/+HfNWUqM+5Mu2r9YDU5D3iDDzZpa12+Rk6hWuccgAZfTBkL4
	yX06704H0ntotbg16IK4ux+mtPM7TYHNAzW0Ep6ung==
X-Google-Smtp-Source: ACHHUZ4RzEz4p8yr6qGhmElkBhQ6Fs4KdBjLaQWqTw2kN8Qcn172fmQXOI9Utd/vo5KAF+1+6ZMSSY7q/0kiO1LHPJA=
X-Received: by 2002:a17:903:234b:b0:1b5:42fe:5eac with SMTP id
 c11-20020a170903234b00b001b542fe5eacmr2783982plh.10.1687173632019; Mon, 19
 Jun 2023 04:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615145607.3469985-1-revest@chromium.org> <CABRcYm+C+tPwXAGnaDRR_U2hzyt+09fjkKBp3tPx6iKT4wBE2Q@mail.gmail.com>
 <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
In-Reply-To: <fbd79f5f2b250ec913c78d91b94ca96fb96f67ee.camel@gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Mon, 19 Jun 2023 13:20:20 +0200
Message-ID: <CABRcYmLaummOg=Nf0qXVN2eci=25OqXLD0zpCUz4CgmTjvo9LA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 7:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-06-15 at 17:44 +0200, Florent Revest wrote:
> > An easy reproducer is:
> >
> > $ touch pwet.c
> >
> > $ clang -g -fsanitize=3Dkernel-address -c -o pwet.o pwet.c
> > $ llvm-dwarfdump pwet.o | grep module_ctor
> >
> > $ clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o pwet.o =
pwet.c
> > $ llvm-dwarfdump pwet.o | grep module_ctor
> >                 DW_AT_name      ("asan.module_ctor")
>
> Interestingly, I am unable to reproduce it using either
> clang version 14.0.0-1ubuntu1 or clang main (bd66f4b1da30).

Somehow, I didn't think of trying other clang versions! Thanks, that's
a good point Eduard. :)

I also can't reproduce it on a 14x build.

However, I seem to be able to reproduce it on main:

  git clone https://github.com/llvm/llvm-project.git
  mkdir llvm-project/build
  cd llvm-project/build
  git checkout bd66f4b1da30
  cmake -DLLVM_ENABLE_PROJECTS=3Dclang -DCMAKE_BUILD_TYPE=3DRelease -G
"Unix Makefiles" ../llvm
  make -j $(nproc)

  bin/clang -fno-integrated-as -g -fsanitize=3Dkernel-address -c -o
~/pwet.o ~/pwet.c
  bin/llvm-dwarfdump ~/pwet.o | grep module_ctor
  # Shows module_ctor

I started a bisection, hopefully that will point to something interesting

