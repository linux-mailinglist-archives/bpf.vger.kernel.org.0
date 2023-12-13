Return-Path: <bpf+bounces-17680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89231811508
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3C2828C3
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B72EB09;
	Wed, 13 Dec 2023 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLBMnt5J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D3C112
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 06:43:14 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9fe0b5b28so90130771fa.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478593; x=1703083393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wjJx+cG+Brq8M2W5mZ43bNr76OcmLiZ/44eEdJznr2w=;
        b=KLBMnt5JFo+1z/5rYQk12CK6LA5oZyMhLwp850XfJqsbKRxpzd0Lzg3LiPIko/GiJE
         2s+TAPFfgvM9Ix7gdyjuU8Wm+ucf+PacnpNSl4nqGRPp2ooEXsdfj7NdMJwWKlTl5rpQ
         +sq5toIbauFLfHnQBUXAZ3ZA8hXJRUv9Zed69c8YrLkXIbs6w9nj4JxPBjssbG8q30wm
         /B8dmF9D9vqmctbkor093THE41MlhkETJQgFhK63fSBOAux1oQU9pAL9eYD9+7QxCASW
         T5CkowdbxpXdsUxlpbhQpcCOJ1s6iTimHaujpLMCFXAMXiLICNWv9AkVAQhpO2Yp9vwO
         vghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478593; x=1703083393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJx+cG+Brq8M2W5mZ43bNr76OcmLiZ/44eEdJznr2w=;
        b=rA3O+luSNVvtAl17LApf8l4vtpNM7hiG3F5itFwWDR5pUX/w7YBlaPL3JgkZgmuHN+
         gogwIeb4UpEUQUsGNv1ninP2swja7SrqvuHnr4dYgDWnGNTokfKrEmTkyLymzHL1sBLB
         ax1LEZHKKNtJO1FtUs1lTQNiQRP6tmkEOGE1cauK3ksYcEbJ3HL2/1xW/vu3ppGK61Bo
         v2fe1nrBIMncjF/p0sgQCDcyXwGztptQh4RfyIxa4x5EoPr0iibn1GasEwUJZfqK1PSu
         1VvFhMnde1ELkZVh4VOHJQePFyIFJ8pjeVRsHlH1LWrc2LcMN2XyRJMZLocEWXtEWCTs
         bNpA==
X-Gm-Message-State: AOJu0YwucBRnUM6f+/ti2vOmuIRunA+RykhwY1YgolPVHJwk5bplEDAU
	4sWJc6ThVRkqkuXDbdu+UJY=
X-Google-Smtp-Source: AGHT+IG+v9hD89suIVhXX+Cm93qIKDjMedbJzAL1snNTILwDRQsRvd5ZMk2Zs5Eq/oDRa4SWQfAwjQ==
X-Received: by 2002:a2e:9b03:0:b0:2c9:fa2d:3e10 with SMTP id u3-20020a2e9b03000000b002c9fa2d3e10mr3586916lji.68.1702478592468;
        Wed, 13 Dec 2023 06:43:12 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b0040b3867a297sm21066883wmp.36.2023.12.13.06.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:43:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Dec 2023 15:43:10 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add test for abnormal cnt
 during multi-uprobe attachment
Message-ID: <ZXnC_utPtXeqAIs3@krava>
References: <20231213112531.3775079-1-houtao@huaweicloud.com>
 <20231213112531.3775079-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213112531.3775079-4-houtao@huaweicloud.com>

On Wed, Dec 13, 2023 at 07:25:30PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> If an abnormally huge cnt is used for multi-uprobes attachment, the
> following warning will be reported:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 7 PID: 406 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
>   Modules linked in: bpf_testmod(O)
>   CPU: 7 PID: 406 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
>   RIP: 0010:kvmalloc_node+0xd9/0xe0
>   ......
>   Call Trace:
>    <TASK>
>    ? __warn+0x89/0x150
>    ? kvmalloc_node+0xd9/0xe0
>    bpf_uprobe_multi_link_attach+0x14a/0x480
>    __sys_bpf+0x14a9/0x2bc0
>    do_syscall_64+0x36/0xb0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>    ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> So add a test to ensure the warning is fixed.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index ece260cf2c0b..0d2a4510e6cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -234,6 +234,35 @@ static void test_attach_api_syms(void)
>  	test_attach_api("/proc/self/exe", NULL, &opts);
>  }
>  
> +static void test_failed_link_api(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +	const char *path = "/proc/self/exe";
> +	struct uprobe_multi *skel = NULL;
> +	unsigned long offset = 0;
> +	int link_fd = -1;
> +
> +	skel = uprobe_multi__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> +		goto cleanup;
> +
> +	/* abnormal cnt */
> +	opts.uprobe_multi.path = path;
> +	opts.uprobe_multi.offsets = &offset;
> +	opts.uprobe_multi.cnt = INT_MAX;
> +	opts.kprobe_multi.flags = 0;

     s/k/u/  ^^^ .. or best just remove the line

jirka

> +	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
> +				  BPF_TRACE_UPROBE_MULTI, &opts);
> +	if (!ASSERT_ERR(link_fd, "link_fd"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(link_fd, -EINVAL, "invalid cnt"))
> +		goto cleanup;
> +cleanup:
> +	if (link_fd >= 0)
> +		close(link_fd);
> +	uprobe_multi__destroy(skel);
> +}
> +
>  static void __test_link_api(struct child *child)
>  {
>  	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
> @@ -311,7 +340,7 @@ static void __test_link_api(struct child *child)
>  	free(offsets);
>  }
>  
> -void test_link_api(void)
> +static void test_link_api(void)
>  {
>  	struct child *child;
>  
> @@ -408,6 +437,8 @@ void test_uprobe_multi_test(void)
>  		test_attach_api_syms();
>  	if (test__start_subtest("link_api"))
>  		test_link_api();
> +	if (test__start_subtest("failed_link_api"))
> +		test_failed_link_api();
>  	if (test__start_subtest("bench_uprobe"))
>  		test_bench_attach_uprobe();
>  	if (test__start_subtest("bench_usdt"))
> -- 
> 2.29.2
> 

