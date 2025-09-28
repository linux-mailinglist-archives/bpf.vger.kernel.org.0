Return-Path: <bpf+bounces-69922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64204BA70A1
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8383516981D
	for <lists+bpf@lfdr.de>; Sun, 28 Sep 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E242DE200;
	Sun, 28 Sep 2025 12:56:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBA2D59EF;
	Sun, 28 Sep 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759064204; cv=none; b=DS8ZUI6ss9EvQbGhV6/XXh40/V3yojMhQ5saJU0Uzdjz+DYXfG3TVrInIQWtK6TZHJgLQuJVYPHoMKPX+BRijTj7E//V2lxeyPtdbrpPx77y8iCci6FTbg/k3/penpfTLPtbPlUf98nCccZ0NfvM7OleSADtCriH5ah7hNerFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759064204; c=relaxed/simple;
	bh=0c4vT2BrsOWcwbLs5Ci3ZZqsXlLN6OvFpRzhoGl1rTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZKv2Fc0pHZPpDTACFRgh3W/EkNXvDv8OjECZuFCuWF+EEr4327LND6tzmgst2mqRUalIFMYGhZ3ErBOVnIoUblUPq7TMyNldkknKdeNKFEvK6WXvlkRWKaqcGVl/EP8XoJm2PDkf1l8Ed5mbmJXJ9UbyKC0XCe3QqzSv/NRejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9D4544423A;
	Sun, 28 Sep 2025 12:56:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id CDAAD2000D;
	Sun, 28 Sep 2025 12:56:29 +0000 (UTC)
Date: Sun, 28 Sep 2025 08:56:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong
 <menglong8.dong@gmail.com>, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, kees@kernel.org, samitolvanen@google.com,
 rppt@kernel.org, luto@kernel.org, ast@kernel.org, andrii@kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: fgraph: Protect return handler from
 recursion loop
Message-ID: <20250928085626.2683c2aa@batman.local.home>
In-Reply-To: <20250927085753.02b55a18@batman.local.home>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
	<175852292275.307379.9040117316112640553.stgit@devnote2>
	<20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
	<20250925032611.52475590@batman.local.home>
	<20250927085753.02b55a18@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s5p156t4tzm9ary8dx7qu83rouyuugeh
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CDAAD2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19+bHTiwi6D1KwGhrnQGdkbYnyr/OKF9sI=
X-HE-Tag: 1759064189-878244
X-HE-Meta: U2FsdGVkX19whh60oa8avdCZ07ZZM+JBvYdetEQn0L9/fYw7TGnylUO0nKRphDrg3e27Hg0Tkl49pof98XvhZ+ajK8qtUKRz0PNUQgJvMhR7mNH5Dnfxo8+1EcJrPbZDPkOifzJoEbw8WclzmDLi8JV2+E7wUJehi4D4+qjDQdMXcuLdoT9/3Jqsisp2onyC1d7Oolx9n0uH3YJowIkMFd1/IiW59f85xP2Gcu4fNtWafDwYWoco47/gar0h17g/8Hmcs2cF1bo96T5bA6VFm5zZvYWVBYRxMaCDhrxcsrPDOhDskpr0Gb/19orS/TaAmCJbZiiighdE3HMmNe/8vYbx+1pSP8H73k291oSwWkubat4+oNoI0BZJ2zLYay8BpAkZL1SMncDMXEIjVRomYQ==

On Sat, 27 Sep 2025 08:57:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami, you didn't include linux-trace-kernel mailing list, so it's not in patchwork.
> 
> Can you please resend?

Never mind, I sent it to Linus already.

-- Steve

