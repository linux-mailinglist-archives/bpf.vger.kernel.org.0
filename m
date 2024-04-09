Return-Path: <bpf+bounces-26230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F1689CF35
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 02:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E831C217BE
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51295383;
	Tue,  9 Apr 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlkLyyHX"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F092572
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712621461; cv=none; b=aDG75YNsTQ4pdzU8FzKJwbX5uTE0r7unU6DgGUzpWRg9iD3Tj2zacE8/Z2t+p2ZESbJoGUZMMRuhBWWOad+oa8djY0gQPrU0WFv1rDoHdAUwgQGiGn6i46ycnRX1P0E/SlQGASZSHxSkZxup4m46xp5WfK2HXyJO6ufIqVJNAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712621461; c=relaxed/simple;
	bh=jHhcISfvM5hw7cGoH7GmgOSBwsHp6ACYR2aJyOjpY8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa+DvZkVa3BtGL1YliOQKlCGjEfXGjkMddSB2MgNbdfIA3iiZXNnX+MDN+9yJwnn0qvtLp+1Wcbdrj76hQR1Ep/26eAz1TLIUfdyHSLMt8uSJDZM5wVvpNOOblbdof3vjT9HnOiU3LISlbVw3Zpd0n9OzVR6VyY41HFVtTdro74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlkLyyHX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <737ae55d-3cd0-40fb-b3e9-3b676f1f735f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712621457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sjp5f9oGLEoLkHdn8mA9hv760wrE2Mtc0mHWY7INqz8=;
	b=LlkLyyHXayvJ2oLUWrzshr7bf5ZTEEuDnUEiflTdRU6YK2A8fJZjfrRUB941Uh3Kbm7m8d
	Mr0BddGphdRLxPPg0PvAWC5py9I3f4EJ27htGz7irp1grKnHhVR2ILg1xXbsg0rJvvjT+J
	26y6vC662TUE6I6neMclRoL6ja/jbm4=
Date: Mon, 8 Apr 2024 17:10:48 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: dereference of null in __cgroup_bpf_query() function
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240406151457.4774-1-m.lobanov@rosalinux.ru>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240406151457.4774-1-m.lobanov@rosalinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/6/24 8:14 AM, Mikhail Lobanov wrote:
> In the __cgroup_bpf_query() function, it is possible to dereference
> the null pointer in the line id = prog->aux->id; since there is no
> check for a non-zero value of the variable prog.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>   kernel/bpf/cgroup.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 491d20038cbe..7f2db96f0c6a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1092,6 +1092,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>   			i = 0;
>   			hlist_for_each_entry(pl, progs, node) {
>   				prog = prog_list_prog(pl);
> +               	       	if (!prog_list_prog(pl))

prog cannot be null. It is under cgroup_lock().

> +				continue;
>   				id = prog->aux->id;
>   				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>   					return -EFAULT;


