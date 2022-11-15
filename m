Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F9629E79
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiKOQH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiKOQHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:07:54 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD312D31;
        Tue, 15 Nov 2022 08:07:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B0375C0241;
        Tue, 15 Nov 2022 11:07:53 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Tue, 15 Nov 2022 11:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668528473; x=1668614873; bh=sQ+NqYLsok
        /k2pVRnPdEqQwqF/VM3gtlRE/KCxbWAQs=; b=THrBgeoDoiG0g9Rc339/+xiGwc
        Vsa297ybR2x5dNcSbuqoA2nNDf4B4wA2yyRFOragOCwmXNd+RyOl5HZQmdgxuuio
        /SxoTKVT8W8B27o818/noxTp37xLvMGma/i2/f7G6NVkCqxNm+6CO5W0LjZtoud0
        dhRPQHGgY1/iAMLjhb8yZTMjPsRJr3aEpPC4GXQeEAOyLby0YRZGxqkUXgLgI+cz
        6XrG+wJi4CTxhzgaICsTbI0spgiPWe/HK482fYkRYZ0FGf7lrD/OGt8kXDPT4CdQ
        7vtbq6/ZRGbfx4tVyfiCzKAt7SHY2H6n38ykPDMD164UMpzD3euzTAU/WdmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668528473; x=1668614873; bh=sQ+NqYLsok/k2pVRnPdEqQwqF/VM
        3gtlRE/KCxbWAQs=; b=OpMfvfL6f/wGaAQAsL+N61M+mkzd3jBeLYX+6/IyWoV3
        RGYylgcO/e1bu9QBnwb4AeRPqQI+JFFHBWV6ViCx2G8kP3FX2rQxTlmovqx6yiJ1
        KXjbsOe8J/ua6tuqTlx0qwRPHpN2Uc1lHW9kTSM0pcqdpZYHmSKdCcCspmXXH0cM
        Y4OPMXyQNZMhmAyD0PY3sBzJZC0vHQflpZ9vQXiR5psCHW6tM95xJETHal/2EiAl
        mgY29NeuZZUVYNa1u/faY8UnK3s51x3T1lFk3D0dLeaGiGraFtIr+xoiJDRs1gvv
        iqlMHlqiq5hccCbuErhmgOFpR9PwLQUZJXG6s2iuSA==
X-ME-Sender: <xms:WLlzY0rVWFRWS4vv8ZahoNLr_VjGW01amL-FPdGHIxDFwGtV-Hehmw>
    <xme:WLlzY6pooc2dSGelzY4dALe99oYWrW-TylSCICX3PbT5txf53WbtbX0pne716asSy
    CGRxqswaRfihE-cMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfnohhr
    vghniicuuegruhgvrhdfuceoohhssheslhhmsgdrihhoqeenucggtffrrghtthgvrhhnpe
    ffteegfffgffffueduiefhffeufffgleehgedtleelgefgfffgveefkeeftdffleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmh
    gsrdhioh
X-ME-Proxy: <xmx:WLlzY5Ok2nGwJXjnH2d7RKESdvZMDQSddBbZKk6J6yjxJcl7adQq2Q>
    <xmx:WLlzY76QW2AQO7SFT05naZfj_SYfnGlsSG4iV9PDntTXqcz0he9ORw>
    <xmx:WLlzYz4Zc7pb75ppvPMFXHDwb5Q-Ve0DDQQimtZaU8NkTZqJadRJUQ>
    <xmx:WblzYzHQRGqDFGgJhRmksY9WSa884Eiam4Xi5oM_mdRyt1RY4JVOPA>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3067315A0087; Tue, 15 Nov 2022 11:07:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <2be3d1a8-f9c1-43a5-9138-3a8a94fe38d7@app.fastmail.com>
In-Reply-To: <2c6203ac-de2a-607e-0589-0a69f91e0479@iogearbox.net>
References: <20221029024444.gonna.633-kees@kernel.org>
 <20221029025433.2533810-1-keescook@chromium.org>
 <CAGG=3QXYVwQ5pwARdGTenm-mDQn4Tcz6U-=EZ8BDcwBkM5bFfg@mail.gmail.com>
 <2c6203ac-de2a-607e-0589-0a69f91e0479@iogearbox.net>
Date:   Tue, 15 Nov 2022 16:07:31 +0000
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Daniel Borkmann" <daniel@iogearbox.net>,
        "Kees Cook" <keescook@chromium.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf/verifier: Fix potential memory leak in array
 reallocation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 1 Nov 2022, at 13:46, Daniel Borkmann wrote:
> [ +Lorenz ]

Thank you Kees and Daniel for fixing this!
