Return-Path: <bpf+bounces-68616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFFB8082D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783AA7B6C8D
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823AA2FA0F5;
	Wed, 17 Sep 2025 03:41:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867672FABE1
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758080499; cv=none; b=EIalF9Q3Dx0+/sD6bbx64gEWlupewbjdxY5vpviBvdtwlCEyLTzJKLQFCp9i1mYdX2dgsaymSXkIgMggLaHN529z1lSdUJCxjoQjNYR9xtZRk3KH8t45mWzSIeGnsylwFj0+sfOM9GBxDO5+jdIEPt8QGJeoMJFvqXwlK29NVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758080499; c=relaxed/simple;
	bh=PzCrw3YQ5wgbCZqgX18sGQkbMnQfufBpW99G9QxyLWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZaTkfFNxFCi/wpHfeLNoTPURqd7LoUDYnMSg20uiQ7e+lVQgQbOca2+hJHsEfQAy4m+gsFoiPGFdGDRnrUBlzteFnNKu8fy3dFB877OjkbPfGGKh55A9N5AiZKug4wRkuQJk0QN3Jq+ok51PEweA7AgMXFfqQ24LUIOV52WS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cRPhD0ZMTzKHMbP
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 11:41:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C288D1A0359
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 11:41:32 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgBHL2fpLcpoFJTqCg--.30721S2;
	Wed, 17 Sep 2025 11:41:30 +0800 (CST)
Message-ID: <8d8dd917-2420-43de-81d5-b58ab45c945e@huaweicloud.com>
Date: Wed, 17 Sep 2025 11:41:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 0/3] Signed loads from Arena
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
References: <20250915162848.54282-1-puranjay@kernel.org>
 <CAP01T74rStmtnHhubDx8q0AQ7J4ZYEaX0EO5DZtqUxT-ceT6uw@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAP01T74rStmtnHhubDx8q0AQ7J4ZYEaX0EO5DZtqUxT-ceT6uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHL2fpLcpoFJTqCg--.30721S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFykXrWUWF4ftF4DGr45Jrb_yoW8ArWxpF
	sxW3WYyFZ8AFW0yFnrXw4j9F47Krn5Gry5W3s8Ja48Aa1Uu3Wvgr1SkF45u3ZruF48urWj
	v3Wjgr9agws8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 9/17/2025 9:03 AM, Kumar Kartikeya Dwivedi wrote:
> On Mon, 15 Sept 2025 at 18:29, Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> Changelog:
>> v1 -> v2:
>> v1: https://lore.kernel.org/bpf/20250509194956.1635207-1-memxor@gmail.com
>> - Use bpf_jit_supports_insn. (Alexei)
>>
>> v2 -> v3:
>> v2: https://lore.kernel.org/bpf/20250514175415.2045783-1-memxor@gmail.com/
>> - Fix encoding for the generated instructions in x86 JIT (Eduard)
>>    The patch in v2 was generating instructions like:
>>          42 63 44 20 f8     movslq -0x8(%rax,%r12), %eax
>>    This doesn't make sense because movslq outputs a 64-bit result, but
>>    the destination register here is set to eax (32-bit). The fix it to
>>    set the REX.W bit in the opcode, that means changing
>>    EMIT2(add_3mod(0x40, ...)) to EMIT2(add_3mod(0x48, ...))
>> - Add arm64 support
>> - Add selftests signed laods from arena.
>>
>> Currently, signed load instructions into arena memory are unsupported.
>> The compiler is free to generate these, and on GCC-14 we see a
>> corresponding error when it happens. The hurdle in supporting them is
>> deciding which unused opcode to use to mark them for the JIT's own
>> consumption. After much thinking, it appears 0xc0 / BPF_NOSPEC can be
>> combined with load instructions to identify signed arena loads. Use
>> this to recognize and JIT them appropriately, and remove the verifier
>> side limitation on the program if the JIT supports them.
>>
>> Kumar Kartikeya Dwivedi (1):
>>    bpf, x86: Add support for signed arena loads
>>
>> Puranjay Mohan (2):
>>    bpf, arm64: Add support for signed arena loads
> 
> +Cc Xu, could you please ack arm64 bits before we merge this?
> Thanks a lot.
>

Sure, I'll look into it a bit later.

>>   [...]
> 


