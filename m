Return-Path: <bpf+bounces-41679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4609D9999F1
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CB01C23104
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346D17BCA;
	Fri, 11 Oct 2024 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMrFkuFX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7D10A1F
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612267; cv=none; b=MCP77G5lIXDgHvlCtqqyhUfXdQK/wKtecG9/hgjCixQ4Vi4LgTc4dBacXawAHjm3HI/0FgUAublQkX1kvcqTlW8PI1O/JublegK6UfRAP01FkG3KZEO5GcOtj2GpOmy0Hgaq1nl4i9K79QgL5Bt1PAsBNcARbTmc9uwqtjFSKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612267; c=relaxed/simple;
	bh=RqToXKlGxuZooFXaMbgAOI6ZqcAvOViUnrPASYExMac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzYuWqOxByw23hqHOeTqIUXwdPgxwyTdMfeCnumstupI/DOcKM4psycfyQGlkF06Gk8lEL6L8oPzNwwRqb8UpMF4HrBC9yM4LZuyA3YP8OJW6LfkS4j3GEcueRVJfoqpb1fbMNofmyf7tnU5ifMA/EYt043HLASRRva9Q7ab0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMrFkuFX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so1205218a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 19:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612265; x=1729217065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51OxZu0LnjLp5HtYVYyzlulH9mglQyvanklDK/iyTgs=;
        b=fMrFkuFXpSWuucJ5grEfNYZ/DJM8p5qvB6qo0/sDz2RSwJBkAFyz/YP4M643lJZ1A1
         xgl+g9+ALFP9kMWfXJB/mSt25Wtd/Ma3hDlk2FSSS06VnS4Z/YRvF6AD1wYiIfMtbZ2B
         bOPrqVc82t1ybyxGcYfS9o+8ZkC/ECujup5m931yUwjEjiplM8dXjLYdlsKrmmFdI/bE
         LuKEbwEBXZzEVyN92P9YXxmrkgBvyOcfxTcbHqtfp/DdEvlHwzDokj1cpWdj6MjZ+m8k
         YvXJlq+Bkd4VqpaR3V7nBHH3Rqb2T88FEI56eapRLoTUiiOIWMszlFRhHEmgrs8br5LM
         JqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612265; x=1729217065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51OxZu0LnjLp5HtYVYyzlulH9mglQyvanklDK/iyTgs=;
        b=OyGVIDRdf6/+YiIiIsayLNVeatTkiNCjZEJHGzZt+rzK1lvaPeumtfsdYuSd4dWHqM
         qf/nko8FcAPgcuYoPCrCGg2pZTLfHIYP5ChWj+1w+MohlQzaW0aI8Z+F9y274zF6eGFQ
         QAgUs0gDCBDMZwW9/pEJwiXIbFrClKKhc5/0W++ePvhrovMcsoqBU3gqsIssJ/5yGXLC
         CTVsDvO0v2Rxg25NXsb5UsOexJ3GI3biWqbSnuKLLjhP9AOVVUyZASKtl4GOiSQlprHU
         ei9usCwxqhIsHITE8/R0CLV8gCfpnhqhlkJViLGis+z0R/HPNCwqc/QzlO8Tly+v6+GH
         MkKg==
X-Gm-Message-State: AOJu0YzjhjH203VnBigepJVHDN2hDmqVHMGXbl9jgvwjrD7zBGs9GaDt
	QP2PlGtK86KyVeOVhr5G84YOhWEVjY558ip+ZsApvlO+L/Uj3lvcnOkcYx9/yOme+RltCR6VsHj
	iq3xVaimyYilxMIb6a20oomhQ2YM=
X-Google-Smtp-Source: AGHT+IGlCT1yxgEbJDQcBgI2Mv5kGgfWdzVIj7aZHnmYP9QfJdZWyrU4miMFczrhuYzZPpQjTDroJATn9MHe+Rhc1io=
X-Received: by 2002:a17:90b:438d:b0:2e2:b513:d534 with SMTP id
 98e67ed59e1d1-2e2f0d8ceb9mr1658780a91.37.1728612265297; Thu, 10 Oct 2024
 19:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me>
In-Reply-To: <zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:04:12 -0700
Message-ID: <CAEf4Bzb1gKB3SEKiS-VGY713YgVhh9tbDpeOwQO5vVMN7YxKvA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: check for timeout in perf_link test
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:24=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> Recently perf_link test started unreliably failing on libbpf CI:
>   * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/3131240=
5473
>   * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/3131551=
4626
>   * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/3132045=
8251
>
> Part of the test is running a dummy loop for a while and then checking
> for a counter incremented by the test program.
>
> Instead of waiting for an arbitrary number of loop iterations once,
> check for the test counter in a loop and use get_time_ns() helper to
> enforce a 100ms timeout.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/prog_tests/perf_link.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/t=
esting/selftests/bpf/prog_tests/perf_link.c
> index 3a25f1c743a1..c1f13d77c464 100644
> --- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
> +++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
> @@ -4,8 +4,12 @@
>  #include <pthread.h>
>  #include <sched.h>
>  #include <test_progs.h>
> +#include "testing_helpers.h"
>  #include "test_perf_link.skel.h"
>
> +#define BURN_TIMEOUT_MS 100
> +#define BURN_TIMEOUT_NS BURN_TIMEOUT_MS * 1000000
> +
>  static void burn_cpu(void)
>  {
>         volatile int j =3D 0;
> @@ -63,8 +67,14 @@ void serial_test_perf_link(void)
>         ASSERT_GT(info.prog_id, 0, "link_prog_id");
>
>         /* ensure we get at least one perf_event prog execution */
> -       burn_cpu();
> -       ASSERT_GT(skel->bss->run_cnt, 0, "run_cnt");
> +       __u64 timeout_time_ns =3D get_time_ns() + BURN_TIMEOUT_NS;

nit: this is not really a kernel C89 code style (even though we don't
enforce that in selftests, but still), can you please move variable
*declaration* up to the top of the function?

> +       while (1) {

nit: true

pw-bot: cr

> +               burn_cpu();
> +               if (skel->bss->run_cnt > 0)
> +                       break;
> +               if (!ASSERT_LT(get_time_ns(), timeout_time_ns, "run_cnt_t=
imeout"))
> +                       break;
> +       }
>
>         /* perf_event is still active, but we close link and BPF program
>          * shouldn't be executed anymore
> --
> 2.39.5 (Apple Git-154)
>

