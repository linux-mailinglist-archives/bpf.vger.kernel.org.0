Return-Path: <bpf+bounces-18043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BB8151E6
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C672F286F53
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981C47F6C;
	Fri, 15 Dec 2023 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMB4Q/c3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BC48CE9
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e18689828so1278614e87.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702675368; x=1703280168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUC4sZcVntEgRTYSln5nwIUWkNKUOnNMg6g/NfAo9MM=;
        b=cMB4Q/c34oTeic738S9jXygL2mLjuflKQk7CB7fCw4t1fTKHtFLFoP5dHLPH83fooO
         zzrxdj/kIsioV9yhSD+EMCxT7Xk6kmZ8UmrVHTlzC6QMEXGfvBMSqJaGIkAYJuQLcQ8C
         sVOHEMYWNFRCG/NUKd+xwjjBkPLoQrXwOoDyibNX/K1a7gZtA+5vy1t17+lHUzlcTa8x
         j/rT6NtUyQncPFEgIp2A6IzmfeAEV/pQQWAS/beEK7BwqsyOGqR62yEkrM3fbGKL6o2L
         JF2j6yGsqh4exM80fMt39QzqtyZyR2pBjl1Q1Y8smTy6H420XR4do/l2SFL4CZpklHsj
         UuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675368; x=1703280168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUC4sZcVntEgRTYSln5nwIUWkNKUOnNMg6g/NfAo9MM=;
        b=vstjCX4zkpx4mvtxSqtEi5jGeRkyq7sb+vNL+v2W0OJw67cbiKuiCJijl9Z/W/c7kA
         tXR8YW8CdDLuYLv1r94S8uAvx0WxrNvr6PnPcMEKFfHONXzmrNWcRFU0rHogOAZ5aUfW
         ffaMK2+kLUzaPwRCMCxflZ0FKLXL5K+AEV69ZmxMlKCHSdnSwUtuf5IG8xge49nkLsb6
         jwkjhPVJTJfIduA2FIjq8PmxBZT2Koq+ruSMf0wophgWT7Qc5I4jX5XSKwdA7yI+skAM
         86QUt5HKofXIzM4208jmWsr1o09PmDYMpEz5VVlbrptwLlfGIt7Ua/yvf4PSfbf2QFyc
         TWIQ==
X-Gm-Message-State: AOJu0Yzw6H+ROcd1Ee4EZBmhEOMhihF9/dFR/bG/XE0Y6A/w5ie7b73W
	tzBH3SCJt93jGHMC1/XGHIa3LjW7s5Ddr3N6IJw=
X-Google-Smtp-Source: AGHT+IGV73OEXCRgAVjZo6cD0m2mJ9rlbBhSJn66rmk3YhPMI2eLdnVQvZ7AF3usxtvRzCRO5svCUQ2sze5jK1TF6Sw=
X-Received: by 2002:ac2:46c5:0:b0:50b:f0af:5605 with SMTP id
 p5-20020ac246c5000000b0050bf0af5605mr5561598lfo.102.1702675367395; Fri, 15
 Dec 2023 13:22:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXwZa_eK7bWXjJk7@krava> <ZXxhlG2gndCZ71Ox@krava> <de0466f0-58af-4eab-bc31-0297eae744ce@linux.dev>
In-Reply-To: <de0466f0-58af-4eab-bc31-0297eae744ce@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 13:22:35 -0800
Message-ID: <CAEf4BzZM3tnm_CB8DW5GMJw=0AVES-ouZS4B22Gy+HirdP+otQ@mail.gmail.com>
Subject: Re: [RFC] bpf: Issue with bpf_fentry_test7 call
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>, 
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:42=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 12/15/23 6:24 AM, Jiri Olsa wrote:
> > On Fri, Dec 15, 2023 at 10:16:27AM +0100, Jiri Olsa wrote:
> >> hi,
> >> The bpf CI is broken due to clang emitting 2 functions for
> >> bpf_fentry_test7:
> >>
> >>    # cat available_filter_functions | grep bpf_fentry_test7
> >>    bpf_fentry_test7
> >>    bpf_fentry_test7.specialized.1
> >>
> >> The tests attach to 'bpf_fentry_test7' while the function with
> >> '.specialized.1' suffix is executed in bpf_prog_test_run_tracing.
> >>
> >> It looks like clang optimalization that comes from passing 0
> >> as argument and returning it directly in bpf_fentry_test7.
> >>
> >> I'm not sure there's a way to disable this, so far I came
> >> up with solution below that passes real pointer, but I think
> >> that was not the original intention for the test.
> >>
> >> We had issue with this function back in august:
> >>    32337c0a2824 bpf: Prevent inlining of bpf_fentry_test7()
> >>
> >> I'm not sure why it started to show now? was clang updated for CI?
> >>
> >> I'll try to find out more, but any clang ideas are welcome ;-)
> >>
> >> thanks,
> >> jirka
> >
> > hm, there seems to be fix in bpf-next for this one:
> >
> >    b16904fd9f01 bpf: Fix a few selftest failures due to llvm18 change
>
> Maybe submit a patch to https://github.com/kernel-patches/vmtest/tree/mas=
ter/ci/diffs?
> That is typically the place to have temporary patches to workaround ci fa=
ilures.
>

To get bpf/master back to green CI I did it meanwhile ([0]). Jiri,
please check the PR to be familiar with the process for the future
similar mitigations, thanks.

  [0] https://github.com/kernel-patches/vmtest/pull/258

> >
> > jirka
> >
> >>
> >> ---
> >> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> >> index c9fdcc5cdce1..33208eec9361 100644
> >> --- a/net/bpf/test_run.c
> >> +++ b/net/bpf/test_run.c
> >> @@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
> >>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
> >>   {
> >>      asm volatile ("");
> >> -    return (long)arg;
> >> +    return 0;
> >>   }
> >>
> >>   int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
> >> @@ -668,7 +668,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *pro=
g,
> >>                  bpf_fentry_test4((void *)7, 8, 9, 10) !=3D 34 ||
> >>                  bpf_fentry_test5(11, (void *)12, 13, 14, 15) !=3D 65 =
||
> >>                  bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, =
21) !=3D 111 ||
> >> -                bpf_fentry_test7((struct bpf_fentry_test_t *)0) !=3D =
0 ||
> >> +                bpf_fentry_test7(&arg) !=3D 0 ||
> >>                  bpf_fentry_test8(&arg) !=3D 0 ||
> >>                  bpf_fentry_test9(&retval) !=3D 0)
> >>                      goto out;
> >> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/t=
esting/selftests/bpf/progs/fentry_test.c
> >> index 52a550d281d9..95c5c34ccaa8 100644
> >> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
> >> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
> >> @@ -64,7 +64,7 @@ __u64 test7_result =3D 0;
> >>   SEC("fentry/bpf_fentry_test7")
> >>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> >>   {
> >> -    if (!arg)
> >> +    if (arg)
> >>              test7_result =3D 1;
> >>      return 0;
> >>   }
> >> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/te=
sting/selftests/bpf/progs/fexit_test.c
> >> index 8f1ccb7302e1..ffb30236ca02 100644
> >> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> >> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> >> @@ -65,7 +65,7 @@ __u64 test7_result =3D 0;
> >>   SEC("fexit/bpf_fentry_test7")
> >>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> >>   {
> >> -    if (!arg)
> >> +    if (arg)
> >>              test7_result =3D 1;
> >>      return 0;
> >>   }

