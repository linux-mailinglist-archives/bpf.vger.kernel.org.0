Return-Path: <bpf+bounces-55836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B8A8771E
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 07:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D339016F2CA
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 05:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60E19C569;
	Mon, 14 Apr 2025 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSHoI0+v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75371862
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607148; cv=none; b=Ub4veCHi20cU4/oglBuvcTul46h/oHQgigh9SoWweyvyfa9zmlMQENM8UHSuLx8y+q41A6omXG4h01JqwXVGVDQ+9m6DeaKbm/hMjsmzVdnhhXMuM06ESDuTrU0iUOd8U6IslVCNRxwIB0/YNC9S/B7wbhMzjjpZay6AL26GVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607148; c=relaxed/simple;
	bh=+zoUCjF8LyByMqFNJP8rSKLkdWSYxripiuw4AoeyUfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ss5GIYlY+GyAWGHUNVtMHGW4/xxhYsy5/pDlzaV4N+/YACUaN0eGR7NhoFpNDJFk+4V1Lfe9W9d6MEiyX1GzsOVhfAVW0kaB1LT3neO1rGPinE9cTwd+Qxk6TdaQh97/3UxEG2LU001xJJ/H5fnU875ojFTgHxcFUw2ony+caYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSHoI0+v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744607145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UWWDmjBR5U0DRXxg9cVkEJpuUfRTxUlG3l7NzHd2N8=;
	b=cSHoI0+vzhuhNq2vwC71bwJTCOSlFeD9y2isj38tJTyy8W1hENR0st2ltCpkzHJBXIDV7w
	aOVwhpAhealNREJS0QK+Wl0lTTYd17jZQK0iY9Rt53GWr9fCn6sDQ1nOP1CeMB+r1kxPTO
	NNoClR97rPt0M2etnmntX8fI8Njk47M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-sz72392iNI2Atl1UBMjOVA-1; Mon, 14 Apr 2025 01:05:43 -0400
X-MC-Unique: sz72392iNI2Atl1UBMjOVA-1
X-Mimecast-MFC-AGG-ID: sz72392iNI2Atl1UBMjOVA_1744607143
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac737973d06so323784366b.2
        for <bpf@vger.kernel.org>; Sun, 13 Apr 2025 22:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607141; x=1745211941;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UWWDmjBR5U0DRXxg9cVkEJpuUfRTxUlG3l7NzHd2N8=;
        b=tYHAwD2PKMuEeIJ4yfofrMpxdzDTtxvhJECFDSVgqhmeLX+2L+uUeuBLrLe4gQne1s
         mAd966+BUQnNFebA3uUnNR9XuFL6Ge8XZJ+xzQAi5EPI3jr7erqxIbqZ2vNS2PeACip2
         IrDh/llBQ7/JVmp+fwTU15anv+g9umPyg3rBwskr9ctX4NJI0ELP4LCyWnCQsXf7kwNF
         WancntnRK5wY+ixJP2SHR1C32dvFIlXVoGCiHCq9AzULEuAcMUJup8gW7dbJZGSqAg9V
         P+NSY0nLtWNrCOVToz23W9OGoz+r7drwf9Ll+f+H3OtGHwDipuqIs1fAG09zCrLlARHY
         nsEQ==
X-Gm-Message-State: AOJu0YwRG2moUJHcyqUbIqU4ZTJv5QLX8xiHisZOFutx6lhglb5dJHX3
	z1cxDl6AGVcQEpyqacvTArDdyct70fLvxLH6plte9KNwPFuc+HKRVyCxkLrbSgbL/t193g9ULvz
	6nKy6vkoqfZ1MXgm7H8HoKw+54f8duLQAukWZlWjmtju6SyZD
X-Gm-Gg: ASbGncuEgctlIrPiSr6lySuTBrbX+Oo9tTz2UsLlcEmtkRpRqye2NWmAj4CEc2+dzRG
	NBQiNbEwE/LtJdMCs9HkOLJkAz7f35lHdlh25byKhqEE8EHdxPDe605sCeMnxWGLScka7wLQ7l8
	jsBaEJJWKFmCquJU1/T/cRMCOvyevXDrfBopt8dNiUH5L8Po3LIjQ/o61eoDcV795decw+D5SOv
	qOAmSvjDyDvW3Pa2DgCSBTbCJcME36LX9Y+gsB2udKerUNVpDiRZfS6JGH17hJWhnqFgg0El3iu
	UJW5uLan29yqtVpO+trlmhevNC65kYV5jNtMKdHm6sdMbw==
X-Received: by 2002:a17:907:7f92:b0:ac7:16f2:e8e5 with SMTP id a640c23a62f3a-acad36d6f97mr827850466b.50.1744607141096;
        Sun, 13 Apr 2025 22:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk9KQvdO8EDflY/syccJhaKyFLBE/TUW45NINF0KjV35/FmHwh8Phzd9X3sECEOuwG2JVYKA==
X-Received: by 2002:a17:907:7f92:b0:ac7:16f2:e8e5 with SMTP id a640c23a62f3a-acad36d6f97mr827847066b.50.1744607140605;
        Sun, 13 Apr 2025 22:05:40 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ce81c5sm833165366b.184.2025.04.13.22.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 22:05:39 -0700 (PDT)
Message-ID: <67b2be76-e1db-4163-995c-57073f127d7a@redhat.com>
Date: Mon, 14 Apr 2025 07:05:38 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
To: Greg KH <gregkh@linuxfoundation.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>,
 stable@vger.kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
 <2025041242-ignore-python-f4ef@gregkh>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <2025041242-ignore-python-f4ef@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/25 08:24, Greg KH wrote:
> On Fri, Apr 11, 2025 at 09:22:37AM -0700, Andrii Nakryiko wrote:
>> On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
>>> file such that arbitrary BPF instructions are loaded by libbpf. This can
>>> be done by setting a symbol (BPF program) section offset to a large
>>> (unsigned) number such that <section start + symbol offset> overflows
>>> and points before the section data in the memory.
>>>
>>> Consider the situation below where:
>>> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
>>> - prog_end   = prog_start + prog_size
>>>
>>>     prog_start        sec_start        prog_end        sec_end
>>>         |                |                 |              |
>>>         v                v                 v              v
>>>     .....................|################################|............
>>>
>>> The CVE report in [1] also provides a corrupted BPF ELF which can be
>>> used as a reproducer:
>>>
>>>     $ readelf -S crash
>>>     Section Headers:
>>>       [Nr] Name              Type             Address           Offset
>>>            Size              EntSize          Flags  Link  Info  Align
>>>     ...
>>>       [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
>>>            0000000000000068  0000000000000000  AX       0     0     8
>>>
>>>     $ readelf -s crash
>>>     Symbol table '.symtab' contains 8 entries:
>>>        Num:    Value          Size Type    Bind   Vis      Ndx Name
>>>     ...
>>>          6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
>>>
>>> Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
>>> point before the actual memory where section 2 is allocated.
>>>
>>> This is also reported by AddressSanitizer:
>>>
>>>     =================================================================
>>>     ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
>>>     READ of size 104 at 0x7c7302fe0000 thread T0
>>>         #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
>>>         #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
>>>         #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
>>>         #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
>>>         #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
>>>         #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
>>>         #6 0x000000400c16 in main /poc/poc.c:8
>>>         #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
>>>         #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
>>>         #9 0x000000400b34 in _start (/poc/poc+0x400b34)
>>>
>>>     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
>>>     allocated by thread T0 here:
>>>         #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
>>>         #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
>>>         #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
>>>         #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740
>>>
>>> The problem here is that currently, libbpf only checks that the program
>>> end is within the section bounds. There used to be a check
>>> `while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
>>> removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
>>> sections to support overriden weak functions").
>>>
>>> Put the above condition back to bpf_object__init_prog to make sure that
>>> the program start is also within the bounds of the section to avoid the
>>> potential buffer overflow.
>>>
>>> [1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>>>
>>> Reported-by: lmarch2 <2524158037@qq.com>
>>> Cc: stable@vger.kernel.org
>>
>> Libbpf is packaged and consumed from Github mirror, which is produced
>> from latest bpf-next and bpf trees, so there is no point in
>> backporting fixes like this to stable kernel branches. Please drop the
>> CC: stable in the next revision.
>>
>>> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
>>> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>>> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
>>
>> libbpf is meant to load BPF programs under root. It's a
>> highly-privileged operation, and libbpf is not meant, designed, and
>> actually explicitly discouraged from loading untrusted ELF files. As
>> such, this is just a normal bug fix, like lots of others. So let's
>> drop the CVE link as well.
>>
>> Again, no one in their sane mind should be passing untrusted ELF files
>> into libbpf while running under root. Period.
>>
>> All production use cases load ELF that they generated and control
>> (usually embedded into their memory through BPF skeleton header). And
>> if that ELF file is corrupted, you have problems somewhere else,
>> libbpf is not a culprit.
> 
> Should that context-less CVE be revoked as well?  Who asked for it to be
> issued?

That would be ideal. It was filed by MITRE but the CVE report doesn't
contain more information than a link to the GitHub repo with the
reproducer [1]. Since the repo contains reproducers for other newly
filed CVEs, it's likely that they have been requested by the repo owner.

MITRE has a form [2] which apparently could be used for providing more
information on a CVE. Should we try to use it and request revoking it?
(I'm asking as I'm not much familiar with the overall CVE filing process).

Thanks!
Viktor

[1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
[2] https://cveform.mitre.org/

> 
> thanks,
> 
> greg k-h
> 


