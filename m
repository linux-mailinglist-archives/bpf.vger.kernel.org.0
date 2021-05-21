Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9338BECA
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 08:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhEUGCO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 May 2021 02:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhEUGCO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 May 2021 02:02:14 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A5FC061574
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 23:00:50 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 82so7314864qki.8
        for <bpf@vger.kernel.org>; Thu, 20 May 2021 23:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+EecFcPWBZeGeXQf/VDF6kV6mLEHDKfDljs1FpMWXA=;
        b=vRUAmyqgKX+SbOLcbP+H13RzJCytdCZEes9PMhZV+p4nRlqCPxqnEU2MCUEr9s3NPK
         /4aZBVJMvE0dsM6UjJohgr7J7fGqhMuEDYdlYclK7ZFJDrzMH3F3qw5ZFTVNaEPERN6P
         NEV/zA4KkZnQm5rq6nv3cDO/hpsCr2dsxBiz8e4a3AICEcB8wRjc4P1yUMyeomMX/LUu
         7z2UB++Hy3yf/KhZfAeekiYGLVLKHZLTAFAJgOp+4NzRlvOqzks+xluWxAY9+urBOD+C
         8dCWsyxwEZO0VZacy2hZoXY3dP4sw3fP7rbj+m0sY6LjnSk7u44HhmhZwob/Kyr3BevR
         e5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+EecFcPWBZeGeXQf/VDF6kV6mLEHDKfDljs1FpMWXA=;
        b=JTKoXVLOeU9l7/tKqQkKt/wtSFM85ZBoaXzXTm3+ZNGdwXvSplysrCrhdPkON8OC4l
         ImZleIXRP/eMdU/54IMs5yWnrIiPk4nz2oa88dYNJRO5WLjq/e+5DvJTJR45vxcMdqnb
         WXxcw8xFHYnidEpPdLuZdp+/4ICH+TqjaryNIFW7q+oD6Sjd2JvJTPRdU/JyR7THn7vx
         aODj8gXH3ZgtdVcnMl2zK2iIFYw1E1BWLgI5HRJBIU4cq5dfeemNZ2pnwFDnbkPvMAbY
         YBjbY+AnXx/n17bACeVXrtyHyEVY7xob9Gymqbu1aNrwlKaRb7yFWP3OQNDjHohItCjB
         Fk/w==
X-Gm-Message-State: AOAM531FiRwFWZjh+bdfX5QbwMXGPn/NRCx3rKQew/IR0SMab646oAqu
        IgKqWeYGrKXoeLDPhJQGfgNiDQ==
X-Google-Smtp-Source: ABdhPJyWGhYeTawrb2iZh9Ih4jaPrXSO/th1mCCRBsrXwf165fBDV2d5M0QFUf/rq4I6yaT1KwCJbw==
X-Received: by 2002:a05:620a:110d:: with SMTP id o13mr10179617qkk.348.1621576849968;
        Thu, 20 May 2021 23:00:49 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id n18sm4049165qkh.13.2021.05.20.23.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:00:49 -0700 (PDT)
Date:   Fri, 21 May 2021 10:00:45 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next 00/11] bpfilter
Message-ID: <20210521060045.ldwluzdt3vyp5vfs@amnesia>
References: <20210517225308.720677-1-me@ubique.spb.ru>
 <7312CC5D-510B-4BFD-8099-BB754FBE9CDF@fb.com>
 <20210520075323.ehagaokfbazlhhfj@amnesia>
 <CAADnVQJbxTikruisH=nfsFrC1UZW5zTXr8bUrL+U0jMBSApTTw@mail.gmail.com>
 <2D15A822-5BE1-4C4A-84B2-46FFA27AC32B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D15A822-5BE1-4C4A-84B2-46FFA27AC32B@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 05:56:30PM +0000, Song Liu wrote:
> 
> 
> > On May 20, 2021, at 9:55 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> > On Thu, May 20, 2021 at 12:53 AM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >> 
> >> On Thu, May 20, 2021 at 04:54:45AM +0000, Song Liu wrote:
> >>> 
> >>> 
> >>>> On May 17, 2021, at 3:52 PM, Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >>>> 
> >>>> The patchset is based on the patches from David S. Miller [1] and Daniel
> >>>> Borkmann [2].
> >>>> 
> >>>> The main goal of the patchset is to prepare bpfilter for iptables'
> >>>> configuration blob parsing and code generation.
> >>>> 
> >>>> The patchset introduces data structures and code for matches, targets, rules
> >>>> and tables.
> >>>> 
> >>>> It seems inconvenient to continue to use the same blob internally in bpfilter
> >>>> in parts other than the blob parsing. That is why a superstructure with native
> >>>> types is introduced. It provides a more convenient way to iterate over the blob
> >>>> and limit the crazy structs widespread in the bpfilter code.
> >>>> 
> >>> 
> >>> [...]
> >>> 
> >>>> 
> >>>> 
> >>>> 1. https://lore.kernel.org/patchwork/patch/902785/
> >>> 
> >>> [1] used bpfilter_ prefix on struct definitions, like "struct bpfilter_target"
> >>> I think we should do the same in this version. (Or were there discussions on
> >>> removing the prefix?).
> >> 
> >> There were no discussions about it.
> >> As those structs are private to bpfilter I assumed that it is
> >> safe to save some characters.
> >> I will add the prefix to all internal structs in the next
> >> iteration.
> > 
> > For internal types it's ok to skip the prefix otherwise it's too verbose.
> > In libbpf we skip 'bpf_' prefix in such cases.
> 
> Do we have plan to put some of this logic in a library? If that is the case, the 
> effort now may save some pain in the future. 

I cannot imagine a case when we need this logic in a library.
Even if we eventually need it as these definitions are private to
bpfilter - amount of pain should be minimal.

> 
> Thanks,
> Song
> 

-- 

Dmitrii Banshchikov
