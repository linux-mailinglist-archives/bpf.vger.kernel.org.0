Return-Path: <bpf+bounces-76383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0009CB1C65
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 04:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0B9307A216
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4D27B34C;
	Wed, 10 Dec 2025 03:11:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DB27A10F;
	Wed, 10 Dec 2025 03:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765336292; cv=none; b=rvL+NU4N8ZYCZiHmEKaiLY6ixQe7sGi4xf0BTCo55VYvgc7NjqeClcYwtEwpYvHgVznmF3Y/DB9yIbbEUC7tP1zRqzc3leBOx3DaUff0gayAUTuAKicfaMzUdYB74DeG3N+2F2fs+Q1PP+l0Fd6T/3tXmzU88fmSw3b8rw8NHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765336292; c=relaxed/simple;
	bh=r2ApAo3meQTG/u4uOqK5Asp6nmuDeOJbVEZD/XvcM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4fOjB1jETFHPaPHWLl9dQFSXOT+ALSSmbA2m/jWH9hUhWKwcs+NPeIKQjuf4xbL5yuQtzg/za/7kJwo2L+K9vCNz8+LhkfR5IBybbSxZ8z7GcwAHS4dMnLidoiPkw6BVHKGR5t7VhXrg/AK9SEco1CVZutstyo9C2HqptFq1RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0D9081A0365;
	Wed, 10 Dec 2025 03:11:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5424B6000B;
	Wed, 10 Dec 2025 03:11:26 +0000 (UTC)
Date: Tue, 9 Dec 2025 22:11:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251209221121.2561c92c@fedora>
In-Reply-To: <7052507f-a435-4fbb-bdf4-4949224e29dc@paulmck-laptop>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
	<20251208044352.38360456@debian>
	<075fd9e5-2db8-4030-9364-0be5e22e9902@paulmck-laptop>
	<20251208193849.3a51648a@debian>
	<7052507f-a435-4fbb-bdf4-4949224e29dc@paulmck-laptop>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5424B6000B
X-Stat-Signature: ogeo1pm9najytcqjy9x48shanb3ry447
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kYgt4grCJ3wKHEg6O2hNhbGahG3LZRL4=
X-HE-Tag: 1765336286-572598
X-HE-Meta: U2FsdGVkX1++seQQ+cyPfmtn/dcAWS9Fq/qGN+GuYi0JUgBqnjLakRe++Trja3qJvl4OJHl+E14yKA267ozTwrMvCnegcyu4lhEQA05pwEgt0vPkmVDuc6OpBB2URU/sAHMs7AW8OOnknvDfAdx4SqL8eXi/y/K5w97MksisV1HDguqXfL7DZN5WUspdR+cZRsegnxWiEUiI2gkvfa995A7ywfUzpkCE67ddq259D3UblXGMQlQniHgMUS0u8+w9F9rmMzueCZDhvqdNgRXNqaC6NX7b/3xxvK/JzTjnCdo6l4hKV885AGox+h/xPEf5nkwboYQTC4Dr2wPwpEsubHrRZQA7a8uOXnR9TiMSuTzch/pn2olEbJBAi+/hov03DJYCsrYPgrE=

On Tue, 9 Dec 2025 14:29:00 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Would it be easiest for me to just hand the patch back to you?  I am of
> course happy to push it myself, but I am also happy to avoid being in
> the way.

Yeah, that may be the best.

Thanks,

-- Steve

