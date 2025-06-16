Return-Path: <bpf+bounces-60704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B36ADAADC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 10:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49DA18890DC
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E6C1F4C8E;
	Mon, 16 Jun 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n9s1izY1"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD31B1E8854
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062923; cv=none; b=qqsVvqEJJ/VMAQnhkV1vjDW8qUkD6+LYkLuvHdcLLB2luNdzmoifh3fouChJSsqFqrU4LRbCUmVc/wpN5/+JUlO3zkamHYNkPfQbny3VUb+pQf3gVW3BhXKfA7sVffWSzfBK5OEgQLO58W54dtwIltYQLGNyFWBxC6ACZXE84xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062923; c=relaxed/simple;
	bh=jaVBmfhiO/gMUJCxr4WGTf3k2pGJTYD8tBDjkUnbMjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nehZz40gxbQCNloRYLSx0239bCeHcinkhGrf2ki5NJre0Tr6u3sLUTj0UpndCtmTjVFbg838zBo3cWGxjwcXY2J8hjbcSphSyIvtquJqrXaxgH7XyVigyO3NOcV4iIFK8+VBMZWQGibrL3QNDhe981+CRiDlvGJyKnrkT9iwyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n9s1izY1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d4a28883-2aff-42dd-afe4-c5a42447ed0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750062907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKgw0q/b2wsEMiS8v+UPXQrLZWDcU2TmDlxSNErwZhE=;
	b=n9s1izY1DgFXeYapdxjJWy2Y9bElYZA4F9H+Gw2gUs+VgMyWEytAWbwxpfwCN3BQUo06j5
	kugONuIW0EAqmK1xABumKKsn2773yVZ0U5cj6Vd4vkybXCdsnYqlwR+Wy8fFYE4E8qs4l4
	D0h+6ZUHdkmGxDVeN51DAqfhJYVJxzY=
Date: Mon, 16 Jun 2025 16:34:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: song@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250615150514.418581-1-chen.dylane@linux.dev>
 <20250615150514.418581-2-chen.dylane@linux.dev> <aE_KaH3DAo4-Yq7m@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <aE_KaH3DAo4-Yq7m@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/16 15:40, Jiri Olsa 写道:
> On Sun, Jun 15, 2025 at 11:05:14PM +0800, Tao Chen wrote:
>> Show kprobe_multi link info with fdinfo, the info as follows:
>>
>> link_type:	kprobe_multi
>> link_id:	3
>> prog_tag:	e8225cbcc9cdffef
>> prog_id:	29
>> type:	kprobe_multi
>> kprobe_cnt:	8
>> missed:	0
>> func:	bpf_fentry_test1+0x0/0x20
>> cookie:	1
>> func:	bpf_fentry_test2+0x0/0x20
>> cookie:	7
>> func:	bpf_fentry_test3+0x0/0x20
>> cookie:	2
>> func:	bpf_fentry_test4+0x0/0x20
>> cookie:	3
>> func:	bpf_fentry_test5+0x0/0x20
>> cookie:	4
>> func:	bpf_fentry_test6+0x0/0x20
>> cookie:	5
>> func:	bpf_fentry_test7+0x0/0x20
>> cookie:	6
>> func:	bpf_fentry_test8+0x0/0x10
>> cookie:	8
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 9a8ca8a8e2b..d060c61e4e4 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -2623,10 +2623,43 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>>   	return err;
>>   }
>>   
>> +#ifdef CONFIG_PROC_FS
>> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
>> +					 struct seq_file *seq)
>> +{
>> +	struct bpf_kprobe_multi_link *kmulti_link;
>> +	char sym[KSYM_NAME_LEN];
>> +
>> +	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
>> +
>> +	seq_printf(seq,
>> +		   "type:\t%s\n"
>> +		   "kprobe_cnt:\t%u\n"
>> +		   "missed:\t%lu\n",
>> +		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
>> +					 "kprobe_multi",
>> +		   kmulti_link->cnt,
>> +		   kmulti_link->fp.nmissed);
>> +
>> +	for (int i = 0; i < kmulti_link->cnt; i++) {
>> +		sprint_symbol(sym, kmulti_link->addrs[i]);
> 
> I think you could use specifier to do the translation for you,
> check Documentation/core-api/printk-formats.rst:
> 
>          %pS     versatile_init+0x0/0x110 [module_name]
> 

I'll refer to that, thanks!

> 
> 
>> +		seq_printf(seq,
>> +			  "func:\t%s\n"
>> +			  "cookie:\t%llu\n",
>> +			  sym,
>> +			  kmulti_link->cookies[i]
>> +			  );
> 
> bracket should be on the previous line
> 

will fix it in v3, thanks.

> jirka
> 
> 
>> +	}
>> +}
>> +#endif
>> +
>>   static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>>   	.release = bpf_kprobe_multi_link_release,
>>   	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
>>   	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>> +#ifdef CONFIG_PROC_FS
>> +	.show_fdinfo = bpf_kprobe_multi_show_fdinfo,
>> +#endif
>>   };
>>   
>>   static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
>> -- 
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

