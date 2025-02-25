Return-Path: <bpf+bounces-52481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76F1A432D8
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9AD170861
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666012C544;
	Tue, 25 Feb 2025 02:10:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888AF2C9D;
	Tue, 25 Feb 2025 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449429; cv=none; b=sY91/Gl+zVNfTi8jpnKzVov8LFHc8Oy7wivfUhb/XK94YWt4wNrqq3ZEwlIptczbk4o6D92n1ol5FaVlrDsl31wb3yiSTqTdC/fdS0aJIE89QmXAmquFoDy0X2r9/6RP0Y+jAuJ7ueTopD4UmcaZx6TDHicXCH3pO+zgKn1rsyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449429; c=relaxed/simple;
	bh=aaHGUOs30tNuy84PGnD8R0PY9RDSWCOwwuFCRkSChe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVC6HrD8DtavyxruxygWpk5/Xi+GSvj+q/sm2Rz724LS/aYb5IvnzWvSz5UOgMOO/ly5cDLnctnW+TLwR4DhlzbUPsawWmFsSHgHvbbT7+Jp50KHUeYPjdGXMvCJ7mRqVWG8RFgnpZHUB0G4DSCrlq3Vy4WTXFqbc/GDtc8pQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A4C4CED6;
	Tue, 25 Feb 2025 02:10:26 +0000 (UTC)
Date: Mon, 24 Feb 2025 21:11:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>, "Masahiro Yamada"
 <masahiroy@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nicolas@fjasle.eu>, "Zheng Yejian" <zhengyejian1@huawei.com>,
 "Martin Kelly" <martin.kelly@crowdstrike.com>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Vasily Gorbik"
 <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] scripts/sorttable: Have mcount rela sort use
 direct values
Message-ID: <20250224211102.33e264fc@gandalf.local.home>
In-Reply-To: <20250224172147.1de3fda5@gandalf.local.home>
References: <20250218195918.255228630@goodmis.org>
	<20250218200022.538888594@goodmis.org>
	<893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com>
	<20250224172147.1de3fda5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 17:21:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, I haven't tried building this with clang.
> 
> Can you compile without that commit, run and give me the output from these
> two programs:
> 
>  ./dump_elf_sym vmlinux __start_mcount_loc __stop_mcount_loc
>  ./dump_elf_rela vmlinux .rela.dyn
> 
> If the second one fails, remove the '.rela.dyn' and see what that shows.
> 
>  https://rostedt.org/code/dump_elf_sym.c
>  https://rostedt.org/code/dump_elf_rela.c
> 

Nevermind, Masami told me all I need to do is add LLVM=1 and clang can
handle the cross compiling.

I looked, and sure enough clang on arm64 does it the same way x86 does. So
using the rela items to sort is a gcc thing :-p

Can you try this patch?

-- Steve


diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 23c7e0e6c024..07ad8116bc8d 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -827,9 +827,14 @@ static void *sort_mcount_loc(void *arg)
 		pthread_exit(m_err);
 	}
 
-	if (sort_reloc)
+	if (sort_reloc) {
 		count = fill_relocs(vals, size, ehdr, emloc->start_mcount_loc);
-	else
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start_loc);
+			sort_reloc = 0;
+		}
+	} else
 		count = fill_addrs(vals, size, start_loc);
 
 	if (count < 0) {

