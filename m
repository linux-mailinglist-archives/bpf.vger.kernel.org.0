Return-Path: <bpf+bounces-62184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC2AF6275
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61363A6014
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1128ECE0;
	Wed,  2 Jul 2025 19:11:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1787218E9F;
	Wed,  2 Jul 2025 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751483484; cv=none; b=RW6QiwFvkKoi55W5GmV44MrPuaAZqMY2GaG1jAXwyScm6j9GzsRPsobQfDAUUdhIreHVz7sY6Z39ClANEZZ7aunDsCN2pOzP56qmmSUv3dEe/YL7m6qkneLHAHenvbx6RBl2VoHC8zBBbVEmPGEU8bQDBlG9AmMCRa5XmAMhags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751483484; c=relaxed/simple;
	bh=YoNaNwUFLT82kv2ptCXYqY4Mgn+cmOc73jVNLs/BO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8F16hsLfXbtmahwKZlmQhxWztO10M/bUG6VcKntRvNWiUNQdqXRPLLs7RwpwQwfwZ4RJPiGKWk4NCts4v6QZHNP/UMGVBs5Knn+pdmfJ3x7eKKvU0td9chyGQdsVnDX4SxJgftHsG2+YlXfjqek2ES3Psl+a7S44X+csCA5lUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3D44658BFA;
	Wed,  2 Jul 2025 19:11:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 8ECCD2F;
	Wed,  2 Jul 2025 19:11:14 +0000 (UTC)
Date: Wed, 2 Jul 2025 15:11:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v12 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250702151113.25961ecf@batman.local.home>
In-Reply-To: <d0aa861d-e1bb-4ab4-8ccb-d9fdc39738a9@linux.ibm.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.737614486@goodmis.org>
	<d0aa861d-e1bb-4ab4-8ccb-d9fdc39738a9@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zbnbhxynbb1bau79zhap459gestpmx4h
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8ECCD2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jaa49HHu5DgsoSVQxEPOEMrWu+n1e/U4=
X-HE-Tag: 1751483474-642477
X-HE-Meta: U2FsdGVkX1+ucqbNdoZQfHmhufbeMK4NTnU6b2a54e1o8jaomukbo8MpsMCicGq5oAvTYcMYb49gYrWeq56kmvojHGy+F5LNJv3/WwM1tdhvyMrhS1B57onjxFKDPddJ7ElFnZ4WVEO+BWadQWThAtzcfWGwdQG3kBv3+krIfNgZrPzy1FzsLnKL50W6t0P4h425vU0TcUeW7zwurqCg6Sk61/q0v+qhZLrRnq27/DO4+Zrw4vvHkuyCdCveqW/odo3Anbtkdia4TD9qKzPDglPkaGFDbG0yO1ptowCJvu1E6URo6KuvAKl1+a2y7CKFG8i8VVJj7YaF/a8kSpLYkkxO/pPiHroO

On Wed, 2 Jul 2025 17:53:05 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> > @@ -2,6 +2,9 @@
> >  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  
> > +#include <asm/local64.h>
> > +#include <asm/local.h>  
> 
> This creates the following circular dependency, that breaks the build on
> s390 as follows, whenever local64.h is included first, so that local64_t
> is not yet defined when unwind_deferred_types.h gets included down the
> line:

As per the discussion on patch 6, this may not be an issue in the next
version. I'm looking to get rid of 64 bit cmpxchg.

-- Steve

