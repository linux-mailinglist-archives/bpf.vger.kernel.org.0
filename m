Return-Path: <bpf+bounces-61431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE86AE7026
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AF83BCD8F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0922E3380;
	Tue, 24 Jun 2025 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN0RmkeW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82722D9ED
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794529; cv=none; b=ulTATSgGH4L1K6OdFGJv9feg2Kqt5g5IMQZVhgqYZyaNemAvm0rjjn/vnnO+IsBcq5rjFwOe3Iyhx2DC8PHw+9R1GvqZe1V4wLbPaAwfLkDhQFWKReiQXR4cqpPN+Qglz0Uh60aWiW66sAkiTnRo6OPdCeL8cMyCkHFx/a/mTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794529; c=relaxed/simple;
	bh=zPnP1t4WQI454xYt8lPJw2mvMsEYZ31Yww15CQZ+zHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8DaqtalkWITmFTirKPCzao1NKvVIDENWvAbfQMZkLaO6lJOaNB4DuPX8oXAAV9ene3H+0JHrAbaDHptRczXfS0a0Q99i1lAxsRY6Y3iShc213A+Q5r+KHlMAkCp3PVdDdZqXlL6s+5wwt3svKkLygfadVWUOcEnk8kNEowivUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN0RmkeW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so829785a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750794527; x=1751399327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjC3IRdcQGtm9LBHXsq2rTz46ZqRYrA5Ev8KF3WoHB0=;
        b=MN0RmkeWGkzVH3LziqW16SNYB52CI0F2lvuKw129E63jZ1Cl8qmIag1Qeek3mbphWu
         p51LZv3JyClC9CyGGVk1FtASls6jtcjrwzg89dp2qTPKhdwAKvyRMgNlYWL17ZaElMYj
         AcPzL3m9LTGC//LZ1wtByWoVRgEY+iY8hR5r51IL0M7MQ42UjaOmbZATsyXAKo1YKB0A
         4xMuEJxtn6Vrqb+TuHjpISkaWOS4FTwDfcJ0MGsTFN7FchyT3aZ4XyGehU7pCJGGPx3I
         5+OMDhqbcHln1eZsWXvo1fWfobE6cPyxmyOSJUHzh5peS7CvTztRPOLNVnv2dwYzZeOE
         OaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794527; x=1751399327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjC3IRdcQGtm9LBHXsq2rTz46ZqRYrA5Ev8KF3WoHB0=;
        b=YS1Ie6lok7Z3TuwZwae1sd9GnvH00gku2ILz2J/gvBMCeErqJ+2UR4Asc9uENXCG3J
         CV/zsB65o+sxYcTRyIkkvsQ83UNpVEjx7c4Mk/YImyWcznRABZlg1ee6Iy1dRR+v+m5u
         8NZpmqO/KSECxF259D2Fr5jUGVnQqFy60duYuKp/0+0u/gf5p9Hk3g89hPXbQpJZ4HNc
         sfCs/rPeYeVgKtcaZN11xI3ao769l9LKfrW+NpxbiFY/Mzh+TLKR8RdR22LTM1VU6cCy
         zl5e6qQu/5CF1fmqUQg3V4OrMdC145oY52gkn21HE+BQyWhxLCva8yJ3uAWDN4BDCN64
         /pAA==
X-Gm-Message-State: AOJu0YyLo+rBYz8opvuKchft7t16p2d8v4YMEPsWcPvxhpNBD9mrHI76
	fCN1BnOoNKbBQNoa14tLFVY1M+F6ABx0IFhZ+bdsngI61ndyXs0BQMoEqeSrheDj16o38eyWnys
	oBOkc5JkesnaA8XbJdJBm8fFxGCqVw30=
X-Gm-Gg: ASbGncvYXiU2320Tz72DA2WAaUmomdKf843IsfCw6i88sqRFfm58Va4Pl2pJjQrmKFY
	84m3dmmL0GylhlWZ6txorXZq1jIDjZ2nJa+HbI/wGp7/XKO5ZfQD7VTz1VUY+TSsMXVXRJ2qP74
	QWj/XQIxMEcSNpns2Uh+d+a2WviPMJL4qa0fuFRe2sQA==
X-Google-Smtp-Source: AGHT+IHCL6UU+egcZDaloT/7MJnM0KSlhyrf9v0jn/dkYGLoxbza4rLpgTapG1oZ2BAhMQawRhCrd4nUN/7PMwHY7K8=
X-Received: by 2002:a17:90b:2dc2:b0:311:ea13:2e6e with SMTP id
 98e67ed59e1d1-315f26b86abmr141103a91.28.1750794527233; Tue, 24 Jun 2025
 12:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
 <20250615185351.2757391-1-yonghong.song@linux.dev> <CAEf4BzZmzrT7+nB0eyK-iLv+un68VtLY-TAq3G5Pti=sjM41TQ@mail.gmail.com>
 <b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev> <CAEf4BzbWqj9a7zrocg5pLDKTG9aJgRK61=SFLzH=ANtAAs_bLA@mail.gmail.com>
 <cc78ac6b-6f87-4d85-ac3e-36bb06fdd3e3@linux.dev>
In-Reply-To: <cc78ac6b-6f87-4d85-ac3e-36bb06fdd3e3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 12:48:35 -0700
X-Gm-Features: AX0GCFvm6-JwCnPke46wZsH6NK1z1kAwA62KS9tOFGlE4FKUEpsIVWVJsdpfod0
Message-ID: <CAEf4BzanoB1D0s+9Tw8Pt0L_dsMUm92_H1cRi0yhkEe1JzWkHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:15=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 6/24/25 8:36 AM, Andrii Nakryiko wrote:
> > On Tue, Jun 17, 2025 at 9:36=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >>
> >> On 6/16/25 3:00 PM, Andrii Nakryiko wrote:
> >>> On Sun, Jun 15, 2025 at 11:54=E2=80=AFAM Yonghong Song <yonghong.song=
@linux.dev> wrote:
> >>>> When building the selftest with arm64/clang20, the following test fa=
iled:
> >>>>       ...
> >>>>       ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
> >>>>       subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
> >>>>       subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected poi=
nter: 0xaaaad82a2a80
> >>>>       #469/2   usdt/multispec:FAIL
> >>>>       #469     usdt:FAIL
> >>>>
> >>>> The failed assertion
> >>>>       subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected poi=
nter: 0xaaaad82a2a80
> >>>> is caused by bpf_program__attach_usdt() which is expected to fail. B=
ut
> >>>> with arm64/clang20 bpf_program__attach_usdt() actually succeeded.
> >>> I think I missed that it's unexpected *success* that is causing
> >>> issues. If that's so, then I think it might be more straightforward t=
o
> >>> just ensure that test is expectedly failing regardless of compiler
> >>> code generation logic. Maybe something along the following lines:
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
> >>> b/tools/testing/selftests/bpf/prog_tests/usdt.c
> >>> index 495d66414b57..fdd8642cfdff 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> >>> @@ -190,11 +190,21 @@ static void __always_inline f300(int x)
> >>>           STAP_PROBE1(test, usdt_300, x);
> >>>    }
> >>>
> >>> +#define RP10(F, X)  F(*(X+0)); F(*(X+1));F(*(X+2)); F(*(X+3)); F(*(X=
+4)); \
> >>> +                   F(*(X+5)); F(*(X+6)); F(*(X+7)); F(*(X+8)); F(*(X=
+9));
> >>> +#define RP100(F, X) RP10(F,X+
> >>> 0);RP10(F,X+10);RP10(F,X+20);RP10(F,X+30);RP10(F,X+40); \
> >>> +
> >>> RP10(F,X+50);RP10(F,X+60);RP10(F,X+70);RP10(F,X+80);RP10(F,X+90);
> >>> +
> >>>    __weak void trigger_300_usdts(void)
> >>>    {
> >>> -       R100(f300, 0);
> >>> -       R100(f300, 100);
> >>> -       R100(f300, 200);
> >>> +       volatile int arr[300], i;
> >>> +
> >>> +       for (i =3D 0; i < 300; i++)
> >>> +               arr[i] =3D 300;
> >>> +
> >>> +       RP100(f300, arr + 0);
> >>> +       RP100(f300, arr + 100);
> >>> +       RP100(f300, arr + 200);
> >>>    }
> >>>
> >>>
> >>> So basically force the compiler to use 300 different locations for
> >>> each of 300 USDT instantiations? I didn't check how that will look
> >>> like on arm64, but on x86 gcc it seems to generate what is expected o=
f
> >>> it.
> >>>
> >>> Can you please try it on arm64 and see if that works?
> >> I tried the above on arm64 and it does not work. It has the same usdt =
arguments
> >> as without this patch:
> >>
> >>     stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt_300
> >>       Location: 0x00000000000009e0, Base: 0x0000000000000000, Semaphor=
e: 0x0000000000000008
> >>       Arguments: -4@[x9]
> >>     stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt_300
> >>       Location: 0x00000000000009f8, Base: 0x0000000000000000, Semaphor=
e: 0x0000000000000008
> >>       Arguments: -4@[x9]
> >>     ...
> >>
> >> But I found if we build usdt.c file with -O2 (RELEASE=3D1) on arm64, t=
he test will be successful:
> >>
> >>     stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt_300
> >>       Location: 0x00000000000001a4, Base: 0x0000000000000000, Semaphor=
e: 0x0000000000000008
> >>       Arguments: -4@0
> >>     stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt_300
> >>       Location: 0x00000000000001a8, Base: 0x0000000000000000, Semaphor=
e: 0x0000000000000008
> >>       Arguments: -4@1
> >>     ...
> >>
> >> But usdt.c with -O2 will have a problem with gcc14 on x86:
> >>
> >>     stapsdt              0x00000087       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt12
> >>       Location: 0x000000000000258f, Base: 0x0000000000000000, Semaphor=
e: 0x0000000000000006
> >>       Arguments: -4@$2 -4@$3 -8@$42 -8@$44 -4@$5 -8@$6 8@%rdx 8@%rsi -=
4@$-9 -2@%cx -2@nums(%rax,%rax) -1@t1+4(%rip)
> >>     ...
> >>
> >> You can see the above last two arguments which are not supported by li=
bbpf.
> >>
> >> So let us say usdt.c is compiled with -O2:
> >>      x86:
> >>        gcc14 built kernel/selftests: failed, see the above
> >>        clang built kernel/selftests: good
> >>      arm64:
> >>        both gcc14/clang built kernel/selftrests: good
> >>
> >> arm64 has more reigsters so it is likely to have better argument repre=
sentation, e.g.,
> >> for arm64/gcc with -O2, we have
> >>
> >>     stapsdt              0x00000071       NT_STAPSDT (SystemTap probe =
descriptors)
> >>       Provider: test
> >>       Name: usdt12
> >>       Location: 0x0000000000002e74, Base: 0x0000000000000000, Semaphor=
e: 0x000000000000000a
> >>       Arguments: -4@2 -4@3 -8@42 -8@44 -4@5 -8@6 8@x1 8@x3 -4@-9 -2@x2=
 -2@[x0, 8] -1@[x3, 28]
> >>
> >> Eduard helped me to figure out how to compile prog_tests/usdt.c with -=
O2 alone.
> >> The following patch resolved the issue and usdt test will be happy for=
 both x86 and arm64:
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/self=
tests/bpf/Makefile
> >> index 97013c49920b..05fc9149bc4f 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -760,6 +760,14 @@ TRUNNER_BPF_BUILD_RULE :=3D $$(error no BPF objec=
ts should be built)
> >>    TRUNNER_BPF_CFLAGS :=3D
> >>    $(eval $(call DEFINE_TEST_RUNNER,test_maps))
> >>
> >> +# Compiler prog_tests/usdt.c with -O2 with clang compiler.
> >> +# Otherwise, with -O0 on arm64, the usdt test will fail.
> >> +ifneq ($(LLVM),)
> >> +$(OUTPUT)/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> >> +$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> >> +$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> >> +endif
> >> +
> >>    # Define test_verifier test runner.
> >>    # It is much simpler than test_maps/test_progs and sufficiently dif=
ferent from
> >>    # them (e.g., test.h is using completely pattern), that it's worth =
just
> >>
> >> Another choice is to support argument like `-2@nums(%rax,%rax)` and `-=
1@t1+4(%rip)`.
> >> But I am not sure whether we should do it or not as typically a usdt p=
robe
> >> probably won't have lots of diverse arguments.
> >>
> >> WDYT?
> > Can we just make that part of the test x86-64 specific for now? All
> > other alternatives seem worse, tbh.
>
> So something like below?
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 495d66414b57..1e7e222034f7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -270,8 +270,16 @@ static void subtest_multispec_usdt(void)
>           */
>          trigger_300_usdts();
>
> -       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>          bpf_link__destroy(skel->links.usdt_100);
> +
> +       /* If built with clang with arm64 target, there will be much less
> +        * number of specs for usdt_300 call sites.
> +        */
> +#if defined(__clang__) && defined(__aarch64__)
> +       bss->usdt_100_called =3D 0;
> +       bss->usdt_100_sum =3D 0;

I'd add this right before usdt_400 attachment unconditionally and
avoid #if/#else/#endif branching. But other than that, yeah, something
like that.

> +#else
> +       /* we'll reuse usdt_100 BPF program for usdt_300 test */
>          skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.us=
dt_100, -1, "/proc/self/exe",
>                                                          "test", "usdt_30=
0", NULL);
>          err =3D -errno;
> @@ -289,6 +297,7 @@ static void subtest_multispec_usdt(void)
>
>          ASSERT_EQ(bss->usdt_100_called, 0, "usdt_301_called");
>          ASSERT_EQ(bss->usdt_100_sum, 0, "usdt_301_sum");
> +#endif
>
>          /* This time we have USDT with 400 inlined invocations, but arg =
specs
>           * should be the same across all sites, so libbpf will only need=
 to
>

