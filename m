Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A55648AD
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiGCQyv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiGCQyu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 12:54:50 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B676318;
        Sun,  3 Jul 2022 09:54:50 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A5E655C0095;
        Sun,  3 Jul 2022 12:54:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 12:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656867289; x=1656953689; bh=3ltIySwpqZ
        RwAe1IfAwY0jDdcMGav0coe6/K+BE81BM=; b=TnpEYX9PlEB8yfchOtozFoBEnr
        KxKBxmVxz2v2x4h5LWsyIR3ClVq+Q7hbUZYlFhdoC21HsSH0OGvVnM4Wsnad2mwm
        tsgfVES/dtrinGTTj0T5mrEHAu+ic5t+yA13BrvmeeyKnWSTcTIBrS6NaJadUku8
        sm+El6gNwhFhgQhcY7u2L23ofhF32tTIzJuXOrWXSviTxbG3L9unmBBsni5nx49/
        M3lZGHuxk6yMOT4MEQ2QLWn4aMltSFk2FR++3Qyw3reqMjUvXo+7FW+ZeXdcbZt2
        h7wQHTHru4F/cPXlKIMuTurPPsfm4hGd3F0lRoQj/FbsNIy7RelmP9joKU6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656867289; x=1656953689; bh=3ltIySwpqZRwAe1IfAwY0jDdcMGa
        v0coe6/K+BE81BM=; b=mauml8Y4piqJfl2CF5VivTT9uq4enas42nhnhp7HqUkE
        m2Pv9ogU+53DepQV/tx0+D2ngpAdVww5aN2gLV0LiKDX9jEZMKmcvjHFnPXcZy1G
        b2xsGuaYtLdzWYNXpF23ITwMGmNEVldyC79bEl0RUqjjm3Y7ixKrrDQyRgbTt2Fe
        Oq9QHbGEmOTMrlEMJCZ9f1V8VZ7GQyxIK0XV3WpwuNzW+4gDUiMn4UDtxeFYY3kg
        /SGHuUMag6QC+73yeRuG+Ml/eK02C7T1y4w5tg78klCJZoVWxyHEiU7lRTJDJO+c
        10MxwA4qU5qOTmNjFLZH2wX+kor0LpVzsm3qS+aw1g==
X-ME-Sender: <xms:2cnBYins9AoTF5zKEAsvlj8avcNtQPnzSfpeWAqdkwBHCCGYJddrMg>
    <xme:2cnBYp1_N0JbTiLlWGfmTP5BAVtAII-n0sL_D0ucNOsjXP3ANe9Mf_f4uyGgVCvL1
    O1hE44QOkIh5xP_oQ>
X-ME-Received: <xmr:2cnBYgq8ZNB_0tyP2LOfKuUiyXJsGNcdIGxEZVVYdECFCqkmfips8B8K0Lljxe6BxTPL6cubykmXInChuc60921F0CuhlLUfVx33EnICBYxggRnXZ-lSTCcRML89>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:2cnBYml48IXug4gjRTZtZC6M6U0qiqoLMsE8HMira8Ac7TSgbHvDug>
    <xmx:2cnBYg1foV4BaL-_sC6Fzom7hkgzwY3OJqdA9gkBzV_7SDlLUY_bbA>
    <xmx:2cnBYtvC_awlok0CVivyK37trv0NxIz7HojBkE9F1aonZ5uXt8ITww>
    <xmx:2cnBYltCxpH_SoNgzrCQIu8XjT7ZG3MPFgtKb57Uv_UTywvfD-e_RQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 12:54:49 -0400 (EDT)
Date:   Sun, 3 Jul 2022 09:54:48 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     sedat.dilek@gmail.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20220703165448.7d2akxawzdvqigat@awork3.anarazel.de>
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
 <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
 <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
 <1496A989-23D2-474D-B941-BA2D74761A7E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496A989-23D2-474D-B941-BA2D74761A7E@gmail.com>
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

On 2022-07-03 10:54:45 -0300, Arnaldo Carvalho de Melo wrote:
> That series should be split a bit further, so that the
> new features test is in a separate patch, i.e. I don't process bpftool patches, but can process the feature test and the tools/perf part.

Ok, will split it further. Should I do

1) feature test
2) introduce compat header header
3) use feature test, use header in perf/
4) use feature test, use header in bpf/

Or should 3, 4 be split to separately introduce the feature test and use of
the compat header?

Greetings,

Andres Freund
