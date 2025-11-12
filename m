Return-Path: <bpf+bounces-74265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E27C503AD
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 02:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A004E9BC2
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 01:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726D28C2BF;
	Wed, 12 Nov 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dXvcihTj"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F612877CF
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 01:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911913; cv=none; b=kP8gj7YA+MxCf5hgYR7wU9czvJ7QKj0pVc+/6iME148j65JoDzeSuuh/CaQaa2W19a2wCEwJO8EqiK+Cn+xyar7S7HJCP6P0s2OjcyNGW18TbuFHaUojbfJXPRCO4qu0YPvepcAJfPwZWVaSxYr4CZ6HQBQlQdqxzfCQisu84ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911913; c=relaxed/simple;
	bh=kqsnlqjSa4IhOrl9lShbvf9SEWNTMIYvIgS6Hka5KSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NS27pssrqkRIFNbrvsw3JqsHuK/xR1/3ml4iEs49RPM+IMCb/zFHTeN86w40T9C13hatm5U+oWhyeZwYQ/NTbHCeA2kAT5rggBXtpJDSM5WXZSo0YaoiEepM45D3hqnb4SiQC1ZbstzV9a7ZpfOg2aiMD+OGCRNVVet3SsguVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dXvcihTj; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a85e262d-0e04-41d9-9420-56a1ee1aeed5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762911899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPXmbSUrivLtKg3Q34VPnZo217pp+kGwg6tsDxXR0ts=;
	b=dXvcihTjaPEol0gaKNaafEuJl1ZGcBR4ln4HQke9wnnZPgJTSmjEyH4cuCGESkGMZbFISe
	ArnYcsnP6PHmie2ZK2i9duAq6VRkxpfIdEC+XlbdT9Vs/I57MZyML+uyb1crP480vVJrtt
	oelXpEIIzWySypYTVhFIj7UG774mHIY=
Date: Tue, 11 Nov 2025 17:44:45 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to
 fix OOB write
Content-Language: en-GB
To: Brahmajit Das <listout@listout.xyz>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
 <20251111081254.25532-1-listout@listout.xyz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251111081254.25532-1-listout@listout.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/11/25 12:12 AM, Brahmajit Das wrote:
> syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
> triggered via bpf_get_stack() when capturing a kernel stack trace.
>
> After the recent refactor that introduced stack_map_calculate_max_depth(),
> the code in stack_map_get_build_id_offset() (and related helpers) stopped
> clamping the number of trace entries (`trace_nr`) to the number of elements
> that fit into the stack map value (`num_elem`).
>
> As a result, if the captured stack contained more frames than the map value
> can hold, the subsequent memcpy() would write past the end of the buffer,
> triggering a KASAN report like:
>
>      BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
>      Write of size N at addr ... by task syz-executor...
>
> Restore the missing clamp by limiting `trace_nr` to `num_elem` before
> computing the copy length. This mirrors the pre-refactor logic and ensures
> we never copy more bytes than the destination buffer can hold.
>
> No functional change intended beyond reintroducing the missing bound check.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Signed-off-by: Brahmajit Das <listout@listout.xyz>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


