Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409E5E6645
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiIVO5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 10:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIVO5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 10:57:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA4E21E2
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 07:57:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BE7043200919;
        Thu, 22 Sep 2022 10:57:50 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Thu, 22 Sep 2022 10:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663858670; x=1663945070; bh=2yPKv3X/xk
        I1sw59vd6GDUlO+wWIohwc3sFTqnzzd0M=; b=XAljxWxHjCUfkQQLcElEhzKRSb
        H3vWbLzgnUmc+QKVHFePiocBZQ211btItmAjx5h+xRlQNxAXWUhNADpQf5R+UnI2
        GWA6ZQLeXJb7h7zUiqV73h/tv/Qryb+wVYx+ahDMJGzY6SkXx8hVEZ71nlHzoVy8
        Iln36BOmyu6vOeQpjve8NG8Nq9Ue826z1RF/OSoZ9CqmD7ZHhL3nw4UC63hv95Qd
        kbXfbJ8opEMwk9LifTWTjrhCmvtfd2Plti1ECktfcWu1NOh03X2sq+usuyM9mFnb
        Ke6a8qLOUBjYxAvr8jNQuKcnsNDNw3NftPlTy7sh1EfL9AaslBLNrKb09AXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663858670; x=1663945070; bh=2yPKv3X/xkI1sw59vd6GDUlO+wWI
        ohwc3sFTqnzzd0M=; b=i7/srPyGS5KdPlAZhznyG1ZUjC7syZFk9sbXR03LJBjJ
        RA53WauajILSImL+gwiph22chpgWThak+HI9IlGVadsOgZzL8xJveWFhqrilUGsf
        /Zn8HIw88g71NReQalRONHrJz0F9NgW8nlD3qWk0q7kqYLe2u0V8KaMo8nFRhxuI
        5x0dzePs7hTWkmpVjBNPpDPGNi0wyDVEEClzPa2XONBARrMESmqo+R1tzXEko07m
        k7BGFfCUzs5ELhZGDOfCcW+MuyewF1gJXfsQ1uKi1gH6noM4q+8/Ph2tGqauacea
        g7vmG7rkl9CHIKTNBWRR1fIlHBV73GbpXXUWa1hcsw==
X-ME-Sender: <xms:7ncsY_5kCO1KM0cA0MGa98oah7itD9TG5NnhuEpS6IldxIRemgi8yQ>
    <xme:7ncsY05QbR2COHshPSSmUOfy0TPvFQCxSDbz9NrvCAWsUgOboe_o-uPnYRwjz4n9L
    PAG0ASDjVN2MupruQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epudeijeetiefhgeeujedtuddvveejtdffgeetueetvddvheegjeehteejfeejfeeknecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmhgsrdhioh
X-ME-Proxy: <xmx:7ncsY2ed-WDoGCHYAhVxEYzoZZL_Ru2zd2ufuv-FHSjwXq72q6iTMQ>
    <xmx:7ncsYwL7iT9Cuyy_XhSWjA52ByM_gU1Ua3bTF-aTa_xGEqhIjqo1JA>
    <xmx:7ncsYzJwX2PAQf_gN3W6DCfE-HnAE3jDtREU_--wW0cdNGf7zOeIBw>
    <xmx:7ncsY78Fce5yuJJhK773Vsug6ATOQadBv5aBqN7eziqGQAm5ty3klw>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1E09715A0087; Thu, 22 Sep 2022 10:57:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <4cfbd3ec-13c5-47e2-9c06-b3b8ece8f257@www.fastmail.com>
In-Reply-To: <CAP01T76fv-qpBsEp8CJbg6FzcbKAWPRq+cDoNCWhcaTJvuNyxg@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <CAP01T76fv-qpBsEp8CJbg6FzcbKAWPRq+cDoNCWhcaTJvuNyxg@mail.gmail.com>
Date:   Thu, 22 Sep 2022 15:57:28 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc:     "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>, bpf@vger.kernel.org,
        luto@kernel.org
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

On Fri, 16 Sep 2022, at 04:03, Kumar Kartikeya Dwivedi wrote:
> Just for completeness, this was also pointed out by Andy back in 2019:
> https://lore.kernel.org/bpf/CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com

Thanks for that link, it's sad that the discussion got bogged down, it would've been great to fix this back then. For reference, Andy came up with the same proposed fix to require R/W when pinning:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=bpf/perms&id=3a5ddc41c25e00e8590f6da414bcf0ed7626ffe1

The following also seems relevant / desirable: https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=bpf/perms&id=3bb110117c983f781f545e69ce35d4fcdd0c543b
