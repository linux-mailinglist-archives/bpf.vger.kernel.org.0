Return-Path: <bpf+bounces-62953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AEAB00992
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 19:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DAA1C86679
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF532F0C4B;
	Thu, 10 Jul 2025 17:09:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4642A9D;
	Thu, 10 Jul 2025 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167351; cv=none; b=JB+fOlXWzCA8I51/3qES+lJT9tZPrElVns1Y9XI1a18TxJl4MHyBGs0pWFKt5ImLTav/AC1Hr07ebOJAdoae9F/LwFQCfK7HD8asA3kJTUCNgjP+8Vx+c/OOMHkXEMGpQWt4IgnMBQZO79e7HGoJLsAZqxoqc8imhLXba8B3O4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167351; c=relaxed/simple;
	bh=fnSrmvINOTQCBaTJNNf92+lWkybHVGjaYPdxfM+hCjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ0auJqoPDW7jv2k8sPVwI6qYNmeBxX3/enCi49tnZEkO12vVPtEHh8ada3BaKeRoWXK0uw20u4koUNJwNGCsBgg5g3o3bfxIBXdEzSg4wUmjlgtQfComTlLi2T9Ny0i0b5lWyXVADE4WVudD7koHZYkW4f/SWLqzB7rxuX+p9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 01A4B1A0374;
	Thu, 10 Jul 2025 17:09:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id C0FA92000F;
	Thu, 10 Jul 2025 17:09:00 +0000 (UTC)
Date: Thu, 10 Jul 2025 13:08:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v13 02/14] unwind_user: Add frame pointer support
Message-ID: <20250710130859.41f3d5d0@batman.local.home>
In-Reply-To: <155f22cb-b986-4d22-a853-6de49a1c2e03@linux.ibm.com>
References: <20250708012239.268642741@kernel.org>
	<20250708012357.982692711@kernel.org>
	<d3279556-9bb6-429d-a037-fe279c5e3c67@linux.ibm.com>
	<20250710112147.41585f6a@batman.local.home>
	<155f22cb-b986-4d22-a853-6de49a1c2e03@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: depqztwu8wiqfietk8fu8n7763s51ws5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C0FA92000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+01n35r8VXAY4UbJG9hSOyN+nC70zKvas=
X-HE-Tag: 1752167340-156481
X-HE-Meta: U2FsdGVkX1/tlcw3ZQtrsCXf5B3curUZeKn1VNU/to0VOeOauQxGd7Ve6hk7iq3DF8ewqmO7sODtFQ5ZuXg6O4v3iz/2FcMy2S94Q4hRg5Gtcn4ls6WHO6ovHxSi015cjB18I0oDgln5oKHSm4zpRu5Jiiusb6hlzrWJFcvnUna7+zW4uqbulKgPd9VBCbx0V/H/57o8NMWGQYCt7glbYmmvLSL6HNDO8jD5HmRFbP5LKDXYfN2y2LSVe9GPv60jJ7AZxAma5JlegirY/AVxAsHZCIJld95RxpTxpH9C2jG9opLBFqbRftwzaHzzQd2YI5VgRVOuh3c4a+ahCEkV8iTM+vQd6rEY

On Thu, 10 Jul 2025 17:41:36 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> cfa + frame->ra_off could be aligned by chance.  So could
> cfa + frame->fp_off be as well of course.
> 
> On s390 the CFA must be aligned (as the SP must be aligned) and the
> FP and RA offsets from CFA must be aligned, as pointer / 64-bit integers
> (such as 64-bit register values) must be aligned as well.
> 
> So the CFA (and/or offset), FP offset, and RA offset could be validated
> individually.  Not sure if that would be over engineering though.

I wonder if we should just validate that cfa is aligned? Would that work?

I would think that ra_off and fp_off should be aligned as well and if
cfa is aligned then it would still be aligned when adding those offsets.

-- Steve

