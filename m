Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6045CC0F
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhKXSaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Nov 2021 13:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhKXSaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Nov 2021 13:30:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B77C06173E
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 10:27:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so14300905eds.10
        for <bpf@vger.kernel.org>; Wed, 24 Nov 2021 10:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=633qxOyS+tZJsojD5dB/SYRRl1YRXzNDp3qXFQO4wwo=;
        b=Tj4WzuQ2sLwb9LVBkkJ60TAwb8HFCUgfJK64afNo2eoHtw6M48i09juw3UvjGKRoDo
         ExhB8WG9WWQ0zKeV++T0aPfAoIfiwoDvyVHG5LRC/yvZG6B6cyb16SPGJJP82ZJkDhiy
         /6cFr3yYUU8csqVuTIDe8d8gMlcldeqRfTJjlCRNoAlLpE5jly95t7JsNDd8Nw+L8Ge3
         L33tOAWwQsj2PX5xnxhUYn89+xvZxIDoo8nHhtBh5ksekMNgIAaTdKyI8jX13dBaQlK8
         QMwSWzYi3d8vQje31VcSaaL1fdSoayj0vEFs1PmQOEWzX9da757zTQDRUuhFdQDAuhqv
         oCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=633qxOyS+tZJsojD5dB/SYRRl1YRXzNDp3qXFQO4wwo=;
        b=zx4ZUY5E7/QYNPu7fM0b1Ho2Xgm7UinMoWgCYhrQ/1sdEClPbKX58MOuAJCobGasso
         7+32Mx+C/eCDTrO7THTh0NQ04lADLTvqzsJbWbQmo4rZ4PhRR/g0fEzOKCv7ruOx1KGo
         UNFdddldPyGQT7c5CUYHoKUhP+v3gmxvZoEDXLB01NYL5fLuCEPC5qm/Uuo8FIVNVl0b
         DGWzP8uhZBzEynufo2gvGpuRZvc9QR1TN9ruW4gxg1b6anaNNSzt047iTjd4hDymRTfS
         1Ba6ZSczGuJ4ucBQaYX6g8s5sYWHSmmogIzjJtY0Dxv7G58UCb6QWKTTmE0k4Pyb9VDW
         BZdQ==
X-Gm-Message-State: AOAM531m0+NNBMwWhZLsJezbKpVdFiQ5DEJNpixlN0v/vZtv0rbTLF7m
        ptGoSLsgXZ0vxiNeFg9u/ysdpv2CaOmI1tFdI/+fsoQb
X-Google-Smtp-Source: ABdhPJxK8Mz/SOKhnjGPXIdNQifwFw9VB/qML9ajjJocPbFIYaVm6UEOZ6kf7wn2y9ylbuumArXo4+29ZrBzMtxTw3Q=
X-Received: by 2002:a17:906:ae48:: with SMTP id lf8mr23051660ejb.451.1637778421882;
 Wed, 24 Nov 2021 10:27:01 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2zzrwv=S=CmgVo2e4Hubw8nvzbFhvpgyTiUh87O6APZrg@mail.gmail.com>
 <YZ5988RpWezAi9Yq@kroah.com>
In-Reply-To: <YZ5988RpWezAi9Yq@kroah.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Wed, 24 Nov 2021 10:26:49 -0800
Message-ID: <CAK3+h2zadFPqC=aOtkmOr96iQ4Qc6g=90B5Cp3f3pC8KK7oxhw@mail.gmail.com>
Subject: Re: bpf mailing list archive
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 24, 2021 at 10:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 24, 2021 at 09:38:05AM -0800, Vincent Li wrote:
> > Hi,
> >
> > I find it hard read bpf mailing list archive from
> > https://lore.kernel.org/bpf/, I don't have specific old email archive
> > subject to read, just want to read some random old bpf email for
> > learning, had to click older/next at the bottom of page, can't go back
> > in specific month/year range, is it possible to archive the bpf
> > mailing list in https://marc.info/, I find it useful :)
>
> Clone the list from lore as instructed at the bottom of the page and
> then you can run tools on it to get your own local archive for searching
> and doing whatever you want to do with it.  Highly recommended, and much
> easier than trying to deal with the horrid marc.info interface.

for lazy users like me that just want to click through browser to read
random subjects, marc.info seems not
that bad interface :)

>
> Also, if you don't know about them, tools like mairix and mu are both
> wonderful email search tools for large mailing lists, you might want to
> look into them after doing your clone of the mailing list archive.
>
> good luck!
>
> greg k-h
