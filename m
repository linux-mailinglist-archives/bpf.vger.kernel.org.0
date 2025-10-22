Return-Path: <bpf+bounces-71849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 351D2BFE310
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24FBC4F7B38
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E202FC875;
	Wed, 22 Oct 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UpJbNPMN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2043F2FBDFB;
	Wed, 22 Oct 2025 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165575; cv=none; b=JJAukJd+fZYYmOZFhIETK5pJEycFgpqKU32bJCHSHzMLsOs6KTr1gUMEN+0t84EEtEK4HpJtarZibbgZyTgErKfoT8nG3hLNe+/cKfsCDZ1bMtDbO2rj+Ya1KJoBcBX0tML6RHD18dUdl/bVafqJrnv/GHB6j8IBxTajPxX029o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165575; c=relaxed/simple;
	bh=Mv96Ed+x0MGsCybuHkpz+hgXUvhyD19vRt09uvNP3kE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8nfi155Pyw7aEz3FjXV+i5LMptpnUlkxSv0w2dhd1lfLy4NdbrtOUBLBiIMEzZgPGtq8l18VM+8H7Nl9zwLCiquBc5trRpOQQKQAg3bS7bxUanZ+tBR772nRqcZJ+HJl+FdvSmEF1Mp1L/tTlsdoLv7caXmkbe479dpH28plVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UpJbNPMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877CEC4CEE7;
	Wed, 22 Oct 2025 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761165574;
	bh=Mv96Ed+x0MGsCybuHkpz+hgXUvhyD19vRt09uvNP3kE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UpJbNPMNCZxnQgBXufWkrUDNWXaRkU2uoX4SsZyzBaIruBWzGMHftF6ISsvsJSlaY
	 tQOMu7i3QJDXR0tYconjL8RMNZP/aXpj4p6xIKob1pGpGM/OU8o21ClRsHQAfx4pJo
	 6Ai80zzqEZ3McBKxRvniDh2jBFGV7SHpN1Xfd7a8=
Date: Wed, 22 Oct 2025 13:39:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org, Steven Rostedt
 <rostedt@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, Kees
 Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James
 <sam@gentoo.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v11 00/15] unwind_deferred: Implement sframe handling
Message-Id: <20251022133932.5e8b419d3525da07453b137d@linux-foundation.org>
In-Reply-To: <20251022144326.4082059-1-jremus@linux.ibm.com>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 16:43:11 +0200 Jens Remus <jremus@linux.ibm.com> wrote:

> This is the implementation of parsing the SFrame section in an ELF file.

Presently x86_64-only, it seems.  Can we expect to see this implemented
for other architectures?

Would a selftest for this be appropriate?  To give testers some way of
exercising the code and make to life better for people who are enabling
this on other architectures.

In what tree do you anticipate this project being carried?



