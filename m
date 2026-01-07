Return-Path: <bpf+bounces-78159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5295CFFEA7
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4884230FB4FD
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D8318ECF;
	Wed,  7 Jan 2026 19:44:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD503446DE;
	Wed,  7 Jan 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815062; cv=none; b=TnK7NCfzG206vghR8p3ehAkntjGezkbWVSLc9WiwtIbcRcg5LbR7yyrxs1Bwzcj2cvNQp4VYiyVUZIQN/kYBRyEwzICtmx8qsMn7oGFlt14rFlZM0NxVRh/fdEaF2jl4btr3WyizdaZp8PQkJjooAm6Tc+riWu0hWpjiX1bVS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815062; c=relaxed/simple;
	bh=BDWvavId5yMpmavgH+5HopBuuoPKcwZOJTX/4K6NxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTC2CENovOuqS/NQuWE9EL0ffp6hmPta+Qr5MzviWQaTK5BZ568MOmhRZLv30K83pcdHGwQIzxwGLHQRO5oPupAEdS1VEC3UqUxxB2PftBTa1Fxs7r5qKQe6ReQBBAvuTnM8C+z/QK8zinPrLg4X1RA6HySUK13+IvXNQ0hB434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 75D3F8BC0E;
	Wed,  7 Jan 2026 19:44:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 7B40480014;
	Wed,  7 Jan 2026 19:44:07 +0000 (UTC)
Date: Wed, 7 Jan 2026 14:44:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 georges.aureau@hpe.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kallsyms: Always initialize modbuildid on ftrace
 address
Message-ID: <20260107144434.233c1c15@gandalf.local.home>
In-Reply-To: <20251220181838.63242-2-mhi@mailbox.org>
References: <20251220181838.63242-1-mhi@mailbox.org>
	<20251220181838.63242-2-mhi@mailbox.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7B40480014
X-Stat-Signature: 1fzuq6dibqskupp1hcexpedbrfzekfmd
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19RdrMjBReEh0DGiEMvIHZvmu5ln5nIhyE=
X-HE-Tag: 1767815047-727664
X-HE-Meta: U2FsdGVkX18A3DoOlTzqb88a5+Y6hLUBJ/DBCmaRfaYIrm4fpHBY4XIzY5lecY0xf2GZ0Mwp8GEmdCAEWG92zRK9XElcvGX+MMMX19/slztkuSW7uPraPNdTmxRMSThH61rMbAYT5S63u1Nq7ixUpnkRZUd3n2CjdwCJHTVRzcyrNutzWi9k258AgzhwdyUH16nOVVIGB/dbLOQ6dZv5G2eMEzfhlEIOGLfwK4ZCO4HWjYzafIvJF5tePcQqgtLT1cPKwMBDe2xRFmeQ2SfSBpAiRKQtOIatNj1XKQdKUnxtS8CpPe1gxjxXLPHAv39WsgQUrPK7QeFUMn0PnBgeLrMXZqYpM2eNWuUEBrJqnQLiIbNZ1MiwrGQ6Eq/7vtvW

On Sat, 20 Dec 2025 19:18:37 +0100
Maurice Hieronymus <mhi@mailbox.org> wrote:

> modbuildid is never set when kallsyms_lookup_buildid is returning via
> successful ftrace_mod_address_lookup.
> 
> This leads to an uninitialized pointer dereference on x86 when
> CONFIG_STACKTRACE_BUILD_ID=y inside __sprint_symbol.
> 

Nothing should be getting a buildid from the ftrace kallsyms lookup.

This code is used to find the names of init functions of modules after
those init functions have been freed. Nothing but ftrace should be looking
for these addresses, and ftrace doesn't care about buildids.

-- Steve

