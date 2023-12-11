Return-Path: <bpf+bounces-17410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDB380CEF4
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6FF1C212E7
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C5C4A99C;
	Mon, 11 Dec 2023 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KU1IlMa4"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [IPv6:2001:41d0:203:375::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F993CF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:04:00 -0800 (PST)
Message-ID: <96228ae1-a199-4f9a-8d40-d161a718c3c9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702307038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1DFnlxZFggZVgkEskBvFOCKE4mVCcaVgt6sW9dWz+ac=;
	b=KU1IlMa4KH/tAurEvOFH6yS0AfIw/e3AgOMZpmePwEknxIrBM6YdeaapLouRJyVjGsqRNa
	XzSemoDfk33OntFxwfM+pbRrVA0bWMeGhCAymW4usgRyDcCH6FqLnYWScjXfHiCERnMVbp
	YQKVN/O4gATDuCanBtLLjL3blIUS1q8=
Date: Mon, 11 Dec 2023 07:03:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: make the verifier trace the "not qeual" for
 regs
Content-Language: en-GB
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231210130001.2050847-1-menglong8.dong@gmail.com>
 <4457e84f-4417-4a60-a814-9288b0756d91@linux.dev>
 <CADxym3bNJXWZRfcGWpD7YW1rFe93vSOastmGrLvAcG3U2SaUdg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CADxym3bNJXWZRfcGWpD7YW1rFe93vSOastmGrLvAcG3U2SaUdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/11/23 1:39 AM, Menglong Dong wrote:
> Hello,
>
> On Mon, Dec 11, 2023 at 1:09 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 12/10/23 5:00 AM, Menglong Dong wrote:
>>> We can derive some new information for BPF_JNE in regs_refine_cond_op().
>>> Take following code for example:
>>>
>>>     /* The type of "a" is u16 */
>>>     if (a > 0 && a < 100) {
>>>       /* the range of the register for a is [0, 99], not [1, 99],
>>>        * and will cause the following error:
>>>        *
>>>        *   invalid zero-sized read
>>>        *
>>>        * as a can be 0.
>>>        */
>>>       bpf_skb_store_bytes(skb, xx, xx, a, 0);
>>>     }
>> Could you have a C test to demonstrate this example?
>> Also, you should have a set of inline asm code (progs/verifier*.c)
>> to test various cases as in mark_reg32_not_equal() and
>> mark_reg_not_equal().
>>
> Yeah! I found that this part is tested in the test_progs/reg_bounds_crafted
> too, and this commit failed that test case, which I should fix in the next
> version.
>
>>> In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
>>> TRUE branch, the dst_reg will be marked as known to 0. However, in the
>>> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
>>> the [min, max] for a is [0, 99], not [1, 99].
>>>
>>> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
>>> const and is exactly the edge of the dst reg.
>>>
>>> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
>>> ---
>>>    kernel/bpf/verifier.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 727a59e4a647..7b074ac93190 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -1764,6 +1764,40 @@ static void __mark_reg_const_zero(struct bpf_reg_state *reg)
>>>        reg->type = SCALAR_VALUE;
>>>    }
>>>
>>> +#define CHECK_REG_MIN(value)                 \
>>> +do {                                         \
>>> +     if ((value) == (typeof(value))imm)      \
>>> +             value++;                        \
>>> +} while (0)
>>> +
>>> +#define CHECK_REG_MAX(value)                 \
>>> +do {                                         \
>>> +     if ((value) == (typeof(value))imm)      \
>>> +             value--;                        \
>>> +} while (0)
>>> +
>>> +static void mark_reg32_not_equal(struct bpf_reg_state *reg, u64 imm)
>>> +{
>> What if reg->s32_min_value == imm and reg->s32_max_value == imm?
>> Has this been handled in previous verifier logic?
> Will such a case happen? In current code path, the src reg is a const,
> and the is_branch_taken() will return 0 or 1 if the
> dst_reg->s32_min_value == dst_reg->s32_max_value.
>
> Enn......maybe we can do more checking here in case that someone
> calls this function in another place.

I double checked the source code as well. Indeed, 'reg' should
not be a constant as it has been handled in is_branch_taken()
properly. Ignore my comments above then. Thanks!

>
> Thanks!
> Menglong Dong
>
>>> +             CHECK_REG_MIN(reg->s32_min_value);
>>> +             CHECK_REG_MAX(reg->s32_max_value);
>>> +             CHECK_REG_MIN(reg->u32_min_value);
>>> +             CHECK_REG_MAX(reg->u32_max_value);
>>> +}
>>> +
>>> +static void mark_reg_not_equal(struct bpf_reg_state *reg, u64 imm)
>>> +{
>>> +             CHECK_REG_MIN(reg->smin_value);
>>> +             CHECK_REG_MAX(reg->smax_value);
>>> +
>>> +             CHECK_REG_MIN(reg->umin_value);
>>> +             CHECK_REG_MAX(reg->umax_value);
>>> +
>>> +             CHECK_REG_MIN(reg->s32_min_value);
>>> +             CHECK_REG_MAX(reg->s32_max_value);
>>> +             CHECK_REG_MIN(reg->u32_min_value);
>>> +             CHECK_REG_MAX(reg->u32_max_value);
>>> +}
>>> +
>>>    static void mark_reg_known_zero(struct bpf_verifier_env *env,
>>>                                struct bpf_reg_state *regs, u32 regno)
>>>    {
>>> @@ -14332,7 +14366,16 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
>>>                }
>>>                break;
>>>        case BPF_JNE:
>>> -             /* we don't derive any new information for inequality yet */
>>> +             /* try to recompute the bound of reg1 if reg2 is a const and
>>> +              * is exactly the edge of reg1.
>>> +              */
>>> +             if (is_reg_const(reg2, is_jmp32)) {
>>> +                     val = reg_const_value(reg2, is_jmp32);
>>> +                     if (is_jmp32)
>>> +                             mark_reg32_not_equal(reg1, val);
>>> +                     else
>>> +                             mark_reg_not_equal(reg1, val);
>>> +             }
>>>                break;
>>>        case BPF_JSET:
>>>                if (!is_reg_const(reg2, is_jmp32))

