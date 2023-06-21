Return-Path: <bpf+bounces-3018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2559F738485
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FEA281604
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A75171B0;
	Wed, 21 Jun 2023 13:11:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384813AEA
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 13:11:07 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF781BCB
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 06:11:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 19B745C00C2;
	Wed, 21 Jun 2023 09:11:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Jun 2023 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1687353060; x=1687439460; bh=IP
	HnfX43ssHmQRMsBhsgWZilxlXhth9oSVqkSBUAPwc=; b=rSySMGmf4XNW4gkWWM
	7Bph11dnkHo6XNZ5wry3w06e0jgdD+1IqNBWyV5B82RbrdhSV2MYecM+YXYdFdSo
	blTcyydXtfos2LkkwFysm+DnfZiJsK0Htdl+CsVGl3ELGtPvsI9P4QB9LZJjfEsW
	P19CZUjc2FSiDIw+hW6U9Zel0r3UJJUzAvVeRa6rtNEtU51FbQ4OTJA4Ndt5Qljx
	2Z0Fmi0Zf77i4Hoer9KwwDATPY4Z7l7DO8QxitFZkT19D9YzWsAiQTX+DxNC9IA6
	y5ylIGKoyQHrUIluN7+3YV73372l6fKCogGHLqsS3jactITFA2/WAg/0VUDqOnbF
	+q1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1687353060; x=1687439460; bh=IPHnfX43ssHmQ
	RMsBhsgWZilxlXhth9oSVqkSBUAPwc=; b=jLBCS//c9okaNjAl3z8TH09xIjVv2
	EXSYMcDeFmqOXld1cewGIIVeVi6JguC2USKBXt11ljrNjOpbJOr/L/NDGdWlhFUV
	/0TKzA8cQVCOpVAaxDibkhioyP2HBl4/eTrGZhTyKNOAJ0z5pZJYejRfm1lAWKk4
	eYXh6/jvDSNg1V8Lg8zRNiTc2j6xD1A0/u2aVS0LFrjQgzE5a9RbRcuCS1CaRoM2
	0UPJJMnc+xB6x8A/2j8yo1hF/GhQQznFFBRD4V+c/HUl/WEMPPQ35iBVtr9/qSjZ
	ruuMBH2tPdzkOSHZR0Cn/vLsHUVHZuN4WVD/c9XFVZSFa4AmAm8Sb22bw==
X-ME-Sender: <xms:4_aSZCQtEfW0RBi5ncV2GS1iUe7WwFOS5HDduE87zJ4CPh5COOpTow>
    <xme:4_aSZHysBOTbYMXu14RmMQVQJ_xnuZ5krlrnfyBXbu6QlLys34jtKfbO5UqTdE-6n
    WyXJ4X1MlaKRg>
X-ME-Received: <xmr:4_aSZP0wpcqV4HUcUJaCwMQbHwmoGzNsOM7-3IJzDGEZPz4EwdtV3F0nsWaFqC6CmAz8A8f6nGYg2lWHX4AyainGebGczWJULNeiVnAawKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:4_aSZOCVeIa8b6rs613kgFmmE5YNnqhrizDRorsgt_UzyRPqyA3aTA>
    <xmx:4_aSZLjUwj6a2o6ZaZuytxrlKlapDUQ9UMIs86pIHktXRRNPddqC2A>
    <xmx:4_aSZKp-mO7TkysV_5mJiOLxSPz31MQ6m_9l_BSpU2qWqv7kkIPDgg>
    <xmx:5PaSZLdfxuhVmG43T-DhkfvqytmYWX7Q5oDrmLQ4IkOOJxW-2TFJPA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 09:10:58 -0400 (EDT)
Date: Wed, 21 Jun 2023 15:10:57 +0200
From: Greg KH <greg@kroah.com>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 00/11] Remove the end element in sysctl table arrays.
Message-ID: <2023062102-letdown-roving-921d@gregkh>
References: <CGME20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038@eucas1p2.samsung.com>
 <20230621091000.424843-1-j.granados@samsung.com>
 <2023062117-federal-dash-cf50@gregkh>
 <20230621123816.ufqbob6qthz4hujx@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621123816.ufqbob6qthz4hujx@localhost>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 02:38:16PM +0200, Joel Granados wrote:
> On Wed, Jun 21, 2023 at 12:46:47PM +0200, Greg KH wrote:
> > On Wed, Jun 21, 2023 at 11:09:49AM +0200, Joel Granados wrote:
> > > This is part of the effort to remove the empty element from the ctl_table
> > > structures (used to calculate size) and replace it with the ARRAY_SIZE macro.
> > > The "sysctl: Remove the end element in sysctl table arrays" commit is the one that
> > > actually removes the empty element. With a "yesall" configuration the bloat-o-meter
> > > says that 9158 bytes where saved (report at the end of the cover letter).
> > 
> > 9k in ram or read-only memory?
> AFAIK its ro as I'm removing all the "empty" end elements from ctl_table
> array that are hardcoded all over the place.
> > 
> > > Main changes:
> > > 1. Add the ctl_table size into the ctl_table_header
> > > 2. Remove the empty element at the end of all ctl_table arrays
> > > 
> > > Commit Overview:
> > > 1. There are preparation commits that make sure that we have the
> > >    ctl_table_header in all the places that we need to have the array size.
> > >       sysctl: Prefer ctl_table_header in proc_sysct
> > >       sysctl: Use the ctl header in list ctl_table macro
> > >       sysctl: Add ctl_table_size to ctl_table_header
> > > 
> > > 2. Add size to relevant register calls. Calculate the ctl_table array size
> > >    where register_sysctl is called. Add a table_size argument to the relevant
> > >    sysctl register functions (init_header, __register_sysctl_table,
> > >    register_net_sysctl, register_sysctl and register_sysctl_init). Important to
> > >    note that these commits do NOT change the way we calculate size; they plumb
> > >    things in preparation for the empty element removal commit. Care is taken to
> > >    leave the tree in a state where it can be compiled which is the reason to
> > >    not separate the "big" commits (like "sysctl: Add size to the
> > >    register_net_sysctl function"). If you have an alternative way of dealing
> > >    with such a big commit while leaving it in a compilable state, please let me
> > >    know.
> > >       sysctl: Add size argument to init_header
> > >       sysctl: Add a size arg to __register_sysctl_table
> > >       sysctl: Add size to the register_net_sysctl function
> > >       sysctl: Add size to register_sysctl
> > >       sysctl: Add size to register_sysctl_init
> > 
> > Why not make these calls automatically calculate the size based on the
> > structure passed into them by using a #define instead of having to touch
> > the code everywhere?  That would make this much simpler AND make it
> > impossible for future people to get this wrong.
> I considered this at the outset, but it will not work with callers that
> use a pointer instead of the actual array.

Then make 2 functions, one a "normal" one where you can't get it wrong
as you pass in the structure that you can compute ARRAY_SIZE() and one
that you have to do it manually.

Don't force developers to think about stuff like this as now you are
going to have to constantly audit the code to verify that the array size
is correct.  Right now it always "just works" due to the null
termination, and now you are going to add complexity to the author in
order to save a trivial amount of memory that no one is asking for :)

> Additionally, we would not avoid big commits as we would have to go
> looking in all the files where register is called directly or indirectly
> and make sure the logic is sound.

Then you need to think about how this could be done better, having "flag
days" like this just doesn't work, sorry.  There are ways to evolve
common apis, and it's not like this patch set :)

I'm all for saving space, but do NOT do it at the expense of making apis
harder to use and easier to get incorrect.  That will just cause more
long-term problems and bugs, which is NOT a good trade off you ever want
to make.

thanks,

greg k-h

