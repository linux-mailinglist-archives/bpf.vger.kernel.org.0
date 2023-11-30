Return-Path: <bpf+bounces-16217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697267FE4B7
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E5E2823F1
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B59A387;
	Thu, 30 Nov 2023 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P4Ph3Kbi"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFED51A3
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:19:50 -0800 (PST)
Message-ID: <990a0e82-7d1e-41b2-a84c-68496844fe30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701303589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiJ8ijwqlRTgyyr+ms/p6jszVZbqTtkg4TgHHeyK4w0=;
	b=P4Ph3KbiCXmiZqfqGDf5yLAXIuILS2qkSmGU701RfgOkVV94JivHLENE8G39eLCz8BfxtH
	IPcj9DscE8Wry45eIIfqm1ECZrsaEKIj/5Fa53+FZZFwQVJ2vvtWKWEwMhmnqkZleotW2x
	Uvkpdc3p9cXrNV6rsIyygaIaeYFXcdc=
Date: Wed, 29 Nov 2023 16:19:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231129075409.2709587-1-yonghong.song@linux.dev>
 <470e1b48-fea7-3f3d-b840-cc0613a930b0@iogearbox.net>
 <a5a38b31-8089-4fd9-b515-1be98226d140@linux.dev>
In-Reply-To: <a5a38b31-8089-4fd9-b515-1be98226d140@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/29/23 6:42 PM, Yonghong Song wrote:
>
> On 11/29/23 5:51 PM, Daniel Borkmann wrote:
>> On 11/29/23 8:54 AM, Yonghong Song wrote:
>>> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
>>> ("bpf: Support new 32bit offset jmp instruction") added support for new
>>> 32bit offset jmp instruction. Unfortunately, in function
>>> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the 
>>> offset
>>> (plus/minor a small delta) compares to 16-bit offset bound
>>> [S16_MIN, S16_MAX], which caused the following verification failure:
>>>    $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>>>    ...
>>>    insn 10 cannot be patched due to 16-bit range
>>>    ...
>>>    libbpf: failed to load object 'pyperf180.bpf.o'
>>>    scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>>>    #405     verif_scale_pyperf180:FAIL
>>>
>>> Note that due to recent llvm18 development, the patch [2] (already 
>>> applied
>>> in bpf-next) needs to be applied to bpf tree for testing purpose.
>>>
>>> The fix is rather simple. For 32bit offset branch insn, the adjusted
>>> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
>>>
>>>    [1] 
>>> https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev
>>>    [2] 
>>> https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
>>>
>>> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   kernel/bpf/core.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index cd3afe57ece3..74f2fd48148c 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct 
>>> bpf_insn *insn, u32 pos, s32 end_old,
>>>   static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, 
>>> s32 end_old,
>>>                   s32 end_new, s32 curr, const bool probe_pass)
>>>   {
>>> -    const s32 off_min = S16_MIN, off_max = S16_MAX;
>>> +    s32 off_min = S16_MIN, off_max = S16_MAX;
>>>       s32 delta = end_new - end_old;
>>>       s32 off;
>>
>> These should all be converted to s64, no? E.g. further below
>> the test will never trigger then for jmp32:
>>
>>        if (off < off_min || off > off_max)
>>                 return -ERANGE;
>
>
> good point! Let us use s64 for potential overflows.
> Will send v2 soon.

I didn't change 's32 delta' type to be consistent with
bpf_adj_delta_to_imm() such that the delta should be
within s32 range. Technically off_min/off_max can
remain as 's32' but I changed them to 's64' to be consistent
with bpf_adj_delta_to_imm().

>
>>
>>> -    if (insn->code == (BPF_JMP32 | BPF_JA))
>>> +    if (insn->code == (BPF_JMP32 | BPF_JA)) {
>>>           off = insn->imm;
>>> -    else
>>> +        off_min = S32_MIN;
>>> +        off_max = S32_MAX;
>>> +    } else {
>>>           off = insn->off;
>>> +    }
>>>         if (curr < pos && curr + off + 1 >= end_old)
>>>           off += delta;
>>>
>>
>

