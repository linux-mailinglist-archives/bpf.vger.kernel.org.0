Return-Path: <bpf+bounces-55643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26102A83DA6
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EA6443B9E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BB20B814;
	Thu, 10 Apr 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwaHa/mS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BE20C009
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275388; cv=none; b=ov51Q8YKaCEFuwTZsaLD1YC4UJebykTUmPFe7Bs5arBNzL47DP7t9b7PxdcbQA0dIpdiS6Y0aDVyZYg55vGLQCTPKALoLjS3Q5GdzWuu7UwkLLCknQFH66BKObI+xTt4EYgnqJJmzKWVr5EsY18+RnYV8NGaqUKn9RqXdB/ltq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275388; c=relaxed/simple;
	bh=cog8XN7RWDlL8mpFUXfLXOeQ9crZwu/ZwwbOWG7ydug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5cmjl+TlqBljnUCOh7FGc2MRewAcGDDGzlqkF6CiAdxm3mPBTJtJf5nGCVaQH784gWhuS2Y8T+i7zTBkUfS/JtZNeQSOlqr5TNODuGd2N46Zq3dsKsWNiZbmaZg4KUYpSQqoLgpQ27lGPEjbrcImVFZ70hB7TCq/ei90VxnELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwaHa/mS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744275385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9RR3UUHR9EEZBwHDjsJ7cAbotBzRhVrVL0VWz/fkYw=;
	b=RwaHa/mSa5BBWPHWnY77t7QKRnHV8fMQkHwsJY4PQpEGOI5IKFbpMfvPYzfATgE+hDzvuh
	ZCTjKHEuPM1Bv88fIipQY1o4JQtI+a5Y8KoEBSHKtWCDiZAclUuuZaiAa+oJcvTXvdKae6
	WmM+OTDFsWOZqXXwkJznhNb+uUIRXf0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-7TJJ62hlPo2bKMpU7aELdA-1; Thu, 10 Apr 2025 04:56:24 -0400
X-MC-Unique: 7TJJ62hlPo2bKMpU7aELdA-1
X-Mimecast-MFC-AGG-ID: 7TJJ62hlPo2bKMpU7aELdA_1744275383
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3978ef9a284so203789f8f.3
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275381; x=1744880181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9RR3UUHR9EEZBwHDjsJ7cAbotBzRhVrVL0VWz/fkYw=;
        b=SG8gjfq3DzOMOte5by7QII7aFvwAr2dqeduXepK/Q8rSRziLNxDV3cX3cgKamzv6xa
         tm0jXv4++FvsmHjGMVUGEcxn+zVhZcseFiqvg7onuUsxAeMzaXNgQF+j8TnejmPjZkDQ
         orK59J8/0AzzR1MENFIYBEFYKhgC9/1v1idskwHZ+gu4+DtUuMyKByjLzOpukdD2d+7b
         7xOxqvUOqcyFj+rtJnXLjzXx5QU3s7enPi0/YyicaqyfMTDSW52uyPR5RiPlGD/3wFSv
         tQRoE0y8SkDuTDdGFXHsPlPWqPkF2nwiXIv0T7SJ4ZJo7FKPNZYCJbNcxb2ABJGDvzcy
         KpRQ==
X-Gm-Message-State: AOJu0YxVVdRg5LXjZC61L3SvWKW7Rz5NHcAgCDas3MJecPiZsG7p/12T
	fXRZJnuCjUbW7L7b5+YxNQxB/yRSjiDsV2saXi04IxiJBVDVw6+WXHN02m3zJH63b0Aed/u7Dwg
	OYUciXN5QRjwOMcYatCkNP5Lee60kBvXOfFIPAPVLhjtsuaYq
X-Gm-Gg: ASbGncv+RVmtmeOLgf39skJY1t0HktUeEURhXlfAMUGFDOl+a/yIkHvB34yyDYOX6wW
	zx2GEQKCiV7V0jm82jCYoMwE1Pe3blPM/ABF5Rklgx2ksPRT3GyWw8uZrDCqhThjcR7fKiHVTM/
	HhKBNRwTcnuzEP262RcWa4shOTv+eRa2BfNGUMA3JLxpuNVroVpJnbsHYHss4179H2hYoCtLAo5
	azVcpQzyOZerIWu3yAlnbTgWq/g9DCCjmUiPTKLSFr5RzdjrLSQauQDup5h8llnXixJLjPuhF1h
	Ttcm1CE=
X-Received: by 2002:a5d:64c9:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-39d8f46d0f5mr1314287f8f.14.1744275381076;
        Thu, 10 Apr 2025 01:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHilg5yEtkuLyh4XmfJ7B23xjVhBD1j3TSM0/A0fb6h1+IHimYiF7BCZaH0/WJ2ebDWjzi7DQ==
X-Received: by 2002:a5d:64c9:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-39d8f46d0f5mr1314260f8f.14.1744275380701;
        Thu, 10 Apr 2025 01:56:20 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893773absm4188009f8f.31.2025.04.10.01.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:56:20 -0700 (PDT)
Message-ID: <09662c0c-8643-4188-849b-adff38e32c23@redhat.com>
Date: Thu, 10 Apr 2025 10:56:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Fix buffer overflow in bpf_object__init_prog
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20250410073407.131211-1-vmalik@redhat.com>
 <b5yyvqbzff6pf4lyducvu7m3aw4wskoakz2l75aedte5lubtvd@327tjmlssvbk>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <b5yyvqbzff6pf4lyducvu7m3aw4wskoakz2l75aedte5lubtvd@327tjmlssvbk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 10:16, Shung-Hsi Yu wrote:
> I was about to sent my fix, just to realize I got beaten by half and
> hour+ even with my 6 hour timezone advantage :)

:)

> 
> On Thu, Apr 10, 2025 at 09:34:07AM +0200, Viktor Malik wrote:
>> As reported by CVE-2025-29481 (link below), it is possible to corrupt a
>> BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
>> This can be done by setting a symbol (BPF program) section offset to a
>> sufficiently large (unsigned) number such <section_start+symbol_offset>
>> overflows and points before the section.
>>
>> Consider the situation below where:
>> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
>> - prog_end   = prog_start + prog_size
>>
>>     prog_start        sec_start        prog_end        sec_end
>>         |                |                 |              |
>>         v                v                 v              v
>>     .....................|################################|............
>>
>> Currently, libbpf only checks that prog_end is within the section
>> bounds. Add a check that prog_start is also within the bounds to avoid
>> the potential buffer overflow.
> 
> I would add
> 
> Reported-by: lmarch2 <2524158037@qq.com>
> Cc: stable@vger.kernel.org
> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
> 
> There used to be a 'while (sec_off < sec_sz)' check that would prevent
> this issue, but with commit 6245947c1b3c that was removed.
> 
> ---
> 
> Nit: it would be nice if some concrete values from the reproducer is
> included
> 
>   Section Headers:
>     [Nr] Name              				Type            Address          	Off    	Size   	ES Flg Lk Inf Al
>     ...
>     [ 2] uretprobe.multi.snter_write 		PROGBITS        0000000000000000 	000040 	000068 	00  AX  0   0  8
> 
>   Symbol table '.symtab' contains 8 entries:
>      Num:    Value          Size Type    Bind   Vis      Ndx Name
>        ...
>        6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
> 
> As well as AddressSanitizer output:
> 
>   libbpf: loading object from crash-04573b0232eeaed1b2cd9f10e4fadc122c560e7a
>   libbpf: elf: section(2) uretprobe.multi.snter_write, size 104, link 0, flags 6, type=1
>   libbpf: sec 'uretprobe.multi.snter_write': found program 'handle_tp' at insn offset 0 (0 bytes), code size 13 insns (104 bytes)
>   libbpf: sec 'uretprobe.multi.snter_write': found program 'handle_tp' at insn offset 2305843009213693943 (18446744073709551544 bytes), code size 13 insns (104 bytes)
>   =================================================================
>   ==169293==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c1fc6be0000 at pc 0x7f6fc831f877 bp 0x7ffc89800a30 sp 0x7ffc898001f0
>   READ of size 104 at 0x7c1fc6be0000 thread T0
>       #0 0x7f6fc831f876 in memcpy (/lib64/libasan.so.8+0x11f876) (BuildId: 7a83eb8b5639d83795773bfac12481d6f3243469)
>       #1 0x00000040fcbf in bpf_object__init_prog ./tools/lib/bpf/libbpf.c:856
>       #2 0x00000040fcbf in bpf_object__add_programs ./tools/lib/bpf/libbpf.c:928
>       #3 0x00000040fcbf in bpf_object__elf_collect ./tools/lib/bpf/libbpf.c:3930
>       #4 0x00000040fcbf in bpf_object_open ./tools/lib/bpf/libbpf.c:8067
>       #5 0x000000411b83 in bpf_object__open_file ./tools/lib/bpf/libbpf.c:8090
>       #6 0x000000403966 in main (../poc/libbpf/poc+0x403966) (BuildId: 9d80b3f3edc46b2a3684427aad5fe2bcda2b5ea4)
>       ...
> 

These are great suggestions, I'll add them to the commit message and
will send v2.

Thanks!
Viktor

>> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> 
> Code-wise LGTM
> 
> Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 


