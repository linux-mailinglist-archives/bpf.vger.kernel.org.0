Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C776501D8B
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 23:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiDNVgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 17:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiDNVgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 17:36:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E345041
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 14:34:17 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q22so369259iod.2
        for <bpf@vger.kernel.org>; Thu, 14 Apr 2022 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ajfbei70n1eakG/CMRgKfGveodlgBmo54/WZM9kSu6M=;
        b=IUDc85PyKG5ch4+7GAZfMXwEREfIYp7ctJh+LfE4ELvfePe7zoxkXe5TomTeuCPVrY
         PSjyb50ykA0CEIky1XukHC+G9CW6Z1Mog0FzKF1XKCuF90WGT/GDxxTKj5IiBwPDveSE
         VoXYgFfspmGH26NyI5TPBwQI9dAss6oRECXivQsRJ5Qo6a83ESSUXEpf9yJ6v/8UQeGh
         hL3R1Zlf8+9UfxdsSHTQMkK3kTcEKAZNM43F59lKcliMduzUtT2aJ1Ds5Mu3Ho13QF7S
         T1gPZGL1+n5Gf55/IACgffg7Y/mCzdqN64th2WP6qL0DfR90Km9/qM7jlHiVunvNB3+5
         /TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ajfbei70n1eakG/CMRgKfGveodlgBmo54/WZM9kSu6M=;
        b=w32LaXrgndPBo9G8L4e0hSohKFeuInyLT4D9CeRN8RHezyUpSMm4+Hkblzq/WoTICv
         ijiM7y40075MqVum3EHxegNt83lqI+YRXaDJ+AbKPtSrl5SnsX1iZqzXH+15EiZ2rkbM
         re2QDaMmDSHxMR/1zFRgamwCHyKEGoO9v56KFBv6I6lHLgkdfuw7NYQbbXRRJMyltUoQ
         MncedKSgxKBkER4wqhTuc99Lm+ywNN/2AFTMDJxOCAgGGzP16YvgYmnu8h4AQ7YYTaO6
         rIRRXqRgLeQ+ErebXB1f8niZC3cr1J1+elx8afS6gIf3RytFd1CqbCQPHojwy9bgfkA+
         fFmA==
X-Gm-Message-State: AOAM532Rhnwnw5CehJjDr5i5AmwNAfDTA0vaJ7bPOsgltBXqFigTnVZt
        St/e5MWSq0BuCAwWGFg3Z+N6hqvCJLgNilgbBUKijaVU
X-Google-Smtp-Source: ABdhPJwHekfnZWdkiGCG4uIoBHkd2pz96sqEwFihey4mGoIXxw/Rc6ZaaFifY8wi7o6G1gIQKS7Zp6J64X2J2PkGB6o=
X-Received: by 2002:a05:6638:1696:b0:326:2d59:7b40 with SMTP id
 f22-20020a056638169600b003262d597b40mr2113805jat.103.1649972056612; Thu, 14
 Apr 2022 14:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220413140629.GA22650@L-PF27918B-1352.localdomain>
 <CAEf4BzYvBHwsFrp52ZqhP=H1WDdpEeovJcgctv2nioAvBg6FBw@mail.gmail.com>
 <20220414020709.GA27635@L-PF27918B-1352.localdomain> <20220414034548.GA27766@L-PF27918B-1352.localdomain>
In-Reply-To: <20220414034548.GA27766@L-PF27918B-1352.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Apr 2022 14:34:05 -0700
Message-ID: <CAEf4BzZVeT=4nU+hCCZKjHiuxpNDxKmPr6g=Cfk+R4jqKdbBFA@mail.gmail.com>
Subject: Re: [Question] bpf map value increase unexpectedly with tracepoint qdisc/qdisc_dequeue
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 8:45 PM Wu Zongyong

<wuzongyong@linux.alibaba.com> wrote:
>
> On Thu, Apr 14, 2022 at 10:07:09AM +0800, Wu Zongyong wrote:
> > On Wed, Apr 13, 2022 at 12:30:51PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Apr 13, 2022 at 12:08 PM Wu Zongyong
> > > <wuzongyong@linux.alibaba.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I tried to count when tracepoint qdisc/qdisc_dequeue hit each time, then read
> > > > the count value from userspace by bpf_map_lookup_elem().
> > > > With bpftrace, I can see this tracepoint is hit about 700 times, but the count
> > > > I get from the bpf map is below 20. It's weird. Then I tried to add a bpf_printk()
> > > > to the program, and the count I get is normal which is about 700.
> > > >
> > > > The bpf program codes like that:
> > > >
> > > >         struct qdisc_dequeue_ctx {
> > > >                 __u64           __pad;
> > > >                 __u64           qdisc;
> > > >                 __u64           txq;
> > > >                 int             packets;
> > > >                 __u64           skbaddr;
> > > >                 int             ifindex;
> > > >                 __u32           handle;
> > > >                 __u32           parent;
> > > >                 unsigned long   txq_state;
> > > >         };
> > > >
> > > >         struct {
> > > >                 __uint(type, BPF_MAP_TYPE_HASH);
> > > >                 __type(key, int);
> > > >                 __type(value, __u32);
> > > >                 __uint(max_entries, 1);
> > > >                 __uint(pinning, LIBBPF_PIN_BY_NAME);
> > > >         } count_map SEC(".maps");
> > > >
> > > >         SEC("tracepoint/qdisc/qdisc_dequeue")
> > > >         int trace_dequeue(struct qdisc_dequeue_ctx *ctx)
> > > >         {
> > > >                 int key = 0;
> > > >                 __u32 *value;
> > > >                 __u32 init = 0;
> > > >
> > > >                 value = bpf_map_lookup_elem(&count_map, &key);
> > > >                 if (value) {
> > > >                         *value += 1;
> > > >                 } else {
> > > >                         bpf_printk("value reset");
> > > >                         bpf_map_update_elem(&count_map, &key, &init, 0);
> > > >                 }
> > > >                 return 0;
> > > >         }
> > > >
> > > > Any suggestion is appreciated!
> > > >
> > >
> > > First, why do you use HASH map for single-key map? ARRAY would make
> > > more sense for keys that are small integers. But I assume your real
> > > world use case needs bigger and more random keys, right?
> > >
> > Yes, this just is a simple test.
> >
> > >
> > > Second, you have two race conditions. One, you overwrite the value in
> > > the map with this bpf_map_update_elem(..., 0). Use BPF_NOEXISTS for
> > > initialization to avoid overwriting something that another CPU already
> > > set. Another one is your *value += 1 is non-atomic, so you are loosing
> > > updates as well. Use __sync_fetch_and_add(value, 1) for atomic
> > > increment.
> >
> > __sync_fetch_and_add do solve my problem. Thanks!
>
> Oh, sorry!
> The count value is about 700 when I do a bpf_printk() in my bpf program
> and with a background command "cat /sys/kernel/debug/tracing/trace_pipe".
>
> If I remove the bpf_printk() or don't read the trace_pipe, the count
> value shows abnormal, for example, about 10.

Not clear, is it 10 even with __sync_fetch_and_add()?

As for why bpf_printk() makes a difference. One reason might be
because bpf_trace_printk() (called from bpf_printk() macro) takes
trace_printk_lock, which introduces a bit of synchronization point,
which reduces this race window. But it might be something else, don't
know.

>
> As your suggestion, the code now is:
>
>         value = bpf_map_lookup_elem(&count_map, &key);
>         if (!value) {
>                 bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXIST);
>                 value = bpf_map_lookup_elem(&count_map, &key);
>         }
>         if (!value)
>                 return 0;
>
>         bpf_printk("hello");    // I don't know why this affect the count value read from userspace
>
>         __sync_fetch_and_add(value, 1);
>
>
> >
> > I have tried to use spinlock to prevent race conditions, but it seems
> > that spinlock cannot be used in tracepoint.
> >
> > >
> > > Something like this:
> > >
> > > value = bpf_map_lookup_elem(&count_map, &key);
> > > if (!value) {
> > >     /* BPF_NOEXIST won't allow to override the value that's already set */
> > >     bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXISTS);
> > >     value = bpf_map_lookup_elem(&count_map, &key);
> > > }
> > > if (!value)
> > >     return 0;
> > >
> > > __sync_fetch_and_add(value, 1);
> > >
> > >
> > > > Thanks,
> > > > Wu Zongyong
