Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15652CB4BA
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 06:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLBFyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLBFyj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 00:54:39 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F44C0613CF;
        Tue,  1 Dec 2020 21:53:59 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so707174iov.8;
        Tue, 01 Dec 2020 21:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Myk/BHn+AdgLfa4SnUnxoiBLM1PbY9Aoe0sfjdufMOE=;
        b=mRve+Hxvr/+mtvbF6XnweP1Rb4cOKr6QIH+KPCVK+GwC6jsZI1eYtt+IGBMDIKHsXM
         8AefwSSl9BgrYBYnkxsDgdCR6vv4tegeOsLVQhjzyvVPmdlvvaQYEpXHjUwFUpltp/DA
         cj8n3Yjq77JsC5/RrV5kLshQsWt9V6vrj3fm/P/nrwMymUvH8cCgmhHayNRAq84MxwEC
         Sod7ozBuarzF3JSK1Dkb9Y2TTiuzHSgTBB3lVJ36YDW3G63t4DfCH7rXvvnf928ldRr2
         OuZIqdSSHNkCP3fmRN6ci8Ur1/vzsAshoHAXt3HZv64M8r+VM3dTcx7jRs2IFu2+DMBv
         LRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Myk/BHn+AdgLfa4SnUnxoiBLM1PbY9Aoe0sfjdufMOE=;
        b=AWT0YE9p1J8SS5hpDSXUGW/DOkVyCkAhPJBaIfRD6c+0t8b09nq+kOmuHbzdtKrWLb
         eIga9x/9KjFZvh6ZUMztGd0QhS42N6SDn6yx2vK214UpkMr8K9NLX+ly1vZ+N4eIZtbR
         fPXe5Z9K5Gy/sglavhm/lRX6L2sH9lWGgJVjC4KdsdWB+Et8tRD2WqxMdMs/V03SxKgG
         HLesVcnqFIBb0WwgmhczITLOwOwQ82Q2S7qL4GwWjOONvSHgD1z/wu9NHH5oSUw4az+a
         npGu79qwYQrqAO4dpRXUdGmM9iP6IiN13+JrForEOwGNCRIXfvcRQr0OSmNVGvR5Ergr
         v9xg==
X-Gm-Message-State: AOAM5327WbtPrqodZC9pTDMx9FTsxZrpf+YHiGInWIkfPAfweWM27pVC
        wU4XYU3qCdZJ5qVpqCT/JaQ=
X-Google-Smtp-Source: ABdhPJwTgegQjwQpv4wjXBZmlbLq8+3Bu56tzHu9kiMurs8qa5BJoa+muIL1qu6LKX8mMHbdNJCbyg==
X-Received: by 2002:a02:834b:: with SMTP id w11mr783851jag.5.1606888438506;
        Tue, 01 Dec 2020 21:53:58 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id y6sm360312ilm.23.2020.12.01.21.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:53:57 -0800 (PST)
Date:   Tue, 01 Dec 2020 21:53:50 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Message-ID: <5fc72beede900_15eb720850@john-XPS-13-9370.notmuch>
In-Reply-To: <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <829353e6-d90a-a91a-418b-3c2556061cda@fb.com>
 <20201129014000.3z6eua5pcz3jxmtk@ast-mbp>
 <b3903adc-59c6-816f-6512-2225c28f47f5@fb.com>
 <4fa9f8cf-aaf8-a63c-e0ca-7d4c83b01578@fb.com>
 <CAEf4BzYc=c_2xCMFAE6RjMCHKWJj2euP2B21y-jfvsNzPVkhpQ@mail.gmail.com>
 <31a67edd-4837-cfd3-c9fe-a6942ebd87bb@fb.com>
Subject: Re: [PATCH v2 bpf-next 00/13] Atomics for eBPF
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> 
> 

[...]

> > Great, this means that all existing valid uses of
> > __sync_fetch_and_add() will generate BPF_XADD instructions and will
> > work on old kernels, right?
> 
> That is correct.
> 
> > 
> > If that's the case, do we still need cpu=v4? The new instructions are
> > *only* going to be generated if the user uses previously unsupported
> > __sync_fetch_xxx() intrinsics. So, in effect, the user consciously
> > opts into using new BPF instructions. cpu=v4 seems like an unnecessary
> > tautology then?
> 
> This is a very good question. Essentially this boils to when users can 
> use the new functionality including meaningful return value  of 
> __sync_fetch_and_add().
>    (1). user can write a small bpf program to test the feature. If user
>         gets a failed compilation (fatal error), it won't be supported.
>         Otherwise, it is supported.
>    (2). compiler provides some way to tell user it is safe to use, e.g.,
>         -mcpu=v4, or some clang macro suggested by Brendan earlier.
> 
> I guess since kernel already did a lot of feature discovery. Option (1)
> is probably fine.

For option (2) we can use BTF with kernel version check. If kernel is
greater than kernel this lands in we use the the new instructions if
not we use a slower locked version. That should work for all cases
unless someone backports patches into an older case.

At least thats what I'll probably end up wrapping in a helper function.
