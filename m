Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232B53142C4
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 23:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBHWVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 17:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhBHWVp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 17:21:45 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000EC061786;
        Mon,  8 Feb 2021 14:21:05 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id l8so3831459ybe.12;
        Mon, 08 Feb 2021 14:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxtA8BPxdjXqTAvlnB/DG2m6D/YD0cTVpAr2uXYiXX8=;
        b=cxQdZkFTSZEbleDGDp9H07tSUCcz2lcnEGr7vrbkwq0ZZQ0LFh9AzLBv7Twe6HHJ2o
         EZ9Q1aQ/ivu45OaocZy0aHhwRvB9rWS1ktgvkz5r/WHPVNitQzfpeNkAW+Fbt8BR1/w6
         hmBQ87tRTzBWHljdD8m2YYkywS3ERkCy+c1EN4eyv5XjRWySqQA6pwJhhSB5VYl+Z7bD
         C53nr8qf75UK6bzUkixkLsSpS3ckXSN4N3RZVM5RZOnmaHxRZ91noLDBUBXgZJYUjO5S
         wpqHdNnsBPj/zVOLibdQ6LVrnYdKI1zHtM61aZONkYbzgm1+G+k/3uSk7PIsdHPT17HI
         Gpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxtA8BPxdjXqTAvlnB/DG2m6D/YD0cTVpAr2uXYiXX8=;
        b=QA4YZrKnk/9nzoTSdktte7m88r8jxBhQuc0DaVAQAo1r+P8czin3cU91FjoM4u+AZ2
         sKWWSFl1JUBRLaZP+gGBWn0Q0wPQUoUNAUGBZQ03MSU/PoTDX4pUWSy6uAVzcsZZB0ua
         etIBzHx+3xx9Zyct5FL/Tn+tvNDocdX+BKAL1HzhcCUgUex9nhmib2rPK3R44PRG2Pib
         wyVhC2utsH7Z8TxkvuTTiOoHkSdEaUeaIcmeS+2sG4pfHiANxrgndcdoKvuJQteH2rCc
         geowxEBxDm1sxNKLDGA/DfsL17K/jEn3s5Rp+kgzv7RRNwVsfz7mxD4MclsCJhe8wKIg
         VTOg==
X-Gm-Message-State: AOAM533P/an8/qSU+IT8/qUKX4EZmUUFS7S80SDCKbxZrusVvGtdcNcA
        fxqp/q6MHDJblJGz2auK4iy3imAxftAh6yOzIDg=
X-Google-Smtp-Source: ABdhPJzawkp+O/VG/hVv8oWyfxU+vRtPJiInw7rPaFflKwNfvxrtP7321ZjViTzrhx98oVnVEO2BYFkO+ZlGAD1kZy0=
X-Received: by 2002:a25:9882:: with SMTP id l2mr26966731ybo.425.1612822864552;
 Mon, 08 Feb 2021 14:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
 <20210205134221.2953163-2-gprocida@google.com>
In-Reply-To: <20210205134221.2953163-2-gprocida@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Feb 2021 14:20:53 -0800
Message-ID: <CAEf4BzY5d7roXe4uHuK3D-pedwz5Y4RDVcqQECGZ5XPiqk=v1A@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 1/5] btf_encoder: Funnel ELF error reporting
 through a macro
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        kernel-team@android.com, Kernel Team <kernel-team@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 5:42 AM Giuliano Procida <gprocida@google.com> wrote:
>
> This adds elf_error which prepends error messages with the function
> and appends a readable ELF error status.
>
> Also capitalise ELF consistently in error messages.
>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  libbtf.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/libbtf.c b/libbtf.c
> index 9f76283..7bc49ba 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -27,6 +27,16 @@
>  #include "dwarves.h"
>  #include "elf_symtab.h"
>

[...]
