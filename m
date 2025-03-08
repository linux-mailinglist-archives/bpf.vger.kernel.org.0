Return-Path: <bpf+bounces-53631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE4A5774C
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 02:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F7172824
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 01:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE40D82D98;
	Sat,  8 Mar 2025 01:34:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3E78F43
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397654; cv=none; b=PtnOnPeeO4IjK0dzPtucxyvvdMCD0aIFKFdNUhihfYSj6P0U0HjxhNcVitMhdxYfzDKjtx27T6sMJhdKKgYDSr3j4fJWCvFWmjShotbDdX+kxrGYU3QgmZF9UROqB2o46sBwSc8UckBJDmJE4zlj6oywQWLVRqZLtRppjZmE/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397654; c=relaxed/simple;
	bh=VlGqM6P2D2Z6LCwS6cDpcjdGa3EoQRaEBtOb0XQj61w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T+8AkkVt3oYmQj678R/e4Id/TLeh+zqnI1OQbTEIXJmVAVBvTFNEFIqVLRp9vWavElp731cPCvpg0t+r+W2MaUplTzOBNsr1+PudxbjbdQ82pcs0tmO8KcyUbFhy4TqlkpD/CtEmnv3JtBrJQYsZ+AdbxKkyJBrcHdEKFcoJnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z8lzs0Xx1z4f3khY
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 09:33:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4B33C1A018D
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 09:34:07 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDXPH2LnstnLUQdFw--.9323S2;
	Sat, 08 Mar 2025 09:34:07 +0800 (CST)
Subject: Re: [PATCH v6 4/4] selftests: bpf: add missing test to runner
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 tj@kernel.org, memxor@gmail.com
References: <20250307153847.8530-1-emil@etsalapatis.com>
 <20250307153847.8530-5-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <4f5a1058-694e-d59e-db3b-010884b1bb48@huaweicloud.com>
Date: Sat, 8 Mar 2025 09:34:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307153847.8530-5-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDXPH2LnstnLUQdFw--.9323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyfZFW5tr1kAF4kKFWrGrg_yoW8XFy7pr
	95J3yjkFWxJF1fJ3WUJ3yxWFy093WkAFZYkw1UKry3Zr9xJa4IqF42gayUXwn5CrZYvr1F
	v3yq9rn5Wa1UA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 3/7/2025 11:38 PM, Emil Tsalapatis wrote:
> BPF cpumask selftests need to be added to bpf/prog_tests/cpumask.c to be
> run. However, the test_refcount_null_tracking is missing from the main
> test file. Add the missing test name to properly trigger the selftest.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/cpumask.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> index 9b09beba988b..447a6e362fcd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
> @@ -25,6 +25,7 @@ static const char * const cpumask_success_testcases[] = {
>  	"test_global_mask_nested_deep_rcu",
>  	"test_global_mask_nested_deep_array_rcu",
>  	"test_cpumask_weight",
> +	"test_refcount_null_tracking",
>  	"test_populate_reject_small_mask",
>  	"test_populate_reject_unaligned",
>  	"test_populate",

Just find out that the invocation of RUN_TESTS(cpumask_success) will
lead to the double test result output for every program in the
cpumask_success.c. Considering we have test the loading of
test_refcount_null_tracking program through cpumask_success_testcases.
It would be better to remove the __success annotation for
test_refcount_null_tracking and the invocation of
RUN_TESTS(cpumask_success) as well.


