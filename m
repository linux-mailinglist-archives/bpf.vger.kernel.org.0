Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5960E428FD4
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbhJKOBf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 10:01:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:55424 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbhJKN7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Oct 2021 09:59:33 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mZvo4-0008Ae-0Q; Mon, 11 Oct 2021 15:57:32 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mZvo3-0004U9-RX; Mon, 11 Oct 2021 15:57:31 +0200
Subject: Re: [PATCH bpf-next 08/10] selftests/bpf: demonstrate use of custom
 .rodata/.data sections
To:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, kernel-team@fb.com
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-9-andrii@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <dfde174b-fff5-118b-b6c8-a2d4047ab2c1@iogearbox.net>
Date:   Mon, 11 Oct 2021 15:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211008000309.43274-9-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26319/Mon Oct 11 10:18:47 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/8/21 2:03 AM, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> Enhance existing selftests to demonstrate the use of custom
> .data/.rodata sections.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Just a thought, but wouldn't the actual demo / use case be better to show that we can
now have a __read_mostly attribute which implies SEC(".data.read_mostly") section?

Would be nice to add a ...

   #define __read_mostly    SEC(".data.read_mostly")

... into tools/lib/bpf/bpf_helpers.h along with the series for use out of BPF programs
as I think this should be a rather common use case. Thoughts?

> ---
>   .../selftests/bpf/prog_tests/skeleton.c       | 25 +++++++++++++++++++
>   .../selftests/bpf/progs/test_skeleton.c       | 10 ++++++++
>   2 files changed, 35 insertions(+)
[...]
> diff --git a/tools/testing/selftests/bpf/progs/test_skeleton.c b/tools/testing/selftests/bpf/progs/test_skeleton.c
> index 441fa1c552c8..47a7e76866c4 100644
> --- a/tools/testing/selftests/bpf/progs/test_skeleton.c
> +++ b/tools/testing/selftests/bpf/progs/test_skeleton.c
> @@ -40,9 +40,16 @@ int kern_ver = 0;
>   
>   struct s out5 = {};
>   
> +const volatile int in_dynarr_sz SEC(".rodata.dyn");
> +const volatile int in_dynarr[4] SEC(".rodata.dyn") = { -1, -2, -3, -4 };
> +
> +int out_dynarr[4] SEC(".data.dyn") = { 1, 2, 3, 4 };
> +
>   SEC("raw_tp/sys_enter")
>   int handler(const void *ctx)
>   {
> +	int i;
> +
>   	out1 = in1;
>   	out2 = in2;
>   	out3 = in3;
> @@ -53,6 +60,9 @@ int handler(const void *ctx)
>   	bpf_syscall = CONFIG_BPF_SYSCALL;
>   	kern_ver = LINUX_KERNEL_VERSION;
>   
> +	for (i = 0; i < in_dynarr_sz; i++)
> +		out_dynarr[i] = in_dynarr[i];
> +
>   	return 0;
>   }
>   
> 

