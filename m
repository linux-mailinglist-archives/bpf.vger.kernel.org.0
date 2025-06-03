Return-Path: <bpf+bounces-59517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93EACCB1D
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 18:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B91188D802
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5623E226;
	Tue,  3 Jun 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmRERprs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA60227E80;
	Tue,  3 Jun 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967685; cv=none; b=hjbUP6FZRNs63dRmAsC2QaSqp0WqI30HaYR8fhpqYxVxFslsMW7/wJZJiiImzVPUjpreIKVtHIOx+vTn8sX9JGytRuoGQl97RGKlQNqxAFffFPw+OIAwQm/hRvBUaQ4dlZLHfrLlFJtCdFqDn16qV5KEr10GVBo+uV03VrFfyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967685; c=relaxed/simple;
	bh=ShaKJ6k3ehwmyVro9yJK9SMezCPYHTrESjoYdr/FhpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmVa2tkakL/RiBnTN65/AZCoRvVZJx1E/rJoW2K1DrLISNkMQHQzN8I2pbLzO6fNq6MJxeTOuzRWfzY++GY95RaCFZmYylRATKYItpGn74fEXpZRYtmY/ELy+gW24fdoF5oPnhn9/XKBfQGrbSUtljId5Q5byrgsko8rzo3SKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmRERprs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7176C4CEED;
	Tue,  3 Jun 2025 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748967684;
	bh=ShaKJ6k3ehwmyVro9yJK9SMezCPYHTrESjoYdr/FhpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mmRERprshPJPNbkUx21sLKbVzxYMjbM4w8r00IS+jtLkwjIAIkGZhkDI8weOIJePX
	 vuA9ipMVDVCB/NpwaK8LXn3uhKGr79hkmA8jIXnJMhdoA2HRyl+RbhAYUz/TxES2ZI
	 GA0k6vXOlL3HMF9e3sjpXFjLxiJIeBTsTac6mojmxirlSAgqB+c+C9XlSlypMDSJ7A
	 6TVw7wTbRPsJGpXfZncL3PMUPqDWAfPZnMJcIELRxV0UzIAweyXx2sW7YE2troYOqw
	 M/ZNAbfuLZ/+5DiUSs5zdQUaXwQi96qd2oa0ZIQAj0wiMD5ej9K4UkOjBBJux+dGf+
	 2rSS8S/SYVD5w==
Message-ID: <68e3606c-9490-4d26-afd9-82d319e1d9c9@kernel.org>
Date: Tue, 3 Jun 2025 17:21:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Display cookie for raw_tp link
 probe
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603154309.3063644-1-chen.dylane@linux.dev>
 <20250603154309.3063644-3-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250603154309.3063644-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2025 16:43, Tao Chen wrote:
> Display cookie for raw_tp link probe, in plain mode:
> 
>  #bpftool link
> 
> 22: raw_tracepoint  prog 14
>         tp 'sys_enter'  cookie 23925373020405760
>         pids test_progs(176)
> 
> And in json mode:
> 
>  #bpftool link -j | jq
> 
> [
>   {
>     "id": 47,
>     "type": "raw_tracepoint",
>     "prog_id": 79,
>     "tp_name": "sys_enter",
>     "cookie": 23925373020405760,
>     "pids": [
>       {
>         "pid": 274,
>         "comm": "test_progs"
>       }
>     ]
>   }
> ]
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

