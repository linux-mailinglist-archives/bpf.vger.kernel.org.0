Return-Path: <bpf+bounces-16178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6497FDF18
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244701C20D8F
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 18:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C977713ADC;
	Wed, 29 Nov 2023 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0g9Ek8y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E767B9
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 10:10:37 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4b2870c9c75so363081e0c.2
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701281436; x=1701886236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGsTyO5iusWS4AgX6Yc8aGP99L+WR6/erISb1DToS1w=;
        b=l0g9Ek8yGw2aa0vsRNmHz7Jr4nWL3iHQUiOzCj39ca4Xcp6sPo20L3AUGTzbC/XGT8
         sFurZGiFSPiZb3+hLLIo+mSVllxFBadzoXbUIGpf5Uq2/zqeiVLi45DxU3KUTsUUwbhd
         B9ssK3T1Pn0u3doueq5fHYpO+axY9XQBRV8iIgT/I6MUMx55L8vmcotcQvNg2wAU9WCG
         k8jZoSvSueTr+3EsGWIEJeuO3J6NJOlNI0d4Rj6GGs0VXPHiudvCgVJFt/FHHcmV5lN9
         qh37m2bBVVHCA7jWbSKOZi9ExSZR7LqCM8PN+K/mrC5SSxAAQypOqhCMxL90JTmvvoh0
         MdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281436; x=1701886236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGsTyO5iusWS4AgX6Yc8aGP99L+WR6/erISb1DToS1w=;
        b=ewPcnQevYkOg9UYVydwVsWpcVcHQx/vsSMwCdML3tbxwS/mwebQaWednhomNL3qQmo
         5bDVi/eymA2PdXN8XDgCrLcdYsCtJ39RJf194m8W0PrZ89O03+twiYGKFuSCwpRUbHSD
         jc/1reJcroD4Gnufwfgczx2Ww3ze7xP86SAdLRwP4eiudQ9sHtxD3HSCSuZ/olSWZoRf
         l9loTJFE+d+ZX37WNDHBENkyZ5cCQk+PP2YkLBIHamk380oavMPylmRTrvn454xDYL2s
         G/FaFf/Veyy95uCl4RuMTkTAwOxSDNaw6GQjy1a/XJ8wnAEDuUvt6fMHmkGdTIoKANsN
         LI+g==
X-Gm-Message-State: AOJu0Yyl9WtomFOiaMBl+9jUpIBomEIXkLMFoT26KvuBJcQ3YPX0b9rL
	ahYpjKvVnZEhAPn9a2QX7od6Au4m5ZW1vCxxeRWY+w==
X-Google-Smtp-Source: AGHT+IFlCyPNezOhhVLRLPVKhlIOVNetkGdV4XTtvFSwG0xVDzZ9BozcyBvMMbq0uzb5R4u2jF262SlGK6ynoesdetU=
X-Received: by 2002:a1f:c8c5:0:b0:4b2:8a1f:6bf3 with SMTP id
 y188-20020a1fc8c5000000b004b28a1f6bf3mr2148115vkf.8.1701281436025; Wed, 29
 Nov 2023 10:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128092850.1545199-1-jolsa@kernel.org> <20231128092850.1545199-2-jolsa@kernel.org>
 <ZWZafkt97qhgHynh@google.com> <ZWdFIUSXcZnCWax-@krava> <ZWdQywF4QnrnTc5P@krava>
In-Reply-To: <ZWdQywF4QnrnTc5P@krava>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 29 Nov 2023 10:10:22 -0800
Message-ID: <CAKH8qBuz4XGfg+w7oitF9p_kW-+ycgwEoUTF8vw36u1-A_qnLg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf 1/2] bpf: Add checkip argument to bpf_arch_text_poke
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Hao Luo <haoluo@google.com>, Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:55=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Nov 29, 2023 at 03:05:21PM +0100, Jiri Olsa wrote:
> > On Tue, Nov 28, 2023 at 01:24:14PM -0800, Stanislav Fomichev wrote:
> > > On 11/28, Jiri Olsa wrote:
> > > > We need to be able to skip ip address check for caller in following
> > > > changes. Adding checkip argument to allow that.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> > > >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> > > >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> > > >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> > > >  include/linux/bpf.h             |  2 +-
> > > >  kernel/bpf/arraymap.c           |  8 ++++----
> > > >  kernel/bpf/core.c               |  2 +-
> > > >  kernel/bpf/trampoline.c         | 12 ++++++------
> > > >  8 files changed, 32 insertions(+), 27 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit=
_comp.c
> > > > index 7d4af64e3982..b52549d18730 100644
> > > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > > @@ -2167,7 +2167,8 @@ static int gen_branch_or_nop(enum aarch64_ins=
n_branch_type type, void *ip,
> > > >   * locations during the patching process, making the patching proc=
ess easier.
> > > >   */
> > > >  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type poke_type=
,
> > > > -                void *old_addr, void *new_addr)
> > > > +                void *old_addr, void *new_addr,
> > >
> > > [..]
> > >
> > > > +                bool checkip __maybe_unused)
> > >
> > > Any idea why only riscv and x86 do this check?
> >
> > so arm does the check as well, but needs the data from the lookup
> > to patch things properly.. but IIUC it does not suffer the same
> > issue because it does not implement direct tail calls [1] which
> > is used only on x86
> >
> > >
> > > Asking because maybe it makes sense to move this check into some
> > > new generic bpf_text_poke and call it in the places where you current=
ly
> > > call checkip=3Dtrue (and keep using bpf_arch_text_poke for checkip=3D=
false
> > > case).
> > >
> > > (don't see any issues with the current approach btw, just interested.=
.)
> >
> > I tried to add new function for that, but it did not look good for arm
> > because it needs to do the lookup anyway
> >
> > hm maybe we could use new arch function that would cover the single
> > tail call 'text poke' update in prog_array_map_poke_run and would be
> > implemented only on x86 ... using __bpf_arch_text_poke directly
>
> looks like below change would be enough, I'll test and send new version

sg. I'm still not 100% sure why it's x86 only, I was (probably
wrongly?) assuming that at least arm64 jit is mostly on par with x86
:-)

