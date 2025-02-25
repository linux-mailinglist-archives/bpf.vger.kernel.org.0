Return-Path: <bpf+bounces-52493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE2A437F9
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 09:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6461893686
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2225EF9C;
	Tue, 25 Feb 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qWtF1Owc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g8sSRzPq"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C691FC0E3;
	Tue, 25 Feb 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473179; cv=none; b=XhCKmjAmrgce+8Tg72QeWIAfJSnL93ELaeEvf3X5C1DzIqvpRNij0eb0qvDiJe/SbjNp1v7flBu5wwPyocQ/T0GHUeJSOf105YU1T1LNKHwVVh+gSxJPZ1lXUnpaSNxmPfstYD5kiK2CVSqjsI5tvsz3+k51kh4bFDv3Kt4UjeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473179; c=relaxed/simple;
	bh=aOml0Bz8Sgb0jQ51XEKSZOwqEewPrKJmjSJ4oe1CkdA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hu9wUaB3yed+yhh0VYMO14061CNqiNeQ3eZmujYwLfbmLYqUxEvycRQ85udwo3D2EqztzlLd2Uh9wZTotN0D/oYGHr4SYJ5/ujk4En0mod4SiQC64NFSZN/zcnpJtz8IOQgucrV9KpWgtk8RDFJTqeiHNZsQEJbe4EVfY9NNYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qWtF1Owc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g8sSRzPq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 161DC2540135;
	Tue, 25 Feb 2025 03:46:15 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 03:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740473174;
	 x=1740559574; bh=Gqp7mwTK3YSjBq7qHLLUEIE1pbJAxEZRfdzmirETXMQ=; b=
	qWtF1OwcrUhy36iN8BURe8nP0cFg0cmcOc+vnGmUH2pt6lcZGpNPG5PNgWqdtV5A
	4JiNgqgMQ2SA4myTu3CjD2Lbgiay3Iv/8GxZopX9dP2FOEYqLwt7dphddTK+/2aO
	IhFK/eBxu1q7sncbOudX6HA1+cKTQjtp1LwB75tgQlLa8TZOVg6MuRgtlwMQ8WDT
	Q2qLEfsrTJU0iibiOSFbEfQFlm3Cda4rZeKTzKyGi6hl/RG38nWCZKmkr7TMQk86
	hmO0Bb5w2ZZdXY4DP6aj9jgChinTO+TzI+8QxOTA1T+Kyj+xy5ejmL1gCkLnLw4U
	upz/YsnU/nqvopd8ioKP8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473174; x=
	1740559574; bh=Gqp7mwTK3YSjBq7qHLLUEIE1pbJAxEZRfdzmirETXMQ=; b=g
	8sSRzPqIkkcW3d2sMheE8RXiIv/hxa0fkAnUND/YHkYPIV1r+LIH9hzpTA2VLCZs
	E3c/LteZGrF7J2MYrblMxg/NnRFI9rQxdrT1sHtKfozEHrWoW5oppH0V0VNUhLrC
	jzwdjSRwfPUx+RPDAXFurpYPSQFXu3IYRanimyL6jos7OIiziugOCA+lebW/BaX7
	bS0SVvl2lvHjCGcVIejv7ZbczP0BI7b6HRWVFwgruklhSCJLecnwFIadutjk9DTs
	vyIoTUIfpW+Ejgg3Hzu/PElCZPWBKIP8XEnce6pE7XMmC4apV+S8/mqiAE6vOZS4
	A62M35zMy5CMFA1vnfncg==
X-ME-Sender: <xms:VYO9Z7ZjzSGQBkl_bdQAkvw7RJJKpmBsMHVKTFY2RIiqGv57dtOovQ>
    <xme:VYO9Z6YUx_PJ_13sTiAv8-8ZCAS_Xv9dHzddPFWcgmFqXFk-ydg9u4vTO9ypS1Sei
    tb_GoxcBIQCmoOzbQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedv
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinh
    grshesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopehmrghrthhinhdrkhgvlhhlhiestghrohifughsthhrihhkvg
    drtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhu
    phdrvghupdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitg
    hiohhsrdgtohhmpdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgvrdgvuhdprhgt
    phhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtohepiihhvg
    hnghihvghjihgrnhdusehhuhgrfigvihdrtghomhdprhgtphhtthhopehpvghtvghriies
    ihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:VYO9Z99GuZzh6mTJ2hh1DqhImZMJTUwR9ybvHkkLGvmfhkFBjtpcNw>
    <xmx:VYO9ZxrzBi1aI77BwZu-YSr_bsDL0SzuIuIq7uZ2I0sQ--QrrCJSYg>
    <xmx:VYO9Z2qimk4q1oG6TtJqdD8ayoJVMeQ_QFFum5C-vnfOJ1yQB2yU6Q>
    <xmx:VYO9Z3T_YIynT8x-I6JrB-PKgBsjBTzNNam7Kn-Nn_ZS2KLkTWU2Pw>
    <xmx:VoO9Z4YEQE10Manbd5j1XgNtt-qqvPhkwEGTYhWC2WCwzIcHyl7INc-u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED1BC2220072; Tue, 25 Feb 2025 03:46:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 09:45:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>,
 "Zheng Yejian" <zhengyejian1@huawei.com>,
 "Martin Kelly" <martin.kelly@crowdstrike.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Message-Id: <91523154-072b-437b-bbdc-0b70e9783fd0@app.fastmail.com>
In-Reply-To: <20250224211102.33e264fc@gandalf.local.home>
References: <20250218195918.255228630@goodmis.org>
 <20250218200022.538888594@goodmis.org>
 <893cd8f1-8585-4d25-bf0f-4197bf872465@app.fastmail.com>
 <20250224172147.1de3fda5@gandalf.local.home>
 <20250224211102.33e264fc@gandalf.local.home>
Subject: Re: [PATCH v5 2/6] scripts/sorttable: Have mcount rela sort use direct values
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 03:11, Steven Rostedt wrote:
> On Mon, 24 Feb 2025 17:21:47 -0500
>> 
>
> Nevermind, Masami told me all I need to do is add LLVM=1 and clang can
> handle the cross compiling.
>
> I looked, and sure enough clang on arm64 does it the same way x86 does. So
> using the rela items to sort is a gcc thing :-p
>
> Can you try this patch?

It fixes the build issue for me. I tried booting as well, but ran
into a BUG() when I enable ftrace. I assume this is an unrelated
issue, but you can find the output for reference in case this is
relevant.

     Arnd

----
[    0.000000] ftrace section at ffffc44698ef67c8 sorted properly
[    0.000000] Unable to handle kernel paging request at virtual address 0000444617800008
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000004
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x04: level 0 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] [0000444617800008] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc4-next-20250225-00565-g6c6895f38d76 #15305
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : ftrace_call_adjust+0x44/0xd0
[    0.000000] lr : ftrace_process_locs+0x220/0x5e0
[    0.000000] sp : ffffc44698fb3da0
[    0.000000] x29: ffffc44698fb3da0 x28: ffffc4469929f000 x27: ffffc4469929f000
[    0.000000] x26: 0000444617800000 x25: ffffc44698ef67d0 x24: ffff57b2c2008000
[    0.000000] x23: ffffc44698f59de0 x22: ffff57b2c2008000 x21: 0000000000000000
[    0.000000] x20: 0000000000001000 x19: 0000444617800000 x18: 0000000000000068
[    0.000000] x17: 0000000000000001 x16: 00000000ffffffff x15: ffffc44698fc5f80
[    0.000000] x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
[    0.000000] x11: 0000000000000000 x10: 0000000000000000 x9 : 00007fff80000000
[    0.000000] x8 : 000000000000201f x7 : 0000000000000000 x6 : 302e30202020205b
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000001
[    0.000000] x2 : 0000000000000004 x1 : 0000000000000040 x0 : 0000444617800000
[    0.000000] Call trace:
[    0.000000]  ftrace_call_adjust+0x44/0xd0 (P)
[    0.000000]  ftrace_process_locs+0x220/0x5e0
[    0.000000]  ftrace_init+0x98/0xe8
[    0.000000]  start_kernel+0x16c/0x3d0
[    0.000000]  __primary_switched+0x88/0x98
[    0.000000] Code: aa1f03e0 14000014 aa0003f3 528403e8 (b8408e74) 
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

