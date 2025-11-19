Return-Path: <bpf+bounces-75104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D30C70BA1
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FC744E29BE
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379931A056;
	Wed, 19 Nov 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/efX9a8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B312D7DCC
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578818; cv=none; b=ERnjNwNalicUxLyMqKQMhC7BofPf9hsb7b4JnKgjKRmyyl8znK/2MVj8zQlkNYRnS4M0G+wxabZRnGc0yX4j8OxKlFqNU4Xsd62DVKV0JYY2typQnZCkAkNq54L7s/s+UJhosjQ2v/tgnFuuA/hXirDF0VTnZuHivtA4373/hVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578818; c=relaxed/simple;
	bh=KnGFpoKuwtmqB/EnRVJ1HUFND/ZP4LQUX3c0HAyxmLo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bi11O+rmJU93wODH+5tPzOpEYLZeNxFkKfPz287vVsichr8Nkd3iQR4EYzVogWZtbOfrGjSl0w6yeCXEDQpyhImJmmzNSKqM5JdoeArNISPhQQy+ojstnZ2voXN/f/Wgvwvle+flJ/rWjQjLY9iam4ZzRlxDArS6OZKqcIZ9RgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/efX9a8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a1c28778so1092205e9.3
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578811; x=1764183611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/2rTu1Zyb2OXccoo9CgESriF93aItZ+MOzoslT+MBNo=;
        b=H/efX9a8ZBdfXGtGI+S7w+VYSXlnygnUEY19RtoBvBfiJvYjmeHveGtBbWQaBNtVtJ
         8E+HdT/1ZV8SxwZiTdtaZFntv9EYW4o56JiSH0iT2IiX9SSL+WdC3M1kA16O76vj74ft
         fyIKVUHpGACyETd3/MM5NAbjHQUPQILllTuVDjHlklHtNKldrCc7jpxb2qt+xH8wCCKX
         obPM7ylOpFr9PJLb3QtGzqLUBRXmSGTD7IsCgBDClWyJqSfdpAf8WO+l0UCVf2DZcosu
         vIPMW1RHuWhRfhx9k/wdxkDM0se5gXirc6k3EO3jcqseQ/s1K7B0RhCwwDlSnuVNIJ4j
         dfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578811; x=1764183611;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2rTu1Zyb2OXccoo9CgESriF93aItZ+MOzoslT+MBNo=;
        b=e39/kS6M6cc/mnwp3ngivISl+YU33SONIg23CMOTrQwDPiInQhYwBdxge3sxAACgdt
         g8bt8EsMlO03+uYves2ykkt2Jxk/4Jd5mtuBGsT72kD/gBhQECqLfHY7vzArDKwg1im7
         UOdypdS+CKkEf5NNtQvlBilHwQB3VAXEZelXOGsos+TMj/4GuUXSqNuttPU5RtnQ7YWU
         27P1leg29q2wx3QhPWEBCqGQz+ltLaMVXjhGPiCmV6Ed6BYSfYSGIk8iEB3cKQ0eJ3xB
         K0aXWYM2wHvTB8UQsvf5kSS/XEunuj/HU/CSJTU1qghdUWmgwZCDcR8fp/BvkrZdOfY2
         KpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVaIzgLggtDJ2R3Y6qJos7I8nIvK//2nr1NK6hOPyc21GqLVofYIHf3MWfnrE5AncKCydU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBz7nib8KB1jvBZJxSvPjEwXaw8aw0g5fXoQrQtAEu5Lclb1n
	U6h3bbwLeEVH+4ypBkyReqbk2wI3eup1E7WZxA2sbfhesRU9UuC63Zb0
X-Gm-Gg: ASbGncvxJuquAKpP05vSraAEwjnwdriPeqgBbyWV88G2vWAyROie51ewDGxtQ0R4hyK
	2QNT+871FreEkNv+SYnJgO0Y/8NagyeF+x2hUVRUlkh4F5xbXukSdsXTUa0GbiSWGQbGB8jhaf+
	yo4nrWl1gkpP1XBfa1QFUfCMtQckaNYVLY33HqLRSWdX+9ZsLy8QcgG5xwEzOsdCyHXRv7OGiVC
	oSe8+iz9kxvw1sygyWjgEoKei/fhq3EZTFUX8Av/fCCG0KenYq1gkYj0Caqn+Ts73W9FV0/bhsJ
	VszvxelX26Kh4yH0WtZZHnbpwJUVXTz1yUjkyYiwin+1aZlqSS94ReZhK/2rt50VYmrmlSpN4hh
	IzQh0gU5gsPoblJJiv+euVPGCCXoki5x7Bq3X2LWl0HsQKUDG4xyLFBafNIkWl4ICXszaSxswgm
	9DZ1mGMW2LJ+I/Xub0qRWTY9CKvY+KjDhiffaXSx2MMc1Cmx4IROEhhH7IYTwmGQ==
X-Google-Smtp-Source: AGHT+IHAX18VnUcaT0wAUrR+wCvUrOrmLXzcKjJrw0Gpf3ST+Lwi0+eH7wNPzaqt/428ybUkeBGd+A==
X-Received: by 2002:a05:600c:1c8d:b0:477:54cd:2029 with SMTP id 5b1f17b1804b1-477b857906emr3833125e9.4.1763578810230;
        Wed, 19 Nov 2025 11:00:10 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dfd643sm45093245e9.14.2025.11.19.11.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 11:00:09 -0800 (PST)
Message-ID: <0527a07c-57ac-41f2-acfd-cfd057922e4a@gmail.com>
Date: Wed, 19 Nov 2025 19:00:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH 0/5] io_uring: add IORING_OP_BPF for extending io_uring
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>
References: <20251104162123.1086035-1-ming.lei@redhat.com>
 <891f4413-9556-4f0d-87e2-6b452b08a83f@gmail.com> <aQtz-dw7t7jtqALc@fedora>
 <58c0e697-2f6a-4b06-bf04-c011057cd6c7@gmail.com> <aQ4WTLX9ieL5J7ot@fedora>
 <9b59b165-1f57-4cb6-ae62-403d922ad4da@gmail.com> <aRVcAFOsb7X3kxB9@fedora>
Content-Language: en-US
In-Reply-To: <aRVcAFOsb7X3kxB9@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Ming,

Sorry for a late reply

On 11/13/25 04:18, Ming Lei wrote:
...
>> both cases you have bpf implementing some logic that was previously
>> done in userspace. To emphasize, you can do the desired parts of
>> handling in BPF, and I'm not suggesting moving the entirety of
>> request processing in there.
> 
> The problem with your patch is that SQE is built in bpf prog(kernel), then

It's an option, not a requirement. It should be perfectly fine,
for example, to only process CQEs and run some kfuncs, and return
back to userspace.

> inevitable application logic is moved to bpf prog, which isn't good at
> handling complicated logic.
> 
> Then people have to run kernel<->user communication for setting up the SQE.
> 
> And the SQE in bpf prog may need to be linked with previous and following SQEs in
> usersapce, which basically partitions application logic into two parts: one
> is in userspace, another is in bpf prog(kernel).

I'm not a huge fan of links. They add enough of complexity to the
kernel. I'd rather see them gone / sidelined out of the normal
execution paths if there is an alternative.

> The patch I am suggesting doesn't have this problem, all SQEs are built in
> userspace, and just the minimized part(standalone and well defined function) is
> done in bpf prog.
> 
>>
>>>>>> for short BPF programs is not great because of io_uring request handling
>>>>>> overhead. And flexibility was severely lacking, so even simple use cases
>>>>>
>>>>> What is the overhead? In this patch, OP's prep() and issue() are defined in
>>>>
>>>> The overhead of creating, freeing and executing a request. If you use
>>>> it with links, it's also overhead of that. That prototype could also
>>>> optionally wait for completions, and it wasn't free either.
>>>
>>> IORING_OP_BPF is same with existing normal io_uring request and link, wrt
>>> all above you mentioned.
>>
>> It is, but it's an extra request, and in previous testing overhead
>> for that extra request was affecting total performance, that's why
>> linking or not is also important.
> 
> Yes, but does the extra request matters for whole performance?

It did in previous tests with small pre-buffered IO, but that
depends on how well ammortised it is with other requests and
BPF execution.

> I did have such test:
> 
> 1) in tools/testing/selftests/ublk/null.c
> 
> - for zero copy test, one extra nop is submitted
> 
> 2) rublk test
> 
> - for zero copy test, it simply returns without submitting nop
> 
> The IOPS gap is pretty small.
> 
> Also in your approach, without allocating one new SQE in bpf, how to
> provide generic interface for bpf prog to work on different functions, such
> as, memory copy or raid5 parity or compression ..., all require flexible
> handling, such as, variable parameters, buffer could be plain user memory
> , fixed, vectored or fixed vectored,..., so one SQE or new operation is the
> easiest way for providing the abstraction and generic bpf prog interface.

Or it can be a kfunc

...
>>> It is easy to say, how can the BPF prog know the next completion is
>>> exactly waiting for? You have to rely on bpf map to communicate with userspace
>>
>> By taking a peek at and maybe dereferencing cqe->user_data.
> 
> Yes, but you have to pass the interested ->user_data to bpf prog first.

It can be looked it up from the CQ

> There could be many inflight interested IOs, how to query them efficiently?
> 
> Scan each one after every CQE is posted? But ebpf just support bound loops,
> the complexity may be run out of easily[1].
> 
> https://docs.ebpf.io/linux/concepts/loops/

Good point, I need to take a look at the looping.

>>> to understanding what completion is what you are interested in, also
>>> need all information from userpace for preparing the SQE for submission
>>> from bpf prog. Tons of userspace and kernel communication.
>>
>> You can setup a BPF arena, and all that comm will be working with
>> a block of shared memory. Or same but via io_uring parameter region.
>> That sounds pretty simple.
> 
> But application logic has to splitted into two parts, both two have to
> rely on the shared memory to communicate.
> 
> The exiting io_uring application has been complicated enough, adding one
> extra shared memory communication for holding application logic just makes
> things worse. Even in userspace programming, it is horrible to model logic
> into data, that is why state machine pattern is usually not readable.
> 
> Think about writing high performance raid5 application based on ublk zero
> copy & io_uring, for example, handling one simple write:
> 
> - one ublk write command comes for raid5
> 
> - suppose the command just writes data to one single stripe exactly
> 
> - submitting each write to N - 1 disks
> 
> - When all N writes are done, the new SQE needs to work:
> 
> 	- calculate parity by reading buffers from the N request kernel buffer
> 	  and writing resulted XOR parity to one user specified buffer
> 
> - then new FS IO need to be submitted to write the parity data to one calculated
> disk(N)
> 
> So the involved things for bpf prog SQE:
> 
> 	- monitoring N - 1 writes
> 	- do the parity calculation job, which has to define one kfunc
> 	- mark parity is ready & notify userspace for writing parity(how to
> 	  notify?)

And something still needs to do all that. The only silver lining
for userspace handling is that there is more language sugar helping
with it like coroutines.

> Now there can be variable(many) such WRITEs to handle concurrently, and the
> bpf prog has to cover them all.
> 
> The above just the simplest case, the write command may not align with
> stripe, so parity calculation may need to read data from other stripes.
> 
> If you think it is `pretty simple`, care to provide one example to show your
> approach is workable?
> 
>>
>>>> you introduced. After it can optionally queue up requests
>>>> writing it to the storage or anything else.
>>>
>>> Again, I do not want to move userspace logic into bpf prog(kernel), what
>>> IORING_BPF_OP provides is to define one operation, then userspace
>>> can use it just like in-kernel operations.
>>
>> Right, but that's rather limited. I want to cover all those
>> use cases with one implementation instead of fragmenting users,
>> if that can be achieved.
> 
> I don't know when your ambitious plan can land or be doable.
> 
> I am going to write V2 with the approach of IORING_BPF_OP which is at least
> workable for some cases, and much easier to take in userspace. Also it
> doesn't conflict with your approach.

-- 
Pavel Begunkov


