Return-Path: <bpf+bounces-69761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705EBA0F75
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8F07A8916
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3C3128AC;
	Thu, 25 Sep 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTFHOfxp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E4271A94
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823228; cv=none; b=I47qWbguUrb0aIxu8JZb8p3MhX9CsE5UOC/cFiXhSPGp+95sjIGGmdiqvKmUASzKevxbH5livLpn2CDjHQbg1tsLyHPPIWxn2Rr0Ie9iZXVyjCyUXCGktQ3t1JoagA+0XdbI0g9E5xv78Rc3yY7BHckKi9kWbBvClRf/J8dr4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823228; c=relaxed/simple;
	bh=L2BcYyWDTOEUzWsdYyJv+HOsCNdtUdd8cbQVDtSWkJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHnLJgPBUZmOAoUy1r0sKD7tHugarpu9ZgyxaAz8Q2+GmYUtNbwMa6fTwBF+VDEZoiZ7WIcRVA9/9q8EapwIc7XSH008FydCVIMdpSf0yGAUxUExG0e72bDOCULaD1mYvPrJVT2HVQvF8lWFF36EDi06Bd6Q403N67zjubOktls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTFHOfxp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so1609308a91.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758823226; x=1759428026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UR7A4j6sdHK0HJW0KPqFlfvSz2vgaALw9Xdvvlzhok=;
        b=RTFHOfxpeiDFx7RfzMtSkjJfl3VJ6RM10ILzHouCxjcVQF5tRDNvDa2il0ztN+wh52
         9eFfkOV1I1yzM7dJDZ7KmExeX1i7u9GlL0kTzcSHMRFRK/zOykt/mYJIJCOAlx7YuLXG
         ZeD7V3nGYKzhaIByt3Orb+7PNRMsHjWd6WeMkBfZHvpIGC7qADS0lxXFTVeCkofAqbJ+
         djPhrihEVjm/US7zPjrXkQGDaRUva1SzZGvX8kVyjzylcRRe6ffZlkEeFeghWPxj/mKt
         2HxClwVmbHM8Fy+IDEWJVv8IIyPxUm45qDgNfi8uGanZtQlz+xfbgE2AGYgveHWm9In6
         In/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758823226; x=1759428026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UR7A4j6sdHK0HJW0KPqFlfvSz2vgaALw9Xdvvlzhok=;
        b=SZuupPNtkHtKPMqce93nQrcHpOKh8EYPYshx7qPfutU00Wd+j5Cf2y1Hl3qNvGEuTN
         EizFBvY/yxh131EDAmi4ZhdzCUdolUX1uZAf0vFOutmWlSVWEX6Fb1iSYQ239wlanbOc
         w1VbVr+Fhrg9K5LETDqz51YaOLiWJkheTOKZLCOtWNIEHvkwFSPlZHAVvzv+8JBcNaPR
         OtmYbD0VEMgg40doThbz1R55kMgX7EOfgZ3t2EaH+stNkj6BpvjpgCqccGH9apvVb57q
         TmOB+1CwJL5V2fKzvuV3/NcgQRjbkbVRO4OazSF9ZvjuQn0ozWoQHTJTAQfVT+n9PwV5
         8fOQ==
X-Gm-Message-State: AOJu0YxtYyQicp2Kkw1u9Q6b3Qgyq3qggvfzzmNsnejPI9swayHO7Zwl
	NK4jnh5jH9VDFflGU/w1d/MMYq/ESa/F9p1FngYfvntXsCypWPx5ffai1yR2T4/Dke4uEfGbIAD
	wJsCRtTWaHOp5mM+f23tBOiRdP9VwHmA=
X-Gm-Gg: ASbGnct/hm0XnReBCfhPVmpU58gE68B5f71o1ofr7rv4bN6uyK6Q9g86hu62HjWM/DB
	QZiTlMWeJs7s3oHDeTSKiiznluTAT0N9ATn7ojg9OZ4+zw8qEsGSsgtE30ZvBZQ8ScJTCo5xHFi
	SWX8wo7wDQXypTnZDZDst1DFA+QVsAPYqZR2KfYkWgM3UHuyuBhJ7cUk156p5f9VQab8NQOfO11
	mV6jC6YZwHqKIMeW+NFt9TarcYs6zPiFw==
X-Google-Smtp-Source: AGHT+IE3xVOyU8i8lVYZrkuVf+RCCmd74wE9ZTCJ3RVJRj6D+lZy45Y+IOhNPx8YuV9xsYdVuQvhZCLIHSl940YWDz4=
X-Received: by 2002:a17:90b:314c:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-3342a2ae68cmr4503015a91.23.1758823225626; Thu, 25 Sep 2025
 11:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250924142954.129519-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 11:00:11 -0700
X-Gm-Features: AS18NWBvx6aaAOTSl6hQJ9o_5tTLiWvRpG39bJSsWxCfYrZYnvRmamSoALBLwTM
Message-ID: <CAEf4BzZBqj09xup-MWed3yEzTBpw1=PdnL=4fyk6gDGDjA-sUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: fix flaky bpf_cookie selftest
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 7:29=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Problem:
> bpf_cookie selftest fails if it runs after task_work selftest:
> perf_event_open fails with errno=3DEINVAL.
> EINVAL indicates incorrect/invalid input argument, which in case of
> bpf_cookie can only point to sample_freq attribute.
>
> Possible root cause:
> When running task_work test, we can see that perf subsystem lowers
> kernel.perf_event_max_sample_rate which probably is the side-effect of
> the test that make bpf_cookie fail.
>
> Solution:
> Set perf_event_open sampling rate attribute for bpf_cookie the same as
> task_work - this is the most reliable solution for this, changing
> task_work sampling rate resulted in task_work test becoming flaky.
>

All of the above is not very convincing, tbh. (and in parts just makes
no sense at all)

A better fix would be to change all those perf_event triggering
dependent tests from just doing some fixed amount of work (like 1
million loop iterations) to time-based waiting for BPF program to be
triggered. And if it's not triggered within a reasonable amount of
time -- only then erroring out.

I dropped this patch for now, and applied the second one only.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 4a0670c056ba..75f4dff7d042 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -450,8 +450,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         attr.size =3D sizeof(attr);
>         attr.type =3D PERF_TYPE_SOFTWARE;
>         attr.config =3D PERF_COUNT_SW_CPU_CLOCK;

test_task_work test is using HARDWARE/HW_CPU_CYCLES, what does these
two independent perf events have to do with each other? This "fix"
makes no sense to me, it's just hoping for the better.


> -       attr.freq =3D 1;
> -       attr.sample_freq =3D 10000;
> +       attr.sample_period =3D 100000;
>         pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG=
_FD_CLOEXEC);
>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>                 goto cleanup;
> --
> 2.51.0
>

