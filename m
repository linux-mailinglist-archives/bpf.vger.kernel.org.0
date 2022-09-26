Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84C5EACEC
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 18:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIZQqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIZQqV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD857BC6
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 08:35:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E76E5C005F;
        Mon, 26 Sep 2022 11:35:36 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 26 Sep 2022 11:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664206536; x=1664292936; bh=oZs0S0+eve
        01F0jRuQ92aAsVJH1bTbnYKZx/TWgd9+8=; b=EyY8QWoLRxl5Xml8n/as5c7XOF
        0SoQVj3en5d2BDoH1+gbjf77Dl9gln7Z+JgyITASj8we4F5advpOpOTsxiMf9+cI
        SLjBV3bZ4jMR+6FtnW5epF0SxRxp6/r4IPSv50NuDEQ2GBklmF0MG4+nYLKZRBjQ
        omX+6qYpEI6FzJh2RaycEh0IxqZzPFU0IuH9o235I3dx33HYPvPU+tJZ8itKBwX0
        Ymxn7pP7qcG+7ruAQ6j7LQa7y2T9q8ufLXG28JpUw0YD6eF4iSvBNYTGsKXbh4IQ
        +0bITre4Hg67BCnZGzsOfIBDRq5H3BuN1CIHsUdhk5H1M7wcAfnBBcqutkQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664206536; x=1664292936; bh=oZs0S0+eve01F0jRuQ92aAsVJH1b
        TbnYKZx/TWgd9+8=; b=qdTDLpGKMTxmFijG6qJi0n9jGZXpm1OsOoEyvnfnn/JM
        MGpWJmJCB4Tb013XWwq2Vo+G2TkNYxXYxmmVsmRtaPLvCnhgZqI3oc5ZuAEd/prd
        w14aZlbdCKVQu/gygMg+23y6OHrOUEK3AQ6xcBsklvVA3hVlM+WIsW93SJJqx7YS
        iRWh9d42DO++ke8Hsq0G4hk0QhCZClJ/6UqptfI3jLYbWsrIcQc0YG/t16MjNu/r
        EQO5zyjJBXmy9Du8o+SyMq1v8iT9/jndp9wywA6nfGZvdxcW9x35F6gN0pcpgYKE
        SOR/9PmpJfHyx68kWSJiNBVY9jzIF1S2K+DLoDTQXg==
X-ME-Sender: <xms:x8YxY-HDmT9ypeKsrJAUIPr-r679-sj7sA4EnBpaedAE3ecXLofhqg>
    <xme:x8YxY_Wo1jOnQia4Aoi6C6eJpiBkgUygPKKSaXfh34wUnd6SfX1Di_GfuvkmtwZeL
    GnwOi1ZtPu592Hsxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epudeijeetiefhgeeujedtuddvveejtdffgeetueetvddvheegjeehteejfeejfeeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:x8YxY4Jmbh2pxrO1M3kY191LQOwxImM7qO0l7PhxKrbg02Qbl1U_cg>
    <xmx:x8YxY4Hd1ThIN9ts6R28sHMAYCC8oQM09inJXRp1M5-pqDS42kOhFA>
    <xmx:x8YxY0X6QKUR91Q1gBQH-QdsG8h3BYrm1TSAEFuKeuUFfrKaxXD_ow>
    <xmx:yMYxY-emt0pqrL2pEPkC4UTrm4SK_gCd4lq6aDXN6DTK2ztPXhHq7g>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9062D15A0087; Mon, 26 Sep 2022 11:35:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
In-Reply-To: <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
 <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
 <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
Date:   Mon, 26 Sep 2022 16:35:09 +0100
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On Fri, 23 Sep 2022, at 08:39, Roberto Sassu wrote:
>> Yes please, I have also have a WIP patch that seems to work, but I'm
>> curious what you came up with. Tests would also be great, mine are
>> kinda janky.
>
> Ok.

Hi Roberto,

Did you get around to putting your patches somewhere?

> If you have write access to /sys/fs/bpf/foo, it does not mean that you
> will have write access to the map, when you call OBJ_GET(). I don't
> know if you could add more modes after getting a fd.

Well, that's kind of how it works at the moment. Write on the file gives write on the FD, and BPF_F_RDONLY, etc. can be passed to OBJ_GET to change that. You're proposing to change that?
 
>> Ok, you're saying that a user can prevent the escalation via SELinux?
>
> Not only with SELinux, but with an eBPF program too (BPF LSM). What I
> wanted to do is to deny write access to anyone except the eBPF program
> that declares the map.

There is no "ownership" of a map as far as I can tell. How would you figure out which program declared the map?

Maybe it's best not to focus on SELinux / LSM too much: this stuff should work correctly out of the box, without needing workarounds from the user.

> I wrote an example here:
>
> https://lore.kernel.org/bpf/8d7a713e500b5e3fce93e4c5c7b8841eb6dd28e4.camel@huaweicloud.com/

That was very helpful. Yes, map iterators semantics are also broken, just like program fds and link fds. I started with maps since that seemed easier to tackle than everything all at once.
