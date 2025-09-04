Return-Path: <bpf+bounces-67467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D77FB442BC
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 18:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA2A46629
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896723370F;
	Thu,  4 Sep 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn7SvQTp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F209231827
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003281; cv=none; b=IWsLozOw4fHp9eOGcNSpjEM1bM8jicOXR/2vbJFdNUJCOFyc/ogIVaqSGyhSmRIzfKOpTbRXSyb0/SD7v/mA3QfVGDKIg1wOZEB4z3OHxN3XzXP0YnIyCUxKeaUxRHvU07VJKJqJc4nTV8DWjP4gzSGZUId9GHVsENbKpERKMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003281; c=relaxed/simple;
	bh=fS2WB5KjYwZEMzmZCllYXKArUmA0IFlTO89kOBCmIiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBVLkLmBwJpT9PpuvvzKjXvtmYsw5Hndb/b4n7FpG1sndL32jRTVYzN3N/VTqO/t2p0s7sGE8wZK1gAE5zrzoJvwA1Yvs0Ilpd5CIqgZ/W8o6pXCAszPAgoZEx+sG2Zd+hWmE2Xb/ZpT0BEfgYEJQxsXRdW4D1OqHpKzcHYvTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn7SvQTp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77238a3101fso856860b3a.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757003279; x=1757608079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNoh6XQueZSIeBPDePiR4DWXats8jVRAEmD3MlVvwNI=;
        b=dn7SvQTpqWqYq9rKlq6wlMalV15vQQL1MdF/2UZL2o9zeITcEyLRb1a+a9IfbHMNzd
         d7DHEY/MYIfs06mLdCcvkmG+f6TVAFro3gJXCLTkhr/rKARV4MBwaiSYhOR3yFPScbKt
         ejPgcUXFZl73Rs6ywpAVz4/51OPwklKpDwkYxY0y+h5tf6noz+mbjE9+V4xkvG5CSFwQ
         9gUL/ACp4z4/s/5d/KJ84/6iZo0uE8IrZME0xOGeQqpkrDH5G4paShdYRwyS8vGysAGW
         3cndUvOHfz9f4n89bkpDcI1XYMRJSnujGCclE4y9I3lPObu/Ip6F9UlA4Oh3EhYEAfoX
         7gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003279; x=1757608079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNoh6XQueZSIeBPDePiR4DWXats8jVRAEmD3MlVvwNI=;
        b=vAoBYRB28UB/Y90cCXUe62cTD5qrd13I4qnHcTkz+MzgF8o7Jb3y1gSiobrgHAa4/t
         MqHc0crc4vzsd0T245ZGOA/gDGc/xpCkbQPq//VysTnsXFXu/LvC8A4E/gHCLkrfZGRW
         et2kZlE8Ap0YG7jmLlR0ge9UzOjFqc8pI6ucWpbrKiIG5z0a+zsPjT1VVoNmUX2guyqQ
         mLKeEn77KNvRXyFpPJ2j9atVjnoOagKA9yZ38Cbq3SWAHduDiIlLdLP8mPOxGA9VHOdP
         1nhrJcoIwVhr9IQ5m47aZOugEEhTg/5/ioYjBI/a+MOeDwZ5hRmUUv5nOcOWXK7vCBbv
         yveg==
X-Gm-Message-State: AOJu0Yw4eQwXvwMIYxYX6UMieOaAaxR+70xwi6PkbPLkSstvyXllWYdk
	i1oWFqGr6LkZmt7ZAjDrp4fh77chJNnSOwDjdlpr9sWNVhuZ6+PRWnHWJHriPA==
X-Gm-Gg: ASbGnct8Azw5u12iEQ7o/MKimma+tNTqlGwgMxh8uUeUgZyYnwKzoPASUr4MHQKVVvO
	RjdmkvBsskKucmbCBBmT3c3r/BRV8durbjxlwZHttFP3bYZ1GAOY9bRvmZp1w37Euj73cUYJ+BR
	bEp1xG/0XbtblXFDOOVs94a3dZL09Fe3ZKyDUPCf557zL4NaUwEcclAnqlkwenBz3aIdBOcY4i6
	5PLrrKDE082waz/NPOCJtJnqtRjyhgeLnbMG2vMCoAdwOgpdqesmRAc5jge9/5AWKbYbSpxjLR5
	1Dzuy82vrFKA1AVykZPoUaWMkfx45bZHKvmS9IYcsx/zn0sjxbv2ggNWg3PY2JpUniZkSwxmgIv
	KHvhaUCQstRlvyGXsCr8ezG1Aif7uLRTd/BQ4bBVe0ict+4WXuDokPWeFbUIZH4DutCnzVq77wg
	==
X-Google-Smtp-Source: AGHT+IHMjKD9EM57yI3XJKgUUOinkoL5TLe3GkMb+eFjXTEi2BRgeaOsjrNXX1y+K9r1BE0LTNFqVQ==
X-Received: by 2002:a05:6a00:a90:b0:771:bfed:bd61 with SMTP id d2e1a72fcca58-7723e33730fmr25529727b3a.17.1757003279343;
        Thu, 04 Sep 2025 09:27:59 -0700 (PDT)
Received: from [192.168.1.77] (c-76-146-12-100.hsd1.wa.comcast.net. [76.146.12.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26bc9csm19972137b3a.18.2025.09.04.09.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 09:27:58 -0700 (PDT)
Message-ID: <a3a927f6-7cad-46c7-9b20-89c9978acad7@gmail.com>
Date: Thu, 4 Sep 2025 09:27:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf: Craft non-linear skbs in
 BPF_PROG_TEST_RUN
To: Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
References: <cover.1756983951.git.paul.chaignon@gmail.com>
 <a3f372a017489ae75545f42a903b12710c2836ca.1756983952.git.paul.chaignon@gmail.com>
 <CAADnVQ+EGdXHBfzrm_FC2mxtZ-Y-VU5Py5GOt9KriC8hVfRB8A@mail.gmail.com>
 <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
Content-Language: en-US
From: Amery Hung <ameryhung@gmail.com>
In-Reply-To: <a9751ae4-adf1-4829-a5c9-2153e79d1ba9@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/4/25 9:02 AM, Daniel Borkmann wrote:
> On 9/4/25 5:56 PM, Alexei Starovoitov wrote:
>> On Thu, Sep 4, 2025 at 5:11 AM Paul Chaignon 
>> <paul.chaignon@gmail.com> wrote:
>>>
>>> This patch adds support for crafting non-linear skbs in BPF test runs
>>> for tc programs, via a new flag BPF_F_TEST_SKB_NON_LINEAR. When this
>>> flag is set, only the L2 header is pulled in the linear area.
>>
>> ...
>>
>>> +               /* eth_type_trans expects the Ethernet header in the 
>>> linear area. */
>>> +               __pskb_pull_tail(skb, ETH_HLEN);
>>
>> Looks useful, but only L2 ? Is it realistic ?
>> I don't recall any driver that would do L2 only.
>> Is L2 only enough to cover all corner cases in your progs ?
>> Should the linear size be a configurable parameter for prog_run() ?
>
> Yeah perhaps we could make this configurable. The ETH_HLEN is a common 
> case
> we've seen and also what virtual drivers pull in at min, but with NICs 
> doing
> header/data split its probably better to let the user define this as part
> of the testing. Then we're more flexible.
>

How about letting users specify the linear size through ctx->data_end? I 
am working on a set that introduces a kfunc, bpf_xdp_pull_data(). A part 
of is to support non-linear xdp_buff in test_run_xdp, and I am doing it 
through ctx->data_end. Is it something reasonable for test_run_skb?

> Cheers,
> Daniel


