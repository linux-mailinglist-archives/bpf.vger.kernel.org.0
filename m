Return-Path: <bpf+bounces-79515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D7D3B89A
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7544304B079
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E715E2F4A05;
	Mon, 19 Jan 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyQuD8EO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6F2C1594
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855064; cv=none; b=Vx+4ZNdsLaAMY7sQODipRyyIZFa3mktzWbNwVmFrVLyvC8p6IWEtE0Wy+N+zPlBCSlrzsjk+3yNCqIiiehnjdUjkB3f2ADTYWtfdY5SZoAvefPATkjQYlDg+fH2GAfNxJb1ifRBp2qGD/zVDahBrp3TgpBe3zPm2wtofmOUUDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855064; c=relaxed/simple;
	bh=YA4vN+4ReplHxz2m3b9bFg9dLEcGhNL33RenmFV0B+I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVUvnGzNkvvwfD3YP/PW4hRFK7+Bez8yn3cKjvs0TqHU5iqwnlentF9cKzQ5QL6NzGqb62avKJ/+32bZhHsRdabtpINmaLz9SjjOZLf3qgK4DHJe3ULZJnKLyV4dWLUaYyeLEwl+ESeA/eABcgxO5zwqV9XHvYKloWDyV6upMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyQuD8EO; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso9986427eec.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 12:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768855062; x=1769459862; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obxFYhoxSkY4ewKsf8MOe+lJXVK2fvzWgYRyrUOL5ZU=;
        b=gyQuD8EOPqIhJwWHi8gFpzdXPjhR1clJoUwMrWhDvYoBYbY+OIir5ykuMdV0joJ2VF
         AZu3BFb/rgVxR6bZ/cWn1q1hmFk2YJHCZA5CbYrHiiFERmYdJ5f/SXjFQw9kySVEnNfR
         g4IOYfTsuvo2MYvYxWRbkMrp3lyNVPSpiFkq9MDOOYdZw28nM3uy4BZde0Xxau9iP7qh
         FL/p6vIdgtlRskoeizF7cCByzg0nnc/geMV9ctJzysd0LZKEHkCgsBuIidWIMLWGQOZc
         MTbLL5MS5LApslXJUovXe+cH7cfSnYfPblSk9nB5jribb+MT+het4eiRBUgMSnr352RU
         zIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768855062; x=1769459862;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obxFYhoxSkY4ewKsf8MOe+lJXVK2fvzWgYRyrUOL5ZU=;
        b=j/WupD9WBAtxhhfLLdPCNqX4LJdyeHkWQli5MBqOqZaqsFxorRu5foRvNCOOg47Wgt
         tjQzeFV/loX8F3WoZhXlvfEkGBMMgeZfXntetWIrBerXFioicPdflKhVmmw3d/ByzWrV
         MXlR+5qXPO/pfpXVQABeE1v8w9drdCUBa4+/fJqvsQpeuu5QP0XFYuNIphHFXCAMKjCf
         0Z8oVGFee6G49RB9/dZ2tGO6CWdxenI+FRwtpAQvowbgS7n+B2hH+rwryv7onVuOx7r4
         qyNfgSYEpzg+Up0ZGSfE1u8yYzMWfvWyxD1Rm/oJuJ2PAsVRrt4w4mBwuBnzYx92u53Y
         NAlA==
X-Forwarded-Encrypted: i=1; AJvYcCWLaxjmx2LbHikoLK7RvW4ksBvTUF7l2ByDJvUh/2oXA3jknW6FgwcGz0Kt6CKHOgjeoHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQykjwV/baGAaHTwpeTBxleTPApKeHXQSZi5RI44dkk+lUh+g
	Xeu9PX6qgS121PRhwrHxBk3wZ7Ft/DtzEGP4/nCt391r7Kl3kkNoGIeh
X-Gm-Gg: AZuq6aLqmUP9Zfl5VJ1zFvwzJ8qOxW6vDiWqAZeuzfCzl2Elymo71h2c+q5BI7RUNbG
	1I0NQ0wg/RmejiHcI6AKcmV9R06EnU6aITMRKE5Hu0nnDBz6dO9+Co9A7jhdNliC0vPRtEXhrDy
	fqybS4PbCV+b4Ivk6xFoPEEJqgJItNCC/++gY2TPVWtCkMLQZA+1vxc8KA5GqZTbbL7bLuMdXCW
	oPXQcZmzz4BZRONhzhCkZxkGwll3kebVEnuIitaEmcS/hXpwVc8FGvMwd7LHYAik1ld/Zt9s/NK
	b3H3hI5AlzwIN9ePAzBYCUnIuLRC7E3FWYlbr1wzHSN6cQpiLAVAafAwAX9jUQGjW4fSsRzla72
	UxQ7i7FFYYaYWVtBhFssp34IfZrRQdMe7XxzrkZ9r2HcjDVbNWI9AFp3RppNo9cOS5mf3IKZRyf
	GQjIfQiosWdo2L6PcpIcOGw3N0V/fDVCMd5RNRw9fbAQjdjqfahJjJv2PJ9wJxopnuUA==
X-Received: by 2002:a05:7301:4104:b0:2af:cd0a:ef75 with SMTP id 5a478bee46e88-2b6b414bdc4mr8473914eec.34.1768855062294;
        Mon, 19 Jan 2026 12:37:42 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm16121656eec.2.2026.01.19.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:37:41 -0800 (PST)
Message-ID: <0a277a7ff97395803d114a0ea74a5cab9fd75237.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2026 12:37:39 -0800
In-Reply-To: <20260119070246.249499-3-dongml2@chinatelecom.cn>
References: <20260119070246.249499-1-dongml2@chinatelecom.cn>
	 <20260119070246.249499-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 15:02 +0800, Menglong Dong wrote:
> Add the testcase for the jited inline of bpf_get_current_task().
>=20
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>  .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline=
.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 38c5ba70100c..2ae7b096bd64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -111,6 +111,7 @@
>  #include "verifier_xdp_direct_packet_access.skel.h"
>  #include "verifier_bits_iter.skel.h"
>  #include "verifier_lsm.skel.h"
> +#include "verifier_jit_inline.skel.h"
>  #include "irq.skel.h"
> =20
>  #define MAX_ENTRIES 11
> @@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bit=
s_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>  void test_irq(void)			      { RUN(irq); }
>  void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
> +void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
> =20
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> new file mode 100644
> index 000000000000..0938ca1dac87
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)

I don't think this #if is necessary as well as 'dummy_test'.
test_loader.c:run_subtest() checks current architecture against a mask
supplied by __arch_* annotations and skips the test for unsupported
archs.

> +
> +SEC("fentry/bpf_fentry_test1")
> +__description("Jit inline, bpf_get_current_task")

Nit: please don't use __description() for new tests,
     it makes "./test_progs -t" tests selection harder.

> +__success __retval(0)
> +__arch_x86_64
> +__jited("	addq	%gs:{{.*}}, %rax")
> +__arch_arm64
> +__jited("	mrs	x7, SP_EL0")
> +int inline_bpf_get_current_task(void)
> +{
> +	bpf_get_current_task();
> +
> +	return 0;
> +}
> +
> +#else
> +
> +SEC("kprobe")
> +__description("Jit inline is not supported, use a dummy test")
> +__success
> +int dummy_test(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
> +char _license[] SEC("license") =3D "GPL";

