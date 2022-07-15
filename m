Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1371576796
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 21:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiGOTjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGOTjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 15:39:31 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D05D13D1A;
        Fri, 15 Jul 2022 12:39:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 09F343200D0E;
        Fri, 15 Jul 2022 15:39:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 15 Jul 2022 15:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1657913969; x=1658000369; bh=vvnov30v3c
        CA2/+HpVJAC1RG0rtOfKvgTbe1umHi+vI=; b=NTzMn1Pifdmp4VPIulbx8zQFKH
        CAQfwJYfECBd4jbfM65uay90fz1OViqQ9zLXMhI1qdkHJfGH8qwEkay9tfYHTzVP
        Kd9SVk3Aqfzayd1Qxz3dH6cGlcW9R+papSIS0mTh7snQaxi2paXUDS5XGsWeCEkK
        eElEu5obqBdg8+qRU4w83Vp2FvFUnuqcaDT++OW1cytPCfxyYfbQG8O+p6ORpP7I
        ZwgcVIZKzGXetIAGYirDg/3WNFqMBdbQHplJ6cCAblFpuNntIbewqwI0547MYRnG
        ApEnHzTarBkKt7GvZWG9mmxm11bXL7XSB5RF1pZ8ur5SX9oVG3kMoY3Auxdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657913969; x=1658000369; bh=vvnov30v3cCA2/+HpVJAC1RG0rtO
        fKvgTbe1umHi+vI=; b=Pw8AC5dKC4DqPaFbyFZpF+ZpGtWqmDuAxzD/34xvXtLp
        5W15EIqRSnHOMMxqQzn53hBOwlZKGm7tWvMa7uqX1ItKMLuxoY+FO0OB38qoFqoB
        n7AEBCCNLdIzJGgF1ryV3eyXJFxiAptK2mLtUIeDK+xIzMOnkVxnEwwMkCk3uAsf
        ZlNIny9nlBA/QowWa88bHhYcmFEsBFZw3WYr3csJDVxXRD23KckOGPuJBaDCulTk
        AG+9x6s9kM3kvtnvflXYoIO6iBXInvlALg+9PJmueKwEV0dTItrj/M29r5/v2ato
        54Q3On+6XV+e8i5+ruDgAKcUfVQaMMVW+3qkLiN9Yg==
X-ME-Sender: <xms:ccLRYjCoiSUN63ON_mfms8vyWNIIr5FyL5HVe5Sfkdxuy8eZemVfFQ>
    <xme:ccLRYpjY7ZyAUxVn-wLJN0nsBANnilhWBMcJIexcukBX86kDaLo3MpelsQAgNOgF8
    k1ufaGP4sHy0Ro23A>
X-ME-Received: <xmr:ccLRYukgXvVIAaez72e6DRJdToNfacXTeBzhg5pFWbaYVpIvl3uzOkfpVMuF9CNMPqGMlE0ummPiYbXAPjAdqAQcnJzdK60LiQ5U8chp7qeZssvsI3BDQa-ltJ0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudekuddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
    udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:ccLRYlzFVLRRTGo967KEZn0DGLBG2_LpVNOtfAOqhsQvMl5MQto1ew>
    <xmx:ccLRYoR0fOZDXwxCbcpKkOs3Exc8h69egJPsJHHUPOYOP-osb5fT5g>
    <xmx:ccLRYobQQlbcfHk5Nmh8-xlUM9NK0o1G2jLhM2Dr2jdREPBZaPkQWg>
    <xmx:ccLRYtL3S6q3w8LHT6C165tNZuaDlqMFvL8x2nyP0Njpm3zXFVvowA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Jul 2022 15:39:29 -0400 (EDT)
Date:   Fri, 15 Jul 2022 12:39:27 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v2 2/5] tools include: add dis-asm-compat.h to handle
 version differences
Message-ID: <20220715193927.x6xy4h7n5rrh2ndc@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <20220703212551.1114923-3-andres@anarazel.de>
 <fc1be6d4-446b-2b34-21cb-5e364742c3a2@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc1be6d4-446b-2b34-21cb-5e364742c3a2@isovalent.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-05 14:44:07 +0100, Quentin Monnet wrote:
> > diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
> > new file mode 100644
> > index 000000000000..d1d003ee3e2f
> > --- /dev/null
> > +++ b/tools/include/tools/dis-asm-compat.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Any chance you could contribute this wrapper as dual-licenced
> (GPL-2.0-only OR BSD-2-Clause), for better compatibility with the rest
> of bpftool's code?

Happy to do that from my end - however, right now it includes
linux/compiler.h, which is GPL-2.0. I don't know what the policy around that
is - is it just a statement about the licence of the header itself, or does it
effectively include its dependencies?

FWIW, linux/compiler.h is also included from bpftool.

If preferrable, I can replace the linux/compiler.h include by just using
__attribute__((__unused__)) directly or by using a (void) cast to avoid the
unused-parameter pedantry.

Greetings,

Andres Freund
