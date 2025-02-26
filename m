Return-Path: <bpf+bounces-52650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B80A463D0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EE0179C6A
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144DB221739;
	Wed, 26 Feb 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qg8zgRxZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDC21E0AF
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581676; cv=none; b=d2mOFSzZ3agw/RZWViIXUJRPiC4l/Uy+qBYaNajqqdOuUQJnqyVgFLbebPUrdqzVc6rjuUK8wCNwzd/ZBMhcz5d8RiN/XjkPTGHCoPkNZUHcAVB0sYsnnN0ef15AqPo2JUPFC7yCCuCM7Vabx6IsWo4wsJ3fAvCb3m2kIYCMAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581676; c=relaxed/simple;
	bh=lO0j4BDeRjb8wOkqrisZQtSBzWEi0HRECEUx+8fHHCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QttNIFujUyepR8fnBV1ofZKh/Uwki3O2oeOXsrcS6NHbOQoMBHOuPdDnnDWcN2PJ6e6qv3gk64eDePODq7SImx1ZIfHz3e+yVGXoykrnUIRdOE84p8cAR6Cop6AnHwJUUhrLTF1buOQDWZvgrACYlMjRoSe/ae3GhIOtvfVv7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qg8zgRxZ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740581672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IfO6w4CUldyAOm4FzuJSOg9YhHsgcgjWNXnBas4Y6Yw=;
	b=qg8zgRxZCuD1QtgIMrQtFOytE5M9YHw16ahZdfO4FDLCKq9YwdF9JKxPzoEw/3vTRbsLkv
	xa+pequqlG0Dix5i4F/Lro+9q796Atv9DIlY8Q+/umqU3UdoVU/73gygTeH/r+bTFcNDzr
	qppdEIXE0/oLN4JrK2YZvkIzMEkFMfg=
Date: Wed, 26 Feb 2025 22:54:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
 <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/26 10:19, Hou Tao wrote:
> Hi,
> 

[...]

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
> 
> Is the check still necessary ? Because its caller has already added the
> check of map_type.

Yes. It should check here in order to make sure the code logic in
bpf_map_direct_read() is robust enough.

But in check_mem_access(), if map is a read-only percpu array map, it
should not track its contents as SCALAR_VALUE, because the read-only
.percpu, named .ropercpu, hasn't been supported yet.

Should we implement .ropercpu in this patch set, too?

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
> 
> Do we also need to check in check_ld_imm() to ensure the dst_reg of
> bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr ?
No. The dst_reg of ld_imm64 for percpu array map must be treated as
map-value-ptr, just like the one for array map.

Global percpu variable is very similar to global variable.

From the point of compiler, global percpu variable is global variable
with SEC(".percpu").

Then libbpf converts global data with SEC(".percpu") to global percpu
data. And bpftool generates struct for global percpu data like for
global data when generate skeleton.

Finally, verifier inserts a mov64_percpu_reg insn after the ld_imm64 in
order to add this_cpu_off to the dst_reg of ld_imm64.

Therefore, in check_ld_imm(), it should mark the dst_reg of ld_imm64 for
percpu array map as map-value-ptr.

Thanks,
Leon


