Return-Path: <bpf+bounces-78417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E18D0C728
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCDEF301B66E
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C9345CA0;
	Fri,  9 Jan 2026 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ok6Siap8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8A340D92
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997196; cv=none; b=C9pAvZfpAaVRLsO8tl8HW8hXf6SHSOOeL5R93AjfPg1WV5P8vGFhemSrophU0Q9gl+8Y4mfjMgjxH6Zj+FtLUX8Sn9xzn9MkCjFrkRwjKQRutovbbp5FYFVrm5/236o3Wq1/yA+uo8xVWpw4vIl/TLfiktnI7ez125zUm8dMORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997196; c=relaxed/simple;
	bh=n53gzJKeiVcKgr8BVkCVCeMAGB994GLjzTCcZCxH4jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5kob/WXxnMAaHw6aECmiX+49I5BfkV5MGII92YkaXm805Qx907qvokrPIkSdJ1dyDCCEAr8XsIXR58XjBFzrxB/BQpj5J4YOEfUaRq4RyjebKkVwaS+I1KvXhnzOLEOhjKOYxlYjdDGN3PdKyj4XcC/hSxSaPCPfegzmScOFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ok6Siap8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso4549036a91.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 14:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997193; x=1768601993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkTXW2+0QLa+/q/JZGCIrrfHToWWbWXR6B3C7QyG5P0=;
        b=Ok6Siap8OtS+Dv6JahCCmh7+4wlXppRGtQhSGXEUZ4QiuH3rx9rXlUhoUgEPrWrumU
         IXC2Hd5C3PLwKhpSWoildkNrKE/Ylf/ViYIbFsxesmn08I//AqbvgJDRGlTJ9vVCbBV+
         8xti94lY5W3J7aNdKis0wTpjLPGMLQfN7n12AaIlHfhmyyALd3IJLzJnzkcAalQZUQUe
         QhSiyCOxlzzvL8fY9/up4yIslmbijIhkOCO3CNEWPpn9FiMCYlXQsT5RVsCbf9EWVsbf
         btTi/EQWYryqkb7mlp+ZIcrU2Cn8o6EoEUEMMD4n0wj81/AGVRk9295FhsO/eu/4BeWW
         u+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997193; x=1768601993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkTXW2+0QLa+/q/JZGCIrrfHToWWbWXR6B3C7QyG5P0=;
        b=VIkZ57Uc6sb4fLGjsqzT/JvJTOUt5yG+gznYkGsgSTpeDB3Yq9lA62t6Jl9YklnhXv
         V9hA/PlHkJ881YIq/AWnP5CyQtZvWVORphqCJhL3hC4dEnrCOXwsebiBXsu4ehE5QIUg
         bsE4rfifkSEfQrAdJ/HQ2K5F+XwxX9QsljHDf4vvp/ITp6LPF6lBY7sbRtQJxingjzwH
         yTCAaHJpKoJce8kxo417nN2uDiNWQQB9mavFR6jagpuhg1+PThuPtsounHYV7BW7D2Fh
         iIOuj/NwiofLlSBAqs7aktbGqo1udBgAU1s6dtL59hxBIy5NkhpBu4UFxc7FlciPvyc0
         JZ9g==
X-Gm-Message-State: AOJu0YwXP7adOBODIl+nyQylIYyN49xj8CcREdJPp/+3AJ3FDEETRMEO
	w5xyGdrXuZf6/RqHeK3tGs1AJoWBhfs978CZb8TWD196bV6j1xAQ+V8uAQceDeuW2AJ0WRRLQ5/
	x/Ta6aJNtmBu2wxmUWztvOoHEM4HgJKsYtA==
X-Gm-Gg: AY/fxX5c+u4h/JjWRQPTzpM1OrKvGWJNoBKUv2gRzau7VDD/LOEUXzSX0FSv9mfoIjH
	lR/CWuPmki8/qq0PC9qTx/4kvzP7yHWo9xXfIUtsMrnaLLfAMcV993/bZT7EL5Q/pJdLmzFptiI
	2vUlY5EVRpyf7PZsa77YucEFWlG1pc3y1r4Ws5lDxC4g6jeyr+K8JBM3Gv1sZbPiv1o3SEZSRcI
	CbMPOuBeJnzBk0fTYK8bEcBi4OZDCiTxMU/+b/c7MSB/IR27knLb5pQccyTsOdHeA4GJMniGW1k
	xbZ6O7FR
X-Google-Smtp-Source: AGHT+IGu9kZTlIj9OcJzaMN/P4DGB4iRX57W6cw4nlRYvpkwEkgiyl/jzdDVg/KDEbp0TtNchFhdfV0KeY72NCPv07s=
X-Received: by 2002:a17:90b:3891:b0:34c:f8e6:5ec1 with SMTP id
 98e67ed59e1d1-34f68ceaddcmr11364630a91.35.1767997193530; Fri, 09 Jan 2026
 14:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com> <20260107-timer_nolock-v3-10-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-10-740d3ec3e5f9@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 14:19:23 -0800
X-Gm-Features: AQt7F2oT-SvD-ncdVvty-TLdvjOFvjJYeYSBPg-ny6DWWjUox7d4LDFSDV8LUaU
Message-ID: <CAEf4BzYBrxSaFkNE1Dy=EESph8OzxKjtGgHL-WhuVwtibV4VLQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 10/10] selftests/bpf: Verify bpf_timer_cancel_async works
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, memxor@gmail.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:49=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add test that verifies that bpf_timer_cancel_async works: can cancel
> callback successfully.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/timer.c | 25 ++++++++++++++++++++=
+++++
>  tools/testing/selftests/bpf/progs/timer.c      | 23 ++++++++++++++++++++=
+++
>  2 files changed, 48 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
> index a157a2a699e638c9f21712b1e7194fc4b6382e71..2b932d4dfd436fd322bd07169=
f492e20e4ec7624 100644
> --- a/tools/testing/selftests/bpf/prog_tests/timer.c
> +++ b/tools/testing/selftests/bpf/prog_tests/timer.c
> @@ -99,6 +99,26 @@ static int timer(struct timer *timer_skel)
>         return 0;
>  }
>
> +static int timer_cancel_async(struct timer *timer_skel)
> +{
> +       int err, prog_fd;
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +
> +       prog_fd =3D bpf_program__fd(timer_skel->progs.test_async_cancel_s=
ucceed);
> +       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       ASSERT_OK(err, "test_run");
> +       ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +       usleep(500);
> +       /* check that there were no errors in timer execution */
> +       ASSERT_EQ(timer_skel->bss->err, 0, "err");
> +
> +       /* check that code paths completed */
> +       ASSERT_EQ(timer_skel->bss->ok, 1 | 2 | 4, "ok");
> +
> +       return 0;
> +}
> +
>  static void test_timer(int (*timer_test_fn)(struct timer *timer_skel))
>  {
>         struct timer *timer_skel =3D NULL;
> @@ -134,6 +154,11 @@ void serial_test_timer_stress_async_cancel(void)
>         test_timer(timer_stress_async_cancel);
>  }
>
> +void serial_test_timer_async_cancel(void)
> +{
> +       test_timer(timer_cancel_async);
> +}
> +
>  void test_timer_interrupt(void)
>  {
>         struct timer_interrupt *skel =3D NULL;
> diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/se=
lftests/bpf/progs/timer.c
> index a81413514e4b07ef745f27eade71454234e731e8..4b4ca781e7cdcf78015359cbd=
8f8d8ff591d6036 100644
> --- a/tools/testing/selftests/bpf/progs/timer.c
> +++ b/tools/testing/selftests/bpf/progs/timer.c
> @@ -169,6 +169,29 @@ int BPF_PROG2(test1, int, a)
>         return 0;
>  }
>
> +static int timer_error(void *map, int *key, struct bpf_timer *timer)
> +{
> +       err =3D 42;
> +       return 0;
> +}
> +
> +SEC("syscall")
> +int test_async_cancel_succeed(void *ctx)
> +{
> +       struct bpf_timer *arr_timer;
> +       int array_key =3D ARRAY;
> +
> +       arr_timer =3D bpf_map_lookup_elem(&array, &array_key);
> +       if (!arr_timer)
> +               return 0;
> +       bpf_timer_init(arr_timer, &array, CLOCK_MONOTONIC);
> +       bpf_timer_set_callback(arr_timer, timer_error);
> +       bpf_timer_start(arr_timer, 100000 /* 100us */, 0);

flaky timing-dependent test... not sure how to write a better one, but
this one is not great :(


> +       bpf_timer_cancel_async(arr_timer);
> +       ok =3D 7;
> +       return 0;
> +}
> +
>  /* callback for prealloc and non-prealloca hashtab timers */
>  static int timer_cb2(void *map, int *key, struct hmap_elem *val)
>  {
>
> --
> 2.52.0
>

