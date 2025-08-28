Return-Path: <bpf+bounces-66776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5FB3920F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 05:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B9B188A455
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320725C838;
	Thu, 28 Aug 2025 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WXQRp7fC"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6111E1DF2;
	Thu, 28 Aug 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350097; cv=none; b=K861rZqxygfDgALbbaTsEkL86vDW4dBXrtvolFih/DGzRKTv3QrYVuU57HbXt702eh/aQYcicUQ6p0YuM8Tl9Vk4yJebZcCCqoPNkt+DX46RMe9ir6fhGw5iwbAmZOqM3Irn6AOmsJ/Ma1uxXLH9xera372vtEvHI83+KC9Nf2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350097; c=relaxed/simple;
	bh=kbpMvqBy89EU5abWhqd8q8RzotmgbmPsNuzS5ETak+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oz8ZLszq1Me+YMYzourJCl+zSVseCrrpFTEj0UuENdwZ0tp/Zk/oQ1muDC9lichf/1uiGEogxVG+ryGzI5Ojl9GAx3TL0atyFiRFXsjqEanX9r1HToP1NkB0nWqOgkGWClASxnJSoyaO/X4xNUpCR1fFHkKTYUN1H4A4CYRlGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WXQRp7fC; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756349791;
	bh=8n1wZcIHNzwg934W9DUCGLByjL9f9WgFoS8AoMdttMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WXQRp7fCDETqZ9hYxvxQRq9wyeWX2e9PthHt+f6cu5n1AedeQRbX9tFZTnaZL1xsE
	 Bm2lZG1RAaSxEDQgcdN//XXQFOk0s7e0ECRB4Ons2WbqZYkE75TzUs/I7C1k9NxaJJ
	 uN2OdGWDdWcm6mc3EVYbXpZKuSCDnIEHdn+FDFms=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id E163D484; Thu, 28 Aug 2025 10:56:22 +0800
X-QQ-mid: xmsmtpt1756349782tmu8u1h6f
Message-ID: <tencent_8E830DF8843CB38A2F4354FC5E3146651009@qq.com>
X-QQ-XMAILINFO: MoH7Vt6T4pB2q+9UHtYJFMOqHHoFZsvbrVlUPMmMCvUEbPq21z8CDNoQkfV9q1
	 muplOkm3XPBO6LAJhCxhpBp0F24/Zi0DunNWWBK+7glGdr0vB9nj4RQCYrqJZH8Q0x9XDAisVV6E
	 q2lqjiePybmA0IeyHY7suk6DrT7iVdXPpIrCGdW/qM7lgx+eK2KSZfEr5QAtaVXyILe5bkHRv2q+
	 /Nyh1ydPmiK9TK9+Q+CGBtgLzGkvMMMVUZKZSQlLMQA+OZPeE8hPCw0ZJVy0Xb372RrZ53cRiYBM
	 F2RJaV7n7IgEDJXWFf74ioE2MhgyJQKvrmeIVsJBBizbL/HwQZXtSs838bF8OKWbQqUAmb1R9yjg
	 TtRNlIhsBXg/wXrhstB/ZzlCYjiePcLA860zULbhqq1oQVyBJErdQRDnVtqRvFB1SxpPmGntmiaH
	 XKxgk3IFHtuBJc/uCpXmQMNxVjBRqT8TPK4RQ4d0jGCzkI5gEaJs/LlnWIItqNsiMVmIBp58NJKK
	 E+LQvLuZB3f1Y4cqvkpc+50mxz5RXwl55rhEYu28wgb/K0HlrepT7qKWpKSzBzoGK8ebCckDNfu1
	 sHIztPaQFQNTSTj8Sxx2Ebu0qhGAUFx4wwyHfFEVZx1/Zur0MHIeYPtSR9gmu3q6zJDKKMt/L7Zu
	 scxhwlTpKmCyeWN3+JBMFKHgJe5CFX1pUVjr1H+rJ8K3HnalQ9egCby+Y3YgldUXDPbo8R15Mbzh
	 0a7nlUZ/EiP32yO9XH+I3aJwFcuGNuq5OSKR71VJfr1d4PE5hZgocnj1tjslJ6aABM7+QeEVyiwB
	 d73noUGFx15yRBe/R6jLfo7HGq5SlrUXW2wmoxN8rN2YStBKxuD4bA/HwE8lBY+OFvSBUF8nubkL
	 55t1ieoN2N5uAmjKPfBmuEa5FpSNMYSfB44rV8YW30O51F0GCfBCg2mhbQpCs5YZ6bAXyh6StiHO
	 7ynMNO+v1TdzyFTXoufZYZB39JXFz8++eL4RnKwzDHGxY24qxhdksA10FVBhX0z2Cz27GXG+V5vy
	 jtgUfmy8dJXihRcfpicpbbeSz7eGIlaUVF6QAoUcKsbg8w2/x/qWwjzePTynXWEvSNpQ0pVyQcT2
	 HsBevljh0LmCz+q2g=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <fada38a0-f344-4873-a1df-2dcbe16a27de@foxmail.com>
Date: Thu, 28 Aug 2025 10:56:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/helpers: bpf_strnstr: Exact match length
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Viktor Malik <vmalik@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, rongtao@cestc.cn,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <tencent_65E5988AD52BEC280D22964189505CD6ED06@qq.com>
 <CAEf4BzaMUEPjix29JjiYCt1JmWcz97gemSpXL9iD9Gc-g+yZYw@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAEf4BzaMUEPjix29JjiYCt1JmWcz97gemSpXL9iD9Gc-g+yZYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/25 06:35, Andrii Nakryiko wrote:
> cc'ing Viktor as well
>
> On Tue, Aug 26, 2025 at 9:29 PM Rong Tao <rtoax@foxmail.com> wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> strnstr should not treat the ending '\0' of s2 as a matching character,
>> otherwise the parameter 'len' will be meaningless, for example:
>>
>>      1. bpf_strnstr("openat", "open", 4) = -ENOENT
>>      2. bpf_strnstr("openat", "open", 5) = 0
> please add these cases to the tests
>
>> This patch makes (1) return 0, indicating a successful match.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 401b4932cc49..65bd0050c560 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -3681,6 +3681,8 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
>>                                  return -ENOENT;
>>                          if (c1 != c2)
>>                                  break;
>> +                       if (j == len - 1)
>> +                               return i;
> But this seems like a wrong fix. The API assumes that s2 is
Thanks a lot Andrii Nakryiko, I just submit V2, please review.
> well-formed zero-terminated string, and so we shouldn't just randomly
> truncate it. Along the examples above, what will happen to
> bpf_strnstr("openat", "open", 3)? With your fix it will return
> success, right? But it shouldn't, IMO, because "open" wasn't really
> found in the first 3 characters of, effectively, "ope".
>
> We should also test bpf_strnstr("", "", 0)... ;)
>
>
> So maybe something like this (but I haven't really tested it):
>
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..ced7132980fe 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3672,10 +3672,12 @@ __bpf_kfunc int bpf_strnstr(const char
> *s1__ign, const char *s2__ign, size_t len
>
>          guard(pagefault)();
>          for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -               for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +               for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
>                          __get_kernel_nofault(&c2, s2__ign + j, char, err_out);
>                          if (c2 == '\0')
>                                  return i;
> +                       if (i + j == len)
> +                               break;
It's works fine, thanks.
>                          __get_kernel_nofault(&c1, s1__ign + j, char, err_out);
>                          if (c1 == '\0')
>                                  return -ENOENT;
>
>
> pw-bot: cr
>
>
>>                  }
>>                  if (j == XATTR_SIZE_MAX)
>>                          return -E2BIG;
>> --
>> 2.51.0
>>
>>


