Return-Path: <bpf+bounces-69715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE3B9F70E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4FE1895221
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1F12101AE;
	Thu, 25 Sep 2025 13:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFC221FA4
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805828; cv=none; b=s3d9DgsN0lhfNqcHMFWkLk6iLz1c2bICzEedcUyIBH3+szkf4o6fgLhImEQM6Cc1zbYEG3CpUiwWXq9I0Rurf9e+SGFTmdoR9vVTyyr9nQ/RrgTWmIAngHOoYmWd2mco6n0Z4M35fzQPYMWun1TDGI/BbN2Ism86cSfvxtdkxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805828; c=relaxed/simple;
	bh=+vtGz0m4ih6Zz+tP8RAbOuQHitqg6vnCE598S5nTR5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAAvR4m4ZNivOSIKys8il9zdaIUi1D0/ibNH3AFkNpHls7/B/FQ2MYoPjPEOuvBaWOVTTKO1RJ8ZQJ9QWRluD8u581C6gbjznoppZHcPyiO8lnG8Y+t0CRCY9SXy0ZjoZtACTDFf2ZrepJICjb04elcfayTayLInKOdk51mAm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cXYwh3TvpzYQv2h
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 21:10:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BDD531A0FE1
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 21:10:21 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgBnTTw8P9VoIeMRAw--.36997S2;
	Thu, 25 Sep 2025 21:10:21 +0800 (CST)
Message-ID: <830adc73-a008-4414-b996-23c2313da657@huaweicloud.com>
Date: Thu, 25 Sep 2025 21:10:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf, arm64: Add support for signed arena
 loads
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20250915162848.54282-1-puranjay@kernel.org>
 <20250915162848.54282-3-puranjay@kernel.org>
 <14c06b60-7923-4f27-ae8d-ba62ac7a2248@huaweicloud.com>
 <CANk7y0jcD65oWuyk=+scJarEtjW9BqN9TmKyUcPOU1xOU7uppQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CANk7y0jcD65oWuyk=+scJarEtjW9BqN9TmKyUcPOU1xOU7uppQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnTTw8P9VoIeMRAw--.36997S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfGryUZry7KFWxZF18Zrb_yoWrJr48pa
	47JFy3Z34vqayruF92qrWfZw18Ars5CFW7Wryay34UA3Z3Wrs3KF1UtFyxWrZ0yr9rWrWU
	AF18u39akr98Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/23/2025 6:52 PM, Puranjay Mohan wrote:
> On Sat, Sep 20, 2025 at 12:37 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 9/16/2025 12:28 AM, Puranjay Mohan wrote:
>>> Add support for signed loads from arena which are internally converted
>>> to loads with mode set BPF_PROBE_MEM32SX by the verifier. The
>>> implementation is similar to BPF_PROBE_MEMSX and BPF_MEMSX but for
>>> BPF_PROBE_MEM32SX, arena_vm_base is added to the src register to form
>>> the address.
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>> ---
>>>    arch/arm64/net/bpf_jit_comp.c | 30 +++++++++++++++++-------------
>>>    1 file changed, 17 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
>>> index f2b85a10add2..7233acec69ce 100644
>>> --- a/arch/arm64/net/bpf_jit_comp.c
>>> +++ b/arch/arm64/net/bpf_jit_comp.c
>>> @@ -1133,12 +1133,14 @@ static int add_exception_handler(const struct bpf_insn *insn,
>>>                return 0;
>>>
>>>        if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
>>> -             BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>>> -                     BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
>>> -                             BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>>> +         BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
>>> +         BPF_MODE(insn->code) != BPF_PROBE_MEM32 &&
>>> +         BPF_MODE(insn->code) != BPF_PROBE_MEM32SX &&
>>> +         BPF_MODE(insn->code) != BPF_PROBE_ATOMIC)
>>>                return 0;
>>>
>>>        is_arena = (BPF_MODE(insn->code) == BPF_PROBE_MEM32) ||
>>> +                (BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) ||
>>>                   (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC);
>>>
>>>        if (!ctx->prog->aux->extable ||
>>> @@ -1659,7 +1661,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>>        case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
>>>        case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
>>>        case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
>>> -             if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
>>> +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_B:
>>> +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_H:
>>> +     case BPF_LDX | BPF_PROBE_MEM32SX | BPF_W:
>>> +             if (BPF_MODE(insn->code) == BPF_PROBE_MEM32 ||
>>> +                 BPF_MODE(insn->code) == BPF_PROBE_MEM32SX) {
>>>                        emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
>>>                        src = tmp2;
>>>                }
>>> @@ -1671,7 +1677,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>>                        off_adj = off;
>>>                }
>>>                sign_extend = (BPF_MODE(insn->code) == BPF_MEMSX ||
>>> -                             BPF_MODE(insn->code) == BPF_PROBE_MEMSX);
>>> +                             BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
>>> +                              BPF_MODE(insn->code) == BPF_PROBE_MEM32SX);
>>>                switch (BPF_SIZE(code)) {
>>>                case BPF_W:
>>>                        if (is_lsi_offset(off_adj, 2)) {
>>> @@ -1879,9 +1886,11 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>>>                if (ret)
>>>                        return ret;
>>>
>>> -             ret = add_exception_handler(insn, ctx, dst);
>>> -             if (ret)
>>> -                     return ret;
>>> +             if (BPF_MODE(insn->code) == BPF_PROBE_ATOMIC) {
>>
>> add_exception_handler already checked this condition, why add a check here?
>>
> 
> If I don't check it here then add_exception_handler() will be called
> even for BPF_ATOMIC (0xc0), earlier
> add_exception_handler() would have rejected it but now
> BPF_PROBE_MEM32SX is also defined as 0xc0, so
> add_exception_handler() will confuse BPF_ATOMIC for BPF_PROBE_MEM32SX
> and allow it, I felt it was better to
> just add a check here.
>

I see. Thanks for the explanation. I think it’s better to include this
explanation as a comment here.

Other than that, this patch looks good to me. Thanks.

> Thanks,
> Puranjay


