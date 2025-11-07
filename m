Return-Path: <bpf+bounces-73941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE04C3EAAA
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 07:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039F8188B762
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 06:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C94304BDF;
	Fri,  7 Nov 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="fak4xDyk"
X-Original-To: bpf@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569EB30497C;
	Fri,  7 Nov 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498716; cv=none; b=jucjaFPDBomSFAxY8VE7hWqXJoYt9A6biQVA8SYzbHD/BscBDqhwJm+9m3wI7peYC0pR7nf9xfaIiWb7xVltXOj8RWGyDd4FbWXeWqQExsvlq2leC194YunpXoR43+tXIPXwi2pgis6UNWlNA+PKYgY4WjsP8/EC0RI/a6sDBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498716; c=relaxed/simple;
	bh=WB/W09ZH7AM/kwynGqLiO2jAqRASpyMZeZ3DfMpSwqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjyKHTOntbz0zPP+O8CP0+/kgOwMGhqtn7HCEI+hZKMRpweFJHL7so7jRx8k1Yvipc8E9UvntWne1RP2Li+gEqYFDz0jseJYwMlmJychGsoJGUN1JCReQk2RSn+Yy11SCg16EpI0/2QmVgEuHmm71lfR8l8fXwwNIFnROMjKgl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=fak4xDyk; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:6518:0:640:e091:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 07260C1E42;
	Fri, 07 Nov 2025 09:58:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GwgPjWGL4Gk0-lavljUaz;
	Fri, 07 Nov 2025 09:58:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762498698; bh=k8RMyoSQNMrDyOfpu6xvqgm3N84tfDfzdVd1J0QkfjI=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=fak4xDykBdwnWTKXd2nYStK3b/oXR30px9jIjiXc8JVIyukgU1R7+32ZZonjON+pQ
	 +VpxjtozYGpMa4BZ9zE83ZU+BhEte+8//kVRRCAf93DQxsCQIWWuFEbmWiAr1htCg7
	 roO8j2PYApDOgwdvF2XLMNtriqDUfb6fgGlrYK6o=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
Message-ID: <afcb878e-d233-4c87-a0fc-803612c8c91f@rosa.ru>
Date: Fri, 7 Nov 2025 09:58:16 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: hashtab: fix 32-bit overflow in memory usage
 calculation
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
 stable@vger.kernel.org
References: <20251106205852.45511-1-a.safin@rosa.ru>
 <CALOAHbCcfszFFDuABhPHoMioT26GAXOKZzMqww0QY1wKogNm1g@mail.gmail.com>
Content-Language: ru
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQsNGE0LjQvQ==?= <a.safin@rosa.ru>
In-Reply-To: <CALOAHbCcfszFFDuABhPHoMioT26GAXOKZzMqww0QY1wKogNm1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, that looks even better to me. Changing value_size to u64 at declaration
makes the arithmetic safe everywhere and keeps the code cleaner.

I agree with this version.

Should I prepare a v2 patch with this modification, or will you take it 
from here?

07.11.2025 04:58, Yafang Shao пишет:
> On Fri, Nov 7, 2025 at 4:59 AM Alexei Safin <a.safin@rosa.ru> wrote:
>> The intermediate product value_size * num_possible_cpus() is evaluated
>> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
>> large value_size and many possible CPUs this can overflow and lead to
>> an underestimated memory usage.
>>
>> Cast value_size to u64 before multiplying.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Alexei Safin <a.safin@rosa.ru>
>> ---
>>   kernel/bpf/hashtab.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 570e2f723144..7ad6b5137ba1 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -2269,7 +2269,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
>>                  usage += htab->elem_size * num_entries;
>>
>>                  if (percpu)
>> -                       usage += value_size * num_possible_cpus() * num_entries;
>> +                       usage += (u64)value_size * num_possible_cpus() * num_entries;
>>                  else if (!lru)
>>                          usage += sizeof(struct htab_elem *) * num_possible_cpus();
>>          } else {
>> @@ -2281,7 +2281,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
>>                  usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
>>                  if (percpu) {
>>                          usage += (LLIST_NODE_SZ + sizeof(void *)) * num_entries;
>> -                       usage += value_size * num_possible_cpus() * num_entries;
>> +                       usage += (u64)value_size * num_possible_cpus() * num_entries;
>>                  }
>>          }
>>          return usage;
>> --
>> 2.50.1 (Apple Git-155)
>>
> Thanks for the fix. What do you think about this change?
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 4a9eeb7aef85..f9084158bfe2 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2251,7 +2251,7 @@ static long bpf_for_each_hash_elem(struct
> bpf_map *map, bpf_callback_t callback_
>   static u64 htab_map_mem_usage(const struct bpf_map *map)
>   {
>          struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> -       u32 value_size = round_up(htab->map.value_size, 8);
> +       u64 value_size = round_up(htab->map.value_size, 8);
>          bool prealloc = htab_is_prealloc(htab);
>          bool percpu = htab_is_percpu(htab);
>          bool lru = htab_is_lru(htab);
>
>

