Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456AC275D01
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgIWQL7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgIWQL7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 12:11:59 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63916C0613D1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:11:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h17so286984otr.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWzl/EC6q1pepHIHQi8YGbYrZy43GP7bLV6xiCO5CnY=;
        b=pBaRxKZY6Bq2LG6skyZ0ElNlD3I6//8Tv7LZ7nCwhl+ieLIbsPkxkcsnt9Ev4Q1/dZ
         VzCRsuwVuGKIcAPSgazwokeiQ63BxqmpXK/xFIazF4AQwF3nfvWnYk7cjxKnkkVpoOqf
         rsQXyL3NEaFTZ8Ib6YNGYCAT7T3SXQBkdsjY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWzl/EC6q1pepHIHQi8YGbYrZy43GP7bLV6xiCO5CnY=;
        b=B4J35qeFdFgkWSjVOLIZO6hSn0zkU2vv5mX/MiZ0t1lsLKdaCAi1IxF97QgFPbcnrv
         VlFrkYrV5nsnSSUdEOzvG5OlwPiuIU7PQuPlpHDbdSeizXGacj570chu+i2dFL1gjYTa
         Careu52g9KfRmG/N3xQKGTFjPSiDIQiR8P58FSdndEqsUbP/YSNudDIwUG5kKCmKbpXm
         DMn6a6AcvqpQCl9B+mqfvD61ibnetvmj5Zq6fhN34Jsw9w+owmdlOS3pRiIauLKOLbdE
         FohncBUJ0/skIQDg3PFCJJjeGbKHxerulWyKik23jOcvJPQoPhOwbQlq6//3+cxxUxEG
         4rDA==
X-Gm-Message-State: AOAM531Fm1GhNfalRkgOtyRdfyABJ5gqMIR5Apl9oCkVwHwX1U368vN1
        toylbUcIfJao2z0gil6QJUXQW6NC4+4icO1rx59JeQ==
X-Google-Smtp-Source: ABdhPJxy/3/VR1e4GrSjqMPRO34URDmZ6fFIeChhcGylh80eAg8kX60nx9dCxpNmw/vexEssXy4qmLm0gc5DHRcvyM0=
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr260459otr.147.1600877517353;
 Wed, 23 Sep 2020 09:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200916211010.3685-1-maciej.fijalkowski@intel.com> <CAADnVQLEYHZLeu-d4nV5Px6t+tVtYEgg8AfPE5-GwAS1uizc0w@mail.gmail.com>
In-Reply-To: <CAADnVQLEYHZLeu-d4nV5Px6t+tVtYEgg8AfPE5-GwAS1uizc0w@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 23 Sep 2020 17:11:46 +0100
Message-ID: <CACAyw994v0BFpnGnboVVRCZt62+xjnWqdNDbSqqJHOD6C-cO0g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 0/7] bpf: tailcalls in BPF subprograms
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 18 Sep 2020 at 04:26, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
>
> Lorenz,
> if you can test it on cloudflare progs would be awesome.

Our programs all bpf_tail_call from the topmost function, so no calls
from subprogs. I stripped out our FORCE_INLINE flag, recompiled and
ran our testsuite. cls_redirect.c (also in the kernel selftests) has a
test failure that I currently can't explain, but I don't have the time
to look at it in detail right now.

Hopefully I can get back to this next week.

Best
Lorenz

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
