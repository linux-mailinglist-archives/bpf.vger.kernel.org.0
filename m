Return-Path: <bpf+bounces-46986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868C9F1EB0
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 14:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69A118895EC
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360E19258A;
	Sat, 14 Dec 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="qYz2n5NX"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44938DD6;
	Sat, 14 Dec 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734182509; cv=none; b=RPTHyumxgvjPRGnpjNc9ZvDDuDjxDWEMrubZA5AROtMMbWaxj4Y7ygx40E1b17UMOct1pH1j7R0DiTk4DemqcdHrtjaODUGOlWmwHsGhmunxMaJolIsSblyAyl7+k++3QWIln9gcLLWM6q03cJus52RQihsv6FHoaWIdvkqVWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734182509; c=relaxed/simple;
	bh=GNPAXeKREmmCRVRrZsx5msaIenpHBKcxRMH7y/BULfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAmfZveLPXlCT7+PJcUlSIdMbDBL10Wyg1OWr0W1wB/IQFxlrP/2pxSR8PGMN+7koyEdQ1GiK1qtQvr+x+BucTmb9iSVIyrY78yYVJANRR9nxhiDry8nX03hJqR390pvhAiOQEEedKWtja5EIiVlkWDwdrA8/mJRKnQO7aXBDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=qYz2n5NX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1734182504; bh=GNPAXeKREmmCRVRrZsx5msaIenpHBKcxRMH7y/BULfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYz2n5NXM7BqCHY6yLfscI6LDTgBX8fBVXSKNIw1/65vHHJDYMMlP4Gvmk9OK0t8D
	 aKZZ8DsjWWQzi1zn8xlduV2Zb9nuev7Q1Af6MXGrrHPnPmNTz1qw1lYkUzI4jc8q9R
	 Luv57ZfE9mo+M1usM/HlDCnjgIR50SdlZr97jp34=
Date: Sat, 14 Dec 2024 14:21:43 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, 
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/13] uprobes/x86: Add uprobe syscall to speed
 up uprobe
Message-ID: <ec6f4159-8428-4156-9413-d5aa6b39e5eb@t-8ch.de>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-7-jolsa@kernel.org>
 <66e85401-b2ec-442d-bebe-c4ff3151e7e2@t-8ch.de>
 <Z1xKAKnX3su21JZu@krava>
 <bd095061-f43b-4b99-bb94-40cdeac76f4c@t-8ch.de>
 <Z1ysj_PXy51WeAT2@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1ysj_PXy51WeAT2@krava>

On 2024-12-13 22:52:15+0100, Jiri Olsa wrote:
> On Fri, Dec 13, 2024 at 04:12:46PM +0100, Thomas Weißschuh wrote:
> 
> SNIP
> 
> > > > > +static int __init arch_uprobes_init(void)
> > > > > +{
> > > > > +	unsigned long size = uprobe_trampoline_end - uprobe_trampoline_entry;
> > > > > +	static struct page *pages[2];
> > > > > +	struct page *page;
> > > > > +
> > > > > +	page = alloc_page(GFP_HIGHUSER);
> > > > 
> > > > That page could be in static memory, removing the need for the explicit
> > > > allocation. It could also be __ro_after_init.
> > > > Then tramp_mapping itself can be const.
> > > 
> > > hum, how would that look like? I think that to get proper page object
> > > you have to call alloc_page or some other page alloc family function..
> > > what do I miss?
> > 
> > static u8 trampoline_page[PAGE_SIZE] __ro_after_init __aligned(PAGE_SIZE);
> > static struct page *tramp_mapping_pages[2] __ro_after_init;
> > 
> > static const struct vm_special_mapping tramp_mapping = {
> > 	.name   = "[uprobes-trampoline]",
> > 	.pages  = tramp_mapping_pages,
> > 	.mremap = tramp_mremap,
> > };
> > 
> > static int __init arch_uprobes_init(void)
> > {
> > 	...
> > 	trampoline_pages[0] = virt_to_page(trampoline_page);
> > 	...
> > }
> > 
> > Untested, but it's similar to the stuff the vDSO implementations are
> > doing which I am working with at the moment.
> 
> nice idea, better than allocating the page, will do that

Or even better yet, just allocate the whole page already in the inline
asm and avoid the copying, too:

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index b2420eeee23a..c5e6ca7f998a 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -462,7 +462,7 @@ SYSCALL_DEFINE0(uprobe)

 asm (
        ".pushsection .rodata\n"
-       ".global uprobe_trampoline_entry\n"
+       ".balign " __stringify(PAGE_SIZE) "\n"
        "uprobe_trampoline_entry:\n"
        "endbr64\n"
        "push %rcx\n"
@@ -474,13 +474,11 @@ asm (
        "pop %r11\n"
        "pop %rcx\n"
        "ret\n"
-       ".global uprobe_trampoline_end\n"
-       "uprobe_trampoline_end:\n"
+       ".balign " __stringify(PAGE_SIZE) "\n"
        ".popsection\n"
 );

-extern __visible u8 uprobe_trampoline_entry[];
-extern __visible u8 uprobe_trampoline_end[];
+extern u8 uprobe_trampoline_entry[];


If you want to keep the copying for some reason, the asm code should be
in the section ".init.rodata" as its not used afterwards.

(A bit bikesheddy, I admit)


Thomas

