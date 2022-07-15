Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7675D57673C
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiGOTQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTQr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 15:16:47 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030360506;
        Fri, 15 Jul 2022 12:16:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1537D3200CEE;
        Fri, 15 Jul 2022 15:16:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Jul 2022 15:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1657912602; x=1657999002; bh=8d5NIeZOvl
        yJTIRnNerFjURGzDw8cShuTtmrWswISE0=; b=fMEn9dzbtsiJA+zsiLeNM4v5VD
        aqaXuqNQVFhZxa0FO0w3bfMcsjJfBCRW6XrME1J1EqNzwF6ZHajwfuhOIkdBHwAn
        ahSeNrQGdyU2xZ5juR5LACgwsvFoAmF+MwO6KN5znYW+OrbLc9nXrdhrdp9416KG
        ZsxoCHhOZXR17AveLdJ72lU2RPhL0O1r7pMtQrLtJbRG8+jvVa1125oR4tkiDd48
        4fZfF2cYTJL7bu8oVUzcjB+S8+vRuQxTeqQsNDK/xKODmixt2325y28pQtlYfiL9
        fgqMvkyBm1dsq0HYb50ziZL/XV0HD+Z3Ow9outqhdHLdaf3vHdugigvq8/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657912602; x=1657999002; bh=8d5NIeZOvlyJTIRnNerFjURGzDw8
        cShuTtmrWswISE0=; b=Si+RjZBrYL1xeaI7H+W0r2FD8jw22kthG9Xp8kzIIpUg
        qI7O+CQEfusFF/3NWUtgf2K7sorMSeGpgcAlBKyGLjzzoxBF33wokGm6X/AVozm8
        RADg8KkbeMeVLU9icFTkVfQUudGytkR20ORPEZFyKRKtSNBBtNQTmtdwN+N/lLQe
        L9Zn+gB7rO1mqCsQbqHGy/dUiulKLaqfAG58SwGUox4q3a2Ol0+8UkEkn1j7zpOu
        BW6ekVi4tKDqY+oUL7uHQt87UIAr3rurYVTUtsvfPBbnVGVJsPiR0yAEAWm92lkn
        CnsjhQgRoKXLmJP9KzjZZ84f7fUxCGEkluu4r0GMjg==
X-ME-Sender: <xms:Gr3RYubbRwY5gmtQKKlHFHeC27NKKsc90pk8Dti8Z2MqLzruyCvClw>
    <xme:Gr3RYhZhJ7DiT-yMzBzzv2QecYLCDm-5FCGhqhPpfNh5_w3o0cwdWft146zzcNXn3
    OZEC5WzZjz_5IefQw>
X-ME-Received: <xmr:Gr3RYo9ypu1EY0FHVC-7eL7ywjG2r-jasIn3-DtROT_7nJik61eDrfdPl9Shw9sVQtsPsTUaYV2PEcGQZ-7ol5FbYNhywnZuyZbWDArw1f1HTJwOc2GFN9aQxRuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:Gr3RYgqtgp3WhrDoVCjWd-zrsdl5rBDnAwb4TYh4VfmBAVCpKgy9Tw>
    <xmx:Gr3RYpptluWNZFG1c6teU-4mvqUf0rwRL3OO0iDEgh83RzzH3k4vmQ>
    <xmx:Gr3RYuSiY_6wC-0Vspz7hB-OkOrn0NzuEYPuS-8GMk3zLt3f3Cbh1g>
    <xmx:Gr3RYqcGnLcZV-s5spf5WViC6YuIcmO4lGcBPdZqBeEMiQNlNPpi3Q>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 15:16:42 -0400 (EDT)
Date:   Fri, 15 Jul 2022 12:16:41 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     sedat.dilek@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <20220715191641.go6xbmhic3kafcsc@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <CA+icZUVDzogiyG=8sCuxdW4aaby_kRwToit2tg-A4D3VorVKnA@mail.gmail.com>
 <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afd3b45e9b95fa5023790c24f8a1b0b4ce1ca7c.camel@decadent.org.uk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-14 15:25:44 +0200, Ben Hutchings wrote:
> Thanks, I meant to send that fix upstream but got distracted.  It
> should really be folded into "tools perf: Fix compilation error with
> new binutils".

I'll try to send a new version out soon. I think the right process is to add
Signed-off-by: Ben Hutchings <benh@debian.org>
to the patch I squash it with?

Greetings,

Andres Freund
