Return-Path: <bpf+bounces-15550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC37F33A6
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47AF283051
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097B5A10A;
	Tue, 21 Nov 2023 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WOn0mLit"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A5C194
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b27726369so7942215e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583994; x=1701188794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+9f2k6NdkYSusRGnlB4WoyiQr0XSRCBiIbKEEB2kbhU=;
        b=WOn0mLitdaPTB2EMemqQzchKF332bFIRq5V+4x8Ku8gyAMT2yxw2GVU3i7KVI0Awwz
         F8XhPBaCGNqVDWB/8IaBA6DLYnTGVsOS7b021w21OjX0dmzCMkLFY1n4wz95eu8lO7j5
         5CgwIQvyU0YEHNEnvOk+uVc7StXXYeI94lWSzTMnUD4QnzcKKOCmguOdyZ4EVi6AYg3I
         24/E7pe2uJHFdWF33J0YS1npUxkuEjhZF2H2hRL03yLN7HorQmWnbNbYYitnE8ptujqv
         2g0GNc7Vah0B91yoSalSw85pG1BHOVtjD2WN2RfX6kvzeibZjB7NGvnkOYqsBMrz7nIx
         sqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583994; x=1701188794;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9f2k6NdkYSusRGnlB4WoyiQr0XSRCBiIbKEEB2kbhU=;
        b=C85k6noaiSpsRZ2h6C2g+RT/oNkDSA0zIrTSGUym59pHT4laoOSEfhPhSGf1m5SCTX
         EDZmxuY7/ZP31XuC2D0TF1neNsaIQgYckOFHR+KNbY5+n5Etth7gWPtLdi/IMutY9xna
         tmDUp9zZmGrQPKpPaF3dVtWucFPXgDujfUzIxHYHHZmqrzgaz+wJRlVndCHW7lgdmcdz
         EJ1pG5fpM0IvNe75RW/1FQGNSLCqFstpRdIdDgmcGiJx1WJhN+riN8oxHP3WN9pqDXR0
         ffOBI9kDSK/7wHSChfHi5sz99cmk2sTpK9oS90CpbBBBS4DHJMITasWkrTO01uAmE3Tw
         25/g==
X-Gm-Message-State: AOJu0YwwuQ2XRzLTLTafH5e6osKYUPTwnjm0UezLX5s2UTPY+VDK+rVm
	JOQslRZstJCu6XnsuxPiuIVCEQ==
X-Google-Smtp-Source: AGHT+IHIJQCkWpbi67v25e8i0Pz6UGMIfOUebZ4sVd6f5Lf5mbLApxGObzNpfHg/DcqcS9DjfmbOvQ==
X-Received: by 2002:a05:600c:4f14:b0:406:f833:d853 with SMTP id l20-20020a05600c4f1400b00406f833d853mr7348695wmq.15.1700583994275;
        Tue, 21 Nov 2023 08:26:34 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:34 -0800 (PST)
Message-ID: <d4fe1449-91d2-4a16-aade-3bf698c201f3@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 8/9] bpftool: Add bpftool_tests README.md
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-9-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231116194236.1345035-9-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> A README.md explaining how to run bpftool tests.
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  .../selftests/bpf/bpftool_tests/README.md     | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/bpftool_tests/README.md
> 
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/README.md b/tools/testing/selftests/bpf/bpftool_tests/README.md
> new file mode 100644
> index 000000000000..8ee5d656f6f8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpftool_tests/README.md
> @@ -0,0 +1,91 @@
> +## About the testing Framework
> +
> +The testing framework uses [RUST's testing framework](https://doc.rust-lang.org/rustc/tests/index.html)
> +and [libbpf-rs](https://docs.rs/libbpf-rs/latest/libbpf_rs/).
> +
> +The former takes care of scheduling tests and reporting their successes/failures.
> +The latter is used to load bpf programs, maps, and possibly interact with them

nit: s/bpf/BPF/

> +programatically through libbpf API.

Typo (programmatically)

> +This allows us to set the environment we want to test and check that `bpftool`
> +does what we expect.
> +
> +This document assumes you have [`cargo` and `rust` installed](https://doc.rust-lang.org/cargo/getting-started/installation.html).
> +
> +## Testing bpftool
> +
> +This should be no different than typical [`cargo test`](https://doc.rust-lang.org/cargo/commands/cargo-test.html)
> +but there is a few subtleties to consider when running `bpftool` tests:

"there are"

> +
> +1. bpftool needs to run with root privileges for the most part. So the runner needs to run as root.
> +1. each tests load a program, possibly modify it, and check expectations. In order to be deterministic, tests need to run serially.

2. Each test loads..., modifies, checks

> +
> +### Environment variable
> +
> +A few environment variable can be used to control the behaviour of the tests:

s/variable/variables/
(s/behaviour/behavior/? Not sure of the guidance on US/British English
in docs.)

> +- `RUST_TEST_THREADS`: This should be set to 1 to run one test at a time and avoid tests to step onto each others.

"each other"

> +- `BPFTOOL_PATH`: Allow passing an alternate location for `bpftool`. Default: `/usr/sbin/bpftool`
> +
> +### Running the test suite
> +
> +Here are a few options to make this happen:
> +
> +```
> +# build the test binary, extract the test executable location
> +# and run it with sudo, 1 test at a time.
> +eval sudo BPFTOOL_PATH=$(pwd)/../bpftool RUST_TEST_THREADS=1 \
> +    $(cargo test --no-run \
> +        --message-format=json | jq '. | select(.executable != null ).executable' \
> +    )
> +```
> +
> +or alternatively, one can use the [`CARGO_TARGET_<triple>_RUNNER` environment variable](https://doc.rust-lang.org/cargo/reference/environment-variables.html#:~:text=CARGO_TARGET_%3Ctriple%3E_RUNNER).
> +
> +The benefit of that approach is that compilation errors will show directly in the terminal.
> +
> +```
> +CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" \
> +    BPFTOOL_PATH=$(pwd)/../bpftool \
> +    RUST_TEST_THREADS=1 \
> +    cargo test
> +```
> +
> +### Running tests against built kernel/bpftool
> +
> +Using [vmtest](https://github.com/danobi/vmtest):
> +
> +```
> +$ KERNEL_REPO=~/devel/bpf-next/
> +$ vmtest -k $KERNEL_REPO/arch/x86_64/boot/bzImage "BPFTOOL_PATH=$KERNEL_REPO/tools/bpf/bpftool/bpftool RUST_TEST_THREADS=1 cargo test"
> +=> bzImage
> +===> Booting
> +===> Setting up VM
> +===> Running command
> +    Finished test [unoptimized + debuginfo] target(s) in 2.06s
> +     Running unittests src/main.rs (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
> +
> +running 11 tests
> +test bpftool_tests::run_bpftool ... ok
> +test bpftool_tests::run_bpftool_map_dump_id ... ok
> +test bpftool_tests::run_bpftool_map_list ... ok
> +test bpftool_tests::run_bpftool_map_pids ... ok
> +test bpftool_tests::run_bpftool_prog_list ... ok
> +test bpftool_tests::run_bpftool_prog_pids ... ok
> +test bpftool_tests::run_bpftool_prog_show_id ... ok
> +test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... ok
> +test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ... ok
> +test bpftool_tests::run_bpftool_struct_ops_dump_name ... ok
> +test bpftool_tests::run_bpftool_struct_ops_list ... ok
> +
> +test result: ok. 11 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out; finished in 1.88s
> +```
> +
> +the return code will be 0 on success, non-zero otherwise.
> +
> +
> +## Caveat
> +
> +Currently, libbpf-sys crate either uses a vendored libbpf, or the system one.
> +This could possibly limit tests against features that are being introduced.
> +
> +That being said, this is not a blocker now, and can be fixed upstream.
> +https://github.com/libbpf/libbpf-sys/issues/70 tracks this on libbpf-sys side.

Kernel docs usually use rST rather than Markdown for formatting.
Although there's rust/alloc/README.md, so I'm not entirely sure what's
best here. Unless there's a good reason for Markdown, we probably want
to stick to rST? This also depends on whether or not this patchset makes
it into the kernel repo, obviously.

Quentin

