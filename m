Return-Path: <bpf+bounces-64367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00995B11DF4
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 13:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198677B5391
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC302E610E;
	Fri, 25 Jul 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2MZq8AJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22172405F5
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444394; cv=none; b=RBAMbKyq9ryDv73WR5uZGgm2rR++MXMDI3Aoh5lsJfy67WkdPEEgdrhHHZ7J01z0ixAgBGI7pkAKT1pdbMp8nD4z3YogujvinrkOtszcI7cuoX432RSoMEN7CeVaYm0MRxtMKD4zDZMhCrFVGWNpWlvoGWXdG0lca1QIRMBkpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444394; c=relaxed/simple;
	bh=DwYLGtgL1ZocShRzFO8MQB/JOKkfYOfzl7LTwSi4kyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkNlu3boHQD/rm/As6QQTGNzeCO/ipelQ8h5W/1vmXjt5BOQ6RQ/luAzBU42M3PRbnBXBakbgCQCH5ZnaQiQY44ffM47RIABPJkT0mCAt3xMqzFcythuoOTyjm5p3buVAhDo0lPYIqiEAIRHlzo/QPIzDPW93cvyH63tdhbcOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2MZq8AJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a510432236so1517641f8f.0
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753444391; x=1754049191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qAGpzQA81kdhq/PtPxtmUruaaPXac9KvZK6o8Mdbg+k=;
        b=j2MZq8AJcBojs4xdQXSgPM8Zy9yUhmfplJY43XPq09mctjm5h1gyDmjiU+dohz4Yso
         ORNjRG2SwHfyPZ9DWVlZbdWO+povi7dD/NIvchcXMrwLevMOUeE3uJU+xnSHYU1dclE0
         xB9wWARF5fLNpvPPwGAUChrLyZf6JTfDafWKntgj19LtN5KQsielydZ6Yw6pJ8b2w7Yg
         77HkcDm/WxQq1VRhv8XsEn6L9YVdOwkNZeGC+JYJ3LrueUcvLAEjL5aedCn/N931qrht
         id5o3JWuMoxDofESWsXeBe2pXgmvVbDqHpYhspA7NQPCh05mk9h1vDVI6go87+BmfyUA
         EXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444391; x=1754049191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAGpzQA81kdhq/PtPxtmUruaaPXac9KvZK6o8Mdbg+k=;
        b=uO/4XKKNLY8qsxpGLzOpjsNW4w8+wGbhpORt3QmTgiirUlPs3DTyNpA0PmdcPwFBy8
         1O5C+Pg5owz3acEM5pqQ6Ow5GQ7HxkR5+95YyOFv71II9T7rzZ9ge/avSCFi6DujmIaL
         0UqX1LTSi96br5pL7OO8Wn0v7kXQS1euewSO/sFfM5Wh2/IdW3jGj37gsOmljnPO53TT
         lvESnr9YJBcebVLGFu7Aci3bATt7JP/wwvSTHkDib45d1zoNRZgbpvP+kIj1pfbhTgtw
         lQD7udbg48227uanG0xikxSg5QiZGzwhzzEVO4/yWQq2MJlWynzLL0ouqCraGCjaxUYu
         r0pA==
X-Forwarded-Encrypted: i=1; AJvYcCVdRoq5e6tsBv9iX+3akz5KI66gJ1I+g4lL/pZPKP5sni2J9pfRv8+XRzauGoEXzUF/cWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynuYzj5MIoL++vyNccslsaiirHlifE0BWJh5xMg3DUSE2hxEml
	ZYuZJeNqTY/hnv41D3LYQDplOpxh7vlTBtOfxDXbe2FMy3qgRF85wzMYPL4+6w==
X-Gm-Gg: ASbGnctQpPP9rRqE9vlBi5hgDEQN8H2oCBgUdSwX1oNyIuahKXwobWDTqISqTdXOfIf
	S62BstVmncED+ZgfMAcTaPlWn09CMw18kFJL081kW4tmt7Pc3R5vuriGab9unp13+wdfx7LNk7S
	F6T1f6aG2xGFjgVpEn6Q9OhyFrwo6GvmG2FaZcP+I0j9CNBcO4jlwKsRNx12UyWcmQS4t+9OUME
	zQevkiS8K63vaRXryDiWNiR5H8nCFZOrOBoQBXa/XESqLhf74NxcvLIHfkxvbzZOyV+8EsU3mJk
	VeG1zysCWnQ0lRY9A8ERKRGbAxiFq4JfhdhuB1nmQHfvavSKND/bqal/S9+cFxOeUFp6yrqPjB1
	YN9tt8P+z5d6zV25XFZ4yBypU+ivQ8EZL+/WlGS0qAietnSS6f1If2iE7JXihQ+M+CIcUThqowi
	7Jc9Mms4jzgmBjKsGo
X-Google-Smtp-Source: AGHT+IHS1HYaLP8IF/+IcmsUHn4xEo/XtnWDGefVCA1ryvgzAzDIRhUCyANZz4iYTO8QxZHziGcD8A==
X-Received: by 2002:a05:6000:2c02:b0:3b3:9cc4:4bc0 with SMTP id ffacd0b85a97d-3b776666017mr1463519f8f.32.1753444391014;
        Fri, 25 Jul 2025 04:53:11 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad219sm4871277f8f.39.2025.07.25.04.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 04:53:10 -0700 (PDT)
Message-ID: <d5018507-3313-4e0d-be75-5266171979f3@gmail.com>
Date: Fri, 25 Jul 2025 12:53:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Increase xdp data size for
 arm64 64K page size
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250725043425.208128-1-yonghong.song@linux.dev>
 <20250725043430.208469-1-yonghong.song@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250725043430.208469-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 05:34, Yonghong Song wrote:
> With arm64 64K page size, the following 4 subtests failed:
>    #97/25   dynptr/test_probe_read_user_dynptr:FAIL
>    #97/26   dynptr/test_probe_read_kernel_dynptr:FAIL
>    #97/27   dynptr/test_probe_read_user_str_dynptr:FAIL
>    #97/28   dynptr/test_probe_read_kernel_str_dynptr:FAIL
>
> These failures are due to function bpf_dynptr_check_off_len() in
> include/linux/bpf.h where there is a test
>    if (len > size || offset > size - len)
>      return -E2BIG;
> With 64K page size, the 'offset' is greater than 'size - len',
> which caused the test failure.
>
> For 64KB page size, this patch increased the xdp buffer size from 5000 to
> 90000. The above 4 test failures are fixed as 'size' value is increased.
> But it introduced two new failures:
>    #97/4    dynptr/test_dynptr_copy_xdp:FAIL
>    #97/12   dynptr/test_dynptr_memset_xdp_chunks:FAIL
>
> These two failures will be addressed in subsequent patches.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>   tools/testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index f2b65398afce..9b2d9ceda210 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -51,6 +51,8 @@ static struct {
>   	{"test_copy_from_user_task_str_dynptr", SETUP_SYSCALL_SLEEP},
>   };
>   
> +#define PAGE_SIZE_64K 65536
> +
>   static void verify_success(const char *prog_name, enum test_setup_type setup_type)
>   {
>   	char user_data[384] = {[0 ... 382] = 'a', '\0'};
> @@ -146,14 +148,18 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
>   	}
>   	case SETUP_XDP_PROG:
>   	{
> -		char data[5000];
> +		char data[90000];
>   		int err, prog_fd;
>   		LIBBPF_OPTS(bpf_test_run_opts, opts,
>   			    .data_in = &data,
> -			    .data_size_in = sizeof(data),
>   			    .repeat = 1,
>   		);
>   
> +		if (getpagesize() == PAGE_SIZE_64K)
> +			opts.data_size_in = sizeof(data);
> +		else
> +			opts.data_size_in = 5000;
> +
>   		prog_fd = bpf_program__fd(prog);
>   		err = bpf_prog_test_run_opts(prog_fd, &opts);
>   
Thanks for fixing these tests for 64K page size.
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

