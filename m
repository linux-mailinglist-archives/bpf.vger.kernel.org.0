Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7D58DCC6
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbiHIRGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbiHIRGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:06:08 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1F501114D
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:06:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id AD94C2B05ED3;
        Tue,  9 Aug 2022 13:00:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 09 Aug 2022 13:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660064436; x=1660071636; bh=3abss+CoOK
        3R89WSKxwqP2TXwiB32/7eSMUhPqbISCk=; b=XaejAeLV6YtYoP1m1vp3sV6Mvm
        ZdnaCdwijII0HCmg7+V2+zSm+cbxWQN+hjTZMwOsFOnhZLoaOadd/hCKY8l2KKSA
        r2zbfCV1TVF1YC4r0Ot1XIf6DtwvplgIyZ9a6lansDZdyUhaLdqFEBaR2XZk9OXW
        QW6yvyWNlqAhL/iPjWGTsEgHT67PsNu6H3PUbT7YqH6r5Cb3z3tsNgiHeTTO+QOU
        KGfidGiu8bhPbMIkXB6lbjww7eRM4ZzM4L51Sd4WCjxXha8iHuU5Z8N5+5z4G/Gd
        VJYlL+AqgIiwkf1IyXmrq03QG1RmAG5gIvgpHas3+vPGqRicFTICI5SFyEWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660064436; x=1660071636; bh=3abss+CoOK3R89WSKxwqP2TXwiB3
        2/7eSMUhPqbISCk=; b=jx5UKs5FR/5TTUMznqXpar493S9pJtqfEXAu+xPgH7Hf
        MzMI2fmjfNSSorTuQHDBOBldR4iyWi0p20MDIXC1elsESVPfa4pS1EdCE0j+H4Rk
        e83VFx5gzYbW8/ak76uyvnrrbUXBWp+2tuwkhWOkZTyolK3/2SHT0TJG/IOI0Z+y
        /YK0Jt7QjO3Yt252jTHOQ6lDu/aZXczZQV54hXVol7tZtwr4H2xYc4shrZmhnktB
        FnOhqT/KWn9asDcS/w6iCF1+uDFgO+eHst6lNEF3oab5C4Sc3BBNEduWRHLfJ3tN
        FMNN0vMmuJia78raFkiuEvS/OZaOEnCoDMZCvT3eqw==
X-ME-Sender: <xms:s5LyYiEDWpP3XIu1fhZ7hW2j1tEJ9_YahHqQaupFDOfN-OgJzL7zeg>
    <xme:s5LyYjUXhWR0e-TA6b-8eUOKkaSSkT6nQqy5uYmdthUlVQ-argdBUNO1bQ92khVDI
    8w2xl-r8ydMOzLoWg>
X-ME-Received: <xmr:s5LyYsLXwLEh-ECGcXC1Ahw1aqBqsTEkFHtD7D0JuYwT7If1v9FZ6DQzDGHecyB1KekGFvrIqjOH2ZjdOv3icxrhSfwu5RcPqwtxDRP_1OxcMTTg7YTwTY0ZCkjX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:s5LyYsGVr1iRxg22r1viLNcxnBb__ip5V9s1GtYOV80LXV1M2lI-0w>
    <xmx:s5LyYoXtfSskZTRfN8-H9DAnAI6bCPEWjHlCk_nUNBRQki44lyRM8Q>
    <xmx:s5LyYvM7hnV60DWPFPbU4RyAdGKRHlSYcm8b5g9E3puupVDX2nWwYQ>
    <xmx:tJLyYjae09X7G4eUbzBHqTzlMX2xyFBOc1WqctEKF7viDjE_x0rHQYLR4RY>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 13:00:35 -0400 (EDT)
Date:   Tue, 9 Aug 2022 10:00:34 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>, quentin@isovalent.com,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, peterz@infradead.org, mingo@redhat.com,
        terrelln@fb.com, nathan@kernel.org, ndesaulniers@google.com,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
Message-ID: <20220809170034.hx7fyiosm3tfekwf@awork3.anarazel.de>
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
 <20220719170555.2576993-4-roberto.sassu@huawei.com>
 <5f867295-10d2-0085-d1dc-051f56e7136a@iogearbox.net>
 <YvFW/kBL6YA3Tlnc@kernel.org>
 <YvJ6DbzBNsAgNZS4@kernel.org>
 <YvJ7awkCVBYaZ2dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ7awkCVBYaZ2dd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-08-09 12:21:15 -0300, Arnaldo Carvalho de Melo wrote:
> So I backtracked, the way it works needs further consideration with
> regard to the patchkit from Andres, that is already upstream, so it
> would be good for Roberto to take a look at what is in torvalds/master
> now and see if we have to removed that styled thing from Andres.

Why would it have to be removed - seems to be fairly independent, leaving the
line conflicts aside? Or do you just mean folding it into one-big-test? If so,
that'd make sense, although I'm not sure how ready the infrastructure


FWIW, if I would have to maintain these, I'd probably change FEATURE_TESTS,
FEATURE_DISPLAY into one-item-per-line to make conflicts less common and
easier to resolve.


> Andres, if you could take a look at Roberto's patchkit as well that
> would be great.

I briefly scanned it, and the only real comment I have mirror's Quentin's,
namely that it'd be nice to avoid displaying more tests that don't tell the
user much.

Greetings,

Andres Freund
