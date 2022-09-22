Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD975E6861
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiIVQ33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 12:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiIVQ30 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 12:29:26 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C885EE99AC
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 09:29:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6C1433200914;
        Thu, 22 Sep 2022 12:29:22 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 12:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663864161; x=1663950561; bh=Ls4S0Tz98v
        3lAbaZgRInk3TZOEGIbEC9AZNUZNgnaHk=; b=m6fpdaKyQ/j3rQ8aeSgEwovBuB
        mKQbXtimIUL6Fgm4PFKryF1prQnhnp4P1g7P49Bc2oS6G6oLBH2//8Nva1abW/1V
        wVairHJxF5rfTENFWBjUnTspIulqXM2MXYWH5/I85BHj4/6JLWf+LqZF4ivRT8ql
        CuEy8HmjoyjvGllGmkrVgfGL1oGRFRHkuXb/flPglvkp6zsezUZFsN7FcdVil6qx
        msKCEjP6ryFsy1nFnGleBiKpcVBnImuzBv/0euT8Umse0ukBispkBOacbDM9CGC7
        BOHStDnzaBnDhgtNwSTfmFP6UeCgA0eFU8iVmqIX2ic5DLIJeunmlJ+u/efQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663864161; x=1663950561; bh=Ls4S0Tz98v3lAbaZgRInk3TZOEGI
        bEC9AZNUZNgnaHk=; b=k0z0huR3YdLYFic2Nu1u1WDmoGLSQMHe6dYZTjQmZ+dk
        9rxIul42uNnkO+W7Z7AcbJxezUTCo8avzkhXQMWNxf0md5LuaiPKSVsv3nbNN0Zf
        RoOGqRce/SzCiDAg6t9HDoKg6jQUpL8fUDGciIjlzJX9UpVpGQqDFQfLYpyMDkoV
        qcjnyeNNi72nLpvFgSbE5McIFmb9Ib8M8fqdjELcfqxpKaisQsBQEngFXKqb4PuY
        vFpet7CfivYXTfrOc1QZxf5VN3xObhJnOXIcgkQHSRbK3rCesQyDT4sd0D6dmA3b
        6xH9sZ6FENhjWfOjb+QAM/MrsmrWbwHh2e/FH4DdxQ==
X-ME-Sender: <xms:YY0sYz51oNQc2gQGYQVZOxMK7YEDQcKHNrZnmUZGsMxv-ksTKvauBQ>
    <xme:YY0sY467xdITZyVReBII0LPxuLBiz_VXJ34BBmSMCPU5AuxJubCEShHlLMOv16mu5
    07Hr7_UmQbImBitEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epjeekveeutdejtdefueffgfetgeehvdeileffgeevtddvuddtteejvdduhfdtvdefnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhssheslhhmsgdrihho
X-ME-Proxy: <xmx:YY0sY6fH-mZeY6kU_t4D4PhEJMYHdAmzZ3JWcj6mYW63JgEVf-fIoA>
    <xmx:YY0sY0J4_kwKBfMnOqxHxS4Wq53h7HrsnHMLbFb66H9_UHQEnbDTHQ>
    <xmx:YY0sY3JEgL2K49p6WbVtYYg6itIqQZNC2OJKDZWrWJGBoq5wp2J0Jg>
    <xmx:YY0sY0FWwoSCrnsxOwHRl9xZ86dtaf2F20QzycfPa6hrqV6SOc8r9Q>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E76A15A0087; Thu, 22 Sep 2022 12:29:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <4e66ca38-e99d-4fe5-b224-e36fb946878f@www.fastmail.com>
In-Reply-To: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
Date:   Thu, 22 Sep 2022 17:29:01 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Closing the BPF map permission loophole
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
> Hi list,
>
> Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF 
> map permission loophole", with slides at [0].

A timeline of the most important commits in this sorry affair. TL;DR: >= 4.15 is really broken.

v4.4 commit b2197755b263 ("bpf: add support for persistent maps/progs") 
https://github.com/torvalds/linux/commit/b2197755b263

Introduces BPF_OBJ_PIN and OBJ_GET. Map fds are always read-write and all is fine.

v4.12 commit 56f668dfe00d ("bpf: Add array of maps support")
https://github.com/torvalds/linux/commit/56f668dfe00d

Map fds are always read-write. Inner map map_flags are compared to the outer map via bpf_map_meta_equal, which prevents stripping BPF_F_RDONLY_PROG, etc. later on.

v4.15 commit 6e71b04a8224 ("bpf: Add file mode configuration into bpf maps")
https://github.com/torvalds/linux/commit/6e71b04a8224

Introduces BPF_F_RDONLY / WRONLY. Doesn't take into account that BPF programs can modify maps (unprivileged BPF is enabled since v4.3). Also doesn't take into account that BPF_OBJ_PIN can be used to turn r/o into r/w maps. This is the start of our problems, and IMO it's completely broken.

v5.2 commit 591fe9888d78 ("bpf: add program side {rd, wr}only support for maps")
https://github.com/torvalds/linux/commit/591fe9888d78

Introduces BPF_F_RDONLY_PROG, etc. Using sourcegraph.com I found a BPF ELF that creates a map with BPF_F_RDONLY | BPF_F_RDONLY_PROG flags [0]. This would be broken by refusing non-RW fds in the verifier, which is my preferred brute fix. Those flags came about because of a misunderstanding of what BPF_F_RDONLY does, which makes me worry might be other cases out there.

Based on my research, we can do the following:

> Problem #1: Read-only fds can be modified via a BPF program

Up until 591fe9888d78 BPF_F_RDONLY_PROG we'd probably be OK with just refusing !rw fds. The only kernel.org version that this applies to is 4.19. 5.4, 5.10, 5.15 need the fix Roberto suggested.

> Problem #2: Read-only fds can be "transmuted" into read-write fds via map in map

This is not as big a problem as I initially thought. First, lookup in a nested map from userspace returns an ID, not a fd. Going from ID to fd requires CAP_SYS_ADMIN. On the program side, it's possible to retrieve the inner map and modify it.

I think it's possible to fix this by refusing to insert !rw inner maps, by patching bpf_map_fd_get_ptr(). That function hasn't changed in a long time either. 4.19, 5.4, 5.10, 5.15.

> Problem #3: Read-only fds can be transmuted into read-write fds via 
> object pinning
>
> 1. BPF_OBJ_PIN(read-only fd, /sys/fs/bpf/foo)
> 2. BPF_OBJ_GET(/sys/fs/bpf/foo) = read-write fd

bpf_map doesn't have a concept of an owning user, so the only solution I can come up with is to refuse OBJ_PIN if !rw and !capable(CAP_DAC_OVERRIDE). Replace CAP_DAC_OVERRIDE with another capability of your choice, the idea being that this allows programs that run as root (probably a lot?) to continue functioning.

Again 4.19, 5.4, 5.10, 5.15.

Daniel, Alexei, Andrii: any thoughts? This is a pretty deep rabbit hole, and I don't want to waste my time on the wrong approach.

0: https://github.com/willfindlay/bpfcontain-rs/blob/eb2cd826b609e165d63d784c0f562b7a278171d2/src/bpf/include/allocator.h#L16
