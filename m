Return-Path: <bpf+bounces-18804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E3822257
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C355284733
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F515EB9;
	Tue,  2 Jan 2024 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiL/ADkR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4216401
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea226bda8so646374e87.2
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704225433; x=1704830233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueqOy4wVVJJdvpgIZvRS0KXQa6tSfnBiRX+i+1IVcLw=;
        b=aiL/ADkRw/eDnf1e1Xzy7tLz3/SPr6FsmYSCiCQ4EE+JZU/odxKNZ3Q8xn8HwI1+dr
         LBJ0d6QXOntS6ooZwW8oJaQhS6GLklypKD8cIf6j3+QWMFMmFc5NqLZse3nMFPcABryt
         WtfbvVtQwbAa+ig/DgQ9Ra7ayw307YNBfaDD9js0GEjNeb4dHYGNya2WNfGQZbeZpQwd
         v+uA1s1m7MTHinIKC08IPEjsHHW9+X56jOkQf3kgSewEDKjoT5nHwlLso3oEzcLHphYP
         zbdywpT9PGwG+9JXwtcbtlwv6Q67KVmMqyezp+nIbFyWEbRhqwRJdJnmEf79QdkpMc3U
         yOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225433; x=1704830233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueqOy4wVVJJdvpgIZvRS0KXQa6tSfnBiRX+i+1IVcLw=;
        b=TK3YEKdk9RxDEFCI1iYAMulN+yoz7d7HIs3aHwBmsSacmIvSZWxfOOh3eVyMHl2n0e
         IoQatzWKJp1Sh6qve5rBPY5mPvqxQ6SxyTwt7iSk1vThbCcUN4TeF5iFoemR2/tgOkBr
         udSMXgrZgxPQQvt4/hsp1ktiMV7yTETScgl7rgu7zLgm3IHyvDyiN4bAIwarRY9BufP2
         Q5zQ6gpuCgGTjIv/rxnRNamcwj+wB4EISfscYkl8646qjR6wwPQmQS1lP1QCcx3XY/X6
         ECurDdrE1FrIbV2fdj8w774q7nZZgIY2qAxfqhsIc+YNR4QxdvjCdnHvt0+qb/IkOQnC
         YNSQ==
X-Gm-Message-State: AOJu0YzUkP5rdeqJXUM8V0vbB59G0xpjA5X5UCXvuN59cwDKxaNE99Lx
	kxvlCsHsJpx3tqxE8+VkxwZSF9vDh+XQmnG3As8Fv9wr
X-Google-Smtp-Source: AGHT+IG3UT+qDsw+fY0/SV8KQlQIqJ85DlkYnkxW4RkczzpcABDTCS8suauTxzBAP46cWfc5AfaWC90TZIeLQEagUyk=
X-Received: by 2002:ac2:44c6:0:b0:50e:3d5b:cfef with SMTP id
 d6-20020ac244c6000000b0050e3d5bcfefmr6893998lfm.53.1704225433212; Tue, 02 Jan
 2024 11:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org>
In-Reply-To: <20240102190055.1602698-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 11:57:01 -0800
Message-ID: <CAEf4BzbffZ5vh5eC8e+n2MeGwGzDH_YnNHRo5cDajPCyy9hsgA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/9] Libbpf-side __arg_ctx fallback support
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Support __arg_ctx global function argument tag semantics even on older ke=
rnels
> that don't natively support it through btf_decl_tag("arg:ctx").
>
> Patch #1 does a bunch of internal renaming to make internal function nami=
ng
> consistent. We were doing it lazily up until now, but mixing single and d=
ouble
> underscored names are confusing, so let's bite a bullet and get it over t=
he
> finish line in one go.
>
> Patches #3-#7 are preparatory work to allow to postpone BTF loading into =
the
> kernel until after all the BPF program relocations (including global func
> appending to main programs) are done. Patch #5 is perhaps the most import=
ant
> and establishes pre-created stable placeholder FDs, so that relocations c=
an
> embed valid map FDs into ldimm64 instructions.
>
> Once BTF is done after relocation, what's left is to adjust BTF informati=
on to
> have each main program's copy of each used global subprog to point to its=
 own
> adjusted FUNC -> FUNC_PROTO type chain (if they use __arg_ctx) in such a =
way
> as to satisfy type expectations of BPF verifier regarding the PTR_TO_CTX
> argument definition. See patch #8 for details.
>
> Patch #9 adds few more __arg_ctx use cases (edge cases like multiple argu=
ments
> having __arg_ctx, etc) to test_global_func_ctx_args.c, to make it simple =
to
> validate that this logic indeed works on old kernels. It does.
>

Oops, I forgot to add version history. It's basically:

v1->v2:
  - do internal functions renaming in patch #1 (Alexei);
  - extract cloning of FUNC -> FUNC_PROTO information into separate
function (Alexei);

> Andrii Nakryiko (9):
>   libbpf: name internal functions consistently
>   libbpf: make uniform use of btf__fd() accessor inside libbpf
>   libbpf: use explicit map reuse flag to skip map creation steps
>   libbpf: don't rely on map->fd as an indicator of map being created
>   libbpf: use stable map placeholder FDs
>   libbpf: move exception callbacks assignment logic into relocation step
>   libbpf: move BTF loading step after relocation step
>   libbpf: implement __arg_ctx fallback logic
>   selftests/bpf: add arg:ctx cases to test_global_funcs tests
>
>  tools/lib/bpf/libbpf.c                        | 1055 ++++++++++-------
>  tools/lib/bpf/libbpf_internal.h               |   24 +
>  .../bpf/progs/test_global_func_ctx_args.c     |   49 +
>  3 files changed, 725 insertions(+), 403 deletions(-)
>
> --
> 2.34.1
>

