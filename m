Return-Path: <bpf+bounces-10165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA847A24A7
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C70281F67
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DE15EA4;
	Fri, 15 Sep 2023 17:28:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA62125A1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:28:47 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C181BF2;
	Fri, 15 Sep 2023 10:28:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5029e4bfa22so3962797e87.3;
        Fri, 15 Sep 2023 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694798924; x=1695403724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbTOfXLq+M53K/FMFDrbAZVv5Nn1wG1Cp/nYwUS1YQQ=;
        b=adXUD0/ezwYufaLXAnEGn67Y6KGfJJZd7/Je6xLDrDS83DswRA9jKBhnigcqigWZ/z
         OxhWPqWgOaPW/cnxVIIwmsJ/gm1L/e9D503gwv5EoeGFYmGAdq/c1cub4Qik0uaebldD
         fEkhuDrqXyye5Rs2tIJc7Sq3MScYmEyHyzd4ubE/D4pHguGYJi/dDoy6xaUQeeqtiJgE
         uAZyO7sYNEcwL4+VIqkrt5FZ5Vu66UaBHvaOpvt3wISjiRhT/dq6QkEzSiNF1VXbkjaZ
         STZPHZDyKu8zZgVGYs3iTBcshnPmb+nrWN7C2w+2KRLBBijrOGNO7t4RR92Tz6nmrvB9
         gBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694798924; x=1695403724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbTOfXLq+M53K/FMFDrbAZVv5Nn1wG1Cp/nYwUS1YQQ=;
        b=NhBHkUf7rYx8djJaanDWFDNGxZ2CwIiT1pkHzT8y/6ulah4zNRefvieLJnDIaKQ173
         XwREGy9oXiWLChgviFbOa5kquWB29X5zcjdfE4QXR50VWhtIlQbC4wuT+MQfehftSAyV
         pGECKhOyrljmZT6aSFX3VqvYUPbC7Zk6xKvCAzEWqmj6VaWczbAwD3WjCvurMhKevG8V
         K/Z8bKmFJ1S4iGeZyReQs6Faf9QMd7DW6zu/mmGKfvn75S08zaftLvO5rdpPflVu23Dj
         I8scsqLOd6FOU0nybz+OASCjCot1a6YbPNalx1+KE1Ic4LY/XzJhTOm14Ib1ZSCjQ3Jk
         A7fQ==
X-Gm-Message-State: AOJu0YxAhIaPXdkE54x7J8wgKXQ4WNBtKgzne3yJysASTTdimrPwCExE
	SBekRhyUcGP1wyf2jucJi4hxpBQuos/UoL2myA8=
X-Google-Smtp-Source: AGHT+IH4fSfihtDdyU0ysF+d0T/pVTmzX5aSLcK0+1T/mg5OuWhXkWFPrZgKYb5IRXPANUmGgntQrMmWYOstQQrvE6k=
X-Received: by 2002:a05:6512:4004:b0:502:d743:9fd0 with SMTP id
 br4-20020a056512400400b00502d7439fd0mr2648065lfb.45.1694798923793; Fri, 15
 Sep 2023 10:28:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com> <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com>
In-Reply-To: <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 Sep 2023 10:28:32 -0700
Message-ID: <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:27=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 15, 2023 at 10:24=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 10:22=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Sep 15, 2023 at 10:18=E2=80=AFAM Nathan Chancellor <nathan@ke=
rnel.org> wrote:
> > > >
> > > > On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> > > > > Marcus and Satya reported an issue where BTF_ID macro generates s=
ame
> > > > > symbol in separate objects and that breaks final vmlinux link.
> > > > >
> > > > >   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
> > > > >   '__BTF_ID__struct__cgroup__624' is already defined
> > > > >
> > > > > This can be triggered under specific configs when __COUNTER__ hap=
pens to
> > > > > be the same for the same symbol in two different translation unit=
s,
> > > > > which is already quite unlikely to happen.
> > > > >
> > > > > Add __LINE__ number suffix to make BTF_ID symbol more unique, whi=
ch is
> > > > > not a complete fix, but it would help for now and meanwhile we ca=
n work
> > > > > on better solution as suggested by Andrii.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.=
com>
> > > > > Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > > > Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> > > > > Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> > > > > Debugged-by: Nathan Chancellor <nathan@kernel.org>
> > > > > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > > > > Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfeb=
ccUasQOfQKaOd0nQ51tw@mail.gmail.com/
> > > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > ---
> > > > >  tools/include/linux/btf_ids.h | 2 +-
> > > >
> > > > Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwis=
e, I
> > > > don't think it will be used by the kernel build.
> >
> > D'oh!
> >
> > >
> > > argh.
> > > Let's do this patch as-is and another patch to update everything
> > > in tools/../btf_ids.h, since it got out of sync quite a bit.
> >
> > I think I can do both in a v3? I don't see the issue (in mainline, are
> > they out of sync in -next?)
>
> Yes. Pls send v3 with two patches.
> We'll apply and flush bpf trees, so both will have all fixes in a day or =
so.

And please use [PATCH bpf v3] in subject, so that BPF CI can test it proper=
ly.

