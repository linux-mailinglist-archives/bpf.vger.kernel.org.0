Return-Path: <bpf+bounces-20672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24547841A69
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 04:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD0CB23621
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B573381A4;
	Tue, 30 Jan 2024 03:20:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D589376EE;
	Tue, 30 Jan 2024 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584803; cv=none; b=hCYohz45jLMxRwMO/9hWip/Q4z22NryhLsMj4ejxwrd4tbZt6PL6JBZBvBUeIiMNMtgdNPkXXSNrDgrPDP+BCyhmhSaLgUbAVU/j9WbESgMPbSFxcnAnEAbNl5ioUHGH+nTEIsidhAMt+p8oQhG97A3CoJNBDeo1bvS4YYkaF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584803; c=relaxed/simple;
	bh=M6wVVTaY3ttiwNUn+PvJfT1HvQ8W8ZLtrGc85LuVN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ued5xMWboH2ot5Fb7VV3/6d8c93iNl3X0BbEfrvW5PWni6PC11WFGPiuhkmqQqeG+gvfv4SGRRhGCn6h75sNfm5FTohqIUpSFJxiE628SCNF512/gv2IzZFhjh/INade/fKpMuy2iJUek8DXXr18gxQI7FePFOnml8fOezJUCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TP9NJ04kZz29krM;
	Tue, 30 Jan 2024 11:18:08 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 486A61A016B;
	Tue, 30 Jan 2024 11:19:57 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 30 Jan 2024 11:19:56 +0800
Message-ID: <8cc7d3ad-1b34-478d-bfc8-6a2f791aa5d9@huawei.com>
Date: Tue, 30 Jan 2024 11:19:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] bpf: Keep im address consistent between dry
 run and real patching
Content-Language: en-US
To: Song Liu <song@kernel.org>, Pu Lehui <pulehui@huaweicloud.com>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>
References: <20240123103241.2282122-1-pulehui@huaweicloud.com>
 <20240123103241.2282122-3-pulehui@huaweicloud.com>
 <CAPhsuW67c8NYxBhwrq8JK8HP95P1Wwq1zHEDqooAOgP+aru13g@mail.gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <CAPhsuW67c8NYxBhwrq8JK8HP95P1Wwq1zHEDqooAOgP+aru13g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100009.china.huawei.com (7.221.188.135)



On 2024/1/30 1:58, Song Liu wrote:
> On Tue, Jan 23, 2024 at 2:32 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> In __arch_prepare_bpf_trampoline, we emit instructions to store the
>> address of im to register and then pass it to __bpf_tramp_enter and
>> __bpf_tramp_exit functions. Currently we use fake im in
>> arch_bpf_trampoline_size for the dry run, and then allocate new im for
>> the real patching. This is fine for architectures that use fixed
>> instructions to generate addresses. However, for architectures that use
>> dynamic instructions to generate addresses, this may make the front and
>> rear images inconsistent, leading to patching overflow. We can extract
>> the im allocation ahead of the dry run and pass the allocated im to
>> arch_bpf_trampoline_size, so that we can ensure that im is consistent in
>> dry run and real patching.
> 
> IIUC, this is required because emit_imm() for riscv may generate variable
> size instructions (depends on the value of im). I wonder we can fix this by
> simply set a special value for fake im in arch_bpf_trampoline_size() to
> so that emit_imm() always gives biggest value for the fake im.
> 

Hi Song,

Thanks for your review. Yes, I had the same idea as you at first, emit 
biggist count instructions when ctx->insns is NULL, but this may lead to 
memory waste. So try moving out of IM to get a fixed IM address, maybe 
other architectures require it too. If you feel it is inappropriate, I 
will withdraw it.

>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
> [...]
>>
>>   static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mutex)
>> @@ -432,23 +425,27 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>>                  tr->flags |= BPF_TRAMP_F_ORIG_STACK;
>>   #endif
>>
>> -       size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
>> +       im = kzalloc(sizeof(*im), GFP_KERNEL);
>> +       if (!im) {
>> +               err = -ENOMEM;
>> +               goto out;
>> +       }
>> +
>> +       size = arch_bpf_trampoline_size(im, &tr->func.model, tr->flags,
>>                                          tlinks, tr->func.addr);
>>          if (size < 0) {
>>                  err = size;
>> -               goto out;
>> +               goto out_free_im;
>>          }
>>
>>          if (size > PAGE_SIZE) {
>>                  err = -E2BIG;
>> -               goto out;
>> +               goto out_free_im;
>>          }
>>
>> -       im = bpf_tramp_image_alloc(tr->key, size);
>> -       if (IS_ERR(im)) {
>> -               err = PTR_ERR(im);
>> -               goto out;
>> -       }
>> +       err = bpf_tramp_image_alloc(im, tr->key, size);
>> +       if (err < 0)
>> +               goto out_free_im;
> 
> I feel this change just makes bpf_trampoline_update() even
> more confusing.
> 
>>
>>          err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
>>                                            &tr->func.model, tr->flags, tlinks,
>> @@ -496,6 +493,8 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>>
>>   out_free:
>>          bpf_tramp_image_free(im);
>> +out_free_im:
>> +       kfree_rcu(im, rcu);
> 
> If we goto out_free above, we will call kfree_rcu(im, rcu)
> twice, right? Once in bpf_tramp_image_free(), and again
> here.
> 

Oops, sorry, forgot to remove kfree_rcu in bpf_tramp_image_free in this 
version.

> Thanks,
> Song
> 
> [...]
> 

