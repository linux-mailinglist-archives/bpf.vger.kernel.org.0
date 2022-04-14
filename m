Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D45004C9
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 05:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiDNDsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 23:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbiDNDsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 23:48:18 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60AD53A48
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 20:45:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VA0LxQ2_1649907950;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VA0LxQ2_1649907950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Apr 2022 11:45:51 +0800
Date:   Thu, 14 Apr 2022 11:45:48 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: [Question] bpf map value increase unexpectedly with tracepoint
 qdisc/qdisc_dequeue
Message-ID: <20220414034548.GA27766@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <20220413140629.GA22650@L-PF27918B-1352.localdomain>
 <CAEf4BzYvBHwsFrp52ZqhP=H1WDdpEeovJcgctv2nioAvBg6FBw@mail.gmail.com>
 <20220414020709.GA27635@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414020709.GA27635@L-PF27918B-1352.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 10:07:09AM +0800, Wu Zongyong wrote:
> On Wed, Apr 13, 2022 at 12:30:51PM -0700, Andrii Nakryiko wrote:
> > On Wed, Apr 13, 2022 at 12:08 PM Wu Zongyong
> > <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > Hi,
> > >
> > > I tried to count when tracepoint qdisc/qdisc_dequeue hit each time, then read
> > > the count value from userspace by bpf_map_lookup_elem().
> > > With bpftrace, I can see this tracepoint is hit about 700 times, but the count
> > > I get from the bpf map is below 20. It's weird. Then I tried to add a bpf_printk()
> > > to the program, and the count I get is normal which is about 700.
> > >
> > > The bpf program codes like that:
> > >
> > >         struct qdisc_dequeue_ctx {
> > >                 __u64           __pad;
> > >                 __u64           qdisc;
> > >                 __u64           txq;
> > >                 int             packets;
> > >                 __u64           skbaddr;
> > >                 int             ifindex;
> > >                 __u32           handle;
> > >                 __u32           parent;
> > >                 unsigned long   txq_state;
> > >         };
> > >
> > >         struct {
> > >                 __uint(type, BPF_MAP_TYPE_HASH);
> > >                 __type(key, int);
> > >                 __type(value, __u32);
> > >                 __uint(max_entries, 1);
> > >                 __uint(pinning, LIBBPF_PIN_BY_NAME);
> > >         } count_map SEC(".maps");
> > >
> > >         SEC("tracepoint/qdisc/qdisc_dequeue")
> > >         int trace_dequeue(struct qdisc_dequeue_ctx *ctx)
> > >         {
> > >                 int key = 0;
> > >                 __u32 *value;
> > >                 __u32 init = 0;
> > >
> > >                 value = bpf_map_lookup_elem(&count_map, &key);
> > >                 if (value) {
> > >                         *value += 1;
> > >                 } else {
> > >                         bpf_printk("value reset");
> > >                         bpf_map_update_elem(&count_map, &key, &init, 0);
> > >                 }
> > >                 return 0;
> > >         }
> > >
> > > Any suggestion is appreciated!
> > >
> > 
> > First, why do you use HASH map for single-key map? ARRAY would make
> > more sense for keys that are small integers. But I assume your real
> > world use case needs bigger and more random keys, right?
> >
> Yes, this just is a simple test.
> 
> > 
> > Second, you have two race conditions. One, you overwrite the value in
> > the map with this bpf_map_update_elem(..., 0). Use BPF_NOEXISTS for
> > initialization to avoid overwriting something that another CPU already
> > set. Another one is your *value += 1 is non-atomic, so you are loosing
> > updates as well. Use __sync_fetch_and_add(value, 1) for atomic
> > increment.
> 
> __sync_fetch_and_add do solve my problem. Thanks!

Oh, sorry!
The count value is about 700 when I do a bpf_printk() in my bpf program
and with a background command "cat /sys/kernel/debug/tracing/trace_pipe".

If I remove the bpf_printk() or don't read the trace_pipe, the count
value shows abnormal, for example, about 10.

As your suggestion, the code now is:

	value = bpf_map_lookup_elem(&count_map, &key);
        if (!value) {
                bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXIST);
                value = bpf_map_lookup_elem(&count_map, &key);
        }
        if (!value)
                return 0;

        bpf_printk("hello");    // I don't know why this affect the count value read from userspace

        __sync_fetch_and_add(value, 1);


> 
> I have tried to use spinlock to prevent race conditions, but it seems
> that spinlock cannot be used in tracepoint.
> 
> > 
> > Something like this:
> > 
> > value = bpf_map_lookup_elem(&count_map, &key);
> > if (!value) {
> >     /* BPF_NOEXIST won't allow to override the value that's already set */
> >     bpf_map_update_elem(&count_map, &key, &init, BPF_NOEXISTS);
> >     value = bpf_map_lookup_elem(&count_map, &key);
> > }
> > if (!value)
> >     return 0;
> > 
> > __sync_fetch_and_add(value, 1);
> > 
> > 
> > > Thanks,
> > > Wu Zongyong
