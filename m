Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF075E6623
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiIVOsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIVOsC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 10:48:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE1F373A
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 07:47:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 24DBB32000CC;
        Thu, 22 Sep 2022 10:47:56 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 10:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663858075; x=1663944475; bh=qkGv1cZuF/
        56tVROSI6K+SIFFXkIIsZLzr9Q0mj163c=; b=Aea95+iKjDh3sRuCRS5X2yjjni
        tp4jftifOMlvaxTSgvf4sFjcvTYv/yyKr1i6Q9/VOv7BbfCjaQ+tClkY4XMOwfXf
        6ZI4svK90x6vtao02YputE41MlcNH20h5F/ct58/c2+dAtLzruG+pJQKUkIGnWNL
        ib2P6vKLRwUKxvmpYyh4NM8/udbLHImsEujNObHWiomR4wZunkIaLBkOB4YxvyoJ
        lBY96MHu3p4gdZKzNjjEQYA9YGdyDyE1rnrMLxiCN+VhPIwCMXXgw0R1sFBXRE4i
        wYAmcr+LMpkaKKw9NfCTEALMi9ZQUinZUwpaXOmOiFMVWiMuZwZZlfIcqN7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663858075; x=1663944475; bh=qkGv1cZuF/56tVROSI6K+SIFFXkI
        IsZLzr9Q0mj163c=; b=n4T+TrXmfxKtSB7ZsmAVH5CN/5wEFuFSc9rqcKdY6Enx
        kqe0pdsM3P9RTwvSAIwBTPXEuIsZ8VeWwGgh+Kg29RdwpWRYY5qXDIiGZ/6Xqh/w
        CHOq5P9GMxaoX4kYHjqA3VQ+algL2P4akWDklkw9M/a/FsUaWZKY8tQzBYGDBuJn
        nhx/P2GluOHzPw/TMdfu/NCZJ3Y533pFc+wEElXDih602kXKVcd5kYPxqy24NvPX
        48Y6ryzWcjppCoMYSG3TaaTc9o4Eid7LCuQhKDXA1tQaEB3CYy51/B1HcAncqOzp
        /vt+rdFfc0JhtmDW6mpiZb6iJLD354/MHoglQvbW1g==
X-ME-Sender: <xms:mnUsYwGwFU2MktIV3T0Zxb8gZS8q0nU8V-4rwr9pS2bKDHiFi7xLLw>
    <xme:mnUsY5XyPrXquWaQjWBVkfSUiZDPXe7Mec4FYp4T5ViinwKLVn2xUHRVDJfKovJTL
    tQ0fqtKIsmMfuA6JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffetgeffgfffffeuudeihfffueffgfelheegtdelleeggfffgfevfeekfedtffelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhssheslh
    hmsgdrihho
X-ME-Proxy: <xmx:mnUsY6J_e4iMqM6CMiaU1cyC941fL7bCZ2dvxJN2suaIHT7ZrlkcnQ>
    <xmx:mnUsYyFQfHtcL0wdnqHHO9DxARvghtr3Ph9C2-ECbYmCVJCKJR-MwA>
    <xmx:mnUsY2WIm_x_pKhLOfPzRQNpgMhtuE35NAiPa7r0RQuc6O-lj2ZJCA>
    <xmx:m3UsY4eXtVyTxbTKXgxWqiPZnA4Hmr535lRcXVFWM7kzHwru4XolWw>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF29F15A0087; Thu, 22 Sep 2022 10:47:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
In-Reply-To: <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
Date:   Thu, 22 Sep 2022 15:47:32 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
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

On Wed, 21 Sep 2022, at 17:32, Roberto Sassu wrote:
>
> I saw your fix #2, even if I didn't fully understand it. What do you
> think instead about converting the fd modes to map flags (e.g.
> BPF_F_RDONLY -> BPF_RDONLY_PROG), and we rely on the existing verifier
> behavior for the _PROG counterparts? In this way, it will be the
> verifier enforcing the decision made by security_bpf_map().

Thanks for that idea, I think something like it was floated during the discussion after my talk as well but I forgot about it. I gave it a shot, and it turns out okay actually. The biggest draw back is that this approach requires commit 591fe9888d78 ("bpf: add program side {rd, wr}only support for maps") which appeared after BPF_F_RDONLY.

>> Problem #3: Read-only fds can be transmuted into read-write fds via
>> object pinning
>
> Maybe I'm missing something, but I consider pinning more like adding a
> new reference to an eBPF object (like the ID).
>
> You are still subject to access control decision by security_bpf_map(),
> as for BPF_MAP_GET_FD_BY_ID().

I had a look, security_bpf_map() is only called from bpf_map_new_fd(), which in turn is invoked from GET_FD_BY_ID, MAP_CREATE and OBJ_GET. Checking at this point is too late, since OBJ_PIN + chmod allow escalating privileges. Can you explain your idea some more?

> Now, the security model is limited to two permissions (read, write). If
> we want to add a new one to decide whether or not a new reference can
> be added, we could revisit this.

Maybe, but that would preclude back porting any fixes. I'll write up another summary in a bit that shows that this problem goes back all the way to the introduction of BPF_F_RDONLY, etc.

Thanks
Lorenz
