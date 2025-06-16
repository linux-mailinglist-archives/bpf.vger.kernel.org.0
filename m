Return-Path: <bpf+bounces-60705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B05ADAAF5
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 10:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1023AE6C4
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE22737E2;
	Mon, 16 Jun 2025 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZrNV28i6"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8E26D4C1
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063201; cv=none; b=preRvwgNafWJqAUGXrI+UszkMADPeiag61qI9iE+qr3VGyU/2WSiy/zgmg29f8oCasdWRD4li0cdpOPo5E6t7oremgOSapdEzkyYCWU2CN2nIXeUjWShMO1W4gKjfSik6Z2CmhwXze41ohfk3fdZghl4C4ByoJxP5dYn9yR1oKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063201; c=relaxed/simple;
	bh=KypxWQJ2yT3gO1ghWzOCG7RfNuaeoxRXNjMEzLekFE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj6j9Me16TL1lsz3+EjaoOfExJvDd1w1coSwEuAzY8bBAErspt1LL7wjRIXZHFXJVpkvtaXghm4mMY0B80YSNAEfD9CBMk4XTB/4iglqJRliAgQlcCDHDMmh1BiNkfHmT78bySj17uBnqQZJdkeha0opyqvUT3jyi6ND0FrU4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZrNV28i6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fdc58e38-8b54-4681-89e9-78f8941db1b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750063187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kcKyRmwMINtcXDedCYZ06Q0fSCB+UG7zs+9U7ma+AdY=;
	b=ZrNV28i6k4CSXtNM/s/DVddBAST36BpPJ7/tLqZDH9oyjEGuMwDJpZQLKVsO/3/raX1WtJ
	g15cU9VatESzpopQDW/M/cNEH0hB/oCa9S5kY3pJlh5zLnvK62K9lILb2V5x9OoelkgDcg
	Nodmiqp3YOc1jX3h6T+o0+Ud4HR2Irk=
Date: Mon, 16 Jun 2025 16:39:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add show_fdinfo for uprobe_multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: song@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250615150514.418581-1-chen.dylane@linux.dev>
 <aE_KX66K-8yrSPtS@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aE_KX66K-8yrSPtS@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/16 15:40, Jiri Olsa 写道:
> On Sun, Jun 15, 2025 at 11:05:13PM +0800, Tao Chen wrote:
>> Show uprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:	uprobe_multi
>> link_id:	9
>> prog_tag:	e729f789e34a8eca
>> prog_id:	58
>> type:	uprobe_multi
>> uprobe_cnt:	3
>> pid:	0
>> path:	/home/dylane/bpf/tools/testing/selftests/bpf/test_progs
>> offset:	0xa69ed7
>> ref_ctr_offset:	0x0
>> cookie:	3
>> offset:	0xa69ee2
>> ref_ctr_offset:	0x0
>> cookie:	1
>> offset:	0xa69eed
>> ref_ctr_offset:	0x0
>> cookie:	2
> 
> hi,
> does this need to be 'tag: value' format ? bpftool uses:
> 
>          offset             ref_ctr_offset     cookies
>          0xe558             0x0                0x0
>          0x2574e            0x0                0x0
>          0x6c393            0x0                0x0
> 
> which might be more readable, or at least extra line after each uprobe?
> also using spaces instead of tabs  to align the values might help
> 
> same for kprobe_multi, otherwise looks lgtm
> 

That's a great suggestion, it does look more concise. I will change it 
in v3, thanks!

> thanks,
> jirka
> 
> 
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 48 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> Change list:
>>    v1 -> v2:
>>      - replace 'func_cnt' with 'uprobe_cnt'.(Andrii)
>>      - print func name is more readable and security for kprobe_multi.(Alexei)
>>    v1:
>>    https://lore.kernel.org/bpf/20250612115556.295103-1-chen.dylane@linux.dev
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 24b94870b50..9a8ca8a8e2b 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3157,10 +3157,58 @@ static int bpf_uprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>   	return err;
>>   }
>>   
>> +#ifdef CONFIG_PROC_FS
>> +static void bpf_uprobe_multi_show_fdinfo(const struct bpf_link *link,
>> +					 struct seq_file *seq)
>> +{
>> +	struct bpf_uprobe_multi_link *umulti_link;
>> +	char *p, *buf;
>> +
>> +	umulti_link = container_of(link, struct bpf_uprobe_multi_link, link);
>> +
>> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +	if (!buf)
>> +		return;
>> +
>> +	p = d_path(&umulti_link->path, buf, PATH_MAX);
>> +	if (IS_ERR(p)) {
>> +		kfree(buf);
>> +		return;
>> +	}
>> +
>> +	seq_printf(seq,
>> +		   "type:\t%s\n"
>> +		   "uprobe_cnt:\t%u\n"
>> +		   "pid:\t%u\n"
>> +		   "path:\t%s\n",
>> +		   umulti_link->flags == BPF_F_UPROBE_MULTI_RETURN ?
>> +					 "uretprobe_multi" : "uprobe_multi",
>> +		   umulti_link->cnt,
>> +		   umulti_link->task ? task_pid_nr_ns(umulti_link->task,
>> +			   task_active_pid_ns(current)) : 0,
>> +		   p);
>> +
>> +	for (int i = 0; i < umulti_link->cnt; i++) {
>> +		seq_printf(seq,
>> +			   "offset:\t%#llx\n"
>> +			   "ref_ctr_offset:\t%#lx\n"
>> +			   "cookie:\t%llu\n",
>> +			   umulti_link->uprobes[i].offset,
>> +			   umulti_link->uprobes[i].ref_ctr_offset,
>> +			   umulti_link->uprobes[i].cookie);
>> +	}
>> +
>> +	kfree(buf);
>> +}
>> +#endif
>> +
>>   static const struct bpf_link_ops bpf_uprobe_multi_link_lops = {
>>   	.release = bpf_uprobe_multi_link_release,
>>   	.dealloc_deferred = bpf_uprobe_multi_link_dealloc,
>>   	.fill_link_info = bpf_uprobe_multi_link_fill_link_info,
>> +#ifdef CONFIG_PROC_FS
>> +	.show_fdinfo = bpf_uprobe_multi_show_fdinfo,
>> +#endif
>>   };
>>   
>>   static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>> -- 
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

