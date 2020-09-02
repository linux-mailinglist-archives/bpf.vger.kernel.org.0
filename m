Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFCD25B472
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 21:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIBTcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 15:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBTcK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 15:32:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A9C061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 12:32:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f127so440521lfd.7
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH4XKkEgGbSll51FkdLqlTjLkM+Hz+KxHBuKks/wLK4=;
        b=Zd0lkWWxJyDy3tv1U0Jez8JXo4EpxheyqB4FC8oZC97r1wO70c9yxBNaiIlZtSa06I
         3yWSnZRuuUoJUDgWspBqv4E3UX7TV2YZY+BJ+0InslezgGZN3Y4U9ryt+VRNXz/9XvNo
         P7FQe1UFW3JGRdM1W1+RQ3jJbniSuh+uVzJOwpvwCu3mSr2zOdz01hJ8jVr8hwLE0lOt
         KFX12RFnSfdRplYj/S9PldA2ht+L3EntkxcO7J1Up38ho8aFr05nfWqTXN10I4SmrmJG
         16nIMdtBKM9v9SJfx22ZH6KFckgxWgeupLLGeyI9H2dlXPtwPTDU5Kca4C2gZ8H0EIzT
         MWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH4XKkEgGbSll51FkdLqlTjLkM+Hz+KxHBuKks/wLK4=;
        b=PyCeT9IuyIfCyTPDLqqLMvJZCbrkGdj7XdRtiRqajx94y0ZlwiN4hPV2ml5Je+yttE
         YjHCCCwoEeL/ceulpbboYksxGORRwbHMkaq3fpzndvx8oFeeHSF5o4wGl15CNBFbRe2J
         O1goYDMxjscTAIIrQw155FTW04JV6LZSr6EX4LgJP/6RP20pEgZ59/STNjJ0xzrQKUdz
         +hiGMNo/H9xnx8+lYpxywMKqKSkvuRkXzxh+5qaMVBOekl/c8pL1Zwfbyq0EzGjQSInL
         ALamRZ2kYOXwAEnjntOuemC4KBL0kEQqcAyQ7vRW/ZsJriScqzRirPTG+vF/CBeFwMmf
         OiBA==
X-Gm-Message-State: AOAM530TBqZrDjvwwvfSYurFLptY48p4oAM1XrHSgmjvo5Xsb8JlpTeY
        PxKuXP3i2O0EBSgPShdX0ItgzAPwr0q1Gv4MMHs=
X-Google-Smtp-Source: ABdhPJyCHTYidwO2t0YeBfeSseVCjKMPjUrtG2pw9iYRqyOisE7Lhk3N9M/V8NQ5VfIfeyrMx5NFwAtojaGBYCr2NOM=
X-Received: by 2002:ac2:5327:: with SMTP id f7mr2589385lfh.8.1599075124829;
 Wed, 02 Sep 2020 12:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <87mu282gay.fsf@oracle.com>
In-Reply-To: <87mu282gay.fsf@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Sep 2020 12:31:53 -0700
Message-ID: <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
Subject: Re: EF_BPF_GNU_XBPF
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 2, 2020 at 11:22 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello BPF people!
>
> In order to ease the testing of the GCC bpf port we are adding a number
> of extensions to the BPF ISA.
>
> We would like to use one bit in the e_flags field of the ELF header in
> order to flag that the code in the ELF file is not plain eBPF:
>
> For EM_BPF:
>
> #define EF_BPF_GNU_XBPF 0x00000001
>
> Any objection?

I've looked at your lpc slides and the extensions don't look like BPF
extensions.
At least I didn't see any attempt to make them verifiable.
In that sense it's not BPF and it's not correct to use EM_BPF for it.
I suggest to define your own EM for your ISA.
