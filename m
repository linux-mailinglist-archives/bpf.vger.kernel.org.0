Return-Path: <bpf+bounces-46619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478C9ECC04
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CDF161E32
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4A6225A43;
	Wed, 11 Dec 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+RxgVB6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C3238E38
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919891; cv=none; b=T7F8KMPr4F7WpD3hz5f5i0Bhx80FxXZZQPsMLKbCkVNU9rfQe9khPJm/KlnbkSrRlppptnQoKPTR8jJ/sgmjczahWYZPycnoCbImgZ+iAiWcTehMtGGuMk3W0xQ6aBI9HwbYmRWx1S+Xb3lCBVpHna9cA1Dl82fu37iSVdQdTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919891; c=relaxed/simple;
	bh=IIQWc63lACKFObEnwgjTKVsH/rDg8iq1jrHHpAweYGQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWyrEcC1JEnSOjvb5G0cw+iPNF9H3f3HSvY26S1pWcltKlweNLVR1FWhaog8qJTibTzPNHdrDpEfA/78/lsSQGv4+X1K5Ljc8YpyELQ0HBfwGQmBvLPmzlNoSFFvr3Ofa02IccV0DayAaI95lrQj26H+YfHfHC/kHuCP1jjW1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+RxgVB6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1282981966b.1
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 04:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733919888; x=1734524688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DK2LHoW+E8D7/pULzigi23ehWNjRiBBcvv18ggm2lUI=;
        b=B+RxgVB6eDNxlSHSUv/QyE5AVgZcE8Hv4bWbF6XrcSdUlOMuFNG9qyYI8XLrwtGeSA
         stOCdo51f38deGns9+vZp0bThrbvaAH9/a6W6bfC+d9uyJFE8dEfRWLRpKMnUkVFZ0IZ
         U1q+vwFlezVu/uZ7s9+9B6jDZUeIqzEE7fJERQz30Zr5mPPCgGteQl5KgDzEGFGH7OIU
         He5K7txKlnCSdhy2sGZoYbda1/ddGUufUm0QBWeuxiNB/FPFUZPLlYHMDpWs581bCq45
         cuRywFgPe/0wqkwJxUfJBjZvViWhlTGMU9Qpo1FBmBN0YGiNDVN+iQTEIEyOxZHJZLcK
         PIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919888; x=1734524688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK2LHoW+E8D7/pULzigi23ehWNjRiBBcvv18ggm2lUI=;
        b=mKGx4fqvD94tNwPcMBQMOCFWEpzBbhaBUu+NLdalO70UWUSr15Mzg5hZb4hEDldukK
         RF5HhXJ8xkiMoRflDjU78MGo+PJLCaWurQ2yGFdfroI211SRwOrOrZN6V8Z7eDs73zD1
         CVCZmkCU5OrDOUivu0m8hrcRuuTRSfAJSy4DX0PxOYn745gYNBn6rQuip/nYyHqpJsSm
         M0+qe9xiCGa9ca3RISctJJC2VAnlfAYHSyXQOOWViXwbLM4QG6it3R/i/d0n5BNsmDfv
         TqKxUS4QuCxSkst8ewkIPzerGB16mXiGYd+5wIzjHQ8GDHexjS7iUPURUUxLe13Ui+or
         Fd6g==
X-Gm-Message-State: AOJu0YxVrdqkGFmtUSSm89U45HskBfndRVF9c1ycWd/Hk3kdf449YyuP
	7TiU35YtiwMNEk1cqGlVAXuYcDv3HOHolM5AiW6VVnS7bvbFBWUn
X-Gm-Gg: ASbGncsV6B5ZPjU5HJ7UV3iRkAnDg8KD0ydF+UvIdrfPUJ+YuX9i97WAychDg5mwHI+
	H6xH7un9rRXxTc/8/y6nE3LKVzoWsBjOobsq5hdx/Pqwh7LI/VytS8k3lFiu54qyubq/s06Yvna
	8buta4i89fqDw8CRrYgX11ylFmAj1lmLIQCh/KDM0jIXhjpDLdBE0SycGy1n4Z/PmTdt/3Q4zgE
	wGFjuSZwO22BhItFMhqLb3QZxqpWryrx4dOnD4eD5+RVhkQsYRAqwf9R7PLkp5bV1bGtw6tT0fn
	OspIvuUW7mS2WlZVDRqTIXLtkEU=
X-Google-Smtp-Source: AGHT+IEARe5o/IHjmcIVhwyWJ31V6HM1d0DKrGHu5Ipmeq1jeb1lXJETjqUzy288T0saGqFXcLTpxQ==
X-Received: by 2002:a17:907:cb02:b0:aa6:6d48:b90e with SMTP id a640c23a62f3a-aa6b13afc33mr199298266b.45.1733919887997;
        Wed, 11 Dec 2024 04:24:47 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa66e2182f3sm603241266b.156.2024.12.11.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 04:24:47 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 11 Dec 2024 13:24:45 +0100
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, kernel-team@fb.com
Subject: Re: [PATCH bpf v1 3/4] bpf: Augment raw_tp arguments with
 PTR_MAYBE_NULL
Message-ID: <Z1mEjTtORv4lImyQ@krava>
References: <20241211020156.18966-1-memxor@gmail.com>
 <20241211020156.18966-4-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211020156.18966-4-memxor@gmail.com>

On Tue, Dec 10, 2024 at 06:01:55PM -0800, Kumar Kartikeya Dwivedi wrote:
> Arguments to a raw tracepoint are tagged as trusted, which carries the
> semantics that the pointer will be non-NULL.  However, in certain cases,
> a raw tracepoint argument may end up being NULL. More context about this
> issue is available in [0].
> 
> Thus, there is a discrepancy between the reality, that raw_tp arguments can
> actually be NULL, and the verifier's knowledge, that they are never NULL,
> causing explicit NULL checks to be deleted, and accesses to such pointers
> potentially crashing the kernel.
> 
> A previous attempt [1], i.e. the second fixed commit, was made to
> simulate symbolic execution as if in most accesses, the argument is a
> non-NULL raw_tp, except for conditional jumps.  This tried to suppress
> branch prediction while preserving compatibility, but surfaced issues
> with production programs that were difficult to solve without increasing
> verifier complexity. A more complete discussion of issues and fixes is
> available at [2].
> 
> Fix this by maintaining an explicit, incomplete list of tracepoints
> where the arguments are known to be NULL, and mark the positional
> arguments as PTR_MAYBE_NULL. Additionally, capture the tracepoints where
> arguments are known to be PTR_ERR, and mark these arguments as scalar
> values to prevent potential dereference.
> 
> In the future, an automated pass will be used to produce such a list, or
> insert __nullable annotations automatically for tracepoints. Anyhow,
> this is an attempt to close the gap until the automation lands, and

so this won't cover modules with raw tracepoints, but I guess it's fine
as temporary solution until we have __nullable annotation support

SNIP

>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		    const struct bpf_prog *prog,
>  		    struct bpf_insn_access_aux *info)
> @@ -6449,6 +6539,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	const char *tname = prog->aux->attach_func_name;
>  	struct bpf_verifier_log *log = info->log;
>  	const struct btf_param *args;
> +	bool ptr_err_raw_tp = false;
>  	const char *tag_value;
>  	u32 nr_args, arg;
>  	int i, ret;
> @@ -6591,6 +6682,36 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
>  		info->reg_type |= PTR_MAYBE_NULL;
>  
> +	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
> +		struct btf *btf = prog->aux->attach_btf;
> +		const struct btf_type *t;
> +		const char *tname;
> +
> +		t = btf_type_by_id(btf, prog->aux->attach_btf_id);
> +		if (!t)
> +			goto done;
> +		tname = btf_name_by_offset(btf, t->name_off);
> +		if (!tname)
> +			goto done;

I think both btf_type_by_id and btf_name_by_offset should succeed for
BPF_TRACE_RAW_TP .. should be already checked in bpf_check_attach_target

> +		for (int i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
> +			/* Is this a func with potential NULL args? */
> +			if (strcmp(tname, raw_tp_null_args[i].func))
> +				continue;
> +			/* Is the current arg NULL? */
> +			if (raw_tp_null_args[i].mask & NULL_ARG(arg + 1))
> +				info->reg_type |= PTR_MAYBE_NULL;
> +			break;
> +		}
> +		/* Hardcode the only cases which has a IS_ERR pointer, i.e.
> +		 * mr_integ_alloc's 4th argument (mr), and
> +		 * cachefiles_lookup's 3rd argument (de).
> +		 */
> +		if (!strcmp(tname, "btf_trace_mr_integ_alloc") && (arg + 1) == 4)
> +			ptr_err_raw_tp = true;
> +		if (!strcmp(tname, "btf_trace_cachefiles_lookup") && (arg + 1) == 3)
> +			ptr_err_raw_tp = true;

could we have extra mask value (or split the current one in half) in
struct bpf_raw_tp_null_args and use it for scalar arguments? so we don't
have special checks and handle everything in the loop above

jirka

> +	}
> +done:
>  	if (tgt_prog) {
>  		enum bpf_prog_type tgt_type;
>  
> @@ -6635,6 +6756,14 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
>  		tname, arg, info->btf_id, btf_type_str(t),
>  		__btf_name_by_offset(btf, t->name_off));
> +
> +	/* Perform all checks on the validity of type for this argument, but if
> +	 * we know it can be IS_ERR at runtime, scrub pointer type and mark as
> +	 * scalar. We do not handle is_retval case as we hardcode ptr_err_raw_tp
> +	 * handling for known tps.
> +	 */
> +	if (ptr_err_raw_tp)
> +		info->reg_type = SCALAR_VALUE;
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(btf_ctx_access);
> -- 
> 2.43.5
> 

