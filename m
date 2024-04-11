Return-Path: <bpf+bounces-26485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55918A0671
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 05:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402A9B23421
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 03:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0474813B5AC;
	Thu, 11 Apr 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/gi5FtC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EB13B28D
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804494; cv=none; b=RHJmc6uQkflmUNVrgpA10L178VBydlWQPXDJCmOE7ZB7oInoMv4eimA+FxNgns/+awpTiivR5MGaW9JMrjmGjRXS0QCvDnsAtKjRufqG/8EBLRP9LYJjLao2Xtae81yh1SRn6Xf/PWNiFA/EiFpN8quymheZUrO/iQLu6p5h4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804494; c=relaxed/simple;
	bh=Kp4LrZzRLN37vnBfjjzM3TYt662A86dD6Xiu+mcyoUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qt2y1h4aELaxBYwXsK9iL/2288xk3zV5PClu/bE5xdGs4/1oP6FqCV1vSuiTmsDszEKVGq7k/umNwxP6EoviZbvt6633xsZDBvA9nxr8qOHKfh+nIMy+m8TRffY9h5A6zrBRhg7m86JqgMuyoWUpj6/QqOirSrkUru4P1Chs5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/gi5FtC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417d42dd5a4so1874175e9.1
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712804491; x=1713409291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdqPrzqevpkyNHolwH4KHCwVDWapkvJpnQL3sORyXZM=;
        b=I/gi5FtC3oyTEbv3edU4hOGVtVhKZUJ2JeIjwLjomFMWq8aXF525BGHJBnjN5S/Tx4
         tUedNy4xR8/VJ6CZNBKXjZeDUkVU54dgN5BLs5G9E4Y5racLxaA1mApFyveA94FhMFEq
         N64HOyT6pAf6PNV64CgDDByme263oS2Sz5Taixb52V63I6vdk+STemasKhbpfpcljo/I
         WoasmeCEs4A1uOlf8FRrsgqipk+nmyAMEQ0dCgidjMfHM+byrVQfjbRx5bRSAEWS9kUf
         yAweucP/Xwz7bGwTBN2Kgk/UWNVcmIXpqB15ldPN0f3n08e9v+WXRQ1x3SqN95puEK+D
         ZVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712804491; x=1713409291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdqPrzqevpkyNHolwH4KHCwVDWapkvJpnQL3sORyXZM=;
        b=I5k0XnvMYjyOWobT/dK4MBLg3kDjceulZrFMGd88VK5HlUF1xFFzYyGfGVvUMzUXB0
         H1Bu49J9aT35X6bMdAwu+4DwlPPKWiQcNYWCd3ynvhKzMkKs8K74m0b6h2On1RhuM9oB
         81EtfoK+tYKR76b96VON23uyE5j4AZj2qkbiui3ZD3MJskxtOsUKGI2BXdmrB5MGzLcN
         LhioqzLrX6569u3wUgyJqyuS+IYyg8tl+Vm7RokDjVli4SptCgeQWz82B1lLaZP9T89X
         o87jr1Vt1V8ggRtfPxsmF6tg9oy1AfT+5pgXYZtwHxy9NG7AmtVrpQm4J1lyPt5mbsg3
         WvDQ==
X-Gm-Message-State: AOJu0YwXi0aa0YcIJi+iPULk2sECpLHKLU46kXpir8D0zVYWmITLk/6I
	MLjMEfY7IC2FZ2CrG/dXlOArzjHC3le8N/L5pBQ+5rB4T8pLxA0w9bZ86VpfG3pdDIBl4O0Vc2q
	LvQejbU6utCmlEPjmsaZg2Jm27KmO+A==
X-Google-Smtp-Source: AGHT+IFgfaRKWxRmzeQopusptfPEH9JNzcnm/w5Fy1xBW/HVXCSpm3Q3DUP/KTVyh+M4id5ABhffQZF9fgQOK5Usj6U=
X-Received: by 2002:a5d:56d1:0:b0:346:4f81:d158 with SMTP id
 m17-20020a5d56d1000000b003464f81d158mr3957658wrw.67.1712804490892; Wed, 10
 Apr 2024 20:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410153326.1851055-1-yonghong.song@linux.dev>
In-Reply-To: <20240410153326.1851055-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Apr 2024 20:01:19 -0700
Message-ID: <CAADnVQLydcELAuYE=PZK2-C=8sCeczMZpGzQhX3j7Sjm=W72Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable tests for atomics with cpuv4
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:33=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> When looking at Alexei's patch ([1]) which added tests for atomics,
> I noticed that the tests will be skipped with cpuv4. For example,
> with latest llvm19, I see:
>   [root@arch-fb-vm1 bpf]# ./test_progs -t arena_atomics
>   #3/1     arena_atomics/add:OK
>   ...
>   #3/7     arena_atomics/xchg:OK
>   #3       arena_atomics:OK
>   Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
>   [root@arch-fb-vm1 bpf]# ./test_progs-cpuv4 -t arena_atomics
>   #3       arena_atomics:SKIP
>   Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>   [root@arch-fb-vm1 bpf]#
>
> It is perfectly fine to enable atomics-related tests for cpuv4.
> With this patch, I have
>   [root@arch-fb-vm1 bpf]# ./test_progs-cpuv4 -t arena_atomics
>   #3/1     arena_atomics/add:OK
>   ...
>   #3/7     arena_atomics/xchg:OK
>   #3       arena_atomics:OK
>   Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
>
>   [1] https://lore.kernel.org/r/20240405231134.17274-2-alexei.starovoitov=
@gmail.com
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index eea5b8deaaf0..edc73f8f5aef 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -658,7 +658,7 @@ $(eval $(call DEFINE_TEST_RUNNER,test_progs,no_alu32)=
)
>  # Define test_progs-cpuv4 test runner.
>  ifneq ($(CLANG_CPUV4),)
>  TRUNNER_BPF_BUILD_RULE :=3D CLANG_CPUV4_BPF_BUILD_RULE
> -TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS)
> +TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_T=
ESTS

I noticed that as well and added to my todo list to follow up.
Thank you for fixing it sooner :)

