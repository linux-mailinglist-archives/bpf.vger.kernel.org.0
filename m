Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A795F69D6
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 16:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiJFOlN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 10:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiJFOlM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 10:41:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38575AA37D
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 07:41:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b4so3065225wrs.1
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cIvD4SIeJoCk360pl02Pzwin/1fMLrYpDwvLvoLUIhc=;
        b=8G1iPQiThztiVXysP820f5cmCxYqykewjF8pk4aHTcWbgGcIWU4Tquq5u/2QVXbG/J
         WdONjK6bc2lFytl0XLDcBEP5obf2L4H0s8lUrjLRDYsqAddpozwrC7tpUgMkhmZNrJZl
         EUdbTLIIFAgSRzmA9HleVA+ZVpwuVg7oNE2wXmndSlcBMpaRAaV7ZZZfpcpbJ6RbKa5Z
         uyoiS9FggKRl1MqmzeNVG6qo7pdCJPXV3LhEFd0kYncExcc8b49sr2QR9Xu1kmrsxYoE
         JaspjbjIutZ+ALzQI5v1zbORR+xXPoBpoDqdM758EYcjgdkp6f2nE5qrZ8lSZbBB5ZrK
         csmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cIvD4SIeJoCk360pl02Pzwin/1fMLrYpDwvLvoLUIhc=;
        b=vhwOke2pc7SzoCK/FEprFS0M2AWCoi9jMz6KCbaMNsAKfQAhan+8PnpCcUX1L6aXvV
         +F8113yueIQcRVRfTR6tFGLfC7pgoTUD5VkzC5KcAsoZ6/GlN0GiyG6pBVSPcGgj1Puz
         sb2wXFr4QEqAXa+1S0Y3SmPHkOKfTprHkA0W9Y/mPmaA+lcDLAxEjkfjIwP5WmIX+6+W
         O2Imp6FX/fhBWLwGuOnD/zM2muvxkJqXybvDs2pdICJHtkMbjOWPhI8OcfW4F/FkyGY3
         8JeIX1E98w4gflK13dgiZJerSU0fnMg46zj3bOLClR+Zx99ObhtUBhvJv/aJni0x2Z6M
         /Iqw==
X-Gm-Message-State: ACrzQf1V0EZhCe6eo3KfxNtVrfgRgz1axGwr01AhkjOTumFvV/xQ5NIn
        qszUfy06t1cKWpa+JzKZ/VUoSFZpakDi5bYznNplrQ==
X-Google-Smtp-Source: AMsMyM7eq2vsFrtfQHah5Exz9HgPq1ucEj0BUaR89bJQXEjyjbpk3I+xwRH7c6D1f4YTGh7MJr5dWPR9xlQI8B8kpVY=
X-Received: by 2002:a5d:584d:0:b0:22b:229:7582 with SMTP id
 i13-20020a5d584d000000b0022b02297582mr185193wrf.211.1665067269753; Thu, 06
 Oct 2022 07:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221004231143.19190-1-daniel@iogearbox.net> <20221004231143.19190-2-daniel@iogearbox.net>
 <20221006050053.pbwo72xtzoza6gfl@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20221006050053.pbwo72xtzoza6gfl@macbook-pro-4.dhcp.thefacebook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 6 Oct 2022 10:40:52 -0400
Message-ID: <CAM0EoMnJzP6kbr94utjDT1X=e9G21-uu=Cbqhx2XLfqXE+HDwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/10] bpf: Add initial fd-based API to attach tc
 BPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, john.fastabend@gmail.com,
        joannelkoong@gmail.com, memxor@gmail.com, toke@redhat.com,
        joe@cilium.io, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 6, 2022 at 1:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 05, 2022 at 01:11:34AM +0200, Daniel Borkmann wrote:

>
> I cannot help but feel that prio logic copy-paste from old tc, netfilter and friends
> is done because "that's how things were done in the past".
> imo it was a well intentioned mistake and all networking things (tc, netfilter, etc)
> copy-pasted that cumbersome and hard to use concept.
> Let's throw away that baggage?
> In good set of cases the bpf prog inserter cares whether the prog is first or not.
> Since the first prog returning anything but TC_NEXT will be final.
> I think prog insertion flags: 'I want to run first' vs 'I don't care about order'
> is good enough in practice. Any complex scheme should probably be programmable
> as any policy should. For example in Meta we have 'xdp chainer' logic that is similar
> to libxdp chaining, but we added a feature that allows a prog to jump over another
> prog and continue the chain. Priority concept cannot express that.
> Since we'd have to add some "policy program" anyway for use cases like this
> let's keep things as simple as possible?
> Then maybe we can adopt this "as-simple-as-possible" to XDP hooks ?
> And allow bpf progs chaining in the kernel with "run_me_first" vs "run_me_anywhere"
> in both tcx and xdp ?

You just described the features already offered by tc opcodes + priority.

This problem is solvable by some user space resource arbitration scheme.
Reading through the thread - a daemon of some sort will do. A daemon
which issues tokens that can be validated in the kernel (kerberos type
of approach) would be the best i.e fds alone dont resolve this.

cheers,
jamal
