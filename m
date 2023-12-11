Return-Path: <bpf+bounces-17402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420A80CA51
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 13:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF481F2181A
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A793C074;
	Mon, 11 Dec 2023 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR5O7z8s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B32BA
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c0e7b8a9bso56830765e9.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702299382; x=1702904182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHN4Sy2kbsrk/6RC1XC3Xil6aAj8Uqiv2z072Yz3VFM=;
        b=MR5O7z8s3kfnlOEvc4+puyrwaVoJorLRMYtrWJWNBQZ7ZQe5Hjhh/e5hQSulgddBNN
         2+cJS9/gjCjeDHYS6xdEXZmrCef10utvplHPIybO2Z2kUStwLU1TbwcfCrwXSRTAtznh
         wnRutUsIbPE8xcRsgzyeZWAhpteJaccbZAEUpz2R4JIr5d/dd72dhb0C9Qk/wbycQUwx
         KG2tZVvFp9UaGYAA0cUWC6LMu5VGX5d5f79M8NLRGJekqURl4mzYrzylx5NNJIbOJnxX
         Y2B0akBwmNVgAl8xN9wzkWMW/gOlDRu8qETOSR0GYsTw77g9epe/UDgj2meNAP11tfTu
         Vutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702299382; x=1702904182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHN4Sy2kbsrk/6RC1XC3Xil6aAj8Uqiv2z072Yz3VFM=;
        b=fJuSzTWbAql5Xx29VhMl/30YpZni1xIoLN4oXTGRGT+49HyABxqYZFkWlEtbkhNsN6
         0v+3j5H2Ll0n8OfSpm6BqoSkDj8UoSAsUd6y6GvJEq2TL1ys5/AEIysSfHrvPVq/3/jH
         Vlb+940SyNJLwxtH3rAFkr2IpAe+nvEVyEFXa512u12sotP9AZdNDe/nUkjcOlU1bbci
         DBWjB073rfX9rVYiMvrxr+sJKMAseUAX71SprV+c9IZveOUIdAZqOfl11MbbmVKCkPhC
         bR2PrLb6C4Mh/iuCYAv1eVyMj8B5+vSRYphcYbgM490dcrPj1Q4M4joD/13E7o1bJ0ko
         K7hA==
X-Gm-Message-State: AOJu0Yz/4adXiFol2QYFICdAE29WPzeCrSrB7vaimP1NU/YFtXY8aW6z
	VYIh8hlZb02UpJ4vWy2ZuDAp1/GGFSg=
X-Google-Smtp-Source: AGHT+IHT8CQddn2KoymuIZUCrLmFNlNG+e0TsJY87UxBGG3T5L7JVPPEiCHFesqLdlbrZFlcWmI1JA==
X-Received: by 2002:a7b:c3d3:0:b0:40b:4520:45c9 with SMTP id t19-20020a7bc3d3000000b0040b452045c9mr2528092wmj.36.1702299381680;
        Mon, 11 Dec 2023 04:56:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b0040b5377cf03sm15159389wms.1.2023.12.11.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:56:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Dec 2023 13:56:19 +0100
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
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add test for abnormal cnt
 during multi-kprobe attachment
Message-ID: <ZXcG85qIqxsDfxKi@krava>
References: <20231211112843.4147157-1-houtao@huaweicloud.com>
 <20231211112843.4147157-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211112843.4147157-4-houtao@huaweicloud.com>

On Mon, Dec 11, 2023 at 07:28:42PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> If an abnormally huge cnt is used for multi-kprobes attachment, the
> following warning will be reported:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 392 at mm/util.c:632 kvmalloc_node+0xd9/0xe0
>   Modules linked in: bpf_testmod(O)
>   CPU: 1 PID: 392 Comm: test_progs Tainted: G ...... 6.7.0-rc3+ #32
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   ......
>   RIP: 0010:kvmalloc_node+0xd9/0xe0
>    ? __warn+0x89/0x150
>    ? kvmalloc_node+0xd9/0xe0
>    bpf_kprobe_multi_link_attach+0x87/0x670
>    __sys_bpf+0x2a28/0x2bc0
>    __x64_sys_bpf+0x1a/0x30
>    do_syscall_64+0x36/0xb0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>   RIP: 0033:0x7fbe067f0e0d
>   ......
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
> 
> So add a test to ensure the warning is fixed.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  .../selftests/bpf/prog_tests/kprobe_multi_test.c   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 4041cfa670eb..a340b6047657 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -300,6 +300,20 @@ static void test_attach_api_fails(void)
>  	if (!ASSERT_EQ(libbpf_get_error(link), -EINVAL, "fail_5_error"))
>  		goto cleanup;
>  
> +	/* fail_6 - abnormal cnt */
> +	opts.addrs = (const unsigned long *) addrs;
> +	opts.syms = NULL;
> +	opts.cnt = INT_MAX;
> +	opts.cookies = NULL;
> +
> +	link = bpf_program__attach_kprobe_multi_opts(skel->progs.test_kprobe_manual,
> +						     NULL, &opts);
> +	if (!ASSERT_ERR_PTR(link, "fail_6"))
> +		goto cleanup;
> +
> +	if (!ASSERT_EQ(libbpf_get_error(link), -ENOMEM, "fail_6_error"))
> +		goto cleanup;
> +
>  cleanup:
>  	bpf_link__destroy(link);
>  	kprobe_multi__destroy(skel);
> -- 
> 2.29.2
> 

