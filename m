Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF30A6CC638
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 17:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjC1P2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjC1P2C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 11:28:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301911648;
        Tue, 28 Mar 2023 08:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB88EB81D75;
        Tue, 28 Mar 2023 15:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856BC433EF;
        Tue, 28 Mar 2023 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680017195;
        bh=oXvvDCyaunVTVYn7N2Vixkpy19o10GalO85q5YlGpwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMcLmdsqpyFR3YaYMhyh7x4sYdD8VcqUa1lFO6Bap34Np6a1F/kdv7YTCVOyNk2si
         tVjb3AFZyNbnc5nnfu7poj/Ll8Qt6ry2DR/G+Zg5bWRP2EVkvWhBpSMkbl4OQ4jPns
         5xDQrNJ2FaThJlrqAOBxCyX9FzHV2LV3pGieJTk/9LvOQa8BkjG0Aodi8osulqges1
         LnSrlkIznkW+M6B28PNxRr/Yt6JGeyMfEironS+N/gusrigTpK1fZeWDx9DAPlCP26
         5admiFFvg3fzeUJQP3Bo/IWQcTe1/lv9htKKmt3Cpv1rtg8Y/Fq1Bd1qli+84HSLIV
         CVqbd7MpLTJTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 710F44052D; Tue, 28 Mar 2023 12:26:32 -0300 (-03)
Date:   Tue, 28 Mar 2023 12:26:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCMHKFdmjVpOSNsJ@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
 <ZCLy0hjyR3KuYy3e@kernel.org>
 <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 28, 2023 at 05:08:48PM +0300, Eduard Zingerman escreveu:
> On Tue, 2023-03-28 at 10:59 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
> > > The following example contains a structure field annotated with
> > > btf_type_tag attribute:
> > > 
> > >     #define __tag1 __attribute__((btf_type_tag("tag1")))
> > > 
> > >     struct st {
> > >       int __tag1 *a;
> > >     } g;
> > > 
> > > It is not printed correctly by `pahole -F dwarf` command:
> > > 
> > >     $ clang -g -c test.c -o test.o
> > >     pahole -F dwarf test.o
> > >     struct st {
> > >     	tag1 *                     a;                    /*     0     8 */
> > >     	...
> > >     };
> > > 
> > > Note the type for variable `a`: `tag1` is printed instead of `int`.
> > > This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
> > > `DW_TAG_LLVM_annotation` objects that are used to encode type tags.
> > 
> > I noticed this:
> > 
> > ⬢[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-clang-pahole-1.25+rust > /tmp/clang
> > ⬢[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-gcc-pahole-1.25+rust > /tmp/gcc
> > 
> > 
> > --- /tmp/gcc    2023-03-28 10:55:37.075999474 -0300
> > +++ /tmp/clang  2023-03-28 10:55:53.324436319 -0300
> > @@ -70,21 +70,21 @@
> >  struct Qdisc {
> >         int                        (*enqueue)(struct sk_buff *, struct Qdisc *, struct sk_buff * *); /*     0     8 */
> >         struct sk_buff *           (*dequeue)(struct Qdisc *); /*     8     8 */
> >         unsigned int               flags;                /*    16     4 */
> >         u32                        limit;                /*    20     4 */
> >         const struct Qdisc_ops  *  ops;                  /*    24     8 */
> > -       struct qdisc_size_table *  stab;                 /*    32     8 */
> > +       struct qdisc_size_table    stab;                 /*    32     8 */
> >         struct hlist_node          hash;                 /*    40    16 */
> >         u32                        handle;               /*    56     4 */
> >         u32                        parent;               /*    60     4 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         struct netdev_queue *      dev_queue;            /*    64     8 */
> > -       struct net_rate_estimator * rate_est;            /*    72     8 */
> > -       struct gnet_stats_basic_sync * cpu_bstats;       /*    80     8 */
> > -       struct gnet_stats_queue *  cpu_qstats;           /*    88     8 */
> > +       struct net_rate_estimator  rate_est;             /*    72     8 */
> > +       struct gnet_stats_basic_sync cpu_bstats;         /*    80     8 */
> > +       struct gnet_stats_queue    cpu_qstats;           /*    88     8 */
> >         int                        pad;                  /*    96     4 */
> >         refcount_t                 refcnt;               /*   100     4 */
> > 
> >         /* XXX 24 bytes hole, try to pack */
> > 
> >         /* --- cacheline 2 boundary (128 bytes) --- */
> > 
> > And:
> > 
> > struct Qdisc {
> >         int                     (*enqueue)(struct sk_buff *skb,
> >                                            struct Qdisc *sch,
> >                                            struct sk_buff **to_free);
> >         struct sk_buff *        (*dequeue)(struct Qdisc *sch);
> >         unsigned int            flags;
> > #define TCQ_F_BUILTIN           1
> > #define TCQ_F_INGRESS           2
> > #define TCQ_F_CAN_BYPASS        4
> > #define TCQ_F_MQROOT            8
> > #define TCQ_F_ONETXQUEUE        0x10 /* dequeue_skb() can assume all skbs are for
> >                                       * q->dev_queue : It can test
> >                                       * netif_xmit_frozen_or_stopped() before
> >                                       * dequeueing next packet.
> >                                       * Its true for MQ/MQPRIO slaves, or non
> >                                       * multiqueue device.
> >                                       */
> > #define TCQ_F_WARN_NONWC        (1 << 16)
> > #define TCQ_F_CPUSTATS          0x20 /* run using percpu statistics */
> > #define TCQ_F_NOPARENT          0x40 /* root of its hierarchy :
> >                                       * qdisc_tree_decrease_qlen() should stop.
> >                                       */
> > #define TCQ_F_INVISIBLE         0x80 /* invisible by default in dump */
> > #define TCQ_F_NOLOCK            0x100 /* qdisc does not require locking */
> > #define TCQ_F_OFFLOADED         0x200 /* qdisc is offloaded to HW */
> >         u32                     limit;
> >         const struct Qdisc_ops  *ops;
> >         struct qdisc_size_table __rcu *stab;
> >         struct hlist_node       hash;
> >         u32                     handle;
> >         u32                     parent;
> > 
> >         struct netdev_queue     *dev_queue;
> > 
> >         struct net_rate_estimator __rcu *rate_est;
> >         struct gnet_stats_basic_sync __percpu *cpu_bstats;
> >         struct gnet_stats_queue __percpu *cpu_qstats;
> >         int                     pad;
> >         refcount_t              refcnt;
> > 
> > 
> > I'll try to fix now.
> 
> Ouch. The fields are annotated with type tags, which are ignored by gcc.
> If this is not urgent I can debug it either later today or tomorrow.

Sure, but look:

> > -       struct qdisc_size_table *  stab;                 /*    32     8 */
> > +       struct qdisc_size_table    stab;                 /*    32     8 */

Its the DW_TAG_pointer_type that is getting lost somehow:

 <1><b0af32>: Abbrev Number: 81 (DW_TAG_structure_type)
    <b0af33>   DW_AT_name        : (indirect string, offset: 0xe825): Qdisc
    <b0af37>   DW_AT_byte_size   : 384
    <b0af39>   DW_AT_decl_file   : 223
    <b0af3a>   DW_AT_decl_line   : 72

<SNIP>

 <2><b0af77>: Abbrev Number: 65 (DW_TAG_member)
    <b0af78>   DW_AT_name        : (indirect string, offset: 0x4745ff): stab
    <b0af7c>   DW_AT_type        : <0xb0b76b>
    <b0af80>   DW_AT_decl_file   : 223
    <b0af81>   DW_AT_decl_line   : 99
    <b0af82>   DW_AT_data_member_location: 32

<SNIP>

<1><b0b76b>: Abbrev Number: 61 (DW_TAG_pointer_type)
    <b0b76c>   DW_AT_type        : <0xb0b77a>
 <2><b0b770>: Abbrev Number: 62 (User TAG value: 0x6000)
    <b0b771>   DW_AT_name        : (indirect string, offset: 0x378): btf_type_tag
    <b0b775>   DW_AT_const_value : (indirect string, offset: 0x6e93): rcu
 <2><b0b779>: Abbrev Number: 0
 <1><b0b77a>: Abbrev Number: 69 (DW_TAG_structure_type)
    <b0b77b>   DW_AT_name        : (indirect string, offset: 0x6e5ed): qdisc_size_table
    <b0b77f>   DW_AT_byte_size   : 64
    <b0b780>   DW_AT_decl_file   : 223
    <b0b781>   DW_AT_decl_line   : 56

 
So it's all there in the DWARF info:

   b0af77 has type 0xb0b76b which is a DW_TAG_pointer_type that has type
   0xb0b77a, that is DW_TAG_structure_type.

Now lets see how this was encoded into BTF:

[4725] STRUCT 'Qdisc' size=384 vlen=28
<SNIP>
        'stab' type_id=4790 bits_offset=256
<SNIP>
[4790] PTR '(anon)' type_id=4789
<SNIP>
[4789] TYPE_TAG 'rcu' type_id=4791
<SNIP>
[4791] STRUCT 'qdisc_size_table' size=64 vlen=5
        'rcu' type_id=320 bits_offset=0
        'list' type_id=87 bits_offset=128
        'szopts' type_id=4792 bits_offset=256
        'refcnt' type_id=16 bits_offset=448
        'data' type_id=4659 bits_offset=480

So it all seems ok, we should keep all the info and teach fprintf to
handle TYPE_TAG.

Which you tried, but somehow the '*' link is missing.

- Arnaldo
