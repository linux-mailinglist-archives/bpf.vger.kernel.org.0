Return-Path: <bpf+bounces-26140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF989B6D2
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 06:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D451F217E6
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 04:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B56522F;
	Mon,  8 Apr 2024 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ScFCVHGU"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4EA749C
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550298; cv=none; b=oDfV11ZiDkZyvgYY77IZ3N88GzAhtw72uGbXNJLsfTDVA9oxZ72cwPmFGzq0vFvZdfI5tG1hLBnhWFhWEWU3J6lyZfHBNyHEflCSL5d9JIy02jIr8TrbtFYy18CSwnYwDFo+DH8mtrw0ntiXbILD0UAewpEBtFbmk+5fmHIvNLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550298; c=relaxed/simple;
	bh=RJHaUybm/GCoa8wCU4iwZ5BuwD186II6yeqIXMsSDOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6liunqx8ny5V3uiSstmshtwxeLkil2D3+/auV6zdDiuZhM3/QFc9Ty/gxqv9qrqn+HOvDGKin8ibyk/Qgn78dL0rqN5xpmZ5ILi/DrltnmQxZFtIcUb7ymjI/QBnbTgdKlOCsfUnEYnMa3Cmx/DjZA5KeorJQ8lIpxFd7kuW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ScFCVHGU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <471352dd-a0f1-4d28-8ad7-3c0cad5c6924@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712550294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lK2Kp3EATkvtmYCZNh14muN68EB5sVTi6XZjjCM6bdg=;
	b=ScFCVHGUjVkr1ODw5H2C7VQYrpgrgdv27jz66iOFUdfYWh0Njf2JWYBooeOt3HVv0ypgJP
	A+VCx2tCY4Svy2pEswpplqpp/7lR4umdbtBPn8pJAP4mFqfqV/qeeZdzNxGtUyv5oFCW3E
	EPhDKf/9nzKWJv+zDhUKz1lX3dufhIo=
Date: Sun, 7 Apr 2024 21:24:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240406160359.176498-1-yonghong.song@linux.dev>
 <20240406160404.177055-1-yonghong.song@linux.dev>
 <CAEf4BzZTM5Ce+EEhTWPkt4C5PjtC9JRrWQzw1ZGU_oiCqQSi7Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZTM5Ce+EEhTWPkt4C5PjtC9JRrWQzw1ZGU_oiCqQSi7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/6/24 11:47 AM, Andrii Nakryiko wrote:
> On Sat, Apr 6, 2024 at 9:04 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> Add bpf_link support for sk_msg and sk_skb programs. We have an
>> internal request to support bpf_link for sk_msg programs so user
>> space can have a uniform handling with bpf_link based libbpf
>> APIs. Using bpf_link based libbpf API also has a benefit which
>> makes system robust by decoupling prog life cycle and
>> attachment life cycle.
>>
>> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf.h            |   6 +
>>   include/linux/skmsg.h          |   4 +
>>   include/uapi/linux/bpf.h       |   5 +
>>   kernel/bpf/syscall.c           |   4 +
>>   net/core/sock_map.c            | 270 ++++++++++++++++++++++++++++++---
>>   tools/include/uapi/linux/bpf.h |   5 +
>>   6 files changed, 277 insertions(+), 17 deletions(-)
>>
> Please check bpf_prog_attach_check_attach_type(), it probably should
> be updated as well. Other than that looks good.

We are fine here. In function attach_type_to_prog_type(), we already
have checking:
         case BPF_SK_MSG_VERDICT:
                 return BPF_PROG_TYPE_SK_MSG;
         case BPF_SK_SKB_STREAM_PARSER:
         case BPF_SK_SKB_STREAM_VERDICT:
         case BPF_SK_SKB_VERDICT:
                 return BPF_PROG_TYPE_SK_SKB;

>
> [...]
>
>>   static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>> -                               struct bpf_prog *old, u32 which)
>> +                               struct bpf_prog *old, struct bpf_link *link,
>> +                               u32 which)
>>   {
>>          struct bpf_prog **pprog;
>> +       struct bpf_link **plink;
>>          int ret;
>>
>> -       ret = sock_map_prog_lookup(map, &pprog, which);
>> +       ret = sock_map_prog_link_lookup(map, &pprog, &plink, NULL, link && !prog, which);
>>          if (ret)
>> -               return ret;
>> +               goto out;
> probably could have kept `return ret;` here?
>
>> -       if (old)
>> -               return psock_replace_prog(pprog, prog, old);
>> +       if (old) {
>> +               ret = psock_replace_prog(pprog, prog, old);
>> +               if (!ret)
>> +                       *plink = NULL;
>> +       } else {
>> +               psock_set_prog(pprog, prog);
>> +               if (link)
>> +                       *plink = link;
>> +       }
>>
>> -       psock_set_prog(pprog, prog);
>> -       return 0;
>> +out:
> and wouldn't need out: then

Ack. I can make this change.

>
>> +       return ret;
>>   }
>>
> [...]

