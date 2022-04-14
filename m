Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB35003D2
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 03:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiDNBxL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 21:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiDNBxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 21:53:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3E222A0
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 18:50:47 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p21so3924960ioj.4
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 18:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xl9w1l2oo+sk/eBLMxGxZCvBdicGIrirC0HC6XDv7y8=;
        b=QH3o4ihT4/V3LmKcoSijLJ01kRG5uq6tUFrzJflB3hFkdZsJMMQE/BA41GL7+yy9w+
         q25qs94/pVpMrKko8ozHgK4/jSFOyzZVcgN0KXeBuWdlJauaI64DTICQ/JhxSXDekNDt
         BqQNqWPfgj99cJ2wF3KUDyUigzo+vpuD9LYpHQZerLFjTahRhElVfa7rXOVUhMsu+rsB
         h1pOxKXc2JM707jgOlaG4Sf8yJN1FOQjpIIvnsgmofIfrjMcY9R0Qp1TYgQN2iLCC3sC
         Gr3oFPhnY7eWQG25RflFwYUkP6bZVZjrWVaF3u43v4zDZRDZUkVHD+Yvy7xn6FuExmRJ
         bnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xl9w1l2oo+sk/eBLMxGxZCvBdicGIrirC0HC6XDv7y8=;
        b=F0t9sUribhCU0KpA8YQXtR+bDyNCcLQwIbGFFT7dfkSzycEO3U43ukbf0sm4xRaL/z
         3brVXyUgrEcyUiZWJZn21ZkhQt9HpEj5s3r/rMy8T7l5we9de9R/RdvsNHiCPYlGSxre
         BU/ZESdErGUvBX+6zIn7pdIhpmtEwRWzgtE/43PLdgrEBmowy5D6m1w8VvAIcht1fYl8
         Iaf1hTruefw8axnoXtAQPKYl9wegCTm6qKYepJjPT3obGXOdJW3pQcCeKzTC2pdUbAXz
         4oOEjP37RbrO5rKuPie1OKiahndi6OX78QxYoj/tjNkAJLW/lQUeRUbcli3lZWexWRh6
         9SUg==
X-Gm-Message-State: AOAM533WWDD+jAHlPiBKTrfGZz1bS9V27ZAUBXEreeN3GMpThwELgT3n
        DFTLq+cJ9OpjtTiKvI/v8VJ8oUsHI1wOUIw8+gTBhOQzx6Aw06yz
X-Google-Smtp-Source: ABdhPJzBBCs6/LWrXHWcpMhc91/C8vSczaB6eUi4dc1VGrYaU2CkWiOQ+xEqkIb6lAJUTGeAi1qKc+3lnNCC5XZ/NTY=
X-Received: by 2002:a5d:874b:0:b0:64c:9859:67d0 with SMTP id
 k11-20020a5d874b000000b0064c985967d0mr243962iol.76.1649901046707; Wed, 13 Apr
 2022 18:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220413140629.GA22650@L-PF27918B-1352.localdomain> <CAEf4BzYvBHwsFrp52ZqhP=H1WDdpEeovJcgctv2nioAvBg6FBw@mail.gmail.com>
In-Reply-To: <CAEf4BzYvBHwsFrp52ZqhP=H1WDdpEeovJcgctv2nioAvBg6FBw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 14 Apr 2022 09:50:10 +0800
Message-ID: <CALOAHbAvikKyrSTm6J9YSP0-7ifkxku2q2FeUsZMyxYdDdCqpg@mail.gmail.com>
Subject: Re: [Question] bpf map value increase unexpectedly with tracepoint qdisc/qdisc_dequeue
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 8:25 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 13, 2022 at 12:08 PM Wu Zongyong
> <wuzongyong@linux.alibaba.com> wrote:
> >
> > Hi,
> >
> > I tried to count when tracepoint qdisc/qdisc_dequeue hit each time, then read
> > the count value from userspace by bpf_map_lookup_elem().
> > With bpftrace, I can see this tracepoint is hit about 700 times, but the count
> > I get from the bpf map is below 20. It's weird. Then I tried to add a bpf_printk()
> > to the program, and the count I get is normal which is about 700.
> >
> > The bpf program codes like that:
> >
> >         struct qdisc_dequeue_ctx {
> >                 __u64           __pad;
> >                 __u64           qdisc;
> >                 __u64           txq;
> >                 int             packets;
> >                 __u64           skbaddr;
> >                 int             ifindex;
> >                 __u32           handle;
> >                 __u32           parent;
> >                 unsigned long   txq_state;
> >         };
> >
> >         struct {
> >                 __uint(type, BPF_MAP_TYPE_HASH);
> >                 __type(key, int);
> >                 __type(value, __u32);
> >                 __uint(max_entries, 1);
> >                 __uint(pinning, LIBBPF_PIN_BY_NAME);
> >         } count_map SEC(".maps");
> >
> >         SEC("tracepoint/qdisc/qdisc_dequeue")
> >         int trace_dequeue(struct qdisc_dequeue_ctx *ctx)
> >         {
> >                 int key = 0;
> >                 __u32 *value;
> >                 __u32 init = 0;
> >
> >                 value = bpf_map_lookup_elem(&count_map, &key);
> >                 if (value) {
> >                         *value += 1;
> >                 } else {
> >                         bpf_printk("value reset");
> >                         bpf_map_update_elem(&count_map, &key, &init, 0);
> >                 }
> >                 return 0;
> >         }
> >
> > Any suggestion is appreciated!
> >
>
> First, why do you use HASH map for single-key map? ARRAY would make
> more sense for keys that are small integers. But I assume your real
> world use case needs bigger and more random keys, right?
>
> Second, you have two race conditions. One, you overwrite the value in
> the map with this bpf_map_update_elem(..., 0). Use BPF_NOEXISTS for
> initialization to avoid overwriting something that another CPU already
> set. Another one is your *value += 1 is non-atomic, so you are loosing
> updates as well. Use __sync_fetch_and_add(value, 1) for atomic
> increment.
>
> Something like this:
>
> value = bpf_map_lookup_elem(&count_map, &key);
> if (!value) {
>     /* BPF_NOEXIST won't allow to override the value that's already set */
>     bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXISTS);
>     value = bpf_map_lookup_elem(&count_map, &key);
> }
> if (!value)
>     return 0;
>
> __sync_fetch_and_add(value, 1);
>

Hi Andrii,

I'm curious that if we should do it as below,

new_value = *value + 1;
bpf_map_update_elem(&count_map, &key, &new_value, BPF_EXIST);

in case someone, e.g. bpftool, may delete this elem in parallel.

BTW, why don't we have a helper like bpf_map_lookup_elem_value() which
returns the value directly instead of the addr of the value ?

-- 
Thanks
Yafang
