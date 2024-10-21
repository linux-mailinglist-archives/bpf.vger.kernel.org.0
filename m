Return-Path: <bpf+bounces-42564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA39A5901
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 04:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76192280EF8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 02:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55F29408;
	Mon, 21 Oct 2024 02:45:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8A3D6D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478756; cv=none; b=ejE9TuRikJ30GE/q1KUVopcVWjaN38Q8ztS4VDGaRt45KLlRG2RKQ/aik9OmoEcj8Xj7z0pNhu4gQ4enPrwba6ZTB5FcnIqADbHfIyt021TnRs4XCfZg3f0NKbO+n+4cX9hrCVoFfMESnmtMHJAmErl8XGPfBpYj/VGhStFRVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478756; c=relaxed/simple;
	bh=j/4R+z59Un7xzP4jUxSNL0rdjeH5sdvpZybpiUVei2I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ClzvfWecC2JcOjXgUkUUTi4//QZuAw5V0gP6426G44YjtPjWw6IpjbCVIMZ112R/+89DHfN7fDFZ+F9vLe/O7mHdscq7ko7NtXnemZ2h6sU7yQ1iwQFMdFA9K+EkwXtfjTs77J1JvYmS+B2uhRenZYmhT9tfjM5MRXDQQI8ITns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XX06T5x6Jz4f3jkq
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:45:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 12CC81A018D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 10:45:50 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAHh1xawBVnoaanEg--.38353S2;
	Mon, 21 Oct 2024 10:45:49 +0800 (CST)
Subject: Re: [PATCH bpf v2 4/7] bpf: Free dynamically allocated bits in
 bpf_iter_bits_destroy()
To: bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Yafang Shao
 <laoar.shao@gmail.com>, xukuohai@huawei.com,
 "houtao1@huawei.com" <houtao1@huawei.com>
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-5-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <91affb00-82af-49ad-69bd-9c9ad57c9a9b@huaweicloud.com>
Date: Mon, 21 Oct 2024 10:45:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241021014004.1647816-5-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAHh1xawBVnoaanEg--.38353S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryfKw13JFy5tr4fXFWfAFb_yoWrJF1kpr
	4fXr1qkrWxJFn2yw1Utr1UWa4UJr4jka4UWF4rJFn8AF18WFyq9r1UWryag3Z8Kr48tF13
	Zw1qk34Fv3yUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/21/2024 9:40 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> bpf_iter_bits_destroy() uses "kit->nr_bits <= 64" to check whether the
> bits are dynamically allocated. However, the check is incorrect and may
> cause a kmemleak as shown below:
>
> unreferenced object 0xffff88812628c8c0 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294727320
>   hex dump (first 32 bytes):
> 	b0 c1 55 f5 81 88 ff ff f0 f0 f0 f0 f0 f0 f0 f0  ..U.............
> 	f0 f0 f0 f0 f0 f0 f0 f0 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 781e32cc):
> 	[<00000000c452b4ab>] kmemleak_alloc+0x4b/0x80
> 	[<0000000004e09f80>] __kmalloc_node_noprof+0x480/0x5c0
> 	[<00000000597124d6>] __alloc.isra.0+0x89/0xb0
> 	[<000000004ebfffcd>] alloc_bulk+0x2af/0x720
> 	[<00000000d9c10145>] prefill_mem_cache+0x7f/0xb0
> 	[<00000000ff9738ff>] bpf_mem_alloc_init+0x3e2/0x610
> 	[<000000008b616eac>] bpf_global_ma_init+0x19/0x30
> 	[<00000000fc473efc>] do_one_initcall+0xd3/0x3c0
> 	[<00000000ec81498c>] kernel_init_freeable+0x66a/0x940
> 	[<00000000b119f72f>] kernel_init+0x20/0x160
> 	[<00000000f11ac9a7>] ret_from_fork+0x3c/0x70
> 	[<0000000004671da4>] ret_from_fork_asm+0x1a/0x30
>
> That is because nr_bits will be set as zero in bpf_iter_bits_next()
> after all bits have been iterated.
>
> Fix the problem by not setting nr_bits to zero in bpf_iter_bits_next().
> Instead, use "bits >= nr_bits" to indicate when iteration is completed
> and still use "nr_bits > 64" to indicate when bits are dynamically
> allocated.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..62349e206a29 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2888,7 +2888,7 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ign, u32 nr_w
>  
>  	kit->nr_bits = 0;
>  	kit->bits_copy = 0;
> -	kit->bit = -1;
> +	kit->bit = 0;

Sent the patch out in a hurry and didn't run the related test.

The change above will break "fewer words" test in verifier_bits_iter,
because it will skip bit 0 in the bit. The correct fix should be as below:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..190b730e0f86 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct
bpf_iter_bits *it)
        const unsigned long *bits;
        int bit;

-       if (nr_bits == 0)
+       if (kit->bit >= 0 && kit->bit >= nr_bits)
                return NULL;

        bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
        bit = find_next_bit(bits, nr_bits, kit->bit + 1);
-       if (bit >= nr_bits) {
-               kit->nr_bits = 0;
+       if (bit >= nr_bits)
                return NULL;
-       }

        kit->bit = bit;
        return &kit->bit;

>  
>  	if (!unsafe_ptr__ign || !nr_words)
>  		return -EINVAL;
> @@ -2934,15 +2934,13 @@ __bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
>  	const unsigned long *bits;
>  	int bit;
>  
> -	if (nr_bits == 0)
> +	if (kit->bit >= nr_bits)
>  		return NULL;
>  
>  	bits = nr_bits == 64 ? &kit->bits_copy : kit->bits;
>  	bit = find_next_bit(bits, nr_bits, kit->bit + 1);
> -	if (bit >= nr_bits) {
> -		kit->nr_bits = 0;
> +	if (bit >= nr_bits)
>  		return NULL;
> -	}
>  
>  	kit->bit = bit;
>  	return &kit->bit;


