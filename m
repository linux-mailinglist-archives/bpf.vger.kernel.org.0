Return-Path: <bpf+bounces-71237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0031BBEB1BD
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579011AE0B3D
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFEF305E1B;
	Fri, 17 Oct 2025 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLPW7+KD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C152320CBA
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723007; cv=none; b=MH+qLKObAWAgVM09MbM5LwljITPEzDo9HmGIEZH1Shem/L03ynWldBpAv/DyZ/fCw8s4pNKNGyi+QlE8bzILR9SXXC/lqHbebCLcGgPCUDk8SkMSbL54gy+RJbyBPs5cWxIPxO9LpzQLeCSvX+BA6qaYgPbi9xNorq7pmFskVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723007; c=relaxed/simple;
	bh=SzwG80orR0KyjbJGsDL4Lk6XBr5LlL2ziF5DJdoF8vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI6prTorEDz7LLx0siz7MFLE6kCnD8Yrbu5pJXDWj9PYnIlIxzJt9Lz/iuCkzm748XugjWdhSEyRGOMOFmqPETe+Z/4XBRA9SBND7RLinsnkK3nCH4FnHErq2r+xI39ftbUtOApq4LS79fN0guBykho/j5Wj1p3fZs7TIyejbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLPW7+KD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711b95226dso9044835e9.0
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760723004; x=1761327804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRzeZLlvSYSmX6btyx8XyIjkEXrJ2cxReJu1vLvlzYs=;
        b=aLPW7+KDdS8vqadRPp/FdcmdJQX/ZyappqQoF3fSUSW1CIiGWou0Wrg0kXRZmAFtWV
         oMOUg8zCRqqv++8nVTdV+fuxCIYavX4CEJS27JkuTIEc7MqOrcZmXvER5BEdps4ilfkc
         jsfVIy4FlvZUzCoIcaZNb3qrAjxwSi3U5bndGb4JP1jsYfOLUmLiwMS75lbXz6RiEGmt
         K0lQFzRzYKnd2GVfdExbTR+u3takJ3J+pZS1O1w6Pc5Eye98ClOaWl9HWqYdZsvzg21h
         +P92Mz8Rm3SD4DLFR7E0d1vfP/SYiusdDOCDx8a6eCXSvWWlRrZAv58+QLhRc6dHuCuB
         brHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723004; x=1761327804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRzeZLlvSYSmX6btyx8XyIjkEXrJ2cxReJu1vLvlzYs=;
        b=Lb4hKXdxcyMz0pz/ESjfwfkzvR+bDg0ZCDQUAVTf5zYE3EdzLyhEzrDRGDbR287rw5
         dgHyJ+jFLIacrZwaH6V7SUKY2aOpyT02blnuCmxUiu0uDR/xYLuSJYiIW1FzGel4m4hm
         J2xjajlay000uNK1PN55IIWj713/hrcvC1LyZM/v36B6YVfluI1jEpxZ0WjNOIHFmSz7
         YVYvi6ZlXkaf8DvG2EVXZOW723L86l8txt6akxk00z2/HRTOF51xM0BT14Av9F1re+md
         g4eKtqz550Aax2ObTxUG1kHACy+DUydVHM1GF8KQN16AOMpDv7zYgUTAc4C7iKZBfugy
         CwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP1SWTklQOEyQtKGp4yYCZNfaDWGfovN9MjpDs3MH3VdnOB63eeLrCKvjg69zaNr791wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTKoyARnSTQpm5OfihGVCf2y9mhIBz7jr6F3wjqs+VDNz4Hjt
	PLcWRKruX91V4xJ9GwriWSUYooUQE6u50NZN6ogIyUEMAkwvdAi1lgp9+obxTUgyIewoN/GCoMV
	WiG2tDGK+BbS7xez0L2G8wZrHv0T/TS0=
X-Gm-Gg: ASbGncs3a3DtrAca2E1i0IALJOjt5yIWaFSGmA+USFeSCnA3oy5gt/jHj+luI1bOTra
	fZnao+Cyh0KT/N4HXZJjEXQ52JA409Rd2u4Rqatofr77I9q+QUV/0Ic5ZDRgh4gOw2IfPgsuNFQ
	OlaVNQMN8UIoU2PFfS2QrQxPSyhyOeMJTnqAHvfpwMA/l8kdzgy7dEkqJQDYBIm8mUYhxPC8u2c
	LwL3df4bu/9+Mbfzw+ALGCyONW16Cv1KWibpc21Gaq9LAmOD96v1DtY57f13u3mE3p7ExxCalz2
	PQTd+kZJ3qN82Z9Kl2F5OczIb/t1
X-Google-Smtp-Source: AGHT+IGwjv5q5HxRJPZy7uGhifIefXNDIaOZVKZU/13/4yaI1fvzOvO97tQTSB/cm6SYZUm/7ygu5jhmpr1UQwH7RBk=
X-Received: by 2002:a05:600c:1d9b:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-4711787672dmr33538135e9.7.1760723003430; Fri, 17 Oct 2025
 10:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017092156.27270-1-yangtiezhu@loongson.cn>
 <CAADnVQJjSNEuX=HJKrD=pefC4C9dQk2aqP+hnRscUEDTntVXyA@mail.gmail.com> <1ce0c35c4c444ba85f753df5b0d0c5cd4870d887.camel@gmail.com>
In-Reply-To: <1ce0c35c4c444ba85f753df5b0d0c5cd4870d887.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 10:43:11 -0700
X-Gm-Features: AS18NWCvCrEwueVkZLL5kNJdSq_uFBaX05ife2xVW1Aux4shB_Th_00Bw7YdeU4
Message-ID: <CAADnVQKPOjNJ4KuCtyApnr27UbJtpqgZZS3ToVhmnUiXnSfrjQ@mail.gmail.com>
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix set but not used errors
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:40=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-10-17 at 10:20 -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 17, 2025 at 2:35=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > >
> > > There are some set but not used errors under tools/testing/selftests/=
bpf
> > > when compiling with the latest upstream mainline GCC, add the compile=
r
> > > attribute __maybe_unused for the variables that may be used to fix th=
e
> > > errors, compile tested only.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > ---
> > >  tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c | 3 +=
+-
> > >  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c            | 3 +=
+-
> > >  tools/testing/selftests/bpf/prog_tests/find_vma.c              | 3 +=
+-
> > >  tools/testing/selftests/bpf/prog_tests/perf_branches.c         | 3 +=
+-
> > >  tools/testing/selftests/bpf/prog_tests/perf_link.c             | 3 +=
+-
> > >  tools/testing/selftests/bpf/test_maps.h                        | 1 +
> > >  tools/testing/selftests/bpf/test_progs.h                       | 1 +
> > >  7 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic=
_ops.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > > index d32e4edac930..2b8edf996126 100644
> > > --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > > +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> > > @@ -226,7 +226,8 @@ static void test_lpm_order(void)
> > >  static void test_lpm_map(int keysize)
> > >  {
> > >         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_N=
O_PREALLOC);
> > > -       volatile size_t n_matches, n_matches_after_delete;
> > > +       /* To avoid a -Wunused-but-set-variable warning. */
> > > +       __maybe_unused volatile size_t n_matches, n_matches_after_del=
ete;
> >
> > I think it's better to disable the warning instead of hacking the tests=
.
> > Arguably it's a grey zone whether n_matches++ qualifies as a "use".
> > It's certainly not a nop, since it's a volatile variable.
> >
> > pw-bot: cr
>
> Maybe something like below?
>
> --- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> +++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c
> @@ -223,6 +223,8 @@ static void test_lpm_order(void)
>         tlpm_clear(l2);
>  }
>
> +static int print_stats; /* debug knob */
> +
>  static void test_lpm_map(int keysize)
>  {
>         LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags =3D BPF_F_NO_PR=
EALLOC);
> @@ -334,14 +336,14 @@ static void test_lpm_map(int keysize)
>         tlpm_clear(list);
>
>         /* With 255 random nodes in the map, we are pretty likely to matc=
h
> -        * something on every lookup. For statistics, use this:
> -        *
> -        *     printf("          nodes: %zu\n"
> -        *            "        lookups: %zu\n"
> -        *            "        matches: %zu\n"
> -        *            "matches(delete): %zu\n",
> -        *            n_nodes, n_lookups, n_matches, n_matches_after_dele=
te);
> +        * something on every lookup.
>          */
> +       if (print_stats)
> +               printf("          nodes: %zu\n"
> +                      "        lookups: %zu\n"
> +                      "        matches: %zu\n"
> +                      "matches(delete): %zu\n",
> +                      n_nodes, n_lookups, n_matches, n_matches_after_del=
ete);

For this particular one, yes. But other tests just do j++ to have
non-empty loop body that does something to make sure that
compilers don't remove the loop.

