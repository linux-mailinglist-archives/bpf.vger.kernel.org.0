Return-Path: <bpf+bounces-46621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEED9ECC8A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9151634E2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 12:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A506233682;
	Wed, 11 Dec 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZv0hZKc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2171EA6F;
	Wed, 11 Dec 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921322; cv=none; b=OunoVobOzfSzt70JbstYGNw5AeqZvhTBvHreElitC4Arc7wVAoHziDQ3XC9hqzFoa2zQoaovlJORMnMnAP7k/4zsXDGA45Pp9VeptinYZAG4vF7PKcSXL3q/CiTUqzcWc/gS/yEzCx8wAaXxJJKpYY+u4vS/ltYxIW51L/2aaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921322; c=relaxed/simple;
	bh=q7AL29J4p6NG4lXcJwqdyKDnOw/+E2JcQFmUdbqKZYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k6tbO2Bbh4N7bhBdNKJPPuyXGKaJP1lLwX3mZdtRNronHoZ2H+/yepVPdgHMeLvfvXh9m3kHdqvngxlTpKVRaLv2CbpaDImpduxeKGRy+xO+65w2prvymQdg0CP1Bj3bK/gRWzmBJIG9MGeqqlVbW64A/HxexcCkqxuNmWUdZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZv0hZKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CFBC4CEDE;
	Wed, 11 Dec 2024 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733921322;
	bh=q7AL29J4p6NG4lXcJwqdyKDnOw/+E2JcQFmUdbqKZYQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aZv0hZKc9VvDW9/i4njbAeb5HOeviBRCJWvaeoT3sS3yMLog8+5dIzYV+2kd3QaQW
	 aqrKSv2HD4EUuJZ/F0zP7eNTYPPP1wgDAOvjkocRu+LtS1JEMLi3hjFKKyHNHA0PP5
	 U+jqzEGlFsmrSb5dIh6mZD1HrbTu+S0jIVl1wpI0JviKPbE4TbTOPkBbEPguXYGDq7
	 A1JrmxtS9qXmJHBge6RUOAwUK5g9l+kUiasgLWrtizdB57xz+71pTGYn7iKIu0rBmu
	 QYYUFBTsyQ3txm29FURoNEVF0r5zrfWWnLWIuPUy8pVfgvQ6F2Ru/q+G9EfW4Jzhlh
	 6IGvAAGpfUigg==
Message-ID: <5d4dde77-b50b-4160-ad2f-f7ddcbe9feb2@kernel.org>
Date: Wed, 11 Dec 2024 12:48:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] bpftool: Link zstd lib required by libelf
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Guilherme Amadio <amadio@gentoo.org>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241211093114.263742-1-leo.yan@arm.com>
 <20241211093114.263742-4-leo.yan@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20241211093114.263742-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-11 09:31 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> When the feature-libelf-zstd is detected, the zstd lib is required by
> libelf.  Link the zstd lib in this case.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/bpf/bpftool/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index a4263dfb5e03..469f841abaff 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -106,6 +106,7 @@ FEATURE_TESTS += libbfd-liberty
>  FEATURE_TESTS += libbfd-liberty-z
>  FEATURE_TESTS += disassembler-four-args
>  FEATURE_TESTS += disassembler-init-styled
> +FEATURE_TESTS += libelf-zstd
>  
>  FEATURE_DISPLAY := clang-bpf-co-re
>  FEATURE_DISPLAY += llvm
> @@ -113,6 +114,7 @@ FEATURE_DISPLAY += libcap
>  FEATURE_DISPLAY += libbfd
>  FEATURE_DISPLAY += libbfd-liberty
>  FEATURE_DISPLAY += libbfd-liberty-z
> +FEATURE_DISPLAY += libelf-zstd


Let's not display this one, please, it brings no information to the user
about what features bpftool will support.

Looks good otherwise, thank you!


>  
>  check_feat := 1
>  NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
> @@ -132,6 +134,12 @@ endif
>  
>  LIBS = $(LIBBPF) -lelf -lz
>  LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
> +
> +ifeq ($(feature-libelf-zstd),1)
> +LIBS += -lzstd
> +LIBS_BOOTSTRAP += -lzstd
> +endif
> +
>  ifeq ($(feature-libcap), 1)
>  CFLAGS += -DUSE_LIBCAP
>  LIBS += -lcap


