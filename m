Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA260607A
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 14:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiJTMoF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 08:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJTMoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 08:44:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E2180ACA;
        Thu, 20 Oct 2022 05:44:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6409ACE2592;
        Thu, 20 Oct 2022 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3047CC433C1;
        Thu, 20 Oct 2022 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666269835;
        bh=EMeRt+MoM9VnLhCCrJJOGBgjdGTe/y/YDLyePQFA6Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kkYJFidxNMuZ70jUpI70l6YBOAn3OjZEBQ+1fsbrGRoE8w3US2wgRgq5Y4uLdZXvt
         xFm1hYFfRsiWT5oRCJgxzwg7upqaxxPq6zgNKFzHvhG4UF1AF/1AKgBUAHywUfg+mN
         aujcUGMgL6GLGX0uEPVdL/y4QiEUHlYzEpdBw4eo=
Date:   Thu, 20 Oct 2022 14:43:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jinpeng Cui <cuijinpeng666@gmail.com>
Cc:     Zeal Robot <zealci@zte.com.cn>, alan.maguire@oracle.com,
        ast@kernel.org, bpf@vger.kernel.org, cui.jinpeng2@zte.com.cn,
        jolsa@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        stephen.s.brennan@oracle.com
Subject: Re: [PATCH linux-next] kallsyms: Use strscpy() instead of strlcpy()
Message-ID: <Y1FCiH16RIetS0hZ@kroah.com>
References: <20221020090547.398680-1-cui.jinpeng2@zte.com.cn>
 <Y1EVnZS9BalesrC1@kroah.com>
 <CANhqVYZ+trZzPdB=Vd9YV53DAJt0p5LZQH-u94+VRrDQ5+w2MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANhqVYZ+trZzPdB=Vd9YV53DAJt0p5LZQH-u94+VRrDQ5+w2MA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 08:27:39PM +0800, jinpeng Cui wrote:
> Hello,Please do not ban my private account cuijinpeng666@gmail.com

Sorry, that has already happened.

> I am very sorry if the patches from zte.com.cn
> in the past few months have made you angry,
> we have decided to fix the problem you pointed out
> as soon as possible.
> Our company's mailbox name@zte.com.cn
> cannot send emails to the external network,
> so we use name@gmail.com to send patches;

You all have been warned numerous times over many weeks and months and
never responded to our emails.

We have no proof that using gmail accounts is actually coming from a ZTE
employee, so until that happens, we can not take your changes (not to
mention the basic fact that you all keep ignoring our review comments,
which is a good enough reason to ignore them.)

Please fix your email systems.

Also, do not attempt to send html emails (like this one), as the lists
by default, reject them as you know.

greg k-h
