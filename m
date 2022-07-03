Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D45648A7
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGCQvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiGCQvV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 12:51:21 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01256313;
        Sun,  3 Jul 2022 09:51:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 49EAE5C0080;
        Sun,  3 Jul 2022 12:51:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 12:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656867077; x=1656953477; bh=sx2V7qb2mC
        RCN2UHEL7rClCbV0gR7Cm92ibBUoYCbAQ=; b=FAfwAIBEkeB72tNGFRpBk8RMIq
        uOiIFtBsP9Eb7mopEpyG5AGahUmTJNfzbLPdec1JBL4FdFWe2chsrwETN4vSU2nr
        Kp6ECDB/I3MxU1E7VhQQMOQIwbQCTsmV85iCTp5cvl38ziT7yXMxewTbwhxIhGbK
        ST63j4MvNYb8c+J/WC5SII4i4px++HWTo6DngrJrJqmphZaA4kTRAMUYGRaClKRI
        /Z33cKXueeyw4K9+8Cp52AuuQ0D4glQcw1HHYRX2G4WJMyEtg6wjqr2dfbbZskWG
        KMfTKEy4ZJolaAnDO03WPmdOv0nAm/ugUJiS2+apAPGWYBCD8DioqwoSGrPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656867077; x=1656953477; bh=sx2V7qb2mCRCN2UHEL7rClCbV0gR
        7Cm92ibBUoYCbAQ=; b=WH93qYTh1kemwAtyxLgmRgz7tk1c/u6AUB3WqNKIlvOJ
        x0U7MGv7ZCgStUyab4qE/4EnPbMC31KfZAD65i4h3bbGStVi5BJQbVHRF5cv7vNL
        u6mhx3D1RiqLTvnBg50l9+rpJEGMr/m74Ece6lKcD0TpRMjzv3GAa8DRbAeeS1Ug
        Fb9TdsOiV2yJX6atHVyO8Lo+8x1IcSqtd+vipTQkHwNY2697XEmXz6gVbBhy6dqx
        r1Vjuvn3qOvASnkTMMD3jf5df3HlTc9XVHoFnqasRmbMK1a5e5uFv47ddUIx51t5
        s5pKHwTURbLemE46V50nvxOWjBq6iUCkWrZ859WdHA==
X-ME-Sender: <xms:BMnBYu7JDqDJhnmAyvHusSdUktdpxFvZ6IOhIfE2OCzKop6ruWUohw>
    <xme:BMnBYn7qFUPRKmPuX52OdZMQWbhkRSm6ohgv4Y4FC7jeWrbQUkzYQI4CJLX5S4Jl5
    94dPk5dORtCySAw8g>
X-ME-Received: <xmr:BMnBYtdjiqgNLbkZt7_09Isq0VEFjMxDB2gC3ueHyeE2ncSHYz4o5bTWS6d-AwEEgSneFusinPiyZxP39cn__Jztnd6SnYOIVXem0Tu0QNHZSM3GqSG7qkiAWgT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:BMnBYrIYt9lV9MEEYBnes04FW69WZJn9sgv3V8s3tMK_WKGoGkFv9g>
    <xmx:BMnBYiI0gY_gsn7NJsSiOk8jSMDtJWlULWPd12uG09iREK1FPOWKmg>
    <xmx:BMnBYsxaGDvD_RhpBpafeyBcAZ5s2pMNndKOsdqzfJyqGve1muZkNg>
    <xmx:BcnBYvASBWIMvFDYc7mJeXbpcErWVNC7SuFAyKpB1jlS8aOWD9nCGg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 12:51:16 -0400 (EDT)
Date:   Sun, 3 Jul 2022 09:51:15 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [perf-tools] Build-error in tools/perf/util/annotate.c with
 LLVM-14
Message-ID: <20220703165115.gox3hlwwdcnorcul@awork3.anarazel.de>
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
 <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
 <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-03 13:54:41 +0200, Sedat Dilek wrote:
> Andres, you have some test-cases how you verified the built perf is OK?

I ran an intentionally expensive workload, monitored it with bpftrace, then
took a perf profile. Then annotated the bpf "function" and verified it looked
the same before / after, using a perf built in a container (and thus
compiling).


Similar with bpftool, I dumped a jited program with a bpftool built with /
without the patches (inside the container using nsenter for the version
without the patches, so I could build it, using nsenter -t $pid -m -p) and
compared both the json and non-json output before / after.

V=4; nsenter -t 847325 -m -p /usr/src/linux/tools/bpf/bpftool/bpftool -j -d prog dump jited id 22 > /tmp/22.jit.json.$V; nsenter -t 847325 -m -p /usr/src/linux/tools/bpf/bpftool/bpftool -d prog dump jited id 22 > /tmp/22.jit.txt.$V

and then diffed the results.


bpf_jit_disasm was harder, because bpf_jit_enable = 2 is broken currently. So
I gathered output in a VM from an older kernel, and used bpf_jit_disasm -f ...
before / after the patches.

Greetings,

Andres Freund
