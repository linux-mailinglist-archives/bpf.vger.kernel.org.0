Return-Path: <bpf+bounces-36823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51D94DB22
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 08:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834BB1C212BD
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12B4502F;
	Sat, 10 Aug 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMvSleJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FB121A0B
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723272554; cv=none; b=ri3WmYnsQOK6exLYfUyt9XBIHHxxqL+EVCmPJPn7y5WFUbLrM+n+2KVCVU+NjtyClY8BD6lt2mZVO32FoTRCOY7oo3tawX3OsDX2p4f77Nt6O+SPTvWSZ/L3Hv294TZE11pQNe1EJOCiTsAH3quGxYEOLjOE/PcGFkPJE3UFoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723272554; c=relaxed/simple;
	bh=3dviYW7usS+CabbFD7ufpnNJpNRiQM7He2aqSD2F6nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxLC8A65q7+kyD7k20bwIvFA7xrKm0Oa8bLE1otAQTf5YJIPRj3qCfu7MJqvwMEGkDXX5TgC9m6k6YDg18iuJH2fH+jVU6XFd6zIPFYN94cKCbmYWRBLMbwItyVOkiduzfZcFtqXSLjtgvlvzdROCvFaPDKvY4y9A+iToJLYKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMvSleJz; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d9e13ef8edso2012158b6e.2
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 23:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723272552; x=1723877352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tiaxKPLKPDNpocF1Tu4ddg2mNEyOB7YSA5iE1flatM=;
        b=eMvSleJz/4sP4vn3ToAkisGHnHsw2Da35DxoQSlDptx8J6YEE84aHpj5LypZV9ziOQ
         Ft/Hx3IBOhmsF2HP4BMStwSCyzmvri4DLnOpfy93D+JsuduStD7nAmyTcviLRACIp+B6
         C62m9ygbeLxQ7dRmHYtuzAuhL2fS7VqMs3LmIb9ofx5hl/s9oFReJcSDoUrctmkB+u4Z
         /t4/Tfb4QEHwgQEIzVDcclAMY/+if2maUMq4qcv4E3wQ9zS2eG5GU/yGsExAMph8Uc/Y
         Bl/t3wm0OhD6VmBnAEfi5DpIgnt0gKLDzfUeEPkIV//+DAlZdqNsfmK4vn7TfTZceJeU
         pCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723272552; x=1723877352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tiaxKPLKPDNpocF1Tu4ddg2mNEyOB7YSA5iE1flatM=;
        b=gVJ+JNdz5XPJiGF2iiZwVKaT5jwz37M3sG217eL+r55v1328DkmCif+AzqPb2Hi42g
         xUVzoeD0+az7tFY5o7C6a2zTGtIcx7BjplHvAQW1WL216w0/rJd06OMgG2yClpgQTMCk
         WIwO/25xuIqsS6TgSiPinA2NEGc4VheDhsdWIRmKuYGVc+kiY9xzrU/3QdBdR/Dj7uDK
         +RJ691yuboW1lA2gmXcIihOIf1DBfL4QQS9at4GtMp3PABpOkKgzS/mTo6DLiQNqiIgr
         Q4xmJxao3oO4C3aY8CjIV4cwYJ5G4hZ+qiNPcSjqQhUt+Tpn1zO8JvQgReXQ/J9QcSd2
         oKqw==
X-Forwarded-Encrypted: i=1; AJvYcCXTNaskhDCi/siPF7NHfZtc7Liwkcx0+vcT8zODPt0603OuEwRHuUagBJHHKMomyoRxcUJkPJ7rcSaG9ovUAOVNQPZx
X-Gm-Message-State: AOJu0YyGZpor/cJosd3HFWYWkN8M3MuN9wKWKVCeCaQ7HXExx+40767q
	okD8SXhSw+1m/uT/YcfiqnEdnfBGI5F04uMR6l+SnoY5uC38u2wA
X-Google-Smtp-Source: AGHT+IEU+sYEfJDQmVRw0FUewQ75WkcNjT2qEVCSalglIAE/rUOss/3T/fJeOQxbO8bQAfjai8APOQ==
X-Received: by 2002:a05:6808:3a15:b0:3d5:2afc:94f5 with SMTP id 5614622812f47-3dc41665accmr4701310b6e.10.1723272551573;
        Fri, 09 Aug 2024 23:49:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2? ([2600:1700:6cf8:1240:e383:f1a1:d5c5:1cf2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58c7e49sm745220b3a.93.2024.08.09.23.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 23:49:11 -0700 (PDT)
Message-ID: <fb6e876a-82f7-42ad-9b80-17cbcebefd21@gmail.com>
Date: Fri, 9 Aug 2024 23:49:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next v1] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20240809212301.3782412-1-linux@jordanrome.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240809212301.3782412-1-linux@jordanrome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/9/24 14:23, Jordan Rome wrote:
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
> 
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper.
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>   kernel/bpf/helpers.c                          | 26 +++++++++++++++++++
>   .../selftests/bpf/prog_tests/attach_probe.c   |  8 +++---
>   .../selftests/bpf/prog_tests/read_vsyscall.c  |  1 +
>   .../selftests/bpf/progs/read_vsyscall.c       |  9 ++++++-
>   .../selftests/bpf/progs/test_attach_probe.c   | 24 ++++++++++++++---
>   5 files changed, 61 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..455cac7b2631 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,6 +2939,31 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_iter_bits *it)
>   	bpf_mem_free(&bpf_global_ma, kit->bits);
>   }
> 
> +/**
> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> + * @dst:             Destination address, in kernel space.  This buffer must be at
> + *                   least @dst__szk bytes long.
> + * @dst__szk:        Maximum number of bytes to copy, including the trailing NUL.
> + * @unsafe_ptr__ign: Source address, in user space.
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user string is
> + * too long this will still ensure zero termination in the dst buffer unless
> + * buffer size is 0.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const void __user *unsafe_ptr__ign)
> +{
> +	int ret;
> +
> +	if (unlikely(!dst__szk))
> +		return 0;
> +
> +	ret = strncpy_from_user(dst, unsafe_ptr__ign, dst__szk);

Does this function promise dst is null terminated if ret >= 0?
It seems not to have null at the end if the source string is longer than
dst_szk.


> +	if (unlikely(ret < 0))
> +		memset(dst, 0, dst__szk);
> +
> +	return ret;
> +}
> +
>   __bpf_kfunc_end_defs();
> 
>   BTF_KFUNCS_START(generic_btf_ids)
> @@ -3024,6 +3049,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>   BTF_KFUNCS_END(common_btf_ids)
> 
>   static const struct btf_kfunc_id_set common_kfunc_set = {
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 7175af39134f..329c7862b52d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -283,9 +283,11 @@ static void test_uprobe_sleepable(struct test_attach_probe *skel)
>   	trigger_func3();
> 
>   	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_byname3_sleepable_res");
> -	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res");
> -	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretprobe_byname3_sleepable_res");
> -	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3_res");
> +	ASSERT_EQ(skel->bss->uprobe_byname3_str_sleepable_res, 10, "check_uprobe_byname3_str_sleepable_res");
> +	ASSERT_EQ(skel->bss->uprobe_byname3_res, 11, "check_uprobe_byname3_res");
> +	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 12, "check_uretprobe_byname3_sleepable_res");
> +	ASSERT_EQ(skel->bss->uretprobe_byname3_str_sleepable_res, 13, "check_uretprobe_byname3_str_sleepable_res");
> +	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 14, "check_uretprobe_byname3_res");
>   }
> 
>   void test_attach_probe(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> index 3405923fe4e6..c7b9ba8b1d06 100644
> --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> @@ -23,6 +23,7 @@ struct read_ret_desc {
>   	{ .name = "probe_read_user_str", .ret = -EFAULT },
>   	{ .name = "copy_from_user", .ret = -EFAULT },
>   	{ .name = "copy_from_user_task", .ret = -EFAULT },
> +	{ .name = "copy_from_user_str", .ret = -EFAULT },
>   };
> 
>   void test_read_vsyscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> index 986f96687ae1..27de1e907754 100644
> --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (C) 2024. Huawei Technologies Co., Ltd */
> +#include "vmlinux.h"
>   #include <linux/types.h>
>   #include <bpf/bpf_helpers.h>
> 
> @@ -7,10 +8,15 @@
> 
>   int target_pid = 0;
>   void *user_ptr = 0;
> -int read_ret[8];
> +int read_ret[9];
> 
>   char _license[] SEC("license") = "GPL";
> 
> +/*
> + * This is the only kfunc, the others are helpers
> + */
> +int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym;
> +
>   SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>   int do_probe_read(void *ctx)
>   {
> @@ -40,6 +46,7 @@ int do_copy_from_user(void *ctx)
>   	read_ret[6] = bpf_copy_from_user(buf, sizeof(buf), user_ptr);
>   	read_ret[7] = bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
>   					      bpf_get_current_task_btf(), 0);
> +	read_ret[8] = bpf_copy_from_user_str((char *)buf, sizeof(buf), user_ptr);
> 
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> index 68466a6ad18c..a90fa0bf103b 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -14,11 +14,15 @@ int uretprobe_byname_res = 0;
>   int uprobe_byname2_res = 0;
>   int uretprobe_byname2_res = 0;
>   int uprobe_byname3_sleepable_res = 0;
> +int uprobe_byname3_str_sleepable_res = 0;
>   int uprobe_byname3_res = 0;
>   int uretprobe_byname3_sleepable_res = 0;
> +int uretprobe_byname3_str_sleepable_res = 0;
>   int uretprobe_byname3_res = 0;
>   void *user_ptr = 0;
> 
> +int bpf_copy_from_user_str(void *dst, u32, const void *) __weak __ksym;
> +
>   SEC("ksyscall/nanosleep")
>   int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __kernel_timespec *rem)
>   {
> @@ -87,11 +91,23 @@ static __always_inline bool verify_sleepable_user_copy(void)
>   	return bpf_strncmp(data, sizeof(data), "test_data") == 0;
>   }
> 
> +static __always_inline bool verify_sleepable_user_copy_str(void)
> +{
> +	int ret;
> +	char data[10];
> +
> +	ret = bpf_copy_from_user_str(data, sizeof(data), user_ptr);
> +
> +	return bpf_strncmp(data, sizeof(data), "test_data") == 0 && ret == 9;
> +}
> +
>   SEC("uprobe.s//proc/self/exe:trigger_func3")
>   int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
>   {
>   	if (verify_sleepable_user_copy())
>   		uprobe_byname3_sleepable_res = 9;
> +	if (verify_sleepable_user_copy_str())
> +		uprobe_byname3_str_sleepable_res = 10;
>   	return 0;
>   }
> 
> @@ -102,7 +118,7 @@ int handle_uprobe_byname3_sleepable(struct pt_regs *ctx)
>   SEC("uprobe//proc/self/exe:trigger_func3")
>   int handle_uprobe_byname3(struct pt_regs *ctx)
>   {
> -	uprobe_byname3_res = 10;
> +	uprobe_byname3_res = 11;
>   	return 0;
>   }
> 
> @@ -110,14 +126,16 @@ SEC("uretprobe.s//proc/self/exe:trigger_func3")
>   int handle_uretprobe_byname3_sleepable(struct pt_regs *ctx)
>   {
>   	if (verify_sleepable_user_copy())
> -		uretprobe_byname3_sleepable_res = 11;
> +		uretprobe_byname3_sleepable_res = 12;
> +	if (verify_sleepable_user_copy_str())
> +		uretprobe_byname3_str_sleepable_res = 13;
>   	return 0;
>   }
> 
>   SEC("uretprobe//proc/self/exe:trigger_func3")
>   int handle_uretprobe_byname3(struct pt_regs *ctx)
>   {
> -	uretprobe_byname3_res = 12;
> +	uretprobe_byname3_res = 14;
>   	return 0;
>   }
> 
> --
> 2.44.1
> 
> 

