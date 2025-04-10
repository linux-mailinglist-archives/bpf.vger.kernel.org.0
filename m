Return-Path: <bpf+bounces-55649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C674A8416C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1151B686C6
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 11:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC628136B;
	Thu, 10 Apr 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Szv8DtBI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BE28137A
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283098; cv=none; b=Ts0jCAxp7OnJI2XeDdbWfdil/Hzqs53Hrc8PUxGER1hPradp/907awC7WAit4e+65/xbWYzbX3YhV7hjpVuY4kMm6FhcAfC2yRBRtbJAU9MbxsriHOdNh9LNadoTgWrOAkbInXX0BqsChrtF00GQbi5ziFODqy19jV/besZT/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283098; c=relaxed/simple;
	bh=U6YpTNnXFyfVhoNVKHTqL8+82bdmJgpeagh1gGFuEJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0wDMh6IG8/mUNvhcxi2XYaxIhKWk4aBzkWDKZQr/wK5xFGj7ND8QrpjLIpP/MnXmygYUyHAuYrbYjC9PnwsYcvc290iBCIvqpO/zX2+pTSr5LofXRfZJ4xcSOBRNLB5F5kSWO03tnOV4oEAzIgWYipohTh9de5Ns6W7BEmAtLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Szv8DtBI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744283095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4Rn5cKFbw5okTNwBi7RFOogyJkx5X7iwnJVW937AvY=;
	b=Szv8DtBIe9z5a0RsjQ0i4mnxB1DqYQWlMvBAhqLVc1atf8eqn1XoAEy/STNbqRvAHOctxg
	Dhe6sL1aWffo7fG2dwm6VrB8YncsxG4BTOL979LJ3swgLHrx15mt7yM9DpX2t4kq6cDtvh
	2ntwETw/WP2P2GuKcjQ+sWHAgsx0Qeg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-puWM1h6yP-2QnYMl6394AA-1; Thu, 10 Apr 2025 07:04:54 -0400
X-MC-Unique: puWM1h6yP-2QnYMl6394AA-1
X-Mimecast-MFC-AGG-ID: puWM1h6yP-2QnYMl6394AA_1744283093
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so3868035e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 04:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283093; x=1744887893;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4Rn5cKFbw5okTNwBi7RFOogyJkx5X7iwnJVW937AvY=;
        b=ljcWEb9OLHXzytxRiQaBQLEoGnmlyuq6kb8yPbw8iqtKUIHPJ8qhQmRejMIjEawSf+
         HoakxTXaDwoLhc2FSsqdn1xyNHDjs5+Y9SsfxSB5vcGOIbigxWA52qqU57oTt1ibebSu
         JLfxD8spJBqNrsYqU1phhk451RecnU9idBzgKZIPoKlpHi0EkEAB9ls8rVkDs3las/Qv
         2DKFZtlEmkSzVvkbmDWmXyJfSSNOy1tlLyOahhJdeKJ0CibkgtWbNksVFGLdONbTX3QR
         e9c3fnhIZZ081UD6Ji1pXj6YB2chGMuw12ZAHjY9+E/PfljB4Mq0avmJzOHVpg43joAT
         eg0g==
X-Gm-Message-State: AOJu0YxcZIV8o06i6n/YfMd93bIExEFUP/VTl7uiBYSSEjPR0gZ0fiAP
	C0xdsaYTEAPV04cWL+2KWCyyeMFm9o4FjFTfiomLPygxN93buPAA6JKBES07BWPsUX1vp4C4bEL
	3x6fkKNxWc742gCfMOK4jyk9onX/AAtdKBke0dHRLco+KF5Dr
X-Gm-Gg: ASbGncteJVWaKprAZNrEx+TNYOsEqhOzAye5rZb6F3ESpE2pnlZ/Bofhr19XjypyCsX
	epOUUXIyE53YqqkLKcMGzk1BC9pn5qQjaOR4vL48MpzoLNEOMUrA1MlsSHqCfQCVYTbTSGgOFk1
	O03OJNi/UoUYTXrG0mg6LDcUci4tyzqTfu2Bz9umZjmZUva7Vi4gJLjRnD4ipLnIAOwejOp9iGh
	bpTiYoIruYGilIVgqcqayjcEtBF+AhFAP3FRTOlcFNYLVE2WVDQad9/wbsvvQ0UmfIp4bnXlvTG
	hNu/Hto=
X-Received: by 2002:a05:600c:4f4f:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43f2d9a13camr20746135e9.32.1744283092675;
        Thu, 10 Apr 2025 04:04:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtdlmexzJO1T/HWw1Ca7ZVb36I/csxvxbgVf11LNIVPB8YuXwD0vHfehEkM4jmAFcQnac1yQ==
X-Received: by 2002:a05:600c:4f4f:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-43f2d9a13camr20745805e9.32.1744283092255;
        Thu, 10 Apr 2025 04:04:52 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5b08sm49036245e9.33.2025.04.10.04.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 04:04:51 -0700 (PDT)
Message-ID: <9657d4a8-b49d-420d-a618-1cf782eb423a@redhat.com>
Date: Thu, 10 Apr 2025 13:04:49 +0200
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
 <09662c0c-8643-4188-849b-adff38e32c23@redhat.com>
 <ttbuf2polzcve56wdthptduyloy72ysy5ld4ar2ihuziuiuuma@3uzo6emqjvlx>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <ttbuf2polzcve56wdthptduyloy72ysy5ld4ar2ihuziuiuuma@3uzo6emqjvlx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 12:09, Shung-Hsi Yu wrote:
> On Thu, Apr 10, 2025 at 10:56:19AM +0200, Viktor Malik wrote:
>> On 4/10/25 10:16, Shung-Hsi Yu wrote:
>>> I was about to sent my fix, just to realize I got beaten by half and
>>> hour+ even with my 6 hour timezone advantage :)
>>
>> :)
>>
>>> On Thu, Apr 10, 2025 at 09:34:07AM +0200, Viktor Malik wrote:
>>>> As reported by CVE-2025-29481 (link below), it is possible to corrupt a
>>>> BPF ELF file such that arbitrary BPF instructions are loaded by libbpf.
>>>> This can be done by setting a symbol (BPF program) section offset to a
>>>> sufficiently large (unsigned) number such <section_start+symbol_offset>
>>>> overflows and points before the section.
>>>>
>>>> Consider the situation below where:
>>>> - prog_start = sec_start + symbol_offset    <-- size_t overflow here
>>>> - prog_end   = prog_start + prog_size
>>>>
>>>>     prog_start        sec_start        prog_end        sec_end
>>>>         |                |                 |              |
>>>>         v                v                 v              v
>>>>     .....................|################################|............
>>>>
>>>> Currently, libbpf only checks that prog_end is within the section
>>>> bounds. Add a check that prog_start is also within the bounds to avoid
>>>> the potential buffer overflow.
> 
> Looking this again, I realize the above does not exactly describe the
> code change. The 'sec_off >= sec_sz' check was instead  a check for the
> following situation:
> 
>     sec_start                        sec_end  prog_start      
>        |                                |         |           
>        v                                v         v           
>   .....|################################|...............
> 
> And it was symbol_offset/sec_off + prog_size/prog_sz that overflowed
> when running the reproducer, not sec_start/data + symbol_offset/sec_off,

Here are the relevant parts of the bpf_object__add_programs function:

    static int
    bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
                             const char *sec_name, int sec_idx)
    {
        ...
        void *data = sec_data->d_buf;
        ...
        for (i = 0; i < nr_syms; i++) {
            ...
            prog_sz = sym->st_size;
            sec_off = sym->st_value;
            ...
            if (sec_off + prog_sz > sec_sz) {
                pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
				        sec_name, sec_off);
                return -LIBBPF_ERRNO__FORMAT;
            }
            ...
            err = bpf_object__init_prog(obj, prog, name, sec_idx, sec_name,
                                        sec_off, data + sec_off, prog_sz);
            ...
        }
    }

You are correct that `sec_off + prog_sz` overflows and therefore
bypasses the existing check.

However, the actual problem is IMO elsewhere. Above, sec_data->d_buf
points to a memory buffer allocated by libelf which holds the section
data. Therefore, `data + sec_off` passed to bpf_object__init_prog will
overflow (as sec_off is 0xffffffffffffffb8) and point before the buffer
itself. This is also what AddressSanitizer reports by:

    0x7c7302fe0000 is located 64 bytes before 104-byte region [0x7c7302fe0040,0x7c7302fe00a8)

Next, bpf_object__init_prog does:

    static int
    bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
                          const char *name, size_t sec_idx, const char *sec_name,
                          size_t sec_off, void *insn_data, size_t insn_data_sz)
    {
        [...]
        memcpy(prog->insns, insn_data, insn_data_sz);
        [...]
    }

which is where the buffer overflow happens as insn_data points before
the memory buffer holding the section.

So, I believe that the actual problem stems from the overflow of
`data + sec_off` (i.e. prog_start) and therefore my description is
accurate.

Viktor

> though maybe that could still happen further down in the call to
> bpf_object__init_prog(), I'm not sure.
> 
> The change does indeed address the issue surface by the reproducer
> though. Just different from what the above describes.
> 
> 
> Shung-Hsi
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 6b85060f07b3..d0ece3c9618e 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -896,7 +896,7 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
>>  			return -LIBBPF_ERRNO__FORMAT;
>>  		}
>>  
>> -		if (sec_off + prog_sz > sec_sz) {
>> +		if (sec_off >= sec_sz || sec_off + prog_sz > sec_sz) {
>>  			pr_warn("sec '%s': program at offset %zu crosses section boundary\n",
>>  				sec_name, sec_off);
>>  			return -LIBBPF_ERRNO__FORMAT;
> 
> ...
> 


