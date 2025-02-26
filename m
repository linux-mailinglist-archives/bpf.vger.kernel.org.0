Return-Path: <bpf+bounces-52604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2DAA452FA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1D189A2AA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 02:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FB1218E8C;
	Wed, 26 Feb 2025 02:19:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBA383
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 02:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536388; cv=none; b=ngPfizxPZ0gWyBbQOeNhxAvk/eUdWGszJPprCNydIJlJp+xOa7o8+BPkNyZUoZOSO5XE2WEm4nOUx/AA/IlH7kPNc88+kiasGdy5RK/bBVgLlELpEvOloWfG43GORaBKK1ohcvMsPVcx3Kc22R3ziMl05idr2/yw7hrMAmamfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536388; c=relaxed/simple;
	bh=YW8dP4LFqcGvq4Ial1Lf3MkK0p8d9iuYzFqNz1vpeGI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Zvz5qwfEqhDWwaeCIxvBYEUjFtft8kLDAK1d7J8hLfTghwDIZAUzJnRAAYD8W3lJO6ZvWH7CmHlL8SCdnuTEGIOwSpLBDNIOnlt8iPllIpB7EKbX8tV6HAI6hPBP5DUsLNfYPKOOL5K4j8mvPXIsl2Ov9STqTttsVjvUJGtvM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z2dT32yw4z4f3jt9
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:19:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E4FA61A058E
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:19:35 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgBnu8U0er5nTZZlEw--.54428S2;
	Wed, 26 Feb 2025 10:19:35 +0800 (CST)
Subject: Re: [RESEND PATCH bpf-next v2 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, qmo@kernel.org,
 dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250213161931.46399-1-leon.hwang@linux.dev>
 <20250213161931.46399-2-leon.hwang@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <913e4bbd-473e-9118-03bd-992ba737032d@huaweicloud.com>
Date: Wed, 26 Feb 2025 10:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250213161931.46399-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgBnu8U0er5nTZZlEw--.54428S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWfGrWDXr1Uury7Xr13Jwb_yoW5Kw47pF
	48GFsxCrs8XFy2g3Z2g3WDCFyjvr1kt3yxJw10y34jvF12gwn2gr18u3W7Ar9Ikrnaqw40
	qrsrXFWxtayUJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2/14/2025 12:19 AM, Leon Hwang wrote:
> This patch introduces global percpu data, inspired by commit
> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> definition of global percpu variables in BPF, similar to the
> DEFINE_PER_CPU() macro in the kernel[0].
>
> For example, in BPF, it is able to define a global percpu variable like:
>
> int data SEC(".percpu");
>
> With this patch, tools like retsnoop[1] and bpflbr[2] can simplify their
> BPF code for handling LBRs. The code can be updated from
>
> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs");
>
> to
>
> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".percpu.lbrs");
>
> This eliminates the need to retrieve the CPU ID using the
> bpf_get_smp_processor_id() helper.
>
> Additionally, by reusing global percpu data map, sharing information
> between tail callers and callees or freplace callers and callees becomes
> simpler compared to reusing percpu_array maps.
>
> Links:
> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe90be28c5a3/include/linux/percpu-defs.h#L114
> [1] https://github.com/anakryiko/retsnoop
> [2] https://github.com/Asphaltt/bpflbr
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

SNIP
> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops = {
>  	.map_get_next_key = array_map_get_next_key,
>  	.map_lookup_elem = percpu_array_map_lookup_elem,
>  	.map_gen_lookup = percpu_array_map_gen_lookup,
> +	.map_direct_value_addr = percpu_array_map_direct_value_addr,
> +	.map_direct_value_meta = percpu_array_map_direct_value_meta,
>  	.map_update_elem = array_map_update_elem,
>  	.map_delete_elem = array_map_delete_elem,
>  	.map_lookup_percpu_elem = percpu_array_map_lookup_percpu_elem,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5d..5682546b1193e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>  	u64 addr;
>  	int err;
>  
> +	if (map->map_type != BPF_MAP_TYPE_ARRAY)
> +		return -EINVAL;

Is the check still necessary ? Because its caller has already added the
check of map_type.
>  	err = map->ops->map_direct_value_addr(map, &addr, off);
>  	if (err)
>  		return err;
> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  			/* if map is read-only, track its contents as scalars */
>  			if (tnum_is_const(reg->var_off) &&
>  			    bpf_map_is_rdonly(map) &&
> +			    map->map_type == BPF_MAP_TYPE_ARRAY &&
>  			    map->ops->map_direct_value_addr) {
>  				int map_off = off + reg->var_off.value;
>  				u64 val = 0;

Do we also need to check in check_ld_imm() to ensure the dst_reg of
bpf_ld_imm64 on a per-cpu array will not be treated as a map-value-ptr ?
> @@ -9128,6 +9131,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
>  		return -EACCES;
>  	}
>  
> +	if (map->map_type != BPF_MAP_TYPE_ARRAY) {
> +		verbose(env, "only array map supports direct string value access\n");
> +		return -EINVAL;
> +	}
> +
>  	err = check_map_access(env, regno, reg->off,
>  			       map->value_size - reg->off, false,
>  			       ACCESS_HELPER);
> @@ -10802,6 +10810,11 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
>  		return -EINVAL;
>  	num_args = data_len_reg->var_off.value / 8;
>  
> +	if (fmt_map->map_type != BPF_MAP_TYPE_ARRAY) {
> +		verbose(env, "only array map supports snprintf\n");
> +		return -EINVAL;
> +	}
> +
>  	


