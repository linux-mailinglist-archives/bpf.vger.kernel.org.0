Return-Path: <bpf+bounces-22401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8F85E01E
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 15:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92E728B415
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBE79DD6;
	Wed, 21 Feb 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4TnO35y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96633D393
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526577; cv=none; b=Kekse0ym6IS/ccUdKwcT6ZRg6tWvkK74ZjqTB0ygSKbxoSUIrbDYZsI6NwiTzxOsL9lsfGfm6mDyKfnnIzX/OjfooEXkpWFoAD8R86y2ELPx2J7+9y/KJSk+MSg8G30ycaOdj5/4J6+orrh4aif87QypR9u7kc89HOBgB8C7nRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526577; c=relaxed/simple;
	bh=43bVyiWplXFt2wbJc+Gf9Zw4l8JmofgfevesSNZ22Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oihs2S9vNOkA3Ac2iIXVVAod1oe55uSUyckDquNUSUQuZ4T7Drisy0Jzwu+TTRtYAdI/knvFtJlvmhZhujd5TmtaMzbP7uUJB/OXHWlwvl1d1TmAvX8A/2W08WN2W1ywmlj+x+viwEOB9NiTJdR6t2tCcF6sNsLLoS1R2xH12v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4TnO35y; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-58e256505f7so4601508eaf.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708526575; x=1709131375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NkdXG6Lod3iIh4Xwkw1Ln7sgM48ZShVJhAl82V9nYjE=;
        b=C4TnO35ygU9wns7Rm70m5PN3e89flQGMbZ+CS48MUWPw3i6qPNW2Xj3EgJwKZDq9w5
         /DEytVb/K8ffxmiZWuTOuFJYs499mi+ovK4CMkqBPxzB0TCvxjxc41Uq8Sz32+fvBm6v
         9XAL6VmyjpWUAkIpj5SIJzTss09xg9a3/LFp2/tiGzW8W+ULlu0+91Rvp8B0EcHwGUqm
         bPkrqzeZ/mjPtdZmZnxwSVHF3YLHJHp9CiwGACz+E2NWGk3CjN/BXdEjVXCOipX0h4xl
         3XeBbv9XsXSjGbyd0JM88csreSdVbL2IDCnCG/TqEwUEDUXdfvsC+HCs4MM4L2jiSKa1
         wOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526575; x=1709131375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NkdXG6Lod3iIh4Xwkw1Ln7sgM48ZShVJhAl82V9nYjE=;
        b=HAVS12MpXHiN4LvrqBLlhn/QRNckHtxKjQHfRaJzQBYq3wCd45CWYXKdgbB1nPfQOR
         kTe6NvJi2svknHdX/WLyoeRfVNOqTByQzka4dTJLGp45Fq15wQ0Ow2YLaVUvuHBbgYKn
         uDIPiiIH4vSon1j9pDiLuNIYMnoZcjBnuoUL9taKoxLVxc0mZmXm/OQnuGw37NV9yshi
         Qwvqszp4H/tKhQxKVmsy58ObP+he1/AzHVFYoR8YxegX+XBBVSMDasHDG9JiMG2S8BL3
         HjWNRcISsBP7dBYGgAX9F3BZWj33bzEDWZ/SuRNXmtjfEvRv9KEFbUYcKEEYpA9kE0/l
         TIWQ==
X-Gm-Message-State: AOJu0YzltKsYNtI7FJfOjEUZHkitmONDgN8EmoiUxTRVJZjLTaPkqOkR
	Xt9HgpUKG5W/jGgb5Fjv5kx3CPLlugOe5BErSRfbMTgbAD71VikH
X-Google-Smtp-Source: AGHT+IH6DLTtzhXyXnrCcXsZ851t9b2sicQzuMlEPh4RRhx1NS4M4hNvmTatjHfgY5OTBcqlDUUl5A==
X-Received: by 2002:a05:6358:120b:b0:17b:5759:82ea with SMTP id h11-20020a056358120b00b0017b575982eamr2731721rwi.11.1708526574773;
        Wed, 21 Feb 2024 06:42:54 -0800 (PST)
Received: from [192.168.11.213] (220-136-196-149.dynamic-ip.hinet.net. [220.136.196.149])
        by smtp.gmail.com with ESMTPSA id h17-20020a63e151000000b005dc884e9f5bsm8688668pgk.38.2024.02.21.06.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:42:54 -0800 (PST)
Message-ID: <0574436a-0c2a-4089-9bd5-2ee4e0b39f71@gmail.com>
Date: Wed, 21 Feb 2024 22:42:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
 <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
 <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
 <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
 <CAADnVQJopb=p-w-RtrDPfNUePjtOO1QtMDEq0DW3nbG7nPL7wQ@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQJopb=p-w-RtrDPfNUePjtOO1QtMDEq0DW3nbG7nPL7wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/21 01:33, Alexei Starovoitov wrote:
> On Sat, Feb 17, 2024 at 5:43 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> Finally, here's the diff against latest bpf-next with asm to handle
>> percpu tail_call_cnt:
> 
> It is not against bpf-next.
> 
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
> 
> There is no such thing in bpf-next.
> 
> Please make a proper patch post following the rules in
> Documentation/bpf/bpf_devel_QA.rst

Sorry for my misunderstanding. I will send PATCH v2 instead, which is
against bpf-next truly.

I'll read the doc again to do better in the future.

Thanks,
Leon

