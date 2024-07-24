Return-Path: <bpf+bounces-35523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DD93B46B
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BA31F24242
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2DB15B97D;
	Wed, 24 Jul 2024 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHoA/ibQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88321598F4;
	Wed, 24 Jul 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836751; cv=none; b=qVoMeWqtz0BwqGnX4mB6miKEvrXU2xqL9CmxTMN3wSIEDXUUwn+zx7bG8NGmeZQwUUMgPA2Dj0sZIkOOPyLs0AIpxZnd9Du5UI6naE13+vPhBKRZ5mMM4lWlVWj7qEGdKZ+Npk4EYBwuaErhMFM23/YHHZZ3eMVCYWUd8vbYu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836751; c=relaxed/simple;
	bh=Dx2Nr7QBWT14vQe0l1RNPBOFDHK+O36WZ5NCMyposTU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dpXpUDsGnmn/lJ1wzIjM0Q9PK/kfadDA1zTw+JCkrpWD5dRtqEQCRM+Ea1tNlCSn8G+ZYolAPU7Rht8sPyCLqJBH/6awCVYL35VTPI5IEIVhTIRCIMpZZBimyga6UO/DCXprIUbQoQIkq+DDlCYP9eboiwDTPtixJjzlGhNjuyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHoA/ibQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC46C32781;
	Wed, 24 Jul 2024 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721836751;
	bh=Dx2Nr7QBWT14vQe0l1RNPBOFDHK+O36WZ5NCMyposTU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=bHoA/ibQ4DckOmpKNdRRYJYDpwo+rA1i8wDvhKrA+r+nRQe26GjM22a4GD5tlxkv8
	 Edjk/M7E8BwlZoV1P1bAu0rV6sbo4sBmffIbVEiYgs0OOa23+94tVBCIgPOiO4swOP
	 0RU1o16errY0Btlh9T0+12hS1KhbV9zXA4GYInw3R2/qifWwpBM7Ffivkz20fc0eb2
	 YqqYLfkQyAUfmcR8Vd1smzXuWxe7YDGdLAj1SNXBXTjS0z9N4ymhj/tgMssnLijFaB
	 7gpVOEGAHAzJQJXMMq2BsG2dSoontO1EQlNOznABcmhmvWwkhJWXBDUZMzb1clyPDk
	 e+tbftAPYl4UQ==
Message-ID: <db58f8bd-1ac6-45fc-a402-065d234d5161@kernel.org>
Date: Wed, 24 Jul 2024 16:59:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v4] tools/bpf: Fix the wrong format specifier
To: Markus Elfring <Markus.Elfring@web.de>,
 Zhu Jun <zhujun2@cmss.chinamobile.com>, bpf@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
References: <20240724111120.11625-1-zhujun2@cmss.chinamobile.com>
 <8c33ec2d-0a92-4409-96b0-f492a57a77ce@web.de>
Content-Language: en-GB
In-Reply-To: <8c33ec2d-0a92-4409-96b0-f492a57a77ce@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-07-24 17:43 UTC+0200 ~ Markus Elfring <Markus.Elfring@web.de>
>> The format specifier of "unsigned int" in printf() should be "%u", not
>> "%d".
> 
> * Please improve the change description with imperative wordings.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10#n94
> 


The wording is fine. The commit subject does use imperative. If
anything, the subsystem prefix should be "bpftool" rather than
"tools/bpf", something that can be addressed when applying, perhaps.


> * Would you like to add any tags (like “Fixes” and “Cc”) accordingly?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10#n145


"Fixes:" arguably, although there's no bug being fixed here, it's just a
clean-up. No need to respin the patch for that. Also there's no need to
Cc the author here, Jiong no longer works on this and the email address
you'll find in the logs is no longer valid.


> 
> 
> …
>> ---
>> Changes:
> …
> v4:
> Thanks! But unsigned seems relevant here, …
> 
> Please adjust the representation of information from a patch review by Quentin Monnet.
> https://lore.kernel.org/linux-kernel/2d6875dd-6050-4f57-9a6d-9168634aa6c4@kernel.org/
> https://lkml.org/lkml/2024/7/24/378


I'm not sure what you mean here. This part won't be kept in the commit
description anyway.

Zhu, for future patches I'd recommend keeping the history above the
comment delimiter (so that it makes it into the final patch
description), and writing a real description rather than copy/pasting
the feedback, which I believe is what Markus is commenting about?


> 
> 
> …
>> +++ b/tools/bpf/bpftool/xlated_dumper.c
>> @@ -349,7 +349,7 @@ void dump_xlated_plain(struct dump_data *dd, void *buf, unsigned int len,
>>
>>  		double_insn = insn[i].code == (BPF_LD | BPF_IMM | BPF_DW);
>>
>> -		printf("% 4d: ", i);
>> +		printf("%4u: ", i);
>>  		print_bpf_insn(&cbs, insn + i, true);
> …
> 
> How do you think about to care more also for the return value from such a function call?
> https://wiki.sei.cmu.edu/confluence/display/c/ERR33-C.+Detect+and+handle+standard+library+errors

Apologies, I'm afraid I don't understand what you're asking here, can
you please rephrase?

As far as I'm concerned I'm good with the current version of the patch.
Quentin

