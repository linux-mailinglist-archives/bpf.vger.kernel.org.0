Return-Path: <bpf+bounces-15551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA97F33A7
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F58B22021
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B615A106;
	Tue, 21 Nov 2023 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gpK4MoVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105CD1
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332ce50450dso509420f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583999; x=1701188799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nlfhhDSEyzCaruzgzzrkJ3jQOCEBZNObRZvF0tsfrQ=;
        b=gpK4MoVNFyBug2QefFN4vBT9BxpIprRnsdHIRAXssdEiiUqWfVRFbruUWawhB6dEZj
         WVsZzk9ioLUGKNfAYDgQTcSGXzfyePzKZCe6if6zHJcEQhrpziQqR4KXCwd4GYA9h3Ii
         uc3AkWCjp7LslS5aHN66VLJLz+H9xRWoaL1K8SVAjXjD1GC141/Ms1G1jj5MIIvMHNCL
         jmHYEZOXC/p7FgGTLFVbQRlbnkGYcvON6XjvNSHvmT677eDXtpjVgZ3BqaNZMW29BToR
         Kii6iV9DmDZi/+2AvciDiabAFTzkn5gqrqJ6hcIo57daEEU16/n02pRdMO0Cz2boXFwq
         dpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583999; x=1701188799;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nlfhhDSEyzCaruzgzzrkJ3jQOCEBZNObRZvF0tsfrQ=;
        b=PUahBEhVgPnBP2PbXuFOpwMIlaMvnRsBla32AyUJsmP9OPPV1DCbB4T5fhKnh90/Kr
         6dPoniTX/P8PhgsnmmkunN3Nwzso56ExhKtIZs+6ZTIIVqkEnrtrCm8rmQndu5qzl8qG
         djHiQf6Rbk3DROV+OXNXSsT+G0HpqqXZpN/Vf5wR3EYDCUhuzEwyZsPm579DXalyuQCx
         eTYaz+pZl1iBvzwFCPZCqQF6UoZY9AYRN1IOJHmuiRDP7YMo3b6WBqvu5k7YMEM8auMN
         sUbxvZCeryfExHFn7iJlObIzL1iCcMCFAlFzef/t+M34oP8iErneRLIYadz3zHPzE5Ym
         hxxg==
X-Gm-Message-State: AOJu0YwURXlS3RG+yWb1ilVgElctV+PDjECJClkgrM3qszbedXkcP+F+
	JFHde/dGePSHsHwi8G0Cqsis8Q==
X-Google-Smtp-Source: AGHT+IEEcU1mM6HkLv1lwXC5qWVVQ7KqsvvscqM4OGc0RjIirmAiKdWD79KVoJiEva/LtTNFdXN1Cw==
X-Received: by 2002:a5d:5f92:0:b0:331:72f3:d59f with SMTP id dr18-20020a5d5f92000000b0033172f3d59fmr9533215wrb.27.1700583999470;
        Tue, 21 Nov 2023 08:26:39 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:39 -0800 (PST)
Message-ID: <49c84828-a430-4547-b07e-9c88ddf33c38@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:38 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 9/9] bpftool: Add Makefile to facilitate
 bpftool_tests usage
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-10-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231116194236.1345035-10-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> Provide some Makefile targets to run the linter, build the tests, and
> run them on the host or in a VM.
> 
>     $ make vmtest
>     cargo test --no-run --offline
>         Finished test [unoptimized + debuginfo] target(s) in 0.05s
>       Executable unittests src/main.rs
>     (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
>     vmtest -k /data/users/chantra/bpf-next/arch/x86/boot/bzImage
>     "RUST_TEST_THREADS=1 BPFTOOL_PATH=../tools/build/bpftool/bpftool cargo
>     test"
>     => bzImage
>     ===> Booting
>     ===> Setting up VM
>     ===> Running command
>         Finished test [unoptimized + debuginfo] target(s) in 2.05s
>          Running unittests src/main.rs
>     (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
> 
>     running 11 tests
>     test bpftool_tests::run_bpftool ... ok
>     test bpftool_tests::run_bpftool_map_dump_id ... ok
>     test bpftool_tests::run_bpftool_map_list ... ok
>     test bpftool_tests::run_bpftool_map_pids ... ok
>     test bpftool_tests::run_bpftool_prog_list ... ok
>     test bpftool_tests::run_bpftool_prog_pids ... ok
>     test bpftool_tests::run_bpftool_prog_show_id ... ok
>     test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... ok
>     test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ... ok
>     test bpftool_tests::run_bpftool_struct_ops_dump_name ... ok
>     test bpftool_tests::run_bpftool_struct_ops_list ... ok
> 
>     test result: ok. 11 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
>     out; finished in 2.88s
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  .../selftests/bpf/bpftool_tests/Makefile      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Makefile
> 
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/Makefile b/tools/testing/selftests/bpf/bpftool_tests/Makefile
> new file mode 100644
> index 000000000000..0b5633cda8b4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/Makefile
> @@ -0,0 +1,22 @@

I'd recommend adding a SPDX tag. I don't know how relevant this is for a
Makefile, but this would prevent to fall it under the default GPL-only
license, and keep it consistent with the rest of the test framework
you're introducing.

> +BPFTOOL := ../tools/build/bpftool/bpftool
> +
> +lint:
> +	cargo clippy --tests
> +	cargo check --tests
> +
> +# Build the tests but do not run them.
> +build-test:
> +	cargo test --no-run --offline
> +
> +# Run the tests on the host using sudo
> +test: build-test
> +	RUST_TEST_THREADS=1 BPFTOOL_PATH=$(BPFTOOL) sudo -E $(shell which cargo) test --offline
> +
> +# Run the tests in a vm. Requires danobi/vmtest.

Please provide the full URL to the repository. I'd also add a comment to
make it explicit that this is distinct from the vmtest.sh from the
selftests.

> +vmtest: build-test
> +	$(eval repo_root := $(shell git rev-parse --show-toplevel))
> +	$(eval kernel_img := $(shell make -s -C $(repo_root) image_name))
> +	vmtest -k $(repo_root)/$(kernel_img) "RUST_TEST_THREADS=1 BPFTOOL_PATH=$(BPFTOOL) cargo test"
> +
> +clean:
> +	cargo clean


