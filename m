Return-Path: <bpf+bounces-50752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F5A2BFB7
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26B13AB8AA
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C481DE3A5;
	Fri,  7 Feb 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhv6zUFD"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CE1A2381
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921371; cv=none; b=rcMgJz8zoSc5U7XrOnMyYzlkQqB7nIbEb1su9InibWyXVsdVgRYJokQhr3kPkW3yx/bBdbOgphNCTTQ8R0ZnaKZHbemtNd5tPKjungNtdf3ESeE0tgeqJae5hhHadDAYQrOT9ULhKyDEZz6RsUF8MANvP5ZB0kYd/iePXKVb0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921371; c=relaxed/simple;
	bh=vJ5gA+O0iLWDY/HxRcoKRx5+QJ7+bedmEcsvOYiYrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X384PFoyFbcRHqkBatAYTGmB/H/Tj8c5xtvaj09ZkLT2d0SKzQV7r5EJMMIRCttqHy2tId5fwsTHr2+8gVfX+4QSjzCdmSMHVR4aqvgtnthE+wP7VAt5Vxp4LrQeAERhxgOwzi4IiXygP6Jgt5vvMFX5A21ssx8MeLrVcvxrFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhv6zUFD; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f0c84bc-8227-4c10-a8c6-903c725473b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738921361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLN0JQhWk767JcA/EQ77dd5xGo8W1VqFsJB0iCI7+ns=;
	b=vhv6zUFDV7l2iJa2UG7Q5XajTYjF3SARuRLJDwstOFYTb/BI/1doDdPCoXgFX2Oz7EWAvE
	b8l8EulSB/3F3t89fhF0q0re+0KzrhEyslyf89uzzOdzsnrhToqsxhZQemwZQQYKTfJouu
	hbs77q53co+92WRmb0wWceyCVfncMPI=
Date: Fri, 7 Feb 2025 17:42:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] bpf: Introduce global percpu data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
References: <20250127162158.84906-1-leon.hwang@linux.dev>
 <20250127162158.84906-2-leon.hwang@linux.dev>
 <CAEf4BzaWjg50fXo=dC2sDpKfkdY-3A_DmSjwjJufU2yg=pw3cQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaWjg50fXo=dC2sDpKfkdY-3A_DmSjwjJufU2yg=pw3cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/25 08:09, Andrii Nakryiko wrote:
> On Mon, Jan 27, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch introduces global percpu data, inspired by commit
>> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
>> definition of global percpu variables in BPF, similar to the
>> DEFINE_PER_CPU() macro in the kernel[0].
>>
>> For example, in BPF, it is able to define a global percpu variable like
>> this:
>>
>> int percpu_data SEC(".percpu");
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
>>  kernel/bpf/arraymap.c | 39 ++++++++++++++++++++++++++++++++++++-
>>  kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 83 insertions(+), 1 deletion(-)
>>
> 
> [...]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 9971c03adfd5d..9d99497c2b94c 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6810,6 +6810,8 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>         u64 addr;
>>         int err;
>>
>> +       if (map->map_type != BPF_MAP_TYPE_ARRAY)
>> +               return -EINVAL;
>>         err = map->ops->map_direct_value_addr(map, &addr, off);
>>         if (err)
>>                 return err;
>> @@ -7322,6 +7324,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>>                         /* if map is read-only, track its contents as scalars */
>>                         if (tnum_is_const(reg->var_off) &&
>>                             bpf_map_is_rdonly(map) &&
>> +                           map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
> 
> shouldn't this rather be a safer `map->map_type == BPF_MAP_TYPE_ARRAY` check?
> 

Ack. I will update it to `map->map_type == BPF_MAP_TYPE_ARRAY`.

Thanks,
Leon

>>                             map->ops->map_direct_value_addr) {
>>                                 int map_off = off + reg->var_off.value;
>>                                 u64 val = 0;
> 
> [...]


