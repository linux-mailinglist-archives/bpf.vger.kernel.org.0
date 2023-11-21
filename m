Return-Path: <bpf+bounces-15546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C917F33A0
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31B31C21B27
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90E5A105;
	Tue, 21 Nov 2023 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Vr+dE0oR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B7112
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2a8575d9so5463495e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583963; x=1701188763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56vyF3C2D8KZj8qyp7mlahKx0Xg6koBjUhvUzDjpAfw=;
        b=Vr+dE0oRBWDubEkm3xdN5W1gj8uIcvuP8THIAyYUFbUy+hxzEaQsz447HXFmJdrbsL
         eazHDvmQzNkJkQBBPvcKgNO9YQm79J1o6OiusunsSq6ASe9kytnlhm0GkdIbv96XTQln
         1VhnEtNBlIiMbgWZJmUlKrPgzqWY9jJxAeTLvqnAbaaMoHenCSdkFZauc7xsgV8+CxoV
         izp3TyU8O0PpV4tTmBgslm/eNN6T0XnjmSUS7nikeerRbyKl5olIQp/7VAMoBbL3NLn+
         F2pLd6CUa/3GkgZMtJaz/qzD/JAlcv5M8QjUeNW62cQLxwPPkCWanlbR8iXbiKlskvBS
         Jlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583963; x=1701188763;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56vyF3C2D8KZj8qyp7mlahKx0Xg6koBjUhvUzDjpAfw=;
        b=jp0WvEDiZLLdPXwNw6885wYQ+tl36svisJunalGf2RuaTLp6jPF0W3oM6m67nUKeDt
         oiZYFr73M13qG7DmcQY/3+vsoH5X7kgJ/lHUnnADLgUxfh8xl6vBTTEiDD/SeMI3h2ca
         W/03DCZAbR9ese3oiGrBe2eMzYZ9NcNz6e5z6LhBG3dbqbAP9hnISaW8PpdVXPEowVtV
         lhyoTI6iS1RQrT1a2QjUM4RCLOQp0sMksOSJeWq2tNCZCM+hElpbQdOEfm+zrLkADLnf
         iop+T2+8NDoteYRCXXh/Y2skI2IVFa9gxdq84ZmK4ci7dQk6XTAEH+0+dzX8daCkC8v2
         AboQ==
X-Gm-Message-State: AOJu0Yyc0yg/GdogVMCyl8xJV05RMHTK/0yGYGAJBbQFDVjhvkSlAtLK
	syyMo+cvvnPsDN54SG0ZfxFLmg==
X-Google-Smtp-Source: AGHT+IF9wAbQsoOlg7b2PSd9e+FySZ1GiCUxR5nnj8+oZ5cmHq4YZ09TaOea+nQan7HOOLlXIUNZLA==
X-Received: by 2002:a05:600c:a03:b0:402:d72:bee5 with SMTP id z3-20020a05600c0a0300b004020d72bee5mr8263648wmp.21.1700583963410;
        Tue, 21 Nov 2023 08:26:03 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:03 -0800 (PST)
Message-ID: <c8d723d2-9947-473e-a803-48f3f93564f7@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-2-chantr4@gmail.com>
Content-Language: en-GB
In-Reply-To: <20231116194236.1345035-2-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> Add minimal cargo project to test bpftool.
> An environment variable `BPFTOOL_PATH` can be used to provide the path
> to bpftool, defaulting to /usr/sbin/bpftool
> 
>     $ cargo check --tests
>         Finished dev [unoptimized + debuginfo] target(s) in 0.00s
>     $ cargo clippy --tests
>         Finished dev [unoptimized + debuginfo] target(s) in 0.05s
>     $ BPFTOOL_PATH='../bpftool' cargo test -- --nocapture
>         Finished test [unoptimized + debuginfo] target(s) in 0.05s
>          Running unittests src/main.rs
>     (target/debug/deps/bpftool_tests-172b867215e9364e)
> 
>     running 1 test
>     Running command "../bpftool" "version"
>     test bpftool_tests::run_bpftool ... ok
> 
>     test result: ok. 1 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
>     out; finished in 0.00s
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  .../selftests/bpf/bpftool_tests/.gitignore    |  3 +++
>  .../selftests/bpf/bpftool_tests/Cargo.toml    |  4 ++++
>  .../bpf/bpftool_tests/src/bpftool_tests.rs    | 20 +++++++++++++++++++
>  .../selftests/bpf/bpftool_tests/src/main.rs   |  3 +++
>  4 files changed, 30 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/.gitignore
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/main.rs
> 
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/.gitignore b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
> new file mode 100644
> index 000000000000..cf8177c6aabd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/.gitignore
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/target/**
> +/Cargo.lock
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
> new file mode 100644
> index 000000000000..34df3002003f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
> @@ -0,0 +1,4 @@
> +[package]
> +name = "bpftool_tests"
> +version = "0.1.0"
> +edition = "2021"
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> new file mode 100644
> index 000000000000..251dbf3861fe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause

Any particular reason for this particular choice of license? If not,
could you please reconsider? All sources for bpftool use (GPL-2.0-only
OR BSD-2-Clause), as you use in the .gitignore above, so it would make
sense to have the related tests with the same licenses. It would
certainly make things easier if someone need to ship the tests along
with the sources in the future.

(Same comment for the other Rust files you add in this commit and the next.)

> +use std::process::Command;
> +
> +const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
> +const BPFTOOL_PATH: &str = "/usr/sbin/bpftool";

This is a decent choice given that it's where the binary will likely end
up for most distributions, but I'd maybe use "/usr/local/sbin/bpftool"
instead to remain consistent with the prefix in bpftool's Makefile, and
default to where we install bpftool when we "make install" it.

