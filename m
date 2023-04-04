Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B26D5EA0
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjDDLHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 07:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjDDLHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 07:07:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BD4C22
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 04:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72E3863178
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 11:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D45C4339E;
        Tue,  4 Apr 2023 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680606316;
        bh=T368aoMHDkiq0GiBMzY/0jBHD0xUknWqqMQtHY1qSi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+o46kTVz4C9gM5i3+3qTdouqu8aPJ9CI9XlydSVAXYuVwKNOhboB/hdMq8wmf/64
         xpA2m4ah/98Uze3SdP/3KtEsVZAjgAxCKv/ox2G7MhszE2FId5ZEYw/ZJwV5wBHv6h
         o4LgeSHr6YhULa0dqTztiX3WSsuhfodsorZxwrDY=
Date:   Tue, 4 Apr 2023 13:05:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhongjun@uniontech.com
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH] BPF: make verifier 'misconfigured' errors more meaningful
Message-ID: <2023040424-dividers-scandal-a4f5@gregkh>
References: <20230404095202.30408-1-zhongjun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404095202.30408-1-zhongjun@uniontech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 04, 2023 at 05:52:02PM +0800, zhongjun@uniontech.com wrote:
> From: zhongjun <zhongjun@uniontech.com>
> 
> There are too many so-called 'misconfigured' errors potentially
> feed back to user-space, that make it very hard to judge on
> a glance the reason a verification failure occurred.
> This patch make those similar error outputs more sensitive and readible.
> 
> base-commit: 738a96c4a8c36950803fdd27e7c30aca92dccefd
> ---
>  kernel/bpf/verifier.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
