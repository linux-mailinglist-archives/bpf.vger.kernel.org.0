Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD2639198
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKYWvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 17:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKYWvF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 17:51:05 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614830F7F;
        Fri, 25 Nov 2022 14:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=81lCKAZfIlY/BgnFBjKaFCh7oQXF+X/zYFNJffYZSsw=; b=WUTOVfX70qzaJkm2+WD+hQdwkF
        dsXopo5Y5ReWxn0hZipDXOOlweqZFVgQGRADfw2a5OsXwwK0TNufItchqr8l7Dg4W91JI8qutl1sF
        Vr7F4OeFOy9DAWlIitBajMmQAvuj5IylXS432S6sPsJJrlMVHuFWtCYC/mHc59d1+xbqrMNAg9tmb
        SRf0BKNh1h+CtUZntp5jn1PqAfHRaLPrMXR1gMEPBTO7Sv9LeAt1FWr3f7SOm3UlmP5uLqt42Lb+B
        Aq8Olt4xqitdGOgYgle0mcujkUqiMk/qd+ZZwV4rL8Pt87J45LlenXm/Q7WNRWFITtky3sDkW+69Y
        VFt7TtJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyhX6-006li7-1U;
        Fri, 25 Nov 2022 22:50:56 +0000
Date:   Fri, 25 Nov 2022 22:50:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Evgeniy Dushistov <dushistov@mail.ru>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v4] fs/ufs: Replace kmap() with kmap_local_page()
Message-ID: <Y4FG0O7VWTTng5yh@ZenIV>
References: <20221016163855.8173-1-fmdefrancesco@gmail.com>
 <Y4E++JERgUMoqfjG@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4E++JERgUMoqfjG@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 25, 2022 at 10:17:28PM +0000, Al Viro wrote:

> The bottom line:
> 	* teach your ufs_put_page() to accept any address within the page
> 	* flip the ways you return page and address in ufs_get_page()
> 	* use offset_in_page(addr) instead of these addr - page_address(page)
> and you'll get a much smaller patch, with a lot less noise in it.
> What's more, offset_in_page() part can be carved out into a separate
> commit - it's valid on its own, and it makes both halves easier to
> follow.
> 
> AFAICS, similar observations apply in your sysvfs patch; the point about
> calling conventions for ufs_get_page() definitely applies there, and
> stronger than for ufs - those casts are eye-watering...

As the matter of fact, I'd probably split it into 3 steps:
	1) switch the calling conventions of ufs_get_page() - callers follow
it with something like kaddr = page_address(page); and that change makes
sense on its own.  Isolated and easy to follow.
	2) offset_in_page() changes.  Again, separate, stands on its own and
is easy to follow.
	3) kmap_local() switch itself - pass address to ufs_put_page(), etc.
Considerably smaller and less cluttered than your current variant.
