Return-Path: <bpf+bounces-33471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B1C91DA2E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DC31F22392
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B883CA0;
	Mon,  1 Jul 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpqLXJJd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7B8289E;
	Mon,  1 Jul 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823261; cv=none; b=WF3PqiyqrGpiDAK24kAPPrBoOCuQrAl8Ln0XI0v3SmRIe94Elfw7+ULGlx2eNwnrnLf8v82h5hgtQPJI5bTB4kUpsuNy7aY0id3Qw+I/GR5H/ODEwC/Us8zogLt2AFdILdwINhTYGa+T3AOal3JY2Fv1Kps8cRN+gDv9/kDsAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823261; c=relaxed/simple;
	bh=L/7N6GKt+ihwLGGrTZRGhbYreVfyqggPQTMbL+0kHvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RzH1yXg50EaXdbVkdYnSmtVfuUpvtg+sUcqs5icyHXodBWSeNMDGPosXmTROV2IfeU2HpJpGYVBKQrxQ5nSmO7r9lWV5eZvusiHEB1GE9ShauQ0uAp5P3HsceZDnvVzA/2D1TlWLy+mVKTKpmaT0yyHOKtTImi1KfT1Eby8gBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpqLXJJd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70675977d0eso1537827b3a.0;
        Mon, 01 Jul 2024 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719823259; x=1720428059; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3x8OXlxrycHdfXvAIhFhHfcQNBUzKhTKnahatC6tJk=;
        b=GpqLXJJde/K4iveWvq5vwu7RX9QlbYnQBu/IGUO4yetSNCja1HTE46gXQbd94jrFkv
         sZhgiM69a41vHhFC0RGCmBWfVBiD3rubVs7VGuc89Jc6QKpr0Dr+bOttCu5/jOM8XTlo
         PeN8VMPeniPh9KazvkqnP9nnCkMHak8HmtQB4zK3KULP0K9RC47RoUvP4EnsP9KHwm3M
         /Y80m5t8ffZ+6btvH++qa7zaIrOypuLJ4+yvPlqbh9lQXU/eh+bPOKMj1QBpZQABBnNw
         ATioHkhzfQv7czoS2ZCKCP8YCMFHi38wVkrMdEF7afaDufc7mtJ/5ovPTelO9awsjDte
         IrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823259; x=1720428059;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3x8OXlxrycHdfXvAIhFhHfcQNBUzKhTKnahatC6tJk=;
        b=HbzVBYpGY6teK4iHmIeYc4yGUgFL96g4gfTxVX6fULZwexHlFTAwu5hBxU1hFYkJF+
         2d7YTUDVpBr6zLPaiXM38/U4RDknwwXdLg4V3X6fY+T5nfI71zc9S4gpZlJhGS+V55z6
         bfNKRQpldlvWN3k8MvL8Z+wXTsqh0TEJRGGySbgZ1PVBNAsVgMA+vieiTS+pxHxQ6rbR
         +ohTi+jeqAAT8T9zyh9JiCwfRttngL2eOVcXVv13eciQPBySpSBEF0uxaFzAByACbZhm
         obA2uNvBp55HrnZWkudfwOc4IO4yDF0fwrmjOrt00n3imkMbfgk2WLrUwuHMBxzuwN+g
         LeQw==
X-Forwarded-Encrypted: i=1; AJvYcCWbt8VkrDa0epZukh2t5x8aHAt/gSrjju9rRCYuZx/C3dSIfmoZzUUygHWl1zmnXUSAXz3rgvEtQX0hj7fKIgYXQSchJhwNHE5hwMlscbMkg6uWh60aacu/0tmaHggOddELn2g3kYu0
X-Gm-Message-State: AOJu0YyKsyxHG9S96Kg4VYWDC0+1DxGBSlOhtdB8WDPh1mvl6YoZx9bf
	dreC3/02Q+Q4dwuNZjvqMr1MHsgtxxsNpEZaPjzbqEY2KYPqRamF
X-Google-Smtp-Source: AGHT+IFF3U5blfYc7cCFy2B2VWKUGh0mSRCO0j+ghWCasUVIR5uCy8kyNN9MdGKcEbR1V4mgvBeXng==
X-Received: by 2002:a05:6a00:4b54:b0:706:588b:d44b with SMTP id d2e1a72fcca58-70aaad60715mr3643920b3a.20.1719823259007;
        Mon, 01 Jul 2024 01:40:59 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53ae0sm5943265b3a.23.2024.07.01.01.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 18:40:50 +1000
Message-Id: <D2E2GLXWB7TH.1L7TFQZO3149Y@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 01/11] powerpc/kprobes: Use ftrace to determine
 if a probe is at function entry
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <2cd04be69e90adc34bcf98d405ab6b21f268cb6a.1718908016.git.naveen@kernel.org>
In-Reply-To: <2cd04be69e90adc34bcf98d405ab6b21f268cb6a.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> Rather than hard-coding the offset into a function to be used to
> determine if a kprobe is at function entry, use ftrace_location() to
> determine the ftrace location within the function and categorize all
> instructions till that offset to be function entry.
>
> For functions that cannot be traced, we fall back to using a fixed
> offset of 8 (two instructions) to categorize a probe as being at
> function entry for 64-bit elfv2, unless we are using pcrel.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/kernel/kprobes.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.=
c
> index 14c5ddec3056..ca204f4f21c1 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -105,24 +105,22 @@ kprobe_opcode_t *kprobe_lookup_name(const char *nam=
e, unsigned int offset)
>  	return addr;
>  }
> =20
> -static bool arch_kprobe_on_func_entry(unsigned long offset)
> +static bool arch_kprobe_on_func_entry(unsigned long addr, unsigned long =
offset)
>  {
> -#ifdef CONFIG_PPC64_ELF_ABI_V2
> -#ifdef CONFIG_KPROBES_ON_FTRACE
> -	return offset <=3D 16;
> -#else
> -	return offset <=3D 8;
> -#endif
> -#else
> +	unsigned long ip =3D ftrace_location(addr);
> +
> +	if (ip)
> +		return offset <=3D (ip - addr);
> +	if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V2) && !IS_ENABLED(CONFIG_PPC_KERNE=
L_PCREL))
> +		return offset <=3D 8;

If it is PCREL, why not offset =3D=3D 0 as well?

Thanks,
Nick

