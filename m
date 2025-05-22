Return-Path: <bpf+bounces-58743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F34AC128A
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 19:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E10A502EC1
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245A299ABA;
	Thu, 22 May 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyUEFjiT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282918FDBE;
	Thu, 22 May 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935771; cv=none; b=aW/hZhDagG8DBtAoLo7iI9za3B1QW1d4NOrwq8JCTYsqTwwxpKRlDZPsIO/r1nTJc6jjy1yJVbpMv+aNl1e3jcsDfX1lBtt5kGKrhGkyhmbfUoa0M6oC4hG4nDrbWGX8sGXrkeCjM+1btMC/Hvnl8yPx7/1IAhYE2L3JUTbdOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935771; c=relaxed/simple;
	bh=nc4C4Sk84UMmyGcLldRWRh/kbRCgfb4nqiv+61p0Hnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ/zypu2OWln4mR2yrainnT1vh7mQ5A2NjbIIWVu8FQ0n9uaYlSAgZnKTrkDdxlHrqA7kYwq8W1plPPUUmyRT4ZVpibUzkKdySRbXHI1deyWigkThcGYUdjovtXV5l02LEYe++RWo75IcqumTKWpuGtodswRcAyGTrE1voMzjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyUEFjiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C8C4CEE4;
	Thu, 22 May 2025 17:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935770;
	bh=nc4C4Sk84UMmyGcLldRWRh/kbRCgfb4nqiv+61p0Hnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyUEFjiTrkuo9gTJRR20Cf4fCrnaKCpIQGMniNiVvHWYKi4QX0YwkcXkb8GTOysUy
	 EwGoLXT4+rqZnp3ij59mAeDBdHmHlClLLoc6yZ2YRNRQFCPDDptXLahVbeoHDDPn4+
	 HC2sO1awEaW0kFD5xZydOLn7n2aLHoGKFe2AbsfPPsCRAtzXi+3xC8uyKrrBwh+bHW
	 fuAl3PUYx+6p7bcupLBZkXwg8YAcRDmlFjXeDsABqXWehl6/1N+Ic9a8+IKjB9Pi0m
	 a8ZMyWRAnuI4H2ifMFxCo3LxJUlGAe9JRiKEWOY+EJzRdoVtv4fcn3wGGM6EdlvfQM
	 OCLVGTjDTIqFQ==
Date: Thu, 22 May 2025 14:42:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	James Clark <james.clark@linaro.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
Message-ID: <aC9iF4_eASPkPxXd@x1>
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521222725.3895192-2-blakejones@google.com>

On Wed, May 21, 2025 at 03:27:23PM -0700, Blake Jones wrote:
> The BTF dumper code currently displays arrays of characters as just that -
> arrays, with each character formatted individually. Sometimes this is what
> makes sense, but it's nice to be able to treat that array as a string.
> 
> This change adds a special case to the btf_dump functionality to allow
> arrays of single-byte integer values to be printed as character strings.
> Characters for which isprint() returns false are printed as hex-escaped
> values. This is enabled when the new ".print_strings" is set to 1 in the
> btf_dump_type_data_opts structure.
> 
> As an example, here's what it looks like to dump the string "hello" using
> a few different field values for btf_dump_type_data_opts (.compact = 1):
> 
> - .print_strings = 0, .skip_names = 0:  (char[6])['h','e','l','l','o',]
> - .print_strings = 0, .skip_names = 1:  ['h','e','l','l','o',]
> - .print_strings = 1, .skip_names = 0:  (char[6])"hello"
> - .print_strings = 1, .skip_names = 1:  "hello"
> 
> Here's the string "h\xff", dumped with .compact = 1 and .skip_names = 1:
> 
> - .print_strings = 0:  ['h',-1,]
> - .print_strings = 1:  "h\xff"

I'll test this but unsure if this part should go thru the perf tool
tree, perhaps should go, together with some test case, via the libbpf
tree?

- Arnaldo
 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  tools/lib/bpf/btf.h      |  3 ++-
>  tools/lib/bpf/btf_dump.c | 51 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4392451d634b..be8e8e26d245 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -326,9 +326,10 @@ struct btf_dump_type_data_opts {
>  	bool compact;		/* no newlines/indentation */
>  	bool skip_names;	/* skip member/type names */
>  	bool emit_zeroes;	/* show 0-valued fields */
> +	bool print_strings;	/* print char arrays as strings */
>  	size_t :0;
>  };
> -#define btf_dump_type_data_opts__last_field emit_zeroes
> +#define btf_dump_type_data_opts__last_field print_strings
>  
>  LIBBPF_API int
>  btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 460c3e57fadb..a07dd5accdd8 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -75,6 +75,7 @@ struct btf_dump_data {
>  	bool is_array_member;
>  	bool is_array_terminated;
>  	bool is_array_char;
> +	bool print_strings;
>  };
>  
>  struct btf_dump {
> @@ -2028,6 +2029,50 @@ static int btf_dump_var_data(struct btf_dump *d,
>  	return btf_dump_dump_type_data(d, NULL, t, type_id, data, 0, 0);
>  }
>  
> +static int btf_dump_string_data(struct btf_dump *d,
> +				const struct btf_type *t,
> +				__u32 id,
> +				const void *data)
> +{
> +	const struct btf_array *array = btf_array(t);
> +	__u32 i;
> +
> +	if (!btf_is_int(skip_mods_and_typedefs(d->btf, array->type, NULL)) ||
> +	    btf__resolve_size(d->btf, array->type) != 1 ||
> +	    !d->typed_dump->print_strings) {
> +		pr_warn("unexpected %s() call for array type %u\n",
> +			__func__, array->type);
> +		return -EINVAL;
> +	}
> +
> +	btf_dump_data_pfx(d);
> +	btf_dump_printf(d, "\"");
> +
> +	for (i = 0; i < array->nelems; i++, data++) {
> +		char c;
> +
> +		if (data >= d->typed_dump->data_end)
> +			return -E2BIG;
> +
> +		c = *(char *)data;
> +		if (c == '\0') {
> +			/* When printing character arrays as strings, NUL bytes
> +			 * are always treated as string terminators; they are
> +			 * never printed.
> +			 */
> +			break;
> +		}
> +		if (isprint(c))
> +			btf_dump_printf(d, "%c", c);
> +		else
> +			btf_dump_printf(d, "\\x%02x", *(__u8 *)data);
> +	}
> +
> +	btf_dump_printf(d, "\"");
> +
> +	return 0;
> +}
> +
>  static int btf_dump_array_data(struct btf_dump *d,
>  			       const struct btf_type *t,
>  			       __u32 id,
> @@ -2055,8 +2100,11 @@ static int btf_dump_array_data(struct btf_dump *d,
>  		 * char arrays, so if size is 1 and element is
>  		 * printable as a char, we'll do that.
>  		 */
> -		if (elem_size == 1)
> +		if (elem_size == 1) {
> +			if (d->typed_dump->print_strings)
> +				return btf_dump_string_data(d, t, id, data);
>  			d->typed_dump->is_array_char = true;
> +		}
>  	}
>  
>  	/* note that we increment depth before calling btf_dump_print() below;
> @@ -2544,6 +2592,7 @@ int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>  	d->typed_dump->compact = OPTS_GET(opts, compact, false);
>  	d->typed_dump->skip_names = OPTS_GET(opts, skip_names, false);
>  	d->typed_dump->emit_zeroes = OPTS_GET(opts, emit_zeroes, false);
> +	d->typed_dump->print_strings = OPTS_GET(opts, print_strings, false);
>  
>  	ret = btf_dump_dump_type_data(d, NULL, t, id, data, 0, 0);
>  
> -- 
> 2.49.0.1143.g0be31eac6b-goog

