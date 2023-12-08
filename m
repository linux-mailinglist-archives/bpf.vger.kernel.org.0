Return-Path: <bpf+bounces-17211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7380AB2C
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 18:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B119DB20BA4
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8923B797;
	Fri,  8 Dec 2023 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="eiU8Meoa"
X-Original-To: bpf@vger.kernel.org
X-Greylist: delayed 1562 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 09:52:19 PST
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7CB5;
	Fri,  8 Dec 2023 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wxy3xgRhrj6UTc1QdokBgbslL2XzW+nP8ePfpGtcYTA=; b=eiU8Meoae3JM9r80l579F6nCF8
	MCned7VaOC0Yg+//GegbbQnsWnv7YGDrdxD2IHSEt1vvfqbb0SShBJr8tQa/chDOh4jOm1FrOfRk5
	jK5T2zXXMpaX1zDv2uUa0gwVhAuIBqTYS9F/srhAiXv94784tPQd3oOQUehLLnQ+mHEkkV+raselG
	Sydqx5tBswMpExkLsi6ap6XWV38EapmlxO9pKur0J7CJPTVUPKt6meFd8pMkU4T2QWZP1YwFU01SM
	KkiJrZx2W9xYN86G8VunVHxelSCJaJsH/q4ZkzhNURBv3pqioJ6uH+nOHiNMrwJEyRyhBVCfZPTrm
	9beKPMVQ==;
Received: from [167.98.27.226] (helo=[10.35.4.236])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1rBec9-00DYnt-G4; Fri, 08 Dec 2023 17:26:14 +0000
Message-ID: <948c34c3-bbbe-484c-892e-cd67abe3ce30@codethink.co.uk>
Date: Fri, 8 Dec 2023 17:26:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: add __printf() to for printf fmt strings
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
 <8a713266-777f-099c-2eed-7ac13b7b72a6@oracle.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <8a713266-777f-099c-2eed-7ac13b7b72a6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 22/11/2023 16:44, Alan Maguire wrote:
> On 22/11/2023 13:36, Ben Dooks wrote:
>> The btf_seq_show() and btf_snprintf_show() take a printk format
>> string so add a __printf() to these two functions. This fixes the
>> following extended warnings:
>>
>> kernel/bpf/btf.c:7094:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>> kernel/bpf/btf.c:7131:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Looks good to me, thanks for fixing! Could also add a
> 
> Fixes: eb411377aed9 ("bpf: Add bpf_seq_printf_btf helper")
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>


Thanks, looks like the test robot found some issues so will
go back and look at those as soon as I can.

>> ---
>>   kernel/bpf/btf.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 15d71d2986d3..46c2e87c383d 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7088,8 +7088,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>>   	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>>   }
>>   
>> -static void btf_seq_show(struct btf_show *show, const char *fmt,
>> -			 va_list args)
>> +static __printf(2,0) void btf_seq_show(struct btf_show *show, const char *fmt,
>> +				       va_list args)
>>   {
>>   	seq_vprintf((struct seq_file *)show->target, fmt, args);
>>   }
>> @@ -7122,7 +7122,7 @@ struct btf_show_snprintf {
>>   	int len;		/* length we would have written */
>>   };
>>   
>> -static void btf_snprintf_show(struct btf_show *show, const char *fmt,
>> +static __printf(2,0) void btf_snprintf_show(struct btf_show *show, const char *fmt,
>>   			      va_list args)
>>   {
>>   	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


