Return-Path: <bpf+bounces-15548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FDA7F33A4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8595EB21F88
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595945A109;
	Tue, 21 Nov 2023 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="bmjQagwq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A043191
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332ce50450dso509180f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583980; x=1701188780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/huruBJxNsM6C/xpMDSvAlubEE94dF3x6Nqx18x9BFQ=;
        b=bmjQagwq5k/bOaOxwsD+pKK5+vju0XVpdRA8sq3LCauSNcUx2eKnrHws4/gbkVp6cp
         RX51bMHIRaTnUYX/LZ+ogObVJfGYm88eCicCRKp//QS+pbKsoT3B5WyEF4sslrfdSclo
         GeqPH/TUwO2Gy5bq3r1FGI41dbta/cZddOZHYoPdtmKjI+/iZBUAIcXnByhVejQUR3Xn
         ihZFpkAvFL1VXavMYTVqWeRgBKhlfusqpaaiUvgBp1RMUKZBY4Z4RpaNqoIGB+oC9ZBS
         Uu8eG7Fe5FC6H9bwnRwJf7DKM+DUckukMFvOswN8HEgwM+N7vytcTU9VayjhMcHL7wA7
         YxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583980; x=1701188780;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/huruBJxNsM6C/xpMDSvAlubEE94dF3x6Nqx18x9BFQ=;
        b=CNKt4elgYVqHzLf1Ih9ngwjd++/CF2S/APPOjsIl1hcQr629GWZW48gyjLDcCWtaW6
         M1iNUjQ6vzk62N72Kg5X5P2uxGyTnyjyrQqSKhM1jakC+ocUUj+UBHOQ0OfPrEpMPTbX
         2s+NULKq5bz38+AvLGhFYCLQ+Bzs7BzV5Pl9gEeTRu4X7N5kUVXUm+2Q7l5xmRaGdoHX
         Q56iPyBIiVXcbm8Hh4RJ99X+ubwfF/jbIwUsl2UIJyQ44irxHyB2BN01EKw8h7DWGI3X
         fBgDuRFf2sitSrnGq1qQM6tEvZqAs+Y1BSxPxufOmtAAv8WM+rehMqj5v+duXEOpBhfs
         H/xA==
X-Gm-Message-State: AOJu0YzEPp9c1dLJsY6suNI7vY6/tGoEq45FU019FM2nB+jOEkqlneyA
	5l5xMbEwnVXHJMVQkSCNgGfO+w==
X-Google-Smtp-Source: AGHT+IE8aFzoME8pp2At3oQMkiKra9+w1rbKfc+H8aPZ/qMak1Bz3lytzZcnOb9JPuE/TLURc/kgCQ==
X-Received: by 2002:a5d:540a:0:b0:32f:7f2c:de2e with SMTP id g10-20020a5d540a000000b0032f7f2cde2emr6922437wrv.36.1700583979594;
        Tue, 21 Nov 2023 08:26:19 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:19 -0800 (PST)
Message-ID: <bb04f066-0db0-418a-a4f8-7ba739115072@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:17 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 5/9] bpftool: add test for bpftool prog
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-6-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231116194236.1345035-6-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> Add tests that validate `bpftool prog list` functions, that we can
> associate pids with them, and that we can show a prog by id.
> 
>     $ BPFTOOL_PATH=../bpftool
>     CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
>     --nocapture
>         Finished test [unoptimized + debuginfo] target(s) in 0.05s
>          Running unittests src/main.rs
>     (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
> 
>     running 6 tests
>     Running command "../bpftool" "version"
>     test bpftool_tests::run_bpftool ... ok
>     Running command "../bpftool" "map" "list" "--json"
>     Running command "../bpftool" "prog" "list" "--json"
>     Running command "../bpftool" "prog" "list" "--json"
>     Running command "../bpftool" "map" "list" "--json"
>     Running command "../bpftool" "prog" "show" "id" "3160417" "--json"
>     test bpftool_tests::run_bpftool_prog_show_id ... ok
>     test bpftool_tests::run_bpftool_map_pids ... ok
>     test bpftool_tests::run_bpftool_map_list ... ok
>     test bpftool_tests::run_bpftool_prog_pids ... ok
>     test bpftool_tests::run_bpftool_prog_list ... ok
> 
>     test result: ok. 6 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
>     out; finished in 0.20s
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  2 +-
>  .../bpf/bpftool_tests/src/bpftool_tests.rs    | 79 ++++++++++++++++++-
>  2 files changed, 79 insertions(+), 2 deletions(-)
> 

> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> index a832b255e988..695a1cbc5be8 100644
> --- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs

> @@ -101,3 +113,68 @@ fn run_bpftool_map_pids() {
>          map.pids
>      );
>  }
> +
> +/// A test to validate that we can list programs using bpftool
> +#[test]
> +fn run_bpftool_prog_list() {
> +    let _skel = setup().expect("Failed to set up BPF program");
> +    let output = run_bpftool_command(&["prog", "list", "--json"]);
> +
> +    let progs = serde_json::from_slice::<Vec<Prog>>(&output.stdout).expect("Failed to parse JSON");
> +
> +    assert!(output.status.success());
> +    assert!(!progs.is_empty(), "No programs were listed");
> +}
> +
> +/// A test to validate that we can find PIDs associated with a program
> +#[test]
> +fn run_bpftool_prog_pids() {
> +    let hook_name = "handle_tp_sys_enter_write";
> +
> +    let _skel = setup().expect("Failed to set up BPF program");
> +    let output = run_bpftool_command(&["prog", "list", "--json"]);
> +
> +    let progs = serde_json::from_slice::<Vec<Prog>>(&output.stdout).expect("Failed to parse JSON");
> +    assert!(output.status.success(), "bpftool returned an error.");
> +
> +    // `handle_tp_sys_enter_write` is a hook our bpftool_tests.bpf.c attaches
> +    // to (tp/syscalls/sys_enter_write).
> +    // It should have at least one entry for our current process.
> +    let prog = progs
> +        .iter()
> +        .find(|m| m.name.is_some() && m.name.as_ref().unwrap() == hook_name)
> +        .unwrap_or_else(|| panic!("Did not find {} prog", hook_name));
> +
> +    let mypid = std::process::id() as u64;
> +    assert!(
> +        prog.pids.iter().any(|p| p.pid == mypid),
> +        "Did not find test runner pid ({}) in pids list associated with prog *{}*: {:?}",
> +        mypid,
> +        hook_name,
> +        prog.pids
> +    );
> +}
> +
> +/// A test to validate that we can run `bpftool prog show <id>`
> +/// an extract the expected information.

s/an/and/

> +#[test]
> +fn run_bpftool_prog_show_id() {
> +    let skel = setup().expect("Failed to set up BPF program");
> +    let binding = skel.progs();
> +    let handle_tp_sys_enter_write = binding.handle_tp_sys_enter_write();
> +    let prog_id =
> +        Program::get_id_by_fd(handle_tp_sys_enter_write.as_fd()).expect("Failed to get prog ID");
> +
> +    let output = run_bpftool_command(&["prog", "show", "id", &prog_id.to_string(), "--json"]);
> +    assert!(output.status.success(), "bpftool returned an error.");
> +
> +    let prog = serde_json::from_slice::<Prog>(&output.stdout).expect("Failed to parse JSON");
> +
> +    assert_eq!(prog_id, prog.id);
> +    assert_eq!(
> +        handle_tp_sys_enter_write.name(),
> +        prog.name
> +            .expect("Program handle_tp_sys_enter_write has no name")
> +    );
> +    assert_eq!("tracepoint", prog.r#type);
> +}


