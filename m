Return-Path: <bpf+bounces-34895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DA9320E1
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BCF1C21554
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34265224D4;
	Tue, 16 Jul 2024 07:05:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6D1D68F;
	Tue, 16 Jul 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721113527; cv=none; b=Rbujgz6cQe7KJqEuAkyBeUMqClmxt/foHgTOdwKGtVyzkOtaplgW0YYGfc4Cu7CSL0r8BBFoi+6Q6Dh2bSFkAEBRvfgDmnqJv/pXDBNDPKX2JIdyU2Ezu6Sb9aloCsnYWtA9NkkjMA1LG6rR3mGOilqYzak29cy8eOcA8PDCyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721113527; c=relaxed/simple;
	bh=23q6PfsYT5ZP0HjZM9tdtTlVLLdS13Xt8ckf5CH06wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WozRJ3XsBDSrHi/g9v3XJThu3yy26Q0+hBP52m1GbhH8GGiobqoN6g/0yoEUmFRpgNdE9n+64B+5LH4+inuzQTmZNoxmuGTFNt8DRhOzGyoLESTXH8IcBuFSUD4HlNDx5TDBog5t4wr+xIRUsRorNueUhjnXarBuOHuAh8i5PJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WNVSg02fqz4f3jZ8;
	Tue, 16 Jul 2024 15:05:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E62481A0568;
	Tue, 16 Jul 2024 15:05:14 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgDX5VCnG5ZmewgPAQ--.64133S2;
	Tue, 16 Jul 2024 15:05:12 +0800 (CST)
Message-ID: <4ff2c89e-0afc-4b17-a86b-7e4971e7df5b@huaweicloud.com>
Date: Tue, 16 Jul 2024 15:05:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 16/20] bpf: Add a special case for bitwise AND
 on range [-1, 0]
Content-Language: en-US
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
 Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>,
 Matan Shachnai <m.shachnai@rutgers.edu>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
 <20240711113828.3818398-4-xukuohai@huaweicloud.com>
 <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDX5VCnG5ZmewgPAQ--.64133S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryrKF1xtFWxurW3WrWUXFb_yoWfWrWkpr
	Z5WFnIkF4kuay8uas2vw1DJFZ2qF18Aw48JryDAry0vr1agFyFyr17Gr45AasxCr4kXr4I
	qFs2g3yUCF4jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 7/15/2024 11:29 PM, Shung-Hsi Yu wrote:
> Cc Harishankar Vishwanathan, Prof. Srinivas Narayana and Prof. Santosh
> Nagarakatte, and Matan Shachnai, whom have recently work on
> scalar*_min_max_and(); also dropping LSM/FS related mails from Cc since
> it's a bit long and I'm not sure whether the mailing list will reject
> due to too many email in Cc.
> 
> On Thu, Jul 11, 2024 at 07:38:24PM GMT, Xu Kuohai wrote:
>> With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
>> is rejected by the verifier, and the log says:
>>
>> 0: R1=ctx() R10=fp0
>> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>> 0: (b7) r0 = 0                        ; R0_w=0
>> 1: (79) r2 = *(u64 *)(r1 +0)
>> func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
>> 2: R1=ctx() R2_w=trusted_ptr_bpf_map()
>> ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
>> 2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
>> 4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
>> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>> 5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
>> ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
>> 6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
>> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>> ;  @ test_libbpf_get_fd_by_id_opts.c:0
>> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>> ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
>> 9: (95) exit
>>
>> And here is the C code of the prog.
>>
>> SEC("lsm/bpf_map")
>> int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
>> {
>>      if (map != (struct bpf_map *)&data_input)
>> 	    return 0;
>>
>>      if (fmode & FMODE_WRITE)
>> 	    return -EACCES;
>>
>>      return 0;
>> }
>>
>> It is clear that the prog can only return either 0 or -EACCESS, and both
>> values are legal.
>>
>> So why is it rejected by the verifier?
>>
>> The verifier log shows that the second if and return value setting
>> statements in the prog is optimized to bitwise operations "r0 s>>= 63"
>> and "r0 &= -13". The verifier correctly deduces that the value of
>> r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
>> But when the verifier proceeds to verify instruction "r0 &= -13", it
>> fails to deduce the correct value range of r0.
>>
>> 7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
>> 8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
>>
>> So why the verifier fails to deduce the result of 'r0 &= -13'?
>>
>> The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
>> "[0, -1ULL]" are encoded to the same tnum. When verifing instruction
>> "r0 &= -13", the verifier erroneously deduces the result from
>> "[0, -1ULL] AND -13", which is out of the expected return range
>> [-4095, 0].
>>
>> As explained by Eduard in [0], the clang transformation that generates this
>> pattern is located in DAGCombiner::SimplifySelectCC() method (see [1]).
> ...
>> As suggested by Eduard and Andrii, this patch makes a special case
>> for source or destination register of '&=' operation being in
>> range [-1, 0].
> ...
> 
> Been wonder whether it possible for a more general approach ever since I
> saw the discussion back in April. I think I've finally got something.
> 
> The problem we face here is that the tightest bound for the [-1, 0] case
> was tracked with signed ranges, yet the BPF verifier looses knowledge of
> them all too quickly in scalar*_min_max_and(); knowledge of previous
> signed ranges were not used at all to derive the outcome of signed
> ranges after BPF_AND.
> 
> 	static void scalar_min_max_and(...) {
> 		...
> 		if ((s64)dst_reg->umin_value <= (s64)dst_reg->umax_value) {
> 			dst_reg->smin_value = dst_reg->umin_value;
> 			dst_reg->smax_value = dst_reg->umax_value;
> 		} else {
> 			dst_reg->smin_value = S64_MIN;
> 			dst_reg->smax_value = S64_MAX;
> 		}
> 		...
> 	}
>

This is indeed the root cause.

> So looks like its time to be nobody[1] and try to teach BPF verifier how
> track signed ranges when ANDing two (possibly) negative numbers. Luckily
> bitwise AND is comparatively easier to do than other bitwise operations:
> non-negative range & non-negative range is always non-negative,
> non-negative range & negative range is still always non-negative, and
> negative range & negative range is always negative.
>

Right, only bitwise ANDing two negatives yields to a negative result.

> smax_value is straight forwards, we can just do
> 
> 	max(dst_reg->smax_value, src_reg->smax_value)
> 
> which works across all sign combinations. Technically for non-negative &
> non-negative we can use min() instead of max(), but the non-negative &
> non-negative case should be handled pretty well by the unsigned ranges
> already; it seems simpler to let such knowledge flows from unsigned
> ranges to signed ranges during reg_bounds_sync(). Plus we are not wrong
> for non-negative & non-negative by using max(), just imprecise, so no
> correctness/soundness issue here.
>

I think this is correct, since in two's complement, more '1' bits means
more large, regardless of sign, and bitwise AND never generates more '1'
bits.

> smin_value is the tricker one, but doable with
> 
> 	masked_negative(min(dst_reg->smin_value, src_reg->smin_value))
> 
> where masked_negative(v) basically just clear all bits after the most
> significant unset bit, effectively rounding a negative value down to a
> negative power-of-2 value, and returning 0 for non-negative values. E.g.
> for some 8-bit, negative value
> 
> 	masked_negative(0b11101001) == 0b11100000
>

Ah, it's really tricky. Seems it's the longest high '1' bits sequence
in both operands. This '1' bits should remain unchanged by the bitwise
AND operation. So this sequence must be in the result, making it the
minimum possible value.

> This can be done with a tweaked version of "Round up to the next highest
> power of 2"[2],
> 
> 	/* Invert the bits so the first unset bit can be propagated with |= */
> 	v = ~v;
> 	/* Now propagate the first (previously unset, now set) bit to the
> 	 * trailing positions */
> 	v |= v >> 1;
> 	v |= v >> 2;
> 	v |= v >> 4;
> 	...
> 	v |= v >> 32; /* Assuming 64-bit */
> 	/* Propagation done, now invert again */
> 	v = ~v;
>
> Again, we technically can do better if we take sign bit into account,
> but deriving smin_value this way should still be correct/sound across
> different sign combinations, and overall should help us derived [-16, 0]
> from "[-1, 0] AND -13", thus preventing BPF verifier from rejecting the
> program.
>
> ---
> 
> Alternatively we can employ a range-splitting trick (think I saw this in
> [3]) that allow us to take advantage of existing tnum_and() by splitting
> the signed ranges into two if the range crosses the sign boundary (i.e.
> contains both non-negative and negative values), one range will be
> [smin, U64_MAX], the other will be [0, smax]. This way we get around
> tnum's weakness of representing [-1, 0] as [0, U64_MAX].
> 
> 	if (src_reg->smin_value < 0 && src_reg->smax_value >= 0) {
> 		src_lower = tnum_range(src_reg->smin_value, U64_MAX);
> 		src_higher = tnum_range(0, src_reg->smax_value);
> 	} else {
> 		src_lower = tnum_range(src_reg->smin_value, src_reg->smax_value);
> 		src_higher = tnum_range(src_reg->smin_value, src_reg->smax_value);
> 	}
> 
> 	if (dst_reg->smin_value < 0 && dst_reg->smax_value >= 0) {
> 		dst_lower = tnum_range(dst_reg->smin_value, U64_MAX);
> 		dst_higher = tnum_range(0, dst_reg->smax_value);
> 	} else {
> 		dst_lower = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
> 		dst_higher = tnum_range(dst_reg->smin_value, dst_reg->smax_value);
> 	}
> 
> 	lower = tnum_and(src_lower, dst_lower);
> 	higher = tnum_and(src_higher, dst_higher);
> 	dst->smin_value = lower.value;
> 	dst->smax_value = higher.value | higher.mask;
>

This looks even more tricky...

> ---
> 
> Personally I like the first method better as it is simpler yet still
> does the job well enough. I'll work on that in the next few days and see
> if it actually works.
> 

This really sounds great. Thank you for the excellent work!

> 
> 1: https://github.com/torvalds/linux/blob/dac045fc9fa6/kernel/bpf/verifier.c#L13338
> 2: https://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
> 3: https://dl.acm.org/doi/10.1145/2651360
> 
> ...


