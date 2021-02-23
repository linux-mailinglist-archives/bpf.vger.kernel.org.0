Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732833223BA
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 02:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBWBbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 20:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhBWBbB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 20:31:01 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D498EC061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:30:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id m188so14837658yba.13
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 17:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWdIWeqFK3guZSlLpaKpm114wyt50M0Ovf4WmvixmJY=;
        b=aHl6NEf1MQzR1mRUH4guny1CqlyDTSvL+6BYEso6KEvXXJGFyStUQbgadRC4b2UAdj
         X4X8IOFg22ATfSSik/uMQ/ViEpxMZ76NIkIFKNQsrwTfMZFFuReTMOLQDoVfxI720De4
         U6dZjpT6uH0OMVCBZ2pHMonxQ+P+Qb3INuBEzCKC3YZZRxjuzdIV1/f5I2hOay2dqze2
         YFsgyyfkqEG+6T3y3mDkEg2q80iZYZyaaPo7bcV8bVcK61HmoyfcYpdw37b2juYoymzj
         ocLJ7irGnUjmPu7zw0eURd+wdMkkUxBwCTt8HFN06cBImumgwxX1y0N8DVwxV+HYzMKv
         9neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWdIWeqFK3guZSlLpaKpm114wyt50M0Ovf4WmvixmJY=;
        b=gIsJqJgAtiKJaoK8/nGp7QS3qIE5GFev0XfA5YUZ+l6Y9/MHtxwEQpqqtdrdYqj0fD
         Lk1Isk1Q4olpI1ZUx0FEu+ERX1OeklkH/qmuwVDl6gXjlSg7WLcfciV6+pe3sW1THpIV
         fimQVDes1X/cIM5QLM1lheboRqbzbU+uEQpfe02XgTqeXOOKYWuR/JZ7XxW42927M+Ec
         j1qw6tCM+LTzgo+FegapvNcsJkhTbTTp/CTfk1X1elojc6BnXGcgjdDqvEB7b6OQO0P+
         NpkSwHdgPONq8g/7UsVQVVy3emFGEGisugwgJyFm56A7TZW5ZtWttGuPn5btUOChCNie
         mOQQ==
X-Gm-Message-State: AOAM531LSk51QBfNviaJ6rD7NvDhqIRINFM7t24i7ZntXWgCy0BdXyup
        Vyq2tt6aQjdvBbzgO7WZcQp0w/xvgL4QUjj9RCI=
X-Google-Smtp-Source: ABdhPJyV3doE+L68gI4+fRO00IA4VXb1LuUsOQ3QfuX4DxlJNdZPjk5FVw7HBpY2tQZXF7FYdqYKLvgU0raBHZmA38s=
X-Received: by 2002:a25:c6cb:: with SMTP id k194mr35583915ybf.27.1614043820209;
 Mon, 22 Feb 2021 17:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20210211233956.em5k4vtefyfp4tiv@altlinux.org>
In-Reply-To: <20210211233956.em5k4vtefyfp4tiv@altlinux.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Feb 2021 17:30:09 -0800
Message-ID: <CAEf4BzZNS_BQhjRuT25YEa0ppU=4_v5kUqMxOaW_FqdXXDtVNg@mail.gmail.com>
Subject: Re: EFI boot fails when CONFIG_DEBUG_INFO_BTF=y on arm64
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 11, 2021 at 3:44 PM Vitaly Chikunov <vt@altlinux.org> wrote:
>
> Hi,
>
> We have boot test using OVMF/AAVMF EFI firmware on aarch64 in qemu. When
> we try to build kernel with `CONFIG_DEBUG_INFO_BTF=y' (pahole v1.20)
> previously successful EFI boot test fails with:
>
>   EFI stub: ERROR: Failed to relocate kernel
>   EFI stub: ERROR: Failed to relocate kernel
>
> Without EFI it boots normally. On other our architectures (such as
> arm32, i586, powerpc, x86_64) it boots normally too (all without EFI
> boot, but x86_64 is also successfully tested with OVMF EFI boot).

So this seems like an arm64-specific issue? Is it possible to get any
help from someone familiar with arm64 specifics to find out what
exactly causes this problem? We use `pahole -J` to "implant" .BTF into
vmlinux.o, but later rely on vmlinux loader scripts to have a loadable
.BTF section. The problem might happen somewhere along those steps. I
don't think I can be of much help here without a bit more information
(and seems like no one else on this list came up with any suggestions
as well).

>
> This is tested on 5.4.97, but I can try 5.10.15 if needed.
>
> Thanks,
>
