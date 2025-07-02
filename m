Return-Path: <bpf+bounces-62146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15FAF5E41
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9B3A88D4
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 16:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DB2F85CE;
	Wed,  2 Jul 2025 16:15:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C11E32DB;
	Wed,  2 Jul 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472913; cv=none; b=VaCkN785wCbf31aS4ie7v5wsGihFVBxga5Ub5jZmnxceWHl6uEo8ZMQfUtMemYvpkABuJgasF6F3vC1YU+PcQrkP92xCDhgzTQ7lyVyqUgsyN5zMj42ELJsRf7ZqhihFQr+bhXvDqI6nM5f8DQY4A2I6bA9N3yZogrNgNaB13Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472913; c=relaxed/simple;
	bh=9QwY94Nv75Nm4h6LBd0G6Al6Dr6/ZyB/b2D87EfuVjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/fnCs7cuv4u+4jWGrUeFehtfwfH7+RyAyREf9JTOUJvh3s7wM7cIYm2ML8O5h57aBWMpXXoH8Qgv4mV3f5dof/gT1n/zyhbfCkesZjjmacxfzikIIysRHucLDQLREbX59lu7zwvVC+9EXwWJGIHuprz4Qflcff+ZQhZbwGvn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C1A7D58571;
	Wed,  2 Jul 2025 16:15:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 63C2532;
	Wed,  2 Jul 2025 16:15:03 +0000 (UTC)
Date: Wed, 2 Jul 2025 12:15:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sam James <sam@gentoo.org>
Cc: fweimer@redhat.com, akpm@linux-foundation.org, andrii@kernel.org,
 axboe@kernel.dk, beaub@linux.microsoft.com, bpf@vger.kernel.org,
 indu.bhagat@oracle.com, jemarch@gnu.org, jolsa@kernel.org,
 jpoimboe@kernel.org, jremus@linux.ibm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, mingo@kernel.org, namhyung@kernel.org,
 peterz@infradead.org, tglx@linutronix.de, torvalds@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
Message-ID: <20250702121502.6e9d6102@batman.local.home>
In-Reply-To: <87wm8qlsuk.fsf@gentoo.org>
References: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
	<87wm8qlsuk.fsf@gentoo.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gtmkfcqme8xtbdquwcbssapubo4m7iui
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 63C2532
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19AG6LzkwtqmHxp3WX42sKswWNayK2TlxY=
X-HE-Tag: 1751472903-636092
X-HE-Meta: U2FsdGVkX19rHZ7pkDz5ytjd8bzC0tbDj2Fxh/8QdylkXNTe6q3K9OrGoldkLBNdwZI82WxA8421au8VXXA7x931WjngEufJhhWrGddMi6rha3TJ8zSovi1eeYyO08LtgHzcpIl2BRMsdSzSiXwD4Yg7quUfFl9wIrvbEqPl8+sF1knxB99FfJX3ztyb5WgZqvWkMj3MIW5MuHEuhvf6qFNzg4aZ+Oeny3DYVeii7Yv4HYtM16sy1M5MIjUHHiZGMCfukDvmF2eiEg8h6BQ+bxH0RKc4y8ax/21PKJfgVoaKP9Yi7m5cKA+fyIb4JaHWpJQcSNU7V9M4rSmfyWNzsRoCu1KbJUOLxJ2no0Lviz55uH8x4ggBSLa+iXKc+36VvcgwF0m4HhixOPB7k3wncA==

On Wed, 02 Jul 2025 12:44:51 +0100
Sam James <sam@gentoo.org> wrote:

> In one of the commit messages in the perf series, Steven also gave
> `perf record -g -vv true` which was convenient for making sure it's
> correctly discovered deferred unwinding support.

Although I posted the patch, the command "perf record -g -vv true" was
Namhyung's idea. Just wanted to give credit where credit was due.

-- Steve

