Return-Path: <bpf+bounces-71439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CCEBF2F94
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 20:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF64402692
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E92C0F92;
	Mon, 20 Oct 2025 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="No0igAcx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2qASaiP"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4C23C4E9
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985627; cv=none; b=pCtUy81M0uNhgfsze946YuJy+ZfSA7VI3UuEOLOgXk1rBXn/uEa6hh5fAuEAttlWc94RV1gDM+qbaa/LBlHfvwbjzOCiWKQc+iUKluKZm/0pROux3tgOBOQS6IJwRbxv5VyLtg+inra4UuA/rrgKyxNiJd2EK2JtaKZYy/uf3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985627; c=relaxed/simple;
	bh=N1Cu08wz6UZ/pNnLNRqKm2Z7rsyk5uvcXPhaAtVL7dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjVzTxrg8gz4iqslCvjDdHjuMdzsNKp9SyGgeN76vhVfIIG517BDUALI/2sq39D39NkGlxqNxIClRN8NMd8MIUBazUXW8LJugqXrxNAVJ7ts8UF0Q7xguF4VR7eZlSdiXdm9tf1qj/U2R2vydgHuN6UibJonQ9WIER3abu+K1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=No0igAcx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2qASaiP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BF9BEC0202;
	Mon, 20 Oct 2025 14:40:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Oct 2025 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760985624;
	 x=1761072024; bh=gmDnJBTdI/eaQ8Pg+tffMDzvjD6PfyoJag7ujZ937N4=; b=
	No0igAcxXMRhiQ7G6vjJRk6H5D9XZInQCuTjpF/I1DfaKS/QwSFshzDeD0tXTHrI
	vWgjhyIPQTU2L0YRMiP8O3mD/onqIEr0flFJtO8Z2PbmFZcr4yBG+h9TDiLYNl0F
	j4scZyAYaYMUjyxJh9+d0pvWQTYmKr9mSZXFK72aCzqC22m5yiSZQfVwyGIre2E0
	weNqxQlEf+S/6z7w+7ZodRFex8jydolfF6kRj/q7cfG+XdazIxVCdQnWp/naAMhv
	gSWZwymm4E92AHpimU+BcjQ+bcxmS3LvAQz73PqHS+EQ9sAHzX8rg3GYiUIPwoZv
	g8sivKbdtgnrgYiuDP0HoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760985624; x=
	1761072024; bh=gmDnJBTdI/eaQ8Pg+tffMDzvjD6PfyoJag7ujZ937N4=; b=O
	2qASaiPxGlQMAAcXy6FZsrguWClpmKPB8QdRpFRuMmMUJNmIfgwNptzKRszUiq6V
	PUj8Q4kKeo+1Yzj7NvkW/DVA3aPwsJNIZB4Y3CZ49dqMW+vkG1PyNySoCg7Itya/
	u9kzuS0EmN2vBQEpzIIhtbg64oCAVBJ7uc1zy/+CMD3loMf8ZGVbe4ZDxwvC7WE+
	sYeBwW9TfApatpZK+PsSa9R++WXaebtfyg0psQCb8wV932Q0uomTu4mfk7hQiqTg
	EjmmzQzQKJ88HVen+oEELXxml2jeKTt9ohep1ifj/6hsE/qyX8c9yNabmSJZsL54
	ydPzUKYldympOwAb1bcmw==
X-ME-Sender: <xms:F4L2aC9H-VmGKDZd7xvbj6QGYpbkLiPTdaKDYhzfllYILRn-tsy-8A>
    <xme:F4L2aMumVBulAxvaHajOPSo48EZlElBZRbVkC-jmAryZageIvFbJTwfT74f39LtD-
    SSin12jPbua3oe6ZcdHpDk8St-8vv2fQMzIXFe5MhoK_thyaceZ2Y2o>
X-ME-Received: <xmr:F4L2aOr0R6ZvdzQUI22dX-rOjUXt3X-3oGjEc96JigEDqZd24bQnRwjewL6H00f6ugaD3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepfe
    fhhfeltdfggfelhedvtedvvdeikeehfeffvdejueeugfegheelgfeuheejtddtnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhg
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsoh
    hngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtphhtthhopehl
    uhgthhhosehiohhnkhhovhdrnhgvthdprhgtphhtthhopehlihhnuhigpghoshhssegtrh
    huuggvsgihthgvrdgtohhmpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdp
    rhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F4L2aIqBHQc_u8dYizipBwRW0aNqZIv_ftSf8W8u0xzFxFSpuGiIRw>
    <xmx:F4L2aFZ07SOLT9SAZ3n2PFHtNJA_qPiEZfddexGDO_-S0b4OF8X1Ug>
    <xmx:F4L2aO-sm6gTLWMvU8a5uERvMH6DB2G7y5MBoP4bo2kO5VAy44FYfw>
    <xmx:F4L2aLkwGd2kplVVa5NtCmNT1aAo24ctjkSm2m_NmgnhkZZTwGEWJg>
    <xmx:GIL2aEAQ0-xTxh4AZ3vTFoSnTDFzwBxEMeYzZkv2c-NQ_DixBADzvmxu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 14:40:22 -0400 (EDT)
Message-ID: <e0c7cd4e-4183-40a8-b90d-12e9e29e9890@maowtm.org>
Date: Mon, 20 Oct 2025 19:40:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 9P change breaks bpftrace running in qemu+9p?
To: Song Liu <song@kernel.org>, v9fs@lists.linux.dev
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 bpf <bpf@vger.kernel.org>
References: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Song,

On 10/20/25 18:40, Song Liu wrote:
> Hi,
> 
> I noticed a new error in the upstream kernel when I run bpftrace with
> vmtest [2]:
> 
> $ vmtest -k arch/x86/boot/bzImage "bpftrace.real -e
> 'fexit:cmdline_proc_show {exit();}'"
> => bzImage
> ===> Booting
> ===> Setting up VM
> ===> Running command
> [    5.610741] id (178) used greatest stack depth: 11592 bytes left
> Parse error: Input/output error
> Command failed with exit code: 2
> [root@(none) /]#
> 
> git bisect points to patch 1/3 of this set [1].
> 
> Any idea what is happening here?

I have attempted to reproduce this but couldn't yet:

	> git log --format=short -1
	commit 211ddde0823f1442e4ad052a2f30f050145ccada (HEAD, tag: v6.18-rc2, origin/master, origin/HEAD)
	Author: Linus Torvalds <torvalds@linux-foundation.org>
	
	    Linux 6.18-rc2
	(0.067s) linux-devbox-2 (mao; ; ?) ~/9pfs
	> vmtest -k arch/x86/boot/bzImage "bpftrace -e 'fexit:cmdline_proc_show {exit();}'"
	=> bzImage
	===> Booting
	===> Setting up VM
	===> Running command
	Attached 1 probe
	^C⏎
	 (130) (14.421s) linux-devbox-2 (mao; ; ?) ~/9pfs
	> vmtest -k arch/x86/boot/bzImage "(sleep 2; cat /proc/cmdline) & bpftrace -e 'fexit:cmdline_proc_show {exit();}'"
	=> bzImage
	===> Booting
	===> Setting up VM
	===> Running command
	Attached 1 probe
	rootfstype=9p rootflags=trans=virtio,cache=mmap,msize=1048576 rw earlyprintk=serial,0,115200 printk.devkmsg=on console=0,115200 loglevel=7 ra...
	
	(5.29s) linux-devbox-2 (mao; ; ?) ~/9pfs
	> qemu-system-x86_64 -version
	QEMU emulator version 10.1.1
	Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
	(0.011s) linux-devbox-2 (mao; ; ?) ~/9pfs
	> bpftrace --version
	bpftrace v0.24.1

I'm happy to take a further look - is there anything special about your
setup, what version of QEMU / bpftrace are you running?

> 
> Thanks,
> Song
> 
> [1] https://lore.kernel.org/v9fs/cover.1743956147.git.m@maowtm.org/
> [2] https://github.com/danobi/vmtest


