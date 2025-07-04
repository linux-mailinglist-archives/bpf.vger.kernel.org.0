Return-Path: <bpf+bounces-62357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6FBAF84E3
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 02:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23371C27795
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835963C465;
	Fri,  4 Jul 2025 00:36:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F073B19A;
	Fri,  4 Jul 2025 00:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589405; cv=none; b=R5f+VsxKciVVoq75/ORVJSCiKNQ7a7fCWq3KCMApt3ctDECWD7FCk6T3u2we0xeripcmafpu2BjJYfe2mi2l0uyQrv0mIqE0Ws7d0YzFp3u58txlbTS0gjtQfUxPjZ8SMgoYpOe/k2fu/2YsxTKmuLrajggvuRZjErxsnfVLpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589405; c=relaxed/simple;
	bh=PhACeU+IJvtaLptUIt3uwtCFvi3EQuqw8vEaWB4nQgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quz7kh16DRiPPBoq0G/5SCI5HaA1SjQdePi6qcUI97h7wuAqcDCgHM9OxSKD+Ahk+0wCa4q0K6KizpVYOcpnQmaixA6uQC3ju1DvAxg83Jq8jMSIpDtHfyevb24B/XdmDuOdJ4kPQTI5iU7algq0q/0FeLJjJpJ1vIcQPjIoswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id E82CA1D8CAA;
	Fri,  4 Jul 2025 00:36:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 0C4E630;
	Fri,  4 Jul 2025 00:36:29 +0000 (UTC)
Date: Thu, 3 Jul 2025 20:36:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] unwind_deferred: Implement sframe handling
Message-ID: <20250703203628.09291030@batman.local.home>
In-Reply-To: <7eea50a5-e1b0-4319-9a25-cb8b327a836d@linux.ibm.com>
References: <20250701184939.026626626@goodmis.org>
	<7eea50a5-e1b0-4319-9a25-cb8b327a836d@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C4E630
X-Rspamd-Server: rspamout02
X-Stat-Signature: m95h75hykg7614nsbpbz6riykcyxiz5m
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/LdmgPZ7NYINeP0/nCbMhlgGHVrf3SR/Q=
X-HE-Tag: 1751589389-636873
X-HE-Meta: U2FsdGVkX18andQ6UqQeO2LphyWVEA/lJt8H7gykBKlvnnbhBTegBZdjSkZZO28KlEi4PdGvkkYYlqygGuN/zNL5cQ+I4C2gf56uB9qrQpZSTcHFkn7zw1Q1DWfxMslNFFk4r5UnqzBEYsV4sGEz6C3kNCj9x473rekZ496MT5esYvaGFu/YTK6Cwk2E1Mhi1IwPgNlq80ikdCIamfJAw12aiKQ0wDMN5bGGIXNdC/C5AspFxR9rnIv0ZZ7PiK9/ELuITfS6Mwz5eZuoHcTAmR79tn+5erVT+x4CpRX2uQV/powB/2HsbxN2PZs8ilNyi9ilwn6CIT+nYfAuyFec4GDcqy+hEFUcJfS74yMEMZCptzHix9ctQIh+rOHNr7Ay1NsSPSS3n5v5rYrD3wEBRAxTRL4lQNO1vMuUDvCAx1o=

On Wed, 2 Jul 2025 14:57:22 +0200
Jens Remus <jremus@linux.ibm.com> wrote:

> Additionally it would make sense to include the patches from Josh that
> add SFrame information to the vDSO on x86 [3].
> 
> [1]: [PATCH v12 00/11] perf: Support the deferred unwinding infrastructure,
> https://lore.kernel.org/linux-trace-kernel/20250701180410.755491417@goodmis.org/
> 
> [2]: https://lore.kernel.org/linux-trace-kernel/51903e66-56bc-42a4-b80c-9c3223e2a48a@linux.ibm.com/
> 
> [3]: [PATCH v6 0/6] x86/vdso: VDSO updates and fixes for sframes,
> https://lore.kernel.org/all/20250425023750.669174660@goodmis.org/

I didn't add the VDSO yet, but I just pushed to the linux-trace.git
tree as:

   unwind/main

that has my latest perf and sframe code merged. It's my work in
progress and is not what I published yet as patches.

It's firework holiday here so I'm going to be mostly offline until Monday.

-- Steve

