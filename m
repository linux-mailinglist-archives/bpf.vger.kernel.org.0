Return-Path: <bpf+bounces-40700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A471B98C45B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D7E283393
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0CC1CBEB3;
	Tue,  1 Oct 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGnfKxS1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523B1CB506;
	Tue,  1 Oct 2024 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803180; cv=none; b=C4rZpkRTOG+pdMyhW+tlKrl9rkxy1NeevYAg7JhvJKl6+vOq+iZ8RM21FwmuTiIi8W2kuxFnepAul7VFJweK4yWx57QUYr77xX39Sllvxhuq+FJJmge/Zti6yMZbaglCcwoSNsSYzP/YIxA3ukHJMeQfHZvU0mAgM41IIs3I90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803180; c=relaxed/simple;
	bh=YwvwOYKm0pbiNgOsSOMXh5XWtzLGBR17gzHrpZQp+R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGMy1tHfPSn+Z2XDTIOLSfw8LIqWDYw8saTQ9BUyjfUSyayUlJ8peX7hAew8+pOgV3qYE1+rXI37cQYCpmbdKMZyGWEz3opyytEAhz97Y51nSn/UDcSV2ddmFjUUeeAx2/WgqkxW6mx0/UKulf/EgoYPJ1yhvBOoL/W6KgcLCfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGnfKxS1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2413312a91.0;
        Tue, 01 Oct 2024 10:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727803178; x=1728407978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hgkQFCdWJfDVkatkm5AEFVWF2+tpBRkxXHX4/K9vLA=;
        b=FGnfKxS1BexopcdaaHBwX7sSZhHFFWb7euzXpkbdSoYWxD8kYRz1OOzauwRK3+Jqgo
         z2jIdrdB5FwuXttFEegzdLeo7rbUhYSNhhUIZ1ZjtCLNUUtehCf7iYk7H5TMSOWTWILi
         4VQpUNR/yYwm3o8Tt7u9Pb5v3v5NLU7L8oUfxEqwDf1R+GrJXxntF51GgBjxb+t189dX
         5xDusirGL5eVuitx1Ctga8awXR0cx1IL3fx3eXe53iKxzn/QDigDkKSQlueLUlCCaGL9
         iwDtANECfmVRI7drHqydr35mPtdfzgCnMqo3VF96ShzmJkoD28QknEUZyxeRujIxYOTA
         E0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803178; x=1728407978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hgkQFCdWJfDVkatkm5AEFVWF2+tpBRkxXHX4/K9vLA=;
        b=gvbcRK93TOs/jUeKaL/y8CnU9pJ/VyF/MejLfClh0zKktyLEhhPWasScqlYqS//P55
         /fwQTidP09sZYVprbsqIyyayqrAFZDq4cMexSXybLYvl8kJk7QTlUCTz9VdRBKmEQejY
         sm6K3ANB4CExTEsIJGQilX4TXeFg5J5rP0qbbEIagen3F+9w2KOVnIVAPlOuYUvLhIGN
         2pt7xX73t/qfMQ3H8M3TlELeaxKPg/XQ7D5c5NiUBrvysZIALGgq6kl1c+De2mDxHxHY
         jyyU6N6Sgo3bc5Q0TmSRVs04u8dAdj/mgvjrfuA+KchqZDRqbc7xQG427MKR82yNo/LA
         ebCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvOcLowTqT43MTEvG+c+WoB+Bd1FlR5bpSX3tvvrmOIq05aqEpU6+8qBkqKDrm/DmZN4GYTMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQklLgq+0w+iOTqo+Y8x46Cx5EUK6u9kvCSztNL4sCcKwZ+Hyd
	UdET8yXr8YIx1M495S+Zs8ikYvvcCie0GgK+koI4PY5AedpUzGB9vKm2r0EUiJErtX4btRr51KI
	UPz26345022exT567+lJd8aXQE4o=
X-Google-Smtp-Source: AGHT+IFDL54lydId1coYWKBS5UCLBQM2DKyUQmzK0jfcubg3cJ/cO6VoISxu9CbvE07IQoCYwYtb7X3uizqDZ1R2vGI=
X-Received: by 2002:a17:90b:103:b0:2e0:80e8:a319 with SMTP id
 98e67ed59e1d1-2e1849e8669mr461154a91.34.1727803178342; Tue, 01 Oct 2024
 10:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe> <20241001-libbpf-dup-extern-funcs-v3-2-42f7774efbf3@hack3r.moe>
In-Reply-To: <20241001-libbpf-dup-extern-funcs-v3-2-42f7774efbf3@hack3r.moe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:19:26 -0700
Message-ID: <CAEf4BzZp1n9KVU_fthftbsgeBPO95zqwcuL4GcavBMcmYEsOVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: test linking with
 duplicate extern functions
To: i@hack3r.moe
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 8:55=E2=80=AFPM Eric Long via B4 Relay
<devnull+i.hack3r.moe@kernel.org> wrote:
>
> From: Eric Long <i@hack3r.moe>
>
> Previously when multiple BPF object files referencing the same extern
> function (usually kfunc) are statically linked using `bpftool gen
> object`, libbpf tries to get the nonexistent size of BTF_KIND_FUNC_PROTO
> and fails. This test ensures it is fixed.
>
> Signed-off-by: Eric Long <i@hack3r.moe>
> ---
>  tools/testing/selftests/bpf/Makefile                  |  3 ++-
>  .../selftests/bpf/prog_tests/dup_extern_funcs.c       |  9 +++++++++
>  tools/testing/selftests/bpf/progs/dup_extern_funcs1.c | 19 +++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/dup_extern_funcs2.c | 17 +++++++++++++=
++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index e295e3df5ec6c3c21abe368038514cfb34b42f69..644c4dd6002c691a9cd94ef26=
ddf51f6dc84e2cc 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -496,7 +496,7 @@ SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c tes=
t_sk_assign.c
>  LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h         =
 \

we already have linked_funcs.skel.h, let's add all this there, it sort
of matches (it's all functions, no?)

>                 linked_vars.skel.h linked_maps.skel.h                   \
>                 test_subskeleton.skel.h test_subskeleton_lib.skel.h     \
> -               test_usdt.skel.h
> +               test_usdt.skel.h dup_extern_funcs.skel.h
>
>  LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c          =
 \
>         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
> @@ -520,6 +520,7 @@ test_usdt.skel.h-deps :=3D test_usdt.bpf.o test_usdt_=
multispec.bpf.o
>  xsk_xdp_progs.skel.h-deps :=3D xsk_xdp_progs.bpf.o
>  xdp_hw_metadata.skel.h-deps :=3D xdp_hw_metadata.bpf.o
>  xdp_features.skel.h-deps :=3D xdp_features.bpf.o
> +dup_extern_funcs.skel.h-deps :=3D dup_extern_funcs1.bpf.o dup_extern_fun=
cs2.bpf.o
>
>  LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
> diff --git a/tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c b/=
tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b26f855745b451f7f53e44b27=
d47a2f659ad1378
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/dup_extern_funcs.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "dup_extern_funcs.skel.h"
> +
> +void test_dup_extern_funcs(void)
> +{
> +       RUN_TESTS(dup_extern_funcs);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c b/tool=
s/testing/selftests/bpf/progs/dup_extern_funcs1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a5b6ea361c3d457d48bc56204=
0f1ef946fadfc81
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs1.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +void *bpf_cast_to_kern_ctx(void *obj) __ksym;
> +
> +SEC("tc")
> +int handler1(struct __sk_buff *skb)
> +{
> +       struct sk_buff *skb_kern =3D bpf_cast_to_kern_ctx(skb);
> +
> +       if (!skb_kern)
> +               return -1;
> +
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c b/tool=
s/testing/selftests/bpf/progs/dup_extern_funcs2.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2f9f63dcc6ed2a35e82b55da5=
4356502cfc95c9d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/dup_extern_funcs2.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +void *bpf_cast_to_kern_ctx(void *obj) __ksym;
> +
> +SEC("xdp")
> +int handler2(struct xdp_md *xdp)
> +{
> +       struct xdp_buff *xdp_kern =3D bpf_cast_to_kern_ctx(xdp);
> +
> +       if (!xdp_kern)
> +               return -1;
> +
> +       return 0;
> +}
>
> --
> 2.46.2
>
>

