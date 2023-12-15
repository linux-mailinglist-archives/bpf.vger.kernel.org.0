Return-Path: <bpf+bounces-18054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B4815469
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 00:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8431C239CF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 23:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4618ED0;
	Fri, 15 Dec 2023 23:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXCxf9+2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7518EC8
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c25973988so12738335e9.2
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702682519; x=1703287319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HkTmstSfnjb7XXAm193pEltYvFOFqgNgYMQsCtnGBgs=;
        b=LXCxf9+2DiGT/hdQpJCKLl2PF3Bnr2/5Azu/hstzPiccqGpnl9xrIQQm6DKQDVhwuI
         UI/sGJ3TiNhd/JbMFRkq+l+0n8/SZwZBJTOuJlGMeW+zDmQPoLI4FMPuLJz+LzqTAlwN
         fpo/+B64N2WY4ZscEKtCqA+xIChOzhofWd9ikR/5yGbYCZozbAkGZYqIvpI2nHC81i/P
         uCIXRjx2MtXbaOGx4xHJRo2WuTlnLB/UEaX0q57q3931y0bRQvpuSRgAN9fXeQVdeVmo
         DxErDtwcM8UAxg8KFOpd5g6wSVGTNuP6HMKfh4pUz/ygGfX3vhn/UPLeqODrBrre2tmQ
         K04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702682519; x=1703287319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HkTmstSfnjb7XXAm193pEltYvFOFqgNgYMQsCtnGBgs=;
        b=w1X23oZZofIaYuS5SFzgMANzK2fSapSfC1zVsrZvpNFEi+7emdLLyZnadfGqFp9iSK
         xeRMNSkZ2th9TLNmGvBBz8TXxC+lLJ8jNOm0ZP1sPD8/Sz43ohIoqTEj+Z0+re/G2ER/
         jijyLLJiFWixDmIW9jANXMtI4rBelTKjl9dXjr3ezWui2N7+4coLjnSLvPzK2GuuRN2V
         lYamTrSl8vQ75NcDeu1NmCwQui6bl8LADus7WwvK4ik1lrp/DU0wKpPW6zZZqX95f2aS
         EsJP02KrJO+ZMVVayguElPiq8O/nCeOdnxwDXMcXg5QlVd45l28jL0ojH7v+TcQ6nWAs
         5a+w==
X-Gm-Message-State: AOJu0YyjwcAuyuMn6HoXK0iWnjmexFjEKlhugN4FSdvqjB3GGdO13Sob
	W4OVRodNOg4kA9X0f8MpT94=
X-Google-Smtp-Source: AGHT+IHfaVeb5pa40UQ5llbB3GpHR5DyyHXaRrVQoEorRr+HC4Uhsq9K9o79iXrzgR8aCzmo3nVaRQ==
X-Received: by 2002:a05:600c:84c9:b0:40c:3828:b8b6 with SMTP id er9-20020a05600c84c900b0040c3828b8b6mr6522634wmb.172.1702682519320;
        Fri, 15 Dec 2023 15:21:59 -0800 (PST)
Received: from krava ([83.240.61.143])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm24081345wmb.15.2023.12.15.15.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:21:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Dec 2023 00:21:56 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [RFC] bpf: Issue with bpf_fentry_test7 call
Message-ID: <ZXzflOq-M51-gxmu@krava>
References: <ZXwZa_eK7bWXjJk7@krava>
 <ZXxhlG2gndCZ71Ox@krava>
 <de0466f0-58af-4eab-bc31-0297eae744ce@linux.dev>
 <CAEf4BzZM3tnm_CB8DW5GMJw=0AVES-ouZS4B22Gy+HirdP+otQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZM3tnm_CB8DW5GMJw=0AVES-ouZS4B22Gy+HirdP+otQ@mail.gmail.com>

On Fri, Dec 15, 2023 at 01:22:35PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 15, 2023 at 6:42 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> > On 12/15/23 6:24 AM, Jiri Olsa wrote:
> > > On Fri, Dec 15, 2023 at 10:16:27AM +0100, Jiri Olsa wrote:
> > >> hi,
> > >> The bpf CI is broken due to clang emitting 2 functions for
> > >> bpf_fentry_test7:
> > >>
> > >>    # cat available_filter_functions | grep bpf_fentry_test7
> > >>    bpf_fentry_test7
> > >>    bpf_fentry_test7.specialized.1
> > >>
> > >> The tests attach to 'bpf_fentry_test7' while the function with
> > >> '.specialized.1' suffix is executed in bpf_prog_test_run_tracing.
> > >>
> > >> It looks like clang optimalization that comes from passing 0
> > >> as argument and returning it directly in bpf_fentry_test7.
> > >>
> > >> I'm not sure there's a way to disable this, so far I came
> > >> up with solution below that passes real pointer, but I think
> > >> that was not the original intention for the test.
> > >>
> > >> We had issue with this function back in august:
> > >>    32337c0a2824 bpf: Prevent inlining of bpf_fentry_test7()
> > >>
> > >> I'm not sure why it started to show now? was clang updated for CI?
> > >>
> > >> I'll try to find out more, but any clang ideas are welcome ;-)
> > >>
> > >> thanks,
> > >> jirka
> > >
> > > hm, there seems to be fix in bpf-next for this one:
> > >
> > >    b16904fd9f01 bpf: Fix a few selftest failures due to llvm18 change
> >
> > Maybe submit a patch to https://github.com/kernel-patches/vmtest/tree/master/ci/diffs?
> > That is typically the place to have temporary patches to workaround ci failures.
> >
> 
> To get bpf/master back to green CI I did it meanwhile ([0]). Jiri,
> please check the PR to be familiar with the process for the future
> similar mitigations, thanks.
> 
>   [0] https://github.com/kernel-patches/vmtest/pull/258

great, thanks

jirka

> 
> > >
> > > jirka
> > >
> > >>
> > >> ---
> > >> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > >> index c9fdcc5cdce1..33208eec9361 100644
> > >> --- a/net/bpf/test_run.c
> > >> +++ b/net/bpf/test_run.c
> > >> @@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
> > >>   int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
> > >>   {
> > >>      asm volatile ("");
> > >> -    return (long)arg;
> > >> +    return 0;
> > >>   }
> > >>
> > >>   int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
> > >> @@ -668,7 +668,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> > >>                  bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
> > >>                  bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
> > >>                  bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
> > >> -                bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
> > >> +                bpf_fentry_test7(&arg) != 0 ||
> > >>                  bpf_fentry_test8(&arg) != 0 ||
> > >>                  bpf_fentry_test9(&retval) != 0)
> > >>                      goto out;
> > >> diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
> > >> index 52a550d281d9..95c5c34ccaa8 100644
> > >> --- a/tools/testing/selftests/bpf/progs/fentry_test.c
> > >> +++ b/tools/testing/selftests/bpf/progs/fentry_test.c
> > >> @@ -64,7 +64,7 @@ __u64 test7_result = 0;
> > >>   SEC("fentry/bpf_fentry_test7")
> > >>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> > >>   {
> > >> -    if (!arg)
> > >> +    if (arg)
> > >>              test7_result = 1;
> > >>      return 0;
> > >>   }
> > >> diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
> > >> index 8f1ccb7302e1..ffb30236ca02 100644
> > >> --- a/tools/testing/selftests/bpf/progs/fexit_test.c
> > >> +++ b/tools/testing/selftests/bpf/progs/fexit_test.c
> > >> @@ -65,7 +65,7 @@ __u64 test7_result = 0;
> > >>   SEC("fexit/bpf_fentry_test7")
> > >>   int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> > >>   {
> > >> -    if (!arg)
> > >> +    if (arg)
> > >>              test7_result = 1;
> > >>      return 0;
> > >>   }

