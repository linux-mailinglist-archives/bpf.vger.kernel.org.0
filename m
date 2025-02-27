Return-Path: <bpf+bounces-52774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725AA48593
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204ED1776A0
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6AF1B85E4;
	Thu, 27 Feb 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6kqsSZf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA491C1F12
	for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674177; cv=none; b=hwUexjMkTH+6Ncs/0WYg9bfSyN1FF14axk2IL3J+RjafaeN3cj2CR7VYpaJYLB1krodlNwNUTs9WMrOVdMpL5NNk2/N2NKlhaDnR/BndEj8eeDdTKMM37YiExkWyT1TMAHis/dnKqYvVweoYCtjIwpX9jV/Z1A+8hTXK3JZULpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674177; c=relaxed/simple;
	bh=AB+l8lvbA8mhHi+d9dLAVegyDzsmv00OyIrOed0EGlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6hAOdEnqC78yLPNk6/6fRoDgNACUrK6t5U0than8VRX1FA+Abqm6ZnqpVrO3hM4v/vcnEW/c2zwJMGERKRXub/GTiDXEix5XVvZHAzN+s9NCReHSGHz4YJ8qlRsqk1hQt5P2b+FL/kjQsJ22zddqfQZ82W03f2vhOOpabO2x0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6kqsSZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740674174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/dDJpNE+yWQjvlVKGlgEsz0t/cIB1d3oT/kNmVlpwY=;
	b=c6kqsSZftnnb7DW5DQPB0L91OECj3vYBDPs0fyw6QHe71HWS+0vaz1FV0/Ko/15dxzkZYT
	R+wgxNXtu6Fu0uQPHE9R2gJ/CbZcOctudeuRr4biwOPLCzNG7eGM2Mdf3ptqI7ftgM/PjX
	MXI3klMtbHQt+qGGOT73iym4YpYvul4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-dRgvjLfrPaONhPks5IWz0g-1; Thu, 27 Feb 2025 11:36:13 -0500
X-MC-Unique: dRgvjLfrPaONhPks5IWz0g-1
X-Mimecast-MFC-AGG-ID: dRgvjLfrPaONhPks5IWz0g_1740674172
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso495970f8f.1
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 08:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674172; x=1741278972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/dDJpNE+yWQjvlVKGlgEsz0t/cIB1d3oT/kNmVlpwY=;
        b=n7nL8ALu4+atpaowxfrnXb3mAiRbzJScqAp/zW9Tb3yv3or0w+belI+TXqs8YxrrTZ
         5PYoXIqFzlyuWP3y8Cqv09XIsQywQoDWZsLMoA+XFGIyZRfuT7X+ZYICe9sdN7Rec2CZ
         clc0UDa1lC3cn9P70N8eopy7oitf/2A9FtoK2cHwW+YzKyWElAKf0f6gSeNnyf4uWKkv
         OwfvdTvMwYTGQOl2+JF+ci+vLNvFJ9t1Lrn+FSu3WFlDNEljiGTkATPIVCtaEi4ZRSIU
         gtrip/mIIAoApSisZOWU0Qqo8Vpmd8Cfm+lzqNCgl76PHqWs7ld4Oc5dUVPV3F08u9R5
         KHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUnwkwPR/T26ArguanpqKYCDMurqM5GBDFmNa1mnXyTb60fcotfbV1BM6AMC0PVMoalEno=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUPeYmcnpIFmQP8jhNI6FZUg7H+lMoYkXsPYuoMeCHYmAgecJ
	KhcMgLCuXusZMMg99K0ilEk43m3HYWEnQ9Pbtz1yUY+EzWfdz21Zg3txoDItHsEP6/YC2r2+Qtx
	7CwvhEKCcYxlY/SClvSnuzP5hZuFZuRSoLK9a7V8VGmqfkYw1
X-Gm-Gg: ASbGncv7DVThcNBYFNbsUsjqYHF20SEJVT1ZIlUqRbiuK+bnOGTzGCH4sbJzJBFF3cg
	DRXXEY+iNIX3M22NJc76o63jWPxYJapDA7My7YOo/0OdMAW0ZryxsNc84B4w7FTdkmiTo3kEDBy
	x7ec058Auj6Pv8VdOQ/qIvQ68qjHyktDyRNRhyfgAIJKJLSMqAoUhPVrLwqaHJUX9yAeMnFOOgp
	OJbJlKL8tkTTr1VN0VdiWEaYfAyMFpabFp6yKQTfJoHEFCNALWwYkmxKRUOoOvwctrGPPGmrilp
	RRlGDNoi37H0Mwf7XXisoue1AwMcDYiS8nQusW4saAwkgap/VA==
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-390cc6475ddmr10659478f8f.54.1740674172213;
        Thu, 27 Feb 2025 08:36:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAdW6AlETrETYKvhPXMU22VxBN3iRRbEButjcrmu6bhlc1staX/N+ZNcR8bcnEaan/0riKdQ==
X-Received: by 2002:a05:6000:18ad:b0:38a:615b:9ec0 with SMTP id ffacd0b85a97d-390cc6475ddmr10659454f8f.54.1740674171882;
        Thu, 27 Feb 2025 08:36:11 -0800 (PST)
Received: from [192.168.0.102] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a66adsm2533882f8f.25.2025.02.27.08.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 08:36:11 -0800 (PST)
Message-ID: <74dcffa5-9407-48fa-b91d-73cc7b588367@redhat.com>
Date: Thu, 27 Feb 2025 17:36:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string
 operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <cover.1727329823.git.vmalik@redhat.com>
 <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com>
 <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com>
 <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
 <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com>
 <CAADnVQKJr_Gmf1SjTpmVLSWaPi=0irza365_Jb2-3kOKhKULdg@mail.gmail.com>
 <CAADnVQLOq835yg2przDwvNfPNiJf4BW2Pczbj_Bf7Lfy1JP2ag@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLOq835yg2przDwvNfPNiJf4BW2Pczbj_Bf7Lfy1JP2ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/25 17:24, Alexei Starovoitov wrote:
> Viktor,
> 
> Are you still planning to work on string kfuncs ?
> 
> I think we more or less converged on requirements.
> So only a small matter of programming is left ? :)
> 
> If you're busy with other things we can take over.

Hi Alexei,

this slipped off my radar due to other priorities recently but I should
be able to get to it in the upcoming weeks. As you say, it shouldn't be
much work so I hope to get back with a v2 soon.

Thanks for poking me :)

Viktor

> 
> On Wed, Oct 9, 2024 at 7:03 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Thu, Oct 3, 2024 at 12:37 PM Viktor Malik <vmalik@redhat.com> wrote:
>>>
>>> Anyways, it seems to me that both the bounded and the unbounded versions
>>> have their place. Would it be ok with you to open-code just the
>>> unbounded ones and call in-kernel implementations for the bounded ones?
>>
>> Right. Open coding unbounded ones is not a lot of code.
>> We can copy paste from arch/x86/boot/string.c and replace
>> pointer deref with __get_kernel_nofault().
>> No need to be fancy.
>>
>> The bounded ones should call into in-kernel bits that are
>> optimized in asm.
>>
>> Documenting the difference in performance between bounded vs unbounded
>> should be part of the patch.
>>
>>> Also, just out of curiosity, what are the ways to create/obtain strings
>>> of unbounded length in BPF programs? Arguments of BTF-enabled program
>>> types (like fentry)? Any other examples? Because IIUC, when you read
>>> strings from kernel/userspace memory using bpf_probe_read_str, you
>>> always need to specify the size.
>>
>> The main use case is argv/env processing in bpf-lsm programs.
>> These strings are nul terminated and can be very large.
>> Attackers use multi megabyte env vars to hide things.
>>
>> Folks push them into ringbuf and strstr() in user space as a workaround.
>> Unbounded bpf_strstr() kfunc would be handy.
> 


