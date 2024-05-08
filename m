Return-Path: <bpf+bounces-29119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F308C05FA
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FF3283E7E
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF8131748;
	Wed,  8 May 2024 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZM2Ygu9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F821373
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201775; cv=none; b=kIMDhSAIaKvPZX8NwMdPyhxhkJkpmXze+YGy4Mf7Ldb0dyBaXWXC5zU3/+Cd5NryFBL8+ioEUcwnbtUCxwd8fbYFILpxZiqFPl9PhtDEATQvoGDXKmfja7dGSlrFNzBWhBmcu98lj7i6HysnvDEnEQSceeE7ZbvgV2TnO6KB4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201775; c=relaxed/simple;
	bh=b9HPaW5nDrZIXPldvrCkOIVenhM2XhXfrhxFIbonza0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cil/RjyfsHFrW/2f52gXMGsFoNuh6gZx/r8/oJewKyz35zqxalutjnkJfpwjkj+BeKgL+7UQn9hx2N3JP/EEM5mev7XLtAzBRwLhBI5JZX9VSs7SNP78Gqkf1ArM8Gtzw/4XGz6bDQ2xpGUFEcZmf8apYmr2DfPTpRYiQrjEJgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZM2Ygu9x; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b4952a1b51so199494a91.0
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715201773; x=1715806573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iV2vPrp9sgO2YTf3r3uL/WZAEXZbq0eq8z3N+IGKRWY=;
        b=ZM2Ygu9xCot+JbZF7rYRP34LrE8jHr6e9aVxZp/CYKdEWdWCnBfrGV8EYAcG6MC0Q6
         gGPbiw31oCgL8kFPtaMnvAxjkhHJMblGnb41g7IHwSoavZ0nWcVAzV/aYWdjIT5FW1Ig
         cZZm7f7J7yylwxTiAjxn0Q9Gk9zaEs24jtQfuGEGd5Ll98/MVphz8JfMRmQmxRxl6zYy
         3GefYJIlQ/dJrxKiZKCN7qriSA8izbfislwaq3dOcb9SNpevTjsu2UMlPETGWNcmqGTK
         KRvsZzhoOp1G6TB27QKu+n+8WknRNgq4qtjdmg/a1rKGMZ97bIs/6SgmUPRGViOb00dE
         t4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201773; x=1715806573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iV2vPrp9sgO2YTf3r3uL/WZAEXZbq0eq8z3N+IGKRWY=;
        b=ITfp3oSu6pb4ZkUWPJExyD3ycnXNDtsuX2MN2N76XpQRgeAcbda9Tw8ocbQUmAERJH
         ciyrhtdgPC0DmBgHKNOHOeZWfIYhp1R/aPcVLWfzJbmxqPzWiXTWkKqbDTuP5AjTVjwm
         hjJKWG+XXBBJnpV06Z1/n2Wk6cGgCTDiFsWkBsYN89kHNyzsQVQ6Uo5UjLWv4M/ZTZ6K
         QQUli+4KlPHoxfg1tXUgOLXONzATWyTIjnxTqe0QhG2Im9eD0azR+UD325eKYh6N+Vzl
         fOZya3XQsmw074J74yvutlipmpQbcG8T7lwAc0fmvxrryO00fTxGKnhJv56uKRYG243t
         s8og==
X-Gm-Message-State: AOJu0Yy2XkwZ2529Qs8pEU6Zx280ZdWn5Bkc7mEUT/NUQuPPnX6uxV3r
	Wb06DJE5YLcQ8DnReD7ZH6XvDizaTYAQ744tSCmZWze/i5oPpqc0UdRlTB3OK08a1IKay8MzYmh
	EJ8vCdbRlliz+CLz/q/3qAybJ/n0=
X-Google-Smtp-Source: AGHT+IH0YzgCeSUsncWCu/p4QbohIjG1nydrcvqrYBOfElzGLWKflOcFWz0n5H/yZukd78lQBjBUZOSnH1JGJNmCxIc=
X-Received: by 2002:a17:90a:ac03:b0:2b5:6d47:9e12 with SMTP id
 98e67ed59e1d1-2b61639c8a6mr3498622a91.2.1715201773337; Wed, 08 May 2024
 13:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508154145.236420-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240508154145.236420-1-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 May 2024 13:56:01 -0700
Message-ID: <CAEf4BzZDp3jt0eOPOh8m7XGAypiMHtPFss4-deOKViTHCe+h1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix a few tests for GCC related warnings.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 8:57=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> This patch disables a few warnings to allow selftests to compile for
> GCC.
>
> -- progs/cpumask_failure.c --
>
> progs/bpf_misc.h:136:22: error: =E2=80=98cpumask=E2=80=99 is used uniniti=
alized
> [-Werror=3Duninitialized]
>   136 | #define __sink(expr) asm volatile("" : "+g"(expr))
>       |                      ^~~
> progs/cpumask_failure.c:68:9: note: in expansion of macro =E2=80=98__sink=
=E2=80=99
>    68 |         __sink(cpumask);
>
> The macro __sink(cpumask) with the '+' contraint modifier forces the
> the compieler to expect a read and write from cpumask. GCC detects
> that cpumask is never initialized and reports an error.

this one seems like a legit unused variable that should just be removed.

>
> -- progs/dynptr_fail.c --
>
> progs/dynptr_fail.c:1444:9: error: =E2=80=98ptr1=E2=80=99 may be used uni=
nitialized
> [-Werror=3Dmaybe-uninitialized]
>  1444 |         bpf_dynptr_clone(&ptr1, &ptr2);
>
> Many of the tests in the file are related to the detection of
> uninitialized pointers by the verifier. GCC is able to detect possible
> uninititialized values, and reports this as an error.
>

We can do `struct bpf_dynptr ptr1 =3D {};` to satisfy compiler without
affecting what the test is actually testing.

Or at the very least, we should add those pragmas only around few
affected functions, not for the entire file.


I haven't looked at other cases, but let's take a step back a bit and
see if existing code makes sense and whether GCC warnings are real and
we should do something about them.

pw-bot: cr

> -- progs/test_tunnel_kern.c --
>
> progs/test_tunnel_kern.c:590:9: error: array subscript 1 is outside
> array bounds of =E2=80=98struct geneve_opt[1]=E2=80=99 [-Werror=3Darray-b=
ounds=3D]
>   590 |         *(int *) &gopt.opt_data =3D bpf_htonl(0xdeadbeef);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> progs/test_tunnel_kern.c:575:27: note: at offset 4 into object =E2=80=98g=
opt=E2=80=99 of
> size 4
>   575 |         struct geneve_opt gopt;
>
> This tests accesses beyond the defined data for the struct geneve_opt
> which contains as last field "u8 opt_data[0]" which clearly does not get
> reserved space (in stack) in the function header. This pattern is
> repeated in ip6geneve_set_tunnel and geneve_set_tunnel functions.
> GCC is able to see this and emits a warning.
>
> -- progs/jeq_infer_not_null_fail.c --
>
> progs/jeq_infer_not_null_fail.c:21:40: error: array subscript =E2=80=98st=
ruct
> bpf_map[0]=E2=80=99 is partly outside array bounds of =E2=80=98struct <an=
onymous>[1]=E2=80=99
> [-Werror=3Darray-bounds=3D]
>    21 |         struct bpf_map *inner_map =3D map->inner_map_meta;
>       |                                        ^~
> progs/jeq_infer_not_null_fail.c:14:3: note: object =E2=80=98m_hash=E2=80=
=99 of size 32
>    14 | } m_hash SEC(".maps");
>
> This example defines m_hash in the context of the compilation unit and
> casts it to struct bpf_map which is much smaller than the size of struct
> bpf_map. It errors out in GCC when it attempts to access an element that
> would be defined in struct bpf_map outsize of the defined limits for
> m_hash.
>
> This change was tested in bpf-next master selftests without any
> regressions.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/cpumask_failure.c         | 4 ++++
>  tools/testing/selftests/bpf/progs/dynptr_fail.c             | 4 ++++
>  tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c | 4 ++++
>  tools/testing/selftests/bpf/progs/test_tunnel_kern.c        | 4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/=
testing/selftests/bpf/progs/cpumask_failure.c
> index a9bf6ea336cf..56a6adb6cbbb 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> @@ -8,6 +8,10 @@
>
>  #include "cpumask_common.h"
>
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Wuninitialized"
> +#endif
> +
>  char _license[] SEC("license") =3D "GPL";
>
>  /* Prototype for all of the program trace events below:
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index 7ce7e827d5f0..9ceff0b5d143 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -10,6 +10,10 @@
>  #include "bpf_misc.h"
>  #include "bpf_kfuncs.h"
>
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
> +#endif
> +
>  char _license[] SEC("license") =3D "GPL";
>
>  struct test_info {
> diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c =
b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
> index f46965053acb..4d619bea9c75 100644
> --- a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
> +++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
> @@ -4,6 +4,10 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Warray-bounds"
> +#endif
> +
>  char _license[] SEC("license") =3D "GPL";
>
>  struct {
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3e436e6f7312..806c16809a4c 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -13,6 +13,10 @@
>  #include "bpf_kfuncs.h"
>  #include "bpf_tracing_net.h"
>
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Warray-bounds"
> +#endif
> +
>  #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __=
ret)
>
>  #define VXLAN_UDP_PORT         4789
> --
> 2.39.2
>
>

