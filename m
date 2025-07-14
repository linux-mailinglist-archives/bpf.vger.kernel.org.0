Return-Path: <bpf+bounces-63273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF79B04C62
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ED14A1BB2
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8A285C94;
	Mon, 14 Jul 2025 23:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzZ6vymR"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1682857C9
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 23:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535942; cv=none; b=N+CHTCQWYOMlAMHEXojOE2YxOYF7+Typt62Nxkfr4c2mlDrlI9jlhROfw2EUiIJm/5GucGfhAc1js0gnXCvdAfUQoxYL/VJYFmN/axBEoDhI8sHPsAO0Xhijs7JZ58185sr+38KmDt8zV1uQf/WQS2ckjACZ94Qbl5eEJSQHwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535942; c=relaxed/simple;
	bh=g928VJ/MMQAjxhqh+sUjqL8aYh9PIDBqwlqj9HriKTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm393O2LnhdT/n/C0ZDFTTj1/KfGGs7TEUUWj3ZwXlKeymWrb0o06C5/oaGuw4cqExpSXnnae1lMsU7QIKjlLXvrr+rwlOw2ypQ1DCdHHiUjVVGP0eZljhchyWT0JtZKMAJyzuOhchA30nKf9j//WW8S0x61jjUysA3lrqc1v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzZ6vymR; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <324a7b0b-ccff-4d8b-b0a2-f810e90f74f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752535925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fjnFWK9YKajtsmrg56AGOFx51s3W0UmHKzgeMTuEqPQ=;
	b=vzZ6vymRoHDVW98EWXScGMUIpOnoibBi3W0HSqRmjnjuHLONeiE2iZ7zYHL237pwm0hmqM
	ILoOyAn3xZhotkqGun+z48vW5HaALVi5C7qMSspMKZL+ByBfRehf0vWXUSRWFdsjf3QO4M
	R+RAkQqp8l02sjVM55KbkcnrpKpXX/8=
Date: Tue, 15 Jul 2025 07:32:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: make the attach target more accurate
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Menglong Dong <dongml2@chinatelecom.cn>
References: <20250710070835.260831-1-dongml2@chinatelecom.cn>
 <CAADnVQKmUE3_5RHDFLmKzNSDkLD=Z2g3bkfT2aRsPkFiMPd-4Q@mail.gmail.com>
 <750dd5f1-a5f8-4ed2-a448-1a57cb5447dc@linux.dev>
 <CAADnVQLHORFKC3PzJ540xxa_bETBypXu2-z7Z+8c+as97vByXA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <CAADnVQLHORFKC3PzJ540xxa_bETBypXu2-z7Z+8c+as97vByXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/7/15 06:29, Alexei Starovoitov wrote:
> On Mon, Jul 14, 2025 at 2:50 PM Menglong Dong <menglong.dong@linux.dev> wrote:
>>
>> On 2025/7/15 03:52, Alexei Starovoitov wrote:
>>> On Thu, Jul 10, 2025 at 12:10 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>>                           } else {
>>>> -                               addr = kallsyms_lookup_name(tname);
>>>> +                               ret = bpf_lookup_attach_addr(NULL, tname, &addr);
>>>>                           }
>>> Not sure why your benchmarking doesn't show the difference,
>>> but above is a big regression.
>>> kallsyms_lookup_name() is a binary search whereas your
>>> bpf_lookup_attach_addr() is linear.
>>> You should see a massive degradation in multi-kprobe attach speeds.
>>
>> Hi, Alexei. Like I said above, the benchmarking does have
>> a difference for the symbol in the modules, which makes
>> the attachment time increased from 0.135543s to 0.176904s
>> for 8631 symbols. As the symbols in the modules
>> is not plentiful, which makes the overhead slight(or not?).
>>
>> But for the symbol in vmlinux, bpf_lookup_attach_addr() will
>> call kallsyms_on_each_match_symbol(), which is also
>> a binary search, so the benchmarking has no difference,
>> which makes sense.
> I see.
> Just curious, what was the function count in modules on your system ?
> cat /proc/kallsyms|grep '\['|grep -v bpf|wc -l

Hi, it's about 34k:

   cat/proc/kallsyms|grep'\['|grep-vbpf|wc-l
   34740


>
> Only now I read the diff carefully enough to realize that
> you're looking for duplicates across vmlinux and that one module.
>
> Why ?
> BTF based attachment identifies a specific module.
> Even if there are dups between that module and vmlinux the attachment
> is not ambiguous.


When the module is not specified, kallsyms_lookup_name() will be called in

bpf_check_attach_target() to get the address. And

kallsyms_lookup_name() will lookup the symbols in the vmlinux

first. If not found, it will lookup it in the modules. And in this

commit, I follow this logic.


So I lookup duplicates accross vmlinux and modules only when

the modules is not specified, and that's reasonable. However,

we always find the address in the vmlinux if module is not specified,

as the btf type belong to the vmlinux. So we will never lookup the

symbols in the modules if "mod" is not specified, which means

bpf_lookup_attach_addr() won't lookup duplicates accross vmlinux
and modules.

So just forget it :/


Thanks!
Menglong Dong


>
>> I thought we don't need this patch after the pahole fixes this
>> problem. Should I send a V4?
> pahole should fix it, so this change is not needed.
> But pahole will be removing the dups within vmlinux and
> within each module independently. Not across them.
> I don't think "across" is needed, but you somehow believe that
> it's necessary ? (based on this diff)

