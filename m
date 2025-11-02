Return-Path: <bpf+bounces-73268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABCC296C5
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 21:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9AA3A7A86
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 20:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0922B8CB;
	Sun,  2 Nov 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FAL7bBL+"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F301EA7EC
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762116891; cv=none; b=k7ivnLhcwPsSFjJdVgi1HSVBww0v/OzPWSCpJOLKvD+B6eu21oxkA/4fcA3ptp+dCe9Vd5ePDzPdvKZF2AvgKWFD0JPT0RNEhEbt99I4gAuAZlMGVDShV3tqB/7sQhHAzlteqq4KYagGLY6ikLfAOO0VHcCEAzHBufLybmKy7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762116891; c=relaxed/simple;
	bh=znhB0HYu7BCHSK5WYxf36KgmWLvUZu3y3u3yHP4Ud0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTNamtBKsS7Dv6IeUAXhd556imCB7Iylb3juMc51hxZ6S4txlnD31UrRPI11nYIcFTWmi9rOjyM5kcFt7nYI9px3Auy1LFDTwmS9YnYKRen/yg1sNbfy9zl2n1D7K9lpXy+RaDAS9veeP9zkKAw1qzLxXHWhEc175HPGC5O4G3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FAL7bBL+; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762116875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vSoLTMn7D7wRI+KcjGWMGJNZbmIDanYc/C6CsZGY6C4=;
	b=FAL7bBL+C4exDYR5oCnLVtwAWj+9G1H9ZgsdMgNY1fT9EkYaCt1Oyygsfg30HqDWIOTChr
	Drhu3O+o/jfQzjrcQwvyWMuxQ1W4mQNaTYonOereiy54CtofgwkshbhVvMobBUBKFZ4/6d
	EroT4lTO5LUCSggGDgSv6KlmZ+MNLtg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
In-Reply-To: <aQSB-BgjKmSkrSO7@tiehlicka> (Michal Hocko's message of "Fri, 31
	Oct 2025 10:31:36 +0100")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<aQSB-BgjKmSkrSO7@tiehlicka>
Date: Sun, 02 Nov 2025 12:53:53 -0800
Message-ID: <87ldkonoke.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
>> The second part is related to the fundamental question on when to
>> declare the OOM event. It's a trade-off between the risk of
>> unnecessary OOM kills and associated work losses and the risk of
>> infinite trashing and effective soft lockups.  In the last few years
>> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
>> systemd-OOMd [4]). The common idea was to use userspace daemons to
>> implement custom OOM logic as well as rely on PSI monitoring to avoid
>> stalls. In this scenario the userspace daemon was supposed to handle
>> the majority of OOMs, while the in-kernel OOM killer worked as the
>> last resort measure to guarantee that the system would never deadlock
>> on the memory. But this approach creates additional infrastructure
>> churn: userspace OOM daemon is a separate entity which needs to be
>> deployed, updated, monitored. A completely different pipeline needs to
>> be built to monitor both types of OOM events and collect associated
>> logs. A userspace daemon is more restricted in terms on what data is
>> available to it. Implementing a daemon which can work reliably under a
>> heavy memory pressure in the system is also tricky.
>
> I do not see this part addressed in the series. Am I just missing
> something or this will follow up once the initial (plugging to the
> existing OOM handling) is merged?

Did you receive patches 11-23?
git send-email failed on patch 10, so I had to send the second part separately.
It seems like the second part did at least to some recipients, as I got
feedback to some patches from that part.

In any case, you can find the whole series here:
https://github.com/rgushchin/linux/tree/bpfoom.2

And thank you for reviewing the series!

