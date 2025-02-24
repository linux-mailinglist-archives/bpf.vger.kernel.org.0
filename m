Return-Path: <bpf+bounces-52448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87320A42FF1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EE33A8105
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A283204C0E;
	Mon, 24 Feb 2025 22:21:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20C1FC0E0;
	Mon, 24 Feb 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435674; cv=none; b=sir88/98adb/sbY72/+zyPL8TOw4C8dJuhdrNRVrVenParAZQHv5IReutKRcsJ4jZvnFpOwuJL88LyM1B7pod7FZyziZEqxwRPQeglLlLJdXT63nkJ5TP680iwpiBdbqr7oEC33zvg5xjkWRj2l8A5QvtkwzZIWYQv7Hw08NiZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435674; c=relaxed/simple;
	bh=LrD5cFP6XRskhPKi5A3NNkORWlC7VdNKTXufpCXDwkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxI07xg2+EjC8qXDMSO1qwrhGThauLinK+v+VNIl0qvynvSM13Frk06b5Qq6Nbu4dKW5Vzf7nAiKLsqnzEeMBVj7ajIL3UETg2MaKgaD1apLyTt6HpxTkqXOv65wRTAd2zJc5GYpEZIfUZ43+FirGr5FLBQrk9ccnIPax8LaTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701C6C4CED6;
	Mon, 24 Feb 2025 22:21:11 +0000 (UTC)
Date: Mon, 24 Feb 2025 17:21:47 -0500
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
Message-ID: <20250224172147.1de3fda5@gandalf.local.home>
In-Reply-To: <893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com>
References: <20250218195918.255228630@goodmis.org>
	<20250218200022.538888594@goodmis.org>
	<893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 22:10:53 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> This is what I get on arm64 randconfig builds using clang after your
> patch:
> 
>   failed to sort mcount 'Expected 24260 mcount elements but found 0
>   ': vmlinux
>   Failed to sort kernel tables
> 
> I have not tried to understand what your patch does. See the attached
> defconfig for a reproducer.

Hmm, I haven't tried building this with clang.

Can you compile without that commit, run and give me the output from these
two programs:

 ./dump_elf_sym vmlinux __start_mcount_loc __stop_mcount_loc
 ./dump_elf_rela vmlinux .rela.dyn

If the second one fails, remove the '.rela.dyn' and see what that shows.

 https://rostedt.org/code/dump_elf_sym.c
 https://rostedt.org/code/dump_elf_rela.c


Thanks,

-- Steve

