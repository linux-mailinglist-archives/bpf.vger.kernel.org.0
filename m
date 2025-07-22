Return-Path: <bpf+bounces-64109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58547B0E544
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 23:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB5F7B60FA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD546285CB6;
	Tue, 22 Jul 2025 21:13:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E0284671;
	Tue, 22 Jul 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753218802; cv=none; b=Pisv7sID2ozkFo217pqzildEd+12sHqW+HDklvUlpQ45d3HzmkaorRu4ddal5RNDvjoyRyQ+BXtd/P8LOP42BRr4TKK5BC30yEWnDCYfB2wJpomGMFLKPheLj1fxh6cht+ybafXMk1FKB3R+MuzLr/kUMJLBtO3bi/e9mdK2kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753218802; c=relaxed/simple;
	bh=j785h7w4mpoDqX8m1YrIwP8dMN7G+uf2/6Ei1YpYPNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLwIucGdza8hZ8HA7AkiO2oI1x2tDGQYrcGm+tYOLTey/s5Wu1owhiRa2hUE2dnrfGbpDYHHG6ACDY264mJNSTTPqVrQ43H/i8gMTEBDnVaxIHkqbmOPhTZPNeD3VIL9OlGN9QK+P7/VSyjN2O0RxLcH0OwFWXNCbXp+IJ2k/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 08E4580487;
	Tue, 22 Jul 2025 21:13:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 3DE8620029;
	Tue, 22 Jul 2025 21:13:11 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:13:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>, Brian Robbins <brianrob@microsoft.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Subject: Re: [RFC] New codectl(2) system call for sframe registration
Message-ID: <20250722171310.0793614c@gandalf.local.home>
In-Reply-To: <ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
References: <2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com>
	<20250721145343.5d9b0f80@gandalf.local.home>
	<e7926bca-318b-40a0-a586-83516302e8c1@efficios.com>
	<20250721171559.53ea892f@gandalf.local.home>
	<1c00790c-66c4-4bce-bd5f-7c67a3a121be@efficios.com>
	<20250722122538.6ce25ca2@batman.local.home>
	<87jz40hx5c.fsf@gnu.org>
	<20250722151759.616bd551@batman.local.home>
	<ce687d36-8f71-4cca-8d4c-5deb0ec908ad@oracle.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kgh9zj14d8jrawena69uocdhxaprapjh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3DE8620029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Bh47E6ZcM2ixi3SZEmc51NMgpP9oTuT0=
X-HE-Tag: 1753218791-332446
X-HE-Meta: U2FsdGVkX18BIIR1Lb3u/0XPmSyeu4t0Eswl7kH4tISic5WdPOE4m1X/2drG/jbd4HtBvxyybXUetzvwB2pak8bmURdDwJ5ZOfcQO7IBJ6Su3npro0nyWQkeyJvx9qc4/MIYKeEh3zL3jkc5ATh+6rThma/iZUySZDjgunRz9y8DM9vE/i8S53ICRA89qA7f4cMr9I+quG+K/LBvHBzg3tCa1IxJJXXBdhToRoGCKBDIm64aG69pMhsOhrnAlWSR4DBp10EwavCC84gL9NsOKNrDpUtWN0zb/mTB7eD09Olp9FovuV992MkEb2CGqTTyZaWFSKiin9gMyjDjWFV7LupkMud1UBqJHaCRcCokZBKl75ZlN8/T/Q==

On Tue, 22 Jul 2025 14:04:37 -0700
Indu Bhagat <indu.bhagat@oracle.com> wrote:

> Yes and No.  The offset at which the text is loaded is _one_ part of the 
> information to "fill in the blanks".  The other part is what to do with 
> that information (text_vma) or how to relocate the SFrame section itself 
> a.k.a. the relocation entries.  To know the relocations, one will need 
> to get access to the respective relocation section, and hence access to 
> the ELF section headers.

You mean to find where in the sframe section itself that needs to be update?

OK, that makes sense. So sframes does need to still be in an ELF file for
its own relocations and such.

It will be interesting on how to do compression and on-demand page loading.

There would need to be a table as well that will denote where in the
decompressed pages that relocations need to be performed.

-- Steve

