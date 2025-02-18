Return-Path: <bpf+bounces-51813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97259A3953E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 09:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3843B7A3E64
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A5822E3E3;
	Tue, 18 Feb 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIeTFt6D"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F422CBEA
	for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867029; cv=none; b=ko7WjcHecDoGdg268i7JT7Y8SNkMPnP3bX3M6ZxnVrmcP7moRt/T1mS6Lk5eiRQEXS28JfRy0+6F9dje2eA5VG3qErURf8xWVjuwT63wTKvCCiSTL5vdKgLvsCQjCJCHYCio9gTls9Pth+D8DN3IoeXvJKPSJsqnyjeoM7LRt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867029; c=relaxed/simple;
	bh=gWd6drMmeihrMWJ8/TtKCyEBVI8vLXPoVdRTCAifHog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPLEPtGby4B23dKPfgo8zb+NALo53EduAdj3IV8PzMqZqFEMgRZBCk7Uh0GzNh8RCIv+SgX2XnTDscFGlMhxR1mQYu1A+oSF5zaeejOr1yiRDQJNWXCBKQhxHIz9x0TiVWUw6+XCgT0BVvHC7eRmbnMJd/LF0oZdjD2WwcAaVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIeTFt6D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739867026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qBvHlvfhr6BmJazXy9Q+HDDUtHYXQv5MYZOFyogRBUc=;
	b=MIeTFt6DjMaKJ8PEsGWbUgfnywGZyBRknnAICkn+hvPgcJUIXomr9TcVzAt2qO92PuhtnB
	h2X6UfRzuaqtcy1FWYX69l0K8c80Vtt12Yef0tiwDRDRo9hr+x8zS/5QAl93+2ON5wf5pC
	Y+vzqZjUdd8jTP5A5AexYuG5VP3aOng=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-dmUN-rYXNra1TyN3dD3O5g-1; Tue, 18 Feb 2025 03:23:44 -0500
X-MC-Unique: dmUN-rYXNra1TyN3dD3O5g-1
X-Mimecast-MFC-AGG-ID: dmUN-rYXNra1TyN3dD3O5g_1739867023
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so30971225e9.2
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2025 00:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739867023; x=1740471823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBvHlvfhr6BmJazXy9Q+HDDUtHYXQv5MYZOFyogRBUc=;
        b=MYjEf4VZRrfDJWhR8JGrNB0zQVJtku98c6GEhBNywVDRystYV6tyon5UiuQ5tR+LcQ
         AUbdbUwz5ari/5hd6laJ1ZxMCdN2OKKdOWaAJgQ2oPyccPtCyCWpHOgzlnfXSnsrjihA
         KFpTnQ9KIJ/pxGi/oPRQQkdl7Aq4YFY9RzOh2REXj9VK2/Bt0ioeQH628SrX6zQ0mIe3
         rQnmKwutqV140iW0MYOAILkFj0SUecDsxRDBsrdKVpDPOx3JmIcWEiCk1S7qzKkEcH6I
         K/7fARXdQNstduXFDUSh0mfDED2K3b63ZpbI70FHI2bI8aPnZPwhtAuV7PyjYTFzpaZ/
         u3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXWaPAbBcHPvL/2Mr0byvtUnCMfIsQ5ox7zLiKGEK7FHpNBO5DKNC+xugULjS6+xtUgH3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sht+cxghoQimEiCVHUG3B5vYR3enckTjDeIt5LeLt60tRMBx
	oIpRn5pDSlDqxWOGMjxW+ZdvjLTXR/QwNZNWo3lpsiNyfkXPshWI06bWX8+hNPKwyaCXbm1APzx
	LHSnQuG5TcNuBpAhVUxlkNPHKT0wA6m3RshH6h8Dge7+ZSmwwbw==
X-Gm-Gg: ASbGncvASLe4CmrmOVX18Lzpw9HZXKxrZbsWqF37LIu4LHtgZhTTeN1xIH7JNnmrwe2
	r1mE2RDIhUuBPwN3JRXdETqbBw46Gl0kFO4U4EzofLh7UHWvcUIyllfHziriMX7knecjolCXSHD
	SacDqrt9fbZNhyakVzj25eSCsT7aYOKr28OLpoH9UaoVW6U3nQ3anTtZPnbVUxGH2oJYpowAhet
	eXcVlg6l2MXta7YQpQG4jvJwbtDfaxYgkp10JYSCLO94IqOoUbUryNnCm5QAZ7EWE1xxgF/QvGx
	jvguZ8e/EMo497h7awFksKmNvW1AkLY5pg==
X-Received: by 2002:a05:600c:4f0b:b0:439:8e3e:b0d6 with SMTP id 5b1f17b1804b1-4398e3eb2efmr32505875e9.13.1739867023322;
        Tue, 18 Feb 2025 00:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tH9YBQtD4GkUVh4n7y0i9ZJ1I2JKGhUsOrKgQV1OtugdjJp59dqV+zBOCHkFIW2CoWU6WQ==
X-Received: by 2002:a05:600c:4f0b:b0:439:8e3e:b0d6 with SMTP id 5b1f17b1804b1-4398e3eb2efmr32505555e9.13.1739867022833;
        Tue, 18 Feb 2025 00:23:42 -0800 (PST)
Received: from [192.168.3.141] (p5b0c61a2.dip0.t-ipconnect.de. [91.12.97.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm36172685e9.1.2025.02.18.00.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:23:41 -0800 (PST)
Message-ID: <3b893634-5453-42d0-b8dc-e9d07988e9e9@redhat.com>
Date: Tue, 18 Feb 2025 09:23:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
To: Tong Tiangen <tongtiangen@huawei.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 wangkefeng.wang@huawei.com, linux-mm <linux-mm@kvack.org>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.02.25 03:47, Tong Tiangen wrote:
> 
> 
> 在 2025/2/17 20:38, Tong Tiangen 写道:
>> We triggered the following error logs in syzkaller test:
>>
>>     BUG: Bad page state in process syz.7.38  pfn:1eff3
>>     page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
>>     flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
>>     raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
>>     raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
>>     page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>>     Call Trace:
>>      <TASK>
>>      dump_stack_lvl+0x32/0x50
>>      bad_page+0x69/0xf0
>>      free_unref_page_prepare+0x401/0x500
>>      free_unref_page+0x6d/0x1b0
>>      uprobe_write_opcode+0x460/0x8e0
>>      install_breakpoint.part.0+0x51/0x80
>>      register_for_each_vma+0x1d9/0x2b0
>>      __uprobe_register+0x245/0x300
>>      bpf_uprobe_multi_link_attach+0x29b/0x4f0
>>      link_create+0x1e2/0x280
>>      __sys_bpf+0x75f/0xac0
>>      __x64_sys_bpf+0x1a/0x30
>>      do_syscall_64+0x56/0x100
>>      entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>
>>      BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1
>>
>> The following syzkaller test case can be used to reproduce:
>>
>>     r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
>>     write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
>>     r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
>>     mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
>>     r5 = userfaultfd(0x80801)
>>     ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
>>     r6 = userfaultfd(0x80801)
>>     ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
>>     ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
>>     ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
>>     r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
>>     bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)
>>
>> The cause is that zero pfn is set to the pte without increasing the rss
>> count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
>> not increase accordingly. Then, the operation on the same pfn is performed
>> in uprobe_write_opcode()->__replace_page() to unconditional decrease the
>> rss count and old_folio's refcount.
>>
>> Therefore, two bugs are introduced:
>> 1. The rss count is incorrect, when process exit, the check_mm() report
>>      error "Bad rss-count".
>> 2. The reserved folio (zero folio) is freed when folio->refcount is zero,
>>      then free_pages_prepare->free_page_is_bad() report error "Bad page state".
>>
>> To fix it, add zero folio check before rss counter and refcount decrease.
>>
>> Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
>> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>    kernel/events/uprobes.c | 6 ++++--
>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 46ddf3a2334d..ff5694acfa68 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -213,7 +213,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>>    		dec_mm_counter(mm, MM_ANONPAGES);
>>    
>>    	if (!folio_test_anon(old_folio)) {
>> -		dec_mm_counter(mm, mm_counter_file(old_folio));
>> +		if (!is_zero_folio(old_folio))
>> +			dec_mm_counter(mm, mm_counter_file(old_folio));
>>    		inc_mm_counter(mm, MM_ANONPAGES);
>>    	}
>>    
>> @@ -227,7 +228,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>>    	if (!folio_mapped(old_folio))
>>    		folio_free_swap(old_folio);
>>    	page_vma_mapped_walk_done(&pvmw);
>> -	folio_put(old_folio);
>> +	if (!is_zero_folio(old_folio))
>> +		folio_put(old_folio);
 >>    >>    	err = 0;
>>     unlock:
> 

The whole "manually replace pages" logic is fragile. I tried to rewrite 
it a while back:

https://lkml.kernel.org/r/20240604122548.359952-1-david@redhat.com

But didn't get to follow-up yet.

I'm not sure if the page_vma_mapped_walk() really does what we would 
expect here.

The folio_remove_rmap_pte(old_folio, old_page, vma); is certainly wrong 
as well for ero folios.


I don't think there is a sane use case right now where we would hit the 
shared zeropage.

So for the time being, I think we should just reject them immediately 
after get_user_page_vma_remote().

At some point I'll follow up with my rewrite that will clean this 
nastiness here up a bit.

-- 
Cheers,

David / dhildenb


