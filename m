Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7155ED847
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiI1Iy4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiI1Iyw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:54:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56454622B
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:54:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A2AFD320077A;
        Wed, 28 Sep 2022 04:54:48 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Wed, 28 Sep 2022 04:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664355288; x=1664441688; bh=9GGgg6PRtv
        MmbF/7cc0xcm2PQeKwnsmF7N7R9di2/zc=; b=iCPywc7Xx+7uB9gqjKw1B593XA
        PysIH1bXYaLdBZhxdHw21JNfErOh8Ncl0wS7SZcnvJH912fmpcdaWNw59lTbYn+u
        KA2E5QDil/hleH37M72DjtVrFZHpRJlXswNaFY7z56cEoEylbrMoTTplgWtb4h10
        5cpqmi6u64tcVXY2MTFDW1PvXUcP4r5Aq5RpXxpC5ks9w7MzqTrVpQ4SKABPAL7N
        FLLlxB7D+yuxkPliPIb4CZ8ERhegJXjrVMqM1aIB3UGIyXlkz4HJjsFNy601uF0r
        8kYNE+y9KU+7khwJx6nvFpwhGI7A4GgSMemX5Slu2+fbRaS/igr3KfbEM4UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664355288; x=1664441688; bh=9GGgg6PRtvMmbF/7cc0xcm2PQeKw
        nsmF7N7R9di2/zc=; b=YHhsxuaceAulwzt+ptYvUL+syFxMgI0wVfUCMxSqQN8q
        mIwZIZByNVEWgk/3TYZotjUDC2KYnNQqTt4nWcstxi1JZhxcA76nGpX5TWNVyYVE
        Pt74xJ75JeGl9beFUAV+j0dHPsw85RFggVIDmuXGUC1LaJhB/N0GR26RSODNiUqC
        ZgQLTdizqYPTbs1TQYRXehLBHNYqWV0IGw4W4PxQbf8l1vfNgsfaD9vxvRm19hi2
        PavfyvZP6d9lO0V6KmlLQCiqRxRhWveBOkZdHftKUnMOi6+8RNUkPu+1I8vJGHsQ
        t6zuzZaGqmGqwtzfFDQgj/l3Vlvv73iKa5afqCDFVQ==
X-ME-Sender: <xms:2As0Y-OBlGbCYv6Cu7AibWwRd6Y-Ac1mSnIkrjEutcluyXYXIRtMSA>
    <xme:2As0Y89bJ_mn-4HpLEZjzAUN0hVyDBTcE7oS3QDimoQJENThfM22CMA5NCCXla5d1
    GEpbopWpilLJvjfEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfnfhorhgvnhiiuceurghuvghrfdcuoehosh
    hssehlmhgsrdhioheqnecuggftrfgrthhtvghrnheptdelhffgvedvgeelleetudekheej
    tedutedutdevkefgieejffehffffhfetvefgnecuffhomhgrihhnpehgohhoghhlvgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeho
    shhssehlmhgsrdhioh
X-ME-Proxy: <xmx:2As0Y1Rpco79-GpFhvfCnzTTBQPqKp5UGMCTEQWg9Ia-iDJajumz6A>
    <xmx:2As0Y-u8q6dnYuqMXLtYjSvNHRPZP6ATa2i4q6HL8fkLucM_sZrDVw>
    <xmx:2As0Y2dWwt5DFCCsjedDlTBBfqkcnAQhtbw12pY-ThIGmKM-Ok78CA>
    <xmx:2As0Y17Y3HsG0bf1aLu2bGjU0C0vCHj0VMguQGSnte9TkYb4vw3JLg>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDC7515A0087; Wed, 28 Sep 2022 04:54:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
In-Reply-To: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
Date:   Wed, 28 Sep 2022 09:54:27 +0100
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

I've put this topic on the agenda of the 2022-10-06 BPF office hours to get some maintainer attention. Details are here: https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit

Best
