Return-Path: <bpf+bounces-19115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF22824F92
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052A61F22C07
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25E320B37;
	Fri,  5 Jan 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quo1Mdut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC520B29
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e80d40a41so1591829e87.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 00:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704442568; x=1705047368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRShYcucNXaR640BsevHR3hUNLw9fdWJPmv5lYSr/no=;
        b=Quo1MdutXVX9liUODrLeLkKsLJjwGnIqEaO6zDqS+NkGDtMzKn2/EVjZ5IDVs61pY+
         iDL8AhOiYjgA37LmIF53OE9fMwWZ2f2JNygtkvBdACc4LZlQhVmQB78TjPLMHsrRXA0g
         r9dv4x1VS81kgx5JhwS57h9XgKNYrp8SXJnLbyp57W7CyWmeNOOWapzla78nuPEN8fim
         cJ36P5SVpgqR0RYarwZ8yu7ynvJRmx5bZNdPAq9edo6V31529DT3Hv6NViIDSA8wXxeF
         Jwd+H2PZVKEmjnX9MmLQrk/ERSHuh2I7nqsTUBqc4ixeGqKAIDlApFxoHC29rgYDoHYR
         yrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704442568; x=1705047368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRShYcucNXaR640BsevHR3hUNLw9fdWJPmv5lYSr/no=;
        b=B8TLfsUpjEGwynY9MqPxqe30Z3W885CEifGmwrP+HKOWrzm6bdecUOlNb26MURg6Yp
         GZk07Kbqu3JcgkKrueMRjJSwSkEEndPoRHuNcY+83DOGSzGWvOMagILCC6JLzKmj6yLx
         rWhA8dOppx7Yt+DLEqSl+JAzWYaGn2BB9sq2f8tc2ClF04c2Gu5BknpyRKFJ41v4cbWm
         gZuSnXAFNwxg9ZU5xDhR63hI+SVShI9/fwd9Awns5HnTwfUmEXg+E3I+lSTGES94lg+L
         j7ubhNFDpru3EB7Hr7yuT74tVadF+EW/736sLvv8dDLGFFMJtlVAjlvDG+pmYQUrveBL
         5IEQ==
X-Gm-Message-State: AOJu0Yz9x/ZdHzKKkpeBV5wUUhv/Xxr6brXrr163zurrNEmNLKKAyqGW
	xkuo2T5W/ZRaS1MYTWp/ULI=
X-Google-Smtp-Source: AGHT+IGi6hrkXAo4HoD9odK3xRFfmIPc9e4Lv4So41M7556JabPACuwEB/fs60BW/2zXX9MxFEBBrA==
X-Received: by 2002:a05:6512:39c8:b0:50e:af8c:1ee6 with SMTP id k8-20020a05651239c800b0050eaf8c1ee6mr801491lfu.65.1704442567317;
        Fri, 05 Jan 2024 00:16:07 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709067c8e00b00a26b37e0e7fsm597252ejo.60.2024.01.05.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:16:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jan 2024 09:16:05 +0100
To: andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: detect testing prog flags support
Message-ID: <ZZe6xaT6xGNyXizA@krava>
References: <20240104223932.1971645-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104223932.1971645-1-andrii@kernel.org>

On Thu, Jan 04, 2024 at 02:39:32PM -0800, andrii@kernel.org wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Various tests specify extra testing prog_flags when loading BPF
> programs, like BPF_F_TEST_RND_HI32, and more recently also
> BPF_F_TEST_REG_INVARIANTS. While BPF_F_TEST_RND_HI32 is old enough to
> not cause much problem on older kernels, BPF_F_TEST_REG_INVARIANTS is
> very fresh and unconditionally specifying it causes selftests to fail on
> even slightly outdated kernels.
> 
> This breaks libbpf CI test against 4.9 and 5.15 kernels, it can break
> some local development (done outside of VM), etc.
> 
> To prevent this, and guard against similar problems in the future, do
> runtime detection of supported "testing flags", and only provide those
> that host kernel recognizes.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../bpf/prog_tests/bpf_verif_scale.c          |  2 +-
>  .../selftests/bpf/prog_tests/reg_bounds.c     |  2 +-
>  tools/testing/selftests/bpf/test_loader.c     |  2 +-
>  tools/testing/selftests/bpf/test_sock_addr.c  |  3 +-
>  tools/testing/selftests/bpf/test_verifier.c   |  2 +-
>  tools/testing/selftests/bpf/testing_helpers.c | 32 +++++++++++++++++--
>  tools/testing/selftests/bpf/testing_helpers.h |  2 ++
>  7 files changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> index e770912fc1d2..4c6ada5b270b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
> @@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_type type)
>  	}
>  
>  	bpf_program__set_type(prog, type);
> -	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS);
> +	bpf_program__set_flags(prog, testing_prog_flags());
>  	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
>  
>  	err = bpf_object__load(obj);
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> index 820d0bcfc474..eb74363f9f70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -840,7 +840,7 @@ static int load_range_cmp_prog(struct range x, struct range y, enum op op,
>  		.log_level = 2,
>  		.log_buf = log_buf,
>  		.log_size = log_sz,
> -		.prog_flags = BPF_F_TEST_REG_INVARIANTS,
> +		.prog_flags = testing_prog_flags(),
>  	);
>  
>  	/* ; skip exit block below
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 74ceb7877ae2..941778ac2691 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -181,7 +181,7 @@ static int parse_test_spec(struct test_loader *tester,
>  	memset(spec, 0, sizeof(*spec));
>  
>  	spec->prog_name = bpf_program__name(prog);
> -	spec->prog_flags = BPF_F_TEST_REG_INVARIANTS; /* by default be strict */
> +	spec->prog_flags = testing_prog_flags();
>  
>  	btf = bpf_object__btf(obj);
>  	if (!btf) {
> diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
> index b0068a9d2cfe..80c42583f597 100644
> --- a/tools/testing/selftests/bpf/test_sock_addr.c
> +++ b/tools/testing/selftests/bpf/test_sock_addr.c
> @@ -19,6 +19,7 @@
>  #include <bpf/libbpf.h>
>  
>  #include "cgroup_helpers.h"
> +#include "testing_helpers.h"
>  #include "bpf_util.h"
>  
>  #ifndef ENOTSUPP
> @@ -679,7 +680,7 @@ static int load_path(const struct sock_addr_test *test, const char *path)
>  
>  	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
>  	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
> -	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS);
> +	bpf_program__set_flags(prog, testing_prog_flags());
>  
>  	err = bpf_object__load(obj);
>  	if (err) {
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index f36e41435be7..50fdc1100a4b 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1588,7 +1588,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  	if (fixup_skips != skips)
>  		return;
>  
> -	pflags = BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS;
> +	pflags = testing_prog_flags();
>  	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
>  		pflags |= BPF_F_STRICT_ALIGNMENT;
>  	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index d2458c1b1671..e1f797c5c501 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -251,6 +251,34 @@ __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
>  }
>  
>  int extra_prog_load_log_flags = 0;
> +static int prog_test_flags = -1;
> +
> +int testing_prog_flags(void)
> +{
> +	static int prog_flags[] = { BPF_F_TEST_RND_HI32, BPF_F_TEST_REG_INVARIANTS };
> +	static struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int insn_cnt = ARRAY_SIZE(insns), i, fd, flags = 0;
> +	LIBBPF_OPTS(bpf_prog_load_opts, opts);
> +
> +	if (prog_test_flags >= 0)
> +		return prog_test_flags;
> +
> +	for (i = 0; i < ARRAY_SIZE(prog_flags); i++) {
> +		opts.prog_flags = prog_flags[i];
> +		fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "flag-test", "GPL",
> +				   insns, insn_cnt, &opts);
> +		if (fd >= 0) {
> +			flags |= prog_flags[i];
> +			close(fd);
> +		}
> +	}
> +
> +	prog_test_flags = flags;
> +	return prog_test_flags;
> +}
>  
>  int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
>  		       struct bpf_object **pobj, int *prog_fd)
> @@ -276,7 +304,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
>  	if (type != BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) != type)
>  		bpf_program__set_type(prog, type);
>  
> -	flags = bpf_program__flags(prog) | BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS;
> +	flags = bpf_program__flags(prog) | testing_prog_flags();
>  	bpf_program__set_flags(prog, flags);
>  
>  	err = bpf_object__load(obj);
> @@ -299,7 +327,7 @@ int bpf_test_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
>  {
>  	LIBBPF_OPTS(bpf_prog_load_opts, opts,
>  		.kern_version = kern_version,
> -		.prog_flags = BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS,
> +		.prog_flags = testing_prog_flags(),
>  		.log_level = extra_prog_load_log_flags,
>  		.log_buf = log_buf,
>  		.log_size = log_buf_sz,
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index 35284faff4f2..1caa16f5096c 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -46,4 +46,6 @@ static inline __u64 get_time_ns(void)
>  	return (u64)t.tv_sec * 1000000000 + t.tv_nsec;
>  }
>  
> +int testing_prog_flags(void);
> +
>  #endif /* __TESTING_HELPERS_H */
> -- 
> 2.34.1
> 
> 

