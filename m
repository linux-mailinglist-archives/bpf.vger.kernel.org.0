Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171196E47ED
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 14:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjDQMhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 08:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjDQMhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 08:37:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A24EF1;
        Mon, 17 Apr 2023 05:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 486DF6239D;
        Mon, 17 Apr 2023 12:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C32BC433EF;
        Mon, 17 Apr 2023 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681735019;
        bh=cZkrlscYdiJDQiCpwVk8ynp/4B7C4EvBAfc7DKgA0E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3tSKHnfksiRkXoMZjtfe8Imke7Z7dlwVy+SWzzASYKGD5F6e9mTFxwVgY+ZKmDmL
         6ChSFb+qfLHqYVxW8bWEUwAMSV5pH8Q76WknaDRhOkEYRzvL1orsgApnhb0yS1gEdy
         SQlJVzloYyl0Q0+RhXPTqXcajPfJtEuavktz4S/s=
Date:   Mon, 17 Apr 2023 14:36:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "songrui.771" <songrui.771@bytedance.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libbpf: correct the macro KERNEL_VERSION for old kernel
Message-ID: <ZD09abW0YyHU3Snt@kroah.com>
References: <20230417084449.99848-1-songrui.771@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417084449.99848-1-songrui.771@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 17, 2023 at 04:44:49PM +0800, songrui.771 wrote:
> The introduced header file linux/version.h in libbpf_probes.c may have a
> wrong macro KERNEL_VERSION for calculating LINUX_VERSION_CODE in some old
> kernel (Debian9, 10). Below is a version info example from Debian 10.
> 
> release: 4.19.0-22-amd64
> version: #1 SMP Debian 4.19.260-1 (2022-09-29)
> 
> The macro KERNEL_VERSION is defined to (((a) << 16) + ((b) << 8)) + (c)),
> which a, b, and c stand for major, minor and patch version. So in example here,
> the major is 4, minor is 19, patch is 260, the LINUX_VERSION(4, 19, 260) which
> is 267268 should be matched to LINUX_VERSION_CODE. However, the KERNEL_VERSION_CODE
> in linux/version.h is defined to 267263.
> 
> I noticed that the macro KERNEL_VERSION in linux/version.h of some new kernel is
> defined to (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c))). And
> KERNEL_VERSION(4, 19, 260) is equal to 267263 which is the right LINUX_VERSION_CODE.
> 
> The mismatched LINUX_VERSION_CODE which will cause failing to load kprobe BPF
> programs in the version check of BPF syscall.
> 
> The return value of get_kernel_version in libbpf_probes.c should be matched to
> LINUX_VERSION_CODE by correcting the macro KERNEL_VERSION.
> 
> Signed-off-by: songrui.771 <songrui.771@bytedance.com>

This needs to be your name, not your email alias (do you use ".771" as a
name to sign things with?)

> ---
>  tools/lib/bpf/libbpf_probes.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index 4f3bc968ff8e..5b22a880c7e7 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -18,6 +18,10 @@
>  #include "libbpf.h"
>  #include "libbpf_internal.h"
>  
> +#ifndef LIBBPF_KERNEL_VERSION
> +#define LIBBPF_KERNEL_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + ((c) > 255 ? 255 : (c)))
> +#endif

What is wrong with using the KERNEL_VERSION() macro, it should be fixed
to work properly here, right?  Did we not get this resolved in the
main portion of the kernel already?

thanks,

greg k-h
