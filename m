Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DC6C5B66
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 01:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCWAgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 20:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCWAgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 20:36:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293614ED5;
        Wed, 22 Mar 2023 17:36:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DFAD95C00E8;
        Wed, 22 Mar 2023 20:36:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 22 Mar 2023 20:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679531800; x=1679618200; bh=gY
        anmg+GyDfmuYC/39sIJDGvil7BWagM2sVSvKzisvo=; b=YJoxgO8czSrPumioP7
        LhJUmNnwrtvN7lx96fIEddYfP50p7Ovwo277Kdeq0uxcXamXWET4FHtE+UTh4rXW
        QVOLY3Hy81X8PgEkW9hkxuKs7r/kEjd7s3xWEIWq7DHccWV8CjiY1GNWzC77339z
        Rpj6j5AuuowHptvaLCwTfOkBplacbAxAOy+gs5PQogEWXtj0/Dtf8+XRXxiaETqb
        lRDZP3WoikCSXY8Ho7ZNf0zgdx19R7QevIWFglLcuj/75dtKUy92BRW00aTCsk+5
        gWpUev0a0Ht6tRdgQU4+dzKsyBFgiFmMrap2hkG2C4qgayTkf9noSLa1mYTZvBUs
        0Y+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679531800; x=1679618200; bh=gYanmg+GyDfmu
        YC/39sIJDGvil7BWagM2sVSvKzisvo=; b=YR4taRLroYeDVlm1Lcfcn0GUqHHi9
        b8KrIYE9Jy0kaRa2EOGnLnDpn/aqPFzkBxbNhGm5mRqo9+62QF0ZPzLKY+c/DdL1
        NJJO0WAdOvLKrRUbTcrexS26YH8agUhfgdJ/MVsag1ppcVq3KnbKkWl7k8u0FftP
        BDpXeA9BXRx4SZnwK7+yWTMTk+mCCKELbII1I6YFHM2MFBGyFYSuPXwOf9ZHaWRn
        pqB6ff/AuXkR9kysySMJJ1R1PKe0ZjKfbpj3UA+hYurxDhX91oyym+RymUYH2ove
        oqaIpJ5lIkP2A9lEQhflhtwgb7XvEl9hCH9VFrQfYksul39MIvB/+pSeA==
X-ME-Sender: <xms:GJ8bZNglTuDwDmutak1sDx_3_RAipkbyKLpWgh2v0Bd97ZgCoFFnVg>
    <xme:GJ8bZCBJXDIFkUbiNM-rvJfgzXgsK0mMdpCwfANFUCX-XXl_CEA5uZFNY-XDWoQWO
    5sDBRBE9Hfs5NLNLA>
X-ME-Received: <xmr:GJ8bZNE63ntfLQu3IsAGevhxhrffifyGnceC6K-Ga1eRjIrfyK_DeQZJFGU5ypgCepmTaSv5yBAiSoTNs0yqOhAAWhJtq2-Q-cXG_aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegfedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepveduudegiefhtdffhefggfdugeeggeehtefgvefhkeekieel
    ueeijeelkeeivdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:GJ8bZCQ9BiLQPgCC-iLdpYf0t8a_IM68GjOGz--q2GFeLtJ1H80bRA>
    <xmx:GJ8bZKwkCukFAb1D5-hDFZQ3NDg7xqepBElOm2kyBFQ2F-_Q-SxCZg>
    <xmx:GJ8bZI7Bus23kmj1Ip_9jcEAamJzjCi4H2HJ4V6G173rckGyIVKi6g>
    <xmx:GJ8bZPpIUpBavhq0ASNUUF02aov76OTAJxkFKq9dRIyoF7UgrvBjzQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Mar 2023 20:36:40 -0400 (EDT)
Date:   Wed, 22 Mar 2023 18:36:38 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC v2 bpf-next 0/3] bpf: add netfilter program type
Message-ID: <20230323003638.pbzm6jino5qxjfvc@kashmir.localdomain>
References: <20230302172757.9548-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302172757.9548-1-fw@strlen.de>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Florian,

On Thu, Mar 02, 2023 at 06:27:54PM +0100, Florian Westphal wrote:
> Add minimal support to hook bpf programs to netfilter hooks,
> e.g. PREROUTING or FORWARD.
> 
> For this the most relevant parts for registering a netfilter
> hook via the in-kernel api are exposed to userspace via bpf_link.
> 
> The new program type is 'tracing style' and assumes skb dynptrs are used
> rather than 'direct packet access'.

[...]

Hope all is well. Do you have any updates on this series? I'm keen to
start building on top of this work.

Thanks,
Daniel
