Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFC36A8B80
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCBWIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 17:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCBWIT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 17:08:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA6A5FE;
        Thu,  2 Mar 2023 14:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06057616A8;
        Thu,  2 Mar 2023 22:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3409FC433D2;
        Thu,  2 Mar 2023 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677794895;
        bh=wH+p1yfWin9qVAKlfszrFdTguxtCbRNw9N1oijfZxwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ImHWPBBrYMeA4yHePnJgDUhdE68GPLaW4h+JY4N3H/7wNJOJxXrCcfOFFKf4YNZFu
         AHEVTInbT0oXguV7OQJb4l83lQbX2NyX3T98MKjCflllbM+Qai4M2CgvQWoNofUB/1
         jkeH4910r4NdSOx8TxRmSU44oPIbmzHbCU5QPvI3JOjy0PsUyqzFV4irqPEaHdNiRO
         a2JeUP7fOR9PTpLSuMPgSp7UXNYfCn/svGjzgRlxqgFCTtmi/8NKoQcECcpesCt6lc
         CYp9z4n38x+4lpGU2yrGxfOxk2H/90iC6A2CTqHLK3gvkPEpPl90XKVJ9JL4PzxDFT
         FZtRb8e12ewfw==
Date:   Thu, 2 Mar 2023 14:08:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <kees@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: splat in ikheaders_read (bpftrace)
Message-ID: <20230302140814.294aece0@kernel.org>
In-Reply-To: <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
References: <20230302112130.6e402a98@kernel.org>
        <22EA7360-E2FC-4A23-BF0B-EFDE523F9605@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 02 Mar 2023 13:57:57 -0800 Kees Cook wrote:
> On March 2, 2023 11:21:30 AM PST, Jakub Kicinski <kuba@kernel.org> wrote:
> >Hi Kees!
> >
> >Running tests on net (Linus's tree as of Monday) I get this splat
> >trying to attach bpftrace to a tracepoint:  
> 
> Can you give me an example command line to try to repro this?

cat /sys/kernel/kheaders.tar.xz >> /dev/null

> >[ 2468.945793] kernel BUG at lib/string_helpers.c:1027!  
> 
> Were there any lines above this? It must be memcpy blowing up due to what it thinks is an overflow from having tracked an allocation size (that's the major change this cycle).

Yes

  detected buffer overflow in memcpy

sorry.

> >[ 2468.949683] RIP: 0010:fortify_panic+0xf/0x20
> >...
> >[ 2468.961930] Call Trace:
> >[ 2468.962300]  <TASK>
> >[ 2468.962611]  ikheaders_read+0x45/0x50 [kheaders]  
> 
> static ssize_t
> ikheaders_read(struct file *file,  struct kobject *kobj,
> 	       struct bin_attribute *bin_attr,
> 	       char *buf, loff_t off, size_t len)
> {
> 	memcpy(buf, &kernel_headers_data + off, len);
> 	return len;
> }
> 
> I will take a look at the caller's allocation of "buf" and kernel_headers_data.

Mm. Actually stopping to look at the code - I don't see it bound
checking against kernel_headers_data_end :| Maybe we need:

@@ -34,6 +35,7 @@ ikheaders_read(struct file *file,  struct kobject *kobj,
               struct bin_attribute *bin_attr,
               char *buf, loff_t off, size_t len)
 {
+       len = min_t(size_t, kernel_headers_data_end - kernel_headers_data, len);
        memcpy(buf, &kernel_headers_data + off, len);
        return len;
 }
