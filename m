Return-Path: <bpf+bounces-22241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B53859FA9
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9ECA284B0D
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A02375A;
	Mon, 19 Feb 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wlGnhrAh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968223749
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334749; cv=none; b=nfkTtOEQk6itbjGzK2e4gldXNq0YeteiFoa0tCEWfTjh/AHJnviQ52J1Atck7zIo1d8PLFZUwD4CIDow7THds2LUCABuSqencdxetf+o85fjVmjS6qnWew+r9TXeD0sZFKmCM7G+u9lC5cXW0K7SmCaCQ6cFG/bCjsj8wJnBiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334749; c=relaxed/simple;
	bh=+LKlSYltSwa5o7mTBNHR/CaFwypKJ2z/e/x0DKLXuP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+JlELhChIiwh/G4ZElxIVIyAtyAh62E1t3EE9SXXpN67980nIOI9VbhfOab/H92eF5srrHjaDZ0TtukxnqRYIqUjTfgHXZGW7mS2+JJ0JXMGafU+rT4fcTYtSOt8S1c/c9Lu5vaKHAvttW6LxqVQQSxfEr8tjGAXcLLA6LS4eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=wlGnhrAh; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7876f2a2e62so11390285a.3
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708334746; x=1708939546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBM57V7YDMQ2ruv7r6M5y8HYBmAz6ICIyB6A6RIy3zc=;
        b=wlGnhrAhO14py7P+dSuSAB6AoSL5WqgAQ+QX8Qut239k7SCtqYFpI/0uT4KDFtOHaF
         4Pn+vtYVlba9a+cFcyd0o4orzO5jdQx/pHaxQb4uGcXRgfE8E22aq0o1dwUF5IcK5FyH
         kwAB2ebKa59Hsd5YaXzUtAchW8AAKiksVKKYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334746; x=1708939546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBM57V7YDMQ2ruv7r6M5y8HYBmAz6ICIyB6A6RIy3zc=;
        b=EyS2AgfMBShK+U8+gZ9Pf0xLsHCpEmTB8M8eaadbgNIzgHU1COTChNbk66rxjDY+wD
         abphW8bKxggmne/Yjfyqsue3eJXrHOKndZby0WBMm1YuXnlfkgOXDNAxjiWe+uIvfqA8
         cvc1KexARm/RdiJnEz+Ugv+/zjFRA/LWdPvmLYhh8O18aXfWXr0d84B352/UUWj4T8lF
         0v/3yjrzmBwRnmn9VWfuee+zcmEBS1T5Xf5WfTGSvhrS/g3dWNslT29GAzR1iKSMNSoB
         PlMAkBbpA3mqnlxB8GtzYVkc2zWKqEb9viM5Sx/Bwzv/PcXhab21zXRwI7P/zkeYkdGV
         WgHA==
X-Forwarded-Encrypted: i=1; AJvYcCU3R5x+742gDZ4C4h2jqAjkxLwmJ2XwgCPcPgC7EmsymnqNNly4BR6rEg30OEfOgFSWHFEYH4mxioly1q0jtFkNqpOB
X-Gm-Message-State: AOJu0YwCESO39IjMVPgmpJUmrV8pqBvzqWUDMgzkEDaiH7NsvQT0gUOt
	c0XevJPYW9TSeYr86LxSMeNXCEDvK85kVFJMeSkKjkKj67fooRXU9I7knEQt4zbLwQaaiSXuIGc
	I
X-Google-Smtp-Source: AGHT+IHbtbGY6GIjs0yE0zRqPn4huY7dEpZotILu6RlVCAAUyj1s29aoRMCiyyjOcwK839J/rTpRaQ==
X-Received: by 2002:a05:6214:1947:b0:68f:2ca1:17fe with SMTP id q7-20020a056214194700b0068f2ca117femr18046958qvk.9.1708334746571;
        Mon, 19 Feb 2024 01:25:46 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id mv8-20020a056214338800b00685422c9e35sm2998730qvb.84.2024.02.19.01.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:25:45 -0800 (PST)
Message-ID: <e06be767-419b-4026-a4e2-fb10c02df9f6@joelfernandes.org>
Date: Mon, 19 Feb 2024 04:25:40 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Discuss more features + use cases for
 sched_ext
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org,
 bpf@vger.kernel.org, schatzberg.dan@gmail.com, andrea.righi@canonical.com,
 davemarchevsky@meta.com, changwoo@igalia.com, julia.lawall@inria.fr,
 himadrispandya@gmail.com
References: <20240126215908.GA28575@maniforge>
 <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
 <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>
 <ZbhV_NSMUaAknOMW@slm.duckdns.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZbhV_NSMUaAknOMW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/2024 8:50 PM, Tejun Heo wrote:> On Mon, Jan 29, 2024 at 05:42:54PM
-0500, Joel Fernandes wrote:
>>> This is a great topic. I think integrating/merging such mechanism with the NEST
>>> scheduler could be useful too? You mentioned there is sched_ext implementation
>>> of NEST already? One reason that's interesting to me is the task-packing and
>>> less-spreading may have power benefits, this is exactly what EAS on ARM does,
>>> but it also uses an energy model to know when packing is a bad idea. Since we
>>> don't have fine grained control of frequency on Intel, I wonder what else can we
>>> do to know when the scheduler should pack and when to spread. Maybe something
>>> simple which does not need an energy model but packs based on some other
>>> signal/heuristic would be great in the short term.
>>>
>>> Maybe a signal can be the "Quality of service (QoS)" approach where tasks with
>>> lower QoS are packed more aggressively and higher QoS are spread more (?).
> 
> This was done for a different purpose (improving tail latencies on latency
> critical workload) but it uses soft-affinity based packing which maybe can
> translate to power-aware scheduling:
> 
>   https://github.com/sched-ext/scx/blob/case-studies/case-studies/scx_layered.md

Thanks! I am looking more into this (scx_layered) for the latency benefits as
well. David kindly gave me an introduction to it last week. It seems quite
similar to our approach with using RT (round-robin) for the higher tier (that is
have a higher tier of tasks that are fair scheduled over a lower one). There is
the issue of starvation though (a higher tier/layer starves a lower one), so
we're incorporating the DL server to help with that:
https://lore.kernel.org/all/cover.1699095159.git.bristot@kernel.org/
https://lore.kernel.org/all/20240216183108.1564958-1-joel@joelfernandes.org/

Interesting on the soft-affinity feature and yeah that help save power and might
be a better approach than say our usage of RT.

> I have a raptor lake-H laptop which has E and P cores and by default the
> threads are being spread across all CPUs which probably isn't best for power
> consumption. I was thinking about writing a scheduler which uses a similar
> strategy as scx_layered - pack the cores one by one overflowing to the next
> core from E to P when the average utilization crosses a set threshold. Most
> of the logic is already in scx_layered, so maybe it can just be a part of
> that. I'm curious whether whether and how much power can be saved with a
> generic approach like that.

Can the scx NEST scheduler be reused for this? AFAIR, it does similar task
packing. Though that is to keep more cores idle than to pack tasks to a certain
type of core, if I remember Julia's presentation.

thanks,

 - Joel

