Return-Path: <bpf+bounces-52157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669F2A3EE0D
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400C617FF0B
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BBD200BB2;
	Fri, 21 Feb 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA9imOHA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86D1FFC77
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 08:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125538; cv=none; b=cbvVz7cUUDNPpXyvgSB0llyGmMFs1TbG5/Jo9FA8IzFhOKkltE9Enm8W+AdtbniR4xGIGLWM7vhgnPla7g6WzCWTTls/GZmnxXzA7RthyxyaeCJukG3RmlZurN3JGbu2ULXP614Q9j8y/E4aT+K3ENZ85FrPDz6OMKCRKG6f/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125538; c=relaxed/simple;
	bh=lzWxN1S1fKFRnF86+Gs+pAO61S9OlEWIgKWpyTFIpqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pNWi9WsMXGVuLQXCXFxLWYK78//KlnK9Bofhxvn+oU4iAu7s2i+w1zFlDcz99qMrUhe8RpwWlGC+4CPI+Ax+82NAVVTe0jEXyUUH+ZmlVEe7s1xa9kXWygbumucOkd0xLkHZyCegS61Aq6Udrj7Ngniz3I89m7OCFAiGzpCBV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JA9imOHA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740125535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snZPDRQfF3nkbAItK54JkAF0l4vF4hDbSlVfQh+HZLY=;
	b=JA9imOHAjxMlPAEPmlKkH1ncH8fdNPKaqYbQHOX6xJ3hTXL942GSkLrvoH+VFwEa0UcXKB
	8oiUcf65na3YFOAYNkSSs4tHA9TZ6sgbVepr1iqJZtNTNzJq7KtvZ19QsH+kqpzgx1O7Ks
	bldWkUl6s1A423g/4hZLU4IgUoYKmJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-4kGHwtIXNvari4kbprVQ5w-1; Fri, 21 Feb 2025 03:12:12 -0500
X-MC-Unique: 4kGHwtIXNvari4kbprVQ5w-1
X-Mimecast-MFC-AGG-ID: 4kGHwtIXNvari4kbprVQ5w_1740125531
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43945f32e2dso16809935e9.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 00:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740125531; x=1740730331;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snZPDRQfF3nkbAItK54JkAF0l4vF4hDbSlVfQh+HZLY=;
        b=BE8QyBGBKMZzXZBKE19M0+mBuBLVnwl3TZYmXq5qWw4WcH3sOgn1nzDpY7Rby1tA5q
         m7mX21CUSy37sSroP5V7gekoTHk99lgPS2fk3Epl3x5umpPY6zCmKKBQcaY1aqSRLcdo
         suSCqkB1HmvE2g9jjwStQ1iKV2knxyboI7DXF/VKpav8MQecMzSzbAxxyIgtSlBPQBzX
         iOM0AXhwxM1bSI8MSGx/V5mi/pAH1wa/l4sjgbiFtNq65KSMgPnULq+nTZ6+N0/dGaSF
         /OjMt1VDrSBtnTCUKpdkeCWTCYuAkBJ4KSXyJqjIR+8v++KmNJEGVBU9ANZr5AoMm8X7
         NRrw==
X-Forwarded-Encrypted: i=1; AJvYcCUocTR572rnz/6celDkaRkfJCMjt1OCQZ/wkGBzOKr8VMyDrVzThbbx7Iw8SxK314jpir0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpljaida74hfVPiz9cfIHrNp6IChWqRo/XD1thhtPNaHwg9fLl
	xJt/upQ3IehnS5iPVi03481re0KT4+BbnxKD5qsipp7x73g+m+BpaKZf8hDXviwvHd2lMGBXWM4
	lvZW2jy0qrCLdNbKrg49h2Gx9pGkKklPiUnfrKC8dm5kfAOVc8w==
X-Gm-Gg: ASbGncv2Xp0VLiQhe1K8skfiol4kcQJxsOIyo7RxIB+oMrZ3yQ7MInK6FFBzaMibWsF
	DW4ykhq4/+nTXfQWzaHOXlU9jZW4gwaI0MUtUBLIRX3zGO8lPDODIzv7cE5fmKG1MB9PtjupgNy
	D07xK6M5CGCklGpUMl3Dl9dhWddp+xF5uQySEhYsGRgwcYBJSKlUB3q9byq27TiMtmyhxeTsRbF
	NsKFNypm89EkoUEfn/VGNuEMJLyNLZCyyXTy72C7roQ6SgRpytJsv9TJt63muDcf8XN9ISHIKqK
	/Je7jruIoa286c4kQu37IOMbXT+YJ7AKLUTbX4UqSwS8lQ==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-439ae21e36emr15274055e9.25.1740125531062;
        Fri, 21 Feb 2025 00:12:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG0dkekhehCKl02eUDjNK4+y+UHQN/7nOWkErBj+FTNK2mzW3HjK76Y3BDYHomyV9SXb1sTw==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id 5b1f17b1804b1-439ae21e36emr15273695e9.25.1740125530691;
        Fri, 21 Feb 2025 00:12:10 -0800 (PST)
Received: from [192.168.3.141] (p4ff23890.dip0.t-ipconnect.de. [79.242.56.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce404sm9811415e9.7.2025.02.21.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 00:12:09 -0800 (PST)
Message-ID: <bdc01d66-01a7-43f6-954f-12a274e294d4@redhat.com>
Date: Fri, 21 Feb 2025 09:12:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] uprobes: fix two zero old_folio bugs in
 __replace_page()
To: Tong Tiangen <tongtiangen@huawei.com>, Oleg Nesterov <oleg@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Xu <peterx@redhat.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>
References: <20250221015056.1269344-1-tongtiangen@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250221015056.1269344-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 02:50, Tong Tiangen wrote:
> We triggered the following error logs in syzkaller test:
> 
>    BUG: Bad page state in process syz.7.38  pfn:1eff3
>    page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
>    flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
>    raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
>    raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
>    page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x32/0x50
>     bad_page+0x69/0xf0
>     free_unref_page_prepare+0x401/0x500
>     free_unref_page+0x6d/0x1b0
>     uprobe_write_opcode+0x460/0x8e0
>     install_breakpoint.part.0+0x51/0x80
>     register_for_each_vma+0x1d9/0x2b0
>     __uprobe_register+0x245/0x300
>     bpf_uprobe_multi_link_attach+0x29b/0x4f0
>     link_create+0x1e2/0x280
>     __sys_bpf+0x75f/0xac0
>     __x64_sys_bpf+0x1a/0x30
>     do_syscall_64+0x56/0x100
>     entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
>     BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1
> 
> The following syzkaller test case can be used to reproduce:
> 
>    r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
>    write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
>    r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
>    mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
>    r5 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
>    r6 = userfaultfd(0x80801)
>    ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
>    ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
>    ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
>    r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
>    bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)
> 
> The cause is that zero pfn is set to the pte without increasing the rss
> count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
> not increase accordingly. Then, the operation on the same pfn is performed
> in uprobe_write_opcode()->__replace_page() to unconditional decrease the
> rss count and old_folio's refcount.
> 
> Therefore, two bugs are introduced:
> 1. The rss count is incorrect, when process exit, the check_mm() report
>     error "Bad rss-count".
> 2. The reserved folio (zero folio) is freed when folio->refcount is zero,
>     then free_pages_prepare->free_page_is_bad() report error
>     "Bad page state".

Well, there is more, like triggering the

	VM_WARN_ON_FOLIO(is_zero_folio(folio), folio);

in __folio_rmap_sanity_checks() I assume.

So maybe just call the patch

	"uprobes: reject the share zeropage in uprobe_write_opcode)()"

Thanks!

-- 
Cheers,

David / dhildenb


