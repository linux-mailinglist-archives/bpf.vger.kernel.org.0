Return-Path: <bpf+bounces-52614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736F6A4548D
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 05:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB873AA9FB
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B542625A645;
	Wed, 26 Feb 2025 04:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DF15098A
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543997; cv=none; b=hzh+KowU7I7EUsj4PeQtqr1vHGS0pjaFZ5iJKQtrKo8DftoyXGXWdejsmzTr7/dzfSjZxTAYa3cmrw40ar2NmsahWZkkitpIbG0clU+PKWVVtwHE53gP0PlXbEq2cvogb3BROsbj7sIRQk5Q4uRth8HT7ldhyAFd4CJ9CnLprS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543997; c=relaxed/simple;
	bh=PXZs5tc+y8Si8b6DYEEYSUeoui1CZAisGhkXV9TQsNY=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=THK2fIZzLq85cKaY4XrslQYxu12u+64li4vlrBdw51DeqsZiTzUkvgFWfAyAk8KTwlg5GGlyXvrHD0Lypc1wjVaDSiZg2JLrltURDHE7A7j2a262my6Gu7mYIdyT4OrsZ/+hYfJTRkZH42I2IknsOoeiquroQwS1b+mFwB3nTBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2hHL74JBz4f3kvl
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 12:26:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 447311A108F
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 12:26:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAn2Hj0l75nvWJvEw--.61229S2;
	Wed, 26 Feb 2025 12:26:30 +0800 (CST)
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
From: Hou Tao <houtao@huaweicloud.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
 <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
Message-ID: <5141034e-6e23-11d5-ab1b-490ef9e7ab76@huaweicloud.com>
Date: Wed, 26 Feb 2025 12:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAn2Hj0l75nvWJvEw--.61229S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8Xr18JF1xAr4rAw13Jwb_yoWrXw43pF
	W8GFsxCrWkXFy29wn2g3Z8Aa4jvr15trWxJw40ya4YvF1DWwn2gr48u3WUCF9IkrnIgw40
	qrsrZayIg3y8JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/26/2025 10:19 AM, Hou Tao wrote:
> Hi,
>
> On 2/14/2025 12:19 AM, Leon Hwang wrote:
>> This patch introduces global percpu data, inspired by commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
>> definition of global percpu variables in BPF, similar to the
>> DEFINE_PER_CPU() macro in the kernel[0].
>>
>> For example, in BPF, it is able to define a global percpu variable like:
>>
>> int data SEC(".percpu");
>>
>> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
>> BPF code for handling LBRs. The code can be updated from
>>
>> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");
>>
>> to
>>
>> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs");
>>
>> This eliminates the need to retrieve the CPU ID using the
>> bpf_get_smp_processor_id() helper.
>>
>> Additionally, by reusing global percpu data map, sharing information
>> between tail callers and callees or freplace callers and callees becomes
>> simpler compared to reusing percpu_array maps.
>>
>> Links:
>> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
>> [1] https://github.com/anakryiko/retsnoop
>> [2] https://github.com/Asphaltt/bpflbr
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
> SNIP
>> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>>  	.map_get_next_key = array_map_get_next_key,
>>  	.map_lookup_elem = percpu_array_map_lookup_elem,
>>  	.map_gen_lookup = percpu_array_map_gen_lookup,
>> +	.map_direct_value_addr = percpu_array_map_direct_value_addr,
>> +	.map_direct_value_meta = percpu_array_map_direct_value_meta,
>>  	.map_update_elem = array_map_update_elem,
>>  	.map_delete_elem = array_map_delete_elem,
>>  	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9971c03adfd5d..5682546b1193e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>  	u64 addr;
>>  	int err;
>>  
>> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
>> +		return -EINVAL;
> Is the check still necessary ? Because its caller has already added the
> check of map_type.
>>  	err = map->ops->map_direct_value_addr(map, &addr, off);
>>  	if (err)
>>  		return err;
>> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>>  			/* if map is read-only, track its contents as scalars */
>>  			if (tnum_is_const(reg->var_off) &&
>>  			    bpf_map_is_rdonly(map) &&
>> +			    map->map_type == BPF_MAP_TYPE_ARRAY &&
>>  			    map->ops->map_direct_value_addr) {
>>  				int map_off = off + reg->var_off.value;
>>  				u64 val = 0;
> Do we also need to check in check_ld_imm() to ensure the dst_reg of
> bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr ?

Just find out that if the check in check_ld_imm() is added, these
map_type checking added in multiple functions will be unnecessary,
because all of these functions needs the register to be a map-value-ptr.
>> @@ -9128,6 +9131,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
>>  		return -EACCES;
>>  	}
>>  
>> +	if (map->map_type != BPF_MAP_TYPE_ARRAY) {
>> +		verbose(env, "only array map supports direct string value access\n");
>> +		return -EINVAL;
>> +	}
>> +
>>  	err = check_map_access(env, regno, reg->off,
>>  			       map->value_size - reg->off, false,
>>  			       ACCESS_HELPER);
>> @@ -10802,6 +10810,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
>>  		return -EINVAL;
>>  	num_args = data_len_reg->var_off.value / 8;
>>  
>> +	if (fmt_map->map_type != BPF_MAP_TYPE_ARRAY) {
>> +		verbose(env, "only array map supports snprintf\n");
>> +		return -EINVAL;
>> +	}
>> +
>>  	
>
> .


