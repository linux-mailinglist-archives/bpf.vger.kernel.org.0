Return-Path: <bpf+bounces-75000-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEDC6B51D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 20:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB79035ED0E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0C2DF134;
	Tue, 18 Nov 2025 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlLuidYa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86462DCBF8
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492352; cv=none; b=T2F+jR3+YHgGQIKbE4cxrYcsGz+nFx0+5dmcBQbkLexccND5bgPqvOIF4d12VfR9tW5hn2Gr0AMY0hOgERAnzzjLlV/k+fVKAeWtbQ0Dkpvybs3/AipDaxs7iUeypQStG7MOjim45bYLcUSlsW44iBtdl/GzPAl97h0fpdwVge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492352; c=relaxed/simple;
	bh=54YiAmlwnUGrcdLrpn3hc+a2egAT+HDaxLUh2C5mIfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsxwW41ANs84ZsO72kOdEUhSOfXENAYx+nEmvfor6N5w+uHqrw8fq/VWoLyNw3WhuygurfmVCtAZ9rJ8afhZvD6jHvEP9ml6aDX+ke2eSHsPfvW74Jg7pjdh1uqnheez4fFRG35WT8XQAgxDAe3AKz/iYbhk9ROqiR6UlUOVSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlLuidYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA485C19423
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763492352;
	bh=54YiAmlwnUGrcdLrpn3hc+a2egAT+HDaxLUh2C5mIfQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZlLuidYaXt5p1HIeGuRnk7MAFths+ZljbVlHt/phlZoUhB6mtIfW2YnXLuxLZ7rup
	 +s7/7uiOzi3I1NhLhxr9QwIrm2jB+q5wt3PcjKXAtMheOxhZdByZ8HTq3gToGq3wBR
	 mRWZFWcOHoa9MwaZpQrnKNDFMKYddQ0QUrqbaRgor2ntO9TxahONKgsGGZZWFBI8oj
	 bmogrAywbYmvGYIlBVTgpETIbXdCUr0GPqtyx6msNOUz2RR8bgriMfBKzOzWJG8X2U
	 zTCRuMG+ROq2FLNxOYLQ7Z0/HvLbiFaUD0+N8NaYz7XUXFW03WmuSO8UwUcd9864vp
	 CppGLo2aFyH3Q==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-780fe76f457so53562457b3.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 10:59:11 -0800 (PST)
X-Gm-Message-State: AOJu0YwN4BrVKI6mzLm02Eme+D2g8HBoNe22SZgytXwlU3j3SrGUZikL
	R/7Q/4VadWAm7dgmaKlViiNuWBvxzRSsiqDA3j5RiTz86mxMQVEukHAeQUpzPgZybVdbdevKgXo
	V0GwVzCaZvD0e/rWDGo+TnDAxFyVLd7s=
X-Google-Smtp-Source: AGHT+IFE3fhoYHAcf4P0PbeVqiGAZ7D7Uvdlz+Pll+XdpoRwFXX6Cxp/FxvK+9XRZH7cO+YySpTZuotXVcu69vEG/00=
X-Received: by 2002:a05:690c:22c9:b0:789:3166:25a7 with SMTP id
 00721157ae682-78931663580mr234618727b3.46.1763492348488; Tue, 18 Nov 2025
 10:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118073734.4188710-1-mattbobrowski@google.com>
In-Reply-To: <20251118073734.4188710-1-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Tue, 18 Nov 2025 10:58:57 -0800
X-Gmail-Original-Message-ID: <CAHzjS_t_o+m97tbELkFVZq_5aPY_ZZD3H2BmKSN9vzWO5S-4eA@mail.gmail.com>
X-Gm-Features: AWmQ_bkaefgydNk4sd67HUwYXeHOm9rZFspP0ggCI_64T-vXeN1m_t2bSTs2x_4
Message-ID: <CAHzjS_t_o+m97tbELkFVZq_5aPY_ZZD3H2BmKSN9vzWO5S-4eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: use ASSERT_STRNEQ to factor in
 long slab cache names
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:37=E2=80=AFPM Matt Bobrowski
<mattbobrowski@google.com> wrote:
>
> subtest_kmem_cache_iter_check_slabinfo() fundamentally compares slab
> cache names parsed out from /proc/slabinfo against those stored within
> struct kmem_cache_result. The current problem is that the slab cache
> name within struct kmem_cache_result is stored within a bounded
> fixed-length array (sized to SLAB_NAME_MAX(32)), whereas the name
> parsed out from /proc/slabinfo is not. Meaning, using ASSERT_STREQ()
> can certainly lead to test failures, particularly when dealing with
> slab cache names that are longer than SLAB_NAME_MAX(32)
> bytes. Notably, kmem_cache_create() allows callers to create slab
> caches with somewhat arbitrarily sized names via its __name identifier
> argument, so exceeding the SLAB_NAME_MAX(32) limit that is in place
> now can certainly happen.
>
> Make subtest_kmem_cache_iter_check_slabinfo() more reliable by only
> checking up to sizeof(struct kmem_cache_result.name) - 1 using
> ASSERT_STRNEQ().
>
> Fixes: a496d0cdc84d ("selftests/bpf: Add a test for kmem_cache_iter")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

LGTM.

Acked-by: Song Liu <song@kernel.org>

