Return-Path: <bpf+bounces-52712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A6A47202
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 03:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0872A1886B33
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32015E5DC;
	Thu, 27 Feb 2025 02:13:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2915687D
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622430; cv=none; b=VaJ76G0uQPMSOpWNXbIyL0sEQpEjG8LO0NmpV0k8IvOiQm9rivraL4TucVAjuEEG6pgIEYmwMYIrbvC2SjV8V0/n9vwN67qyLJsU5WqfS0qcbCNoXhyhTvmajJyv6O0wMnGtCAYcmMlXs3DNcpZMAbFuFn3Fr1qqPhqk/iNiSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622430; c=relaxed/simple;
	bh=zRiYhyMQQecuWD3eeo6rWYGDftDNj5ASFSPPlbEqyzc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UqWa3JujHeN2KxiPJt5+UDM7q9W9Hv3W3jjE55hhS1Z6/sjBa/iAxP8m/XsIsj1k1iM925vjsbRL5+PITWY6KD+f4mHTf6Yq+4frfA+CBcdOTTBQ4wwLBYQu9OAYkTqflDRcp6rLg1qGDcuGpZ0hQ+CPowXnJI1rGShP46TawFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z3FHg0101z4f3lgB
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 10:13:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5100C1A1F24
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 10:13:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgB3ycPByb9nLiHFEw--.140S2;
	Thu, 27 Feb 2025 10:11:17 +0800 (CST)
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
 <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
 <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <a37ee76f-77da-e08b-de5d-b1afdb4cf1cc@huaweicloud.com>
Date: Thu, 27 Feb 2025 10:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b49cbd71-6b2d-4c83-be5d-4fc56fdb3447@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgB3ycPByb9nLiHFEw--.140S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4fWFW7CryDKF45GFy8Xwb_yoW5Zrykpr
	W8JFsxCrWvvFW3u3sFv3ZrCry0q34rJ3yxAwn0y34Yyr97WrnrJrWUG3WUAF1a9rnIqw40
	q3yDZayIvayUtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/26/2025 10:54 PM, Leon Hwang wrote:
>
> On 2025/2/26 10:19, Hou Tao wrote:
>> Hi,
>>
> [...]
>
>>> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>>>  	.map_get_next_key = array_map_get_next_key,
>>>  	.map_lookup_elem = percpu_array_map_lookup_elem,
>>>  	.map_gen_lookup = percpu_array_map_gen_lookup,
>>> +	.map_direct_value_addr = percpu_array_map_direct_value_addr,
>>> +	.map_direct_value_meta = percpu_array_map_direct_value_meta,
>>>  	.map_update_elem = array_map_update_elem,
>>>  	.map_delete_elem = array_map_delete_elem,
>>>  	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 9971c03adfd5d..5682546b1193e 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>>  	u64 addr;
>>>  	int err;
>>>  
>>> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
>>> +		return -EINVAL;
>> Is the check still necessary ? Because its caller has already added the
>> check of map_type.
> Yes. It should check here in order to make sure the code logic in
> bpf_map_direct_read() is robust enough.

Er, I see. In my opinion, checking map_type == BPF_MAP_TYPE_ARRAY twice
(one in its only caller and one in itself) is a bit weird.
>
> But in check_mem_access(), if map is a read-only percpu array map, it
> should not track its contents as SCALAR_VALUE, because the read-only
> .percpu, named .ropercpu, hasn't been supported yet.
>
> Should we implement .ropercpu in this patch set, too?
>
>>>  	err = map->ops->map_direct_value_addr(map, &addr, off);
>>>  	if (err)
>>>  		return err;
>>> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>>>  			/* if map is read-only, track its contents as scalars */
>>>  			if (tnum_is_const(reg->var_off) &&
>>>  			    bpf_map_is_rdonly(map) &&
>>> +			    map->map_type == BPF_MAP_TYPE_ARRAY &&
>>>  			    map->ops->map_direct_value_addr) {
>>>  				int map_off = off + reg->var_off.value;
>>>  				u64 val = 0;
>> Do we also need to check in check_ld_imm() to ensure the dst_reg of
>> bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr ?
> No. The dst_reg of ld_imm64 for percpu array map must be treated as
> map-value-ptr, just like the one for array map.
>
> Global percpu variable is very similar to global variable.
>
> >From the point of compiler, global percpu variable is global variable
> with SEC(".percpu").
>
> Then libbpf converts global data with SEC(".percpu") to global percpu
> data. And bpftool generates struct for global percpu data like for
> global data when generate skeleton.
>
> Finally, verifier inserts a mov64_percpu_reg insn after the ld_imm64 in
> order to add this_cpu_off to the dst_reg of ld_imm64.
>
> Therefore, in check_ld_imm(), it should mark the dst_reg of ld_imm64 for
> percpu array map as map-value-ptr.

Thanks for the explanation. I mis-understood the code and my original
though was it was only trying to read somthing from the per-cpu array
map value.
>
> Thanks,
> Leon


