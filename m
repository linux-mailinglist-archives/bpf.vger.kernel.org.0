Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6F25E5F6D
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiIVKJ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiIVKJK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 06:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26309D58A6;
        Thu, 22 Sep 2022 03:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72AD62ADB;
        Thu, 22 Sep 2022 10:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957EDC433C1;
        Thu, 22 Sep 2022 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663841321;
        bh=DQD5bY7rmYscssK562jPhzpbowUB46DFrAfdGq6qZ3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2TNQKgtrEU+Yf7g9o2GRe9ffvaoTrWTjnm2fRwGEVnIxgUvoSRkXmb4Kb5NflwAX
         FPLN2A7ja6KyLFWVYAT0WXvjtqBincyJRxVOlvlhklcnX7zgzi0Mi13LwxHr65w07u
         XBd9lX+BeASwwRT9eGEbdNV+2tRDvvNtOHxe6Avk=
Date:   Thu, 22 Sep 2022 12:08:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linu-next] samples/bpf: use absolute path for dd
Message-ID: <Yyw0JskGMbGE1lHK@kroah.com>
References: <20220922090231.236152-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922090231.236152-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 22, 2022 at 09:02:31AM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Not using absolute path when invoking dd can lead to serious security
> issues.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
>  samples/bpf/trace_event_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/trace_event_user.c b/samples/bpf/trace_event_user.c
> index 9664749bf618..d841918accc9 100644
> --- a/samples/bpf/trace_event_user.c
> +++ b/samples/bpf/trace_event_user.c
> @@ -126,7 +126,7 @@ static void print_stacks(void)
> 
>  static inline int generate_load(void)
>  {
> -       if (system("dd if=/dev/zero of=/dev/null count=5000k status=none") < 0) {
> +       if (system("/usr/bin/dd if=/dev/zero of=/dev/null count=5000k status=none") < 0) {
>                 printf("failed to generate some load with dd: %s\n", strerror(errno));
>                 return -1;
>         }
> -- 
> 2.15.2

Again, please stop submitting patches for Linux kernel development at
this point in time until your company has fixed their development
process.

You have been warned many times about this, and we have heard nothing
back from you at all.  I'll go ask for your email address to now be
banned from our lists, sorry.

greg k-h
