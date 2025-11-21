Return-Path: <bpf+bounces-75241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F73C7ACCD
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 685194F127B
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27C293C42;
	Fri, 21 Nov 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcHzRxxo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80B34C81D
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741557; cv=none; b=VE5/4d25lpOM6ep+NyBOohDrleY2smOSmRawqzpVxeDlsXaoK1aIoQ7WAGz0FGi2SAhv7vL925NMZaJ0JOGjL5InlI6s14XgM4kkA0ze5GzwqEXN6YhLlrBQptYa2C5PeVAyVeBrLU6rbfXiFxAKe8/7VRH8Kd0kD8pv2cKzVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741557; c=relaxed/simple;
	bh=ZgqPfaK6VWEXZdLqNt0iEnR3nGhXa8URQijIh9dbPo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqBMa9RtZQDVXI0ZRAmo8PzpsDYiIoL1pXy6MX12KDweV0SdYvleY9Ez14MFzHvA2z/uqDihdD7ol0le7/wmJXrIunXTqWEBppPUl7DK0NGDMaViGz2KmNTJB/pbcqGd0Nq7HeaH1ulkvAdZ6Nj2ibx4t/ETqv6nxo6AnFtPWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcHzRxxo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563e28a3so15646595e9.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741548; x=1764346348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqIKEwT/rUMqsaYUty5E6HMF8PGsa9QB4kUVO+4IgS8=;
        b=KcHzRxxoMReSNyiA+xvzcjUUj3J7kziDZadgk9+7b4pZh/0kM/Et09agLfXz9GIK1s
         Oe5RLS2fwvyZJis70zeRfdyRA3TFDwgtAsHoFwg+1j+UjrB/ljV5z3qmTtJRIXpN2vG9
         QpApgc6kL8CTFIJLBe5KehLHosvg0LFir/9dWjtbiq2P8oPVa+hJfGt/huBnuebJqjyE
         kT4mgOWcPZucaF6qBlIQjvo5txadb5YqV6QMAqJRbPTpOhIQXkrsi4Qt6TglFkec6IPr
         twj7yJ8GKKZ4towtDGH1btEq2Efo7tTyJBeGnzGdzm0a52ucQ1WkafIk8Xyb/0u3iofO
         Pjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741548; x=1764346348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqIKEwT/rUMqsaYUty5E6HMF8PGsa9QB4kUVO+4IgS8=;
        b=ri3LqPSKcjPYtTUIzN0i+49C39wV+Qrn8yLiy7arT/WbMEz6SC6YWhaMH5uKgtEUeI
         zqfdyICWUOH1EOg2VYaaMgc1LnWHtOxDX5ZXJgPC+6MPM3TjtxCT4GZtsHDKySmlAVjF
         rzjKQoh0eXGVDS3FP2SjKkaa73ejkZV1oDXjttjgo5Ox9kS7q6vL704/gDezAiilw0p5
         swjnIcA5qp5psQQlafTLvUvBGbdDtewS/M6VpvCGR+VGCdy+tjdQP95mvpfkvNDQIh3L
         LPSrETl58nhqHzD3RI5fss0riLBdTGFH090ay4zK0d7+0ZBIIRckXJEpgg+qLZ8ZqakX
         Gq1w==
X-Forwarded-Encrypted: i=1; AJvYcCXuI7CeXg7EO/Iq5rNRxxnZSdPw86jxQn9anzPNJdBgO3b2Xzy8WFdrhxgI4ZYsi9s9j3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyuC+2h6C5yp1sSXPuEnT0MKO+1sNIfUckRqxMt+hbAudXD+Iz
	ws3nyJFv33cfGcW1hYxg0QZVn870DqHuRuA0qsgFbpYTqu9zWwcN0h5Z
X-Gm-Gg: ASbGncv15iP3cXeKSSkN0mCcyOPQOxRDbV4AQFoGByeVOHSTxxTEG85x5N2RNvxzMea
	iXrDUuI/YfFV6nyH7pzTZysSFZMZ21qXbOkx/oUBFEKI0lNZQN3baqtD7wa8SxW1NbMdar5zSb6
	WSoplBp6d7t7zYRN1jc893affrHFn+MCM6h885lUIzQ0pFysgHhCt34suGo+/tYOhbxF/Co+lrW
	QjI9zPtC/5ajoLw5aCvR9oqLXiCQuU8k/x6lO8agIQCz7V+LRAbWuiSn4c0oI9WL3/J0Jr9zqDA
	c6DOK8+ZNgTS/qtQOEKARTMs17zUh2Qo4zJ+F6kGK7Q+4UbtRPm8/r/BMi74UxcTfivQEp+pdo7
	08kU5Za9p1IfiypgyosG4eJewc/CkOSIsdBjH+c3bxu00YP6I70RmIC9iBnOYtXJMk1kiXO0h4L
	BROqByZ3IWrTyKOmZPdKA5uzHgLzLKeAWpTTvNMVBhXv0=
X-Google-Smtp-Source: AGHT+IFlt0JhjSE9IV98wA3TZU9MPZgJtJ2z9Blxl9S9eSJcFCrFmdXcolTY3ZBMyw9cni0ADFDsXg==
X-Received: by 2002:a05:600c:2155:b0:475:de06:dbaf with SMTP id 5b1f17b1804b1-477b9efe351mr50829945e9.17.1763741547704;
        Fri, 21 Nov 2025 08:12:27 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:7bc2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bd1580cbsm29401865e9.2.2025.11.21.08.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 08:12:27 -0800 (PST)
Message-ID: <1994a586-233a-44cd-813d-b95137c037f0@gmail.com>
Date: Fri, 21 Nov 2025 16:12:25 +0000
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
 <aR5xxLu-3Ylrl2os@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aR5xxLu-3Ylrl2os@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 01:41, Ming Lei wrote:
> On Wed, Nov 19, 2025 at 07:00:41PM +0000, Pavel Begunkov wrote:
>> On 11/14/25 13:08, Ming Lei wrote:
>>> On Thu, Nov 13, 2025 at 11:59:47AM +0000, Pavel Begunkov wrote:
>> ...
>>>> +	bpf_printk("queue nop request, data %lu\n", (unsigned long)reqs_to_run);
>>>> +	sqe = &sqes[sq_hdr->tail & (SQ_ENTRIES - 1)];
>>>> +	sqe->user_data = reqs_to_run;
>>>> +	sq_hdr->tail++;
>>>
>>> Looks this way turns io_uring_enter() into pthread-unsafe, does it need to
>>> be documented?
>>
>> Assuming you mean parallel io_uring_enter() calls modifying the SQ,
>> it's not different from how it currently is. If you're sharing an
>> io_uring, threads need to sync the use of SQ/CQ.
> 
> Please see the example:
> 
> thread_fn(struct io_uring *ring)
> {
> 	while (true) {
> 		pthread_mutex_lock(sqe_mutex);
> 		sqe = io_uring_get_sqe(ring);
> 		io_uring_prep_op(sqe);
> 		pthread_mutex_unlock(sqe_mutex);
> 
> 		io_uring_enter(ring);
> 
> 		pthread_mutex_lock(cqe_mutex);
> 		io_uring_wait_cqe(ring, &cqe);
> 		io_uring_cqe_seen(ring, cqe);
> 		pthread_mutex_unlock(cqe_mutex);
> 	}
> }
> 
> `thread_fn` is supposed to work concurrently from >1 pthreads:
> 
> 1) io_uring_enter() is claimed as pthread safe
> 
> 2) because of userspace lock protection, there is single code path for
> producing sqe for SQ at same time, and single code path for consuming sqe
> from io_uring_enter().
> 
> With bpf controlled io_uring patches, sqe can be produced from io_uring_enter(),
> and cqe can be consumed in io_uring_enter() too, there will be race between
> bpf prog(producing sqe, or consuming cqe) and userspace lock-protected
> code block.

BPF is attached by the same process/user that creates io_uring. The
guarantees are same as before, the user code (which includes BPF)
should protect from concurrent mutations.

In this example, just extend the first critical section to
io_uring_enter(). Concurrent io_uring_enter() will be serialised
by a mutex anyway. But let me note, that sharing rings is not
a great pattern in either case.

-- 
Pavel Begunkov


