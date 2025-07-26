Return-Path: <bpf+bounces-64429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A715CB12851
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0F7B87CA
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 00:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7131953BB;
	Sat, 26 Jul 2025 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFPTZ8cV"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA002E3719
	for <bpf@vger.kernel.org>; Sat, 26 Jul 2025 00:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491554; cv=none; b=ICFNxroNCGUEW1cJZXIJRKgIzN22IpNFLmxlIBzvHYBdLIhezKkW3s/chXK2+d2dz61SEblGnM3FxahSwWx6MVbeWWp3lm8Tdf464HMTTs9nnu7I3GX0w+q96UCQ7adPsMeUJoXPlkM7bDYNADve2y+BcwDXQhJuBLh9h1SzOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491554; c=relaxed/simple;
	bh=/304ZqCxzcxRut5ErJY27/sZP9V5rkFUTGoWggm9l5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jwswnj89Cg9bPj4+VGMgFYE3UjI91nYwnCoEx3ZObtQxy66mj2kbFyCq9owkrePPeTcgrD5oBoORQ5Pz7Wh+lWtK86Ag2IrJJWdNmFCbnyKTZvSBZgzf+ZCu84PCOBJNPKu+jylRsmTyMnFYCKbzMUUQr2f6pywI7SqRM9hywT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFPTZ8cV; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74ad40ee-1a78-4a0d-8408-ff22defb632b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753491549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0YBMaHM1Bq3Yjp6c9EiZ6GLkJ+laiQcd9JK1GR8+5E=;
	b=JFPTZ8cVh0TH/wwNYIf9rznunkTcL+j1hHdZHQivzJSHzYNNu5zHp852FktT/fAbTfNBX/
	cZ+7jTTzVtgVVJgDluJ376tvqaHn5fdF/tqJpN1QrHKNt5Wk3oajwiBo1+9PbL9oW7Twcm
	Plu8BNQcRzKx8GRncRqDy4Vsb1iAKKs=
Date: Fri, 25 Jul 2025 17:59:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Fix test
 dynptr/test_dynptr_memset_xdp_chunks failure
Content-Language: en-GB
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20250725043425.208128-1-yonghong.song@linux.dev>
 <20250725043440.209266-1-yonghong.song@linux.dev>
 <3c145192-122d-46fc-8567-be30a2694a4d@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3c145192-122d-46fc-8567-be30a2694a4d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 4:29 PM, Martin KaFai Lau wrote:
> On 7/24/25 9:34 PM, Yonghong Song wrote:
>> For arm64 64K page size, the xdp data size was set to be more than 64K
>> in one of previous patches. This will cause failure for 
>> bpf_dynptr_memset().
>> Since the failure of bpf_dynptr_memset() is expected with 64K page size,
>> return success.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/progs/dynptr_success.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c 
>> b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> index 3094a1e4ee91..8315273cb900 100644
>> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
>> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
>> @@ -9,6 +9,8 @@
>>   #include "bpf_misc.h"
>>   #include "errno.h"
>>   +#define PAGE_SIZE_64K 65536
>> +
>>   char _license[] SEC("license") = "GPL";
>>     int pid, err, val;
>> @@ -821,8 +823,17 @@ int test_dynptr_memset_xdp_chunks(struct xdp_md 
>> *xdp)
>>       data_sz = bpf_dynptr_size(&ptr_xdp);
>>         err = bpf_dynptr_memset(&ptr_xdp, 0, data_sz, 
>> DYNPTR_MEMSET_VAL);
>> -    if (err)
>> +    if (err) {
>> +        /* bpf_dynptr_memset() eventually called bpf_xdp_pointer()
>
> I don't think I understand why the test fixed in patch 1 (e.g. 
> test_probe_read_user_dynptr) can pass the bpf_xdp_pointer test on 
> 0xffff. I thought the bpf_probe_read_user_str_dynptr will eventually 
> call the __bpf_xdp_store_bytes which also does a bpf_xdp_pointer?

For example, for test_probe_read_user_dynptr, for function test_dynptr_probe_xdp(),
for this one:
    off = xdp_near_frag_end_offset();

the off = 64928. Note that xdp_near_frag_end_offset() return value depends page size.

__u32 xdp_near_frag_end_offset(void)
{
         const __u32 headroom = 256;
         const __u32 max_frag_size =  __PAGE_SIZE - headroom - sizeof(struct skb_shared_info);
         
         /* 32 bytes before the approximate end of the fragment */
         return max_frag_size - 32;
}

The 'len' depends on 'test_len[i]' and test_len is
    __u32 test_len[7] = {0/* placeholder */, 0, 1, 2, 255, 256, 257};

In bpf_xdp_pointer, we have the following test

         if (unlikely(offset > 0xffff || len > 0xffff))
                 return ERR_PTR(-EFAULT);

In this particular case, offset = 64928, len = {0, 1, 2, 255, 256, 257}, so
it won't return -EFAULT.

For this patch 3, test_dynptr_memset_xdp_chunks, eventually we reached here:

         for (write_off = 0; write_off < size; write_off += chunk_sz) {
                 chunk_sz = min_t(u32, sizeof(buf), size - write_off);
                 err = __bpf_dynptr_write(ptr, offset + write_off, buf, chunk_sz, 0);
                 if (err)
                         return err;
         }

So the 'size' is 90000, chunk_sz is 256.
So 'offset + write_off' will be 0, 256, 512, ..., 65536
Once it reached 65536, 'offset > 0xffff' will become true since 0xffff = 65535.
and the -EFAULT will be returned.

>
>> +         * where if data_sz is greater than 0xffff, -EFAULT will be
>> +         * returned. For 64K page size, data_sz is greater than
>> +         * 64K, so error is expected and let us zero out error and
>> +         * return success.
>> +         */
>> +        if (data_sz >= PAGE_SIZE_64K)
>> +            err = 0;
>>           goto out;
>> +    }
>>         bpf_for(i, 0, max_chunks) {
>>           offset = i * sizeof(buf);
>


