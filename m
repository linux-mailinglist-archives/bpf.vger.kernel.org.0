Return-Path: <bpf+bounces-43006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB7B9ADACB
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 06:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20677284468
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E83165F16;
	Thu, 24 Oct 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFGYFBh6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CD2C9A
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729742771; cv=none; b=pSZ9bFy8XbgUS7z5GFn881kIZdfYAXTQWhGytRnpkoI7Cj5fWkAzhpxrwGfVwCItxazMH3gMaXIi3yGoe9jB8OvPonEALunvtC7wLpiZzElnKuzY1+KCSh6B+5WYn9UXcGoqcRXtqlAWETj9p64tBkHsiuah8irjq6xx083dkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729742771; c=relaxed/simple;
	bh=0jZbWbzo2DFx8xLf51EvP3YGxwE/H8jYtHgW9F+z/aA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qdEL+yljXttFaDBjAdKIUQbwqceB/6Xcpr6RyG3FMrUrwbCFN96QZLmreqYQBsWeC5iFEhsw92DRz86ojG1wnlhf/2NxunBNo9jj0vZkwwetCkrd64bHrY/JEe1bgS3uvKWn39/1gXEUXH/PMP0oWq27HkI7xo+G92fXqwAyFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFGYFBh6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71809fe188cso299515a34.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 21:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729742768; x=1730347568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzwfvUG3KkF++iGj1OqI6ymFOnvAiDIFVRLD/D+zPqU=;
        b=OFGYFBh6Jg2hSYQ0oAPJBep/ZGFzTNNKiOD+h2Iviane/K8gENITQ/ioVq2gd16ssX
         28wnZM8aL470Tm4hKG4e9zsz0xpF1KG8kKI3s9vdCtAHtSOytS/njhQTQO5WVdbrY+4q
         smGKeIrIl3RI4kj3OSYf0y4EcihicY9s+LiHyKljvKZOOiAdIjVmJ2Gu1vnmZbg/UV+e
         w+2evuaLCi0IwE4BKA9Go4Rdr/KVeo2i6dNbdoj97Irvhv2spZwt1mUKLanr30qg+eYB
         IiC6ZOqCMVpeVQSQamm/drb6/LX0a8VfD1DAZkr2aB6bqW05KU4y7VIb4jaDPm83dKmO
         yY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729742768; x=1730347568;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kzwfvUG3KkF++iGj1OqI6ymFOnvAiDIFVRLD/D+zPqU=;
        b=bxC5d7gzXJBN6uWqf5hdcIPXFlvX7ZHbVPrcsZtFMxvC/5qKksZuD2CD6Omtaww87j
         zUCYpo4o3FC/dm9ggO6xp0oTOuijgeC0OSpWTzGYpTTtbt8TuMU8JHB2yzfFC9Ly4j5H
         9IvZfy/qBh5mzK8Qaj6Gg0bPTd5GSpW5gz6k1jwBvg9TpCvrHzg1UetPQrrUMHrWxg4+
         lQGfpkt2FvdEgvPospGVd6l0QSX+Tu93tEdQbLgYwy6VbdOGhbLXpi+4uXtOKwPuB7Bc
         tawvWPt4YBD98jAlrlxT4/IcxDXA6H0Vaxy/isAW50EKPJLGXQ9KJFI+IXeLPxAzrb61
         kuKg==
X-Forwarded-Encrypted: i=1; AJvYcCV1KluDTHE1+AgGtUi6TIHfE30S1NbImVPhYYkgyrYhOnal6qSgWt1B9pn/wrdxQR48zew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2AhAaGvDI9sHPWyRhmFsH80ZGiLiubr0CUlShI4UVY8sbtcCU
	OEpwtA8YQFOxID1TvFPfJZRebC8rP8nnfnN/yHhR1L/tacxJcr+jW6TH/A==
X-Google-Smtp-Source: AGHT+IHZg/M2tPeYVzS9WSTRAoUI3jd0RgCsWFGC3OsHGi9iTPBJo8G+i2dFVjhj4HAqbmr27bnIyg==
X-Received: by 2002:a05:6830:3809:b0:718:1163:ef8f with SMTP id 46e09a7af769-7184b2980c4mr5963685a34.2.1729742768409;
        Wed, 23 Oct 2024 21:06:08 -0700 (PDT)
Received: from localhost ([98.97.32.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab48f7bsm7650136a12.39.2024.10.23.21.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:06:07 -0700 (PDT)
Date: Wed, 23 Oct 2024 21:06:06 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: zijianzhang@bytedance.com, 
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, 
 daniel@iogearbox.net, 
 john.fastabend@gmail.com, 
 ast@kernel.org, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 jakub@cloudflare.com, 
 liujian56@huawei.com, 
 zijianzhang@bytedance.com, 
 cong.wang@bytedance.com
Message-ID: <6719c7aede141_1cb2208a6@john.notmuch>
In-Reply-To: <20241020110345.1468595-1-zijianzhang@bytedance.com>
References: <20241020110345.1468595-1-zijianzhang@bytedance.com>
Subject: RE: [PATCH bpf 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> Several fixes to test_sockmap and added push/pop logic for msg_verify_data
> Before the fixes, some of the tests in test_sockmap are problematic,
> resulting in pseudo-correct result.
> 
> 1. txmsg_pass is not set in some tests, as a result, no eBPF program is
> attached to the sockmap.
> 2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
> test skippings and failures.
> 3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
> msg_loop_rx end early and skip some data tests.
> 
> Besides, for msg_verify_data, I added push/pop checking logic to function
> msg_verify_data and added more tests for different cases.

Thanks! Yep I think push/pop are not widely used anywhere unfortunately.
There are some interesting uses for push/pop to add/edit headers, but
I've not gotten there yet clearly.

> 
> After that, I found that there are some bugs in bpf_msg_push_data,
> bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
> why they have not been exposed is that because of the above problems, they
> will not be triggered.

Good. I'll review these quickly tonight/tomorrow and run some testing.
We don't currently have any longer running tests with push/pop.

> 
> With the fixes, we can pass the sockmap test with data integrity test now.
> However, the fixes to test_sockmap expose more problems in sockhash test
> with SENDPAGE and ktls with SENDPAGE.
> 
> The problem I observed,

Thanks for digging into these.

[...]

