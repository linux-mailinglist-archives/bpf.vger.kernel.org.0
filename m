Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C0A605B41
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJTJdN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJTJct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 05:32:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525F21C712D;
        Thu, 20 Oct 2022 02:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40A4861A55;
        Thu, 20 Oct 2022 09:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A878C433C1;
        Thu, 20 Oct 2022 09:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666258336;
        bh=uDa7pRZFKuZM92/rP5vN9GgDEx9DKSCJjNDCnUYV/Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIN7o0wBGP5H59N6bRQIsHl2XC7i9bUQxNenxJBKcdNvGK0iHvBiPs5m99EX/P9Dm
         s4hfmEoz8VWE6wZ/LhfGwDDS/gXJQiPrTS77qdjakRMJa+ansEtV2TesOWeYlQ52KM
         80ZZ4Yy/17px3FEp9//Di1RRu05Vjgl2wbVcjGe4=
Date:   Thu, 20 Oct 2022 11:32:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cuijinpeng666@gmail.com
Cc:     ast@kernel.org, keescook@chromium.org, jolsa@kernel.org,
        cui.jinpeng2@zte.com.cn, peterz@infradead.org,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kallsyms: Use strscpy() instead of strlcpy()
Message-ID: <Y1EVnZS9BalesrC1@kroah.com>
References: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 09:05:47AM +0000, cuijinpeng666@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Again, please stop.

I have told you, and others who are purporting to send patches from ZTE
to please stop using gmail.com addresses as there is no way to verify
that you really are from ZTE.  You are potentially lying about who you
are here, which is not allowed in kernel development for obvious
reasons.

Also, these email addresses are "one way only" with no responses ever
being recieved, and so they have been banned from vger mailing lists.

I will go ask this one to be banned as well.

Please work with your employer to get their email settings fixed up so
that you can properly send patches.  Do NOT abuse gmail for this as
that's not ok.

greg k-h
