Return-Path: <bpf+bounces-55835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04248A8771D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 06:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990BC3AF74D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 04:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF819E806;
	Mon, 14 Apr 2025 04:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoTYxfNA"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1C8155C83
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744606783; cv=none; b=nXn737AOYAFrN/nv+KpWzGS/a9U14eUIwvDshJJp3Jvvh5Aatckyj165YZjoJ7HMdprhLmX09qPfKzlDzpG98dFywuIh+FfeLdjbnjwZlweY6zhYtModmuwbgPpvsTvROC9sesRwr/d4I/AMXTllrlIVnk4wTX44J1oxlKj6NwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744606783; c=relaxed/simple;
	bh=ACWZLJupa25jfFCxMpR9Xs9uVwnapZ24uhwEct9sX20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG8ISCdGINVAOpvQGP610qNaKQQwtzVxjMMw8m9WZaQaEcxGRzC3AUJv6UqNR6nVjbjv4S855966HzTS2Ii1lfExrzqq/tctTabr07DPJJvpqVzDFfNxJftYVtWRtqSqVT+xN6q5cqJRY5eLErwt0KwI0ghOsr0gc6fwgTGHooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoTYxfNA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744606780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1VnfrOH4OkYtjGJfeu1RCRHY0/ALwH6gZrfWL+zW1w=;
	b=IoTYxfNAT/UgT/t9/hbG5Ts1UAfWFOAbhqKvYxkqiTyDdfk8mcxLtkjBmjP7l+bm1ANvS8
	tOzTvBcT4F90zB5XYsNoy+1uTh20K7087cdF/aAvDEYryh8PNnuCmoyMeU6MdYFBDpM/wS
	zoiPZIQbJTGIheW7+3KcAx9PEAO+gW4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-4iadCVIsN66OZEuNPpmbZA-1; Mon, 14 Apr 2025 00:59:38 -0400
X-MC-Unique: 4iadCVIsN66OZEuNPpmbZA-1
X-Mimecast-MFC-AGG-ID: 4iadCVIsN66OZEuNPpmbZA_1744606778
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so293756366b.3
        for <bpf@vger.kernel.org>; Sun, 13 Apr 2025 21:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744606774; x=1745211574;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1VnfrOH4OkYtjGJfeu1RCRHY0/ALwH6gZrfWL+zW1w=;
        b=K8pCJZgK5AZdkNQN0JtLGjRhugVcHYTTZjxz6zngMrmua0+FIrOQJtpxPZ3/i/fM9h
         o/UbQ2qoIW61BXMwIddDPHG8LcDlnuJLPpEam8xYx6DJwPhkDQLUEZhjPVPjp0BJSeYN
         3jPdvwtR1Lh3zj5WroYmVDx4lG4x84nKfC9RI4g/we9ncDEpgWlxBz3cFPXash7RmKqi
         wam8bRDSFFdXk/UDHNWE0FnNLz6rJnthq01SGRc6rTX7afQLdiAEa662REE5kb/Q2Q0E
         JkNDgHVrLT/DV9vpTqPL4dqxI+l3u04rmlZot9NdXId7I/Ka/DO1QmEEzs1bZvRdfUpp
         d7oQ==
X-Gm-Message-State: AOJu0YzfVAVcFzjU1RUQUvqhjpsuZ2GZPi/czITFdMbLv3azXqUejbDs
	gRIZVz8yck3mMz4VGKUzx5AouSHS2v9cF9b4ayb/ihVNBwCiVuzu6ecINfEUnmLkObbY76vT+hY
	/Fb5Xndo/7UFDzRTaWFBx0eHO4z2TPTY7W4N0aOwaOLqBWVBJ
X-Gm-Gg: ASbGncvTF2fDWwGLjy88Qqa0iECMorrTIcAeOa3JfNlObtYNo4cjY5bcPQFuUavC2Zn
	o8OqXCVe53D2sHCgGrjbxZT/xbQFoah/qEUln2iWyLRFsHPJr+to0ZqwYkH3c0lOvLlsNdrD+F5
	JN/TU1SqSqe9l/X5sqJPMjVzRfp/SxOeCdTMsOpMp6HDxtpA/GOrHv8ewZkemmPAcFtFnabQ3OY
	Dnfi3RZSSBvgYyj6NE2Eh1rz/rZr6v6lP0SWYUhu3kgPhvV/DskZOy3WQ1GmyLmpjvc4HO3PfbA
	MLlUqM75M8XlLzHIEGg7D5jg0VGDpVP1Sqlg9pqB54Hfzg==
X-Received: by 2002:a17:907:3fa2:b0:ac7:edc4:3d42 with SMTP id a640c23a62f3a-acad349a039mr946481066b.24.1744606774086;
        Sun, 13 Apr 2025 21:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQHfzSeAUj/TqqAU+tVLfI9UaIU4wpXQagNEC/sSIHQzzK1OE7CO/dsuYzuDxtr7NOkU2wVQ==
X-Received: by 2002:a17:907:3fa2:b0:ac7:edc4:3d42 with SMTP id a640c23a62f3a-acad349a039mr946478666b.24.1744606773610;
        Sun, 13 Apr 2025 21:59:33 -0700 (PDT)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4070sm847644766b.102.2025.04.13.21.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 21:59:32 -0700 (PDT)
Message-ID: <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>
Date: Mon, 14 Apr 2025 06:59:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/25 18:22, Andrii Nakryiko wrote:
> On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
>> file such that arbitrary BPF instructions are loaded by libbpf. This can
>> be done by setting a symbol (BPF program) section offset to a large
>> (unsigned) number such that <section start + symbol offset> overflows
>> and points before the section data in the memory.
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
>> The CVE report in [1] also provides a corrupted BPF ELF which can be
>> used as a reproducer:
>>
>>     $ readelf -S crash
>>     Section Headers:
>>       [Nr] Name              Type             Address           Offset
>>            Size              EntSize          Flags  Link  Info  Align
>>     ...
>>       [ 2] uretprobe.mu[...] PROGBITS         0000000000000000  00000040
>>            0000000000000068  0000000000000000  AX       0     0     8
>>
>>     $ readelf -s crash
>>     Symbol table '.symtab' contains 8 entries:
>>        Num:    Value          Size Type    Bind   Vis      Ndx Name
>>     ...
>>          6: ffffffffffffffb8   104 FUNC    GLOBAL DEFAULT    2 handle_tp
>>
>> Here, the handle_tp prog has section offset ffffffffffffffb8, i.e. will
>> point before the actual memory where section 2 is allocated.
>>
>> This is also reported by AddressSanitizer:
>>
>>     =================================================================
>>     ==1232==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c7302fe0000 at pc 0x7fc3046e4b77 bp 0x7ffe64677cd0 sp 0x7ffe64677490
>>     READ of size 104 at 0x7c7302fe0000 thread T0
>>         #0 0x7fc3046e4b76 in memcpy (/lib64/libasan.so.8+0xe4b76)
>>         #1 0x00000040df3e in bpf_object__init_prog /src/libbpf/src/libbpf.c:856
>>         #2 0x00000040df3e in bpf_object__add_programs /src/libbpf/src/libbpf.c:928
>>         #3 0x00000040df3e in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3930
>>         #4 0x00000040df3e in bpf_object_open /src/libbpf/src/libbpf.c:8067
>>         #5 0x00000040f176 in bpf_object__open_file /src/libbpf/src/libbpf.c:8090
>>         #6 0x000000400c16 in main /poc/poc.c:8
>>         #7 0x7fc3043d25b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
>>         #8 0x7fc3043d2667 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x3667)
>>         #9 0x000000400b34 in _start (/poc/poc+0x400b34)
>>
>>     0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)
>>     allocated by thread T0 here:
>>         #0 0x7fc3046e716b in malloc (/lib64/libasan.so.8+0xe716b)
>>         #1 0x7fc3045ee600 in __libelf_set_rawdata_wrlock (/lib64/libelf.so.1+0xb600)
>>         #2 0x7fc3045ef018 in __elf_getdata_rdlock (/lib64/libelf.so.1+0xc018)
>>         #3 0x00000040642f in elf_sec_data /src/libbpf/src/libbpf.c:3740
>>
>> The problem here is that currently, libbpf only checks that the program
>> end is within the section bounds. There used to be a check
>> `while (sec_off < sec_sz)` in bpf_object__add_programs, however, it was
>> removed by commit 6245947c1b3c ("libbpf: Allow gaps in BPF program
>> sections to support overriden weak functions").
>>
>> Put the above condition back to bpf_object__init_prog to make sure that
>> the program start is also within the bounds of the section to avoid the
>> potential buffer overflow.
>>
>> [1] https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>>
>> Reported-by: lmarch2 <2524158037@qq.com>
>> Cc: stable@vger.kernel.org
> 
> Libbpf is packaged and consumed from Github mirror, which is produced
> from latest bpf-next and bpf trees, so there is no point in
> backporting fixes like this to stable kernel branches. Please drop the
> CC: stable in the next revision.

Ack, will drop it.

> 
>> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
>> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
>> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> 
> libbpf is meant to load BPF programs under root. It's a
> highly-privileged operation, and libbpf is not meant, designed, and
> actually explicitly discouraged from loading untrusted ELF files. As
> such, this is just a normal bug fix, like lots of others. So let's
> drop the CVE link as well.
> 
> Again, no one in their sane mind should be passing untrusted ELF files
> into libbpf while running under root. Period.
> 
> All production use cases load ELF that they generated and control
> (usually embedded into their memory through BPF skeleton header). And
> if that ELF file is corrupted, you have problems somewhere else,
> libbpf is not a culprit.

While I couldn't agree more, I'm a bit on the fence here. On one hand,
unless the CVE is revoked (see the other thread), people may still run
across it and, without sufficient knowledge of libbpf, think that they
are vulnerable. Having a CVE reference in the patch could help them
recognize that they are using a patched version of libbpf or at least
read an explanation why the vulnerability is not real.

On the other hand, since it's just a bug, I agree that it doesn't make
much sense to reference a CVE from it. So, I'm ok both ways. I can
reference the CVE and provide some better explanation why this should
not be considered a vulnerability.

>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Reviewed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6b85060f07b3..d0ece3c9618e 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>                         return -LIBBPF_ERRNO__FORMAT;
>>                 }
>>
>> -               if (sec_off + prog_sz > sec_sz) {
>> +               if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
> 
> So the thing we are protecting against is that sec_off + prog_sz can
> overflow and turn out to be < sec_sz (even though the sum is actually
> bigger), right?
> 
> If my understanding is correct, then I'd find it much more obviously
> expressed as:
> 
> 
> if (sec_off + prog_sz > sec_sz || sec_off + prog_sz < sec_off)
> 
> We have such an overflow detection checking pattern used in a few
> places already, I believe. WDYT?

Sure, since we're dealing with unsigned numbers, the above is an
equivalent condition. And you're right that it better expresses the
intent so let me use it.

Thanks!
Viktor

> 
> pw-bot: cr
> 
>>                         pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
>>                                 sec_name, sec_off);
>>                         return -LIBBPF_ERRNO__FORMAT;
>> --
>> 2.49.0
>>
> 


