Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A061224B
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ2LTD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Oct 2022 07:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2LTC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Oct 2022 07:19:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2C72FDD
        for <bpf@vger.kernel.org>; Sat, 29 Oct 2022 04:19:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 649725C00E7;
        Sat, 29 Oct 2022 07:18:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Sat, 29 Oct 2022 07:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmb.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1667042338; x=1667128738; bh=OP5fiDsWx3
        HBFZc2RFgNY8xt6MJz65zkLO7rn9/e38c=; b=6KazzNrMRHvboyYOvTsVzZfuLw
        O0Op6IoKKa93eD/CCFISu+Ta1dWw4jCQkGudHB00Dwr07JWyprVjhxF/qW7nqo5P
        rb9rpK4PgsL5jReFrJYBYUZmLofTwSx7JO/CDlQrszvKu+1+T2GXtufX5K08Avtp
        oDi9TNOFU+p/a3jmPi07ALNlFWLWTK4RN+Yss7PYb7arLs8hR8cdmQ7DQLWAQT+x
        kwh2XmhWg5vmqEXE01bu5bNSOgToUe+QnhC6Q9fjMlVK8zv5jXh2stY3IOTDAGrR
        itQ6niNqW1i52F1lbhRw1HQn4//WU27ulE6bW2/t+jFdc5zGt9o+2+YPWYtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667042338; x=1667128738; bh=OP5fiDsWx3HBFZc2RFgNY8xt6MJz
        65zkLO7rn9/e38c=; b=KdPeg7eIzUnWQdHF4fgmTko3uX6243SvcFTBBHYkz3yh
        CgSk5jbx2Fqrq4oow4WeKAZtZdod60u2hYZgkoUC+JPftkSPJKg7/fxtndZNECLC
        FzBEG2hmSEfZOhX7leEE+IyeajhRAv1nGVePg86qWFB/qvGQrhH4hPtUWJUW4OT0
        LubQSvNGI4a4NGv8FpuZHTD2KLOHr+Wpeend8XrpjDPlASP38HeN/z+IE1yH/hV/
        fGlCWdLgOcOA1HUJB6t1T0zNjvn+J9MUGivFxjNeLYxiaGTEllYhU1FJtPrHHTDU
        62i6qWYw6T1PssW1Fll799gVmgjORNdYVw5ic+uIqw==
X-ME-Sender: <xms:IQxdY6ZsiQYqiLHEBl7-6jrZHW3YwtcNlhyRwoeS_09tgxzBhFBTCg>
    <xme:IQxdY9aCHqUP-xmci3aZeJlaPyDpPKDwj1MqpJUjV4G1_Tx1ViADOPJpaFyK9jnaa
    VzhUTWB70Qf3sIuFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfnohhr
    vghniicuuegruhgvrhdfuceoohhssheslhhmsgdrihhoqeenucggtffrrghtthgvrhhnpe
    ffteegfffgffffueduiefhffeufffgleehgedtleelgefgfffgveefkeeftdffleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoshhssehlmh
    gsrdhioh
X-ME-Proxy: <xmx:IQxdY09RMuDv69VXYW4iPGazxPhsOrpIndcarVsxpMlwXJ0J9hO1fQ>
    <xmx:IQxdY8oEMWYJUbsp-ZwasYprjsvMxBeq0W3bYH49Raqv20suoAK7vQ>
    <xmx:IQxdY1pKqF-fY5Y0mGO1OR4hRp4j91w-6Il1wBdIVB__VbY6v7KP4w>
    <xmx:IgxdY-B7DZnkD8H8W7cr-bqJSs81sIhwieeJJyhEO9wO5yOQuHGh5w>
Feedback-ID: icd3146c6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E6E2E15A0092; Sat, 29 Oct 2022 07:18:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <14b9b139-732e-4013-aaa5-562f27fedb8a@app.fastmail.com>
In-Reply-To: <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
 <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
Date:   Sat, 29 Oct 2022 12:18:36 +0100
From:   "Lorenz Bauer" <oss@lmb.io>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
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

On Thu, 27 Oct 2022, at 17:54, Andrii Nakryiko wrote:
>
> So after the office hours I had an offline whiteboard discussion with
> Alexei explaining more precisely what I was proposing, and it became
> apparent that some of the things I was proposing weren't exactly
> clear, and thus people were left confused about the solution I was
> talking about. So I'll try to summarize it a bit and add some more
> specifics. Hopefully that will help, because I still believe we can
> solve this problem moving forward.

Hi Andrii,

Thanks for writing down your thoughts, that helps a lot. I have a draft
email that I wanted to finish this week, but that didn't happen, sorry.
I'll be traveling next week, so I'll circle back on this issue the week after.
I hope that is OK.

Lorenz
