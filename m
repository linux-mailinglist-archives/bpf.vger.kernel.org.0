Return-Path: <bpf+bounces-16194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3047FE438
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274DD2823A9
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0447A5D;
	Wed, 29 Nov 2023 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a857CSBt"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1244BD
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 15:42:30 -0800 (PST)
Message-ID: <a5a38b31-8089-4fd9-b515-1be98226d140@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701301349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AegibG3n3UiWdQIGK3pVKNHZIaO4zJQkqAOkhQVKHDM=;
	b=a857CSBt0MC/SBA2we005vCPDtr0Wcnkv/bhzp13eeGsZ/vCZp4UGJHXpzjtdBsfLFZCta
	xzpcp1pNjPKkjyBCwrFyWGTdIBsrgspgxWWLvQzwEFnppH/R/X68bmSKr/jE6TB5XFD9zn
	xqXF571JoPz0NtLSnWUG6KpHDp33lhM=
Date: Wed, 29 Nov 2023 15:42:22 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231129075409.2709587-1-yonghong.song@linux.dev>
 <470e1b48-fea7-3f3d-b840-cc0613a930b0@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <470e1b48-fea7-3f3d-b840-cc0613a930b0@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/29/23 5:51 PM, Daniel Borkmann wrote:
> On 11/29/23 8:54 AM, Yonghong Song wrote:
>> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
>> ("bpf: Support new 32bit offset jmp instruction") added support for new
>> 32bit offset jmp instruction. Unfortunately, in function
>> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the 
>> offset
>> (plus/minor a small delta) compares to 16-bit offset bound
>> [S16_MIN, S16_MAX], which caused the following verification failure:
>>    $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>>    ...
>>    insn 10 cannot be patched due to 16-bit range
>>    ...
>>    libbpf: failed to load object 'pyperf180.bpf.o'
>>    scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>>    #405     verif_scale_pyperf180:FAIL
>>
>> Note that due to recent llvm18 development, the patch [2] (already 
>> applied
>> in bpf-next) needs to be applied to bpf tree for testing purpose.
>>
>> The fix is rather simple. For 32bit offset branch insn, the adjusted
>> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
>>
>>    [1] 
>> https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev
>>    [2] 
>> https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
>>
>> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/core.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index cd3afe57ece3..74f2fd48148c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct bpf_insn 
>> *insn, u32 pos, s32 end_old,
>>   static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 
>> end_old,
>>                   s32 end_new, s32 curr, const bool probe_pass)
>>   {
>> -    const s32 off_min = S16_MIN, off_max = S16_MAX;
>> +    s32 off_min = S16_MIN, off_max = S16_MAX;
>>       s32 delta = end_new - end_old;
>>       s32 off;
>
> These should all be converted to s64, no? E.g. further below
> the test will never trigger then for jmp32:
>
>        if (off < off_min || off > off_max)
>                 return -ERANGE;


good point! Let us use s64 for potential overflows.
Will send v2 soon.

>
>> -    if (insn->code == (BPF_JMP32 | BPF_JA))
>> +    if (insn->code == (BPF_JMP32 | BPF_JA)) {
>>           off = insn->imm;
>> -    else
>> +        off_min = S32_MIN;
>> +        off_max = S32_MAX;
>> +    } else {
>>           off = insn->off;
>> +    }
>>         if (curr < pos && curr + off + 1 >= end_old)
>>           off += delta;
>>
>

