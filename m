Return-Path: <bpf+bounces-63060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E943EB0216D
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7028C1CC3238
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678312EF2A6;
	Fri, 11 Jul 2025 16:11:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBE82EF28F;
	Fri, 11 Jul 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250310; cv=none; b=gyYgy9OOiG3uHS39bAOowFzi5J+iCYqJc9Iw4Si/Cp3E2Za4th+Xiu9rahvPHeFTcSC6ACKabcfLZ45IS9HuVomy7wjeF8f+WsoChdW7jpXz+gPfUqVC7xWqkIjHBjABWaf0/ZE3g3m4v4sAuvmveoohPJIg7aS+hyHivQJSRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250310; c=relaxed/simple;
	bh=HiyWvgjQ6Tw3t/L7Jjs6qn/jzZEYZ7vQ42nz5apuopU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cisF6S2kwaRCDEnaUdIa8hZnOVKa1r0QIjI+/5ntGourZLnAEIqxG5RDftCUpQZ7FmRDtwSg8AFjf/k9CABd62N65w32sdUQtrZiTsl64hQb1W0bBfck1oTD5Oo/m1/kfnggbaNX6VyNELMPyiZNcxi0OE0Pm/sRhl03/tp+fIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2339680B95;
	Fri, 11 Jul 2025 16:11:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 121EC20026;
	Fri, 11 Jul 2025 16:11:32 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:11:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Subject: Re: [PATCH v13 13/14] unwind_user/x86: Enable frame pointer
 unwinding on x86
Message-ID: <20250711121132.5c270cfa@batman.local.home>
In-Reply-To: <20250711094321.3c64757c@pumpkin>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.853818537@kernel.org>
	<20250711094321.3c64757c@pumpkin>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qte6h5trxd3jihtuk7dcq8a8fkt59xrd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 121EC20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19LrrO7/3ROS0s3nj8/FX9Fdpx8NaF9lw4=
X-HE-Tag: 1752250292-817812
X-HE-Meta: U2FsdGVkX1/0H3hjP9wfcZqo8vyVdb4L53LrCbGzExj4KDyuH8b7gd7vaGl1BvB4SeCbfzOzI4Wbt58bGq2RetlPLrWrmisZPVsRcgGvTs03Zent/H178cz9Ai7I3qeI62Dxe2zHe/4MhC/rKj6rGS8OdYdZSJQBg/X8yinSczds9RNb8JApEfWL2Wse/dZ5aaFX04aRQ1sSzl+NplmdoprUJXLpc8UPDSjd67eApnugahbbKYhldnptsjRuTOQFS6mn727yLuXp2C4fpfdCK7Q2TnWCiudswVsXWCkKOCdNEsWkh4Mm2aTc0FEpCpC7lFCsSi+0VAgitWpcdArLP3E75mGI5bSjtcpdBQ8CI+7xsWRgd75sKhwz6eeuxOV+U89Tga8dhb9P+4oPS7esbZRo8mRNnkjN/b/QHHrk0Ag=

On Fri, 11 Jul 2025 09:43:21 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 07 Jul 2025 21:22:52 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Use ARCH_INIT_USER_FP_FRAME to describe how frame pointers are unwound
> > on x86, and enable CONFIG_HAVE_UNWIND_USER_FP accordingly so the
> > unwind_user interfaces can be used.  
> 
> How is that going to work?
> Pretty much all x86 userspace is compiled with bp as a general
> purpose register not a frame pointer.

Which is where this patch set comes in...

  https://lore.kernel.org/linux-trace-kernel/20250701184939.026626626@goodmis.org

-- Steve

