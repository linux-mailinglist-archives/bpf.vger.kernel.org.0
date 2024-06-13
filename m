Return-Path: <bpf+bounces-32039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD5D906239
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 05:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478BE1F224E4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFA12CD8C;
	Thu, 13 Jun 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtMoEi34"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6018028
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247744; cv=none; b=TYwDZp3yTZGcx1MX9HhBClFm2uuWI37mgUzYaGU7NQq4zWjOlzY9Ih2bK59m0ZTkGjXcCbUcUZ/c0NrcH8OCGviSK2SM4/91ZjGaA7uZ6O6WBqPMpqMEYkWg410lwGbTHFLwjzcCQ0GaKTeGjSYVx0AZf6Kh5v6cvWyUls+/UK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247744; c=relaxed/simple;
	bh=8CmEJ3ob565scTgnCo1rtvV2Tyc7S6GOcQeN8V55eGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rc0z020eLGo/UdCU/4nMax0TH4U05CwtJ+yNQI6Tr37VGaXQJk4Tq2KmogknyUHh7zqr777N8sFZoqaJu7Oo02p/ym+cfOGpQ+a47EAD2jdE/+yhYlR4l/B43D2qDz7R58H7aQNrV1b89x7dbxZXrDII54+jrL46ZG+/caaqxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtMoEi34; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42108856c33so10064415e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 20:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718247741; x=1718852541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2IX17eR92SWdGI/QkTlnGG8BYIbW6LlPdWiLMErERY=;
        b=MtMoEi348Dv0oPMoAm4HQXo7EsfSszxfTxKDqNIUThmkPxkJID5ZIo0o+R1n5yLAlx
         0KJOm4EE72Dz/1aLRmLdlKg3L84UXX0QvXDPrlszuuYxNRl7nbLwfW3ZVLV4M92PNeis
         11e1ktUxNOX0LyqZoXzriTaE0HMCTXQnW1Gu4V6wFHNggTUY1V3S4nM5JT3fkNfqDByF
         UR8nWnQKAp/qL6gntAnqCFnOrS/cxDBpmlURbXCirslcFGnshDpA3JFJ+3UFhmWJFoof
         i25b16JSpHinxRAuEPnEzoyiQKeMlTL9Y7PVBT8Ucl4uXk2NtMYJ8siIaaTU0+RCVGP9
         aMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247741; x=1718852541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2IX17eR92SWdGI/QkTlnGG8BYIbW6LlPdWiLMErERY=;
        b=txr2cpNE8qCUcPue/JW1NaSfW2td39Bl/zqP7eKKoZNiD8ZVpeGD8xsUShxwUl49de
         +4WiYZAY1casMMoLROTp7fHZkNWgLh1tnH91hpmfTJojzrPf0Urv5+Am70+13LdayGci
         MJ2spyNtDw3++esnzALEvBQXHi864eahrNQvPfcLAytCwPAXy93sCTf/Lp5JgWjWSByf
         CT4lfXS/DzbfKS/5DnDWxg+slDXRdGKrx9R6JdbK3s+BayGaJlrOgWdwUsf+22WYRgyi
         J9uWLDlvzOXcNi8R8cX9n/+QbUIy5Yj8wWKi280AvtR1ksXgndN7h6Py1Rxu3lOyj6qp
         NeGA==
X-Forwarded-Encrypted: i=1; AJvYcCVnhaaeTTGBFGBMZKbXkOl8bP8/Mdw17GaJOcDQEbehoiEGTjIxSZJ1ehvG+i7NjLa9VRv9jYZq/flckaU0a9S8wjwc
X-Gm-Message-State: AOJu0YzCdrMryPLAlwAFR27cnpgP6hM7yHjwi7eV3AxSS6h/AWpNYxLf
	ktIyvTVHqx9aSWYmr+GMvCpwxkM7z6bnWJyeS0CxDI+KACet3CKE2+qdLFMCligdVc08+o6t40F
	CM4QFjF1Am9oFtr/K1PvOWvhlRAd8xA==
X-Google-Smtp-Source: AGHT+IHKjE4fb2sYKWhMd/Oe4Bfmv6XGfntS6quvwY6Tv6zlxvYR6WDXqstq/eC4OtVtr4wpVOKGafv+jvpfvK5iI6I=
X-Received: by 2002:a5d:6488:0:b0:35f:314a:229c with SMTP id
 ffacd0b85a97d-360718e51e2mr1312643f8f.28.1718247741220; Wed, 12 Jun 2024
 20:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613021942.46743-1-flyingpeng@tencent.com>
In-Reply-To: <20240613021942.46743-1-flyingpeng@tencent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Jun 2024 20:02:09 -0700
Message-ID: <CAADnVQ++WUh6H8ZkE3GT561X=ZbPDzWv+w3ivHo5zdnU5_cHUA@mail.gmail.com>
Subject: Re: [PATCH] bpf: increase frame warning limit in verifier when using
 KASAN or KCSAN
To: flyingpenghao@gmail.com
Cc: Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 7:19=E2=80=AFPM <flyingpenghao@gmail.com> wrote:
>
> From: Peng Hao <flyingpeng@tencent.com>
>
> When building kernel with clang, which will typically
> have sanitizers enabled, there is a warning about a large stack frame.
>
> kernel/bpf/verifier.c:21163:5: error: stack frame size (2392) exceeds
> limit (2048) in 'bpf_check' [-Werror,-Wframe-larger-than]
> int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uatt=
r,
> __u32 uattr_size)
>     ^
> 632/2392 (26.42%) spills, 1760/2392 (73.58%) variables
> so increase the limit for configurations that have KASAN or KCSAN enabled=
 for not
> breaking the majority of builds.
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  kernel/bpf/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index e497011261b8..07ed1e81aa62 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,6 +6,12 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno=
-gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
>
> +ifneq ($(CONFIG_FRAME_WARN),0)
> +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> +CFLAGS_verifier.o =3D -Wframe-larger-than=3D2392

that's very compiler specific.
version +-1 will have different results.
Please investigate what is causing the large stack size instead.
pw-bot: cr

