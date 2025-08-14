Return-Path: <bpf+bounces-65600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B643B25BC9
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F17228F9
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBD242D8E;
	Thu, 14 Aug 2025 06:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDE450276;
	Thu, 14 Aug 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152976; cv=none; b=Rg2p6shg0OuWs4HqsDMc5jw2HW95NN5bQTLsgQKf5PX95/tnxYioKGMoHsr5Rx5ZGcLBsxdXHHbLjROdrHIFeO1nS8lL1buLTyyOJcQn5pGBuvAM61aTL2k/I7NHYgNmnnvov6p1TGGcGv1vBHrrgc/xXyg2AYOL/LyrtjLrQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152976; c=relaxed/simple;
	bh=mHrZ3pJ8EWpvZlPK0OvhbaUzb9eALq4tdkF+Y/M64hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MauylEOL8zeAM8anm0m2y+6I2hB5oyenw3YHrIdzGicUHE551Lj5VHrRPJLPDmC/0YJEJ2nIcBsbPItXYrhGtap979WSaAAYtO9BpMSaFgDi0OOV3h2QcQuIukEPSRCIeIyMJrMng15A04Qoggq0KmPofwXVv9mAxM5DKL2drcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7f5.dynamic.kabel-deutschland.de [95.90.247.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E494561E647BA;
	Thu, 14 Aug 2025 08:28:42 +0200 (CEST)
Message-ID: <2ec36cd7-7378-4e44-894a-93008348a96a@molgen.mpg.de>
Date: Thu, 14 Aug 2025 08:28:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/5] ethtool: use vmalloc_array() to
 simplify code
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-2-rongqianfeng@vivo.com>
 <af057e48-f428-4c34-8991-99959edbabd2@molgen.mpg.de>
 <abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Quianfeng,


Thank you very much for your reply.

Am 14.08.25 um 06:05 schrieb Qianfeng Rong:
> 
> 在 2025/8/13 0:34, Paul Menzel 写道:

[…]

>> Am 12.08.25 um 15:32 schrieb Qianfeng Rong:
>>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>>> simplify the code and maintain consistency with existing kmalloc_array()
>>> usage.
>>
>> You could build it without and with your patch and look if the assembler
>> code changes.
> 
> Very good point, the following experiment was done:
> //before apply patch:
> objdump -dSl --prefix-addresses fm10k_ethtool.o > original.dis
> 
> //after apply patch:
> objdump -dSl --prefix-addresses fm10k_ethtool.o > patched.dis
> 
> diff -u original.dis patched.dis | diffstat
> patched.dis | 1578 ... 1 file changed, 785 insertions(+), 793 deletions(-)
> 
> From the above results, we can see that the assembly instructions are
> reduced after applying the patch.
> 
> 
> #define array_size(a, b)    size_mul(a, b)
> 
> static inline size_t __must_check size_mul(size_t factor1, size_t factor2)
> {
>      size_t bytes;
> 
>      if (check_mul_overflow(factor1, factor2, &bytes))
>          return SIZE_MAX;
> 
>      return bytes;
> }
> 
> void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
> {
>      size_t bytes;
> 
>      if (unlikely(check_mul_overflow(n, size, &bytes)))
>          return NULL;
>      return __vmalloc_noprof(bytes, flags);
> }
> 
> And from the code, array_size() will return SIZE_MAX after detecting
> overflow.  SIZE_MAX is passed to vmalloc for available memory
> verification before exiting and returning NULL. vmalloc_array()
> will directly return NULL after detecting overflow.

Awesome! Thank you for digging that up. Maybe something to add to the 
commit message. Maybe something like:

`vmalloc_array()` is also optimized better, resulting in less 
instructions being used, which can be verified with:

objdump -dSl --prefix-addresses <changed module>.o

>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

