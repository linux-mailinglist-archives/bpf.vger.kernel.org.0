Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC361562C
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiKAXj4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 19:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKAXjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 19:39:54 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FD1A832
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 16:39:53 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p184so13713232iof.11
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mEybnH2UhRzD4auUi0wSDxENyyFO/HWEpbnVaPepQh8=;
        b=OZlJbS+WzRxq3jUxV0ElWsbLMBIiQO7kdHFPdN9VB42vCZA/rTLsO4iLtZgpsEUoD9
         rJKVlSwIE4jtO+UvvYUGMoUNM/o3cEjmBfluv6lB5nszp+t/iHNgE7aMM1TXgOVKDlay
         Ct1SfRd2Y9tCiyVLMGaazJp1mBjx7amSiZFDJ7YUvW8uSLRH7X3UaekwyMplabAsfIz8
         MNhLQjXdrJ3JR/6X25N+jSMWTfvHOGFD6WPDXXyatoL+rxhv5PcDF8A8wWRdFR3Ov4WT
         ugq9dp233gYGlZcxmIGHr1srjtpHJ2vl9OzQy2XZFuD6Cq+gydY+3d+KH0gW+TzV/YG+
         3ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mEybnH2UhRzD4auUi0wSDxENyyFO/HWEpbnVaPepQh8=;
        b=QnGSLp5fLyFEBtMWU83lCBEE/iXAVA6Mhd8mhb3SSkGF/CADM3bUVV1MUdkns+hL+X
         XruoMvpncnJvqnxoJenOxsV1Oj/pwlqwIvfCbaTl7Fw03emeth0aYCh9tFGfMayJ5+DY
         5OYPaR8aQif/gQjaA3DWzZHHFaIFLCljhUSXiGeUX16tQ8sBF0n2UpbcrMgBhZdOk9P8
         eP9O+8I9udlR8f+Oy+TIonll2sdpLFgtaw1oitQAJvro/tsHJASRD0OehgqVpzpkEKFe
         SKgrwilW+gLuGntvo2pN8mMOPv9K3nVNQYOb6w5zSNGbhIZ8S1PzHQxZtJ8oykJ6tZye
         MARA==
X-Gm-Message-State: ACrzQf1YNXrAj4ZEey90BQRj3eI3kREhu8Kp3eAZyTMdNezAivEZlNcV
        yb4EadGrp1rGfkfuGdtZWyg6ivZA5/XhnBI5k5O2mg==
X-Google-Smtp-Source: AMsMyM7lBAbHHYStD57NU2sxF+27b4MrDso9tV5DCLGAyEkOUC/hF04hokwcWHlFfcfMivZ/9tiSNId5xhdAgR3+m0A=
X-Received: by 2002:a02:ccf3:0:b0:375:3e51:5e2d with SMTP id
 l19-20020a02ccf3000000b003753e515e2dmr13750721jaq.179.1667345992651; Tue, 01
 Nov 2022 16:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221027225537.353077-1-sdf@google.com> <2efac61c-a477-d3c1-4270-3c98998e6497@linux.dev>
In-Reply-To: <2efac61c-a477-d3c1-4270-3c98998e6497@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 1 Nov 2022 16:39:41 -0700
Message-ID: <CAKH8qBt1QPBLh1Yg+oA-qdQjND9Zp04z6tK9vjDkSMRqbhh24A@mail.gmail.com>
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

On Tue, Nov 1, 2022 at 1:28 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/27/22 3:55 PM, Stanislav Fomichev wrote:
> > syzkaller managed to trigger another case where skb->len == 0
> > when we enter __dev_queue_xmit:
> >
> > WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 skb_assert_len include/linux/skbuff.h:2576 [inline]
> > WARNING: CPU: 0 PID: 2470 at include/linux/skbuff.h:2576 __dev_queue_xmit+0x2069/0x35e0 net/core/dev.c:4295
> >
> > Call Trace:
> >   dev_queue_xmit+0x17/0x20 net/core/dev.c:4406
> >   __bpf_tx_skb net/core/filter.c:2115 [inline]
> >   __bpf_redirect_no_mac net/core/filter.c:2140 [inline]
> >   __bpf_redirect+0x5fb/0xda0 net/core/filter.c:2163
> >   ____bpf_clone_redirect net/core/filter.c:2447 [inline]
> >   bpf_clone_redirect+0x247/0x390 net/core/filter.c:2419
> >   bpf_prog_48159a89cb4a9a16+0x59/0x5e
> >   bpf_dispatcher_nop_func include/linux/bpf.h:897 [inline]
> >   __bpf_prog_run include/linux/filter.h:596 [inline]
> >   bpf_prog_run include/linux/filter.h:603 [inline]
> >   bpf_test_run+0x46c/0x890 net/bpf/test_run.c:402
> >   bpf_prog_test_run_skb+0xbdc/0x14c0 net/bpf/test_run.c:1170
> >   bpf_prog_test_run+0x345/0x3c0 kernel/bpf/syscall.c:3648
> >   __sys_bpf+0x43a/0x6c0 kernel/bpf/syscall.c:5005
> >   __do_sys_bpf kernel/bpf/syscall.c:5091 [inline]
> >   __se_sys_bpf kernel/bpf/syscall.c:5089 [inline]
> >   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5089
> >   do_syscall_64+0x54/0x70 arch/x86/entry/common.c:48
> >   entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > The reproducer doesn't really reproduce outside of syzkaller
> > environment, so I'm taking a guess here. It looks like we
> > do generate correct ETH_HLEN-sized packet, but we redirect
> > the packet to the tunneling device. Before we do so, we
> > __skb_pull l2 header and arrive again at skb->len == 0.
> > Doesn't seem like we can do anything better than having
> > an explicit check after __skb_pull?
> hmm... I recall there was similar report but I didn't follow those earlier fixes
> and discussion.  Not sure if this has been considered:
> If this skb can only happen in the bpf_prog_test_run (?),
> how about ensure that the skb will at least have some header after l2 header in
> bpf_prog_test_run_skb().  Adding some headers/bytes if the data_size_in does not
> have it.  This may break some external test cases that somehow has no l3/4?
> test_progs should be mostly fine considering they are using the pkt_v[46] in
> network_helpers.h.

For the previous issue we've added "skb->len != 0" check which works
for the cases that remove l2.
For the ones that don't, I think you're right, and checking at the
time of bpf_prog_test_run_skb can probably be enough, lemme try
(require ETH_HLEN+1 vs ETH_HLEN).
For some reason I was under the impression that Lorenz changed the
size from 0 to 14 [0], but he went from 14 to 15, so we won't break at
least cilium again..
CC'd him just in case.

0: https://github.com/cilium/ebpf/pull/788

> Adding some headers/bytes if the data_size_in does not have it.
> This may break some external test cases that somehow has no l3/4?

Yeah, idk, this seems like a last resort? I'd prefer to explicitly
fail and communicate it back to the user than slap some extra byte and
then fail in some other place unpredictably?

> > Cc: Eric Dumazet <edumazet@google.com>
> > Reported-by: syzbot+f635e86ec3fa0a37e019@syzkaller.appspotmail.com
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   net/core/filter.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bb0136e7a8e4..cb3b635e35be 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2126,6 +2126,10 @@ static int __bpf_redirect_no_mac(struct sk_buff *skb, struct net_device *dev,
> >
> >       if (mlen) {
> >               __skb_pull(skb, mlen);
> > +             if (unlikely(!skb->len)) {
> > +                     kfree_skb(skb);
> > +                     return -ERANGE;
> > +             }
> >
> >               /* At ingress, the mac header has already been pulled once.
> >                * At egress, skb_pospull_rcsum has to be done in case that
>
