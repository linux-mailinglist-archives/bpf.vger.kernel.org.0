Return-Path: <bpf+bounces-78339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8793D0B382
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3EE030C6123
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417ED272803;
	Fri,  9 Jan 2026 16:19:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B6320A0B;
	Fri,  9 Jan 2026 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975543; cv=none; b=HbL30S07tgP9LeQ3PT2aWyB/9iJuQV0PHiNAya/0BPJcffyYL2r0EdoR2QS7xnCeEOBFAdaF6jbXxF1zg9h1gD2DanLpVJ1wh6c4Kezo5f4RYbsou7+4bQ1N6DU4b94JWdiXS9TdNUf98XVOalfNrFL6/fVkr0q+N8FlrGwohAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975543; c=relaxed/simple;
	bh=la9dS307TupTSfSOorfB/EvD/poUOL0lBV8mBrqsIVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnN801deBMZBRPqg7k414uzT/NOyBe1VzF4Axcn1OkfCRHWstOvkDBchWjjJF1qSIPai6c5BgjxsKa+bVzb674EltIlcYgVNq6IhOqbujBh/rNPTX0wXOld/BonUiV3q9kX/Iwt70zMrX7m+OM0Fe0hE6OoBPpkq73OA8n+Wses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E3C22B858D;
	Fri,  9 Jan 2026 16:19:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4363717;
	Fri,  9 Jan 2026 16:18:58 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:19:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260109111929.2010949e@gandalf.local.home>
In-Reply-To: <aWEG685zlaV0o7M7@willie-the-truck>
References: <20260109093454.389295-1-jolsa@kernel.org>
	<aWEG685zlaV0o7M7@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g5kx9yn89q6xixp9gq3pya3dtjj3dsu6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 4363717
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19qsi8Pk5Vu+kdeg20pJJbgBKfhV4KVte8=
X-HE-Tag: 1767975538-271428
X-HE-Meta: U2FsdGVkX1+k08Bp3QsylDW1XUY030Ou3SOuOiBJuzqQrn9A94M/dpqz8X3nfwDKqnnVbEEliCPc3ELXIKAVy4dCjTds/KiSK0YAVaUyxBrQdyjWycqLMuDnawcIgbF5ETu5EXR4pVf10mB7SpXMONADy4nyxfBYihZI1sP1xcJXscf3rdJx4jiEyTCNUL5VrfBPhzbWl1RjOaSVWAXVmY0uwdLDC3mSjo/xkSR22uPeuFezKISdyb5ElbYL0lL5N79hZNCEdkjxdBE86ViDcMy8GIZ/pUFQ+1AMzCZP8Atv9c/qKrwpnv2Z/yOsnKm/qqmPNTnCwbrQD744cNBXW0hIpGolLxeV

On Fri, 9 Jan 2026 13:47:23 +0000
Will Deacon <will@kernel.org> wrote:

> I think the AI thingy is right about dropping the const qualifier here
> but overall I prefer this to the previous revisions. Thanks for sticking
> with it!

Yep, I missed that too :-p

I do think AI is better at reviewing than writing code ;-)

-- Steve

