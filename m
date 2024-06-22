Return-Path: <bpf+bounces-32801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D991322A
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 07:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148781C21E47
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 05:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC614A606;
	Sat, 22 Jun 2024 05:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF018BFA;
	Sat, 22 Jun 2024 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719035874; cv=none; b=ISOV1gbIO4daAOdVy7shneA+5QikR2bxBGLS8CLkkh+BCOQrph3OqywuaPtzr7EuKKs3uvDuztmZuevGCLv8wq3K50rhO2Xv2g3/JLDQOQ9dBiaM0R+2cmt77qUgkhLAY/vAi7oMmpAk9/KZdkdMmeKxHWGxBib07MRB3BLzccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719035874; c=relaxed/simple;
	bh=kURFcAsPl9DhZYx4fNKn/EPawCHvuT2/i6OzZj/Rlpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccN+6pMBey9xX63UB0ByqIHq9oCFCebzbptdm905pSPp1lVLXeQXNyAF+VIWzM0Ro/4pXObFasfXBnQyMryswm/CyoCCK4oEougl+9HHghdrCdAI5DYgzOtuh2RLr+PVdyCowGrUJLp2NOwe9/8alzTuIT11O8qF4bYwntjwxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45M5vKFL093458;
	Sat, 22 Jun 2024 14:57:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 22 Jun 2024 14:57:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45M5vJQZ093454
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 22 Jun 2024 14:57:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1a48d05c-539b-4d5d-9375-f2aaa5fa0dd4@I-love.SAKURA.ne.jp>
Date: Sat, 22 Jun 2024 14:57:20 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: mmap_lock: replace get_memcg_path_buf() with on-stack
 buffer
To: Axel Rasmussen <axelrasmussen@google.com>, bpf <bpf@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp>
 <CAJHvVcgfgjPQMxRn09+QKV0G-6AOS6UA7hMbtu2azMquMW4JCA@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAJHvVcgfgjPQMxRn09+QKV0G-6AOS6UA7hMbtu2azMquMW4JCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/22 8:03, Axel Rasmussen wrote:
> No objections. Looking back all the way to the first version [1] the
> buffers were already percpu, instead of on the stack like this. IOW,
> there was no on-list discussion about why this shouldn't go on the
> stack. It has been a while, but if memory serves I opted to do it that
> way just out of paranoia around putting large buffers on the stack.
> But, I agree 256 bytes isn't all that large.
> 
> That v1 patch wasn't all that complex, but then again it didn't deal
> with various edge cases properly :) so it has grown significantly more
> complex over time. Reconsidering the approach seems reasonable now,
> given how much code this removes.
> 
> This change looks straightforwardly correct to me. You can take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thank you. One question. CONTEXT_COUNT was defined as below.

>> -/*
>> - * How many contexts our trace events might be called in: normal, softirq, irq,
>> - * and NMI.
>> - */
>> -#define CONTEXT_COUNT 4

Is there possibility that this function (or in general, trace events) is called from NMI
context? If yes, I worry that functions called from get_mm_memcg_path() are not NMI-safe.
Original change at
https://lkml.kernel.org/r/3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAKURA.ne.jp was
posted due to worrying about NMI safety.


