Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6897D30E13D
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBCRid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 12:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBCRia (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 12:38:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4F4C061573;
        Wed,  3 Feb 2021 09:37:50 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f19so17550ljn.5;
        Wed, 03 Feb 2021 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3q+UPAtENPnhUZTyBdBqprfk1+k/9wHkbmh6uMGkygA=;
        b=jxbXaerWzmnj9ICX44F5qlZWWt+k0oqRudED27GB+NLY+8bpHekdblE0Mm06JIiy39
         n11fblEGb6zIi36Ar+UqdblvoUmYtcsHZ4DYA5l0ZkWMJUulXyFh5Z9aKtymUuwppq0q
         eQLAO1PvKnxj32FslPBOBW1GU8BhzJCrSW1IbYNVk5vDSQSCSp2Oe76E5oY0gMJ9mw2z
         3Wu3PZXDAH7VRO4GTbBXmzMd+XnkDEIhocex9KaoC868l2CosG0+2AwAOG1fIny55JRs
         BndCm7XuY2k/Qzxstr2lJ59dXmJSEC3UVY5fr8YXVQUAH1AEPzp/H9WtS/lU58xNRj9/
         IaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3q+UPAtENPnhUZTyBdBqprfk1+k/9wHkbmh6uMGkygA=;
        b=ip/WJyMLkUog6eY2K/LpjZAO+wgvAKhPYNqQg1g4MBYgJAUl+4ztDf2WwM1rHtmBhE
         05v3rCwjr0dvgZQ780lbuJ/P1BRM2nsktb5sNk6Jy4May3I7w2MyxrprPulAmvHMEtdK
         Q/dM6Y+YTJhY6x+Jhox06BNYxye5RhWMCMOHJhpoUnj2U3O6UT+Bhtv+3+0tie4OP7r7
         00Eoo513Nd73aVYY1VpBP6hMeLq5fGL4E0jIijhoXItiJQ4z/6k3Vq0tPX6wzjtk2sRT
         wik+/VGL6CJkLrT18MwvJq+Gno3ZXmNdie4olU3XVbw3jxim03ilCf5mSb+Ev+VxTkUP
         M1GA==
X-Gm-Message-State: AOAM533tpu8GOusE2+TMCPcceWsZKmSFFY5jpLhdgyov7PF3Psk1aUBW
        DiB/qKZuQuMgzxWQZxVI2wfK+0WvSIADadUbwrKLuEzU
X-Google-Smtp-Source: ABdhPJzoIX1w5qTGwHd+UeZvX+UUlWH/gojsSF/e9+apOZSMSSNxnPr2krku08s19F3iPL2OR7BtZW/BPkBlM2vKxKU=
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr2272461ljn.486.1612373868842;
 Wed, 03 Feb 2021 09:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20210202135002.4024825-1-jackmanb@google.com> <3160ff36-3f5b-e278-0ce8-b5a4aa61417f@fb.com>
In-Reply-To: <3160ff36-3f5b-e278-0ce8-b5a4aa61417f@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 3 Feb 2021 09:37:37 -0800
Message-ID: <CAADnVQL4S_XbyNEFrX9+6ew_6wyMZfQXW8t7pHu1eLdY0mgtJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Propagate stack bounds to registers in
 atomics w/ BPF_FETCH
To:     Yonghong Song <yhs@fb.com>
Cc:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 9:07 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/2/21 5:50 AM, Brendan Jackman wrote:
> > When BPF_FETCH is set, atomic instructions load a value from memory
> > into a register. The current verifier code first checks via
> > check_mem_access whether we can access the memory, and then checks
> > via check_reg_arg whether we can write into the register.
> >
> > For loads, check_reg_arg has the side-effect of marking the
> > register's value as unkonwn, and check_mem_access has the side effect
> > of propagating bounds from memory to the register. This currently only
> > takes effect for stack memory.
> >
> > Therefore with the current order, bounds information is thrown away,
> > but by simply reversing the order of check_reg_arg
> > vs. check_mem_access, we can instead propagate bounds smartly.
> >
> > A simple test is added with an infinite loop that can only be proved
> > unreachable if this propagation is present. This is implemented both
> > with C and directly in test_verifier using assembly.
> >
> > Suggested-by: John Fastabend <john.fastabend@gmail.com>
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
>
> Ack with a nit below.

Sorry it was already applied yesterday.
patchbot just didn't send auto-reply.
