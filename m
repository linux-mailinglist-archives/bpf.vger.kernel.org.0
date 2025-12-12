Return-Path: <bpf+bounces-76501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC81CB786C
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948233028FF7
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8B3274FCB;
	Fri, 12 Dec 2025 01:13:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AA20A5C4;
	Fri, 12 Dec 2025 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765502038; cv=none; b=KM8rrVxCuS9jOFanRSp5blEq/8GMhfgsseBGA6aOEAohTov+K2QnOHAtsH/mV+FSfl9BVGQJA2uIU0GKe2GMOiXzl+ij9Zia1Hi9RYaXMQ7xGB669RNKWYSvvH1WyzvSiuTi8AfIdSEOBtkR7Muq1QAL48+o5/QsiXhLQ6P+V/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765502038; c=relaxed/simple;
	bh=wjMxNYK3+DfJ6xAeWz0SVNgXUX13l/Ho/l5kO35JvWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8BPPkLSKU66J1g6C24b6otPXTGKfDmJpRi+Ze5BB5+ULfWqUYEhpj3dQX3ZdiH+z95qdLLp0WbwxvXjo2PxqXxlf4NPIMZwLvQtkawu2xZ2B9DgFDneAvtcPdFrZSl9u0/nBc4fhruToXziwxpvJlA4m9hEktGJroXALTILAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 96CFFC024A;
	Fri, 12 Dec 2025 01:13:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 0A5CD2002C;
	Fri, 12 Dec 2025 01:13:44 +0000 (UTC)
Date: Thu, 11 Dec 2025 20:13:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251211201340.618195b2@fedora>
In-Reply-To: <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
	<B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
	<febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0A5CD2002C
X-Stat-Signature: eid3cyp49wyrcyr4y3cfjzew16tjfdwu
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jjFVCDig2uscPTXP3BtbFVlSic7mS3Vk=
X-HE-Tag: 1765502024-551383
X-HE-Meta: U2FsdGVkX19/Er++Ul3pM2LrRGJOLDWVQPdekHbC1Vd8duTAWqdshjo/SMRnpk2Ig5nY5SoAlKHWfulcb0rkiYPnBHuCMCQ6mvZ8QqdAKhopKr94to394Fsar/k5jnWbGr7dWW/Y82eClRzAqXUE8Lp30LK7mAc98QfoArUEOHqq3p/rUcfBtIm9FKF2lb72a/QrpuBZ0FSHYo710nIBsHEuBW9/0t/7BWP+7x/CTW71HiWbyT9jVUD0o9iCO+XWGG8kNE9euqMe7uSRSZ8d3f4K7P+wYFInyvX5zfkITzoqbLLpnHCoPT0YppYTNjf2Tgf2d/3/tw6qflmZnAby/1e8XZjScmUqsVCGn90poIxwNYCYbEN5Qw==

On Thu, 11 Dec 2025 12:23:29 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Is there a reason to not make non-RT also benefit from SRCU fast and trace points for BPF? Can be a follow up patch though if needed.  
> 
> Because in some cases the non-RT benefit is suspected to be negative
> due to increasing the probability of preemption in awkward places.
> 
> > Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>  
> 
> Thank you, and I will let Steven collect this one.
> 

Sure. Note, I'll be working on this next week.

-- Steve

