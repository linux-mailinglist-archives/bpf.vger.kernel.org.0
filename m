Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25C67F31D
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjA1AYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjA1AYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:24:43 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C46114
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:24:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AAC4E32005D8;
        Fri, 27 Jan 2023 19:21:34 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Fri, 27 Jan 2023 19:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674865294; x=1674951694; bh=VyAzUiJGfn
        nw5rxeobzFIgzhwaO/aq4YJ94GIAazgKo=; b=kt1r9VEL10jnz8zpYn/6mxcSTQ
        3pbPztjMVRrT2Vr/Y3cDUbyoJG7iYksfqP7PYO9rKPq+UGB+Z+T+r00Dx5lU9j7q
        7DISbFp0JXVQpZsa0Cgtvh6ciCPOgnTabE+ZzAjwV3a9mvLH/n2CM0kK9ToYDAkq
        ishmD5kITIwSDI/KSYcJMR1tPWhNlYIxCvAinWkHFKAzhZoLtJA/SaI/H84VjQju
        3lh60rXpy6VJOMCHd41FfpmgCEyihQRCDZ41VKNLhqeBmTNYCBloylGyUC5yIJbW
        vvuC3R1gxpCl3VX5U5kEwW3G+LVlXm6RtosKPlPCkGkHN0FYaU/CFlPQ2Nqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674865294; x=1674951694; bh=VyAzUiJGfnnw5rxeobzFIgzhwaO/
        aq4YJ94GIAazgKo=; b=shjuq3eB8DpMLH4wQyULS5r45PZTt8b3M/acK5H1yUJH
        IKGWQTPnWEdb5wEHBKFzSrexb0LGguu+uRIhl5/vMp9RJhPQ8uul8xBBZ71Y8R0J
        ynoonSKjG9+Nm6xdy92JzDwcav3kUjNi1RXz2CAWxMKAsE1aZeSXdo2wWYZDrW22
        WefZL5+MbUmg6QKDbH1EDIJNazOnilqCVA/kTvBEhwiA3jTgE5QaJz0Y1cjOSCZB
        0TaQdjvHLFzcGHQa58Of/vLtdskAtmrNmzgtT1N8YK7J+1nnZlJr83WVzdqfE/u8
        +P5WJJPWwEP3YJxss51eJPCOH50cUuO42RVuSEutOQ==
X-ME-Sender: <xms:jWrUY3ZzO9ze2DrCKav5M_DI10ONcOfctt282K_TFAdE6IYT19eutg>
    <xme:jWrUY2ZJyjsJkRLuopBZ6pENFole1g6N6SfUXTt5JMkznwuQsuu7OAtfJJMjUaTls
    YaaOI46bFvbn7koQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeetleffffehgfeigfetleeuteehfeetleduudffleet
    vdfgudejjedvhfejgfduveenucffohhmrghinhepkhgrlhhlshihmhhsuddrshgrshdpkh
    grlhhlshihmhhsvddrshgrshdpkhgrlhhlshihmhhsfedrshgrshdpvhhmthgvshhtrdhs
    hhdpugiguhhuuhdrgiihiienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:jmrUY588e0jJAlBFmkDpZxkGjQOouShFRIKsKfuEVTLNPZjJyYHCXw>
    <xmx:jmrUY9oVZ56z53mIz9mrg3nlQPdpO962j80gCpw9RWv11GA5eIllzg>
    <xmx:jmrUYyruwXzzaXT7BfOHyP9gReaDv-SXEh08mL4MpWYIq-9pyJJxNQ>
    <xmx:jmrUY3BCtRtVBezOiExrVUyHeTNLAtmL62rPZDGoy96mftDay3C-Pw>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAE64BC0078; Fri, 27 Jan 2023 19:21:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <070e7661-8b19-417f-8e16-8ccc34d6c7bc@app.fastmail.com>
In-Reply-To: <Y9RlpyV5JPz/hk1K@krava>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com> <Y9RlpyV5JPz/hk1K@krava>
Date:   Fri, 27 Jan 2023 17:21:13 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Jiri Olsa" <olsajiri@gmail.com>,
        "Alexandre Peixoto Ferreira" <alexandref75@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jiri & Alexandre,

On Fri, Jan 27, 2023, at 5:00 PM, Jiri Olsa wrote:
> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>> 
>> 
>> On 1/24/23 00:13, Daniel Xu wrote:
>> > Hi Jiri,
>> > 
>> > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>> > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>> > > > Hi,
>> > > > 
>> > > > I'm getting the following error during build:
>> > > > 
>> > > >          $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>> > > >          [...]
>> > > >            BTF     .btf.vmlinux.bin.o
>> > > >          btf_encoder__encode: btf__dedup failed!
>> > > >          Failed to encode BTF
>> > > >            LD      .tmp_vmlinux.kallsyms1
>> > > >            NM      .tmp_vmlinux.kallsyms1.syms
>> > > >            KSYMS   .tmp_vmlinux.kallsyms1.S
>> > > >            AS      .tmp_vmlinux.kallsyms1.S
>> > > >            LD      .tmp_vmlinux.kallsyms2
>> > > >            NM      .tmp_vmlinux.kallsyms2.syms
>> > > >            KSYMS   .tmp_vmlinux.kallsyms2.S
>> > > >            AS      .tmp_vmlinux.kallsyms2.S
>> > > >            LD      .tmp_vmlinux.kallsyms3
>> > > >            NM      .tmp_vmlinux.kallsyms3.syms
>> > > >            KSYMS   .tmp_vmlinux.kallsyms3.S
>> > > >            AS      .tmp_vmlinux.kallsyms3.S
>> > > >            LD      vmlinux
>> > > >            BTFIDS  vmlinux
>> > > >          FAILED: load BTF from vmlinux: No such file or directory
>> > > >          make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>> > > >          make[1]: *** Deleting file 'vmlinux'
>> > > >          make: *** [Makefile:1264: vmlinux] Error 2
>> > > > 
>> > > > This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>> > > > (2241ab53cb).
>> > > > 
>> > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>> > > > upstream pahole on master (02d67c5176) and upstream pahole on
>> > > > next (2ca56f4c6f659).
>> > > > 
>> > > > Of the above 6 combinations, I think I've tried all of them (maybe
>> > > > missing 1 or 2).
>> > > > 
>> > > > Looks like GCC got updated recently on my machine, so perhaps
>> > > > it's related?
>> > > > 
>> > > >          CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>> > > > 
>> > > > I'll try some debugging, but just wanted to report it first.
>> > > hi,
>> > > I can't reproduce that.. can you reproduce it outside vmtest.sh?
>> > > 
>> > > there will be lot of output with patch below, but could contain
>> > > some more error output
>> > Thanks for the hints. Doing a regular build outside of vmtest.sh
>> > seems to work ok. So maybe it's a difference in the build config.
>> > 
>> > I'll put a little more time into debugging to see if it goes anywhere.
>> > But I'll have to get back to the regularly scheduled programming
>> > soon.
>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>> in pahole when CONFIG_X86_KERNEL_IBT is set.
>
> could you plese attach your config and the build error?
> I can't reproduce that

I've confirmed that CONFIG_X86_KERNEL_IBT=n fixes my issue as well.

Here is the config that produces my originally reported error:
https://pastes.dxuuu.xyz/wlg9tb

Thanks,
Daniel

