Return-Path: <bpf+bounces-20635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3F8415D8
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 23:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F281C22F08
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CB4F1F5;
	Mon, 29 Jan 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vXupRyM1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752C208A5
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568110; cv=none; b=nnSJHBwkMEpvbgNRIJgLyXCYXZJYw/R5b9gYXetgouGU6oAykhOqdKI5Io6biUbhqab+tdonsAR552KT7DiQnEZTn9DhUoQ+17LDoE3jma2NsGbNkjWheysHCoSpX0rH8n5yOLEeOTiJ9ueVH6iK6HWFA1rAuEX/gJ3Kt+MpSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568110; c=relaxed/simple;
	bh=BEVgxCcz1tJ4OESYosl5u5hjog+5sryv5Exep9lS5CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbumCPG+ABUiFSkyaG4lGkaqdMDYvcnaOtBdspgWMrocTP9NWvZXE1tX6PsTHVeQ7EcZNlK0bgq/neRlgwW+4ZMMoRirhfQDYXQm5fGtzc7Tq2LvcRtG5UFcqXLzVw9IHrtnGwOXiYH8aNdKgAYsmlCxGrs73uftWU3xbG1tgFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=vXupRyM1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783ced0216aso244727485a.1
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706568108; x=1707172908; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lsnle3am1REkSSK8vbdjiCmlL58zuIi1ZmA2Vy2Nzm8=;
        b=vXupRyM1jZR3HNzammJFDCDh5BcfWtQud1/PTtjW0lDOGSxmiwf37cmPqoYac8ltwR
         ga8ygW2H2Ai9g13JCSze43YQYUR2hfhPs+0gfgI5vjnORjL0JEVqyID2QKCgtZimYD8j
         BDJxsF8DKmPwuZKJYUe8iblTonV1aJlntCWi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568108; x=1707172908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsnle3am1REkSSK8vbdjiCmlL58zuIi1ZmA2Vy2Nzm8=;
        b=ZNo8TA8B45d09IZHcxTa+VEbRafIUDoG+roO3t70nnKKV1vp3NvusHV/BurQ0mYu+g
         aswFs/EqlohRCEE7wMwt2zG42SNCKYEor4Hmiddhh3tFx15BbcgNUyhjZOdR6majZXI6
         MPeQWQlcYxLnslE4O7ekmxcUmw343V/k1NUwSfhWCVgfPaTgdLLM0161rNFdIz18F6Ji
         83RXuxEmdqChrLNVYGhD1C+O63JvUCZKJswdxK9mJ8wHsjHCFN9okERRxGSDHpZt/6vC
         7YRg+xH+fV2pzY0dSxr62Q6txJElG8DaXZoj+VxpH+ZDDGos5GXky2wuizXLTH9AwtEd
         5m6w==
X-Gm-Message-State: AOJu0Yx4DnCyg44mrptiktx2TWg/0MDKJfsGA6I5jK8gcWMDvIDJT3XF
	eM0MTW84o5DkB71gro5bYLQbztlVD5nJHGo40BSfgb/79e1q8de1gwujXfBoSXA=
X-Google-Smtp-Source: AGHT+IGOosuFVDfewqgGcNpeO9LxFijea2FMPa4QIDSZP9KfPImnXHCFJtr/agZmxLb8S92P48No9Q==
X-Received: by 2002:a05:620a:102d:b0:783:67c6:5d43 with SMTP id a13-20020a05620a102d00b0078367c65d43mr5942627qkk.54.1706568108020;
        Mon, 29 Jan 2024 14:41:48 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a0cc700b00783f70bc497sm1815754qkj.115.2024.01.29.14.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:41:47 -0800 (PST)
Message-ID: <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
Date: Mon, 29 Jan 2024 17:41:44 -0500
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
To: David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org, htejun@kernel.org, schatzberg.dan@gmail.com,
 andrea.righi@canonical.com, davemarchevsky@meta.com, changwoo@igalia.com,
 julia.lawall@inria.fr, himadrispandya@gmail.com
References: <20240126215908.GA28575@maniforge>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20240126215908.GA28575@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/2024 4:59 PM, David Vernet wrote:
> Hello,
> 
> A few more use cases have emerged for sched_ext that are not yet
> supported that I wanted to discuss in the BPF track. Specifically:
> 
> - EAS: Energy Aware Scheduling
> 
> While firmware ultimately controls the frequency of a core, the kernel
> does provide frequency scaling knobs such as EPP. It could be useful for
> BPF schedulers to have control over these knobs to e.g. hint that
> certain cores should keep a lower frequency and operate as E cores.
> This could have applications in battery-aware devices, or in other
> contexts where applications have e.g. latency-sensitive
> compute-intensive workloads.

This is a great topic. I think integrating/merging such mechanism with the NEST
scheduler could be useful too? You mentioned there is sched_ext implementation
of NEST already? One reason that's interesting to me is the task-packing and
less-spreading may have power benefits, this is exactly what EAS on ARM does,
but it also uses an energy model to know when packing is a bad idea. Since we
don't have fine grained control of frequency on Intel, I wonder what else can we
do to know when the scheduler should pack and when to spread. Maybe something
simple which does not need an energy model but packs based on some other
signal/heuristic would be great in the short term.

Maybe a signal can be the "Quality of service (QoS)" approach where tasks with
lower QoS are packed more aggressively and higher QoS are spread more (?).

> 
> - Componentized schedulers
> 
> Scheduler implementations today largely have to reinvent the wheel. For
> example, if you want to implement a load balancer in rust, you need to
> add the necessary fields to the BPF program for tracking load / duty
> cycle, and then parse and consume them from the rust side. That's pretty
> suboptimal though, as the actual load balancing algorithm itself is
> essentially the exact same. The challenge here is that the feature
> requires both BPF and user space components to work together. It's not
> enough to ship a rust crate -- you need to also ship a BPF object file

Maybe I am confused but why does rust userspace code need to link to BPF
objects? The BPF object is loaded into the kernel right?

> that your program can link against. And what should the API look like on
> both ends? Should rust / BPF have to call into functions to get load
> balancing? Or should it be automatically packaged and implemented?
> 
> There are a lot of ways that we can approach this, and it probably
> warrants discussing in some more detail

But I get the gist of the issue, would be interesting to discuss.

thanks,

- Joel

