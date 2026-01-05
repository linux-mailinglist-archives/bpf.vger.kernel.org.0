Return-Path: <bpf+bounces-77795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F012CF2063
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 06:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDD85301119D
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 05:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71E22068F;
	Mon,  5 Jan 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvUXFoYx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31D83A1E89
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592217; cv=none; b=MrqKSj/VSE11gH00fafx0YSsZqFjuXIkc6WlptW6BC+duVoyN8zFRNYOwdwDaM9b8lS1OX4EEKPEGHP4gylDPnj3nRAAvYuxrbC84NQ9g1zPjgQcTZgqYArcbGOdLsspTzkyRdI1QT7DK+KTWT5bQ0eqXf6Iuk9Yy5+6DiCR2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592217; c=relaxed/simple;
	bh=V4KqZ3driE22w5/F97L1WeQ7I+Gqva5pvc8F8ol3oyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOU9NXfuoGazPv7BBMzdpHKrU7afcEsXevc4S1MfZHQN5/78CMAxC3WxXkpfxdg3xH+einrvqDNWeOGh3ObLAu60opdyhDRjnpiKa8FzTbG5mffE+sxr82fkK10BGB/MGzQ8Kzg5E/LNHjljZbCqOU9cQK23DBK9F0l2d1kErSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvUXFoYx; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a2d0d37-bcca-454f-85c3-063906ecd042@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767592212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4KqZ3driE22w5/F97L1WeQ7I+Gqva5pvc8F8ol3oyk=;
	b=EvUXFoYxVWa/4DMrkhSmRnxwi2VMErcYLJXiOHBH2ZN21LtOHFGQ1HW38zsN6YgvrsPdGq
	62BwHeUixth06jLLS+oF3xW5CJJugPZTyVS4tOfCodTndgieesgjOVVWEWkUAYLCzx4JyY
	4VboiG+6LWkoraGtFHMwmO25hnNDHKM=
Date: Sun, 4 Jan 2026 21:50:04 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 Brahmajit Das <listout@listout.xyz>
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260104205220.980752-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/4/26 12:52 PM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
> during stack trace copying.
>
> The issue occurs when: the callchain entry (stored as a per-cpu variable)
> grow between collection and buffer copy, causing it to exceed the initially
> calculated buffer size based on max_depth.
>
> The callchain collection intentionally avoids locking for performance
> reasons, but this creates a window where concurrent modifications can
> occur during the copy operation.
>
> To prevent this from happening, we clamp the trace len to the max
> depth initially calculated with the buffer size and the size of
> a trace.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Cc: Brahmajit Das <listout@listout.xyz>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


