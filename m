Return-Path: <bpf+bounces-73953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBCBC4001B
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576E83BE9B2
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E9D2D0C82;
	Fri,  7 Nov 2025 12:58:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C460433BC;
	Fri,  7 Nov 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520332; cv=none; b=lpKDOR6OGZNJUXMMNK7hQXVEV7YuGjnf0KNdvQzfOgUb2xkgpHQX7vmu3llIn/9m0ScfykX7w3WJtQzXAxThE8OuPhKHY30a6l9ehH24Hr4mzIYBXd5AUS1kh9LJ1T5GWID9YgHkzyC8j5Lfw19IHanijmCFG3Mlp0eaTEFzSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520332; c=relaxed/simple;
	bh=UgzisQ/iy2XeFzZsuUXeMq1Bh7g2J4JyUxk+b85hknU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfaQYnUyE0aTnwDx/jRsE+HhmBauJLl3CviNm8dYkvKtV5PsryFqEi2bd09umHT7OtfR4GTtERjPYAuXkN1Jq9jcIC3wLj4pE73KhhWA4yt6tYb6jBpLWZEDUhXO39QRXu3JZDowlDsVNAtXtaNhtUGcD+7B4sqSurls/j9UvPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A1683140479;
	Fri,  7 Nov 2025 12:58:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 8E8C12000E;
	Fri,  7 Nov 2025 12:58:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 07:58:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251107075847.2f1c61c1@gandalf.local.home>
In-Reply-To: <827c94b5-f10f-4fa2-a7d5-6f1097808d27@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<20251105203216.2701005-10-paulmck@kernel.org>
	<20251106110230.08e877ff@batman.local.home>
	<522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
	<20251106121005.76087677@gandalf.local.home>
	<eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
	<20251106190314.5a43cc10@gandalf.local.home>
	<46365769-2b3a-4da1-a926-1b3e489d434a@paulmck-laptop>
	<20251106201644.3eef6a4a@batman.local.home>
	<827c94b5-f10f-4fa2-a7d5-6f1097808d27@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8E8C12000E
X-Stat-Signature: dt4uq6ofet1jwxmgmhnuoni6wssk54fy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NExT4vdAr5ERldn9JaCip+/hXTWEAAr0=
X-HE-Tag: 1762520326-178848
X-HE-Meta: U2FsdGVkX1+IGynjyWveeV69+uX2grWvG6VD/mhdGpUQtsrySnDpLp4XX2Np7A0m4BVFaA4qyxMtmV9m9rvCsiUVH5VJZc/6ARWMj7OjAkoBmp2sU5LKMEZO4AfroBEkoyvaaWXwWYOZnH0yj7Q52Uqad8/S9dLtHuqZMNfCiy3lMcd1K/7uNVs9s6atts3Jttc3GmqF9jzwPupNPo+sDeGkdtObDax/40vFBSWwugqY5OvuHCW6dnuVVFoVAz52D+s+PbnssqR7I9pjkak+I+xTCBj3uZmyFrQNXmO3PuN4JGLx4hYPEM+XsaUrm3nyJ2uDO02j7+fop74g4qmtvY9aAvZ6oWR0

On Thu, 6 Nov 2025 17:53:53 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Again, thank you, and I will start up some testing as well.  Please see
> below for an attempted commit log.
> 
> The SRCU commits that this depends on are slated for the upcoming
> merge window, so we can work out the best way to send this upstreeam.
> Whatever works.  ;-)

Sounds good. Thanks,

-- Steve

