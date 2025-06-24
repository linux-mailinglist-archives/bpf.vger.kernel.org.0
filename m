Return-Path: <bpf+bounces-61383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93024AE6B76
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684CF5A5025
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3D29E0FA;
	Tue, 24 Jun 2025 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwF/4lTh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2F170A26
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779394; cv=none; b=WxWEVRq6CGZGeYqWWWKpR/AXOA74zPA4oveRykhcPFvMTzBkxrXOZ5o1A0FwFKowQlnESi/gHRKITROEYkzuzcTlsn7AgTr+WdSasOIlIdCxyIkEXUi37CCffTzngHkZdcRHuGOagywv5b/7/vLzLeBEU78Pk5r0/Z04+QYCS0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779394; c=relaxed/simple;
	bh=i+w5/gv+UEzmLpikr2iZ7CRRUkS/DsWEBxHiHWWSqlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dim40Obu6C7nTL04ylJndMNiulLs9gSXvFwRiVr/bC0ELZFh/n0GLQZRH4CFenz9KEb1UeXLBZgpiw94yI4zU1dVpbvBNHFo7XOY2uUtvEBj8To1HmgGFeaOyjSvZQ/hbvxmaLT0b7K+h/YhmskCzXAri1xjG2whswkJBGD6JnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwF/4lTh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso4189746a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750779391; x=1751384191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYHEawio7UnuodozoAAPY2hak/mg4KkBT7zKLdvmchg=;
        b=NwF/4lTh575R9eCQxDvLvzFojv9YrrjDkxRh7TSmFy1Q0TTj0KaPxFVGjIDaCbFlqY
         Z6o4qnpmRZJeCz/m+zX1lih48nm2mCHUQokfXX9gl3zmsEI3iHlZS2yFZCiqc7C+a1QJ
         PXRwhUWloXpvtGeTHQNz9LESSPLQLOG26/aHZd9WmLjad5E+L9sQcEUGq2kcRksz1bVT
         WIRZJg/96zqJ2t3uXgMg3dZzrn2E7pxQTE/arUM07KxnjcjnXiAsbC7KL9+zKkjrgnqo
         3Xy/SCwd88vHMZzcz1mYeAegIDyI8girxWpPyrU+3aF/ZxP4lhI0Sp3krcKaCpohpStB
         PkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750779391; x=1751384191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYHEawio7UnuodozoAAPY2hak/mg4KkBT7zKLdvmchg=;
        b=QWa5l9pwhBwXgYZZk8lNNnu43RPRCt30+XEI9xJZeAV27kwvEt/EfoR+jYBCcsheLc
         Atn+W0uTcI4GTx+OindmnHMSLAo5A3EamaS+0X+F4xCdBb3nIwiWC3/PfqTYcLeQm5yC
         lRhL9MBPmLz68MKMo5rzM8vfEUfW69rGgWoUKCLOVNNHVjgDYMX5OoEllToMKud4jZXM
         UCrc1nBx5AcdAlKCTR74plAes9vms/auRGG3B4ZUTkRxKdqxnWS3vL3TjL9pcMlWQIfe
         CPG6TKg1Z9UUQ1X5hmEyZFNJ3WbGA+Cun3tVAuYknnVsnkPoRl8COhXkLq5BzjlFpRDW
         L4Dg==
X-Gm-Message-State: AOJu0Yx2vqVoU5HPai8NBUSJzL3tawrQCIwr5bU+GQxEVCn2Fv03rCV2
	lxI42dYaRKa3qixmvWTBb26GxgwKVhupnl5ZpE1oBv0p4E+1JKIE92pDH9WhxZf2FXWWYMtsU9q
	B1WELo39I/66jTbvz7US4huKXbsJwcb0=
X-Gm-Gg: ASbGncsqLCS0Fg7nM1LlLH7hrSmCMDtycnWnjnj8MLw6PmJEQ84M8D/Zm5zFvA2Whf9
	b8rHC3EPMsrgAk6Wlwq5WxzJKPjCubcA5GOlWa+bzMdijn/kmtnAlXB2XjXbdEuqyymB58GSXUT
	Ee5FFvuuJq8doRs8ygT0mRRV25hZpGhs5X66CKXQhfsw==
X-Google-Smtp-Source: AGHT+IGcBrF5Q8qbYd2JxIHei0SR7U+O03nDMGU2oQCpxUzFqpFFfcfBwYODNyEikezcK3ebVyws8n9wopu6OdMkc88=
X-Received: by 2002:a17:90b:1f8b:b0:311:e8cc:424e with SMTP id
 98e67ed59e1d1-3159d8d685dmr30840660a91.24.1750779390993; Tue, 24 Jun 2025
 08:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615185345.2756663-1-yonghong.song@linux.dev>
 <20250615185351.2757391-1-yonghong.song@linux.dev> <CAEf4BzZmzrT7+nB0eyK-iLv+un68VtLY-TAq3G5Pti=sjM41TQ@mail.gmail.com>
 <b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev>
In-Reply-To: <b3ce39f0-c52b-4787-980c-973bd4228349@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Jun 2025 08:36:18 -0700
X-Gm-Features: AX0GCFtoaFFEFg1AI3eq5ULlLJpvS0cbkZ3QQW8rXgk-AOkK7MSZmsiikq2Gk_4
Message-ID: <CAEf4BzbWqj9a7zrocg5pLDKTG9aJgRK61=SFLzH=ANtAAs_bLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Refactor the failed
 assertion to another subtest
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:36=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 6/16/25 3:00 PM, Andrii Nakryiko wrote:
> > On Sun, Jun 15, 2025 at 11:54=E2=80=AFAM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >> When building the selftest with arm64/clang20, the following test fail=
ed:
> >>      ...
> >>      ubtest_multispec_usdt:PASS:usdt_100_called 0 nsec
> >>      subtest_multispec_usdt:PASS:usdt_100_sum 0 nsec
> >>      subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointe=
r: 0xaaaad82a2a80
> >>      #469/2   usdt/multispec:FAIL
> >>      #469     usdt:FAIL
> >>
> >> The failed assertion
> >>      subtest_multispec_usdt:FAIL:usdt_300_bad_attach unexpected pointe=
r: 0xaaaad82a2a80
> >> is caused by bpf_program__attach_usdt() which is expected to fail. But
> >> with arm64/clang20 bpf_program__attach_usdt() actually succeeded.
> > I think I missed that it's unexpected *success* that is causing
> > issues. If that's so, then I think it might be more straightforward to
> > just ensure that test is expectedly failing regardless of compiler
> > code generation logic. Maybe something along the following lines:
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > index 495d66414b57..fdd8642cfdff 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> > @@ -190,11 +190,21 @@ static void __always_inline f300(int x)
> >          STAP_PROBE1(test, usdt_300, x);
> >   }
> >
> > +#define RP10(F, X)  F(*(X+0)); F(*(X+1));F(*(X+2)); F(*(X+3)); F(*(X+4=
)); \
> > +                   F(*(X+5)); F(*(X+6)); F(*(X+7)); F(*(X+8)); F(*(X+9=
));
> > +#define RP100(F, X) RP10(F,X+
> > 0);RP10(F,X+10);RP10(F,X+20);RP10(F,X+30);RP10(F,X+40); \
> > +
> > RP10(F,X+50);RP10(F,X+60);RP10(F,X+70);RP10(F,X+80);RP10(F,X+90);
> > +
> >   __weak void trigger_300_usdts(void)
> >   {
> > -       R100(f300, 0);
> > -       R100(f300, 100);
> > -       R100(f300, 200);
> > +       volatile int arr[300], i;
> > +
> > +       for (i =3D 0; i < 300; i++)
> > +               arr[i] =3D 300;
> > +
> > +       RP100(f300, arr + 0);
> > +       RP100(f300, arr + 100);
> > +       RP100(f300, arr + 200);
> >   }
> >
> >
> > So basically force the compiler to use 300 different locations for
> > each of 300 USDT instantiations? I didn't check how that will look
> > like on arm64, but on x86 gcc it seems to generate what is expected of
> > it.
> >
> > Can you please try it on arm64 and see if that works?
>
> I tried the above on arm64 and it does not work. It has the same usdt arg=
uments
> as without this patch:
>
>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt_300
>      Location: 0x00000000000009e0, Base: 0x0000000000000000, Semaphore: 0=
x0000000000000008
>      Arguments: -4@[x9]
>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt_300
>      Location: 0x00000000000009f8, Base: 0x0000000000000000, Semaphore: 0=
x0000000000000008
>      Arguments: -4@[x9]
>    ...
>
> But I found if we build usdt.c file with -O2 (RELEASE=3D1) on arm64, the =
test will be successful:
>
>    stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt_300
>      Location: 0x00000000000001a4, Base: 0x0000000000000000, Semaphore: 0=
x0000000000000008
>      Arguments: -4@0
>    stapsdt              0x0000002b       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt_300
>      Location: 0x00000000000001a8, Base: 0x0000000000000000, Semaphore: 0=
x0000000000000008
>      Arguments: -4@1
>    ...
>
> But usdt.c with -O2 will have a problem with gcc14 on x86:
>
>    stapsdt              0x00000087       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt12
>      Location: 0x000000000000258f, Base: 0x0000000000000000, Semaphore: 0=
x0000000000000006
>      Arguments: -4@$2 -4@$3 -8@$42 -8@$44 -4@$5 -8@$6 8@%rdx 8@%rsi -4@$-=
9 -2@%cx -2@nums(%rax,%rax) -1@t1+4(%rip)
>    ...
>
> You can see the above last two arguments which are not supported by libbp=
f.
>
> So let us say usdt.c is compiled with -O2:
>     x86:
>       gcc14 built kernel/selftests: failed, see the above
>       clang built kernel/selftests: good
>     arm64:
>       both gcc14/clang built kernel/selftrests: good
>
> arm64 has more reigsters so it is likely to have better argument represen=
tation, e.g.,
> for arm64/gcc with -O2, we have
>
>    stapsdt              0x00000071       NT_STAPSDT (SystemTap probe desc=
riptors)
>      Provider: test
>      Name: usdt12
>      Location: 0x0000000000002e74, Base: 0x0000000000000000, Semaphore: 0=
x000000000000000a
>      Arguments: -4@2 -4@3 -8@42 -8@44 -4@5 -8@6 8@x1 8@x3 -4@-9 -2@x2 -2@=
[x0, 8] -1@[x3, 28]
>
> Eduard helped me to figure out how to compile prog_tests/usdt.c with -O2 =
alone.
> The following patch resolved the issue and usdt test will be happy for bo=
th x86 and arm64:
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 97013c49920b..05fc9149bc4f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -760,6 +760,14 @@ TRUNNER_BPF_BUILD_RULE :=3D $$(error no BPF objects =
should be built)
>   TRUNNER_BPF_CFLAGS :=3D
>   $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>
> +# Compiler prog_tests/usdt.c with -O2 with clang compiler.
> +# Otherwise, with -O0 on arm64, the usdt test will fail.
> +ifneq ($(LLVM),)
> +$(OUTPUT)/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/cpuv4/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/no_alu32/usdt.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +endif
> +
>   # Define test_verifier test runner.
>   # It is much simpler than test_maps/test_progs and sufficiently differe=
nt from
>   # them (e.g., test.h is using completely pattern), that it's worth just
>
> Another choice is to support argument like `-2@nums(%rax,%rax)` and `-1@t=
1+4(%rip)`.
> But I am not sure whether we should do it or not as typically a usdt prob=
e
> probably won't have lots of diverse arguments.
>
> WDYT?

Can we just make that part of the test x86-64 specific for now? All
other alternatives seem worse, tbh.

>
>
> >
> >> Checking usdt probes with usdt.test.o,
> >>
> >> with gcc11 build binary:
> >>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x00000000000054f8, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp]
> >>    stapsdt              0x00000031       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000005510, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp, 4]
> >>    ...
> >>    stapsdt              0x00000032       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000005660, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp, 60]
> >>    ...
> >>    stapsdt              0x00000034       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x00000000000070e8, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp, 1192]
> >>    stapsdt              0x00000034       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000007100, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp, 1196]
> >>    ...
> >>    stapsdt              0x00000032       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000009ec4, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[sp, 60]
> >>
> >> with clang20 build binary:
> >>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x00000000000009a0, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[x9]
> >>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x00000000000009b8, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[x9]
> >>    ...
> >>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000002590, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[x9]
> >>    stapsdt              0x0000002e       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x00000000000025a8, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[x8]
> >>    ...
> >>    stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe d=
escriptors)
> >>      Provider: test
> >>      Name: usdt_300
> >>      Location: 0x0000000000007fdc, Base: 0x0000000000000000, Semaphore=
: 0x0000000000000008
> >>      Arguments: -4@[x10]
> >>
> >> There are total 301 locations for usdt_300. For gcc11 built binary, th=
ere are
> >> 300 spec's. But for clang20 built binary, there are 3 spec's. The libb=
pf default
> >> BPF_USDT_MAX_SPEC_CNT is 256. So for gcc11, the above bpf_program__att=
ach_usdt() will
> >> fail, but the function will succeed for clang20.
> >>
> >> Note that we cannot just change BPF_USDT_MAX_SPEC_CNT from 256 to 2 (t=
hrough overwriting
> >> BPF_USDT_MAX_SPEC_CNT before usdt.bpf.h) since it will cause other tes=
t failures.
> >> We cannot just set BPF_USDT_MAX_SPEC_CNT to 2 for test_usdt_multispec.=
c since we
> >> have below in the Makefile:
> >>    test_usdt.skel.h-deps :=3D test_usdt.bpf.o test_usdt_multispec.bpf.=
o
> >> and the linker will enforce that BPF_USDT_MAX_SPEC_CNT values for both=
 progs must
> >> be the same.
> >>
> >> The refactoring does not change existing test result. But the future c=
hange will
> >> allow to set BPF_USDT_MAX_SPEC_CNT to be 2 for arm64/clang20 case, whi=
ch will have
> >> the same attachment failure as in gcc11.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/testing/selftests/bpf/prog_tests/usdt.c | 35 +++++++++++++----=
--
> >>   1 file changed, 25 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/tes=
ting/selftests/bpf/prog_tests/usdt.c
> >> index 495d66414b57..dc29ef94312a 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> >> @@ -270,18 +270,8 @@ static void subtest_multispec_usdt(void)
> >>           */
> >>          trigger_300_usdts();
> >>
> >> -       /* we'll reuse usdt_100 BPF program for usdt_300 test */
> >>          bpf_link__destroy(skel->links.usdt_100);
> >> -       skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.=
usdt_100, -1, "/proc/self/exe",
> >> -                                                       "test", "usdt_=
300", NULL);
> >> -       err =3D -errno;
> >> -       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach=
"))
> >> -               goto cleanup;
> >> -       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> >>
> >> -       /* let's check that there are no "dangling" BPF programs attac=
hed due
> >> -        * to partial success of the above test:usdt_300 attachment
> >> -        */
> >>          bss->usdt_100_called =3D 0;
> >>          bss->usdt_100_sum =3D 0;
> >>
> >> @@ -312,6 +302,29 @@ static void subtest_multispec_usdt(void)
> >>          test_usdt__destroy(skel);
> >>   }
> >>
> >> +static void subtest_multispec_fail_usdt(void)
> >> +{
> >> +       LIBBPF_OPTS(bpf_usdt_opts, opts);
> >> +       struct test_usdt *skel;
> >> +       int err;
> >> +
> >> +       skel =3D test_usdt__open_and_load();
> >> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> >> +               return;
> >> +
> >> +       skel->bss->my_pid =3D getpid();
> >> +
> >> +       skel->links.usdt_100 =3D bpf_program__attach_usdt(skel->progs.=
usdt_100, -1, "/proc/self/exe",
> >> +                                                       "test", "usdt_=
300", NULL);
> >> +       err =3D -errno;
> >> +       if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach=
"))
> >> +               goto cleanup;
> >> +       ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> >> +
> >> +cleanup:
> >> +       test_usdt__destroy(skel);
> >> +}
> >> +
> >>   static FILE *urand_spawn(int *pid)
> >>   {
> >>          FILE *f;
> >> @@ -422,6 +435,8 @@ void test_usdt(void)
> >>                  subtest_basic_usdt();
> >>          if (test__start_subtest("multispec"))
> >>                  subtest_multispec_usdt();
> >> +       if (test__start_subtest("multispec_fail"))
> >> +               subtest_multispec_fail_usdt();
> >>          if (test__start_subtest("urand_auto_attach"))
> >>                  subtest_urandom_usdt(true /* auto_attach */);
> >>          if (test__start_subtest("urand_pid_attach"))
> >> --
> >> 2.47.1
> >>
>

