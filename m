Return-Path: <bpf+bounces-47905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A088A01D20
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 02:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D0E3A36AA
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7BF41C6C;
	Mon,  6 Jan 2025 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEtf3Saw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CEA184F;
	Mon,  6 Jan 2025 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736128484; cv=none; b=BkDHKQ6ZiCMwPEZ8CuZszBKFYiJZ/LFSTXu28XC19Uybv3XNVt9fZ6Gz/h/e3wE8AbVi14jieNoZOw+J8vVWeo5Z6VSbv3Q4EnljhdbAcD2rdjEo0BF3xU7EmHRmohUHJeej3VlXjZ4Qu2wmtzmk37aGpLPD0Iay4PupMcqMKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736128484; c=relaxed/simple;
	bh=VXHTSlWVeej65C6gWEdXhGhaNxkRXr5jGN61emh9ek8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W68WIVWLBHEmaXk9fj7oqmqJF7u0nDeWhpfQ4zr7h6xHdEXU6xrZSGZfd8fpFcMyxerOhQPPrtgd7/zuf4udQCUj46JMAmk26b79lLyHZ0Xbqc2EaLWAJu6sWlDDvNb50rR4qIm0uGbI13JglPlt3d45/rFiAfUEUuxexDMBvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEtf3Saw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA98C4CED0;
	Mon,  6 Jan 2025 01:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736128483;
	bh=VXHTSlWVeej65C6gWEdXhGhaNxkRXr5jGN61emh9ek8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEtf3Sawb5gYw3jcbVvK/g+/c3EDSX2rcB/mxneDgQOI9p2znVsjTklVuQxF7/DAy
	 yuErRnUtSZXCbqRdy/KAE++Yea+gXBb12mvvaKI28WpVy5rRHvoRlPx6iPPq2hvtch
	 CCtvF8OrHJG0Aa6lvXY7Buaf9eMZLXh7EOzquUmq9adf3LextO2sUsXV0RH2XG7eR2
	 vBsyPAi3k4O7KXKNHQyE7HmQsd7cclN3x5HRZm4uRLrmoPIAMndZaN7R8RGYcB2mXu
	 XGMHIiJThc2+fF0lXn+i0st5Jysv0qnhyJikf84UoqGHA0CfYkBfXqfyUVooFhFchv
	 m0BqcxcVZSV6Q==
Message-ID: <ee32c284-aeda-4efa-adb1-bb4af724d097@kernel.org>
Date: Mon, 6 Jan 2025 10:53:58 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>, Song Liu <song@kernel.org>,
 hch@infradead.org, yanjun.zhu@linux.dev
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/25 2:52 AM, Vishnu ks wrote:
> Thank you all for your valuable feedback. I'd like to provide more
> technical context about our implementation and the specific challenges
> we're facing.
> 
> System Architecture:
> We've built a block-level continuous data protection system that:
> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> 2. Captures sector numbers (not data) of changed blocks in real-time
> 3. Periodically syncs the actual data from these sectors based on
> configurable RPO
> 4. Layers these incremental changes on top of base snapshots
> 
> Current Implementation:
> - eBPF program attached to block_rq_complete tracks sector ranges from
> bio requests
> - Changed sector numbers are transmitted to a central dispatcher via websocket
> - Dispatcher initiates periodic data sync (1-2 min intervals)
> requesting data from tracked sectors
> - Base snapshot + incremental changes provide point-in-time recovery capability
> 
> @Christoph: Regarding stability concerns - we're not using tracepoints
> for data integrity, but rather for change detection. The actual data
> synchronization happens through standard block device reads.
> 
> Technical Challenge:
> The core issue we've identified is the gap between write completion
> notification and data availability:
> - block_rq_complete tracepoint triggers before data is actually
> persisted to disk

Then do a flush, or disable the write cache on the device (which can totally
kill write performance depending on the device). Nothing new here. File systems
have journaling for this reason (among others).

> - Reading sectors immediately after block_rq_complete often returns stale data

That is what POSIX mandates and also what most storage protocols specify (SCSI,
ATA, NVMe): reading sectors that were just written give you back what you just
wrote, regardless of the actual location of the data on the device (persisted
to non volatile media or not).

> - Observed delay between completion and actual disk persistence ranges
> from 3-7 minutes

That depends on how often/when/how the drive flushes its write cache, which you
cannot know from the host. If you want to reduce this, explicitly flush the
device write cache more often (execute blkdev_issue_flush() or similar).

> - Data becomes immediately available only after unmount/sync/reboot

??

You can read data that was written even without a sync/flush.

> Proposed Enhancement:
> We're looking for ways to:
> 1. Detect when data is actually flushed to disk

If you have the write cache enabled on the device, there is no device interface
that notifies this. This simply does not exist. If you want to guarantee data
persistence to non-volatile media on the device, issue a synchronize cache
command (which blkdev_issue_flush() does), or sync your file system if you are
using one. Or as mentioned already, disable the device write cache.

> 2. Track the relationship between bio requests and cache flushes

That is up to you to do that. File systems do so for sync()/fsync(). Note that
data persistence guarantees are always for write requests that have already
completed.

> 3. Potentially add tracepoints around such operations

As Christoph said, tracepoints are not a stable ABI. So relying on tracepoints
for tracking data persistence is really not a good idea.


-- 
Damien Le Moal
Western Digital Research

