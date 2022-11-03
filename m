Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB655618AB7
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiKCVjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKCVjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:39:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D413E8E
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:39:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id o65so2494440iof.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3QN9qDodq/aU5tlCSzzroSH+1NsZzZo1uA0chP0Tws=;
        b=PDJ8wyvkq/Ie8hcdLJqtN18Xen2j7nrSLcOtaNEAkFcGSHL/2oLxznK2EdHjYgbTh8
         ZaSayvgcY1LQ/8oWKpHi310Tm05QM0WNZQJufgs77NPksn3snuf8LG8kCu6W7dxTPzB3
         qkrlov3T4VyyPFpOjmiBw2l010M9LKLYxsjthI4zdTfdYW0wLwKkbx0LoNo/y8hNs84C
         8xKN9xO/mzkM5Dbzq8zHvYssjMUBDqKxyCGbkLu2X9tbz2CkOBuisnpFNsfkvO2A37Do
         cbANjh2Kf2VJ/23F+m+T+HGDC5JbHNk7nUgP2aWxeabJVChzhspdeuxOoZ2+hn6bFoc6
         KIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3QN9qDodq/aU5tlCSzzroSH+1NsZzZo1uA0chP0Tws=;
        b=gqBzq477N+oflzphpna1ZWo8CY+wYTJ9MAdC/dut7axUXCNwfGszVGWWeLntD1H8O/
         +xhGgJPQl7XTlOBKB9mnsUeRux+s5tb8K+Y6Y2HsVtOh2D0HW/yZirVUN1SKq2TqowbI
         CrOy4lwrwRBXUYfzU3opPDRKCmZ16CijGwpISbH6f705GxoSTuPQZK5I6XCEYpCs++s5
         CPNv7AO6dLWq8AatiHLCOZUb7z+5HFTz9GP/yVOEEKQh13qQezL9YG7PMuOtNrXYgBoe
         qx5mj0gSqwAJCgvTTtLYNmcTDPppgr44QiZf7oFmQWY8NYSG2i4kAU0JWbSSITT4SC5j
         htcA==
X-Gm-Message-State: ACrzQf0+mBM2hbc3c28lYV7v3zm2lHYmI+/PtOBoUYD1b+ALwxrWRf+o
        Nx3FdLiL+j0NdnaV7DrjgbUXRvkYg1Ijl8p0fUwpgA==
X-Google-Smtp-Source: AMsMyM61NlIm/gVSRMqzHMipWB7KJn7cV6LWUXDXmyAhDen+qFHchTTmn1qGt1QnB7/7fg0CVexvuWPZ5zjoSPZbhsE=
X-Received: by 2002:a05:6602:13d5:b0:6d6:1ea:3b0c with SMTP id
 o21-20020a05660213d500b006d601ea3b0cmr2826052iov.16.1667511549268; Thu, 03
 Nov 2022 14:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221027225537.353077-1-sdf@google.com> <2efac61c-a477-d3c1-4270-3c98998e6497@linux.dev>
 <CAKH8qBt1QPBLh1Yg+oA-qdQjND9Zp04z6tK9vjDkSMRqbhh24A@mail.gmail.com>
 <1393c4d0-89e0-e5b7-9f40-2c646f2ea2e9@linux.dev> <5de93174-6e27-1d0b-6ff1-b63c6141b6a2@linux.dev>
In-Reply-To: <5de93174-6e27-1d0b-6ff1-b63c6141b6a2@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 3 Nov 2022 14:38:58 -0700
Message-ID: <CAKH8qBt5d7fJH6Anw1BHK8YyKjkw3jsR_6Bi01YqGRRxfuGP6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: make sure skb->len != 0 when redirecting to
 a tunneling device
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, Lorenz Bauer <oss@lmb.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 3, 2022 at 2:32 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/1/22 5:43 PM, Martin KaFai Lau wrote:
> > On 11/1/22 4:39 PM, Stanislav Fomichev wrote:
> >> On Tue, Nov 1, 2022 at 1:28 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>>
> >>> On 10/27/22 3:55 PM, Stanislav Fomichev wrote:
> >>>> syzkaller managed to trigger another case where skb->len == 0
> >>>> when we enter __dev_queue_xmit:
> >>>>
> >>>> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len
> >>>> include/linux/skbuff.h:2576 [inline]
> >>>> WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576
> >>>> __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295
> >>>>
> >>>> Call Trace:
> >>>>    dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
> >>>>    __bpf_tx_skb net/core/filter.c:2115 [inline]
> >>>>    __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
> >>>>    __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
> >>>>    ____bpf_clone_redirect net/core/filter.c:2447 [inline]
> >>>>    bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
> >>>>    bpf_prog_48159a89cb4a9a16+0x59/0x5e
> >>>>    bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
> >>>>    __bpf_prog_run include/linux/filter.h:596 [inline]
> >>>>    bpf_prog_run include/linux/filter.h:603 [inline]
> >>>>    bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
> >>>>    bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
> >>>>    bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
> >>>>    __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
> >>>>    __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
> >>>>    __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
> >>>>    __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
> >>>>    do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> >>>>    entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>>
> >>>> The reproducer doesn't really reproduce outside of syzkaller
> >>>> environment, so I'm taking a guess here. It looks like we
> >>>> do generate correct ETH_HLEN-sized packet, but we redirect
> >>>> the packet to the tunneling device. Before we do so, we
> >>>> __skb_pull l2 header and arrive again at skb->len == 0.
> >>>> Doesn't seem like we can do anything better than having
> >>>> an explicit check after __skb_pull?
> >>> hmm... I recall there was similar report but I didn't follow those earlier fixes
> >>> and discussion.  Not sure if this has been considered:
> >>> If this skb can only happen in the bpf_prog_test_run (?),
> >>> how about ensure that the skb will at least have some header after l2 header in
> >>> bpf_prog_test_run_skb().  Adding some headers/bytes if the data_size_in does not
> >>> have it.  This may break some external test cases that somehow has no l3/4?
> >>> test_progs should be mostly fine considering they are using the pkt_v[46] in
> >>> network_helpers.h.
> >>
> >> For the previous issue we've added "skb->len != 0" check which works
> >> for the cases that remove l2.
>
> Yeah, I replied on the "bpf: Don't redirect packets with invalid pkt_len" thread
> which is hitting the same syzbot report afaict.  I don't think that patch is
> actually fixing it.
>
> >> For the ones that don't, I think you're right, and checking at the
> >> time of bpf_prog_test_run_skb can probably be enough, lemme try
> >> (require ETH_HLEN+1 vs ETH_HLEN).
> >> For some reason I was under the impression that Lorenz changed the
> >> size from 0 to 14 [0], but he went from 14 to 15, so we won't break at
> >> least cilium again..
> >> CC'd him just in case.
> >>
> >> 0: https://github.com/cilium/ebpf/pull/788
> >
> > Thanks for the pointer.
> >
> > The cilium's prog is SOCKET_FILTER (not l2).  It is why the new "skb->len != 0"
> > test broke it.
> >
> >>
> >>> Adding some headers/bytes if the data_size_in does not have it.
> >>> This may break some external test cases that somehow has no l3/4?
> >>
> >> Yeah, idk, this seems like a last resort? I'd prefer to explicitly
> >> fail and communicate it back to the user than slap some extra byte and
> >> then fail in some other place unpredictably?
> >
> > If fixing in the fast path in filter.c, is __bpf_redirect_no_mac the only place
> > that needs this check?  bpf_redirect_neigh() looks ok to me since the neigh
> > should have filled the mac header.
>
> I took a closer look.  This seems to be the only place needed the check, so
> applied.  If it turns out there are other cases caused by test-run generated
> skb, we will revisit a fix in test_run.c and the existing tests have to adjust.
>
> >
> >>
> >>>> Cc: Eric Dumazet <edumazet@google.com>
> >>>> Reported-by: syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
> >>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>>> ---
> >>>>    net/core/filter.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/net/core/filter.c b/net/core/filter.c
> >>>> index bb0136e7a8e4..cb3b635e35be 100644
> >>>> --- a/net/core/filter.c
> >>>> +++ b/net/core/filter.c
> >>>> @@ -2126,6 +2126,10 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb,
> >>>> struct net_device *dev,
> >>>>
> >>>>        if (mlen) {
> >>>>                __skb_pull(skb, mlen);
> >>>> +             if (unlikely(!skb->len)) {
> >>>> +                     kfree_skb(skb);
> >>>> +                     return -ERANGE;
> >>>> +             }
>
> One question, if the "!skb->len" check is deleted from convert___skb_to_skb(),
> this "unlikely(!skb->len)" block here has to be moved out of the "if (mlen)"?

I see, yeah, that might be the alternative. I'm assuming
__bpf_redirect_common is covered by "skb->mac_header >=
skb->network_header" check?
