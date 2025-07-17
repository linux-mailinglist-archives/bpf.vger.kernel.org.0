Return-Path: <bpf+bounces-63597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BBAB08C89
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5C5189EF13
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFD29DB9A;
	Thu, 17 Jul 2025 12:10:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36B288C12;
	Thu, 17 Jul 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754210; cv=none; b=oQcSRYxcdvET25VOC0XkLG8TuX/7/dC6wCwdtHDWg6+uNqA9wcoQxJd9WE42IWwytpy6pu7VnY/mndAYQQjIL6TVP2RcE1htTgqhRUSZ+wxBQxv0V8XI00f6ODU8orMNocD8QFOxHsafJhi1CCgC8Ty613L4/LGU0I5o+fZyZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754210; c=relaxed/simple;
	bh=GdAs1ricyLy0Okt6KsGTRmYij0L5F1Alpvdoem6s6jM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtEbtWPfc12CKv7QY5i5GnKmHDvfpq9HA3O27FrX2bW3A1hfzOt/yo9155Wn7oeEOsnqwA6bfyxHD56LEJMitxy3vxC0PmiU4nlFe7USZ1TbW3+d3dNd0RBkLhsfDp9r7RDboE7eqPLQbKKM1wT49bz7Rkob0+OLDD5ddNtxDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id AA8C51108DE;
	Thu, 17 Jul 2025 12:09:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id C7D651A;
	Thu, 17 Jul 2025 12:09:53 +0000 (UTC)
Date: Thu, 17 Jul 2025 08:10:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Steven Rostedt <rostedt@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [RFC PATCH v1 08/16] unwind_user: Enable archs that save RA/FP
 in other registers
Message-ID: <20250717081014.784251f8@gandalf.local.home>
In-Reply-To: <6285a2b1-eb9b-4315-b960-cfaa99513ac1@linux.ibm.com>
References: <20250710163522.3195293-1-jremus@linux.ibm.com>
	<20250710163522.3195293-9-jremus@linux.ibm.com>
	<oasyyga72yuiad7y2nzh7wcd7t7wmxnsbo2kuvsn5xsnuypewd@ukxxgdjbvegz>
	<6285a2b1-eb9b-4315-b960-cfaa99513ac1@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xwethkroayf7ooawrhb5mxrjozn8nxsu
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C7D651A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/TFUojl9QB09XhWUCqE83+0sXbYx/qjXk=
X-HE-Tag: 1752754193-959188
X-HE-Meta: U2FsdGVkX1+AhNLby23TP5j5vlNJ4oInMMm848iZWEgPDAGlfygNTlxQ07tBSg/n7Z590ysAPCaQYLBdh4qR3bKu7+5ls8gtn7aXGYYuVd1WqH72Bk0pGMs2ryifjP53p4rdwnKIcV/n76kqXw8Z77p5e0fqywXOzDogZN+ICn+WKcvm9MYEBSj4lQDToA0RIqjfLG+E7Uy90BqzPTlwU7GMDFOLH7/2LyomXad55kHb7kv/BZr2b8MKgtCh5kHBkqotWfJ90oiDL3KBRlBepdI8X5adri4JxT57oX+MAT95exCJLPlCWlMlhFI0MPXgd1HsZluDZRKXeHlOITMQiQltLo2jwVOry7SGZQ8KffUDgskI+L6mR973Q5H5wIh2g10OWQFihls=

On Thu, 17 Jul 2025 13:28:25 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> >> +	default:
> >> +		WARN_ON_ONCE(1);
> >> +		goto done;  
> > 
> > The default case will never happen, can we make it a BUG()?  
> 
> Whatever Steve and you agree on.  I am new to Kernel development.

Keep the WARN_ON(). Linus has yelled at people for using BUG() when a
WARN_ON() would do.

WARN_ON() is meant for things that should never happen. BUG() is reserved
for places in the kernel that is dangerous to continue.

It's even documented:

  https://docs.kernel.org/process/deprecated.html#bug-and-bug-on

-- Steve

