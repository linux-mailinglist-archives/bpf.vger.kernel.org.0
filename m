Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187EB4E88EA
	for <lists+bpf@lfdr.de>; Sun, 27 Mar 2022 18:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiC0QmJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Mar 2022 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiC0QmI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Mar 2022 12:42:08 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD590E66;
        Sun, 27 Mar 2022 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=PG0sCMqcFoDH6jUFSoH1T+PWVs769vp8HcptC7WDJ2M=; b=srObZ0Hw2pO8Sy3NoBL3TpYMGn
        /zaLNF0CbYJey80ZStn265GYjlk+ScorGiev2cgqtP03hcDawbRAJf44cVgRKJ+BzxES1UzcwhiKC
        eajbiijTRRMmJiEtYk6qO7PWURg48wvXALeywQno8jAQseDZ9/BUaNZ3SdXhzYAOQyVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nYVwF-00Cu8e-DX; Sun, 27 Mar 2022 18:40:23 +0200
Date:   Sun, 27 Mar 2022 18:40:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
        corbet@lwn.net, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH net 08/13] docs: netdev: add a question about re-posting
 frequency
Message-ID: <YkCTd+ojh6s20WBO@lunn.ch>
References: <20220327025400.2481365-1-kuba@kernel.org>
 <20220327025400.2481365-9-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327025400.2481365-9-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 26, 2022 at 07:53:55PM -0700, Jakub Kicinski wrote:
> We have to tell people to stop reposting to often lately,
> or not to repost while the discussion is ongoing.
> Document this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
