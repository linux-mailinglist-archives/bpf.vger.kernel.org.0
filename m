Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E576B41BD44
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 05:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbhI2DTA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbhI2DS6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 23:18:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA7C061745
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 20:17:18 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j14so550484plx.4
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hwK9T6fsSfOAiPPGKTKaR0RbJaAeTYNzmjOlW7jitEY=;
        b=nFIdHLGCLVCRPjTWGrKXIzVcs1vPMTKnkzRudQ6LRvtB/KcN3Kd3HRaUuTy08SLuz3
         RfuThN1rubhjbTqq9WHaa9Dtn/DmJjC/SG+ok4YqcfUJ5l6H+Gt5chGqvXmJoNMDLCCu
         YXn6BPMq/yhKMJIWNdAhamSrmQQMxvb06htrK2vgEqeh8zqDVH6zpZWLhEoqMZ4bO16p
         c5GYS0QzAZYMKD3qcHspB6sV/fXbjVKtrZ/4M+Xg14eMWhxk/8YoWN9TDwKNuOBgkVpX
         1CaC1TiqTztBL/dCPtRouTbLRJsohqoKu2mTjXmOptRWaOkkeK58YQVJl/KvL/bnS7uP
         3u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hwK9T6fsSfOAiPPGKTKaR0RbJaAeTYNzmjOlW7jitEY=;
        b=3cv+mgiETApIRTqfzu4kJwHzTMhMKx1tMvOqNcyjy7RvB6IEvBQo7P+bogvtkE3s31
         g0zqJGoAaflx1uZytvYY7mxDzX9PJKxjScgqQENBl3purEYgq8x/Pmxv+2iQDM3+wlnD
         4Ys1LVSyUMBJxi+18axbl8lr9xzwyfxXbv5n4uu6YPhR5NCc5DCv25LCdbBUcUvqo8EY
         5IYShiW7xQX5fvCbf2UPrmWotofT8kz5ig1NaLD4evUFtz9n7jQtrNqDytd7r6DkZwKb
         5c10BExA8TT6kjfNY0aX6ESjcAo9SK41OWVrObzitJXvQrlYa3VWky+ipGXAVnGMgCSB
         5K9A==
X-Gm-Message-State: AOAM5339GDAul2dcF4fhLdUyfRyxfKfnPLyyj2xplMM144nuR2rP0zN3
        /f1kYVgQP+Q/5tCpk8FVdLg=
X-Google-Smtp-Source: ABdhPJziNJWcx5papsOv3tcpe7IcnAuypMQ1UzKuy1HgPdL8YbzRCFutow54i7+01mW3xVEcR1Y+gA==
X-Received: by 2002:a17:90a:5295:: with SMTP id w21mr3778668pjh.31.1632885437808;
        Tue, 28 Sep 2021 20:17:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:bbe4])
        by smtp.gmail.com with ESMTPSA id c206sm469321pfc.220.2021.09.28.20.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:17:17 -0700 (PDT)
Date:   Tue, 28 Sep 2021 20:17:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210929031715.wvicuaf6iixm7xsb@ast-mbp.dhcp.thefacebook.com>
References: <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
 <20210927164110.gg33uypguty45huk@ast-mbp.dhcp.thefacebook.com>
 <CAEf4Bzb7bASQ3jXJ3JiKBinnb4ct9Y5pAhn-eVsdCY7rRus8Fg@mail.gmail.com>
 <20210927235144.7xp3ngebl67egc6a@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY=yrSZFJ_dgeS5MSn+pTR+Y9d4am2v+Uby-TBGn4i+Cg@mail.gmail.com>
 <20210928162125.qsidw3zkzsfy4ms2@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbH8v2m4tJEz2hFU+PGxMxP6QrFXcRmD3ESiQi_jqBbtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbH8v2m4tJEz2hFU+PGxMxP6QrFXcRmD3ESiQi_jqBbtw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 05:14:55PM -0700, Andrii Nakryiko wrote:
> 
> So for Bloom filter you get performance advantage from a dedicated map
> (due to having just 1 helper call to do N hashing operations). For
> pure bitset, there seems to be little benefit at all because it is
> basically ARRAY.

I brought up bitset only as an idea to make bloomfilter map a bit more
generic and was looking for feedback whether to call the new map
"bitset that allows bloomfilter operations" or call it
"bloomfilter that simplifies to bitset" with nr_hashes=0.

It sounds that using bloomfilter as a base name fits better.

> I haven't found SPDX header or any mention of GPL in
> include/linux/jhash.h, so I assumed someone can just copy paste the
> code (given the references to public domain). Seems like that's not
> the case? Just curious about implications, license-wise, if there is
> no SPDX? Is it still considered GPL?

I believe so. Every project that copy pasted jhash from the kernel
add SPDX gpl-2 to its source.
