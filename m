Return-Path: <bpf+bounces-43966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC59BBFD6
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF220B229C4
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237C1FA27F;
	Mon,  4 Nov 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HYxM/F1j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A07LXhM+"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E601C57A5;
	Mon,  4 Nov 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754825; cv=none; b=q1DPpMXorLmuFv0xTI8UwXShfm5nu1aVQqc+b1niAsH/MKRZE9ROQaFBstetpUZ78ExSiX7AjqQW/LDHXMMevHrS+I7A8XTjdwCLhv+FsvOHZpgzIfjOA/nV05ab27sP60uVpKb/xnuY8xcAeNuYWB1k5RV+j9YiNpt48doMHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754825; c=relaxed/simple;
	bh=TdV1m7lsJV9n+gRB4GbAabE6d/d+dG0m6q0qhV7Vk8A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jEF2iBUtTqbTVYSArqhuKMM/nsJMKQJqPRUzPNWrJxVyqZgUVNs0C7kFkGUfH8hJOWNLuzzy6Lcl9NOP9/JmCd6cIRLEt5DJ6LgfbVMmsbtY9l7hdNX4V7MBC343xZZufs5aYuqXPcS879hQfq3p/j/pQXKCjpuyWzx/oYGN7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HYxM/F1j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A07LXhM+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1785425400BB;
	Mon,  4 Nov 2024 16:13:40 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 04 Nov 2024 16:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730754819;
	 x=1730841219; bh=V0h+HnwYM6G14tqfuEBcSfoAhMcxFQIDMQETosW9jT0=; b=
	HYxM/F1j4lMV3qcZLf2/ywYPB0bgQgPU6nQk/K+naRkovv97U83DYHb5KcZpVf0x
	ZhuynQAg2mHgQNN0HFSmADvFhF7W9d3aHDAY+PwKB96XTDbcfrRyBU5b3+YOqxF8
	lSs3ySfRLS5x4/W/BuRz3ksq2PI415eD9vq5HefepgZdoRPI7NKVqZlqj8whkqJ1
	3I4g4CTkC56DDZ51egRLXec1uHz0TMxxcMYZlCULGmJsX43AipvtOXBugK4W5eWO
	V9dYVQHJjlW64YoXXdjryU6Nn0fsAb0X86QsCIBylrRXYd8Jbr+2HBFc01Yu89Ly
	Jgxm0YMrYBejXJTS+Cdjag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730754819; x=
	1730841219; bh=V0h+HnwYM6G14tqfuEBcSfoAhMcxFQIDMQETosW9jT0=; b=A
	07LXhM+Iq1HCBnCunXqpgfNDV2r2wBsNjVcaZBED84teZ5OBI84eO40xTruVaIlb
	CTu83Z7rZQ2g8IgSY0iTyGsddlsmaSymS8tyx1YgdBNMiEIdjPhO/8NyuWBsAQ4R
	3BFY+ngJ4zsKrv96GIyRw/02pP+F6h35hwPpRiObV2FABJLxInkhSlBx2LpvWHul
	V+Pf7xzFnQ5C4DWgfCzFo3teifpTB3Dfy14StP7CJfAPLbaUBebJEEZic94jUVZZ
	kSnsXvCgjRtBS8YSngsbswoTuY+AYE4lBGLlDQb7KenMqJqKtDLPMDZFaSDjBtdi
	tlbU1kJwhvS+te9me5dNQ==
X-ME-Sender: <xms:AjkpZ7iLwMb7LS52CjGTazhHzh1hC8c78ofVs3xc41WaM4CjDfFK9g>
    <xme:AjkpZ4DpGENhrWdnaGR8Via9b10QYZcLhlzRZMc6gY3rzc6XU4y_y32T3mzMtaXJO
    gQ-LbupRVMkdcAaFvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeef
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhguse
    grrhhmrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhr
    tghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegrohhusegvvg
    gtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehirhhoghgvrhhssehgohhoghhlvgdrtghomhdprhgtph
    htthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrughr
    ihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AjkpZ7HDxCwy4I__a2KM4WoXIAT-uVa-FUNo5xAINlv6PIc3MDmN3g>
    <xmx:AjkpZ4TEpwHRFnIZ1r1FdqqUbIpgwi0-D_DPyXW0gWwGbaQgNqoybQ>
    <xmx:AjkpZ4wI8UxMGhZhBFFMXFGGRBq8PaJdE2Bz84HCW1PVRGBfp3N5_Q>
    <xmx:AjkpZ-4HRRofSWplUrAHFwaw7MrOvwaTcko0TgpGFlly-Euyx3Q6Ew>
    <xmx:AzkpZx8kPUEQuc9kjEr7jGh3aP1zGFEnrt0qIDe_xxeUuWuooZ8w3Cme>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 708CF2220071; Mon,  4 Nov 2024 16:13:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 22:13:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charlie Jenkins" <charlie@rivosinc.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 "Christian Brauner" <brauner@kernel.org>, guoren <guoren@kernel.org>,
 "John Garry" <john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>,
 "James Clark" <james.clark@linaro.org>, "Mike Leach" <mike.leach@linaro.org>,
 "Leo Yan" <leo.yan@linux.dev>, "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Message-Id: <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
Subject: Re: [PATCH RFT 00/16] perf tools: Use generic syscall scripts for all archs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 4, 2024, at 22:06, Charlie Jenkins wrote:
> Standardize the generation of syscall headers around syscall tables.
> Previously each architecture independently selected how syscall headers
> would be generated, or would not define a way and fallback onto
> libaudit. Convert all architectures to use a standard syscall header
> generation script and allow each architecture to override the syscall
> table to use if they do not use the generic table.
>
> As a result of these changes, no architecture will require libaudit, and
> so the fallback case of using libaudit is removed by this series.
>
> Testing:
>
> I have tested that the syscall mappings of id to name generation works
> as expected for every architecture, but I have only validated that perf
> trace compiles and runs as expected on riscv, arm64, and x86_64.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Thanks for doing this, I had plans to do this myself, but hadn't
completed that bit so far. I'm travelling at the moment, so I'm
not sure I have time to look at it in enough detail this week.

One problem I ran into doing this previously was the incompatible
format of the tables for x86 and s390, which have conflicting
interpretations of what the '-' character means. It's possible
that this is only really relevant for the in-kernel table,
not the version in tools.

     Arnd

