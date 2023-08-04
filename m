Return-Path: <bpf+bounces-7009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFA7701A8
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E51C21866
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F7C155;
	Fri,  4 Aug 2023 13:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588779EB;
	Fri,  4 Aug 2023 13:32:06 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDD4C05;
	Fri,  4 Aug 2023 06:31:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 442185C013F;
	Fri,  4 Aug 2023 09:31:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 04 Aug 2023 09:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1691155904; x=1691242304; bh=jt/eqP4aPwn04
	aS2T+/sFSLK8MZIFtCXDP4UokE+Qio=; b=dLoDFeQZyoLisNWmOXcJb2viKeyzU
	7fGNJ+GlsUV/xif7+JuiY89mdb1djfgWc7YRiVNqkc1rmMKex0VMQp7py4U7P+Rl
	gtUniQth10aQyyzCPPmyW2Q+fxsPkxUOQZ1COjVF/hlC0rgyje7MDaHFCfN6qOdU
	uAHJO0x6a5x+x8n0v1oRgay7qPIAzCBG8LUArsexYiwHJooRy7aR3MCRpq5YqbwY
	v0hr/P8lXL912thzs7v9JEGu+jP5A6I+dWFjXqvPqqTnsZoPkjv2bnLkM3/qDHiQ
	GZkY3oOxuRs9Nx0zkT3OaVuWJiXVx+NUllEJNxAjdaeyEUq4i6rpasXJA==
X-ME-Sender: <xms:wP3MZOkocCCz6uMr1bdnJ_hMKWPPTC_ErMpRBTrDbFj3ddDUZA-Wug>
    <xme:wP3MZF3dRKF8gZ3ylcnrPnIQKHddEjiMOoMHubyK2h9_jEMrcPLr153r4AfIzlF-z
    1OYpQZJtNtP0ng>
X-ME-Received: <xmr:wP3MZMomUDjQR3wVfALFdsL487_NLuwBq-9fA9CAGAcC1f2aAxpvyMHp7kelu52238AG0i3dfpsbw_A4SxzkbPleXD1kXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:wP3MZClsFTC4heq81SnS1v8rFuQnBa6i0oMKkdwWVU98tS_myf-0_w>
    <xmx:wP3MZM2nWzhw8YxEXnxiw-3e363ocEoffiDCNPEO8WCo4IiqKQRlNQ>
    <xmx:wP3MZJs8q08vf7uSs9eAGUs6xsY8UlTIEM-WTMnQKjxKgziab0JUOg>
    <xmx:wP3MZGqazbGqtl2mN3L125zG27U7nQnC6O-ppkOmLYKgWl9vIpo_4g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 09:31:43 -0400 (EDT)
Date: Fri, 4 Aug 2023 16:31:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
	syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
	syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
Message-ID: <ZMz9u+yZtk8vf+OP@shredder>
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 03, 2023 at 02:10:51PM +0300, Gal Pressman wrote:
> Our nightly regression testing picked up new memory leaks which were
> bisected to this commit.
> Unfortunately, I do not know the exact repro steps to trigger it, maybe
> the attached kmemeleak logs can help?

[...]

> unreferenced object 0xffff88812acdebc0 (size 16):
>   comm "umount.nfs", pid 11626, jiffies 4295354796 (age 45.472s)
>   hex dump (first 16 bytes):
>     73 65 72 76 65 72 2d 32 00 eb cd 2a 81 88 ff ff  server-2...*....
>   backtrace:
>     [<0000000010fb5130>] __kmalloc_node_track_caller+0x4c/0x170
>     [<00000000b866a733>] kvasprintf+0xb0/0x130
>     [<00000000b3564fca>] kasprintf+0xa6/0xd0
>     [<00000000f01d6cb3>] nfs_sysfs_move_sb_to_server+0x49/0xd0
>     [<000000009608708f>] nfs_kill_super+0x5f/0x90
>     [<0000000090d4108b>] deactivate_locked_super+0x80/0x130
>     [<000000000856aeb1>] cleanup_mnt+0x258/0x370
>     [<0000000040582e39>] task_work_run+0x12c/0x210
>     [<00000000378ea041>] exit_to_user_mode_prepare+0x1a0/0x1b0
>     [<00000000025e63dd>] syscall_exit_to_user_mode+0x19/0x50
>     [<00000000f34ad3ee>] do_syscall_64+0x4a/0x90
>     [<000000009d3e2403>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

This one is caused by commit 1c7251187dc0 ("NFS: add superblock sysfs
entries") and fixed by [1], so I'm not sure the bisection result is
reliable.

[1] https://lore.kernel.org/linux-nfs/6702796fee0365bf399800326bbe6c88e5f73f68.1689014440.git.bcodding@redhat.com/

