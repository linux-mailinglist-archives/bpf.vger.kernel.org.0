Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF8C5E684D
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 18:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiIVQV4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 12:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIVQVy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 12:21:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0692E21D0
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 09:21:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 956013200657;
        Thu, 22 Sep 2022 12:21:46 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 12:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663863706; x=1663950106; bh=ojV5qtpUSm
        xW/5klERVRy6tSkdY9WvxB4GKRxa9oxE0=; b=kyd4eQ15Iu49HIl5hx7j1twtku
        pSPTJ1cfmHLKSeppjjKE9/KYQ8aV9fuLUXTwQE/y3vYjeUxPTzGxfRxVh7Qfcg6i
        OPzBvivxHVL4uUzVzMPV0g0AEiE0TkkJq3EHsH6vq7tUTnG9tAgLGBsHMld4B6zi
        5KaanXoa/rKaHKuVC5XFlb7mYWRi3pg26YKGbW3oNsElxNXx9UjzhMFSCuSY3AJe
        AZMar0N7VihPUSBzjXEWbCqXMgIDKddysrJUaif2Yzp5k+Sysqwf3EHZ0FLFSbRK
        2OgVCseHBTRsI6XJAljO0zGPlelIAmECOPgg6O6wPOShHiGQYHz2hAKDdu5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663863706; x=1663950106; bh=ojV5qtpUSmxW/5klERVRy6tSkdY9
        WvxB4GKRxa9oxE0=; b=UCXu8YhTe9Lu14ccq806REv9DfvuXWnW3n6Z7Hfwedhf
        HjdM7LavTJ9Ul2/mFprJXZ2J/s2h/5bKJLDs1+pvqKTUp9WhlsORboxHmy4mntr0
        U8RyCWu3Uza+L/NK90HbvN06ulDTJNoepp3sVCQH5I91wDTFG5lXbIyNFN1pq88M
        j56L8WSB0hvEscGY/y7Dvh+/Us9eY/vcxjgwETWhmNBRegg7OANVk1KFjMDP5q5y
        D0rCOsxky7j2iL+gPNSG25QTBkEWuNNJjrhdX4Caqyh6kqauCDVozBORvgmndpCD
        VPOPPAMNEK4SccV/S+Ne5OcvPrGFdJ5t21VDYXz3WA==
X-ME-Sender: <xms:mYssYwxbLoPIcmGinVVDQmbaUFb2YZMNFwv5uGE4cEnz9wAv5Q-_Sw>
    <xme:mYssY0Sojx-THc7lUZbWfNOYew6jC1yiSBGplq9YhGpeKqq1ygJHhVQwgD5JyugOq
    DdWt26PVQxRTSzZDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffejueekkeetheeiieehieffhfevheetuddvfeehgeekgeelleffkeelueefleevnecu
    ffhomhgrihhnpegthhgvtghkshdrhhhofienucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:mYssYyUVaI98Rmxl5WgQw-0Z7BxlkC9wcUbOvrtf-R4Ziy6yL9RfwA>
    <xmx:mYssY-iqT2t9VweKztrTmXzjAVw9AU_HaUAuZnR4TKnhF7BmWuiIXg>
    <xmx:mYssYyD5mz5YqVBmWOFXUj0EaFqGx-t5avoJBRlLlibuw2wGVRsswQ>
    <xmx:mossY56nc2FoPOMX4ZuTFNZu40KA-wVDd_mEeP0IifTElngYiEjMNA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A676815A008B; Thu, 22 Sep 2022 12:21:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
In-Reply-To: <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
 <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
Date:   Thu, 22 Sep 2022 17:21:12 +0100
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

On Thu, 22 Sep 2022, at 16:39, Roberto Sassu wrote:
>
> Yes, true. Not sure if it makes sense to backport it to stable versions
> (probably not). Or alternatively, for older versions we could ensure
> that the fd is for read/write, even if as you said, there is a risk of
> breakage of existing applications. It seems unlikely that this could
> happen, as libbpf still does not support requesting a read-only fd,
> although one could create an ad-hoc function to set the appropriate
> parameters for the bpf() system call.

You can create a r-o fd via bpf_map_create if you pass map_flags=BPF_F_RDONLY unfortunately. Were you thinking of OBJ_GET when you refer to libbpf?

> Actually, if it may help, I could send my version of the fix I
> developed to validate the idea. I also wrote the tests.

Yes please, I have also have a WIP patch that seems to work, but I'm curious what you came up with. Tests would also be great, mine are kinda janky.

> The ability to access the path of a pinned map does not give you the
> ability to access the map itself.

I think there is a subtlety here I don't get. BPF_OBJ_GET(/sys/fs/bpf/foo) gives me an fd I can modify via syscall, no? Are you making a distinction between the inode and the bpf_map itself?

> You still need to pass
> security_bpf_map(). With SELinux, you would need a rule like:
>
> allow <ctx of subject accessing the pinned map> <ctx of the map
> creator>: bpf { map_read map_write };
>
> The inode is not passed to security_bpf_map(), so likely it is not
> taken into account for the security decision.

Ok, you're saying that a user can prevent the escalation via SELinux?

> What you say, I think it applies to map iterators. The ability to
> access the path of an iterator gives you the ability to make changes to
> the map without further checks.

How? An example would really help me, I don't know much about iterators besides that I can pin them and that open() triggers the program.

Lorenz
