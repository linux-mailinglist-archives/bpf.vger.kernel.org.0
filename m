Return-Path: <bpf+bounces-74007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB8C43D22
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 13:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDE8B4E2550
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 12:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3FA2E8881;
	Sun,  9 Nov 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0xKG8HL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFF2E7BC0
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690295; cv=none; b=aiBdDkL92PktWXY1n3IyLzgxSkem2QNniHJDarkbIgU1Ix/0KeWV/2ZdMoVCRH2x0zzHIl7/dflYMSeLszKSGgoQzAEY8kD2Ohfm24xE+OS++XeRqnuIKObMDxwtyp5ZdYc2P9+nvuLdftfsXlQ9On7ArAGX92/pIjzKnmwydAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690295; c=relaxed/simple;
	bh=9TrRIYB2XOoX17zzX0ixZst/V96BVzam/k//08+kh8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvv9UHCvPkna/btFUuXXSyP3CU5gNyxv8ZjwPhS5ZpT6xAdJOuT52tYovVteQtyDdKAA7EzyS5YyGKvGKexiKr2/yOxHBcnarp7Do+ZQKMiMeAhXrQu58oE8fMXgDLnHObg/phPFIofpzQ/CHtjvzb16uU8y+0RPyUnnxGJ4EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0xKG8HL; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63fd17f0cd2so1629699d50.3
        for <bpf@vger.kernel.org>; Sun, 09 Nov 2025 04:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762690293; x=1763295093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaB3iUzdscR6aViyJqwLMcsd0JlvtsbUTPKpewl2qBw=;
        b=i0xKG8HLwJxJQcEyL2ltkvCVpmxagHX06H1+TkaAdLNrdGkDsu5HgIlgaq9FWa6WvO
         778wxQiCre3f4LjyO+5X+h7e2oGY+3U+6VawUd0/AJ9OjFMAmtWQZ4MbfLbB9iUegERz
         DW9CvOugr9jrIMCGEW8xhiR+2sOF00U5VYaYEQLys/WO4lN/iE0SN9VQ5+sus/cjGbk0
         efenTlxYu3lJb/pdai0TMlsKRlh3OwzDOqWSaE0ODACKK5NqMooUynYg6YqmrPSXOh/A
         ZHTpSW/Z+fdsKOxPssK92QFeflKqVutZMvWqMR/hmE3Ubq3hoxXgIiZ6eJEK5uvRuKFZ
         F8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762690293; x=1763295093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaB3iUzdscR6aViyJqwLMcsd0JlvtsbUTPKpewl2qBw=;
        b=lf+mN07BtdYZdmUC0af23JN04+sA87EJIaA01N4l0xMQ0my8OeQ4jDCMgUC1DPPOVT
         pkhmdjoDH5O7NNCLVfiHq02OVLwTB32o4W4wUjuHwtQowa1YyEXnx5/dyUjip6YmAFru
         Yuz+/Y1XKN3YWvRE2vl6UP4TilTX1KmXXlfFtL9GkuLjZwwcdI5PbeZnmoG/bIkdSB7G
         4nY23Zn28Y9fghKOgHYeMDktsRpO3lLwHoymrYgfKaJ+NopjWT/a8gzCzB7saqUeQYfZ
         rdrVMe5G6dAy0KaA8vFZqIO8NWWFdZoIgS6pwDXFtt9mZc//L3HOgfgCIequ+0WZDH6/
         QY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVxsL/RJnbkHXjuzw1B93Q66VeFaYCPhaukWCEghulbgECk1y7Ngr2nf+UImMAhCXdJOtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mHjPA1d04c8ScN9dVe0NiyMiQLnPT+SZ+NLct5kxN/qJADP2
	jNrsTbez5Z9fQAQJCrUvQTHuePt4nWxCIstPyjwkBL3gWrSHYkG1I2AaTpI+aBxZOPuXqFDSvw4
	tq044ITCsuWoTqEqv5Y91ihG/IC+eb0A=
X-Gm-Gg: ASbGncsFvvQV0BzfLAVLKTdnHQqfbBRR6Z97qABbuiSVWyoP8vens6iuXET8wgJBIbU
	rCKkZKPs3lU6pYdF7FbTR0qJZ3x6aWxBTGSlP4rKJfKw05iLm6+xv0/5ZXAwmiMrRkN9Ockd2Zo
	egXlo5iFL7IbfiT6ggMXqzF5fyCUZcBBj/0UZA8MrGvpJ+nTRWAF/KjNHvPJbdS2y8sYY4Y2mni
	GOD+dIeGJe/gXf+2nN2pbGO1anRcBZo6UxS7eRLx4EtcRsGSLN04Ik+7cBh5Gg1odkGSQYv
X-Google-Smtp-Source: AGHT+IEKhjeme65HFe4rbHvn0fhtz0mbKIXocvNQ95paIv/R07SYgK3/Ab1CQi+EtohDNRjUSI8bQbzPh8xSQmFFyn8=
X-Received: by 2002:a53:acc8:0:20b0:63f:aef7:d009 with SMTP id
 956f58d0204a3-640d4543d3emr3526712d50.5.1762690292759; Sun, 09 Nov 2025
 04:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
 <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
 <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com> <8a4aae40-46d3-403a-a1cf-117343c584f6@rosa.ru>
In-Reply-To: <8a4aae40-46d3-403a-a1cf-117343c584f6@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 20:10:56 +0800
X-Gm-Features: AWmQ_blpVmNsJtsggeQbfkqHI6DRzOvkhrN0Qih5Gjdy_fjh5mvfLp1OZCiTq2g
Message-ID: <CALOAHbBdcq6bKCeroGFmUNfo6Os+KOXGzeqVZjM=S0Q9hpxYew@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQsNGE0LjQvQ==?= <a.safin@rosa.ru>
Cc: David Laight <david.laight.linux@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 7:00=E2=80=AFPM =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=B9 =D0=A1=D0=B0=D1=84=D0=B8=D0=BD <a.safin@rosa.ru> wrote:
>
> Thanks for the follow-up.
>
> Just to clarify: the overflow happens before the multiplication by
> num_entries. In C, the * operator is left-associative, so the expression =
is
> evaluated as (value_size * num_possible_cpus()) * num_entries. Since
> value_size was u32 and num_possible_cpus() returns int, the first product=
 is
> performed in 32-bit arithmetic due to usual integer promotions. If that
> intermediate product overflows, the result is already incorrect before it=
 is
> promoted when multiplied by u64 num_entries.
>
> A concrete example within allowed limits:
> value_size =3D 1,048,576 (1 MiB), num_possible_cpus() =3D 4096
> =3D> 1,048,576 * 4096 =3D 2^32 =3D> wraps to 0 in 32 bits, even with
> num_entries =3D 1.

Thank you for the clarification.

Based on my understanding, the maximum value_size for a percpu hashmap
appears to be constrained by PCPU_MIN_UNIT_SIZE (32768), as referenced
in htab_map_alloc_check():

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/ker=
nel/bpf/hashtab.c#n457

This would require num_possible_cpus() to reach 131072 to potentially
cause an overflow.  However, the maximum number of CPUs supported on
x86_64 is typically 8192 in standard kernel configurations. I'm
uncertain if any architectures actually support systems at this scale.


>
> This isn=E2=80=99t about a single >4GiB allocation - it=E2=80=99s about a=
ggregated memory
> usage (percpu), which can legitimately exceed 4GiB in total.
>
> v2 promotes value_size to u64 at declaration, which avoids the 32-bit
> intermediate overflow cleanly.


--
Regards
Yafang

