Return-Path: <bpf+bounces-69902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F07BA5F68
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 14:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7D07B5BDB
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2D2E0B5D;
	Sat, 27 Sep 2025 12:58:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949C6F2F2;
	Sat, 27 Sep 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977887; cv=none; b=cXOgnwV3d8/04GE+2UsNEKf74yjzBFpHX1a0oiyugirqeUyMgJuUNXnTQutwbLafPNbeXT5an4YcPVn4kO2JaPwrjrwg4+xRpa1SgCldr1rDCdJjD5qIbE1bq+Nk2RTGide5quVgMz3RvEk5evJQIUq44qmYRPjZzZz/C/ZKKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977887; c=relaxed/simple;
	bh=CKWOV81jywlWe0XfUySS13N9FGLKesHsiIUEGcpW8Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTOKp3P3TS2IQzjSP6HNB5kuniLXkyKqzmrSNzaKR348Rq4Te6xpS8Gil5m6wroqhGKCSdiyphhRLXyW5fDr+FXWFbi9fF0GGJGjyuhdtLCVOLy95filQ5mRjSClQELaDwvIYfjyMIWXpoR1pqvXPQfHzl5SYFVhEIn0FOYOTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9D8CE1395EA;
	Sat, 27 Sep 2025 12:58:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 0DF622F;
	Sat, 27 Sep 2025 12:57:56 +0000 (UTC)
Date: Sat, 27 Sep 2025 08:57:53 -0400
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
Message-ID: <20250927085753.02b55a18@batman.local.home>
In-Reply-To: <20250925032611.52475590@batman.local.home>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
	<175852292275.307379.9040117316112640553.stgit@devnote2>
	<20250925003410.de2ef839f6ef3921ee08a955@kernel.org>
	<20250925032611.52475590@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kcrn8d5muzwk9hbwrqphp8opm3x5fosw
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0DF622F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1928uWd71bpAhcIaqMLb+W0oGcRDfxwgpA=
X-HE-Tag: 1758977876-12051
X-HE-Meta: U2FsdGVkX19KJtOUxOofJlMZGb7DYODN/Xj4LN5m2FVzT8v90BdRbvhGCasVrZVVmmxFHPORnbJml9UOQaiuZizjvblzXG0Y9jSygdQrfXvAeYyvFEiemTljyURmnyg2ca+OOt5354LJ/NQ0zZ6o5dpAmgHLnI3QVqog7/+3qg4sP1rChNHUu3ZeqHusLC3smnFOda96UIkDTxvgMAeF4rsLTUSQtXfiRdEu5NeiHKA+ggpkXPDJXvPa7F6xJryx2WekBUBOTTLelwrmQKJ/gt1krnM9N5uqeJNySb7umAWkNlyr1OVuoZ0m032dn4j2QHMV1RfftnbjaY568hhEkA/9Ss+ED3Mi

On Thu, 25 Sep 2025 03:26:11 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Thu, 25 Sep 2025 00:34:10 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Can you pick this ? Or I will do?  
> 
> I'll take it. I'm currently pulling in patches now anyway. Although,
> while I'm traveling, I'm a bit slow at it.
> 

Masami, you didn't include linux-trace-kernel mailing list, so it's not in patchwork.

Can you please resend?

-- Steve

