Return-Path: <bpf+bounces-3001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B9737FB1
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3A51C20E3B
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479CFC0E;
	Wed, 21 Jun 2023 10:47:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E3BBE61
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 10:47:01 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66311FEA
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:46:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A0E965C0143;
	Wed, 21 Jun 2023 06:46:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 21 Jun 2023 06:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1687344412; x=1687430812; bh=8O
	uUchPXbLk/EsSQK0T9sZGppaeBE3iJdEj6rWSBQ54=; b=ktkYkP4gCMBEobxPs0
	TnfowNxrhXlNu8AvkQbxg0stfhAXMNRDsxFYgVMXSF0aBzAsCbhqNq65NWZVGq9n
	QPVzzMYbk+m3RrMwyw9/sogxjTT55BVe/sCU32n1sOSuZENc5fGWRl1fVEMY5HHC
	jQLBwWJDWYwMEeTpGxUlnU0fhxZ5t1E/7okM3WJk8PtC3Lf858AaqbEVRKunJz7V
	/0BbTlJpNb5e6GxrjucD68SvCmcWgZl2aJCxljI/riQcP94yfRs36S9Xlbwoe9OK
	10Cm6ksHOHhsT9obLBj5CLTbNyESiIZsOfW+VAeD2VQYNCfCNRZ72X3KvuEk4oJK
	d8tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687344412; x=1687430812; bh=8OuUchPXbLk/E
	sSQK0T9sZGppaeBE3iJdEj6rWSBQ54=; b=dmji/UXRy75SdLBwF+VMixNpkUmGo
	4kPFpkHANxNDAYiYM1fRBqgAMJFzpkx2QEroaWC/Sz9adFvQsm6ODPx8vL7RfcNy
	QG9N1o8UzAOsZKd6WnwE0GMzbYU93BNkvDqqyQWV427ZKMUmX0HuERMqdEq1thSG
	qQElkYLH/lG1n/g6KLw/R5ZY2E3VmYXYwVuQJxBp+DRIKNxrT1rvd7HNAD1d2OSZ
	Gd+Kv4fFbxtzsHV3hPa5J15zBk/pUzPYPL6jp7SuCuGLBwxiGUu99NF9e5UJGeXX
	SyvpneNRNB6t8AChfF2bDqWR+47T70S9692e3jVFZtOHugSFOcHgb21TQ==
X-ME-Sender: <xms:HNWSZHK-Nha6KkfhJx8VgOC5ZSVGHijXnXaVuBba1lifZMlrJ0ikEA>
    <xme:HNWSZLKed1m4ZfTYLTtTePTcXTaJ6_Co8EEITKp9Ce018BoiSUba-8E-D572N3ZA7
    eQI3SOJWI6swg>
X-ME-Received: <xmr:HNWSZPvV-i8eng1oHuZFStMdT-NEWJU_OkJnp3fVEMu4GfZZvQqie9geuZCHrxzGmpby3enb5NaqNL9BYnL2sqYxvuZOzIwLKRw8Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:HNWSZAYKVPygxa1vOgQujMVkSaZqA7zA0CUAcky1ndTOuqlWThuSwQ>
    <xmx:HNWSZOZslZ5OsAV3Hpp8YZf7_z7sB5N5_scmkkHW13C9UW4VSX_qlw>
    <xmx:HNWSZECeZB7ObfwPRL8vIIyuzgstMmGPIsaHWZztboD3Os3GhlPQrQ>
    <xmx:HNWSZFVUyYvjqEoM8Q4g5dItO849cpxUOgT8umUa0nh6-q4ouilX8w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 06:46:51 -0400 (EDT)
Date: Wed, 21 Jun 2023 12:46:47 +0200
From: Greg KH <greg@kroah.com>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/11] Remove the end element in sysctl table arrays.
Message-ID: <2023062117-federal-dash-cf50@gregkh>
References: <CGME20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038@eucas1p2.samsung.com>
 <20230621091000.424843-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 11:09:49AM +0200, Joel Granados wrote:
> This is part of the effort to remove the empty element from the ctl_table
> structures (used to calculate size) and replace it with the ARRAY_SIZE macro.
> The "sysctl: Remove the end element in sysctl table arrays" commit is the one that
> actually removes the empty element. With a "yesall" configuration the bloat-o-meter
> says that 9158 bytes where saved (report at the end of the cover letter).

9k in ram or read-only memory?

> Main changes:
> 1. Add the ctl_table size into the ctl_table_header
> 2. Remove the empty element at the end of all ctl_table arrays
> 
> Commit Overview:
> 1. There are preparation commits that make sure that we have the
>    ctl_table_header in all the places that we need to have the array size.
>       sysctl: Prefer ctl_table_header in proc_sysct
>       sysctl: Use the ctl header in list ctl_table macro
>       sysctl: Add ctl_table_size to ctl_table_header
> 
> 2. Add size to relevant register calls. Calculate the ctl_table array size
>    where register_sysctl is called. Add a table_size argument to the relevant
>    sysctl register functions (init_header, __register_sysctl_table,
>    register_net_sysctl, register_sysctl and register_sysctl_init). Important to
>    note that these commits do NOT change the way we calculate size; they plumb
>    things in preparation for the empty element removal commit. Care is taken to
>    leave the tree in a state where it can be compiled which is the reason to
>    not separate the "big" commits (like "sysctl: Add size to the
>    register_net_sysctl function"). If you have an alternative way of dealing
>    with such a big commit while leaving it in a compilable state, please let me
>    know.
>       sysctl: Add size argument to init_header
>       sysctl: Add a size arg to __register_sysctl_table
>       sysctl: Add size to the register_net_sysctl function
>       sysctl: Add size to register_sysctl
>       sysctl: Add size to register_sysctl_init

Why not make these calls automatically calculate the size based on the
structure passed into them by using a #define instead of having to touch
the code everywhere?  That would make this much simpler AND make it
impossible for future people to get this wrong.

thanks,

greg k-h

