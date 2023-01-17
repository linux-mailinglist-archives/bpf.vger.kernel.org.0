Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C866E339
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjAQQQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAQQQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:16:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17363BDBF;
        Tue, 17 Jan 2023 08:16:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6873FB81889;
        Tue, 17 Jan 2023 16:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9918AC433D2;
        Tue, 17 Jan 2023 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673972198;
        bh=JDdKiExkdHHBvFjl0JAbqgCBVMtsUjtunEQuXNFiEeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFIokIh8FPRI/MDifDwqLBbv7xE/Si8Fa9gf7NcCFI0/pWqu81fykNf9Y8T3MrlwT
         KoJb79OKvPyjjiUFWAusoeIS2ZjlZ3BemvdsRCVWs6giySdiKVmdd0sel35e2iHIX7
         1jvRyKtCqVSWS43YgQHD7UESDBj4X9y8PB7T7ziM=
Date:   Tue, 17 Jan 2023 17:16:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     WritePaper <clangllvm@126.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: security enhancement by limiting the offensive eBPF
 helpers
Message-ID: <Y8bJ48Q5mcDOxS3c@kroah.com>
References: <20230117151256.605977-1-clangllvm@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117151256.605977-1-clangllvm@126.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 11:12:56PM +0800, WritePaper wrote:
> The bpf_send_singal and bpf_override_return is similar to
> bpf_write_user and can affect userspace processes. Thus, these two
> helpers should also be constraint by security lockdown.
> 
> Signed-off-by: WritePaper <clangllvm@126.com>
> ---
>  include/linux/security.h | 3 +++
>  kernel/trace/bpf_trace.c | 6 ++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
