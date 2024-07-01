Return-Path: <bpf+bounces-33474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738291DB04
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 11:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E604CB2662B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473813DBB3;
	Mon,  1 Jul 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyl+zqkw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E9412FF6E;
	Mon,  1 Jul 2024 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824524; cv=none; b=hhWiaaYJxj1Bd8EO3HejDMrkY3pNaJRXy2qyeus9O3JFv5CP7wT+hswpWr7fTQs8JQAO3fBLr2roNXIli/N1cEIkCtIJOK5J8veSxm3o/NKvRx7z7Zp6SD4mDcwRNGnB5xgaKNb5wDhwfln9do2zCJYWEUfQ0RuA6AacWXa61As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824524; c=relaxed/simple;
	bh=eyWKni/+X2/LBQ3BfnBvxUxML05TnimAdXg5nrWod2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=e8M70qsXMHeRRZjaH8StPSr8YXCBgSlEZmFDAasLls0MDcPDP2vnVIsGM1UsXIikhD0XtrY3u7VdZq++48lzHqPPEzazVBG4ruZLAeusAterrApvk7yk0pMm54Y94PA4GkM+GIj/6bM3sUNodF8iznQTYFCPPbXIHnvgjlORqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tyl+zqkw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa75f53f42so11613535ad.0;
        Mon, 01 Jul 2024 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719824522; x=1720429322; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AZjFIWKODzM/NcTqJf05rFl20Hxp9H5fZbg5Tl9cDM=;
        b=Tyl+zqkw0R7uHaq+6UWMJsva7l3SY3ptp+yzTgWPz0tWLgeycWNaHY/3U1T+IIxEbC
         5Izm/nGbStOXMufFbTUvhI6m3Si0N9XOk4WbLa9Orezia7lp2AqMOVj0zY5svUNeHp2e
         9igjpMzlx/OShQXcgy7RhKjGKjRqTH7GRfytpxdrCgaBFAImBDgfTQU838/HX19XMRlX
         kyQrSv7/Rr9EwZAb/VLBKa04guwEoy5rYVZSnuIsMJ8FrHbrEn75jTkLV3rLNHr0hM7A
         fCEQIA1W/CgYQ3nywcUotNIIC3/BPqTuz8PEfgkg6aWJ2bGSM0dz07VgrILuOrLcdwIQ
         PyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824522; x=1720429322;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8AZjFIWKODzM/NcTqJf05rFl20Hxp9H5fZbg5Tl9cDM=;
        b=lOKXQqo3uFR4IIdp9uGeGwuSJRbgEfJidJdZGkUhs3PWNI0D62Elbr+TYbJimz8iyl
         Yl9w7X07H5TFgHuLtYR4M3oeiZNzTMQ4ep4x6t4KfZOb2rIk07m9LaeRX2xI4iKI78Ct
         6H/kT966Y2McTTzDo3/HQZS/tpjdO+f66GhxU5EsMW/FEEFM5kpQ4zSSL2MPg8KLpyGg
         IwQ7jYqphzBAGG5/mlUiYaEPpuWCt6Cz6APtmlHNeKOuSWDAM5NQyiE7vSuLJTwwJjSA
         ytW1To8kAqlXXRgVk69kc6JNmqBxTtx1uEFC0NxBSdJDvItfsAmX71FevewDBaTRUPHP
         eQhw==
X-Forwarded-Encrypted: i=1; AJvYcCVra3KX/YF1xtqiPJta78yeSztzvGHs2QnCr/Ii3ubSEEaY5BTZwHLOgbf6Iek6Y8vM+oMZNII3lLNol7tEWJ+rxjY0PXgdn3Nxg2Xg1QesREW+S/OWeKwNF0D2b7s/brFcCfqzioj0
X-Gm-Message-State: AOJu0YwoN9E0/tdflVcruIcRl/J7KGNtPpNxB0qj2kFxZzET98V9ikzh
	2jU3DTnjNS7PWDH+MhuDQ/EmGgsxBtIwoDz2xNhaMJy4kAXvpqdxrTE4Dw==
X-Google-Smtp-Source: AGHT+IGsrF3+f846+0ll/nXhZ5ebUEruoSp54Z7Zxn3+lFCS9qSPb8kXe8eT8SjoYF/hztGBwmF+Vg==
X-Received: by 2002:a17:902:e54f:b0:1f7:1655:825c with SMTP id d9443c01a7336-1fadbca1794mr29389455ad.36.1719824522032;
        Mon, 01 Jul 2024 02:02:02 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568ea7sm59477635ad.186.2024.07.01.02.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 19:01:53 +1000
Message-Id: <D2E2WQD0YGWH.11G3KU8SYPPZE@gmail.com>
To: "Naveen N Rao" <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>
Subject: Re: [RFC PATCH v3 03/11] powerpc/module_64: Convert #ifdef to
 IS_ENABLED()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1718908016.git.naveen@kernel.org>
 <e0782cdf680a645d7f8d311a16530be7004bb0ef.1718908016.git.naveen@kernel.org>
In-Reply-To: <e0782cdf680a645d7f8d311a16530be7004bb0ef.1718908016.git.naveen@kernel.org>

On Fri Jun 21, 2024 at 4:54 AM AEST, Naveen N Rao wrote:
> Minor refactor for converting #ifdef to IS_ENABLED().
>
> Signed-off-by: Naveen N Rao <naveen@kernel.org>
> ---
>  arch/powerpc/kernel/module_64.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module=
_64.c
> index e9bab599d0c2..c202be11683b 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -241,14 +241,13 @@ static unsigned long get_stubs_size(const Elf64_Ehd=
r *hdr,
>  		}
>  	}
> =20
> -#ifdef CONFIG_DYNAMIC_FTRACE
>  	/* make the trampoline to the ftrace_caller */
> -	relocs++;
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE))
> +		relocs++;
> +
>  	/* an additional one for ftrace_regs_caller */
> -	relocs++;
> -#endif
> -#endif
> +	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
> +		relocs++;
> =20
>  	pr_debug("Looks like a total of %lu stubs, max\n", relocs);
>  	return relocs * sizeof(struct ppc64_stub_entry);

LGTM. Hmm, you could get even cleverer

    // make the trampoline to the ftrace_caller and ftrace_regs_caller
    relocs +=3D IS_ENABLED(CONFIG_DYNAMIC_FTRACE) +
              IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS);

But either way

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick


