Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E484DB9CB
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 21:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344587AbiCPU5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344217AbiCPU5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 16:57:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405DB91;
        Wed, 16 Mar 2022 13:55:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DE7985C0094;
        Wed, 16 Mar 2022 16:55:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Mar 2022 16:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkourt.io; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=mesmtp; bh=G3OtiOQY8nhGOQhzRFrCBxUr4ceMCbICwiB
        AU9ewMYo=; b=KFYR6cFQhPH2h30o0mQoW1Mrt3Cnyri4T3aBFiEoBYQ7wcFUzc0
        39wC0ABJ0rjXHtOUPFG1ZFIc5Sfm933fGT9XffZgr+kiNgXwWPiwnOCNVKuN6Wqn
        ndRBdDUrQfs23x8D3QaDi4MgNx0eM/UfJpntBSK++Ph0uyGpVgrjrVBQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G3OtiOQY8nhGOQhzR
        FrCBxUr4ceMCbICwiBAU9ewMYo=; b=UdVzep+2lewk2ku3GgUSxWeEfu7u4+YgZ
        hN0QEIBZg+dQOJthmI1k4t4UliDby/Ub6zvIvApHafRksN/fQGTDEWiJoUKx+fxj
        8bqxMBaN0AJIXU/MgFA6/mWoJY94xfxl3MYR0w/ON97K9XvA1LJkkymJD9RyP+k+
        lEB/L1ph6esSlCyyW995kf6BIa9GQSAyfrMuhrt6rwB7BDRz5vSar0KXZYOIAXo8
        vpJDqTs8InV920h4BYbOqTePAIpARZlU4x4tIoLdBqyeDHztgqNrzDHeJ5SQ+Z77
        RaXOrZZ+9rujNDcbJqBu7SHMmd/v35RQfAbcDNOpbDCzlSKA1m3SA==
X-ME-Sender: <xms:104yYnMdz5R_-Llat6E2FDg4wWTSGD8TNcFjpxtDboS0jswrpp1zkw>
    <xme:104yYh_4nphR-jDgZRdI2bgZUNigI8vfSkn1aVbeSr33HVZZeCOoecKRtNCqjB7HV
    rvkI4RF3ubT0uhtnA>
X-ME-Received: <xmr:104yYmTXj2R5Fi1TStTwJszdT3kJmaMXLVMUbJ0zx2iFRDwjhq2zvcz6wrd0Ls5-OamYnssDu9v5zRucID24yzY9Jpme>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefvddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefmohhrnhhilhhiohhsucfmohhurhhtihhsuceokhhkohhu
    rhhtsehkkhhouhhrthdrihhoqeenucggtffrrghtthgvrhhnpeevhfdtleehhffhkeeufe
    egffdtueefheegveffledtueegtedvieeutedtueeugfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkkhhouhhrtheskhhkohhurhhtrdhioh
X-ME-Proxy: <xmx:104yYrv51Zn0EXv0twrbZr4kORy26fW4E_bEy_9o2gj5QqJcBiTQKw>
    <xmx:104yYvcaIV3z0fc_b5etRBQvaYNt_wmIPjWKbXXSUVvcLAIB1IKuBA>
    <xmx:104yYn0B7fNM71qG0oSkqLSYrTCXrdHYTt1xV_kxLDcD2--VP5chTg>
    <xmx:104yYr45M2X6og59r-AMadGzcSHFZXDxy7t4Aa76ohWeGFVGQk1o-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Mar 2022 16:55:51 -0400 (EDT)
Received: by kkourt.io (Postfix, from userid 1000)
        id 016822541B5C; Wed, 16 Mar 2022 21:55:48 +0100 (CET)
Date:   Wed, 16 Mar 2022 21:55:48 +0100
From:   Kornilios Kourtis <kkourt@kkourt.io>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kornilios Kourtis <kornilios@isovalent.com>
Subject: Re: [PATCH 2/2] dwarves: cus__load_files: set errno if load fails
Message-ID: <YjJO1HrKlf4CiZQD@tinh>
References: <YjHjLkYBk/XfXSK0@tinh>
 <20220316132354.3226908-1-kkourt@kkourt.io>
 <YjJNt0GpA5fAm8PQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjJNt0GpA5fAm8PQ@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 16, 2022 at 05:51:03PM -0300, Arnaldo Carvalho de Melo wrote:
> Agreed? I'll fix it up here and apply if so.

Agreed, thanks!

cheers,
Kornilios.
