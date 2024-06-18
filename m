Return-Path: <bpf+bounces-32405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430790D2E3
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 15:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D41C22E0B
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE1815CD6D;
	Tue, 18 Jun 2024 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eP1XnMWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2E15CD65;
	Tue, 18 Jun 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717455; cv=none; b=REWPkuyXJoFyejWN+4SAmkIc0NszVkKqzdCsLEZEs4Feoevv45gmKFo5/7KMl4EfkVhvMm4/DGjJmvdAd9f7s6kHX3YglgSj1teXvxIjIxjoo00dNkVxo+uwV04jkVdixdW6rAOzrB8bnRrQoW4dRju2FZ1cL2O5z/w7kCkBb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717455; c=relaxed/simple;
	bh=hyu0Am/KzFedokVqpQHC0MeCjFCn8cgrf2UfhAKYzvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0NPhEUd5osAUMqQLQcVpym67w4hO04JPGIdLxX5JHVvAAJ46QNpUMfvtAd1uGMH/kHPgOOxx7EzoUJPNP6CBD34dOSSfqDv/pjPlYjfIbRS6Gs+yaY89qVKcO9mkFhpmpmEsXqay0PT+3qYjAMFRLEBZ7Ah14Oaat4+Oy7VDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eP1XnMWg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3608e6d14b6so2002628f8f.0;
        Tue, 18 Jun 2024 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718717452; x=1719322252; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FcnMHtNdVwEgRHhVzwaKzsGpucVSC1MxgjxGj0kWT+Q=;
        b=eP1XnMWgodQhPGGnp1+MI0JsASpGQvffx77OQg27WJ1hJjTlEtx0jvKDEifrKuxqlF
         qhvMFeRa15gudNV/kwbPjfSvQclPrwBlU8SwvAR5Dd4IwTb7Gh/UkBWAkyplaZFJSufg
         xUZnwi6A76ub/ItBSBzd8QEiHlFhGLLl0DkykSxw/muf903RPBzUOcQcvr8vEQVm8hUE
         +rK3gJsL9JsWj2TSRJhcTT+wIJoJRA0g8ZZED2hb2MZtWp02twQemHlQBmNlQaPoQvJ+
         J+lZskPm3AA+7fVtmGur3p9qdN26X4GYKnuTZpI7AT0aaV6yySkDuRYJtmF4dkaHtSct
         1OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717452; x=1719322252;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcnMHtNdVwEgRHhVzwaKzsGpucVSC1MxgjxGj0kWT+Q=;
        b=MDwJS3p0b22gpI/l4OZt4tz140L7gRro4EP4/fYx2WBib2y+GiKzCgKm+UV7t4tx8w
         v4U++DUQzihYpDPr8kTbHPKqoTgWHo02IPwRxgGWrvvHEoldem0DjRSLqqR1ePhQGxJE
         x6ZmekYIjL5tTLCBp//SGIexYpmc8GXJpKv/NluZX3CSz0zl/A+48PwU/zwbCEDrjiID
         mtlaxGsTDdnqCyMCTqflWrp6mu/NAjW2736DEvCLpSMXpgc6VzmxEPtuZ+Xl9e09TjME
         kzYvgK9TtTntQSKC8j+uCIvHfWfu3z/4y+T2A/v4ViDqTcSTquY+0u6dk6+up7N41LA6
         7mIA==
X-Forwarded-Encrypted: i=1; AJvYcCVlNmCuXc8MtVN3aBtSlXC+j2xfnSlWZDFGiyKgORjoE1T7zuWpYZfEh2/VfunA14xLsNNBZl0z6vruYM3S7ZFc7ukdT/7MqoFiiBvB/tKbr6oAqmVAoEcVbF7qhDF9M62Y
X-Gm-Message-State: AOJu0Yy/HUY7EgHR5YrGuh8ZzjIRXss+ghoiFQWZKbYT3ohhMrxgcWYa
	vQiytXftAxRdOvJt6yhuA5UOnvnLxea0MTvWD7PgmZt0jPBe39oa
X-Google-Smtp-Source: AGHT+IF6+iO/0W0LMpOnPmATaN6+Ni/p2mp4ptbLlokGCHrnllKR92jiA0qM4MrXh098DtwZbBN29g==
X-Received: by 2002:adf:f584:0:b0:35f:2b1d:433 with SMTP id ffacd0b85a97d-3607a746a11mr9688051f8f.26.1718717451370;
        Tue, 18 Jun 2024 06:30:51 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362907048b0sm671272f8f.24.2024.06.18.06.30.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:30:50 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Maxwell Bland <mbland@motorola.com>, "open list:BPF [GENERAL] (Safe
 Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mark
 Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, open
 list <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v7 2/2] arm64/cfi,bpf: Support kCFI + BPF on arm64
In-Reply-To: <puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54>
References: <ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq>
 <puj3euv5eafwcx5usqostpohmxgdeq3iout4hqnyk7yt5hcsux@gpiamodhfr54>
Date: Tue, 18 Jun 2024 13:30:36 +0000
Message-ID: <mb61p5xu6z8cj.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hi Maxwell,

I am happy to test your code everytime but it would be great if you test
the code before posting it on the list. Otherwise it would take multiple
revisions for the patches to be accepted. I understand that testing this
is non-trivial because you need clang and everything and you also need
ARM64 hardware or Qemu setup. But if you enjoy kernel development you
will find all this is worth it.

> +u32 cfi_get_func_hash(void *func)
> +{
> +	u32 *hashp = func - cfi_get_offset();
> +	return READ_ONCE(*hashp);

The above assumes that hashp is always a valid address, and when it is
not, it crashes the kernel:

Building these patches with clang and with CONFIG_CFI_CLANG=y and then
running `sudo ./test_progs -a dummy_st_ops` crashes the kernel like:

Internal error: Oops: 0000000096000006 [#1] SMP
Modules linked in: bpf_testmod(OE) nls_ascii nls_cp437 aes_ce_blk aes_ce_cipher ghash_ce sha1_ce button sunrpc sch_fq_codel dm_mod dax configfs dmi_sysfs sha2_ce sha256_arm64
CPU: 47 PID: 5746 Comm: test_progs Tainted: G        W  OE      6.10.0-rc2+ #41
Hardware name: Amazon EC2 c6g.16xlarge/, BIOS 1.0 11/1/2018
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cfi_get_func_hash+0xc/0x1c
lr : prepare_trampoline+0xcc/0xf44
sp : ffff80008b1637e0
x29: ffff80008b163810 x28: ffff0003c9e4b0c0 x27: 0000000000000000
x26: 0000000000000010 x25: ffff0003d4ab7000 x24: 0000000000000040
x23: 0000000000000018 x22: 0000000000000037 x21: 0000000000000001
x20: 0000000000000020 x19: ffff80008b163870 x18: 0000000000000000
x17: 00000000ad6b63b6 x16: 00000000ad6b63b6 x15: ffff80008002eed4
x14: ffff80008002eff4 x13: ffff80008b160000 x12: ffff80008b164000
x11: 0000000000000082 x10: 0000000000000010 x9 : ffff80008004b724
x8 : 0000000000000110 x7 : 0000000000000000 x6 : 0000000000000001
x5 : 0000000000000110 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0003d4ab7000 x1 : 000000000000003f x0 : 0000000000000000
Call trace:
 cfi_get_func_hash+0xc/0x1c
 arch_bpf_trampoline_size+0xe8/0x158
 bpf_struct_ops_prepare_trampoline+0x8
[...]

Here is my understanding of the above:

We are trying to get the cfi hash from <func_addr> - 4, but clang
doesn't emit the cfi hash for all functions, and in case the cfi hash is
not emitted, <func_addr> - 4 could be an invalid address or point to
something that is not a cfi hash.

In my original patch I had:

u32 cfi_get_func_hash(void *func)
{
	u32 hash;

	if (get_kernel_nofault(hash, func - cfi_get_offset()))
		return 0;

	return hash;
}

I think we need to keep the get_kernel_nofault() to fix this issue.

cfi_get_func_hash() in arch/x86/kernel/alternative.c also uses
get_kernel_nofault() and I think it is there for the same reason.

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIsEARYKADMWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZnGL/RUccHVyYW5qYXkx
MkBnbWFpbC5jb20ACgkQsMD5Ixtwdp3AbwD+I2Q0OiLq8foDoUj0DISDhNMGiCcn
ZBr+3BwPV151j4YBAPkWjUG3guQHThHmZJjwPVLbhMDHizKBlmgn6sb3qRML
=OXLV
-----END PGP SIGNATURE-----
--=-=-=--

