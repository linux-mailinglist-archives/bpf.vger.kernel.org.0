Return-Path: <bpf+bounces-15549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132117F33A5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6549A283056
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908FE5A109;
	Tue, 21 Nov 2023 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="K9ao8+fl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9C112
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so1337300f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 08:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1700583987; x=1701188787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AwAhw8YCY0I4k2XHNynYRb3MdRl9G61iiE74YN3Dfw=;
        b=K9ao8+fl+cofK/PzspYWnn1yCEffkFEuOUEsgZgc9L8OHNlGB3tc1Gkex8AtNRXQD6
         16tTO+RszfkbRiZIr2x3uNf9oyQR9bxWj7dxcOq2nNpbA/1Q56m2yV7/5hTwSNa1emE6
         hL4uVue1WS/2GyHn9hbbPUz1Oj4pvP8wb9RbOtPKBNEKHnG7QYJ/z+ISiPx61Mg/HY/H
         ybw3zycEZ4u84RvpehKsuTP0SwqKOwXSMZNpQtrE0KRzn9qVmrSmqMoxX4GLCoJ0n0dK
         /APlD5t0rh26bBVE7sQkjZAgCqhZvSTKGEzRnzGRDndtt9BJSBFrhnvYDz6AbXVghK/t
         wOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700583987; x=1701188787;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AwAhw8YCY0I4k2XHNynYRb3MdRl9G61iiE74YN3Dfw=;
        b=i04+1uVDeof6X7mJmHwYOFxBWXhNgdlXfkCotCayhiOMCWSJsIsBudQBDlJpKfUF5W
         eyN7MAUHrF1QSbB+1Cswxmr+gptkvXEf50SXrJATQOOEFzvywuPiyr7BLKrwQ7W7KUX1
         LnLYfRvshSRl2tsOb72OoFJ11wDIy529PNff2PahMdR3ycUZ687fJv0nco+ZBIuCuNF7
         gXSo25nJWC2OaFMV6AzPWzsNfI7YBlCKaQDmVHT55o6rhqTeGA9nq9HjxPTxsRbbeqwF
         l4nriF/qyCBtXR13JC8ui7lZBP3KE3mg8W9I24Hw7Na86SnL6sCPMwva+AllQxd8zI1V
         CE7A==
X-Gm-Message-State: AOJu0YyX/J9TbGx66tFwVExgaNVkX/Jac3NWsWMv2rZ634xPyvfR/1qK
	LeJQyxVgEutxwzhUppPMnWPUTGyOo4ZxOy1rjhOB6g==
X-Google-Smtp-Source: AGHT+IFAvlUAZXw7bHsZwFS35caLWDCK/FdaHtzESwSH9xS18g6G9dbZx2pIGOSHmcHesU1oenrIGg==
X-Received: by 2002:a05:6000:1845:b0:32f:84e3:9db5 with SMTP id c5-20020a056000184500b0032f84e39db5mr7966317wri.6.1700583986902;
        Tue, 21 Nov 2023 08:26:26 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3815:34ab:69a0:6fd2? ([2a02:8011:e80c:0:3815:34ab:69a0:6fd2])
        by smtp.gmail.com with ESMTPSA id p11-20020adfcc8b000000b0032d9337e7d1sm14871554wrj.11.2023.11.21.08.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 08:26:26 -0800 (PST)
Message-ID: <0869bd90-3e3d-4bc1-bcb4-c4111f8f6350@isovalent.com>
Date: Tue, 21 Nov 2023 16:26:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 bpf-next 6/9] bpftool: test that we can dump and read
 the content of a map
Content-Language: en-GB
To: Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20231116194236.1345035-1-chantr4@gmail.com>
 <20231116194236.1345035-7-chantr4@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231116194236.1345035-7-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-11-16 19:43 UTC+0000 ~ Manu Bretelle <chantr4@gmail.com>
> This test adds a hardcoded key/value pair to a test map and verify
> that bpftool is able to dump its content and read/format it.
> 
>     $ BPFTOOL_PATH=../bpftool
>     CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_RUNNER="sudo -E" cargo test --
>     --nocapture
>         Finished test [unoptimized + debuginfo] target(s) in 0.05s
>          Running unittests src/main.rs
>     (target/debug/deps/bpftool_tests-afa5a7eef3cdeafb)
> 
>     running 7 tests
>     Running command "../bpftool" "version"
>     test bpftool_tests::run_bpftool ... ok
>     Running command "../bpftool" "map" "dump" "id" "1848713" "--json"
>     Running command "../bpftool" "prog" "list" "--json"
>     Running command "../bpftool" "map" "list" "--json"
>     Running command "../bpftool" "prog" "list" "--json"
>     Running command "../bpftool" "prog" "show" "id" "3160759" "--json"
>     Running command "../bpftool" "map" "list" "--json"
>     test bpftool_tests::run_bpftool_map_dump_id ... ok
>     test bpftool_tests::run_bpftool_prog_show_id ... ok
>     test bpftool_tests::run_bpftool_map_pids ... ok
>     test bpftool_tests::run_bpftool_prog_pids ... ok
>     test bpftool_tests::run_bpftool_prog_list ... ok
>     test bpftool_tests::run_bpftool_map_list ... ok
> 
>     test result: ok. 7 passed; 0 failed; 0 ignored; 0 measured; 0 filtered
>     out; finished in 0.22s
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  7 ++
>  .../bpf/bpftool_tests/src/bpftool_tests.rs    | 86 +++++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
> index e2b18dd36207..a90c8921b4ee 100644
> --- a/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
> @@ -11,6 +11,13 @@ struct {
>  	__type(value, u64);
>  } pid_write_calls SEC(".maps");
>  
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 10);
> +	__type(key, char[6]);
> +	__type(value, char[6]);
> +} bpftool_test_map SEC(".maps");
> +
>  int my_pid = 0;
>  
>  SEC("tp/syscalls/sys_enter_write")
> diff --git a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> index 695a1cbc5be8..90187152c1d1 100644
> --- a/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> +++ b/tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
> @@ -45,6 +45,37 @@ struct Map {
>      pids: Vec<Pid>,
>  }
>  
> +/// A struct representing a formatted map entry from `bpftool map dump -j`
> +#[derive(Serialize, Deserialize, Debug)]
> +struct FormattedMapItem {
> +    key: String,
> +    value: String,
> +}
> +
> +type MapVecString = Vec<String>;
> +
> +/// A struct representing a map entry from `bpftool map dump -j`
> +#[derive(Serialize, Deserialize, Debug)]
> +struct MapItem {
> +    key: MapVecString,
> +    value: MapVecString,
> +    formatted: Option<FormattedMapItem>,
> +}
> +
> +/// A helper function to convert a vector of strings as returned by bpftool
> +/// into a vector of bytes.
> +/// bpftool returns key/value in the form of a sequence of strings
> +/// hexadecimal numbers. We need to convert them back to bytes.

So sorry about that.

> +/// for instance, the value of the key "key" is represented as ["0x6b","0x65","0x79"]

s/for/For/

> +fn to_vec_u8(m: &MapVecString) -> Vec<u8> {
> +    m.iter()
> +        .map(|s| {
> +            u8::from_str_radix(s.trim_start_matches("0x"), 16)
> +                .unwrap_or_else(|_| panic!("Failed to parse {:?}", s))
> +        })
> +        .collect()
> +}
> +
>  /// Setup our bpftool_tests.bpf.c program.
>  /// Open and load and return an opened object.
>  fn setup() -> Result<BpftoolTestsSkel<'static>> {
> @@ -114,6 +145,61 @@ fn run_bpftool_map_pids() {
>      );
>  }
>  
> +/// A test to validate that we can run `bpftool map dump <id>`
> +/// and extract the expected information.
> +/// The test adds a key, value pair to the map and then dumps it.
> +/// The test validates that the dumped data matches what was added.
> +/// It also validate that bpftool was able to format the key/value pairs.

s/validate/validates/
s/pairs/pair/

> +#[test]
> +fn run_bpftool_map_dump_id() {
> +    // By having key/value null terminated, we can check that bpftool also returns the
> +    // formatted content.
> +    let key = b"key\0\0\0";
> +    let value = b"value\0";
> +    let skel = setup().expect("Failed to set up BPF program");
> +    let binding = skel.maps();
> +    let bpftool_test_map_map = binding.bpftool_test_map();
> +    bpftool_test_map_map
> +        .update(key, value, libbpf_rs::MapFlags::NO_EXIST)
> +        .expect("Failed to update map");
> +    let map_id = bpftool_test_map_map
> +        .info()
> +        .expect("Failed to get map info")
> +        .info
> +        .id;
> +
> +    let output = run_bpftool_command(&["map", "dump", "id", &map_id.to_string(), "--json"]);
> +    assert!(output.status.success(), "bpftool returned an error.");
> +
> +    let items =
> +        serde_json::from_slice::<Vec<MapItem>>(&output.stdout).expect("Failed to parse JSON");
> +
> +    assert_eq!(items.len(), 1);
> +
> +    let item = items.first().expect("Expected a map item");
> +    assert_eq!(to_vec_u8(&item.key), key);
> +    assert_eq!(to_vec_u8(&item.value), value);
> +
> +    // Validate "formatted" values.
> +    // The keys and values are null terminated so we need to trim them before comparing.

key and value, singular

> +    let formatted = item
> +        .formatted
> +        .as_ref()
> +        .expect("Formatted values are missing");
> +    assert_eq!(
> +        formatted.key,
> +        std::str::from_utf8(key)
> +            .expect("Invalid UTF-8")

Do we need to check the UTF-8 encoding for the strings we provide in the
test?

> +            .trim_end_matches('\0'),
> +    );
> +    assert_eq!(
> +        formatted.value,
> +        std::str::from_utf8(value)
> +            .expect("Invalid UTF-8")
> +            .trim_end_matches('\0'),
> +    );
> +}
> +
>  /// A test to validate that we can list programs using bpftool
>  #[test]
>  fn run_bpftool_prog_list() {


