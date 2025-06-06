Return-Path: <bpf+bounces-59866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A105AAD0428
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD0E1891F13
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9761A262D;
	Fri,  6 Jun 2025 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ivMEGlE2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7E13D891
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749220748; cv=none; b=M3OF63NByT2FzKpT2y2hb2+WjjXXpu/PawXyi6OL1VWjKb34kuq9+ySNjPfAIKk1l/6xADyWs25o9Bqrp8lfbsnxpWjGYDpLY9cVcSihtfi+qhUbELssgK1/5Eg+gWv4BT7qbG1ztCk/sKMwteGPfP+6UZyL7n9bGCvipgPPobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749220748; c=relaxed/simple;
	bh=3RlpGtfRa9bewFOs6MV3+PiSEYjbIEuBcgpZrywD4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHDT4MaQzJ5cHH/I8bw+aXD52c+i30oswFpQ/JU584KLbeFJYqBziaZxwmUSfA03udOV/J3AAYxv9s5wBWoY1Nl+5sW7v3b6lY5lZHukeoqLsvGxiRAZ9jtLjwiPiWYiQEo5aaJWTYHwCTUfLOs8/7fHJRe8f5M5XmxAP6ea3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ivMEGlE2; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3dc6f6530c5so17733885ab.3
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749220745; x=1749825545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePD8mbSyxWI7tOm3mJrlzLEJipoLjaxPhCQo9r49Cf8=;
        b=ivMEGlE2JRV5S1hn9YzAwQRXz0gXwlThJpRS2FM+su311rY3pKTVd5Dju1UwNDBT/P
         ms227qDN1Sa7i340F7/X8ghniOR3hTxGCzmPfLfHgKXbUEIac5R6ABHKNCKhwxqsaIHB
         5psZSWX+78NK5mFJFbvoujGq+GB4camb1d4Y/ivDxhBlnjN0zG0FugikbmPyBpi3Y0IX
         zxXHbZHtxFOHIjfIu9fUtYI2m1O2s1AdNwjA4mY80/v6fsVC1VkTQYivTvcdsYDUSsCa
         r6zHdxeE1CtCB2EHzMDEQ8txvoBS8haGV6/TuLB5DTiJ+Ojh1mOOk5I9Hro+0aC06LBl
         ERzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749220745; x=1749825545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePD8mbSyxWI7tOm3mJrlzLEJipoLjaxPhCQo9r49Cf8=;
        b=rMzk0PKlk+aplLzksPmcc/ooORqMUZvuHhCI4t7iHHw6ryfiMMfew9nA0hkrn4Rvah
         24jfR6RivJiM4f+1r3fPgvdh+sFscqnhbQqIei1oWchuAdNb/QPqgSZeQb6ckL4isx6c
         s+q8UNGf10N0SApl/ynSVdxB1pvQHdECz2vX8kRkI34vEKHEmjM2HG3gVoDuc2Y+Obx5
         Xo0BIAy502gCIuWhFUXV8vM3WNKjXK7iJ8KujWpQcvU41Xk/WUuCVekP4d9ehoop5x6i
         GmAaHebqeONs54SY9dClswpgUR9KZbPclgqrNtw2tPXO2wOs2PFH44WqVdUMOzvBL+Fq
         OWmA==
X-Forwarded-Encrypted: i=1; AJvYcCUtUBcgFnBFirB9abcmXiQA7XKoyHHWuhVGKFD7AhFTWLWO36XQo3GxUhz2OtNBVEdXJpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNm6mEOwsUC1LxcsACcmUILJjRyViGFbZs871W58MBsHF7abjc
	MX5Ok5a4RrlrchFe640RC1GxWyll42pmhjFqqp4DY6Vv5MRbwDydiEhJfpl/kszwzG1XOsCetL6
	bmZHn
X-Gm-Gg: ASbGncvXV4li9+XTsJ921ALRBxBZEyU1JLaG5SNGuIBa/Kb7OlQsJKeVlNFqcyeXSm2
	tsItv84gUquLY5K5DWrFRdKErbWpuj6iMYT6POtcnIgYXKwR3WmClM0HbKnUjAKxFo0ZN7ADbKv
	YcQ4pXCJ2QfVixXkReGbRW9xvzSjoPpXb5433rtZIeTZhAuFQR04GkxE6HgRhYWIILmbSvSqrUQ
	+c04LPQ4QYP4KKekmQERnHiv3dd55FAHoX9oRC42sDXCq4uVebVEwf/Ik/ZpVl64doonO5H2/CZ
	nIj19otQ4kJc4UPdGF9loRZiLpIGp8EoP6dIA5beAQIYGpRxruYiXpeGjw==
X-Google-Smtp-Source: AGHT+IEYIIwpMH1limnRPkyPHzVPpLRFlfL43w/MdnkURpLFcO0uzBblUbS83KbIhEnSklhOW03Jog==
X-Received: by 2002:a05:6602:4807:b0:86c:fea7:6b83 with SMTP id ca18e2360f4ac-8733665b1d9mr492040539f.6.1749220732743;
        Fri, 06 Jun 2025 07:38:52 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-873387843b3sm34217239f.8.2025.06.06.07.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 07:38:52 -0700 (PDT)
Message-ID: <36c0c06e-26fa-4395-a4cf-2a7520520187@kernel.dk>
Date: Fri, 6 Jun 2025 08:38:51 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] BPF controlled io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1749214572.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1749214572.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/25 7:57 AM, Pavel Begunkov wrote:
> This series adds io_uring BPF struct_ops, which allows processing
> events and submitting requests from BPF without returning to user.
> There is only one callback for now, it's called from the io_uring
> CQ waiting loop when there is an event to be processed. It also
> has access to waiting parameters like batching and timeouts.
> 
> It's tested with a program that queues a nop request, waits for
> its completion and then queues another request, repeating it N
> times. The baseline to compare with is traditional io_uring
> application doing same without BPF and using 2 requests links,
> with the same total number of requests.
> 
> # ./link 0 100000000
> type 2-LINK, requests to run 100000000
> sec 20, total (ms) 20374
> # ./link 1 100000000
> type BPF, requests to run 100000000
> sec 13, total (ms) 13700
> 
> The BPF version works ~50% faster on a mitigated kernel, while it's
> not even a completely fair comparison as links are restrictive and
> can't always be used. Without links the speedup reaches ~80%.

Nifty! Great to see the BPF side taking shape, I can think of many cool
things we could do with that. Out of curiosity, tested this on my usual
arm64 vm on the laptop:

axboe@m2max-kvm ~/g/l/examples-bpf (bpf) [1]> ./link 0 100000000
type 2-LINK, requests to run 100000000
sec 13, total (ms) 13868

axboe@m2max-kvm ~/g/l/examples-bpf (bpf)> sudo ./link 1 100000000
type BPF, requests to run 100000000
sec 4, total (ms) 4929

No mitigations or anything configured in this kernel.

I'll take a closer look at the patches.

-- 
Jens Axboe

