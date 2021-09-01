Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D23FD191
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 04:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbhIAC4u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 22:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhIAC4s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Aug 2021 22:56:48 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1359C061575
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 19:55:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q68so1272646pga.9
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 19:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AOF/PyWcybkN1VAidtyE1ugBmiXC/YOxl+qIQGZcGKU=;
        b=Lw2zwgGYx9RiYAkYQtSkKOQGpGxMLSPtTHu84H8iqgkpjfa3J4ho2UUPKy03JXPMJy
         WRsoMPZqo8VAjntWccJKN/yt0sls00OKTxngV4RWauUGYRNUpTUsZeSTwo0/FGNUF7Jf
         bEYP6KuIBowVgg0alWZk4PWsxGCjpuSa1O9b33YkkQKYpalcX/nMe6WJtWrnfBAGUYbI
         OLvJOqXDh9eRPYbIEi3cr5ySAHj7yZQCz2Mt5TipgkTC9vkAjIc1+Tc37QxAE5ka89wX
         9sbhJuk1FlQZd9hjcWh2mtj2xNtw3CYnrK9TwlMwTQS27wrYE0T8AFs/d0P3dA9HSuGF
         ZaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOF/PyWcybkN1VAidtyE1ugBmiXC/YOxl+qIQGZcGKU=;
        b=cwRvwRDsa8B0TEojRy/IHv3iIhoU1kPm1vonL/nP/A1ngzGNRhyWGwU/vIZYqpwUtZ
         rXRSF+r/61Ypf33jHoM6CrIM8551Xp3Cgs86Mixs1ilho4p9p3q9BMzYOLOqBQ1SVoYG
         SdTafb56+ETBCRwl4+G2e2yPXsJbNvzevuyZ9yJm503mdUdlRAhAjuHGWwgYOt9sMW0+
         tJIWdJtFOfG3qUEe4wpJTr6qjK7cKpQ990RYfsy0wdPGbXhrx2oeALphunxY9oTP1UST
         u11gCBUzclDMzYagHdW6EEqWRwa1Dk4aMdl6ezqEYyJfTdWdHVBp0fGzlnq+DmgQDVa+
         uPkA==
X-Gm-Message-State: AOAM53387wpn/vh7+SQA1EwyOAI5UDhJEIXkx6Ypb4d4n7XV8O9yQmDw
        H4D1BFKdxwPBM7/2RkYrvmw=
X-Google-Smtp-Source: ABdhPJw1j0l+jU15E5JtUiyBriGn+Hj9yBSHOPyXrGcBajoJqDvHQuTVDXobkHB0M6m2AE8Lxkk1lA==
X-Received: by 2002:aa7:9413:0:b0:3f6:e49e:5ca2 with SMTP id x19-20020aa79413000000b003f6e49e5ca2mr22779042pfo.22.1630464952404;
        Tue, 31 Aug 2021 19:55:52 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:121f])
        by smtp.gmail.com with ESMTPSA id e5sm391688pjv.44.2021.08.31.19.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:55:52 -0700 (PDT)
Date:   Tue, 31 Aug 2021 19:55:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: Add bloom filter map test
 cases
Message-ID: <20210901025549.rqz2tsepibrlbf7g@ast-mbp.dhcp.thefacebook.com>
References: <20210831225005.2762202-1-joannekoong@fb.com>
 <20210831225005.2762202-4-joannekoong@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831225005.2762202-4-joannekoong@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 31, 2021 at 03:50:03PM -0700, Joanne Koong wrote:
> +++ b/tools/testing/selftests/bpf/progs/bloom_filter_map.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-3.0

typo :)
