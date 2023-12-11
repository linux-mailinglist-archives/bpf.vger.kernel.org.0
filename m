Return-Path: <bpf+bounces-17401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF980CA50
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5DEBB20F75
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047AE3C078;
	Mon, 11 Dec 2023 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDzinYdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333FAF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c339d2b88so30600735e9.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299375; x=1702904175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KLvj/GVrkSA8DHWJQJ160yZDzLtUmybGw5DElE1H1ro=;
        b=JDzinYdn9/Fg1z6sddNKoI5mFd30cOFTWpkyFOyRPFvbcWye30BeyjKV28weRX4FGE
         DIA8t8Bg6x6ZYIOiJqE/gzmxJIFfu/YuAMZ0BLJ1M/JltyBbHVDz0WgAwHd0D1/3vOZH
         qYCFW0usp+VyE/7HIuMubaqt8aRNAZGI9diykJm/1Z5r5Ulwgz6IyN37rr6eB8qODdjq
         XCQtQlK0roiNwlPXoVzg0UlR7cOHpe8iS70io0QdabMdE2CCxmPsl0fMxtL1errRNtgT
         4IBb6nYXb1Qr8SZeJHCfswhD/JURO3djjcpe7vG4AgWhrp3jQzQgWioijNEsPHMJZQn7
         5WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299375; x=1702904175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLvj/GVrkSA8DHWJQJ160yZDzLtUmybGw5DElE1H1ro=;
        b=FXwA/a7jjdNhSBCq2WKROaM2nijhnppaf4rvyC8Qi1lIvp7qE7I6mpU8IZcudThiPv
         2vZp0lRT06HhjzOSgKAo4M97GDZMxJ9VfhfHDD27o4+/f0tbRK0QSL7NBsDOnZOYvMZC
         npUFpj2LRviw5+eDXg9ZYK1sRt4a25wn//wCW7PbP115sGyUh14V8p8arjlJdbuSIfkj
         pveIdMbtaFklMdo5oFtmPUU8Fa7cS/+FuepCPNGsiMU0UuavyBpfvbf1nx1jbJOklTn4
         i1ed7me+DiHQS+NPZ65DxZR45KLo8IH3xPL/isnQWP3V7LFkA8QX8KZURO+DCJlWwrbO
         1CNQ==
X-Gm-Message-State: AOJu0Yxgs7OyWJ4y3PA4wS0xO9PqONFIVOKua9fvgcZECEIhnOjcXxFI
	/eVdBRbVQaS1sn2zSK+vspc=
X-Google-Smtp-Source: AGHT+IFaLKxzw1M5COqQJAQ35/mxDpgqEqq+1AoTLm02A9tJXdXZwFxHOtxyrSQ5l43MxjXr4IhZSQ==
X-Received: by 2002:a05:600c:3516:b0:40b:5e21:e25b with SMTP id h22-20020a05600c351600b0040b5e21e25bmr2094456wmq.72.1702299374920;
        Mon, 11 Dec 2023 04:56:14 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b004042dbb8925sm15137441wmq.38.2023.12.11.04.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:56:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:56:12 +0100
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
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add test for abnormal cnt
 during multi-uprobe attachment
Message-ID: <ZXcG7FQLi08Eojjy@krava>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211112843.4147157-5-houtao@huaweicloud.com>

On Mon, Dec 11, 2023 at 07:28:43PM +0800, Hou Tao wrote:
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
>  .../bpf/prog_tests/uprobe_multi_test.c        | 43 ++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index ece260cf2c0b..379ee9cc6221 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -234,6 +234,45 @@ static void test_attach_api_syms(void)
>  	test_attach_api("/proc/self/exe", NULL, &opts);
>  }
>  
> +static void test_failed_link_api(void)
> +{
> +	LIBBPF_OPTS(bpf_link_create_opts, opts);
> +	const char *path = "/proc/self/exe";
> +	struct uprobe_multi *skel = NULL;
> +	unsigned long *offsets = NULL;
> +	const char *syms[3] = {
> +		"uprobe_multi_func_1",
> +		"uprobe_multi_func_2",
> +		"uprobe_multi_func_3",
> +	};
> +	int link_fd = -1, err;
> +
> +	err = elf_resolve_syms_offsets(path, 3, syms, (unsigned long **) &offsets, STT_FUNC);
> +	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
> +		return;

we should not need any symbols/offset for this tests right?

the allocation takes place before the offsets are checked,
so I think using just some pointer != NULL should be enough?

thanks,
jirka

> +
> +	skel = uprobe_multi__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
> +		goto cleanup;
> +
> +	/* abnormal cnt */
> +	opts.uprobe_multi.path = path;
> +	opts.uprobe_multi.offsets = offsets;
> +	opts.uprobe_multi.cnt = INT_MAX;
> +	opts.kprobe_multi.flags = 0;
> +	link_fd = bpf_link_create(bpf_program__fd(skel->progs.uprobe), 0,
> +				  BPF_TRACE_UPROBE_MULTI, &opts);
> +	if (!ASSERT_ERR(link_fd, "link_fd"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(link_fd, -ENOMEM, "no mem fail"))
> +		goto cleanup;
> +cleanup:
> +	if (link_fd >= 0)
> +		close(link_fd);
> +	uprobe_multi__destroy(skel);
> +	free(offsets);
> +}
> +
>  static void __test_link_api(struct child *child)
>  {
>  	int prog_fd, link1_fd = -1, link2_fd = -1, link3_fd = -1, link4_fd = -1;
> @@ -311,7 +350,7 @@ static void __test_link_api(struct child *child)
>  	free(offsets);
>  }
>  
> -void test_link_api(void)
> +static void test_link_api(void)
>  {
>  	struct child *child;
>  
> @@ -408,6 +447,8 @@ void test_uprobe_multi_test(void)
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

