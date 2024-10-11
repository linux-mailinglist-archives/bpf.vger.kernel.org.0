Return-Path: <bpf+bounces-41698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1923C999B2E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 05:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9638B1F24E47
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090F1F4FA6;
	Fri, 11 Oct 2024 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a76tPzV+"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A56D2FB
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728617274; cv=none; b=W27LyeERpt9wdR+A2dcm5LOtz66VJiGQe3VMUeXJMFmXqJEShMxcDWyKeKzVaxlO8sTTgc0TlEohIJUh4KQ3/mC33rdTGvb4Vqp7lEyzuTog5cwpc6IqG2Vxrqe3C/h+0geyZpulUvhoTvkFj7WiAvO3AsGMR5qWPJCDRtJwceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728617274; c=relaxed/simple;
	bh=9LsOQAcoUAYZDPeemO5qE1kpd52rVf69eUQHTMTznCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrPSRdrqJiZ/aH9nmcnF16nC0/EF9DedXLvdwuClCrvLS8H4JEaCR/QcFswmMj32gW2+/eqsrX2oXV+qk6mRzt7ugVoHc+GqaYw07Zc4a4mdYYU0bP0sMJyd9sYcjQ6wm2CEaGncUqN05fV8PcrnCZkR2NvS+b6Ut0kDt+ACJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a76tPzV+; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c7e49c48-7644-40c3-a4a2-664cc16a702c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728617270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Vq9SEqCGw7yztKMTFVdutw4lNsZ1RC6kshJc/bjvhw=;
	b=a76tPzV+x2mEt6Gd61HGyEYqgdSStzs4LaQsj3uCZRrZwDtMmAijP68ki3HYQvPUMNrI1j
	acQLC2BI3GlE3EI7CIh1CKpinunogF0U/macXxU/PyGEkYHOqcOPYpXcLn6ku6rE0ieUBI
	3govBlcpNOy6wZ3w6OND6YBiolY0fQI=
Date: Fri, 11 Oct 2024 11:27:41 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Prevent tailcall infinite loop
 caused by freplace
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kernel-patches-bot@fb.com
References: <20241010153835.26984-1-leon.hwang@linux.dev>
 <20241010153835.26984-2-leon.hwang@linux.dev>
 <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 11/10/24 01:09, Alexei Starovoitov wrote:
> On Thu, Oct 10, 2024 at 8:39 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> -static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
>> +static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>> +                                     struct bpf_trampoline *tr,
>> +                                     struct bpf_prog *tgt_prog)
>>  {
>>         enum bpf_tramp_prog_type kind;
>>         struct bpf_tramp_link *link_exiting;
>> @@ -544,6 +546,17 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_tr
>>                 /* Cannot attach extension if fentry/fexit are in use. */
>>                 if (cnt)
>>                         return -EBUSY;
>> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
>> +               if (tgt_prog->aux->prog_array_member_cnt)
>> +                       /* Program extensions can not extend target prog when
>> +                        * the target prog has been updated to any prog_array
>> +                        * map as tail callee. It's to prevent a potential
>> +                        * infinite loop like:
>> +                        * tgt prog entry -> tgt prog subprog -> freplace prog
>> +                        * entry --tailcall-> tgt prog entry.
>> +                        */
>> +                       return -EBUSY;
>> +               tgt_prog->aux->is_extended = true;
>>                 tr->extension_prog = link->link.prog;
>>                 return bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP, NULL,
>>                                           link->link.prog->bpf_func);
> 
> The suggestion to use guard(mutex) shouldn't be applied mindlessly.
> Here you extend the mutex holding range all the way through
> bpf_arch_text_poke().
> This is wrong.
> 

Understood. The guard(mutex) should indeed limit the mutex holding range
to as small as possible. I’ll adjust accordingly.

>>         if (kind == BPF_TRAMP_REPLACE) {
>>                 WARN_ON_ONCE(!tr->extension_prog);
>> +               guard(mutex)(&tgt_prog->aux->ext_mutex);
>>                 err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
>>                                          tr->extension_prog->bpf_func, NULL);
>>                 tr->extension_prog = NULL;
>> +               tgt_prog->aux->is_extended = false;
>>                 return err;
> 
> Same here. Clearly wrong to grab the mutex for the duration of poke.
> 

Ack.

> Also Xu's suggestion makes sense to me.
> "extension prog should not be tailcalled independently"
> 
> So I would disable such case as a part of this patch as well.
> 

I’m fine with adding this restriction.

However, it will break a use case that works on the 5.15 kernel:

libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> freplace B.

With this limitation, the chain 'freplace A --tailcall-> freplace B'
will no longer work.

To comply with the new restriction, the use case would need to be
updated to:

libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> XDP B.

> pw-bot: cr

Thanks,
Leon


