Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA30400D68
	for <lists+bpf@lfdr.de>; Sun,  5 Sep 2021 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhIDXCX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Sep 2021 19:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhIDXCX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 4 Sep 2021 19:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630796480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uNhzLsF4iRWK4KsXwkGsahNdu3Yt13aVCLJA26yT90U=;
        b=LKI3g4I+Pe6lnpwcQ/7iD4hMt53t18nxMbeihHKMCL1AGDUU0wdXQem3D3ZOs+WywdKCHq
        dMajALImuk/ECkePBUkbaw4ylmvFpmxozrQiFB+HL8rDFcncGdBvTQMBhjz7rSRP27E1AN
        LqlpDlBBQAixcmh4qkkJuzg8j28gyVE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-6JQt9OY9MOaa87o-wJmOXQ-1; Sat, 04 Sep 2021 19:01:19 -0400
X-MC-Unique: 6JQt9OY9MOaa87o-wJmOXQ-1
Received: by mail-oo1-f72.google.com with SMTP id w9-20020a4aca09000000b0028b7adc5bd2so1898004ooq.11
        for <bpf@vger.kernel.org>; Sat, 04 Sep 2021 16:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uNhzLsF4iRWK4KsXwkGsahNdu3Yt13aVCLJA26yT90U=;
        b=QdYrJCj8Se6IWwQh0QQJhmOvHp8oKHlySryQyKH2U3egNRorBYtF67z/8eZEHceylE
         aPg/tQyD7P2aV0KK+XkigtuvjedzpiEJYtVha6uhdvRM75NEgRstD5OjKhptfkjlEUYO
         KP/RSD19vs+kXycnqSG6a+vhJ7NQ00Y+irjbyMPFUJB+1j7SOw1t4unJWdtWuMxOD3XE
         J0YhyGaBFowza8RyibOHTNzIqL166AKfvIWLCcM0wPxNNhJyPArNRxk9RNdVyNN2GSCb
         TAS+/gH8SuBCLTtAodX++vzdoPyO9TA/HMU85bDcvhGwjVw1Fsmz+j6Ar9W4WBM+0n8c
         PhpQ==
X-Gm-Message-State: AOAM531IDT5AAvrTuPkbI1RU/8gcazOwroeHVhThSRAWkF3Ylw5m0j+7
        KE6OLpB2p2nnDEexcAb1D6MGU86ZLt4+87o4iLocoQHuN/Dj0AggA7b9ettCkmmkx9rKCd9besJ
        vOwL6G2VKgSgs
X-Received: by 2002:aca:f189:: with SMTP id p131mr4014157oih.128.1630796478483;
        Sat, 04 Sep 2021 16:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1y6WtwxTzsPd1+RG3rtgXo0yUpy4975hviEF9fX0AdiAL/t5/DD8MaFp8ZPnY4qXfMSfhXw==
X-Received: by 2002:aca:f189:: with SMTP id p131mr4014132oih.128.1630796478273;
        Sat, 04 Sep 2021 16:01:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id bi41sm691621oib.54.2021.09.04.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 16:01:17 -0700 (PDT)
Date:   Sat, 4 Sep 2021 16:01:13 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Message-ID: <20210904230113.cpjota2sttx2w7aa@treble>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <719D2DC2-CC5D-4C6A-94F4-DBCADDA291CC@fb.com>
 <YS0eXMd5Y5yV/m1m@hirez.programming.kicks-ass.net>
 <YS+0eIeAJsRRArk4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS+0eIeAJsRRArk4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 01, 2021 at 07:12:24PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 30, 2021 at 08:07:24PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 30, 2021 at 05:41:46PM +0000, Song Liu wrote:
> > > DECLARE_STATIC_CALL(perf_snapshot_branch_stack,
> > >                    int (*)(struct perf_branch_snapshot *));
> > 
> > > Something like 
> > > 
> > > typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_snapshot *);
> > > DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
> > > 
> > > seems to work fine. 
> > 
> > Oh urg, indeed. It wants a function type, not a function pointer type.
> > I've been bitten by that before. Go with the typedef, that's the sanest.
> 
> The below is the best I can make of it... it's a little inconsistent and
> somewhat tricky, but at least the compiler yells hard if you get it
> wrong.
> 
> I can *almost* get to: DEFINE_STATIC_CALL(foo, &func), except for
> ARCH_DEFINE_STATIC_CALL_TRAMP() which needs the actual function name
> string for the ASM :-(
> 
> The rest can do with a function pointer type and have it work.

Seems reasonable to me.

-- 
Josh

