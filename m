Return-Path: <bpf+bounces-20068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A983869E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 06:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803EE1C232FB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D35251;
	Tue, 23 Jan 2024 05:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWXuMBV4"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1D5225
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986796; cv=none; b=WxKdcPzBJRVXOknFZn4luuinMVKqzVfSTD0u+rYc6YL5u7GZiqrmVm75JgoCsSlMJVqcaRoSU7tYTlNdMgyuGpfIOzPZsmil1++cQ9NgFGrKVRd3cOGgracyZQ9d7yJrsiYkerVoFe1JbNlvY3fMUMYrWBATT3U+/zALcbm3S+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986796; c=relaxed/simple;
	bh=t/KCU56R+dFtiwauwVUeRePUW1od4vVajaPW4USQIi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnM/X20zu2kQaTJ6gTw/MiJ5JTsxc6UyGegM4SDTE+1oZptiNrlmaZOENGLpcFHKFakB5nfhn/01h0/2NoSJAAIKNOh1gioUUKqzr6EqVfJ2jFcC3K+QYVL0UKPchPD+XyQQI8k+G9dYwcR5QoAyNJBOc/O4N9+alfCtiOXOoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWXuMBV4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <58625a60-af4e-4a90-bd65-5fb6c0822d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705986791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4kzbtw5h/pedHWa9T6Y5qZbauanbD5GJ6RoxeeZneA=;
	b=oWXuMBV4FcP3nvy9Nz9ix5sFWm1QrSwt/+YGRq++nDb+lsSTSNxjyxF0fViB6xAzxCO/jK
	Ebn0cpQcYtl4ztX1PJAM4NsHj0t64bxJUmvA8QCbeTEFHK2ZqoAHihZEdTNtNRYEDVe7Fa
	BHyhEo3ktoe1nAXPA+0hOr9rPfjBnGY=
Date: Mon, 22 Jan 2024 21:13:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 43/82] bpf: Refactor intentional wrap-around test
Content-Language: en-GB
To: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-hardening@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-43-keescook@chromium.org>
 <15d65e11-d957-4b03-bec3-0dcd58b50f97@linux.dev>
 <6CE08B7D-7E0C-45E2-8A6B-32691BE40D08@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6CE08B7D-7E0C-45E2-8A6B-32691BE40D08@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/22/24 8:07 PM, Kees Cook wrote:
>
> On January 22, 2024 8:00:26 PM PST, Yonghong Song <yonghong.song@linux.dev> wrote:
>> On 1/22/24 4:27 PM, Kees Cook wrote:
>>> In an effort to separate intentional arithmetic wrap-around from
>>> unexpected wrap-around, we need to refactor places that depend on this
>>> kind of math. One of the most common code patterns of this is:
>>>
>>> 	VAR + value < VAR
>>>
>>> Notably, this is considered "undefined behavior" for signed and pointer
>>> types, which the kernel works around by using the -fno-strict-overflow
>>> option in the build[1] (which used to just be -fwrapv). Regardless, we
>>> want to get the kernel source to the position where we can meaningfully
>>> instrument arithmetic wrap-around conditions and catch them when they
>>> are unexpected, regardless of whether they are signed[2], unsigned[3],
>>> or pointer[4] types.
>>>
>>> Refactor open-coded wrap-around addition test to use add_would_overflow().
>>> This paves the way to enabling the wrap-around sanitizers in the future.
>>>
>>> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
>>> Link: https://github.com/KSPP/linux/issues/26 [2]
>>> Link: https://github.com/KSPP/linux/issues/27 [3]
>>> Link: https://github.com/KSPP/linux/issues/344 [4]
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: Andrii Nakryiko <andrii@kernel.org>
>>> Cc: Martin KaFai Lau <martin.lau@linux.dev>
>>> Cc: Song Liu <song@kernel.org>
>>> Cc: Yonghong Song <yonghong.song@linux.dev>
>>> Cc: KP Singh <kpsingh@kernel.org>
>>> Cc: Stanislav Fomichev <sdf@google.com>
>>> Cc: Hao Luo <haoluo@google.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: bpf@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>    kernel/bpf/verifier.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 65f598694d55..21e3f30c8757 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -12901,8 +12901,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
>>>    			dst_reg->smin_value = smin_ptr + smin_val;
>>>    			dst_reg->smax_value = smax_ptr + smax_val;
>>>    		}
>>> -		if (umin_ptr + umin_val < umin_ptr ||
>>> -		    umax_ptr + umax_val < umax_ptr) {
>>> +		if (add_would_overflow(umin_ptr, umin_val) ||
>>> +		    add_would_overflow(umax_ptr, umax_val)) {
>> Maybe you could give a reference to the definition of add_would_overflow()?
>> A link or a patch with add_would_overflow() defined cc'ed to bpf program.
> Sure! It was earlier in the series:
> https://lore.kernel.org/linux-hardening/20240123002814.1396804-2-keescook@chromium.org/
>
> The cover letter also has more details:
> https://lore.kernel.org/linux-hardening/20240122235208.work.748-kees@kernel.org/

Thanks for the pointer.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

>
>> The patch itselfs looks good to me.
> Thanks!
>
> -Kees
>

