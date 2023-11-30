Return-Path: <bpf+bounces-16219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A047FE4D9
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 01:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8BE1C20B2E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671F80B;
	Thu, 30 Nov 2023 00:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZGMlX7o"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86ADBF
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 16:33:37 -0800 (PST)
Message-ID: <53e39e5c-3611-4efe-9eb0-e05fa086c6fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701304415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVMn5LcVY2P0PUY7SXx7B6bVKuxpM/aZ3R3f3Y7jAHQ=;
	b=gZGMlX7oY/C4bf7MQJ64Y3g3QL3i86ezBbcT8mLZ6ZNWXLQpeT46s+F4GhfgCsFPTBhCc0
	ApvEWq5TyWQiCOD1Rd8d7eY8iZVHvXKXldCXi/6qOTvMYr3DYCNVUhtIqmazpFnEy8luC3
	raCvd6znA3DvLSV6J1cZB7GrD0zSaQI=
Date: Wed, 29 Nov 2023 16:33:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20231130001516.3522627-1-yonghong.song@linux.dev>
 <CAEf4Bza_pH9kEg82=z0eTSjJNgTi_zipS76sR8sW_YOvo1ccRA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bza_pH9kEg82=z0eTSjJNgTi_zipS76sR8sW_YOvo1ccRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/29/23 7:19 PM, Andrii Nakryiko wrote:
> On Wed, Nov 29, 2023 at 4:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
>> ("bpf: Support new 32bit offset jmp instruction") added support for new
>> 32bit offset jmp instruction. Unfortunately, in function
>> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
>> (plus/minor a small delta) compares to 16-bit offset bound
>> [S16_MIN, S16_MAX], which caused the following verification failure:
>>    $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>>    ...
>>    insn 10 cannot be patched due to 16-bit range
>>    ...
>>    libbpf: failed to load object 'pyperf180.bpf.o'
>>    scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>>    #405     verif_scale_pyperf180:FAIL
>>
>> Note that due to recent llvm18 development, the patch [2] (already applied
>> in bpf-next) needs to be applied to bpf tree for testing purpose.
>>
>> The fix is rather simple. For 32bit offset branch insn, the adjusted
>> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
>>
>>    [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev
>>    [2] https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
>>
>> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/core.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index cd3afe57ece3..beff7e1d7fd0 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -371,14 +371,17 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
>>   static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
>>                                  s32 end_new, s32 curr, const bool probe_pass)
>>   {
>> -       const s32 off_min = S16_MIN, off_max = S16_MAX;
>> +       s64 off_min = S16_MIN, off_max = S16_MAX;
>>          s32 delta = end_new - end_old;
>> -       s32 off;
>> +       s64 off;
>>
>> -       if (insn->code == (BPF_JMP32 | BPF_JA))
>> +       if (insn->code == (BPF_JMP32 | BPF_JA)) {
>>                  off = insn->imm;
>> -       else
>> +               off_min = S32_MIN;
>> +               off_max = S32_MAX;
>> +       } else {
> nit: it would be more symmetrical and easier to follow if you set
> S16_{MIN,MAX} in this branch, instead of using variable initialization
> approach

I tried to minimize the code change but probably not worth it.
If no further errors in this patch, should I send v3 with better
coding style or Maintainers could help do the change? Either
way, please let me know.

>
>>                  off = insn->off;
>> +       }
>>
>>          if (curr < pos && curr + off + 1 >= end_old)
>>                  off += delta;
>> --
>> 2.34.1
>>

