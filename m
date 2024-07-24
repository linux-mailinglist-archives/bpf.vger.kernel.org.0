Return-Path: <bpf+bounces-35480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09B93ADCE
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 10:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B8B1C20C73
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 08:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039861428E0;
	Wed, 24 Jul 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bJa69jjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMrnAldD"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3C140E34;
	Wed, 24 Jul 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808744; cv=none; b=UrAnZcxxfHmruWmOncGLuM8LwfDFUy/An+MHcoV2HgIrBe3aZdbnOK0VJX5VosY5X0pth7I/wRWuVqfsqNWqmC5TA7ewQVmK9ZJtQRzhBNHm6B+OiTT6olYmD3FBq33T/Yzho/AnJGuVxyF8Kzc4gAbOMJC/yI4DBsaS8P2vxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808744; c=relaxed/simple;
	bh=6Fm8JrNPs/1upSEArpW/YxNgJ9qWkhSemEGaBboVlIk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uTTLPoZAWNFcDmRE3xoPGvuAqSfVTx2sdD1I1RZlJnN4mm6EKnVQ3skYmM6pAkLC0zN/JcZaFl7qdtTdofxQsVkszjyUmFNcQGmRMQ2+aVe4k4Tx1S+UMHGIeNd60JgUlaUfF1MN5HdZ+SjgY8lZGRIEggLZ+6kP50+0MJwH0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bJa69jjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kMrnAldD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DEE91140184;
	Wed, 24 Jul 2024 04:12:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 04:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721808741; x=1721895141; bh=hiSXs5Mq3H
	fGMF//do5lCOX/xFKDwAwYvRZDtZ1qkMs=; b=bJa69jjR+wdarLBKXGD0cnKR2e
	ccfEHc+w1orquV6gjLcfTKdr+8n5asusIAVLm3HNPbCBX+h21OsbgUOol5GVscju
	TKw14aO1psCqQkSoUkv0uXAnB5RmIpS9g3Dcc789OxIvEp7aymVmuc+RNVh0rvg6
	SNGOXGA3jq680D9A6nP234/s0NrJoKzPH7fePmefCI+CxPE5eyao+TchJDCH4EPW
	oNJkQPqcL4lc3nLBrkLNwq/p8+ET2L9j27lbeeMGOD93B91tzB+OmP/l+mhWw8ap
	s1ZsT7aekW3YsJx+nNPMBxz8ji1YLEFiULanCrmKDAZnAvee3qLcvcj64XEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721808741; x=1721895141; bh=hiSXs5Mq3HfGMF//do5lCOX/xFKD
	wAwYvRZDtZ1qkMs=; b=kMrnAldD9dSYBlJpKCBlDtq5uOer//fnvjckkNQ23fPC
	XbJD5dfFHhztMfw/Qq9coQkuxzdBYGiXKU34wjZVQ0i/7cukByxfIjVcueT1V8tS
	aMIpI5SMZ8FXqCzy3qIP3X5IQojEhVN02HLFoacto5dEVyijCbFwydia0QCIv5GU
	sP0L8/WfHmqsas+arSJ952ayNoN8Cc9ZA5OOagTYWi6Uz8tCLtNOKMpQoEPeFh0n
	PZIpQD+94nWHu+M19brTiPW5wtBo6iklbDO+v1Rj7UONMVH5o70iJjManaGGKeGs
	ILcioyBt6hMOHFmsGk7vMldKt6RoYkHcSUC3leWffw==
X-ME-Sender: <xms:ZLegZhEVLW_aYa9kfZJa_aOW8mLsZBJG_lFlEllj3kjj0fWJMmCWew>
    <xme:ZLegZmVawUimaOrvOiLZmj593yaPGiEbCEJXowOIJrddQdxKDnZMwxMzi8h26nk3V
    nQFUBKIcUJheBt7SCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ZLegZjKTBpTXvrv8bHlHTV7K6V4l9POYhZBpTcBXGbGt90oAbu4NxQ>
    <xmx:ZLegZnEEB0JfmMvLsGUzZ2JbcSUjLfmwRrBVbZM-xi7gfzfxIK3msA>
    <xmx:ZLegZnUuar1voe0L33Eu7CG4yClpLJmJtZtDnqg6v0aNUhnrN0rhOw>
    <xmx:ZLegZiOCtdYLAOlTG0ZOUBPTNUI6B-fVh5BjGAZaT5ZuvWbSAuP34w>
    <xmx:ZbegZpb5ORlCvNLKjkgpb6Fm4LsvtZjiqzn3ImXQ_7-iwdzm_1zJAfrb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4E896B6008D; Wed, 24 Jul 2024 04:12:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <672a3c33-19b3-4451-a259-27b3931640b6@app.fastmail.com>
In-Reply-To: <20240724074629.GA11265@altlinux.org>
References: <20240712135228.1619332-1-jolsa@kernel.org>
 <20240712135228.1619332-2-jolsa@kernel.org>
 <20240724074629.GA11265@altlinux.org>
Date: Wed, 24 Jul 2024 10:11:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry V. Levin" <ldv@strace.io>, "Jiri Olsa" <jolsa@kernel.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Oleg Nesterov" <oleg@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 x86@kernel.org, bpf@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
 "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Deepak Gupta" <debug@rivosinc.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] uprobe: Change uretprobe syscall scope and number
Content-Type: text/plain

On Wed, Jul 24, 2024, at 09:46, Dmitry V. Levin wrote:
> On Fri, Jul 12, 2024 at 03:52:27PM +0200, Jiri Olsa wrote:
>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>> index 6452c2ec469a..dabf1982de6d 100644
>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>> @@ -384,7 +384,7 @@
>>  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
>>  461	common	lsm_list_modules	sys_lsm_list_modules
>>  462 	common  mseal			sys_mseal
>> -463	64	uretprobe		sys_uretprobe
>> +467	common	uretprobe		sys_uretprobe
>>  
>>  #
>>  # Due to a historical design error, certain syscalls are numbered differently
>
> Isn't include/uapi/asm-generic/unistd.h expected to be updated as well?
> As of mainline commit v6.10-12246-g786c8248dbd3, it still contains
>
> #define __NR_uretprobe 463

The file is currently unused and replaced with scripts/syscall.tbl,
my plan was to remove the old file in the 6.12 syscall cleanups.

The number in scripts/syscall.tbl is now 467, so its users (arc,
arm64, csky, hegagon, loongarch, nios2 openrisc and riscv) have
the same number as on x86.
However, the corresponding change did not make it into the
other syscall.tbl files (alpha, arm, m68k, microblaze, parisc,
powerpc, s390, sh, sparc and xtensa), which is rather
inconsistent.

I think we should definitely make all non-x86 architectures
behave the same way, either with or without an entry for
uretprobe. There are three ways do do this:

a) remove it from both include/uapi/asm/unistd.h and
   scripts/syscall.tbl, and change the x86-64 system call
   to a private number such as 335

b) remove it from both include/uapi/asm/unistd.h and
   scripts/syscall.tbl, but leave the number at 467

c) add the syscall to all other architectures for
   consistency, but continue to have it return -ENOSYS.

From Linus' earlier comments, I would guess that a) would
be the least bad of those. I'm also unsure about the status
of the xattrat patches, which were the reason for
changing uretprobe from 463 to 467. Those patches are still
not merged either, and disappeared from linux-next between
Friday and Monday.

      Arnd

