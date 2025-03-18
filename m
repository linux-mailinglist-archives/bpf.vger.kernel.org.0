Return-Path: <bpf+bounces-54253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35280A663DB
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 01:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353D47A334D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE32628D;
	Tue, 18 Mar 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtRevj4z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241818AE2
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257861; cv=none; b=eSwoh65GaxAabgs7vqWpe+HHEZ27UQxJiNGSxvNxhRjr55Cm3nSNNOdnLxoFW7cf54BsBoybnnxrc2b0wR6tsNB5VuR98tU79h4+hkvmDaWL0D7qBfuWhoxHdPiRNNqPw7L4bs3rKZ1C/kVBsra5K9KfhLKddM/k3+ZfvfKLCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257861; c=relaxed/simple;
	bh=TtmEYNkiTCkuSTB044pPXxALsYmqao5EgZpHVZJFwXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Skb7gLay4SFEQywZOuafTI/S+cPmpMVb2njofr92A1oFmYQTPZFveJn/2PCYj+k4npdKt9egSU/ZOOnLdR6A1laW3dV0rFJYRlVMwoDYnssE4JuCDDvH71/670KHedxsJ4d9ZUZkkPJr6jw97xVcR6huN9MJ9L/iaq7cv5f+9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtRevj4z; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2989171f8f.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742257857; x=1742862657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ayyxh5/J4j4y3scaMwCCLG/lcgZY37wyfVFiWkXY2A=;
        b=CtRevj4z46kTYNNn5cTmGhkfT4H8cf3UQhTj6HDw07xXrJZCFnq+AgbzFqcnW+u4q3
         bMSK9Tg8TK0W0FuwVYguJhlUWfU2NKC7p5rejwonCJg42f3Rr2Leshk2F0QWEMbFgsN9
         J++sBQUULiSSWisp4OqGFo/xUWHOdeJBEYl1Z/YT6lZzYK4al2Cz6aSB2qdcmqq+63xY
         /Etu5fSsBBl8ejKmAw5crR4giEu2jeEsbydEa4xwejTSaXzKE3aHh5gYF2lFpbH32dwT
         l5CmxhZpiuG7wmWLc6pVMT05dP28vxIqQVSNncwBBXkoHkhL9fXpQfrwt/dC/dtCU6T7
         TDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742257857; x=1742862657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ayyxh5/J4j4y3scaMwCCLG/lcgZY37wyfVFiWkXY2A=;
        b=rzTdELMwuiM0iOsOuojptUE/WaQLhB12GL2zt1cWJUokjkHxmTl7MMsq70bxCoXxl0
         LegrwBeqZP/YlZYLmkonq/qWQuzfDeitdqbaAe13/N1D3wFf7nktur+KsWQ8cm2yy+tj
         Ayhd9aemjk8EKObc4sg8zYgvnXhJTTmXo1W+9darImhi4Jakcnte4HLZWSw+BANoH8bu
         qLZiD4l0aVUq6aqEXUtvE+iM2aR0ZjQxquTkrgZta5GNe0LwsIx2wraLMvflYO69NgAM
         yStvUOwcXWifU0O9A7opyOpaVM1dhkdiXdCJ+YpKeUp9LeY7Gzb5y3AfWIOYfxcQYNMu
         y19g==
X-Forwarded-Encrypted: i=1; AJvYcCW9onZZOEneAgHEjCWLoRtrqXQLvR+39rn5MWDEMOyVdh/q+lZD5YeJPVXKeQz0+FMkRn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUagwtWhzGhp/adJ67DYIN4JkhUmjVL+QWaZtzrcvIRd2hiPL
	1cwC6oNXPAklMFWZtgaqc0k+zUVJyShzsTX4BbWEMQBfH17OKeVHxPP2lk1+cc6cOJXX3EcldPK
	bW/rPlCzGtfhSMFh3AAKVZBYcid4=
X-Gm-Gg: ASbGncuibQEo3Ysb9I4FIJt2FjIcDW4qNcgpfv03cbR5UDH5MybdCDhZ0i9GxSBE+q6
	JtLEObxsEUQljzatt1TtP7MH2kC4y8zHIk2J061xZvheSOxg5jUbr1mJVYukQ1bG2X9l2RHSb1G
	pmcT88Hj0Z690JL5KAlVWjZcYaz3CuIE53mi9f75KpAA==
X-Google-Smtp-Source: AGHT+IHv+6NUPs08oNJpiXFh/qd8P0xjVMj34lHnHs2+lE77TBAZRAwx9qKlQf8/iMJz5AKkdF76MYyGE0X9+xIfPzg=
X-Received: by 2002:a05:6000:18ac:b0:391:39ea:7866 with SMTP id
 ffacd0b85a97d-3996b446d57mr1464270f8f.19.1742257857318; Mon, 17 Mar 2025
 17:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317224932.1894918-1-vadfed@meta.com> <20250317224932.1894918-4-vadfed@meta.com>
In-Reply-To: <20250317224932.1894918-4-vadfed@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Mar 2025 17:30:46 -0700
X-Gm-Features: AQ5f1JpkKG7Zk9WDfl_1BPLGOuYczHzYBmU3vBnMDjLc4Glu2w6dJWe_c9nHu4w
Message-ID: <CAADnVQKzXjC2-24V_dYiq_cCf8Df-Sm0Kf=keiyBrLKZ0yXeVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 3/4] selftests/bpf: add selftest to check
 bpf_get_cpu_time_counter jit
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Yonghong Song <yonghong.song@linux.dev>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>, X86 ML <x86@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 3:50=E2=80=AFPM Vadim Fedorenko <vadfed@meta.com> w=
rote:
>
> bpf_get_cpu_time_counter() is replaced with rdtsc instruction on x86_64.
> Add tests to check that JIT works as expected.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../selftests/bpf/progs/verifier_cpu_cycles.c | 104 ++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index e66a57970d28..d5e7e302a344 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -102,6 +102,7 @@
>  #include "verifier_xdp_direct_packet_access.skel.h"
>  #include "verifier_bits_iter.skel.h"
>  #include "verifier_lsm.skel.h"
> +#include "verifier_cpu_cycles.skel.h"
>  #include "irq.skel.h"
>
>  #define MAX_ENTRIES 11
> @@ -236,6 +237,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bit=
s_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>  void test_irq(void)                          { RUN(irq); }
>  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
> +void test_verifier_cpu_cycles(void)          { RUN(verifier_cpu_cycles);=
 }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/to=
ols/testing/selftests/bpf/progs/verifier_cpu_cycles.c
> new file mode 100644
> index 000000000000..5b62e3690362
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Inc. */

botched copy paste.

