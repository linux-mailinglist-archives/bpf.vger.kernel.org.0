Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD567713C
	for <lists+bpf@lfdr.de>; Sun, 22 Jan 2023 18:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjAVRtU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Jan 2023 12:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAVRtU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Jan 2023 12:49:20 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF414238
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 09:49:15 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EFBCB32004ED;
        Sun, 22 Jan 2023 12:49:12 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Sun, 22 Jan 2023 12:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1674409752; x=1674496152; bh=MhZ2hrgRGurIG+i72LZaS7kSnItrmyAEtxX
        neDjzaYo=; b=QNPrhkpQ4qrzRWLdrD9xlNPkaKFOLVQGK0O8VDxL2TUICBZnw95
        vRraKoBWIc8SX9fLC6WZepLdFasTEfaUcvLSlr5WZeFxgh5lh2YMl2qz1YzR5or1
        Xi+R+/62NnwUtwXOg/pltlstsB0ZZDbOc9Nw47TEZFU9bu5pItX1vftbrKsjF37H
        fcbkVnw/Ch33GSnPKLl5APzt7kzJt/lXCDcpyW3DYEUv1j6cCz6hTGFe6f5bTDYK
        olkehKinpbbzfidIb3IEjIJPZuo0nM710SrRZqrsXhJ8aFewy3hZxsUDmwmWKfHp
        IoD+6aAQK1HSqdJ38shwV83QiwWfSx5V5ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674409752; x=
        1674496152; bh=MhZ2hrgRGurIG+i72LZaS7kSnItrmyAEtxXneDjzaYo=; b=X
        ymO8xvGbbdP+C1BcvaBxN+22r+OauC45v2Wihx9Au/UWKzhfw/hd5wL1k67Q9FCY
        TfMW5y9GoawO7L/OS5gxSIEsSzQ2WXvzGtKGJV5v6qaw3QyNuFo7v7BVdwen/1GD
        zlIK71y0+gm/mPLMuinr4Q4nicxbNKAMv6enqapwBS1Etdv4zObESvT9ZTAyIbtu
        6lgY2xphHTe5k/Vw7A+vXnhf5VtFNmzDqZzr1hv5vCJszkoEzIjda2ilZ8n1lJtP
        g0dgslnqNtnTiBz+RMF4s7YQR8TRNKdmCbhjTrg0AERDvjQYARnhswDbtN/M4vji
        gXQ4LBf1NzzxeUpRWP2hw==
X-ME-Sender: <xms:GHfNYwBb7ne_iV9qhaeLwnhnkuMDRO0JK2gqY9rYBnjCKE_eR-ff3g>
    <xme:GHfNYyjbNGIeytODCen7j8Dddp493lHzuyS_iI1pYLxwkJhf1LhKGiFzW98f4ET6K
    uEG2WqR-u0qUehJHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepof
    gfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgiuhdf
    uceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepuddtudfgjeevtd
    eftdevtdffheffudelueegfedtfefhvdevgfevteekudeihfefnecuffhomhgrihhnpehk
    rghllhhshihmshdurdhsrghspdhkrghllhhshihmshdvrdhsrghspdhkrghllhhshihmsh
    efrdhsrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:GHfNYzmYp_1_EV_8dDSFOxBGdTd9Noytsqhg88Lf7N1l3KBVDA3Qog>
    <xmx:GHfNY2xyjprNEFx6NNx-uMG6BoGtnWpfCZc_DyjZUyeYXKqNC3P5bw>
    <xmx:GHfNY1SERyndCr6xJ3ckPbbn4JqZc_Z9hiykqgqA1MmTwMVFnTbPbQ>
    <xmx:GHfNYwNLenHQf-f-3O6xQKRQVbKJXUrArbc27qDa0-VC1rFdlxeVTg>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4150ABC0078; Sun, 22 Jan 2023 12:49:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
Date:   Sun, 22 Jan 2023 10:48:44 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Type: text/plain
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'm getting the following error during build:

        $ ./tools/testing/selftests/bpf/vmtest.sh -j30
        [...]
          BTF     .btf.vmlinux.bin.o
        btf_encoder__encode: btf__dedup failed!
        Failed to encode BTF
          LD      .tmp_vmlinux.kallsyms1
          NM      .tmp_vmlinux.kallsyms1.syms
          KSYMS   .tmp_vmlinux.kallsyms1.S
          AS      .tmp_vmlinux.kallsyms1.S
          LD      .tmp_vmlinux.kallsyms2
          NM      .tmp_vmlinux.kallsyms2.syms
          KSYMS   .tmp_vmlinux.kallsyms2.S
          AS      .tmp_vmlinux.kallsyms2.S
          LD      .tmp_vmlinux.kallsyms3
          NM      .tmp_vmlinux.kallsyms3.syms
          KSYMS   .tmp_vmlinux.kallsyms3.S
          AS      .tmp_vmlinux.kallsyms3.S
          LD      vmlinux
          BTFIDS  vmlinux
        FAILED: load BTF from vmlinux: No such file or directory
        make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
        make[1]: *** Deleting file 'vmlinux'
        make: *** [Makefile:1264: vmlinux] Error 2

This happens on both bpf-next/master (84150795a49) and 6.2-rc5
(2241ab53cb).

I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
upstream pahole on master (02d67c5176) and upstream pahole on
next (2ca56f4c6f659).

Of the above 6 combinations, I think I've tried all of them (maybe
missing 1 or 2).

Looks like GCC got updated recently on my machine, so perhaps
it's related?

        CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"

I'll try some debugging, but just wanted to report it first.

Thanks,
Daniel
