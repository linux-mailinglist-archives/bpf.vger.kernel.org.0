Return-Path: <bpf+bounces-15552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A590C7F33A8
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFD3283058
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6CE5A10C;
	Tue, 21 Nov 2023 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="VA8nEGH9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5CE191
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332ce3fa438so484139f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700584006; x=1701188806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxKT//Kr/jPYhL4EV8Oyn7wgtVh/Gt9brQ45hWxM0U=;
        b=VA8nEGH9t4SoA5bSk+IXQFKFOP/j2TFC9Ye415vzHHOfd8q4Y0Dlq25J3XIYO9wAv2
         JtuF0gig/d2t0iNfU0BsqT5pbCH+ryy4N2ryxJBOGeeOkq9jfiuMBXX7WqKb8ejgfc3M
         j+TGunHxG0yQjdjo3hOtcEt57AFiRV0GUpxYr3PpBMZMj0qjGkLcU4JIcQeSjyQWYaW9
         2Tiop9pI4NolDbrsNAJ2Cw9877m6f1b1NGCvbQbA7Al8H1ZLB7EbXpuIBNLcGJTcdNV1
         7GWhAzg1PkyyW+8t8hrS+Yf6SQF0OOAer5XlXph9+uGnBMKBlXZD1foIIj8y/MNwKUNz
         JAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700584006; x=1701188806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxKT//Kr/jPYhL4EV8Oyn7wgtVh/Gt9brQ45hWxM0U=;
        b=jtu+/UG+fwpe386wazo62q6JAQqPmAyTkX775tEZOEvN3ZYwsBcRcEgRLQzQvUiimT
         6vnhqNUfuup59QhUmWxlf0eC4XFIQ2xXJycDlTL4msnhokjadH7s9lEZHWoiVs9/qk46
         0M5Ha1noBQaRCip6GzXMRlBDjlkk1xpd9A58uMDkgtuLM8ISbL7q+oOyJ0Z7FE72A1Ij
         w2Lc9dK9Oc4ndqDDb5cNdSl5LzpQc26X6eSXBwGZRrW3M6KT4xpZDUZ75JTjp4UyWDOF
         z1BxyBdI0v6LIrBUS0GqUftBSu29sHOjKtjQuJ4cw0PKVvTYA9n9L4OjWBJCldKa7OTD
         MLWg==
X-Gm-Message-State: AOJu0YyfTT/L+JQldXUZ/AGXDzjxPznprXZwBsKpi2VeXSN6+1GAY0bg
	osP4aObwGD8EXiqGhFEnfcKf4Q==
X-Google-Smtp-Source: AGHT+IFAOMXPhQuOuubIw+w9xipTeZgUnnPJMjAjkqkCZs2QSIjIG3TJQClH0ufkkMq06X7r/WIZaA==
X-Received: by 2002:adf:f384:0:b0:32d:d2aa:ed21 with SMTP id m4-20020adff384000000b0032dd2aaed21mr2152405wro.28.1700584006273;
        Tue, 21 Nov 2023 08:26:46 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:46 -0800 (PST)
Message-ID: <a9ac8c82-7b97-4001-a839-215eb4cc292f@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 1/9] bpftool: add testing skeleton
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Manu Bretelle <chantr4@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-2-chantr4@gmail.com>
 <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAADnVQ+Mb-eQUxp-0c_C_nVme0Sqy7CST_vaCiawefjTb5spiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2023-11-21 01:38 UTC+0000 ~ Alexei Starovoitov
<alexei.starovoitov@gmail.com>
> On Thu, Nov 16, 2023 at 11:43 AM Manu Bretelle <chantr4@gmail.com> wrote:
>>
>> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +use std::process::Command;
>> +
>> +const BPFTOOL_PATH_ENV: &str = "BPFTOOL_PATH";
>> +const BPFTOOL_PATH: &str = "/usr/sbin/bpftool";
>> +
>> +/// Run a bpftool command and returns the output
>> +fn run_bpftool_command(args: &[&str]) -> std::process::Output {
>> +    let mut cmd = Command::new(std::env::var(BPFTOOL_PATH_ENV).unwrap_or(BPFTOOL_PATH.to_string()));
>> +    cmd.args(args);
>> +    println!("Running command {:?}", cmd);
>> +    cmd.output().expect("failed to execute process")
>> +}
>> +
>> +/// Simple test to make sure we can run bpftool
>> +#[test]
>> +fn run_bpftool() {
>> +    let output = run_bpftool_command(&["version"]);
>> +    assert!(output.status.success());
>> +}
>> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/main.rs b/tools/testing/selftests/bpf/bpftool_tests/src/main.rs
>> new file mode 100644
>> index 000000000000..6b4ffcde7406
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/main.rs
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> +#[cfg(test)]
>> +mod bpftool_tests;
> 
> There is rust in the kernel tree already.
> Most of it is #![no_std] and the rest depend on
> rust_is_available.sh and the kernel build system.
> This rust usage doesn't fit into two existing rust categories afaics.

I haven't followed closely the introduction of Rust in the kernel
repository, so apologies if I'm incorrect. From what I understand,
#![no_std] is to avoid linking against the std-crate, which is necessary
for Rust code that needs to be compiled as part of the kernel or
modules, but is maybe not relevant for something external like a test
suite? As for rust_is_available.sh, we would need a way to determine
whether Rust is available indeed, before plugging these tests into the
Makefile for the BPF selftests.

As far as I'm aware, these would be the first selftests written in Rust
in the repo (other than for the code under rust/). I'm fine having tests
in Rust for bpftool, for what it matters. Whether we want selftests in
Rust in the kernel repo is another thing.

> 
> Does it have to leave in the kernel tree?
> We have bpftool on github, maybe it can be there?
> Do you want to run bpftool tester as part of BPF CI and that's why
> you want it to be in the kernel tree?

It doesn't _have_ to be in the kernel tree, although it's a nice place
where to have it. We have bpftool on GitHub, but the CI that runs there
is triggered only when syncing the mirror to check that mirroring is not
broken, so after new patches are applied to bpf-next. If we want this on
GitHub, we would rather target the BPF CI infra.

A nice point of having it in the repo would be the ability to add tests
at the same time as we add features in bpftool, of course.

Quentin

