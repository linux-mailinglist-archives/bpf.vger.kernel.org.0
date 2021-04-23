Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D0368C5F
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 06:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhDWEwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 00:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWEwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 00:52:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA7C061574
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 21:51:57 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i190so33275500pfc.12
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfS3TrL/Y0etQj8aAjhKAxo8acQ/7MJWaAvPrvywT4o=;
        b=ilmObq3hTxZlFIiLxhqIIPKrwwiHb6Mk2zNkN/2Xq+MnUAdnF5M0CaHOIkBub/HZog
         uvv+PiaWBMUde+x9aK17WF2oQ2mrHltKr40fe94MnIhHpy4FNWTZNn2hFjeCbIXXbdL5
         e6/vNlgMwm14jNY50rJCBys3rd4AjpSRjUNqhaQKOcMa4BOdw3QxNXwY8A6AR4yQVHAs
         g4MmISReRiLKAvOsTtzvFI8K+eZmJHD/UU6/OpVLlOsJecajQgEmvGB/U9rNBo5dl3Dp
         F0rGAjpyo2tEsexyI9TWtW7akxuj8eOC4RPwqpIZicFdUbzoMfF4HSh8H0RAhDiU3RKV
         3qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfS3TrL/Y0etQj8aAjhKAxo8acQ/7MJWaAvPrvywT4o=;
        b=DozrhqSSettZG8xn9n1MvTrY433LFUb9ZYkdfxP/umJpMheIsMSQnicnj67AZdygod
         /SDEl61XNbHmqI5OEv0gandbizanjo7VcPLSfZ2457umjVQ1QC6GaR28kV2xVTglueGS
         vPfuBSfqf5HWMr3/FxPIT1diBmI2Tt152MbrCwbxcGCkjUeMBvhxrBEBqsV1p0V4HPgr
         PEDYFoIFy2me1gGyvcU+8QfjBa2CLNGOhOfQMZIbmiXtH5OHRdgXXKox0SfhTSIW7u5s
         E5aStNhfGebLKpqivv3ySGwMJ/Q7e/lApaF9MCxBeMORS4qpFK52gUjXOGVu2HzJ732d
         zoCQ==
X-Gm-Message-State: AOAM531dQN+lpwbvxYthJO2PC4ArdapnkTy1dT7k+0myfdahHruswlIE
        1MnkrYxc/vafC7hyfJytJxRaGBfelJmVPZlaJgo=
X-Google-Smtp-Source: ABdhPJzKW4dUEKT9JsyVTpia/Q/9Jl4DjXPFLzXZRW4CP5Wio1rZSwyCRZ86rZSvVG7NssLtPu6VQMprtwWOBVLeEnM=
X-Received: by 2002:aa7:82ce:0:b029:242:deb4:9442 with SMTP id
 f14-20020aa782ce0000b0290242deb49442mr2000502pfn.73.1619153517341; Thu, 22
 Apr 2021 21:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1618378752-4191-1-git-send-email-lirongqing@baidu.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Fri, 23 Apr 2021 06:51:47 +0200
Message-ID: <CAJ8uoz1LcizW4UCyq7hO6kPnLipedpB9-gY8ZEqTV-g2hWUbfg@mail.gmail.com>
Subject: Re: [PATCH] xsk: align xdp socket batch size with dpdk
To:     Li RongQing <lirongqing@baidu.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 2:39 PM Li RongQing <lirongqing@baidu.com> wrote:
>
> DPDK default burst size is 32, however, kernel xsk sendto
> syscall can not handle all 32 at one time, and return with
> error.
>
> So make kernel xdp socket batch size larger to avoid
> unnecessary syscall fail and context switch which will help
> increase performance.

My apologies for the delay RongQing. I forgot to ack this for some
reason. Your suggestion makes sense and will improve performance in
other cases too. Thank you.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  net/xdp/xsk.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index a71ed66..cd62d4b 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -30,7 +30,7 @@
>  #include "xdp_umem.h"
>  #include "xsk.h"
>
> -#define TX_BATCH_SIZE 16
> +#define TX_BATCH_SIZE 32
>
>  static DEFINE_PER_CPU(struct list_head, xskmap_flush_list);
>
> --
> 1.7.1
>
