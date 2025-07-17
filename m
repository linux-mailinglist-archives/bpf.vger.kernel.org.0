Return-Path: <bpf+bounces-63667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5EB09548
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16EE17AFE36
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DD121C9EA;
	Thu, 17 Jul 2025 19:56:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD941F95C;
	Thu, 17 Jul 2025 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782209; cv=none; b=Xy0G1hX6q0jPq69iEZol/iU5uK7iWBuhZWdfmiQLgv8XwXx3wNXHa8CAZIxh66MxI3HJxBy5Ha0yZIgXsP/m8dcBXZA05D3Xf48Mw1Pj/sV5MOd9KKLF3D7y99vv7kPsCr+Kn7cg/e+z7v7HJsENWL5LxwYLcJTp3KXKMXLxqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782209; c=relaxed/simple;
	bh=I8eSrBKt326m+9P+PY4C4XiY4LCX892lLorjoTKNHq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELuk8tRXGvQCVEEbzdcaioScWNnOeOKkQAGq/VXBUtV11fSi+MBJGIUX1Rx2jpGFbBswE868y1weFBSEa6cGVp9jMN1FI4ggZph76Es7Zm/Yymx7xdSoTUfcrusFuX21NEpEzbGZLy3ogNqYGaVZeznilm3vqYSKS0xkz7C8nzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1C4BD1D8B2E;
	Thu, 17 Jul 2025 19:56:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 7636720025;
	Thu, 17 Jul 2025 19:56:41 +0000 (UTC)
Date: Thu, 17 Jul 2025 15:56:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH RFC 6/4] srcu: Add guards for SRCU-fast readers
Message-ID: <20250717155638.63c4f58d@batman.local.home>
In-Reply-To: <af022343-1719-4882-bf86-ec49e59f77c3@paulmck-laptop>
References: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
	<ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
	<512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
	<bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
	<16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
	<20250716110922.0dadc4ec@batman.local.home>
	<895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
	<bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
	<58866d6b-f4d9-4aaf-abce-10ddf526c3ad@paulmck-laptop>
	<20250717151934.282d8310@batman.local.home>
	<af022343-1719-4882-bf86-ec49e59f77c3@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cicr4697j8g1qtjxa9hwuygj9mi3hg99
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 7636720025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JduZW30vm/goGxt8d4wvYnbavzn2et1Y=
X-HE-Tag: 1752782201-661520
X-HE-Meta: U2FsdGVkX18fBDw8T8RnJurhGLzaWeEq/lPcgAdqC4oZ8R00PQCoJqebIBTvlGw/55ILxNuOeGvUkeXQmuO+rUp7gxVpZ+4dj/hDiqK6CJektI9tV9e2YQc6x7OgFqNmEtC9SzYRWwtkcx3B5UVcWMbU2uNcpmSgcnInvruH74QXVjlmcB9O+prPpMnqUlwv+UtrJvChfHm1TNr/s5EzlPeXQX0hgUAYQTTxHa/JxxojgNPszjQ8SqRmNiFsJNfS0oGzKSOH/AM4OA5Qqt4LG/B8da5JYkE0dyordnnG5SnJJzmBAZBdA8lIQVif+M5OgT+0YhG98n+c3UZ16O2PraymV7XHDd6w

On Thu, 17 Jul 2025 12:51:29 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Thank you!  I will apply this on my next rebase.
> 
> The normal process puts this into the v6.18 merge window, that it, the
> merge window after the upcoming one.  If you need it sooner, please let
> us know.

I'd suggest 6.17. I can understand the delay for updates to the RCU
logic for how subtle it can be, where more testing is required. But
adding a guard() helper is pretty trivial and useful to have. I
wouldn't delay it.

Thanks,

-- Steve

