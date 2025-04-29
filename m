Return-Path: <bpf+bounces-56888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B124AA0025
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 05:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB627B036F
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C462C35972;
	Tue, 29 Apr 2025 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIbAqx3R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC391876
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 03:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745895640; cv=none; b=EN2rXGiXqJQzxFvkzDz47i2R9AAVp8m/bVc+w1Yx2vChjWftRv8/jPfSkQnMTI97g23zmE8JaF6wXbZmvXn/icRGg6EpHsM+nPA6rMLFhgL9KAZyv53fZUh4b+CW30f8Kl7A1DWQHUZxv2LkXkSMWdDdcbWRzJvdfTimTaus2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745895640; c=relaxed/simple;
	bh=eEchu0jevRjy9n7XKJV+Vm5Zo3UhcZlg1sheXa8mPq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k19VzGtiVEuZ0ZB9sMb4yGEEPzm/mbvoHAqn5HsXFPaaCWa0kW8tZzIKcVY+TNWrjl9TJMieLobvhuaZzA1ItdIbfyO6MfT8q7k8ExM0NtCFChaUu3m/0wFNVfJO/R5hzES6hu6uqh9LHEf2B2kfuIug5HlzykL5/pB0RK55UGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIbAqx3R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso11845e9.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745895637; x=1746500437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXmnnMlOMz9HXYjqkmk0j99jq6uUz0PM4YYUHpKEw7A=;
        b=qIbAqx3RmNtsIXuFeJqtTC9W7jbuPSIjfRZZbMbR5XcCB0gLWwFxg48ON1MQk6Nqm9
         Tss5A2UZ1767UYShI6EkjMEddEGsmzFkhdex8UqCI2yCgHLoRjriJgkIRTBWFG1E8yJA
         SDhuIPdeIcE13PxQNRJd8QnCHVwcVtb7JwiNliw8Y5Ox9HAEtnce7K+t+6JOlvlRUpE8
         ax7lf9PiFWk44pnaG9itgqOwHDD4BZfyw4rUeNeODCz6ptVsQOjuQA9uAllu5bSWXiAc
         TRzmr6iCZkTP9U05AQUu2hHFEESRGvuJx4eBlmiYmDZUXQR/Hg5UigmhcG05SPjnarCw
         BR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745895637; x=1746500437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXmnnMlOMz9HXYjqkmk0j99jq6uUz0PM4YYUHpKEw7A=;
        b=DxV54A+5GtONDHCBvsnk0Y2rBo50KGjK66rgm7CHcXb0uvNfELYB1bghZsOJV7lTLk
         ggwgLn36tQ+wLFq41IqSE8u2a+2uVCbwPY0neEs5AMdORphmiECAHVBL3h3QY6WaJbbH
         /EswQtcf7ZUQMkdqsGMj8NadU0d9VnRgZ8UHUbIZtIaZFFbFEO+/qhj+En0/u83x4TTX
         wxyxVoOQUZ+bo7Dnl3+zPdoP/M7mj1vTkWwpUWkLCP+Vvm8rG2avT8PTx9VzwV8/9smq
         70H76MZ0+bCHmJ0p2EfFCqdqbC73XpfvVtLwnee2JP2Fyl03o4r94yPXKtLLaSSgv7ms
         KB4w==
X-Forwarded-Encrypted: i=1; AJvYcCVr5cUo/5lz/oHIrKJIPoYa8MxR3NevEjg0aISg2J3wjQhmdsjly9Y4tHIuC3xVsUBZgpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRdEZrcNI0FCF1sKxR7lP5QPhUYNaSVY7ERd3t7eY73OCBvTA
	OA/WB7z7rwg7gYor8fZhNWgvT9hpnh7bU+6Y9iZ4rG8+ijEn59GPkko/Z3RXtC6/BJRImFchvnw
	J9ozahmk9EW3LdO/8wDQJfgMSsNVR16HswLrE
X-Gm-Gg: ASbGncvLva2b8Y7I9au6o9hdQtayDvg0ZG/A9Xa2+uCrA02CkdWX/J8XCnbuf3TbwS0
	J+PHOuG74u9X/TjkKLZRoPmvYC4tWFsMw2RKauzkCtp241rGcKWQaAhrDrxK4k7oEfpB2B+WWjI
	Bh2AxTxRfx9NfoS4rOyU1H
X-Google-Smtp-Source: AGHT+IHsE9sPW2ALzneXpyU3pp853ePANsnTKlaCQrAw1N98lky+V/YLF8kH9Qb801Y9M1a0qMiqDnJxZP+S3uVu77k=
X-Received: by 2002:a7b:c4d0:0:b0:43d:169e:4d75 with SMTP id
 5b1f17b1804b1-441ad653ea1mr266515e9.1.1745895636688; Mon, 28 Apr 2025
 20:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428180256.1482899-1-tjmercier@google.com> <aA_fwbubEEDjolYX@google.com>
In-Reply-To: <aA_fwbubEEDjolYX@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 28 Apr 2025 20:00:25 -0700
X-Gm-Features: ATxdqUFLRXtkCSlGd4q-1Xn10l2gIz9SiSK6SIAgqXzhFUZ70cW56VPNviF4EDE
Message-ID: <CABdmKX3QiJupqcHvb9O7Du1h+dVnTAo1D2Upq-Y2dX+XJSk_ng@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix kmem_cache iterator draining
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 1:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Apr 28, 2025 at 06:02:54PM +0000, T.J. Mercier wrote:
> > The closing parentheses around the read syscall is misplaced, causing
> > single byte reads from the iterator instead of buf sized reads. While
> > the end result is the same, many more read calls than necessary are
> > performed.
> >
> > $ tools/testing/selftests/bpf/vmtest.sh  "./test_progs -t kmem_cache_it=
er"
> > 145/1   kmem_cache_iter/check_task_struct:OK
> > 145/2   kmem_cache_iter/check_slabinfo:OK
> > 145/3   kmem_cache_iter/open_coded_iter:OK
> > 145     kmem_cache_iter:OK
> > Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Oops, thanks for fixing this.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung

No worries, thanks! It's been helpful reading through this code.

> > ---
> >  tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c b=
/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > index 8e13a3416a21..1de14b111931 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kmem_cache_iter.c
> > @@ -104,7 +104,7 @@ void test_kmem_cache_iter(void)
> >               goto destroy;
> >
> >       memset(buf, 0, sizeof(buf));
> > -     while (read(iter_fd, buf, sizeof(buf) > 0)) {
> > +     while (read(iter_fd, buf, sizeof(buf)) > 0) {
> >               /* Read out all contents */
> >               printf("%s", buf);
> >       }
> >
> > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
> > --
> > 2.49.0.906.g1f30a19c02-goog
> >

