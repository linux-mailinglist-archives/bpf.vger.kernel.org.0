Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1B55ED842
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI1IxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiI1IxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 04:53:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0409A698
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 01:53:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 74DDA3200923;
        Wed, 28 Sep 2022 04:53:13 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Wed, 28 Sep 2022 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664355192; x=1664441592; bh=S6l92pi0CV
        M8EcEGexpIFmwZftDYc2Zueb4eiNNggG8=; b=Ud25dD5CkX0wE7FRJnjrh+YFOp
        MfhbZTbj/JuXykzq8Yw61r/UE/pAAj4sv4GM/xnTBkfJmZ8IsbR+9JX/Ze3zy8tT
        YCndwqmM4uzCOZyRBkYm+l0QGZ3YR+0fS8rbkwHEZivDrqouEvDrmPAr2vYhDAsU
        lovP0SsMo7+lA9ya7CnAG7ohemp/YPQAdE4hnHelbprTVlEkaRpt9m6RtWqNDB7W
        b1B/YYw9Gi/USrmL/cSs8fj8yXcuDrvVDYytOxc+W0ls2SoFVR9CE87uKNGJivqq
        CZsrL1DdaShd0pDszEvrC4Sj+x6NFZ9PV5YxjgbRNZcwX+TOuovERhWK+V8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664355192; x=1664441592; bh=S6l92pi0CVM8EcEGexpIFmwZftDY
        c2Zueb4eiNNggG8=; b=bKtrJQuSP9CzegVAVWfFe+kk3X77TbarDjh9aLdo6Hv+
        g/lALMaY3sNjLa3ukCj6+QPSaxdl2iIKd07oqLO9D6WiOHgH9/IShG+7sBVn55R3
        vzJkOTnZtKNkYyqkfXV7/DpvMKb5QX6YadvjLLq6jVU0fYfjyhX8WOgjOODFBbds
        LbBrShxoqznXG4GiKnu0TPjXAt9b2GDQC/KYoCFDl2k1Ki8mpbngw1SrESDjeGCf
        e8em8FxQ03H3KAp70brO28QATqCAclgaTChESQNPxeFzu+S2kvsjr65m/tgxmcqR
        RYaLHsb2ytn3eXzaLygp13BU4YQ0QGqjYxRi8DKQpQ==
X-ME-Sender: <xms:eAs0Y72ZlwFyfxCUcOL6lzOdXY1rF1uWUaEArf4ZNaeGinupTlnp3g>
    <xme:eAs0Y6Ff3sntxV0E7wpIGX1xQBuPcIheTkl0IaC1KtLAN6dC8aixeZ6LROCPk2Gia
    5TBqlgfU3vnuow7jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfnfho
    rhgvnhiiuceurghuvghrfdcuoehoshhssehlmhgsrdhioheqnecuggftrfgrthhtvghrnh
    epffetgeffgfffffeuudeihfffueffgfelheegtdelleeggfffgfevfeekfedtffelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhssheslh
    hmsgdrihho
X-ME-Proxy: <xmx:eAs0Y761ZXvI9VZxJAmZZvzd4QNGHcNX9tpD9pur-ur4hH5qmUWM_g>
    <xmx:eAs0Yw2Con9R74OZzjXcheizz9JRoCNjrj9Vv_hsG6oGjEVFD9YJHw>
    <xmx:eAs0Y-HRSL-i9UhIl5wDyF8y453mz6xmMeh1sErUV157UAaPgxnoYw>
    <xmx:eAs0Y7PlNLwk9V3sEtzOjiP-vP5ewhkUP9TiwuUMWklfgaUS4r69VA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9EA2315A0087; Wed, 28 Sep 2022 04:53:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <439dd1e5-71b8-49ed-8268-02b3428a55a4@www.fastmail.com>
In-Reply-To: <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <8e243ad132ecf2885fc65c33c7793f0703937890.camel@huaweicloud.com>
 <7f7c3337-74f1-424e-a14d-578c4c7ee2fe@www.fastmail.com>
 <65546f56be138ab326544b7b2e59bb3175ec884a.camel@huaweicloud.com>
 <b0c00f80-c11e-4f5d-ba63-2e9fb7cad561@www.fastmail.com>
 <9aba20351924aa0d82d258205030ad4f2c404de2.camel@huaweicloud.com>
 <98a26e5c-d44f-4e65-8186-c4e94918daa1@www.fastmail.com>
 <06a47f11778ca9d074c815e57dc1c75d073b3a85.camel@huaweicloud.com>
Date:   Wed, 28 Sep 2022 09:52:52 +0100
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

On Mon, 26 Sep 2022, at 17:18, Roberto Sassu wrote:
>
> Uhm, if I get what you mean, you would like to add DAC controls to the
> pinned map to decide if you can get a fd and with which modes.
>
> The problem I see is that a map exists regardless of the pinned path
> (just by ID).

Can you spell this out for me? I imagine you're talking about MAP_GET_FD_BY_ID, but that is CAP_SYS_ADMIN only, right? Not great maybe, but no gaping hole IMO.

> DAC information should be rather added to the map object
> itself.

There is a form of DAC on the map, BPF_F_RDONLY_PROG and friends. You just can't stuff BPF_F_RDONLY in there since multiple fds may refer to the same map with different permissions.
