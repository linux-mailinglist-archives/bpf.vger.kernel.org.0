Return-Path: <bpf+bounces-39511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360E89741C9
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 20:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E002D1F27060
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054821A0B0D;
	Tue, 10 Sep 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rfUAc5ln"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972301990D7
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725991981; cv=none; b=icEzKiz/uM+TNF+wGS3vBAVN0vUUJeiglrwtNqCfKnIA8Qy0c6IjHEDC1TXydCfGbsPRiYQcxYf6FoPaMjF0YNiKfo0sWowcKlq7EBT1bG3bkOJrK3xvMXzPUl4fJqEOHt5o1tSb9IpmGa4X7L5jp+ayN746uoipCjTS24b8R8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725991981; c=relaxed/simple;
	bh=l+XAHITzXMLlmACUGto0i5TcIyat/5wnW+YH037Q+iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktKkU7xTef4WwQ35GpLwl7cUgLIITTdmGnLaSQvKVEHCv9Zu7ThOVlBkJ9Pqd1BdmWn5vQFESSqGmEEZW2qMqGdEqUxH3g6eGs1+uLd715zTeW8CVCmUkOEaN/mJ0eF2TaZ03esAtBfGBg1EWRgF/JqoI8dZcPXlJmJaA+GUyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rfUAc5ln; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70c5db56-4117-4820-9089-f6a6bfe92e2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725991976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7f8MS/o8Rj5iP3/ibYA87XvITyOcKRgrFyPVnWPu/k=;
	b=rfUAc5lnvIwqIlpRDw5lGEiPOwiBTupKmfqnEAWWFAuB++1HUB6nVT/emnAnvFV7scUAbf
	pr0Aeh/Vg4II5mPOLHX/IF4AhxUP9Jp9JroJz2FNl7LlZ5C9kIiMgAPXETtRsiHhtr4haf
	99a2Tp3I9dbzEXYXpI4+RB5EY1RudEU=
Date: Tue, 10 Sep 2024 11:12:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel oops caused by signed divide
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>,
 Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 bpf <bpf@vger.kernel.org>
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev>
 <18d101db038f$f3c2d400$db487c00$@gmail.com>
 <ff27a7ba-e3b3-4cd9-85a8-55c10756df5d@linux.dev>
 <CAADnVQKNG-EAv6t-CuCWCOX-Tm9=b6fHD3bwWgJirnQ93V=tzw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKNG-EAv6t-CuCWCOX-Tm9=b6fHD3bwWgJirnQ93V=tzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 9/10/24 8:21 AM, Alexei Starovoitov wrote:
> On Tue, Sep 10, 2024 at 8:18 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 9/10/24 7:44 AM, Dave Thaler wrote:
>>> Yonghong Song wrote:
>>> [...]
>>>> In verifier, we have
>>>>      /* [R,W]x div 0 -> 0 */
>>>>      /* [R,W]x mod 0 -> [R,W]x */
>>>>
>>>> What the value for
>>>>      Rx_a sdiv Rx_b -> ?
>>>> where Rx_a = INT64_MIN and Rx_b = -1?
>>>>
>>>> Should we just do
>>>>      INT64_MIN sdiv -1 -> -1
>>>> or some other values?
>>> What happens for BPF_NEG INT64_MIN?
>> Right. This is equivalent to INT64_MIN/-1. Indeed, we need check and protect for this case as well.
> why? what's wrong with bpf_neg -1 ?

I think you are right. 'bpf_neg <num>' should not cause any exception.
In this particular case 'bpf_neg LLONG_MIN' equals LLONG_MIN.

On arm64,

# cat t4.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = LLONG_MIN;
   printf("-a = %lld\n", -a);
   return 0;
}
# gcc -O2 t4.c && ./a.out
-a = -9223372036854775808

In the above -a also equals LLONG_MIN.

On x86, we get the same result.

$ uname -a
Linux ... #1 SMP Wed Jun  5 06:21:21 PDT 2024 x86_64 x86_64 x86_64 GNU/Linux
$ cat t4.c
#include <stdio.h>
#include <limits.h>
int main(void) {
   volatile long long a = LLONG_MIN;
   printf("-a = %lld\n", -a);
   return 0;
}
$ gcc -O2 t4.c && ./a.out
-a = -9223372036854775808
$ clang -O2 t4.c && ./a.out
-a = -9223372036854775808




