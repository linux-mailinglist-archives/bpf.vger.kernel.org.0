Return-Path: <bpf+bounces-20636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCB8415E2
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 23:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F91C2351A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394E4F1FA;
	Mon, 29 Jan 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="idlXAgni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE174F1EC
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568180; cv=none; b=lgLHpgiOs2+MLQ8A/d6Z7nd++Gamqvo+euszPAy59wD/zQv5+4WQqq8gFwDWbQqG+98iK0dYDZE1uwluw93ASJHAErRVUt52A0CTd7WGsGPxTO18qujqbWnE1kp+U+SIIQjyJvywAEE2J+H4234Cr25Lm9w+DM3llhP8yjWqhic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568180; c=relaxed/simple;
	bh=SY5wNKeb1y1XYOJ4gfmcw37vIKfZrGtEg9MQK+dkn4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ntr04w8FQiTev8/pepDv2tdkeBSFCxHC7IYmuZ4ikNN0rFitf1JRqQrWrz1vqVF8LH16n0lA8TtYCZtLwbW02GT7uY8iwVdJaBxwdqHbLpYCK0s+U78oOu4fdcod3+AJkkLSsEqvHRCYVu2ouLKHgPXSVbCnKum0zip6aIyXE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=idlXAgni; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc223d20a29so3115942276.3
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1706568177; x=1707172977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4W3XsR9NSIY5bmgw8jMaohnLwKClIALZbJVOfI/TEY=;
        b=idlXAgniw0w9x30B0k2cencA5VwDQAuLKgswCArn8mamk2tZTOOA9aKcleB+oWAo1Z
         MRiIlO0uJ9QN5WDF0O6y3UXU1E/3vGbOKROIfCKBnMH96SqYZGA7fpBrBZoBzL5d4N4b
         9jC+7KyB0IlNip5mBGpmm/Bo2ssJk8HuL+rCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568177; x=1707172977;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4W3XsR9NSIY5bmgw8jMaohnLwKClIALZbJVOfI/TEY=;
        b=aLqOPsxK/tvCoKr+mvUTGsoGf7xrYyaDl8pXQf5ZtVt41/F38oD3cBJv2Lj6mu9BYO
         9sWSKYo7nFYY7LJ6aB48qh33Ne0JDo5PpGRnhbufrNi/mFMGdoNduPgQV/7gO8TYxoXd
         LQwSa4QpcJJi1aybMofn6mFZ55W/5027aKdwwFl6i5tJ6BhpMK9g7j40A9zD3/yZ7h/G
         NBd5BT/wavKvpIJ6tC0Q6XzqbQzLQY287k1MP1UY2zqbHXecvQx5WEuwGpYRYqwGvpU6
         LtzWDYQzqXvw6wqtIfCroyfHDcMoM7WMAJn1EHuQ591VkXo7f06ZyKtvn8GkkLA+QnyJ
         Mwlg==
X-Gm-Message-State: AOJu0YxhiCKnRMcGXYlQk5QnhgOfLV1FDs50QwM/c7BSeKXfoiXkLfUC
	Yp9InLLeBU8Oqa+9rT/WLggg/o8BJIw3X/k5/xTsrhNQ0BTYSgb3yIMbBp/7peqxSVpzZDRtrCv
	o
X-Google-Smtp-Source: AGHT+IGp07cPXFLiDwC4zcI6vOJsQ/c6LSdipfAlhHDlV8hVYmKTf/PljPwWBpsGgCoEgTXezMgtJw==
X-Received: by 2002:a25:8201:0:b0:dbd:aac1:4049 with SMTP id q1-20020a258201000000b00dbdaac14049mr3853223ybk.32.1706568177667;
        Mon, 29 Jan 2024 14:42:57 -0800 (PST)
Received: from [10.5.0.2] ([45.88.220.198])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a0cc700b00783f70bc497sm1815754qkj.115.2024.01.29.14.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:42:57 -0800 (PST)
Message-ID: <47d47cd3-f49c-401e-9f45-b3de5a084b67@joelfernandes.org>
Date: Mon, 29 Jan 2024 17:42:54 -0500
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
To: David Vernet <void@manifault.com>, lsf-pc@lists.linux-foundation.org,
 Tejun Heo <tj@kernel.org>
Cc: bpf@vger.kernel.org, schatzberg.dan@gmail.com,
 andrea.righi@canonical.com, davemarchevsky@meta.com, changwoo@igalia.com,
 julia.lawall@inria.fr, himadrispandya@gmail.com
References: <20240126215908.GA28575@maniforge>
 <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
In-Reply-To: <7f389bbb-fdb2-4478-83c4-7df27f26e091@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tejun's address bounced so I am adding the correct one. Thanks.

On 1/29/2024 5:41 PM, Joel Fernandes wrote:
> 
> 
> On 1/26/2024 4:59 PM, David Vernet wrote:
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
> 
> This is a great topic. I think integrating/merging such mechanism with the NEST
> scheduler could be useful too? You mentioned there is sched_ext implementation
> of NEST already? One reason that's interesting to me is the task-packing and
> less-spreading may have power benefits, this is exactly what EAS on ARM does,
> but it also uses an energy model to know when packing is a bad idea. Since we
> don't have fine grained control of frequency on Intel, I wonder what else can we
> do to know when the scheduler should pack and when to spread. Maybe something
> simple which does not need an energy model but packs based on some other
> signal/heuristic would be great in the short term.
> 
> Maybe a signal can be the "Quality of service (QoS)" approach where tasks with
> lower QoS are packed more aggressively and higher QoS are spread more (?).
> 
>>
>> - Componentized schedulers
>>
>> Scheduler implementations today largely have to reinvent the wheel. For
>> example, if you want to implement a load balancer in rust, you need to
>> add the necessary fields to the BPF program for tracking load / duty
>> cycle, and then parse and consume them from the rust side. That's pretty
>> suboptimal though, as the actual load balancing algorithm itself is
>> essentially the exact same. The challenge here is that the feature
>> requires both BPF and user space components to work together. It's not
>> enough to ship a rust crate -- you need to also ship a BPF object file
> 
> Maybe I am confused but why does rust userspace code need to link to BPF
> objects? The BPF object is loaded into the kernel right?
> 
>> that your program can link against. And what should the API look like on
>> both ends? Should rust / BPF have to call into functions to get load
>> balancing? Or should it be automatically packaged and implemented?
>>
>> There are a lot of ways that we can approach this, and it probably
>> warrants discussing in some more detail
> 
> But I get the gist of the issue, would be interesting to discuss.
> 
> thanks,
> 
> - Joel

