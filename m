Return-Path: <bpf+bounces-71138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361BBBE5132
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338AB1A66C41
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21343239E9B;
	Thu, 16 Oct 2025 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1EJrXxd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005223B611
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639838; cv=none; b=QpdGkQ4CPACXWz8TnidqfkRD7CGSLPrc+J0NNGpAnFw8aeHS3I1UyQM90PdbvwhuvLy3YnYp5e22DA+VbbBM4RvEj6L6ZjAEwKdbAjISfYGWtlQjxXVGMTdn9nrO+wYU46ChcLxmwEY7IEAYOpVlk7qdL6OLhC2ngzT4je0ZOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639838; c=relaxed/simple;
	bh=973/tPHChrX5VSciyVyWvk4+VfZMVj7E4tlb5MpKm+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s9QKrkvQDLJz/0X1mh9igc1o7CvaNy9oKetDH7YvjnfK071dPU6Lvz1xKiu4wFzHve0rnTrnUhzuoxZ2vu5wGTOJXGVqMy4xiNldqb5Nx9owmK6u8Ui73MYO4wAqKRmwIBe9K6A5sxLcCFgj1nUUoIG0nsf15qF0NHphVIYEq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1EJrXxd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso1069758a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639836; x=1761244636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5MkamMtuC/Dta+bRuSUfmL0bDguGjqmZx+0n3odVhw=;
        b=N1EJrXxdlJWnvKGa1JnBRhCD1Gnzb83CCG3rWwycysoqd50sqaqGqhSoj3x6GQ2koX
         QVTRZbcjpV9mQz+k2TpAVP3ZV9lOK6al5R7Wy+wib2Uc3inh0nJR8DXF1AEldgpl3jtY
         S6WyGxfPmKo99naEt9k8IIeL25a0TKzw7JX61L9NuUMFr8zdy+qMtCEzpxabNlsTGTIJ
         00ZxTvH7hQgotWS/sATkv2b3HS7F5lc+keA8YCCTjYz/rxssB1fw5LCDrCQA7+DSNWuU
         rF20sy9ALRH1bP3jVVmNMaoCKvzixosLA6qdxG9XiUKgiLUiwV7iDfpn6GTnXetOSMbn
         /s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639836; x=1761244636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5MkamMtuC/Dta+bRuSUfmL0bDguGjqmZx+0n3odVhw=;
        b=LsnBOoqTBV33YxW5dbYBbxs9Gm5JVLeL8HXj3putlXOfurlNsJwaUv6VfEvFao/sS4
         ghAt3gXzq2vMjCiqicFjn8/VndfVroFULfTuzuLq+3gR2aMz8dfc2UL54wQYC8LQwEtJ
         plJikvIEELwESWRC11qA+YFd1qteqb/Cdiysq1hc6rkR4fKy+iDBW2r2Jtg50dJr4smV
         Qb/JVj+qV5C++uLa56+eT3WJGTEKafjj/ozT7WAu1CnIQN5S4qW8KZapFIP1o6V6jEHZ
         1APlgGnZM+GMxFPVqSuFVQ7Fh3GukggJkXYmo4XTMQgER0D0Yji68h0P0yYtksykKNAr
         RQzg==
X-Forwarded-Encrypted: i=1; AJvYcCWxSjh4OdypffmQZsD7+re53jc3toKQtEeDp9yXTJkl8uPkY7JeYouZpEfB91r7g1iDNZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdOoABIosD50LenHWZHChBkD6r7LhV9nCGtOzg6lVSCUdOX50
	hvwOePRHTBoUeEeq2A30KLwlgB6fIydyXqGwwpJSRXFuc6S2kgpL7SD6cgyZLy6z55gROgWzTBQ
	gX8UuAyF8GgUexaXDBTfERJgHbUX6bcI=
X-Gm-Gg: ASbGncvaUXCdTAW67JRgIoBsdeNHOvHaJMcUCocj32C+AQbdz5HncvgtL0FH98BA9ab
	vM8AHF9PPEzb52uFmyVquXoZ9qlzvGQ+va8UwY5ZbKgaRV2kmH3N2nCuCxWpxyDkMyR0+Y9xBLb
	wP2nNnDX83B8oQjg7zGYAYnH204tM0XOywPgBMAkx0+289j+bw13J++4rp5vGBOzCpk+Sca7Js+
	cFiFr7wvmJwmW6XdDYFA5v/tZvpRhTvbI3TyhYKdfA/y1w7hSiQoIz7etZKDy6HjzRzZN59x7J3
	1bK7HbnyhJU=
X-Google-Smtp-Source: AGHT+IHTVfP01AZX7UmCLXc9YHiY8VqB92JWTL6nhmIlr8/O+4wdHwRxfS0KMfNYYcqVZf/JRvPgNlq8V4jau2NbD38=
X-Received: by 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id
 98e67ed59e1d1-33bcf8f78c4mr970661a91.20.1760639836370; Thu, 16 Oct 2025
 11:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-15-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-15-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:36:55 -0700
X-Gm-Features: AS18NWA84j0_S7rdZ_CbRMTDnvgpA93SogcMLC5BE64LYQDnIOEX7V7Ijg3ve9g
Message-ID: <CAEf4Bzanp4fSOLZp5a5bifXh3447-rjScPRVwf2xDsA_pNmizA@mail.gmail.com>
Subject: Re: [RFC bpf-next 14/15] libbpf: add support for BTF location attachment
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:36=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Add support for BTF-based location attachment via multiple kprobes
> attaching to each instance of an inline site. Note this is not kprobe
> multi attach since that requires fprobe on entry and sites are within
> functions. Implementation similar to USDT manager where we use BTF
> to create a location manager and populate expected arg values with
> metadata based upon BTF_KIND_LOC_PARAM/LOC_PROTOs.
>
> Add new auto-attach SEC("kloc/module:name") where the module is
> vmlinux/kernel module and the name is the name of the associated
> location; all sites associated with that name will be attached via
> kprobes for tracing.
>

If kernel ends up supporting something like this natively, then all
this is irrelevant.

But I'd test-drive this in a purpose-built tracing tool like bpftrace
before committing to baking this into libbpf from the get-go.

Generally speaking, I feel like we need a tracing-focused companion
library to libbpf for stuff like this. And it can take care of extra
utilities like parsing DWARF, kallsyms, ELF symbols, etc. All the
different stuff that is required for powerful BPF-based kernel and
user space tracing, but is not per se BPF itself. libbpf' USDT support
is sort of on the edge of what I'd consider acceptable to be provided
by libbpf, and that's mostly because USDT is stable and
well-established technology that people coming from BCC assume should
be baked into BPF library.


> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/Build             |   2 +-
>  tools/lib/bpf/Makefile          |   2 +-
>  tools/lib/bpf/libbpf.c          |  76 +++-
>  tools/lib/bpf/libbpf.h          |  27 ++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |   7 +
>  tools/lib/bpf/loc.bpf.h         | 297 +++++++++++++++
>  tools/lib/bpf/loc.c             | 653 ++++++++++++++++++++++++++++++++
>  8 files changed, 1062 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/bpf/loc.bpf.h
>  create mode 100644 tools/lib/bpf/loc.c
>

[...]

> diff --git a/tools/lib/bpf/loc.bpf.h b/tools/lib/bpf/loc.bpf.h
> new file mode 100644
> index 000000000000..65dcff3ea513
> --- /dev/null
> +++ b/tools/lib/bpf/loc.bpf.h
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> +/* Copyright (c) 2025, Oracle and/or its affiliates. */
> +#ifndef __LOC_BPF_H__
> +#define __LOC_BPF_H__
> +
> +#include <linux/errno.h>
> +#include "bpf_helpers.h"
> +#include "bpf_tracing.h"
> +
> +/* Below types and maps are internal implementation details of libbpf's =
loc
> + * support and are subjects to change. Also, bpf_loc_xxx() API helpers s=
hould
> + * be considered an unstable API as well and might be adjusted based on =
user
> + * feedback from using libbpf's location support in production.
> + *
> + * This is based heavily upon usdt.bpf.h.
> + */
> +
> +/* User can override BPF_LOC_MAX_SPEC_CNT to change default size of inte=
rnal
> + * map that keeps track of location argument specifications. This might =
be
> + * necessary if there are a lot of location attachments.
> + */
> +#ifndef BPF_LOC_MAX_SPEC_CNT
> +#define BPF_LOC_MAX_SPEC_CNT 256
> +#endif
> +/* User can override BPF_LOC_MAX_IP_CNT to change default size of intern=
al
> + * map that keeps track of IP (memory address) mapping to loc argument
> + * specification.
> + * Note, if kernel supports BPF cookies, this map is not used and could =
be
> + * resized all the way to 1 to save a bit of memory.

is this just a copy/paste of really we will try to support kernels
without BPF cookies for something bleeding edge like this?..

[...]

