Return-Path: <bpf+bounces-65243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E3B1DFF1
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCB566A42
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 00:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B4CA52;
	Fri,  8 Aug 2025 00:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6lus2SR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D9645
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 00:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754613125; cv=none; b=j/IU+VEiZ5HiunKJZqFpHTUox1nbFkd2GCaZdVBkAlLriehj4fg9Q5w+XFPzzgBDMNgzBzb1CUUNuzaEtP1yzrHF3KHlMb3P8yvIAawuEAg5W13KyvFeBq4C6GaivqJS1LTB3DC947uEnT12JY5hEoED8XixajSZoG85x8UPQLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754613125; c=relaxed/simple;
	bh=F6u0/6x2HBAheK6L5F1roodkpCVzfGsmaUQTld0v9c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udHV4RZMJwPEnArHy4743ugK6cGkXffC515+CBKcfEiBoqUIHJEjRD/IA6PB+8Wi92JrT8t7HH1WMdQrZHY95AAzYbgXaUrUEEyEBTA8I7xH6FNa6IEclK32/PY7FKwfIEyBJcUeho7U8zRMNxUzn9g8vn3f4CumBQp+u7NjA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6lus2SR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459ddf8acf1so13890285e9.0
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754613122; x=1755217922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHP6ZxV+zUx9Bhx6D0aeffPHvF1MtcqxssBHo+TsQfc=;
        b=k6lus2SR3lZ+0pivxLnjDnLDIwUgrP3+XkFey51WP/K8LIHYnOw4VwbnpAflmhvznh
         IvojpHuJsUYbWPsIdLylAy7zPEobBCcf2nI4hW6aSDpP05B0BTPLEVpUukGD+03heLSF
         St80qk57xwQsSkzDaM7Scb4Z4IgtzYbhbrfloXljTQmxZZYTTdDaN51wmw+1FS00ol8u
         9Tok4wO0tjyBKUSrFRvoMONCmFzLTMvTe5a/Zt6tsDPjpiIzrevrUKNgjAqfDPGchv0L
         kH8BThtPdOqxICFlLHknZ6WhcXXwPURjpWPtlcDlfjMXCGO1sOBweO9aagXzPzRdNiAD
         0MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754613122; x=1755217922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHP6ZxV+zUx9Bhx6D0aeffPHvF1MtcqxssBHo+TsQfc=;
        b=OqxzUkZqoYEDnWn+cgVI6osOjNo+ERHhWl3KEN9fsh4R5NTvHo2AZ+MU9Tt7tpXgAS
         ow9Kgfvacr+wAmMJrj+WBj7fEJkQGLU1JY2Bkkr0XoWMd/DOdPbUY4ctFE8RVLpM5tK6
         qWoOtfuIEOORJqTwA5cy5adpoP7LQiZv4fBB13+OojUlmymq2jazKMobF6LC3oVh6P98
         peJYU2WQGudid9FrJaJYa14ZDpCJcKZZT0Kjf1HC3bmNSzcjp21OVJXpzPtZwuK53jAH
         SFa/1UAkUgDXkU+d73lGoNwXKKbdMloy/IPn6BNN8pW743hM8L3FU8horz+qqsLejEX4
         SX9w==
X-Gm-Message-State: AOJu0YyYsoKeu9IoaHH5FCANRS+TQIhXpGMtgbbvjIFWdDXvybsTbfyk
	x3nypxfQ9SN6iiDrwfPNDqoomhjESEWX/HuTicTLUJmig+Nnln/hwFF43Bcna68p59KUxlv80KI
	3BS2ZV0aJGX/rXb+HwYS9Jvvkr2mz9JM=
X-Gm-Gg: ASbGncsftv/G5y0gqd6Iyf0vbxs6+p8VSJhQUdFXlHcg9295QPAWTOflOW8HrAFi3Qh
	ho10zLf+Cyi8b4b3bMA3AuZtEp5XaEJCkS3kCzGRU13+RiwcR/Vm1OyYVVsQeeBKuEhSLQGzHym
	n3AUahLk6kCevjgEYnieWki2QwpYT+p2okmp6mo3AFgxSGH9mDILpT9/HVmia1tzYjyrAxaw9U8
	Ge9zu3EAYmpDL4KTvGQhHJWSMk98cNKVy2P
X-Google-Smtp-Source: AGHT+IE+CvXhw/j7NI42IDQ5O5MBNP6IjMoslZXlyiP5iBU9d3t/MfumNZsclDiRp03AG2sfLy4n8mvsKK1J9xQ8ajc=
X-Received: by 2002:a05:6000:2506:b0:3b7:859d:d62b with SMTP id
 ffacd0b85a97d-3b900b44960mr645303f8f.8.1754613121871; Thu, 07 Aug 2025
 17:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807114732.410177-1-hengqi.chen@gmail.com>
In-Reply-To: <20250807114732.410177-1-hengqi.chen@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 17:31:50 -0700
X-Gm-Features: Ac12FXwfOBpXGrRx3Q3mMW20aVvQCJuT-xksHvGWvDup1g6rqO1nVqwlg1VBB_k
Message-ID: <CAADnVQKwZYxc64XLP=jGcx1N3sPHWUxmQRjmDu9M0xoOV5fHkg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Use vmlinux.h for BPF programs
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 4:47=E2=80=AFAM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> Some of the bpf test progs still use linux/libc headers.
> Let's use vmlinux.h instead like the rest of test progs.
> This will also ease cross compiling.

only if...

> diff --git a/tools/testing/selftests/bpf/progs/loop6.c b/tools/testing/se=
lftests/bpf/progs/loop6.c
> index e4ff97fbcce1..f8e2628c1083 100644
> --- a/tools/testing/selftests/bpf/progs/loop6.c
> +++ b/tools/testing/selftests/bpf/progs/loop6.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -#include <linux/ptrace.h>
> -#include <stddef.h>
> -#include <linux/bpf.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  #include "bpf_misc.h"
> @@ -26,12 +24,6 @@ char _license[] SEC("license") =3D "GPL";
>  #define SG_CHAIN       0x01UL
>  #define SG_END         0x02UL
>
> -struct scatterlist {
> -       unsigned long   page_link;
> -       unsigned int    offset;
> -       unsigned int    length;
> -};
> -

Pls test your patch before submitting, so that maintainers
don't need to point to CI that complains about this.

scetterlist here is not the same as in vmlinux.h which causes issues.

--
pw-bot: cr

