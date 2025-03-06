Return-Path: <bpf+bounces-53444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31BCA540BD
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23483AB71A
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 02:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6418DB38;
	Thu,  6 Mar 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="sozQBz5+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379C1624D7
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228629; cv=none; b=qlPaHHA5Ud0RYNRlSdVDMIv8WmqYLlNW/qbrshgAkBRNRcuWf1oYbnqM9+j915sDyRrTX728biwx2XXuYReTWaZxUE0Beqbf4K9YEjOUc/PL/yj1T6tduCz7yf1PnV1SF01MplF8EqtBPoVDWA0HUXDkDsivGrIF22yOQbkPONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228629; c=relaxed/simple;
	bh=62YHmirGA0vVZkXy//htomScKBPIyQ5OGF5xtI2He7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9cgD8JxYfPQDi2nQdAdbihZi9eVqge2WYWlusDd5VEiesGSze823KJWoPZ71bGJ+WZknMLNB0W6G4G4UIfOjmH3A1X7YlKNCAG2Hpj4bl/0M6LHX88sDG5Si2EJZGdy/y4yQkaNdWd0+ER3wVAQITFsFS3TeJyFu2XjCAzstf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=sozQBz5+; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fcf90d09c6so1896377b3.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 18:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741228626; x=1741833426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lcFj6bcci69UcvXtrYxKBQmOnMR/ngntEGx8KDBKN0=;
        b=sozQBz5+loVKMZM/m8Hw8go6VbWYa4/R7MP4LViElsEi7/ES51FLapW6ycwF3uaZSn
         WsL3SVOg9BPSB+UnAwmilIOW+s9q00+rDoABrM4Apct0IKmsrgZ4GrlcIV9x7pVqNTOX
         oKp1xTt6pTZERzQ9R13Jj6gBqfUqZVm1ISVATubqjVX9GpLptPjzQ3LFzWlBoowz/Mno
         mthNITDiOX1BMERaA4S8LnFURMcx17tM13Tksj49PIuTx4yu2iSgwXJmcVsY9Yt+44On
         yheZpmjPqsY4Eisr7rOeLe07TZOw2dTHiwBYpzBuH9oSsPGne1084toV/gXQ6v4EAS/h
         8V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228626; x=1741833426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lcFj6bcci69UcvXtrYxKBQmOnMR/ngntEGx8KDBKN0=;
        b=pkGXPfUSil/ylB08cduLceWwryFwj3UyQ6KNw1cIiPpGpoV34TFqq/eiZatJgFmmKP
         513Hh1X2vT+iOHMXI1CtnMiUB6HFYb17cvRftedgp+IRT1sIVaA2uNIGFmIRALGrD8Fz
         psiqrkvftcE6vwErw/B5k3Cgb10L7dt5b9Ybte/Ftuzn/vkTLUOW9ZEXraUL7hROmUot
         XZAb9Of9w6Rd6KqOzhfBA76MOlprtQG48XSqGIvf5J8uPYOPTZ9GPTxDJ3vCWAnUdEDV
         xz3zWUfXNfhRUW2ae5Irs/zi9VQLJDCdMQnqIrg47x/7XqPJABBZgAHXgKWySqXsOaYT
         q4BA==
X-Gm-Message-State: AOJu0YwZZeRaUYIHtaIOW0dJejAbbCpzWMdv4BiqUP6bPxbahkIgc3v0
	yfU6XB+N4lerCi+XftYJJvXCMjjDz3y94UlhS0dS22BabJMEjXiyg+sV6jiMXiVniIxcf+7sU4K
	AY3Y80Tlu81ns596SFLDcbMUFBMPCt01pY71XjQ==
X-Gm-Gg: ASbGncthKzViUMMx5Y2Cv5dtAaQET3+HW5Nr24omZbwigXrlyGHkacXBSIMQu/A0Io6
	0aOQFH8VDoeOUuA/H8rPblRA7ZJ/MBxOmwMVTXBU5qQSjDTCM3ZT3lOwCEUYw8FkzGAzEn0v8nZ
	ZbHpFv//Clurb3Y++I5aoo4f/AQOA=
X-Google-Smtp-Source: AGHT+IFI6SfTFweqJkaRDeQ6OJmB0KcUtjcZfV4LapJckOY+SqzSL4Kx6OvnA+v01AspqHgN4IXqaCygPZ7mG3OI1NY=
X-Received: by 2002:a05:690c:920e:b0:6fe:8fe:f5c2 with SMTP id
 00721157ae682-6feaee59801mr23986657b3.8.1741228625983; Wed, 05 Mar 2025
 18:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305211235.368399-1-emil@etsalapatis.com> <20250305211235.368399-3-emil@etsalapatis.com>
 <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
In-Reply-To: <7deb7f8c-d196-ac21-4857-9f8deb65b1f5@huaweicloud.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 5 Mar 2025 21:36:54 -0500
X-Gm-Features: AQ5f1JqCdAR4JqkCOm8jgFR4fBoH8I6F4nvqoOzVpJhs2txs2Z8bg8SROscQOEA
Message-ID: <CABFh=a7Y3-eJV6Wk+g=XcvBva+x95wEiwCVYTfS8v59nZpCuLQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] selftests: bpf: add bpf_cpumask_fill selftests
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thank you for the feedback. I will address it in a v5.

On Wed, Mar 5, 2025 at 8:57=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 3/6/2025 5:12 AM, Emil Tsalapatis wrote:
> > Add selftests for the bpf_cpumask_fill helper that sets a bpf_cpumask t=
o
> > a bit pattern provided by a BPF program.
> >
> > Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> > ---
> >  .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
> >  .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
> >  2 files changed, 152 insertions(+)
>
> My local build failed due to the missed declaration of
> "bpf_cpumask_populate" in cpumask_common.h. It reported the following err=
or:
>
> progs/cpumask_success.c:788:8: error: call to undeclared function
> 'bpf_cpumask_populate'; ISO C99 and later do not support implicit fun
> ction declarations [-Wimplicit-function-declaration]
>   788 |         ret =3D bpf_cpumask_populate((struct cpumask *)local,
> &toofewbits, sizeof(toofewbits));
>
> Don't know the reason why CI succeeded.
>

Based on Alexei's email systems with recent pahole versions handle
this fine (at least the CI and my local setup),
I will still add the definition in cpumask_common.h for uniformity
since all the other kfuncs have one.

> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tool=
s/testing/selftests/bpf/progs/cpumask_failure.c
> > index b40b52548ffb..8a2fd596c8a3 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> > @@ -222,3 +222,41 @@ int BPF_PROG(test_invalid_nested_array, struct tas=
k_struct *task, u64 clone_flag
> >
> >       return 0;
> >  }
> > +
> > +SEC("tp_btf/task_newtask")
> > +__failure __msg("type=3Dscalar expected=3Dfp")
> > +int BPF_PROG(test_populate_invalid_destination, struct task_struct *ta=
sk, u64 clone_flags)
> > +{
> > +     struct bpf_cpumask *invalid =3D (struct bpf_cpumask *)0x123456;
> > +     u64 bits;
> > +     int ret;
> > +
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)invalid, &bits, si=
zeof(bits));
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("tp_btf/task_newtask")
> > +__failure __msg("leads to invalid memory access")
> > +int BPF_PROG(test_populate_invalid_source, struct task_struct *task, u=
64 clone_flags)
> > +{
> > +     void *garbage =3D (void *)0x123456;
> > +     struct bpf_cpumask *local;
> > +     int ret;
> > +
> > +     local =3D create_cpumask();
> > +     if (!local) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)local, garbage, 8)=
;
> > +     if (!ret)
> > +             err =3D 2;
> > +
> > +     bpf_cpumask_release(local);
> > +
> > +     return 0;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tool=
s/testing/selftests/bpf/progs/cpumask_success.c
> > index 80ee469b0b60..5dc0fe9940dc 100644
> > --- a/tools/testing/selftests/bpf/progs/cpumask_success.c
> > +++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
> > @@ -757,6 +757,7 @@ int BPF_PROG(test_refcount_null_tracking, struct ta=
sk_struct *task, u64 clone_fl
> >       mask1 =3D bpf_cpumask_create();
> >       mask2 =3D bpf_cpumask_create();
> >
> > +
> >       if (!mask1 || !mask2)
> >               goto free_masks_return;
>
> An extra newline.
> >
> > @@ -770,3 +771,116 @@ int BPF_PROG(test_refcount_null_tracking, struct =
task_struct *task, u64 clone_fl
> >               bpf_cpumask_release(mask2);
> >       return 0;
> >  }
> > +
> > +SEC("tp_btf/task_newtask")
> > +__success
>
> For tp_btf, bpf_prog_test_run() doesn't run the prog and it just returns
> directly, therefore, the prog below is not exercised at all. How about
> add test_populate_reject_small_mask into cpumask_success_testcases
> firstly, then switch these test cases to use __success() in a following
> patch ?

Sorry about that, I had the selftests properly hooked into
prog_tests/cpumask.c until v3 but saw duplicate entries in the
selftest log
and thought it was being run twice. I will add them back in.

Is __success() a different annotation? AFAICT __success is enough as
long as err is set to nonzero on an error path, and all
error paths are set like that in the selftests. In that case,
shouldn't adding the new tests cpumask_success_testcases be
enough to properly run the tests?


> > +int BPF_PROG(test_populate_reject_small_mask, struct task_struct *task=
, u64 clone_flags)
> > +{
> > +     struct bpf_cpumask *local;
> > +     u8 toofewbits;
> > +     int ret;
> > +
> > +     local =3D create_cpumask();
> > +     if (!local)
> > +             return 0;
> > +
> > +     /* The kfunc should prevent this operation */
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)local, &toofewbits=
, sizeof(toofewbits));
> > +     if (ret !=3D -EACCES)
> > +             err =3D 2;
> > +
> > +     bpf_cpumask_release(local);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Mask is guaranteed to be large enough for bpf_cpumask_t. */
> > +#define CPUMASK_TEST_MASKLEN (sizeof(cpumask_t))
> > +
> > +/* Add an extra word for the test_populate_reject_unaligned test. */
> > +u64 bits[CPUMASK_TEST_MASKLEN / 8 + 1];
> > +extern bool CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS __kconfig __weak;
> > +
> > +SEC("tp_btf/task_newtask")
> > +__success
>
> Same for test_populate_reject_unaligned.
> > +int BPF_PROG(test_populate_reject_unaligned, struct task_struct *task,=
 u64 clone_flags)
> > +{
> > +     struct bpf_cpumask *mask;
> > +     char *src;
> > +     int ret;
> > +
> > +     /* Skip if unaligned accesses are fine for this arch.  */
> > +     if (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> > +             return 0;
> > +
> > +     mask =3D bpf_cpumask_create();
> > +     if (!mask) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     /* Misalign the source array by a byte. */
> > +     src =3D &((char *)bits)[1];
> > +
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)mask, src, CPUMASK=
_TEST_MASKLEN);
> > +     if (ret !=3D -EINVAL)
> > +             err =3D 2;
> > +
> > +     bpf_cpumask_release(mask);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +SEC("tp_btf/task_newtask")
> > +__success
> > +int BPF_PROG(test_populate, struct task_struct *task, u64 clone_flags)
> > +{
> > +     struct bpf_cpumask *mask;
> > +     bool bit;
> > +     int ret;
> > +     int i;
> > +
> > +     /* Set only odd bits. */
> > +     __builtin_memset(bits, 0xaa, CPUMASK_TEST_MASKLEN);
> > +
> > +     mask =3D bpf_cpumask_create();
> > +     if (!mask) {
> > +             err =3D 1;
> > +             return 0;
> > +     }
> > +
> > +     /* Pass the entire bits array, the kfunc will only copy the valid=
 bits. */
> > +     ret =3D bpf_cpumask_populate((struct cpumask *)mask, bits, CPUMAS=
K_TEST_MASKLEN);
> > +     if (ret) {
> > +             err =3D 2;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * Test is there to appease the verifier. We cannot directly
> > +      * access NR_CPUS, the upper bound for nr_cpus, so we infer
> > +      * it from the size of cpumask_t.
> > +      */
> > +     if (nr_cpus < 0 || nr_cpus >=3D CPUMASK_TEST_MASKLEN * 8) {
> > +             err =3D 3;
> > +             goto out;
> > +     }
> > +
> > +     bpf_for(i, 0, nr_cpus) {
> > +             /* Odd-numbered bits should be set, even ones unset. */
> > +             bit =3D bpf_cpumask_test_cpu(i, (const struct cpumask *)m=
ask);
> > +             if (bit =3D=3D (i % 2 !=3D 0))
> > +                     continue;
> > +
> > +             err =3D 4;
> > +             break;
> > +     }
> > +
> > +out:
> > +     bpf_cpumask_release(mask);
> > +
> > +     return 0;
> > +}
> > +
> > +#undef CPUMASK_TEST_MASKLEN
>

