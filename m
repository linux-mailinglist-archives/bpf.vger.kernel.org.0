Return-Path: <bpf+bounces-75334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0BC80592
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B813A161E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69858301716;
	Mon, 24 Nov 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXO6yPJV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B55301709
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985439; cv=none; b=g3yZd8giru4xLKYG6j3b06nZttkmZoWWeELSw4dxET3avLkusy2FFs1URsZw77wOKHOsC/Jm1yU6EFBW5gokI8BxzwFidWojmlgfltZr5aSkHhgTR+r5g8AQjydwZBWzZHMLVKFkA8u2KmSrQ1J6XSO95P4mvkDK3UHZTaDR8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985439; c=relaxed/simple;
	bh=e+v7CdcV1TaYkT5kdyH2QFzOE1VmsFJEbzHKYsR48Z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krTdjMJ0Xg4T0zdXE+MiH+UvyG3txN5ecLCK3cws9aRgdiNxKWlUpLqx87Q+aY54Xvb0SXivVDvPO9mIkaluya9NbdItmyiAVgcoAqJJtUWczHuAXicvPEfdSo84Rome3yLl9+YBz8Hq23yWL9FiD9gnvcL3Kj6RLc1IChFE8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXO6yPJV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477a219db05so25112465e9.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763985436; x=1764590236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6K646kVMCKHQIyUwaCd8T41DsNbqTmzztejn5C3rxY=;
        b=IXO6yPJVpsPxV4vZSNb0AII2tisvZbojJPQCJ4s40bd0LxrN6vUBU9Jdqixuww+Vgg
         dsv4UYfmnXUGK/wWRC3es0/5L5nnS8P40qWfSUlPB99vfnKUUMQpGlx+7PPylLlbE/Yp
         gaikspbksbOW2vAGYZJZhjBvEVtp9LdiPQWj7tLfy42f0tkeO0K/RAnpmks0BnHD4cB6
         Q9t1Gk1/k3jSL7FkoInd/dGqhO1kfHgbLpCCcXKVyc+PMaz1o9eN+IFXC1QoosxBJKj1
         5kLABclDEYbLwXfAGfOs/lKX+WjJKHgZWgZNEEJgVSs12CWG6RWKjdRAFVVk1vpzFkH7
         3KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763985436; x=1764590236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6K646kVMCKHQIyUwaCd8T41DsNbqTmzztejn5C3rxY=;
        b=q2lRp4wmYAjyqzbaoTgz58JynImJRiytPGfdUmpk38QUDvFXONYgjHNqsXzbHRJ+Qi
         3ANL2E5H2gtrOcNYAXV7K08kAMbeJtHD0YxJRjC5aHa6Y/ETEWxN1vUe6I6u2+S9yaFQ
         YdlhsVXWYwmcnjAiADeMQPhi3swYBiTG695H+nzNpkR8AqJydWqyrhR9GHSfczasZZ1u
         hkIRRUOOw3bD/77BMY2pt2RV+xG3V9nz8fil8Dd+LA3mqxjOQQ8X/vYj95MmF4VnFaOt
         NfXsgCwPKxAivsc4nxqYaz6Btz6AAJwvP/i/6hPWaryAGXsQ3goQMdcFgfxYyTlWZiCt
         GTEg==
X-Forwarded-Encrypted: i=1; AJvYcCUHifqZoVHFx4lKSUqONvxgCgFQBNZOf7lnMrk/YhUNY2kwJ/a+IPAPS6bxhhez7ImwRmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydDCqHhSm5Bqo7/C+DMrB6LopAiSKU5mTvBcCELGItU8tenYi
	pAkO0q/AzhLQ9BmiQA7zlCLXrY+8lhdcRx81I7zkhBPyNn4G1JvB9Mij
X-Gm-Gg: ASbGncvjtEhP7zu3m03Thsvixj6geCisIRcp25FW3ARkdAKAlJNOIL8eZ5REgBj5gaN
	Bl7XsJyjv3Bd0J3zvaT4vrWPI//bmNe0LzNa2EI/Rqi1dZwmHc5G+Q0M9W/XEWWJDuP4MRVg1ZI
	gdn4EBYiq6P7o3zRc1ugWxqxyP0Y0OujX8dkTFNFSKYn5/FKpMnwYR+ef+NgdF2W6JeU/9dBsUY
	Wy3rN4pLHuh2wG3QN4tgSlDeX1urBe9Oc8gh4A/W5YLeN55R6WWOmsRaiGYv+Edt+y4fjTBb3Vk
	YM0eAUtjvJNDZn9slu4zv6mwHQT7S666mBcBsYqtLUNtFSxHbdP3Ix6E1uAuH20/Mb5R2QcBqpV
	FhaVLQ7tYgbjgzArbAwECSzaQ5HJcpECerx+6zbBWmGqFVMkWPmRlt8U6s6CAQeoONJQWtKLWgA
	pFbe5c3XKFYidWVgjKHOvqMccGKAt2yqfGOUVcpzGdWhOVNP16ec52VfBSzlH1F3f15F+gMudU
X-Google-Smtp-Source: AGHT+IE0OSj8JqZ05GjF3Oefxk9wJ+p5QyMka9uBLVg7fNTS2Gs36AgHP69SB66QxOT2H4cSE1QuHA==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id 5b1f17b1804b1-477c11175a9mr128273385e9.16.1763985435881;
        Mon, 24 Nov 2025 03:57:15 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf227ae2sm192385605e9.9.2025.11.24.03.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 03:57:15 -0800 (PST)
Message-ID: <f1db3be4-a4a7-4fd7-bd5c-0295a238b695@gmail.com>
Date: Mon, 24 Nov 2025 11:57:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] selftests/io_uring: add bpf io_uring selftests
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <cover.1763031077.git.asml.silence@gmail.com>
 <6143e4393c645c539fc34dc37eeb6d682ad073b9.1763031077.git.asml.silence@gmail.com>
 <aRcp5Gi41i-g64ov@fedora> <82fe6ace-2cfe-4351-b7b4-895e9c29cced@gmail.com>
 <aR5xxLu-3Ylrl2os@fedora> <1994a586-233a-44cd-813d-b95137c037f0@gmail.com>
 <CAFj5m9KfmOvSQoj0rin+2gk34OqD-Bb0qqbXowyqwj16oFAseg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAFj5m9KfmOvSQoj0rin+2gk34OqD-Bb0qqbXowyqwj16oFAseg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/22/25 00:19, Ming Lei wrote:
> On Sat, Nov 22, 2025 at 12:12 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...
>>>
>>> `thread_fn` is supposed to work concurrently from >1 pthreads:
>>>
>>> 1) io_uring_enter() is claimed as pthread safe
>>>
>>> 2) because of userspace lock protection, there is single code path for
>>> producing sqe for SQ at same time, and single code path for consuming sqe
>>> from io_uring_enter().
>>>
>>> With bpf controlled io_uring patches, sqe can be produced from io_uring_enter(),
>>> and cqe can be consumed in io_uring_enter() too, there will be race between
>>> bpf prog(producing sqe, or consuming cqe) and userspace lock-protected
>>> code block.
>>
>> BPF is attached by the same process/user that creates io_uring. The
>> guarantees are same as before, the user code (which includes BPF)
>> should protect from concurrent mutations.
>>
>> In this example, just extend the first critical section to
>> io_uring_enter(). Concurrent io_uring_enter() will be serialised
>> by a mutex anyway. But let me note, that sharing rings is not
>> a great pattern in either case.
> 
> If io_uring_enter() needs to be serialised, it becomes pthread-unsafe,

The BPF program needs to be synchronised _if_ it races. There are
different ways to sync, including from within the program, but not
racing in the first place is still the preferred option.

> that is why I mentioned this should be documented, because it is one
> very big difference introduced in bpf controlled ring.

That can definitely be mentioned as a guide to users, would be a
diligent thing to do, but my point is that it doesn't change the
contract. SQ/CQ are not protected, and it's the users obligation
to synchronise it. With this set it includes BPF programs the
user attaches.

-- 
Pavel Begunkov


