Return-Path: <bpf+bounces-77972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED724CF9460
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 17:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E1A2306C4AB
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFDC338F5B;
	Tue,  6 Jan 2026 16:05:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE133BB4A;
	Tue,  6 Jan 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715501; cv=none; b=sr7fRXdVykM0CF4Z4s/YH+5Mtvo8R8XO72zxOHkOzqpa+omZ1Qlt57+0glX/hvQA0YhRZsfyOKa/j929Hyc9rvy2hOf+DIwid72vWH24iQazexJ3iO4VZ/eh/IlgxCQneYenTFRgS2M3bkADs7iuXJ7rZSMKU4vBes4XBoJIIQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715501; c=relaxed/simple;
	bh=bQlqTi+fgNu8g36BdhCMNW50Cji31Li3Lj/KV4lEO5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvnJd3DT0ZvpZ+I1iwTal2nhOkI/7uAFnfIqnE5dewn+Vv+baLqx8i1AjnQZhDn8UF/5FErAYpn0AdJ1hfj20Qiho1REyMv4xj7NbpuaLDi1DQyc8Cb60pxJM4vZ2HiNNSU35RT4kpFQWeYWDCUrUwM5zrSgVltPT1Mb9tGBa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 329C31403C1;
	Tue,  6 Jan 2026 16:04:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id DF69A20023;
	Tue,  6 Jan 2026 16:04:54 +0000 (UTC)
Date: Tue, 6 Jan 2026 11:05:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin
 <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org (open
 list:Real-time Linux Analysis (RTLA) tools), linux-kernel@vger.kernel.org
 (open list:Real-time Linux Analysis (RTLA) tools), bpf@vger.kernel.org
 (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_))
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
Message-ID: <20260106110519.40c97efe@gandalf.local.home>
In-Reply-To: <20260106133655.249887-16-wander@redhat.com>
References: <20260106133655.249887-1-wander@redhat.com>
	<20260106133655.249887-16-wander@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: DF69A20023
X-Stat-Signature: ipuk75zqimd45pr8xdnmfmrpnepz91j8
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198qTr+o9HNEZklP+qRkJum/HEVvFYbSVY=
X-HE-Tag: 1767715494-244863
X-HE-Meta: U2FsdGVkX1+/uW8vIOUg6fX4tnHxYIBdB4DMHhUfvlSqv7Y9DJg3P5x58unOSJ69kmLYfIGIcItCRLjMSaMkQpaJ1AlYqLCP9eRVdbtQfTatEO4ozO9aH88A7QVpDS56mFgLmlfyQc3uDPJoX4qtlR40GayIzrHCxaSyh8jR+j+zZtjr2o0WMKdcCBwbGHTuJppP7Am/snhXGOy5FaSKVL2IWU3XRRwZ1GJdJYymu05TpOSlCg/C6yThdLwP2hQTdvwwvQsF+dZBZcXlfOnJGT7Phf88EPzVvM9lBPD3h3iuXDtp/zNTbzEnBwLNQcT69o00idLvnhRwSMrfyB/1iy1AhJOfazVO

On Tue,  6 Jan 2026 08:49:51 -0300
Wander Lairson Costa <wander@redhat.com> wrote:

> Add the volatile qualifier to stop_tracing in both common.c and
> common.h to ensure all accesses to this variable bypass compiler
> optimizations and read directly from memory. This guarantees that
> when the signal handler sets stop_tracing, the change is immediately
> visible to the main program loop, preventing potential hangs or
> delayed shutdown when termination signals are received.

In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
should implement that too.

-- Steve

