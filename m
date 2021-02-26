Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01D7326990
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 22:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBZVan (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZVal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 16:30:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66555C061756
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:30:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h19so12680035edb.9
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oq+ziV5W+4fEB7+AhqNfzmL/v56Klno9yJ5KkNDHbIk=;
        b=lgCtW/Yjv2mimZpK+rAl0afo5lamoHgXB1ZyR3nf/HIVD3AkIrzv8F68PpHt4s4RoC
         DDJoegJdMQ2Tcae3+I6sSpnDorPEb11zApmi29GJPNjLCdN2no5i2PdSMSaZnfbb7+yo
         YRFEySb1DigFpXmu2Q7g0DWZzrBhqyptwEO8IinjATl71E69DE0Y3r3qZqj4zQfsndB6
         OMgjNIpKEG7cxVanbYHd6ZRNRd8pcTNFxCSJtYeyj8d0bNIylOAOuTf2dyl40im30IoH
         ElkJK6JOR3Y5vL7jzdVWrc/6XtmvTdkeKIgENLsdSUtuhj5AgMsVl7g9N4btIliIudx9
         WvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oq+ziV5W+4fEB7+AhqNfzmL/v56Klno9yJ5KkNDHbIk=;
        b=fbhO+Mmg8zqRqgSCd6qDGEGnvejpQ7IROKVfG34l+28lySeOahtYc2FuQ0/Gak21P8
         AjU+n0AU1wx3dg27xrQiVEfc7SnrEQTxp4NcncQpLVCFiYlIArY8kV5Q6V13Hw7Bu0sZ
         ZN4vP+MnI8+sx0QVOUeAiM6oV6GES5HJN/SSL0tl2QZzLH2C40B+9/Ib7M4C47781Xpo
         rfP6aCXA2rsHaTwjan23Jn+E0pbYMMMl4mwZtmzKZBs+v53awOfymgY8xKxyVv+OYRdk
         eJm7GvluhBWNH8ojFxEv8KT+f3Q3kglShTQ8qXnwz/yXsCpdk5h18ARAuFg/Go6zdG+f
         y/OQ==
X-Gm-Message-State: AOAM5311AO4ldCvmV4YIJbrel5XSJmZJmFLUlbgQdRoEEHjhi6DBuYkF
        PCHrUAl15MIS5F3bujOShGDp9fdmutM=
X-Google-Smtp-Source: ABdhPJxcPSSxgvyi7/20l6UBx2E+148xmZzbGF7jUlxfRYnBOozlVMhlT+afV+a61gaK4LTN0e/ksQ==
X-Received: by 2002:aa7:d89a:: with SMTP id u26mr5612248edq.17.1614374999854;
        Fri, 26 Feb 2021 13:29:59 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id b17sm6001809ejj.9.2021.02.26.13.29.59
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:29:59 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id e10so9679130wro.12
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 13:29:59 -0800 (PST)
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr5220400wra.419.1614374998947;
 Fri, 26 Feb 2021 13:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20210226035721.40054-1-hxseverything@gmail.com> <CAM_iQpUAc5sB1xzqE7RvG5pQHQeCPJx5qAz_m9LaJYZ4pKfZsQ@mail.gmail.com>
In-Reply-To: <CAM_iQpUAc5sB1xzqE7RvG5pQHQeCPJx5qAz_m9LaJYZ4pKfZsQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 26 Feb 2021 16:29:21 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfrE_brf_KO+swvsqTVGuoXYhPNTvnyK-1gC8PxSKneUA@mail.gmail.com>
Message-ID: <CA+FuTSfrE_brf_KO+swvsqTVGuoXYhPNTvnyK-1gC8PxSKneUA@mail.gmail.com>
Subject: Re: [PATCH/v3] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Xuesen Huang <hxseverything@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 3:15 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 7:59 PM Xuesen Huang <hxseverything@gmail.com> wrote:
> > v3:
> > - Fix the code format.
> >
> > v2:
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > - Add a new flag to specify the type of the inner packet.
>
> These need to be moved after '---', otherwise it would be merged
> into the final git log.
>
> >
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> > Signed-off-by: Zhiyong Cheng <chengzhiyong@kuaishou.com>
> > Signed-off-by: Li Wang <wangli09@kuaishou.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  net/core/filter.c              | 11 ++++++++++-
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 20 insertions(+), 1 deletion(-)
>
> As a good practice, please add a test case for this in
> tools/testing/selftests/bpf/progs/test_tc_tunnel.c.

That's a great idea. This function covers a lot of cases. Can use the
code coverage against regressions.

With that caveat, looks great to me, thanks.
