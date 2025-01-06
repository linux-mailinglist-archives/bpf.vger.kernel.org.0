Return-Path: <bpf+bounces-47953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66BA02841
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E4B3A214F
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F471DE2DA;
	Mon,  6 Jan 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLi2So6Y"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A351DE894
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174382; cv=none; b=RAjQr76bVFdWFb07TKMXvrLmRibqaBMkH9yTIqH5qguZAvBJ3xqrtmeLQBxyIhPU3IURaOx6wlMIBFbHS+Zubp+tOVlVTpElDh0R6Su9WarSc8tXLEKOUU9NCrz7dVKatUNmaOZlmhQV5SsNBW1N0cZ/8CBxEQpzt+Zi9L0RMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174382; c=relaxed/simple;
	bh=pEcdNS6biiuDg5Lz2TFAPdrcZP4bEIgW5De5HoGw8aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CA2Pl9x3dza5e6c48UY3HImLhJ+k9jHxFrooOLii7kjW9dJNJAItfibqsMo0Ra+OUTLufJLZxOqo3eXBY8EYrNhJuLTJWVzLZhhQOSCip9wOE+v1kNWHh3DF3VWD7wuStkOYSqQccYJlaNVD58LkvNO2bgIRNFgTDtc63YhZ5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLi2So6Y; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736174377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QBb1SxSbkhq0fjJPP/D8igQzmWEtDwWTFQrDDQ04OM=;
	b=JLi2So6YMgc1dnvVKl8hkq5wxmbpmbt93tP9dW3JvqKloiWUhxBzIW4jWw3BIH4IdoUiuD
	9wXf2ugoGGIVDR78uxu6XWy1ZOr8e/zHj8vPORYlyin6Oy6bcJETw/dBqjDwmgeLJYnrPl
	dmUulL7tkr6kcGySvUEWJOd+D5/Ekcs=
Date: Mon, 6 Jan 2025 15:39:34 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Christoph Hellwig <hch@infradead.org>, Vishnu ks <ksvishnu56@gmail.com>
Cc: Song Liu <song@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, bpf@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <Z3uIOPxr4s09qS1X@infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z3uIOPxr4s09qS1X@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06.01.25 08:37, Christoph Hellwig wrote:
> On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
>> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> 
> You can't.  Drivers can and often do change the sector during submission
> processing.

If I get you correctly, you mean, the action that **drivers often change 
the sector during submission processing** will generate a lot of 
tracepoint events. Thus, this will make difference on the performance of 
the whole system.

If yes, can we only monitor fentry/fexit of some_important_key_function 
to reduce the eBPF events? Thus this will not generate too many events 
then make difference on the performance.

Zhu Yanjun

> 
>> 2. Captures sector numbers (not data) of changed blocks in real-time
>> 3. Periodically syncs the actual data from these sectors based on
>> configurable RPO
>> 4. Layers these incremental changes on top of base snapshots
> 
> And all of that is broken.  If you are interested in this kind of
> mechanism help upstreaming the blk-filter work, which has been
> explicitly designed to support that.
> 
> Before that you should really undestand how block devices and
> file systems work, as the rest of the mail suggested a very dangerous
> misunderstanding of the basic principles.


