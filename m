Return-Path: <bpf+bounces-22239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C81859F56
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8213FB20BB9
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86622619;
	Mon, 19 Feb 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Lm1Pcsea"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A422098
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333896; cv=none; b=TiTbZAt+QDyPo1+N8s9uJ+FFEWH+xrh4+P4lAq6dXpLpjIVEx8/1ACqOAUJyXhp/2Ve00/1FDz02v60pyB+l8X9Qtsvw1O90ZINDJrsOkyHFUNAyMLrggMJcjXKePuv8Ut8S188TrFiAqFFqn7mYjTQjezbGtCNextG9NSFqUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333896; c=relaxed/simple;
	bh=1WdiEP+0fA+v16Oei/yLsxaxyP4HsTJoMMhhaj9M2Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0hX6LD52RTYp6LIjdmBQM5bWJrIj17SNlvGWbI21CnSe4qBTL4JLdFhqCCGM31tzzkiron+2nN047U7PZpQvkyMmHxGIs+LVk0boJpdLceUkf5cu068ZtHHy4etcAB0+StnHwCuf1bcywG8uHVWsfuAJP/aH/f06hTZrNmlcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Lm1Pcsea; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68f41af71ebso25366316d6.1
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708333894; x=1708938694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrK/mzYV98JZRDND2ZbtiaPxIsN4h8AdKvp2Uw1jyuk=;
        b=Lm1Pcsea0L8zDOE27HKuBW0nGEuDtmaIKNRPg8jVbWTm/iTi/1SlniRqs6eHQEw7Hc
         99DXgjfmApu2GLHGahueR4BFXHPHiSYIOJMnol466AHQMfsatMmvYXDOuy0KlUbvJpZb
         Bm7TsPtU8kIq+iZapaUoepxKsBzfO0fRVTIwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708333894; x=1708938694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrK/mzYV98JZRDND2ZbtiaPxIsN4h8AdKvp2Uw1jyuk=;
        b=Vdc7/BFRHAC91ALV8mjuh2Bk2pX4kSXgBnp9kO2TrU2+xKQyRRaui1L13yxE0LsaRP
         BYPGIf24xGNDt/2pJV0eyEwzTjpexLqqT4KPP5dMdJ/heEcGtSIVTc9lGUE6+6rj4t4d
         JhVA+A5mPnknVFVYpW3AX7P7oa4IhMdiUgfkW51tbccUduOHhI9bGloCn/ltmR+tvYB4
         aHUSZ9/8540YT2X7nu9hFVyQlxkSnPGu+vssDA5IPZV3l9d6E7wBHal8Vr5orB7+Jo0S
         eIREdMiFMA7BJgtbUV6EvTHRvJwo58M0tY7MtAcxytlwRcmipooxWqwgxr1ifwqjycoV
         MqMg==
X-Gm-Message-State: AOJu0YxgyVE/HovcKn1/xhuMSqG/JEjL/LIr+VKdCP7sHvvkbaw+5JHx
	I/bPEzUQhjmqqDwlu8nfauurBGonzFv7u2d3KOKLzz94z3yUaFC42la/wx22nzg=
X-Google-Smtp-Source: AGHT+IHIefgen36OLi8bhje0qZ3N6hdCoiSBC/26WeqjC4/nJDcC3Iix/lUgdB/biSLC1JUfAS0+dQ==
X-Received: by 2002:a0c:c990:0:b0:68f:5c6a:172e with SMTP id b16-20020a0cc990000000b0068f5c6a172emr4666636qvk.48.1708333893858;
        Mon, 19 Feb 2024 01:11:33 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id oo6-20020a056214450600b0068c440bc7d0sm2918349qvb.105.2024.02.19.01.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:11:32 -0800 (PST)
Message-ID: <9aa4b307-145e-4188-8027-df8360a8cd32@joelfernandes.org>
Date: Mon, 19 Feb 2024 04:11:27 -0500
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
To: Muhammad Usama Anjum <musamaanjum@gmail.com>,
 David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, htejun@kernel.org, schatzberg.dan@gmail.com,
 andrea.righi@canonical.com, davemarchevsky@meta.com, changwoo@igalia.com,
 julia.lawall@inria.fr, himadrispandya@gmail.com
References: <20240126215908.GA28575@maniforge>
 <41193af3bd250b9e1e4a52e6699fdbe59027270d.camel@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <41193af3bd250b9e1e4a52e6699fdbe59027270d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/2024 3:48 AM, Muhammad Usama Anjum wrote:
> On Fri, 2024-01-26 at 15:59 -0600, David Vernet wrote:
>> Hello,
>>
>> A few more use cases have emerged for sched_ext that are not yet
>> supported that I wanted to discuss in the BPF track. Specifically:
>>
>> - EAS: Energy Aware Scheduling
>>
>> While firmware ultimately controls the frequency of a core, the kernel
>> does provide frequency scaling knobs such as EPP. It could be useful for
>> BPF schedulers to have control over these knobs to e.g. hint that
>> certain cores should keep a lower frequency and operate as E cores.
>> This could have applications in battery-aware devices, or in other
>> contexts where applications have e.g. latency-sensitive
>> compute-intensive workloads.
> The current scheduler must already be using the frequency scaling
> knobs. Can sched_ext use those knobs directly with hint from userspace
> easily?

With regards to the current way of doing things, it depends. On Intel platforms,
if HWP is enabled (Hardware-Controlled Performance States) which it is on almost
all Intel platforms I've seen, then the selection of the individual Performance
states (P-states) is done by the hardware, not the OS. My understanding is the
benefit of HWP is responsiveness of the state selection. So the only thing OS
can control then is either Turbo boost, or EPP.  Unfortunately, this hinders
using an energy model and doing energy calculations (ex. If I place shit on this
core instead of that, then the total system power is such and such because
P-state on this core is this) the way EAS on ARM does. But maybe we can do
something simple with what is available and reap some benefits.

On ARM platforms, there is more finer grained OS control of different operating
performance points (what they call OPP).

Thanks.

