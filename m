Return-Path: <bpf+bounces-68198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DBB53E67
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7311B1C216E3
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDF329F05;
	Thu, 11 Sep 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjMFA84z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D02D24B9
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628050; cv=none; b=snK96xb0QbSsfyQA0SMG++8m5It92bb9wBXfWLvXOMxXI4C1krrNlI+aGY3HzspqJfxICD/vuOT1Aseuxhn8QTwWC35gG+Br7aGO/YL6+GMv67RImS0RYOkkp/8+FcF+GgPxm2mFqEiD13H8B2Q0tNNuoTHCqEM39GvTHA/mu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628050; c=relaxed/simple;
	bh=AyIdQ9L9OeyX521nrdHbDt4oVSqD3xS+WzZJNAQawIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZboFOYjkXQRfjXdQD8WnMYIrpCpOdyBcd2ba61+KzfpABaSa2TBtzT5uiWV+R4tRNHjwnof+GZzfhuG3pyD7yOi42psELGv7NfZP3aXV9jZ97gAZ2phNhtigc6ARqHjwC6J7aOp5ZunHhQoEwRJ4xYVjsnPzI8CaMrsBgsRRF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjMFA84z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dde353b47so7739325e9.3
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757628047; x=1758232847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNGC3S96f0iYG7S7yObvSZ6IO9c4scAuRn29A95dofY=;
        b=BjMFA84zKLOtvz6GW9NToHUhBSWWN+kFID5qMX8GG7TiRMMX7/xrg2sbmuZUboJ/vh
         817dks+9YRYAP29cd5EXW6uLcU9X3gXXKOz/i2wIwz7+Y1B5DwNk3bLktjsu2BG/1tL5
         smlOuoK7gJX0MvLaSmpSIdn1n+/+1l51zhkrlrhAZgCeU0+YZYR1tu5bUn0570TEKlVP
         3gP6zyrqCH8NuhkOcI9Rbtq2ACVV/M73nIH/VQ1yY3Xgm35BXyVfiuwAvZ0Ccit3+Ypm
         T0ctu6G9vso+oxl70X+FT3h8YmtUlgipmMldDqtJasjYygagMOdfEzyTbNK3eai15YAT
         7myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757628047; x=1758232847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNGC3S96f0iYG7S7yObvSZ6IO9c4scAuRn29A95dofY=;
        b=T+OsDxd5pWb4YEH2HmfAcUYZAJEYt4pdkT5hVYgH6Vy+0dzdC6s2DYGy9iB2Ae/fCy
         Q8JJ6clfcC3EkPJ5OxhAuBLXkamulcW0AGiI0Uea3nNuMQvAMUKM+5YZBXK0RAAuRasD
         3zkmhm/KAngPpbodudGZvL4UMY3JsD9pvWxt+T56IcX768Am4yyy0bkcrGpQZ9XnP8W6
         kSPdJj1t2n7NTsnccEdkFNrhb5mEpVnJOoP7zzH9I5EGswd23nxhHOparGXkudpI68Sl
         cCKgqmtnm3dCcY1llHPWvjOjTUhc7IRIHp6RzxflxJI5Bl3+VdpKe45JKd61qnTHD8K6
         KJIw==
X-Forwarded-Encrypted: i=1; AJvYcCXfJTV1cGofZzkp3Q7RvPaRrbOKyoQVayoHnXPkZ4YVdz3pJwibYQaN9zN9oYKwHlxihxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzD2b8Xv4tK+tlgfOO7zZMCO1oYdIJF9fDuV+317hCvsMpswJ
	ruS4cp0IM4b3I/yOZZB5HCsNUjen2fjrZ/26TukMqZ3KKo5cMEq+O5RZ/Zf2RQjM4wtERUOGsj6
	3dMFZxAMblb/PEq1e68JZ6ElVSUZhvvc=
X-Gm-Gg: ASbGncv9cFI/U8dstTqrJJxnQyTQbfpUDLPgfBz/bDFqNrSYY2ujKbnATgoK0q3yK6P
	EuqEe79u3GjNd6mk/M0EYCQB7ykb8lKWfF09+FDD/Vl1HocjZZo/THCyGC8JNpnb/7XRLjuJWML
	75CIOx8DckLjiK0MeyQ9hAupFHrh3PpCG8Pxr9O1lbSfR4Hg7772i19bEYL9WzJci57P9RPsOzO
	rnpCfOfKQoAdZPwdGVtCLm0xW+0jptge3Xz
X-Google-Smtp-Source: AGHT+IGhOSWpHlpALI/lzdPz72vgmRbcHanf8h6jJsn15Xo09fd25S6ynV6BBaXIb+2CIIQV9R9kuhRlge27S6C19mw=
X-Received: by 2002:a05:6000:4023:b0:3c9:3f46:70eb with SMTP id
 ffacd0b85a97d-3e7659f3b84mr741021f8f.52.1757628046755; Thu, 11 Sep 2025
 15:00:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911010437.2779173-10-eddyz87@gmail.com> <202509112112.wkWw6wJW-lkp@intel.com>
 <c846a153010e40a52e98b8abe9db69f7d4cadd58.camel@gmail.com>
In-Reply-To: <c846a153010e40a52e98b8abe9db69f7d4cadd58.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Sep 2025 15:00:35 -0700
X-Gm-Features: AS18NWAAMoGo6ybHHipSr8Dg7OeGrogyD5EPk8l-wM51YPkXTYDAOkyqXPipa6c
Message-ID: <CAADnVQKGwghC=+V8u0tSPdkJ1f4usY5LeYUpxnJno=3xW8tYGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 09/10] bpf: disable and remove registers chain
 based liveness
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, oe-kbuild-all@lists.linux.dev, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-09-11 at 22:19 +0800, kernel test robot wrote:
> > Hi Eduard,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on bpf-next/master]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman=
/bpf-bpf_verifier_state-cleaned-flag-instead-of-REG_LIVE_DONE/20250911-0906=
04
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.gi=
t master
> > patch link:    https://lore.kernel.org/r/20250911010437.2779173-10-eddy=
z87%40gmail.com
> > patch subject: [PATCH bpf-next v1 09/10] bpf: disable and remove regist=
ers chain based liveness
> > config: x86_64-buildonly-randconfig-003-20250911 (https://download.01.o=
rg/0day-ci/archive/20250911/202509112112.wkWw6wJW-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87=
f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250911/202509112112.wkWw6wJW-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202509112112.wkWw6wJW-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > > > kernel/bpf/verifier.c:19305:11: warning: variable 'err' is uninitia=
lized when used here [-Wuninitialized]
> >     19305 |                                 err =3D err ? : push_jmp_hi=
story(env, cur, 0, 0);
> >           |                                       ^~~
> >    kernel/bpf/verifier.c:19140:12: note: initialize the variable 'err' =
to silence this warning
> >     19140 |         int n, err, states_cnt =3D 0;
> >           |                   ^
> >           |                    =3D 0
> >    1 warning generated.
> >
> >
> > vim +/err +19305 kernel/bpf/verifier.c
>
> This was sloppy on my side, should look as follows:
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19297,9 +19297,12 @@ static int is_state_visited(struct bpf_verifier_=
env *env, int insn_idx)
>                          * the precision needs to be propagated back in
>                          * the current state.
>                          */
> -                       if (is_jmp_point(env, env->insn_idx))
> -                               err =3D err ? : push_jmp_history(env, cur=
, 0, 0);
> -                       err =3D err ? : propagate_precision(env, &sl->sta=
te, cur, NULL);
> +                       if (is_jmp_point(env, env->insn_idx)) {
> +                               err =3D push_jmp_history(env, cur, 0, 0);
> +                               if (err)
> +                                       return err;
> +                       }
> +                       err =3D propagate_precision(env, &sl->state, cur,=
 NULL);

hmm. init err=3D0 instead and avoid explicit if (err)return err ?

