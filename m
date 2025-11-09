Return-Path: <bpf+bounces-74006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E609BC43C80
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 12:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BD3A7E67
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B862DF709;
	Sun,  9 Nov 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="DZaCzS7h"
X-Original-To: bpf@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF032DC338;
	Sun,  9 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686384; cv=none; b=GFW9fo594HZbqhiNsSqP/schaai0iOsOYDPAzS3F7dQNqzOoBfYsKxmV/b9DoQRSHFdc/mFZJOmOH34ajyJwKSFTmS/LTUI41vjzJzDo6Oi1EJH8nYH/Qv029A3wGYd9kYpTgRjFKcaJ+UzP/MegyJV5IZuHyargLt5xKzomktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686384; c=relaxed/simple;
	bh=628j+T4NN4U3fieq61FSy/7vinhuQ5xHDPEojaikKO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ev3RrQiZ2ezthSht4Da2Fj4tBq06Qg6Q8dtbTpJzTOBszJIxPbTPuKZyKbtrnpXhl3RWeMKlMmA6zJrBpTaYebVzcmG7naE8eu2g9CeGmBnJnUVqqk1GFOOj1AFhmqlJOYBnOmybptJgy8EI/iNosubkkgyoOkVaX2SWWGXjdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=DZaCzS7h; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:8120:0:640:c15b:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 61A51C092A;
	Sun, 09 Nov 2025 14:00:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id G0KGd3lLrOs0-kx0gRr5n;
	Sun, 09 Nov 2025 14:00:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762686018; bh=Ul+neqMs6+35CzJCWIQokzZfipMzxkGIjAKa5XhFakA=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=DZaCzS7hgPVQJUlGFb5xbirfZ+cGgJ0+JN/6nvvT9eyi2+toQ8pmKvGGbLtUaBvIK
	 c/lTu+WdWozu8PqR8hIQiDLNvb5PhUmeZUOcQwEZu0IXO3jD8JubbW2KOinVjEFKaN
	 B0uQ8oLH5FVCCcVhFz2xOw6x2WJGOWUz2Zrwc/ZA=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
Message-ID: <8a4aae40-46d3-403a-a1cf-117343c584f6@rosa.ru>
Date: Sun, 9 Nov 2025 14:00:16 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage
 calculation
To: Yafang Shao <laoar.shao@gmail.com>,
 David Laight <david.laight.linux@gmail.com>
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
References: <20251107100310.61478-1-a.safin@rosa.ru>
 <20251107114127.4e130fb2@pumpkin>
 <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
 <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com>
Content-Language: ru
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQsNGE0LjQvQ==?= <a.safin@rosa.ru>
In-Reply-To: <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the follow-up.

Just to clarify: the overflow happens before the multiplication by
num_entries. In C, the * operator is left-associative, so the expression is
evaluated as (value_size * num_possible_cpus()) * num_entries. Since
value_size was u32 and num_possible_cpus() returns int, the first product is
performed in 32-bit arithmetic due to usual integer promotions. If that
intermediate product overflows, the result is already incorrect before it is
promoted when multiplied by u64 num_entries.

A concrete example within allowed limits:
value_size = 1,048,576 (1 MiB), num_possible_cpus() = 4096
=> 1,048,576 * 4096 = 2^32 => wraps to 0 in 32 bits, even with 
num_entries = 1.

This isn’t about a single >4GiB allocation - it’s about aggregated memory
usage (percpu), which can legitimately exceed 4GiB in total.

v2 promotes value_size to u64 at declaration, which avoids the 32-bit
intermediate overflow cleanly.

09.11.2025 11:20, Yafang Shao пишет:
> On Sun, Nov 9, 2025 at 11:00 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>> On Fri, Nov 7, 2025 at 7:41 PM David Laight
>> <david.laight.linux@gmail.com> wrote:
>>> On Fri,  7 Nov 2025 13:03:05 +0300
>>> Alexei Safin <a.safin@rosa.ru> wrote:
>>>
>>>> The intermediate product value_size * num_possible_cpus() is evaluated
>>>> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
>>>> large value_size and many possible CPUs this can overflow and lead to
>>>> an underestimated memory usage.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>> That code is insane.
>>> The size being calculated looks like a kernel memory size.
>>> You really don't want to be allocating single structures that exceed 4GB.
>> I failed to get your point.
>> The calculation `value_size * num_possible_cpus() * num_entries` can
>> overflow. While the creation of a hashmap limits `value_size *
>> num_entries` to U32_MAX, this new formula can easily exceed that
>> limit. For example, on my test server with just 64 CPUs, the following
>> operation will trigger an overflow:
>>
>>            map_fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map", 4, 4,
>>                                                       1 << 27, &map_opts)
> Upon reviewing the code, I see that `num_entries` is declared as u64,
> which prevents overflow in the calculation `value_size *
> num_possible_cpus() * num_entries`. Therefore, this change is
> unnecessary.
>
> It seems that the Linux Verification Center (linuxtesting.org) needs
> to be improved ;-)
>

