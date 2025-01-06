Return-Path: <bpf+bounces-47996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D241A0300D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66963A323B
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E21DF971;
	Mon,  6 Jan 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVaf5pO7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F370812
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189989; cv=none; b=LXHvRDcsDkj8TNEBhBmOh8agvLXNJtS4r1bae8yD7+0roKlGTzsQBiCF2LN2uOwsPlwMjvF5nG32pt/+relgdMrYLmNVT4zJN2bbvAA6EJZVAn0shJgt1nRnSut1JAhpOqbfrpjY4BYaGo7eo4J/ZkJHiyu90QQ6lxykGSP33wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189989; c=relaxed/simple;
	bh=AcrxltmDr3mKaWAGtzNzJUwEEhZz8LGB9H5dEkihsHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnszlWSx/kUheoEITZ9HiQ8bfQkkVSzhmgWjB/z+cKCyHm8prhiYI/6bLngBN0aY1ILR0Uk47ifj6f9bnDcrwGQDVH6k8apYSe9u313YKXMOyO0QcSyYw3IrTdv1YI9IvbILnnKd/HnoPu7AMYRkjkPgDRt1Z+jBXYNRxA9ZCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVaf5pO7; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so31416435ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 10:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736189988; x=1736794788; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a4gMOb/UQc3ZNDP2w1WW1thapwg1JSRNppUuIMdGhj4=;
        b=CVaf5pO7DkbxKq1P91EbaS13aq3ieBK3NVJvLP7xA8VwndzMWmTXOrWc0BUVxuUkdi
         J47asMArs+t1pzkno2QI+KxHrsIdjn1iMwsUERuwas00zn5OAabWiMD0SA40wGGP8tt5
         pcbeBKh/mEpbyByJxlrYOVIWFFk0oLMp9L6Lol1YHXBuLAqYjvLPCI77Et9aAdUkTgcV
         3UYjFPy+KGnON2LJMX/u4VpPhM9RV9/Mfo52GPISoZtUPz/us2Sgvd3eEV6Po/NFlX1Y
         a8bzFaaAcMzLTeE02OdEownfR2vWjoiIEjkZNdNCuam7ShFljeH9u8BwfCm2DIQobAJf
         diEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736189988; x=1736794788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a4gMOb/UQc3ZNDP2w1WW1thapwg1JSRNppUuIMdGhj4=;
        b=YIqHNTeELWPz7777qEYq0qZj4AJoczmgiiSxmHNqHy6VTmbDborn9RfR0YYgB/BRD4
         HFk+0hhwr8r7qoHcrV61ddeskiMvXLIrZXqBn1VxhmJlJbtGMnLa09xogkVGfTQdyWoJ
         KT5GhnmDNbtQOEwiFHQIqAmKIswBADSY9bDKmGBvhgS3iCf3Plz+7oCckoYgWZJh2akH
         eFZzIEENOYX7zOU28+/8jCHjukYAtw09zNoBmd2TI2haW/T4EHuDgsF3ytTThhxNprA+
         LS32OuGH6+CklYlanW2BQA2n/4YLswVUjK0IwzYa51XHhty+w7mgk50O9IbmMcXH3UfH
         nmQg==
X-Forwarded-Encrypted: i=1; AJvYcCXkFBZq8gsdbdfUXQOQ/IZMBIOqn1AUmtYQa97nNfcd6YZ/Gy1POMN5tLbrbspMHymnuF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHYqzGAsvczCWXNEdAdbIExJg7uOlhKeqPa/JZQdKXotbQkGH
	8iWbJ7b7cL0JXH12AXvZKP7EPVrPlu287BY5IfyCyneGkLcVof89
X-Gm-Gg: ASbGncsxkahiLrintWL8zx49OyU3MtohibiF5+LMITdEaOf6avtQgVgY4mYrqpLPUT4
	WLxKWT9TXZcJsVnJ0o0unt7qy/smuUxEx9Ei0p5yM45Wix8kHcWacL97Cffd+1Eyv72FR1H3eX9
	YzN6hf+oJuEeDDsK8jLw+hjCIrqikTtPhYxgun8x+Uj+iWnHmbyQ2EfvUslCsfUwzD1Mdp6vTM2
	EVZaKvROKjmagyI9DI5OLHRljaqi2BHWAoNRshePkuqCWRVyAxlUg==
X-Google-Smtp-Source: AGHT+IFRHFMNORlqJ7uXr8gEf44/VNj16KaGZtVKn2rEgPwYL/BvVevYQpD8u8tty0waptxvLyXEDw==
X-Received: by 2002:a17:903:2a8c:b0:212:55c0:7e80 with SMTP id d9443c01a7336-219e6ea1968mr885683765ad.20.1736189987572;
        Mon, 06 Jan 2025 10:59:47 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9704dbsm296944655ad.98.2025.01.06.10.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 10:59:47 -0800 (PST)
Message-ID: <4b01f799f25062513fcdb5b64c5d791247b1ee48.camel@gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: workarounds for GCC BPF build
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, mykolal@fb.com
Date: Mon, 06 Jan 2025 10:59:42 -0800
In-Reply-To: <20250106185447.951609-1-ihor.solodrai@pm.me>
References: <20250106185447.951609-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 18:54 +0000, Ihor Solodrai wrote:
> Various compilation errors happen when BPF programs in selftests/bpf
> are built with GCC BPF. For more details see the discussion at [1].
>=20
> The changes only affect test_progs-bpf_gcc, which is built only if
> BPF_GCC is set:
>   * Pass -std=3Dgnu17 to gcc in order to avoid errors on bool types
>     declarations in vmlinux.h
>   * Pass -fno-strict-aliasing for tests that trigger uninitialized
>     variable warning on BPF_RAW_INSNS [2]
>=20
> [1] https://lore.kernel.org/bpf/EYcXjcKDCJY7Yb0GGtAAb7nLKPEvrgWdvWpuNzXm2=
qi6rYMZDixKv5KwfVVMBq17V55xyC-A1wIjrqG3aw-Imqudo9q9X7D7nLU2gWgbN0w=3D@pm.me=
/
> [2] https://lore.kernel.org/bpf/87pll3c8bt.fsf@oracle.com/
>=20
> CC: Jose E. Marchesi <jose.marchesi@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
>=20
> ---
>=20
> v1: https://lore.kernel.org/bpf/20250104001751.1869849-1-ihor.solodrai@pm=
.me/
>=20
>  tools/testing/selftests/bpf/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index eb4d21651aa7..b043791fe6db 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -69,6 +69,10 @@ progs/timer_crash.c-CFLAGS :=3D -fno-strict-aliasing
>  progs/test_global_func9.c-CFLAGS :=3D -fno-strict-aliasing
>  progs/verifier_nocsr.c-CFLAGS :=3D -fno-strict-aliasing
> =20
> +# Uninitialized variable warning on BPF_RAW_INSN
> +progs/verifier_bpf_fastcall.c-CFLAGS :=3D -fno-strict-aliasing
> +progs/verifier_search_pruning.c-CFLAGS :=3D -fno-strict-aliasing

Specifying -fno-strict-aliasing for a sub-set of tests is not convenient,
as this list would have to be extended each time __imm_insn macro is used.
Either this flag should be used for test_progs compilation as a whole,
or the macro should be updated to use union as it was suggested previously.
Personally, I don't like the aliasing rules and would prefer -fno-strict-al=
iasing,
but changing macro is a simple and non-intrusive update, so I think it's a =
better option.

>  # Some utility functions use LLVM libraries
>  jit_disasm_helpers.c-CFLAGS =3D $(LLVM_CFLAGS)
> =20
> @@ -507,7 +511,7 @@ endef
>  # Build BPF object using GCC
>  define GCC_BPF_BUILD_RULE
>  	$(call msg,GCC-BPF,$4,$2)
> -	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2
> +	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -s=
td=3Dgnu17 -c $1 -o $2
>  endef
> =20
>  SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c



