Return-Path: <bpf+bounces-71449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B399BF3AB1
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F290A3A9C96
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE52E2EF2;
	Mon, 20 Oct 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJeNF0/g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79F2D061C
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994480; cv=none; b=HRC9S/vqvaRr8nNHzJvaGS9dgom4CbbTrW/htvf1HMoW13Onj57nG+FlqyY4vdsEiPR0WbdTfCEkvDeE5vlaWo435IcsL7votC2Kbo3yvI8MvKOl+EjjthASxoPbV8bMoN9h/NSp/fch5+EKNZTVhOwzm2GPhLPv20YhgbYQ/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994480; c=relaxed/simple;
	bh=ZWrqJyDvIDg2LD0dgF/C+wHsQhPZnS6RElBjzy9dJSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of17teK8v1miFhn6x8E4kVFUm71hpioFNE/+WpqgDqYGj1kYAOdYkrTJ9Tlqy/S6i6NUwf9OWoS9hiciAx4+0XHVbIvdwhJYy13ce7ORARhXr0PwzCq8VVVz1jOU9LOfuqIpQ6h5oBwYCKHqxAOkRfU55aS9+1K8Egi3vKren78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJeNF0/g; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78125ed4052so5971963b3a.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994468; x=1761599268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvn+vrsKw5XSlxeW29aeMY9MH6dfWC3aPx/eGlTqx28=;
        b=QJeNF0/gVci4TDLomAqNKC4I1xtltetVJOtcOYXOMPjBfRzTjzvFzI4EtIzB8dSd2C
         jDK7CEWdurYxzZKUPBcyQ50UjDEzJXy+n8Y5Olk0iC7E1Zf/p4hqSeaeONoMi10ca/T+
         J2zZM0Gj2I8fk1KUaK7i/TrVMEKppGqoQRuRDsQlFSl5uTUpfnpaAOC/TdHOdRylplAL
         TqRXtzUHQDvq/TWAaYxkr2jUC67v2TwxOew1HLw0JucMXZ225Xxp4wB++uReFuMcU5qC
         nhEHkOIfJRtzuknfDnVvWhPrpm7IlY37gxN8TuCYYh2zxNu+IS/cufU1QtnM5VY02RpN
         7Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994468; x=1761599268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvn+vrsKw5XSlxeW29aeMY9MH6dfWC3aPx/eGlTqx28=;
        b=Yj2AQQkCZCGDMCMNGt+vWUqtOZKamwDUaT5jaQLY4ZraBOc7u4wgKCJW2Oc8nrWEw5
         KBC+03RFT7Zo5rRBJGTMvK1fIZawhlVzev7ntrIAb3+0dYTgu3e0cnyNZffwMClnXt62
         bUIsrcBFwZEnA4RabqBZ82g6bzLfzsLc48qOHesR77QkB6g/lgoj/z/1JCzlp45Wfd7G
         QUZl87Zj0cGtOZR3s17tCmhQROzUxTEmCNjk6PoQ/xwFgsXQZvmKi5LUo+AuQsvYyFOC
         2cZghcjIzVj2Ihm5Kin8ghlOGFWEJAN662G6qFLSqUeX3cEep8ALLrCWCLqC1RAPQvj1
         yMPg==
X-Forwarded-Encrypted: i=1; AJvYcCUs8pKpLmP9tBODWdneXlwjtIRuqkFX/9jeVe5iET/Nb15TLUx04/KrXT9iyoDd+oSN6uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAKz+mZf0kB2OQYG6JZSyxHlMhrUr3Qpn8luBnDdnuakaiB1k
	5Ib/INv16sv5MAxwH8X5XVTqo7GuqauckyTLCXXB5s5xsbFYq7ima3F7UY8xAK7d+/noOAQkk0g
	7VGqanZUBPNHr7XxfJvNg6dZazzBHSHI=
X-Gm-Gg: ASbGncuAVjnbaxeCgIoAg3NbyuJpnM2wGI7/pYq0jrYU5w4eJjMavXU5cX42BP7qiZ3
	mLO0+ybbUxo4vQzILnH07wNPOqy+8f0E8eNoNE55IjUb1CnQQfQQrLcGxlTJ3tHPgwMg8p1zLQ4
	b6jZ4qlKoxTqHen/Ocn6g2TNSgGaxReFBA52b+mzoSMUUf7qgsyxMSNpBQ1FhCQpkwrmpOfASwS
	YfLpa1tyeNsKQv65R8oobr1yIc7+YpT/W5A8sPxjl+ameaR0g2ljgdSDO3Y6g/kipIR4sJ/TEuD
	DXzZ36tM4RM=
X-Google-Smtp-Source: AGHT+IHJUsRDRnpRSxe1003HNcktdrqLiZyGbAI+Gojc1lcs3iZjP+3giXQdokcAFAcyvQonnIwRnHE+A9BI3i5W0sw=
X-Received: by 2002:a17:90b:3c0d:b0:332:50e7:9d00 with SMTP id
 98e67ed59e1d1-33bcf86b347mr19293614a91.11.1760994468297; Mon, 20 Oct 2025
 14:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-15-alan.maguire@oracle.com> <CAEf4Bzanp4fSOLZp5a5bifXh3447-rjScPRVwf2xDsA_pNmizA@mail.gmail.com>
 <73e5248e-80d9-4440-92d9-864112d4e53b@oracle.com>
In-Reply-To: <73e5248e-80d9-4440-92d9-864112d4e53b@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 14:07:33 -0700
X-Gm-Features: AS18NWBD8BA51R9HhUfj2iNSq_U5KJQuj8DTxVHbEh3Z-AcFc7iTw7ojC56tNL4
Message-ID: <CAEf4BzYj7JKksxLG7_75Rm4ZTHeeAkJc5n8E5PRWSps0VWBU_w@mail.gmail.com>
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

On Fri, Oct 17, 2025 at 7:02=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/10/2025 19:36, Andrii Nakryiko wrote:
> > On Wed, Oct 8, 2025 at 10:36=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Add support for BTF-based location attachment via multiple kprobes
> >> attaching to each instance of an inline site. Note this is not kprobe
> >> multi attach since that requires fprobe on entry and sites are within
> >> functions. Implementation similar to USDT manager where we use BTF
> >> to create a location manager and populate expected arg values with
> >> metadata based upon BTF_KIND_LOC_PARAM/LOC_PROTOs.
> >>
> >> Add new auto-attach SEC("kloc/module:name") where the module is
> >> vmlinux/kernel module and the name is the name of the associated
> >> location; all sites associated with that name will be attached via
> >> kprobes for tracing.
> >>
> >
> > If kernel ends up supporting something like this natively, then all
> > this is irrelevant.
> >
> > But I'd test-drive this in a purpose-built tracing tool like bpftrace
> > before committing to baking this into libbpf from the get-go.
> >
> > Generally speaking, I feel like we need a tracing-focused companion
> > library to libbpf for stuff like this. And it can take care of extra
> > utilities like parsing DWARF, kallsyms, ELF symbols, etc. All the
> > different stuff that is required for powerful BPF-based kernel and
> > user space tracing, but is not per se BPF itself. libbpf' USDT support
> > is sort of on the edge of what I'd consider acceptable to be provided
> > by libbpf, and that's mostly because USDT is stable and
> > well-established technology that people coming from BCC assume should
> > be baked into BPF library.
> >
>
> Yeah, that makes total sense; the implementation is really just there to
> facilitate in-tree testing. We could move it to selftests and have
> custom ELF section handling there to support it though without adding to
> libbpf. It would definitely be good to have some in-tree facilities for
> testing to ensure the metadata about inlines is not broken though.
> Ideally this would be done by adding inline sites to bpf_testmod but the
> RFC series did not support distilled/relocated BTF (which is what
> bpf_testmod uses). Next round should hopefully have that support so we
> can exercise inline sites more fully.

TBH, for selftests we don't really need to invent BPF_USDT()-style
macros and such. I'd keep it simple and have some explicit global
variables-based approach to lookup a few values at correct locations.
No need to be really fancy here, IMO.

>
> >
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/Build             |   2 +-
> >>  tools/lib/bpf/Makefile          |   2 +-
> >>  tools/lib/bpf/libbpf.c          |  76 +++-
> >>  tools/lib/bpf/libbpf.h          |  27 ++
> >>  tools/lib/bpf/libbpf.map        |   1 +
> >>  tools/lib/bpf/libbpf_internal.h |   7 +
> >>  tools/lib/bpf/loc.bpf.h         | 297 +++++++++++++++
> >>  tools/lib/bpf/loc.c             | 653 +++++++++++++++++++++++++++++++=
+
> >>  8 files changed, 1062 insertions(+), 3 deletions(-)
> >>  create mode 100644 tools/lib/bpf/loc.bpf.h
> >>  create mode 100644 tools/lib/bpf/loc.c
> >>
> >
> > [...]
> >
> >> diff --git a/tools/lib/bpf/loc.bpf.h b/tools/lib/bpf/loc.bpf.h
> >> new file mode 100644
> >> index 000000000000..65dcff3ea513
> >> --- /dev/null
> >> +++ b/tools/lib/bpf/loc.bpf.h
> >> @@ -0,0 +1,297 @@
> >> +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> >> +/* Copyright (c) 2025, Oracle and/or its affiliates. */
> >> +#ifndef __LOC_BPF_H__
> >> +#define __LOC_BPF_H__
> >> +
> >> +#include <linux/errno.h>
> >> +#include "bpf_helpers.h"
> >> +#include "bpf_tracing.h"
> >> +
> >> +/* Below types and maps are internal implementation details of libbpf=
's loc
> >> + * support and are subjects to change. Also, bpf_loc_xxx() API helper=
s should
> >> + * be considered an unstable API as well and might be adjusted based =
on user
> >> + * feedback from using libbpf's location support in production.
> >> + *
> >> + * This is based heavily upon usdt.bpf.h.
> >> + */
> >> +
> >> +/* User can override BPF_LOC_MAX_SPEC_CNT to change default size of i=
nternal
> >> + * map that keeps track of location argument specifications. This mig=
ht be
> >> + * necessary if there are a lot of location attachments.
> >> + */
> >> +#ifndef BPF_LOC_MAX_SPEC_CNT
> >> +#define BPF_LOC_MAX_SPEC_CNT 256
> >> +#endif
> >> +/* User can override BPF_LOC_MAX_IP_CNT to change default size of int=
ernal
> >> + * map that keeps track of IP (memory address) mapping to loc argumen=
t
> >> + * specification.
> >> + * Note, if kernel supports BPF cookies, this map is not used and cou=
ld be
> >> + * resized all the way to 1 to save a bit of memory.
> >
> > is this just a copy/paste of really we will try to support kernels
> > without BPF cookies for something bleeding edge like this?..
> >
>
> Yeah, copy-paste; it seems unlikely that a kernel would have location
> data and not have BPF cookie support. Even given the fact distros
> backport stuff it's generally fixes not features like this. If we end up
> moving some testing code to selftests I'll simplify removing no-cookie
> workarounds. Thanks!

yeah, going forward we can assume BPF cookies are available, they are
pretty fundamental

>
> Alan

