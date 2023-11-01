Return-Path: <bpf+bounces-13840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E57DE7C0
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 22:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E41C20E07
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AA01BDD6;
	Wed,  1 Nov 2023 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4FQFgju"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F223BC
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 21:57:11 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A193130
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 14:57:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d2c54482fbso43801066b.2
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698875827; x=1699480627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlUfYIg82W3YYt5r8qMRQs66TZKukXlWHzglGay6f18=;
        b=f4FQFgjuCS7qlOgGuHHW85J3j3VHFr4tWE7fizAsa7dZE9zgmf2W670wQJALxLIB0Q
         AcGYCM+z55Ph0j9avJMf2k/Elu7KABHh0hArxTrqyqgK32VMHwblfW5SVyB3ffZ/8t2g
         JGhHF/jXHLoVu6eIXQ5/7J2HAF+TywUKKMY3GbE0aTFFcRxMDW6Fk3Kwebz2ntMt2PdH
         bftVvpXhhtxb/xo6C4fHrfCD1qf8y0HaNChEiW/SdEKpmCuPw5UVQJsIw7Ta4kEak7CH
         Z341w+stzRtw329KFQLyiMj96SeMFEqJJRNU0730YaFB85x3SKJRPqvj7jwq0cyHYa7f
         w+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698875827; x=1699480627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlUfYIg82W3YYt5r8qMRQs66TZKukXlWHzglGay6f18=;
        b=k9u4I/zSnaxAQKHZdcoDDmqSs6cgbXWoyb5kcORn8D138Abw1/4ZqICUNFatAg+wVm
         kXkTgeRqOcmmA1e8gPuEmd/Ouei1vZj8bVPrWXxCWX71I6XOrC26TdFoplw56Qhz2Y2M
         TxLBDBtihMdQvsI+pUUPV03VW484pkYbyHTabeOknN5HDAfXemphVREhjX02e2AKFEM0
         nK6NA/23anGnXoBbD5r3JgAKol5cZNOp7M6B183a78R0Q+NIDzY8hFAhf4K/ndWYdY60
         bpU1W/8oCQnS6xk7JlNIsj2ZeCUErMEzoQen6Z58Z/EFhLkVN9ZarEYrhjlhQumjPcoU
         Erzw==
X-Gm-Message-State: AOJu0YyHW+OBTQgKJp6BrLRRelPh5JOg1nXe3Ugoo2d+ub9rVEIdHiaM
	w2uvfhMFJlDzbZfHheDH50hPQzgzBuQSu5HqNFE=
X-Google-Smtp-Source: AGHT+IFZqid4fhLPeJ1xGrarExFgEQwhbJoVqulnEhnjvvQNUpp1gP1pTDke1gMKUH6CsMzuoR68/9onawfeYeX68n4=
X-Received: by 2002:a17:906:2308:b0:9d7:139:ca03 with SMTP id
 l8-20020a170906230800b009d70139ca03mr1973704eja.11.1698875826880; Wed, 01 Nov
 2023 14:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023220030.2556229-1-davemarchevsky@fb.com> <20231023220030.2556229-5-davemarchevsky@fb.com>
In-Reply-To: <20231023220030.2556229-5-davemarchevsky@fb.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Nov 2023 14:56:55 -0700
Message-ID: <CAEf4BzYK9s+Wses5OnZgwL3=56PTcmXtp6WC+uQ8LCpzxghaEg@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/4] selftests/bpf: Add tests exercising
 aggregate type BTF field search
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:01=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> The newly-added test file attempts to kptr_xchg a prog_test_ref_kfunc
> kptr into a kptr field in a variety of nested aggregate types. If the
> verifier recognizes that there's a kptr field where we're trying to
> kptr_xchg, then the aggregate type digging logic works as expected.
>
> Some of the refactoring changes in this series are tested as well.
> Specifically:
>   * BTF_FIELDS_MAX is now higher and represents the max size of the
>     growable array. Confirm that btf_parse_fields fails for a type which
>     contains too many fields.
>   * If we've already seen BTF_FIELDS_MAX fields, we should continue
>     looking for fields and fail if we find another one, otherwise the
>     search should succeed and return BTF_FIELDS_MAX btf_field_infos.
>     Confirm that this edge case works as expected.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  .../selftests/bpf/prog_tests/array_kptr.c     |  12 ++
>  .../testing/selftests/bpf/progs/array_kptr.c  | 179 ++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/array_kptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/array_kptr.c
>

[...]

> +SEC("tc")
> +__failure __msg("map '.bss.A' has no valid kptr")
> +int test_array_fail__too_big(void *ctx)
> +{
> +       /* array_too_big's btf_record parsing will fail due to the
> +        * number of btf_field_infos being > BTF_FIELDS_MAX
> +        */
> +       return test_array_xchg(&array_too_big[50]);

how often in practice people are going to index such arrays with a
fixed index? I'd imagine it's normally going to be a calculated index
based on something (CPU ID or whatnot). Is that supported? Can we add
a test for that?


> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>

