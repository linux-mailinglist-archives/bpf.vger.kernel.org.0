Return-Path: <bpf+bounces-22240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A55859F60
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 10:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A370DB21F4F
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B822638;
	Mon, 19 Feb 2024 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kkDGDH5q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073623746
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334099; cv=none; b=QIA+Wyp8rqLzdw9y8FMXVGWzZxQwzpY9fz6ZB8YPR7S8FPtzJCOlLm/DuPA6NQO00UHAI1557ngEcCDAP59qkKJtC6aXauqAWxWDY6L9yrKiXbD1LFN5G+HS7l97oyVNnlzSKWCvqEu4q4u7R8Ijjo3/uDCrXse7Qh0a0RLdx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334099; c=relaxed/simple;
	bh=q13gUA1tjk0X5BE4hqv4ZpZ2k+XdGcwE0axALYn5cYw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=krMNNlja1qCEu2ElEDgLU2tE7Qald1y1U8nhz6IqaTBMldGK1msRdG1tmhi4glErUtcKJZLaUEdxA/Vh7e5AuIbG/RgqkUEfhe+FflP3zOWNJJTdvWCqP7kNLDTNeBWn7HIjeJejpSEyhweY75QKbKX+z1MT1Arp7v78eezxl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=kkDGDH5q; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68ca1db07ceso27318516d6.2
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 01:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708334097; x=1708938897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22Jstu7+TFc9RfUxT2/Fkn8ZNqUrR8ZCiBni3W2t3OI=;
        b=kkDGDH5q8rU3tf8urLrU+jXLdj7mjG0KW8j6RWJEXynUYAtxbOtlISvGl0BS/iDc3/
         9Glzr/jj1zla/5kWaQ87sMRHVRGnRyi3f+eVNEAyvr9uzhx2MOy952zuwtNG0vdlhHo/
         TA6vdx7Qe3G4P+ePZeL5hkKWQ7GYXhlQnZgXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334097; x=1708938897;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22Jstu7+TFc9RfUxT2/Fkn8ZNqUrR8ZCiBni3W2t3OI=;
        b=DeXtMswRYPwX31XSINBnGVOaGtzaKOCRYN7ejyr/nwZ5Vq/DF6kazohE8GoNQq7Sfh
         KWfkgK7Br1lQf2IScGxArbcL4JXlfN3FaQqLH4IXy44T335wHUYKn+Ri93sJWhFRy6WE
         WnwxOO4EtNvXSNPXVwqABQNp/P0oPTeaIuKL6YLGrNUp7iqgMHBSF0ads7+in8y75EVD
         RsXz0apEYv/KN28fCUqVAP59Pcza2ChcObSiRMWXrL+rq5eQ+IGpr+IslGZQmYA3oJPj
         37bHn0ARciBfccAk0nCGrbCy6wGtUlyPlH744qNonHeiFlfbzgPIX1fqitmWk/iaipER
         c3YQ==
X-Gm-Message-State: AOJu0Yy75GlvnF9THYz4I/A5tJ7Ge6y2q+lG3OZR5/6WmmVzcB7yoeBY
	nZiDqNvwOrfBWQWlEsDFSVWZ7VA80LXnpW/Yq1qhXXXwpo0P0SC3bovPf851PnY=
X-Google-Smtp-Source: AGHT+IGzkCArRY0FAh7zeuE95CcPd/pV3pem1aKiZqMIztT0bRvjdNQdExJORAkkWSxJS/mrWvOS5Q==
X-Received: by 2002:a0c:ca0f:0:b0:68f:144f:4c4 with SMTP id c15-20020a0cca0f000000b0068f144f04c4mr14307977qvk.37.1708334097258;
        Mon, 19 Feb 2024 01:14:57 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id qm12-20020a056214568c00b0068c88a31f1bsm2990597qvb.89.2024.02.19.01.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 01:14:56 -0800 (PST)
Message-ID: <3ff747ca-65c0-4f8b-83d9-71f66d680749@joelfernandes.org>
Date: Mon, 19 Feb 2024 04:14:51 -0500
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
From: Joel Fernandes <joel@joelfernandes.org>
To: Muhammad Usama Anjum <musamaanjum@gmail.com>,
 David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org,
 Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, schatzberg.dan@gmail.com,
 andrea.righi@canonical.com, davemarchevsky@meta.com, changwoo@igalia.com,
 julia.lawall@inria.fr, himadrispandya@gmail.com
References: <20240126215908.GA28575@maniforge>
 <41193af3bd250b9e1e4a52e6699fdbe59027270d.camel@gmail.com>
 <9aa4b307-145e-4188-8027-df8360a8cd32@joelfernandes.org>
In-Reply-To: <9aa4b307-145e-4188-8027-df8360a8cd32@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Fixing with Tejun's correct email address again. ;-)

On 2/19/2024 4:11 AM, Joel Fernandes wrote:
> 
> 
> On 2/19/2024 3:48 AM, Muhammad Usama Anjum wrote:
>> On Fri, 2024-01-26 at 15:59 -0600, David Vernet wrote:
>>> Hello,
>>>
>>> A few more use cases have emerged for sched_ext that are not yet
>>> supported that I wanted to discuss in the BPF track. Specifically:
>>>
>>> - EAS: Energy Aware Scheduling
>>>
>>> While firmware ultimately controls the frequency of a core, the kernel
>>> does provide frequency scaling knobs such as EPP. It could be useful for
>>> BPF schedulers to have control over these knobs to e.g. hint that
>>> certain cores should keep a lower frequency and operate as E cores.
>>> This could have applications in battery-aware devices, or in other
>>> contexts where applications have e.g. latency-sensitive
>>> compute-intensive workloads.
>> The current scheduler must already be using the frequency scaling
>> knobs. Can sched_ext use those knobs directly with hint from userspace
>> easily?
> 
> With regards to the current way of doing things, it depends. On Intel platforms,
> if HWP is enabled (Hardware-Controlled Performance States) which it is on almost
> all Intel platforms I've seen, then the selection of the individual Performance
> states (P-states) is done by the hardware, not the OS. My understanding is the
> benefit of HWP is responsiveness of the state selection. So the only thing OS
> can control then is either Turbo boost, or EPP.  Unfortunately, this hinders
> using an energy model and doing energy calculations (ex. If I place shit on this
> core instead of that, then the total system power is such and such because
> P-state on this core is this) the way EAS on ARM does. But maybe we can do
> something simple with what is available and reap some benefits.
> 
> On ARM platforms, there is more finer grained OS control of different operating
> performance points (what they call OPP).
> 
> Thanks.

