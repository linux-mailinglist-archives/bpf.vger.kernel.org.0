Return-Path: <bpf+bounces-64224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6FB0FCEB
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F5C587A58
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7F272E7E;
	Wed, 23 Jul 2025 22:29:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7894C26E16C;
	Wed, 23 Jul 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309774; cv=none; b=K6NoSSzMHTK+b3aC5mv9XOubTikToF7dBWOqXiHIJUOgCPeaDSZcx0UDgFy4UU/sj/Gmy7ARq7vptVwn9U92O/GENmvWDsZh0cd/iGo41fWeZcw2TsBt8yoONL1vJTGqbQISg6neF3Dk8rsYDAsS0PJjKDooveP06hAp9o5ifmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309774; c=relaxed/simple;
	bh=mL3oh+shmka845RhxhfspMRTL0Xj2jYKatISC+iC+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYvUDYukVxIdjUcjsZOmrCKO6tns/ZRslxj5B47HycEek8m9E+mW0q4dYfOW0iLrrSqGBseVYMg3Iv+SEsr+PH4ke3cgKS6elaCE8dbsGpiLDansaFFCU57GoGRCMViAogmY7z0495KrjgshmmahoUiyH6XMzIWR0UtTu+ILB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0BDB214020E;
	Wed, 23 Jul 2025 22:29:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 21E0B2000D;
	Wed, 23 Jul 2025 22:29:29 +0000 (UTC)
Date: Wed, 23 Jul 2025 18:29:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/6] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20250723182930.2d0d59f1@gandalf.local.home>
In-Reply-To: <a09344a7-22dc-48d1-a202-67532507163b@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
	<20250723202800.2094614-4-paulmck@kernel.org>
	<020d22f0-a95b-4204-a611-eb3953c33f32@efficios.com>
	<a09344a7-22dc-48d1-a202-67532507163b@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nkxqrgq5fofc15441rhaa6fo5s6qpyth
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 21E0B2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ncpB1/OEDZezJEjJrrXr4ISpN5Xlm9Jk=
X-HE-Tag: 1753309769-689421
X-HE-Meta: U2FsdGVkX1+vzZjNxcfJPmMWiYC3qNt5ZuS/ZRVLzeXytsHvsJUfLojLKAezakaDpH8K+DhUNqr7k8oBkqH4vl1J2BopsEh2S147pAtVPu6+1FYPnMHGgLd04O/P4ceSMtfZestzU7qd+4eSmO8DqwnmUOjr35SBlAXl1eng+APJPnmH7C5wsdhn52gOtARhuBS6Kb9xKejcCXws7Nq32DCfb8qsuFiqhrHf9b2K0mkkhj4Y/dYP+5u5Gy3MUWfHSe03HdHWb2FFIZK9y1hqwtO9pEVdCGC1u82tU9CL9Ud7l3UScrc+TQizCnpwcxh6csfKShj8ZLZm0+j3stwqgnA/mNNNyhIB

On Wed, 23 Jul 2025 15:17:52 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> I believe that Steve provided me with the essentials for perf and ftrace,
> but please check:  f808f53d4e4f ("squash! tracing: Guard __DECLARE_TRACE()
> use of __DO_TRACE_CALL() with SRCU-fast").

Note, there's nothing in the ftrace side that requires preemption disabled,
but it assumes that it is, and adjusts the preempt_count that is recorded
in the trace event to accommodate it.

-- Steve

