Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172395B98CC
	for <lists+bpf@lfdr.de>; Thu, 15 Sep 2022 12:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIOKbX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 06:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIOKbW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 06:31:22 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7C895C1
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 03:31:20 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A327E5C006D;
        Thu, 15 Sep 2022 06:31:17 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 15 Sep 2022 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1663237877; x=1663324277; bh=NFNg93cumQ6GotlPF6eXabO9jiXMH/FvtO9
        yjxTzR74=; b=b+ahCT0ea+H5fONX5h0ZkDFFL4jXMrGbZW5A+4e05fnPvxr6gis
        41vtkZYFLedu1GSYqFA1ANrBZ8mSPjpT65olKcHc8Z0woyM615PB2SfL6l4ewzcc
        9x2SoKm14WCxjCNKs9VnmiyVuOvSEbT//HrKDGNCqS6qd3t9chUYDmx753AnEAPv
        UwImZ7bmXod5ZDGe2G7w+5w46tdaqyrxJKuLFe9dmeeFJFKQf0VSWWCvoVEr7oJZ
        US0GIg+7nZrJT8Qre7o3YGLft0BlYOAh8OaSoTZeRqkV/E47V/rHfYg/BTSsPZUD
        breyCm40Vwk4zoDdqEep2HewPVAXes3ULlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663237877; x=
        1663324277; bh=NFNg93cumQ6GotlPF6eXabO9jiXMH/FvtO9yjxTzR74=; b=A
        rZVT6BYVL0ZalOwS2EeTAoJaRW1K1UDgmwDeMdcI+GiGA8kJXtLfEFpAtWpncShR
        VGCZPrlgKxb6FTHt0CUB9oyQevjlocwouY7dpfcJUYXLTPD+jy3XSgmeaa0+4x5W
        KO1XTX8ZZxhQSIK441vhzDOKtxPVLS6/5aGJMrAS0GQjtDW3a0B9teACciazpAYR
        +tD8VxCh2XDUuVWEfF4I7GjOpFzTJ+A8sBK4bvtTf/lPD/jWX/O3vLrzHOTGxp2k
        SVKE+/N5CDjPmeLxL2DEFbaU3QDam7oVIpydG/Zk1dKnK5Al633ksNRf51qSEaYE
        IeDlt+pTIBJ7YgI73CZOQ==
X-ME-Sender: <xms:9P4iY3J1DdUVMnq2GlVHOgkAPEDJFzwP8ClS6g0bOEZnrXGFtDV--Q>
    <xme:9P4iY7KJTTf2l8Dr1UUt9kcLpycWtWRGDeo1Twbpta80bF2M6ysGatrHt4qRmADc0
    -At4PPpZFtS0V5kOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfhorhgv
    nhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnhepke
    ehuefgfffgueduueeuhffhvdeuvdffueelheegtdegtddtvdekueetgeehheetnecuffho
    mhgrihhnpehlphgtrdgvvhgvnhhtshdpsghoohhtlhhinhdrtghomhdpkhgvrhhnvghlrd
    horhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:9P4iY_vkMXmZf56Ie3eNItbBkRUCt9mCTyWMphJ-g1wZorDrzqybDg>
    <xmx:9P4iYwZtP3T9cPZsudRuKwsb4YuKifsyPg6HrYF2XHjo6haiziGdUg>
    <xmx:9P4iY-aTwGx_OTbp8RIXEPMenSkfwS5CCXpiAtZA4e2rvnNWyOnb2w>
    <xmx:9f4iY1Uzg5Md3kOh2Lka7PVS7bHfPjfvGux9RQcngumHMkqi8KzFuA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D524F15A0087; Thu, 15 Sep 2022 06:31:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
Date:   Thu, 15 Sep 2022 11:30:12 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>
Cc:     bpf@vger.kernel.org
Subject: Closing the BPF map permission loophole
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi list,

Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF map permission loophole", with slides at [0].

Problem #1: Read-only fds can be modified via a BPF program

1. Craft a BPF program that executes bpf_map_update_elem(read-only fd, ...)
2. Load the program & execute it

The reason is that the verifier only checks bpf_map->map_flags in resolve_pseudo_ldimm64, but ignores fd->f_mode.

Fixing this problem is complicated by the fact that a user may use several distinct fds with differing permissions to refer to the same map, but that the verifier internally only tracks unique struct bpf_map. See [1].

Problem #2: Read-only fds can be "transmuted" into read-write fds via map in map

1. BPF_MAP_UPDATE_ELEM(map in map fd, read-only fd)
2. BPF_MAP_LOOKUP_ELEM(map in map fd) = read-write fd

This was pointed out by Stanislav Fomichev during the LPC session. I've not yet tried this myself.

Problem #3: Read-only fds can be transmuted into read-write fds via object pinning

1. BPF_OBJ_PIN(read-only fd, /sys/fs/bpf/foo)
2. BPF_OBJ_GET(/sys/fs/bpf/foo) = read-write fd

The problem is with BPF_OBJ_PIN semantics: regardless of fd->f_mode, pinning creates an inode that is owned by the current user, with mode o=rw. Even if we made the inode o=r, a user / attacker can still use chmod(2) to change it back to o=rw.

On older kernels, this requires either unprivileged BPF or CAP_BPF, but recently BPF_OBJ_PIN has been made available without CAP_BPF.

This problem also applies to other BPF objects: links, programs, maybe iterators? Since we don't have BPF_F_RDONLY semantics for those the issue is maybe less urgent, but see [2] for some more fun.

A number of ideas were explored during the session:

* In OBJ_PIN, create the inode owned by the user that executed MAP_CREATE, not the user that
  invoked OBJ_PIN. This would allow unprivileged users to create files as another user, which
  seems like a bad idea.
* In OBJ_GET, refuse a read-write fd if the fd passed to OBJ_PIN wasn't read-write. This is not
  possible since we store struct bpf_map * in the inode, so we don't have access to fd->f_mode
  anymore.
* In OBJ_PIN, adjust the mode of the created inode to match fd->f_mode, and later refuse attempts
  to chmod(2). After a cursory glance at the source code it seems like there are no hooks for
  filesystems to influence chmod.

My gut feeling is that the root of the problem is that OBJ_PIN is too permissive. Once an inode exists that is owned by the current user the cat is out of the box.

BPF_F_RDONLY and BPF_F_WRONLY were introduced in 4.15 [3]. If we want to fix this properly, aka relying on BPF_R_RDONLY doesn't introduce a gaping hole, we'll have to do quite a bit of backporting.

I plan on submitting a sledgehammer approach fix for #1 and #2 as discussed with Daniel after my presentation.

#3 is in sore need of further discussion and creativity. One avenue I want to explore is whether we can refuse OBJ_PIN if:
- the current user is not the map creator
- and the fd is not r/w
- and the current user has no CAP_DAC_OVERRIDE (or similar)

Thanks
Lorenz

0: https://lpc.events/event/16/contributions/1372/attachments/977/2059/Plumbers%2022%20Closing%20the%20BPF%20map%20permission%20loophole.pdf
1: https://elixir.bootlin.com/linux/v6.0-rc5/source/kernel/bpf/verifier.c#L12839
2: https://lore.kernel.org/bpf/20210618105526.265003-1-zenczykowski@gmail.com/
3: https://github.com/torvalds/linux/commit/6e71b04a8224
