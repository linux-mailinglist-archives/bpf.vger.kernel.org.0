Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CD5EAD11
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiIZQs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 12:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIZQsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:48:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4A714D27
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 08:41:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 001565C006D;
        Mon, 26 Sep 2022 11:41:41 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 26 Sep 2022 11:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664206901; x=1664293301; bh=Y9qqIHbjlH
        jfDnCVIwWfTlZ+Qvk1ZAEnjT1eL4WIGOM=; b=DimqWWmBhHnnzFYgdVEUEaRPfA
        AaOgYSTGjhTa3UVN6SMhHHfbcGhetERaaGYi3M8OWnOM4qQgyV7UEZrNxACsxeiu
        6SciC59qADytNfkm/EvLoE9fDgix/cJj13dxhLtUo94asVTk0qgrFC9jBIIPJOsS
        vGJ61wLkzlFvx6kjveyviBgcFlXl0DyeDKQTIYvZ5BSYKYmSpnNFw0+lavz/Ufgs
        5LBuSgpjQbLXU9DS0v82/W2kzg+L4DrABg5oFFgtY8SwH+N+tIeijaj4hStLxCJg
        pzly+IlJKwMMHTn9UwlAp6mwlt7MHY72mmY3mH5NnpS3bDlT/hUKq+qOWWhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664206901; x=1664293301; bh=Y9qqIHbjlHjfDnCVIwWfTlZ+Qvk1
        ZAEnjT1eL4WIGOM=; b=oMxdPr1tUGhBul6UM29eMZ+IEmaWcNg6WSfInX1eUrOk
        +rlcc0+LeoTtKAMTgRYWu9uRGdJsY5EW1VFjjDWCEk/VgheTu5XD9NXekyL5R+Ht
        scYuqgP1dJswRbxRawxoNSZLlig7o85JRGgXd3u/546Gd3LvVZW8gOPV68kEPk2k
        7D41JcCXAIAMMikxmnwjJFITrj6+Rfut7fq95zUDcw3MPbTqMyn7UbXUJ1fxWJmo
        mqPxQnrXIHSGIecUChLX/HBtm14fVzrdt2O1Jt874ZfO69YeqR+g9VZLvodmqcrl
        2WI74M+9dBIyukTI+5gGMVr4xTc4e6mDJNm3ovj9nA==
X-ME-Sender: <xms:NcgxYycHmZzJMJBASRSikG8ZbvB2pEE0SymY2V9a_QehfkscHlyTkQ>
    <xme:NcgxY8Mxf9to8JF8rDzeE42UHL6BNODRDANSd46Dq2OmI1VVY0n2bQZ7Yaw-fee0J
    bklkf6liKyEwT3GDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffetgeffgfffffeuudeihfffueffgfelheegtdelleeggfffgfevfeekfedtffelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhssheslh
    hmsgdrihho
X-ME-Proxy: <xmx:NcgxYzi6Aa0PE7NWf6ivZmK9_vsGRk4-QBpuGIV_vUIjohbkN9sdnw>
    <xmx:NcgxY_8FjrePNLqQm3DUdZ05iQ7SOEZC2MUSpbZ_fX7xtmABPHaozw>
    <xmx:NcgxY-trM6bZ9Zq4oJkD3rX_EUjNHjEOK-7rQSpxvy9rLbDN6i4nAw>
    <xmx:NcgxYwXHbZgcsbzqUpT0o-aL7ZurQsI1RuQ87q-cWK2m-_S9dcZdSg>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BCE8715A008B; Mon, 26 Sep 2022 11:41:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <e63e027d-c0a0-445c-94b7-c83d1d5dced5@www.fastmail.com>
In-Reply-To: <CA+khW7ittjLYfdHLpcVDGtpnXv1q-WPwRz-CqUTvFOSeywhBQA@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <4e66ca38-e99d-4fe5-b224-e36fb946878f@www.fastmail.com>
 <CA+khW7ittjLYfdHLpcVDGtpnXv1q-WPwRz-CqUTvFOSeywhBQA@mail.gmail.com>
Date:   Mon, 26 Sep 2022 16:41:21 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Hao Luo" <haoluo@google.com>
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>, bpf@vger.kernel.org
Subject: Re: Closing the BPF map permission loophole
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

On Fri, 23 Sep 2022, at 00:21, Hao Luo wrote:
> For this problem, I'm thinking of a fix purely in the verifier:
> passing along the file permission up to the site where the map is
> used.
>
> For maps that are not passed from outside, this permission is rw by default.
>
> For maps that are obtained from fdget(), we can do the following:
>
> - associate the env->used_maps with an array of permissions.
> - then extend bpf_reg_state and bpf_call_arg_meta to include the
> permission information.
> - then in record_func_map(), we can reject the program if the
> permission doesn't allow the map operation.
>
> Not the simplest solution, but this is the first solution that comes
> up in my head.

That's roughly what I have as well!

> For an idea mentioned in the summary,
>
>> In OBJ_GET, refuse a read-write fd if the fd passed to OBJ_PIN wasn't read-write.
>
> This sounds reasonable to me. Can we extend the object type referenced
> by inode to include the permission?

You're saying, add a layer of indirection? Instead of inode => bpf_map we have something like inode => bpf_perm => bpf_map.

I think this is less user friendly than refusing !rw pin, since we decouple what you can do with a pinned file from the state that is observable via ls. Put another way, there should be a way to introspect bpf_perm if we end up going this way.

I also think that this tries to plug the hole in the wrong place: it's not the caller of OBJ_GET that is escalating privs, is OBJ_PIN.
