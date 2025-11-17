Return-Path: <bpf+bounces-74697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A8C62788
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 07:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A02F4E702C
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 06:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9843D30F805;
	Mon, 17 Nov 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2+SBHFc"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF342D6E59
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763359601; cv=none; b=MRECZr228I7AqmoQadz7xBI93Om9AvJ1NlrjnTqAnJs7IxhTUnuXwV7ybfb0jD6S7xlXwzS8RVBIkThf9i53zApeu6ArWzKBhAsw3ukBPrbiNS1O8KJNBxksj94Q5Y5vwgW9rPFvp+JyPI6J3B4JafdFvrK0fVkcByUgEBVLo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763359601; c=relaxed/simple;
	bh=fiL6oqMyBG2rjlnTIB3myv/nS2l10i3Q3vtmAqGo4I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY1Odxvb3FcVjI9JAR8mcIMZ6q/rjP5J4oktFvuvY6kK9stgmu218snOqWfBO84XrJqMcyAuw2nR2/fQCuxCNSKRbP+H2pLY8xkZSz5aE6QlYb+M12UyIx1MQhPAg3k7DyRikTmm1bzEUxsvRz7DKG9/WfFZBR/kkZz4JRD6yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2+SBHFc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db1c7ad3-5c9d-4597-811c-4b40b9ae2788@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763359596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C33sRpdbc0u4EVy33VHpB+KZaZ9PvousdUVbPNgqaks=;
	b=c2+SBHFc73U9z2RKaDR14wa6F/jFsbSykJ5zrmH3uHvUjbgg2w4WF6uWGILRVGXXUeKNaw
	UZzGgGWXPXMsj9Ce8vINFmI3MAp5GUc9nM77LGp7pDmJtDQFVrAInV51Kr/py/KG9c5AlH
	20rpXwUZVDA+R9Eo63AtGhuUr41RCvc=
Date: Sun, 16 Nov 2025 22:06:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Plug a potential exclusive map memory leak
Content-Language: en-GB
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <6919bd8f.a70a0220.3124cb.007d.GAE@google.com>
 <tencent_3F226F882CE56DCC94ACE90EED1ECCFC780A@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_3F226F882CE56DCC94ACE90EED1ECCFC780A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/16/25 6:58 AM, Edward Adam Davis wrote:
> When excl_prog_hash is 0 and excl_prog_hash_size is non-zero, the map also
> needs to be freed. Otherwise, the map memory will not be reclaimed, just
> like the memory leak problem reported by syzbot [1].
>
> syzbot reported:
> BUG: memory leak
>    backtrace (crc 7b9fb9b4):
>      map_create+0x322/0x11e0 kernel/bpf/syscall.c:1512
>      __sys_bpf+0x3556/0x3610 kernel/bpf/syscall.c:6131
>
> Fixes: baefdbdf6812 ("bpf: Implement exclusive map creation")
> Reported-by: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cf08c551fecea9fd1320
> Tested-by: syzbot+cf08c551fecea9fd1320@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


