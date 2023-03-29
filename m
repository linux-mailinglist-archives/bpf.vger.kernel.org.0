Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20186CED34
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC2Pn4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjC2Pn4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 11:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7FFE2;
        Wed, 29 Mar 2023 08:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4419961D8F;
        Wed, 29 Mar 2023 15:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC2C433D2;
        Wed, 29 Mar 2023 15:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680104633;
        bh=PayhhRO1vkav4N1ifvU/LSz3rnL+UNjzB3tII3q4XDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anpXQy1Aqn/JydIt13rXSM9bnP7NRchVzPfTckFrZAF/0ORBRY48A/ThGZweLhhPH
         neghCke5IOU1hq8h/+lVFddWCTcDJVDmzsDv49nzWQZhzclX2kSFIEHEFrzUkoxWvG
         eEWsa8bSwqPsQrlrQeYB1KGJDJ7LbYVpRjTDTjTBuzol872GRYx/PlCJlUAgLgss0A
         ftagjGWGu2E6fggbQgFV5oms10JteVW5H5GtvKxx+eC5VszbBQCAzuGPvsMlztfq+p
         eo8iqTiKHX56IkmycsP0i51TXpBPh0Fr6uHdzp1MLkHRbimR1mKhaTmx8uUPvsENBQ
         q5vxSTVnvp08A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37E044052D; Wed, 29 Mar 2023 12:43:50 -0300 (-03)
Date:   Wed, 29 Mar 2023 12:43:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCRctmB2yrwgsNMh@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
 <ZCLy0hjyR3KuYy3e@kernel.org>
 <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
 <ZCMHKFdmjVpOSNsJ@kernel.org>
 <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
 <ZCNZcl1mkC9yhwDD@kernel.org>
 <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 29, 2023 at 06:36:34PM +0300, Eduard Zingerman escreveu:
> On Tue, 2023-03-28 at 18:17 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 28, 2023 at 06:30:05PM +0300, Eduard Zingerman escreveu:
> > > On Tue, 2023-03-28 at 12:26 -0300, Arnaldo Carvalho de Melo wrote:
> > > [...] 
> > > > Sure, but look:
> > > > 
> > > > > > -       struct qdisc_size_table *  stab;                 /*    32     8 */
> > > > > > +       struct qdisc_size_table    stab;                 /*    32     8 */
> > > > 
> > > > Its the DW_TAG_pointer_type that is getting lost somehow:
> > > > 
> > > >  <1><b0af32>: Abbrev Number: 81 (DW_TAG_structure_type)
> > > >     <b0af33>   DW_AT_name        : (indirect string, offset: 0xe825): Qdisc
> > > >     <b0af37>   DW_AT_byte_size   : 384
> > > >     <b0af39>   DW_AT_decl_file   : 223
> > > >     <b0af3a>   DW_AT_decl_line   : 72
> > > > 
> > > > <SNIP>
> > > > 
> > > >  <2><b0af77>: Abbrev Number: 65 (DW_TAG_member)
> > > >     <b0af78>   DW_AT_name        : (indirect string, offset: 0x4745ff): stab
> > > >     <b0af7c>   DW_AT_type        : <0xb0b76b>
> > > >     <b0af80>   DW_AT_decl_file   : 223
> > > >     <b0af81>   DW_AT_decl_line   : 99
> > > >     <b0af82>   DW_AT_data_member_location: 32
> > > > 
> > > > <SNIP>
> > > > 
> > > > <1><b0b76b>: Abbrev Number: 61 (DW_TAG_pointer_type)
> > > >     <b0b76c>   DW_AT_type        : <0xb0b77a>
> > > >  <2><b0b770>: Abbrev Number: 62 (User TAG value: 0x6000)
> > > >     <b0b771>   DW_AT_name        : (indirect string, offset: 0x378): btf_type_tag
> > > >     <b0b775>   DW_AT_const_value : (indirect string, offset: 0x6e93): rcu
> > > >  <2><b0b779>: Abbrev Number: 0
> > > >  <1><b0b77a>: Abbrev Number: 69 (DW_TAG_structure_type)
> > > >     <b0b77b>   DW_AT_name        : (indirect string, offset: 0x6e5ed): qdisc_size_table
> > > >     <b0b77f>   DW_AT_byte_size   : 64
> > > >     <b0b780>   DW_AT_decl_file   : 223
> > > >     <b0b781>   DW_AT_decl_line   : 56
> > > > 
> > > >  
> > > > So it's all there in the DWARF info:
> > > > 
> > > >    b0af77 has type 0xb0b76b which is a DW_TAG_pointer_type that has type
> > > >    0xb0b77a, that is DW_TAG_structure_type.
> > > > 
> > > > Now lets see how this was encoded into BTF:
> > > > 
> > > > [4725] STRUCT 'Qdisc' size=384 vlen=28
> > > > <SNIP>
> > > >         'stab' type_id=4790 bits_offset=256
> > > > <SNIP>
> > > > [4790] PTR '(anon)' type_id=4789
> > > > <SNIP>
> > > > [4789] TYPE_TAG 'rcu' type_id=4791
> > > > <SNIP>
> > > > [4791] STRUCT 'qdisc_size_table' size=64 vlen=5
> > > >         'rcu' type_id=320 bits_offset=0
> > > >         'list' type_id=87 bits_offset=128
> > > >         'szopts' type_id=4792 bits_offset=256
> > > >         'refcnt' type_id=16 bits_offset=448
> > > >         'data' type_id=4659 bits_offset=480
> > > > 
> > > > So it all seems ok, we should keep all the info and teach fprintf to
> > > > handle TYPE_TAG.
> > > > 
> > > > Which you tried, but somehow the '*' link is missing.
> > > 
> > > Yep, thanks a lot for the analysis, I will take a look.
> > > Hopefully will send v2 tomorrow.
> > 
> > So, with the patch below it gets equivalent, but some more tweaking is
> > needed to make the output completely match (spaces, "long usigned" ->
> > "unsigned long", which seems to be all equivalent):
> > 
> > --- /tmp/gcc    2023-03-28 18:13:42.022385428 -0300
> > +++ /tmp/clang  2023-03-28 18:13:45.854486885 -0300
> > @@ -73,15 +73,15 @@
> >         unsigned int               flags;                /*    16     4 */
> >         u32                        limit;                /*    20     4 */
> >         const struct Qdisc_ops  *  ops;                  /*    24     8 */
> > -       struct qdisc_size_table *  stab;                 /*    32     8 */
> > +       struct qdisc_size_table  * stab;                 /*    32     8 */
> >         struct hlist_node          hash;                 /*    40    16 */
> >         u32                        handle;               /*    56     4 */
> >         u32                        parent;               /*    60     4 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         struct netdev_queue *      dev_queue;            /*    64     8 */
> > -       struct net_rate_estimator * rate_est;            /*    72     8 */
> > -       struct gnet_stats_basic_sync * cpu_bstats;       /*    80     8 */
> > -       struct gnet_stats_queue *  cpu_qstats;           /*    88     8 */
> > +       struct net_rate_estimator  * rate_est;           /*    72     8 */
> > +       struct gnet_stats_basic_sync  * cpu_bstats;      /*    80     8 */
> > +       struct gnet_stats_queue  * cpu_qstats;           /*    88     8 */
> >         int                        pad;                  /*    96     4 */
> >         refcount_t                 refcnt;               /*   100     4 */
> > 
> > @@ -96,8 +96,8 @@
> > 
> >         /* XXX 4 bytes hole, try to pack */
> > 
> > -       long unsigned int          state;                /*   216     8 */
> > -       long unsigned int          state2;               /*   224     8 */
> > +       unsigned long              state;                /*   216     8 */
> > +       unsigned long              state2;               /*   224     8 */
> >         struct Qdisc *             next_sched;           /*   232     8 */
> >         struct sk_buff_head        skb_bad_txq;          /*   240    24 */
> > 
> > @@ -112,7 +112,7 @@
> >         /* XXX 40 bytes hole, try to pack */
> > 
> >         /* --- cacheline 6 boundary (384 bytes) --- */
> > -       long int                   privdata[];           /*   384     0 */
> > +       long                       privdata[];           /*   384     0 */
> > 
> >         /* size: 384, cachelines: 6, members: 28 */
> >         /* sum members: 260, holes: 4, sum holes: 124 */
> > @@ -145,19 +145,19 @@
> >         /* XXX 4 bytes hole, try to pack */
> > 
> >         struct netdev_queue *      (*select_queue)(struct Qdisc *, struct tcmsg *); /*     8     8 */
> > -       int                        (*graft)(struct Qdisc *, long unsigned int, struct Qdisc *, struct Qdisc * *, struct netlink_ext_ack *); /*    16     8 */
> > +       int                        (*graft)(struct Qdisc *, unsigned long, struct Qdisc *, struct Qdisc * *, struct netlink_ext_ack *); /*    16     8 */
> > -       struct Qdisc *             (*leaf)(struct Qdisc *, long unsigned int); /*    24     8 */
> > +       struct Qdisc *             (*leaf)(struct Qdisc *, unsigned long); /*    24     8 */
> > -       void                       (*qlen_notify)(struct Qdisc *, long unsigned int); /*    32     8 */
> > +       void                       (*qlen_notify)(struct Qdisc *, unsigned long); /*    32     8 */
> > -       long unsigned int          (*find)(struct Qdisc *, u32); /*    40     8 */
> > +       unsigned long              (*find)(struct Qdisc *, u32); /*    40     8 */
> > -       int                        (*change)(struct Qdisc *, u32, u32, struct nlattr * *, long unsigned int *, struct netlink_ext_ack *); /*    48     8 */
> > +       int                        (*change)(struct Qdisc *, u32, u32, struct nlattr * *, unsigned long *, struct netlink_ext_ack *); /*    48     8 */
> > -       int                        (*delete)(struct Qdisc *, long unsigned int, struct netlink_ext_ack *); /*    56     8 */
> > +       int                        (*delete)(struct Qdisc *, unsigned long, struct netlink_ext_ack *); /*    56     8 */
> > 
> > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > index 1e6147a82056c188..1ecc24321bf8f975 100644
> > --- a/dwarves_fprintf.c
> > +++ b/dwarves_fprintf.c
> > @@ -788,8 +788,15 @@ next_type:
> >  			if (n)
> >  				return printed + n;
> >  			if (ptype->tag == DW_TAG_LLVM_annotation) {
> > -				type = ptype;
> > -				goto next_type;
> > +				// FIXME: Just skip this for now, we need to print this annotation
> > +				// to match the original source code.
> > +
> > +				if (ptype->type == 0) {
> > +					printed += fprintf(fp, "%-*s %s", tconf.type_spacing, "void *", name);
> > +					break;
> > +				}
> > +
> > +				ptype = cu__type(cu, ptype->type);
> >  			}
> >  			if (ptype->tag == DW_TAG_subroutine_type) {
> >  				printed += ftype__fprintf(tag__ftype(ptype),
> 
> This explains why '*' was missing, but unfortunately it breaks apart
> when there are multiple type tags, e.g.:
> 
> 
>     $ cat tag-test.c
>     #define __t __attribute__((btf_type_tag("t1")))
>     
>     struct foo {
>       int  (__t __t *a)(void);
>     } g;
>     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahole --sort -F dwarf tag-test.o
>     struct foo {
>     	int ()(void)   *           a;                    /*     0     8 */
>     
>     	/* size: 8, cachelines: 1, members: 1 */
>     	/* last cacheline: 8 bytes */
>     };
>     $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahole --sort -F btf tag-test.o
>     struct foo {
>     	int ()(void)   *           a;                    /*     0     8 */
>     
>     	/* size: 8, cachelines: 1, members: 1 */
>     	/* last cacheline: 8 bytes */
>     };
>     
> What I don't understand is why pointer's type is LLVM_annotation.

Well, that is how it is encoded in BTF and then you supported it in:

Author: Eduard Zingerman <eddyz87@gmail.com>
Date:   Wed Mar 15 01:04:14 2023 +0200

    btf_loader: A hack for BTF import of btf_type_tag attributes`


I find it natural, and think that annots thing is a variation on how to
store modifiers for types, see, this DW_TAG_LLVM_annotation is in the
same class as 'restrict', 'const', 'volatile', "atomic", etc

I understand that for encoding _DWARF_ people preferred to make it as a
child DIE to avoid breaking existing DWARF consumers, but in
pahole's dwarf_loader.c we can just make it work like BTF and insert the
btf_type_tag in the chain, just like 'const', etc, no?

pahole wants to print those annotation just like it prints 'const',
'volatile', etc.

> Probably, the cleanest solution would be to make DWARF and BTF loaders
> work in a similar way and attach LLVM_annotation as `annots` field of
> the `struct btf_type_tag_ptr_type`. Thus, avoiding 'LLVM_annotation's
> in the middle of type chains. I'll work on this.

-- 

- Arnaldo
