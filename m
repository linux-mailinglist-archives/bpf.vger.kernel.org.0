Return-Path: <bpf+bounces-56374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C3AA95C84
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 05:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414D41898486
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 03:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EDA19D89B;
	Tue, 22 Apr 2025 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBK5QcRl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB93EAFA;
	Tue, 22 Apr 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745291341; cv=none; b=ja9bQZobGlvKZXrrEut8av0JfZACjmDKTsGIvwou2WxfYJX10Ps8AIvhboeQMRwlPQlqQA+jUmr3FRTo46rknxUgNHlbw1uCf32noetKEF/NvlO/2toPVzjqlbYhwzo4dZSkuW8ot/KyeaN1o8c9ZZK+itaLcIQwknWuKEOAvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745291341; c=relaxed/simple;
	bh=neLgSU6fZ88Gq4ywcKceTeJZXqBgok9pT8ATnfIQE+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI+m4GNdGJNlCXfluEm1CO5/vXbCZqL/EWI7t+1UohAduibdgLUtGWssdkODWb8o+H3zQk6ntqW11Eclj/xLrEup6AmFiees6oQOOhsYeFhKQzPpTw/dnECiHJtEgotzYN007RrnY+FXk/6A6B5zdkm/TXUwv/TWVbli9ekFOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBK5QcRl; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac25d2b2354so667600066b.1;
        Mon, 21 Apr 2025 20:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745291338; x=1745896138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGwxEYRlN7uDPHaf0HP+8DwOhkQo5lfcpdh4X0nTvWE=;
        b=mBK5QcRlJpUKshfH9UBDGX1o8whmFIDQx6MLsWFmMfWculg3QIcyrC1aHMZGbalqUb
         VQlNHyquRiUpM/DQMDKhun7bubrhWIaJJWRqAqXR3RTSNjD0J44Ew2Kt5c28bjM07BxN
         wLb9Cbb/Cq24xK5Z3nd3q9DP6Qq3v4MEuc+Hk1gAtkCEh+VytLKhgO01BYNzSwRhxMix
         XpFDvGJQ3Z0+UgbCtujJ7DbVHbXhOUA99yk0t5JhEtWq5cV4LWe8br4UtMHxuyP6ac6k
         szmoIAAZuW7G75ehxsRMl37/+Gmzl/oaugdrgH18kZQIvSKUC6SfxI/hxvHq2dXPttTj
         WAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745291338; x=1745896138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGwxEYRlN7uDPHaf0HP+8DwOhkQo5lfcpdh4X0nTvWE=;
        b=Wj0TRMgQViy00wtvjxFd6VpwkEljHMvZpN6us5A68e68/vAVWc0iZCK4a7viliB7dM
         Whu5kQARaqD7L0tYL3ykinQDVwzsND9lKAlRR2FvndgPTUBUaBDZ1Bap7Gnbou55U7ZX
         eQse5V0uMHyJbVbFN5S8Vvwr+1iASM5n44ZvNnSLneYrRxrVrplP2BpV1rkPzomDmUdI
         vQLKbcISFlBMrRE8h07VskiOVVWLe+eq4oAPwptfWS+UZUKBf6cvejXI9k2jjD5Okx7r
         a1uGhdW10GK/6oGfpdjzyRejsAPXHoa1lnseOcBCtKY44CJ7mULCnMKxvpwA0utXpsOy
         Lzdg==
X-Forwarded-Encrypted: i=1; AJvYcCXhkWO6EwTuV89Pl2BOoXe54H/rS0TmF6JEcrdus0gOHhIPa4qlvU9fIvbNoxkHG7SkUuZrFvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2rdWMcNgv9VA+g2AdgZHAghtkp0tiTj/c1PvZHFU9EoPixSKJ
	85WjYPKYSYQRsfr9YVE/ffqsetFDNF2v0ndnSsAaGfrPcsCSCx+jzvNBLuVzP/QeoJj7eZp5lkv
	TCoacER0v+5YsApCpaDuUnMyl50M=
X-Gm-Gg: ASbGncs+tvytv1NkKMc7Z4DeeX6XhDPzS4ERvcVSsBSlRCXpoEvZKSVp86ixs+4qFO8
	9UHEINSEV/RjBdE9UuysIBtuvL6zsPFGb87zZ8le1U4i5NfsTtrrzzriV/71QIdxUp+AwWQXLLG
	qWFU6BBgkvS82g2Vyzoc5fPresC/lS0zOxJd3oIklkqso=
X-Google-Smtp-Source: AGHT+IEOMxs5YXyqUMJPgMG3wykV1xzKg/BBTtoLFyp6heiNrdDGP/4mge4Awtl3ET4D4ywLGA/JU+6GMjGFsg0awxY=
X-Received: by 2002:a17:907:869e:b0:acb:bbc4:3362 with SMTP id
 a640c23a62f3a-acbbbc43abamr220324766b.27.1745291338232; Mon, 21 Apr 2025
 20:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-11-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-11-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 05:08:21 +0200
X-Gm-Features: ATxdqUFSZQruXezVC6ImRlAH1YQRTiJvTpaXI-i0AoOocwdYYiQ4Mjzi-Lb36Cs
Message-ID: <CAP01T76heQ9rV1sNdssBQ_mSeDk_yxwP-Binh_j-AfTtXFVPdw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 10/12] selftests/bpf: Add test for bpf_list_{front,back}
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch adds a test for the new bpf_list_{front,back} kfunc.
>
> It also adds a test to ensure the non-owning node pointer cannot
> be used after unlock.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/linked_list.c    |   2 +
>  .../selftests/bpf/progs/linked_list_peek.c    | 104 ++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/linked_list_peek.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> index 77d07e0a4a55..559f45239a83 100644
> --- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
> +++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
> @@ -7,6 +7,7 @@
>
>  #include "linked_list.skel.h"
>  #include "linked_list_fail.skel.h"
> +#include "linked_list_peek.skel.h"
>
>  static char log_buf[1024 * 1024];
>
> @@ -804,4 +805,5 @@ void test_linked_list(void)
>         test_linked_list_success(LIST_IN_LIST, false);
>         test_linked_list_success(LIST_IN_LIST, true);
>         test_linked_list_success(TEST_ALL, false);
> +       RUN_TESTS(linked_list_peek);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
> new file mode 100644
> index 000000000000..26c978091e5b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +#include "bpf_experimental.h"
> +
> +struct node_data {
> +       struct bpf_list_node l;
> +       int key;
> +};
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
> +private(A) struct bpf_spin_lock glock;
> +private(A) struct bpf_list_head ghead __contains(node_data, l);
> +
> +#define list_entry(ptr, type, member) container_of(ptr, type, member)
> +#define NR_NODES 32
> +
> +int zero = 0;
> +
> +SEC("syscall")
> +__failure __msg("invalid mem access 'scalar'")
> +long list_peek_unlock_scalar_node(void *ctx)
> +{
> +       struct bpf_list_node *l_n;
> +       struct node_data *n;
> +
> +       bpf_spin_lock(&glock);
> +       l_n = bpf_list_front(&ghead);
> +       bpf_spin_unlock(&glock);
> +
> +       if (l_n) {
> +               n = list_entry(l_n, struct node_data, l);
> +               if (n->key == 0)
> +                       return __LINE__;
> +       }
> +
> +       return 0;
> +}

Would be good to have tests explicitly asserting the type is
non-owning ref (even though we indirectly do that by touching it after
unlock, relying on invalidation logic.).

> +
> [...]
>

