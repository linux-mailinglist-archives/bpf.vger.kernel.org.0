Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0C564A05
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiGCVbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGCVbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:31:06 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A65FC2;
        Sun,  3 Jul 2022 14:31:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DB7595C0061;
        Sun,  3 Jul 2022 17:31:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 17:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1656883864; x=1656970264; bh=P+eL1Ug90j
        cAif2rkt5zV/SsOFRZ2blzqg+nKXzhH5A=; b=peTEV+nkvEcmt6UExg13DKCuh2
        YjduUwNbgmKsZwNWe7ho5HaWSwbCiuj+OZ4PZm+T1nJQQ+qeuKwoargnIsSa001G
        SuCRg8Bw9hLA2I2fRbR7TMrlTsAJpp2E1sles6w+UrQ/y1bhLHdb9CjrqPU1/pUk
        U6+Oy1T/wiiE6n8bFVDYm3ahoMr4Kz1ngUKzmfU/GuRyl9hr6iEYSOkB7fomARXC
        9BEHuvVeUU1BEF3Pwa7VfxO5QFvZdFx6MLUDXDEwmWntA+2fEs0Gbyj/bj8HMn7g
        GVudNvS5eS85tLVXeN7KAf5AHH4j43RV61oRUY5i6t2v6rHOfGpu5N1f4w8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656883864; x=1656970264; bh=P+eL1Ug90jcAif2rkt5zV/SsOFRZ
        2blzqg+nKXzhH5A=; b=cx2m+KpccWVMp3NQZAfrCj1nmSBTQSyb2YK9FeLo+82M
        4/2BXTA05SG9XTe4oG/1OzmSbQsfbjnCqQXyY7wYQ1y6eu1d8UmOBTJ4SxYTukhg
        XR14nTA0b/TjLqXQmiU/+d5gX2CQ7Y4x8vTmqA/6nQRimwlt2BcbEwrDaqBW+G9i
        mmp7pUtkdpfjReZjhY8nZ046rSujKNfofg8HTE5gt8CyDgs4Ae7D+09BSRARnvXe
        XznW1UEM6HkhwMHgi0Vf5ssXcbpJsuBvD9D5iAAPmlQwQBKwS/n53Mwy63O+mL6E
        OlKHMt5KXh03ykFIXPmK+aKbfX9pUodsoOb1KLhLJQ==
X-ME-Sender: <xms:mArCYoR71A8UMLf3CaJde7BBjyQLADjE2FZpuw_X-D4SurJPOsUAGQ>
    <xme:mArCYlxLF0KQ6sC3kadYY4ZNJr2dNFBqOxkIsDbTP_glNLlrGZnmTQAG-WiyUaDeU
    KNhZINgCirjb6icBw>
X-ME-Received: <xmr:mArCYl0W0EmGlAjl6_-5D4U7jYAHNPvZPJSVGC__AExd26Ah2zVDqRvgZ-lRAx6XcAzT1OHQbsCEtmFN0aQhQ21-9P7P2VQcifoiLuc_t32e64FvlHZ_QWM_dhGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:mArCYsB_UOrtWhfLyQbEuR9lSYQTU557-7eMImdiZVlEoTf1gKfCug>
    <xmx:mArCYhipUJg40X0JKrYU1X19MGmmdId8tRjVgS8y-3EPN8CV4SSAEg>
    <xmx:mArCYoorSoU5Z8X5hARugFyvjckkrFUezWhJckmMDXjfnuzLQAcaRQ>
    <xmx:mArCYmaxE32E5Xiu8urj7Rq_S_URgaYynHO0WcWnqvOC_3yD9iASIw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 17:31:04 -0400 (EDT)
Date:   Sun, 3 Jul 2022 14:31:03 -0700
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
Message-ID: <20220703213103.n3oxmdnlyjsdrty4@awork3.anarazel.de>
References: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
 <CA+icZUW3VrDC8J4MnNb1H3nGYQggBwY4zOoaJkzSsNj7xKDvyQ@mail.gmail.com>
 <CA+icZUVcCMCGEaxytyJd_-Ur-Ey_gWyXx=tApo-SVUqbX_bhUA@mail.gmail.com>
 <CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com>
 <20220703165115.gox3hlwwdcnorcul@awork3.anarazel.de>
 <CA+icZUXCqzZgdSNyPwM+nmdTdPoZrQm2M=2DgOy7j_YHXQ1T6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXCqzZgdSNyPwM+nmdTdPoZrQm2M=2DgOy7j_YHXQ1T6w@mail.gmail.com>
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

On 2022-07-03 22:40:22 +0200, Sedat Dilek wrote:
> My test-case was to build a Linux v5.19-rc4 plus custom patches
> including your v1 patchset.

> make-line:
> 
> /home/dileks/bin/perf stat make V=1 -j4 LLVM=1 LLVM_IAS=1
> PAHOLE=/opt/pahole/bin/pahole LOCALVERSION=-1-amd64-clang
> 14-lto KBUILD_BUILD_HOST=iniza KBUILD_BUILD_USER=sedat.dilek@gmail.com
> KBUILD_BUILD_TIMESTAMP=2022-07-03 bindeb-pkg
> KDEB_PKGVERSION=5.19.0~rc4-1~bookworm+dileks1
> [...]
> Hmmm, it took a bit longer as usual.

I don't think the patches would affect the performance of this workload - I
don't know the kernel build process well, but I don't see why anything in it
would trigger bpf programs to be disassembled? I guess the additional three
feature tests can take a tiny bit of time, but...

Sent out a new version, did add you as a CC.

Greetings,

Andres Freund
