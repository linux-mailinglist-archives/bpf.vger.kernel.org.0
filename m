Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB57C646614
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 01:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLHArn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 19:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLHArm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 19:47:42 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE115705
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 16:47:39 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso4628004pjb.1
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 16:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HaAmnuOAdvYFUn66u8vk9fSXQikjthSj5jNh+ldrnMY=;
        b=SBZrLaOnQoMZmb2jCw4ej9dmTk+HulcuOAtVlBnmEmMwLgI19w8lj1wEuy4CMkQ2yl
         hJv9ZDBu4m4BS1sAtVZJiq01XHFJc8Mr3sx+k+qmtL1XffXrX1+tYaWy4SYL5TOw+L6l
         bRR59DdfHGa3F+e1uiZikVdJqIZOpCThXu/N05Fr1FroAyHrAvjjKuY3eyApuLbhg0AT
         Dj6296HX/FyPaQzEnfif/dDQqA08h8vXx2K8ZW7Sq0HjBrKkmRFe96rT9khIlB8UO+6m
         wlniuX6jn7GFKd/mr4MrzWxDzWgL9OM9vcxzqtRd9mYbl2uQYI9WfnUsT8WKa1n0545z
         YqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaAmnuOAdvYFUn66u8vk9fSXQikjthSj5jNh+ldrnMY=;
        b=2ZpcB2aCTrCjkGZ1rFvJuIOksu6v4DzO8YgKt7nXboOod+fIigFdjJ4I9GR1XxyeCa
         FgzLe7BZOAr8lhuMmBaRPBuXkRGkXRc9vu7C6v+i8jQyOG+Dy7ndXyfi2bDX96CS7Y8X
         /WBe0iZqUPz/LPGge5R4fY0KkGrLd9+UmSGqUw+ktBgMmWOFipM23Nn0gFiJfFLS/1wS
         9GnMq6q9Ok2ivTWoOf29C2qfVmHvdaU4FePC4vOL+A4OqnSajfjrehvS8VilFSX38BKH
         Pmu0n6c1/khwReRf6ex9Jo3cWhH5mx0dTNoMVaL07+IqYtF3sdmIgGNPJoyJXVVLHODR
         A1vQ==
X-Gm-Message-State: ANoB5pkJqIGIjDRWaT7QPj7t8ER40lvZHv66bJgVJSLV0BOTPCZ4Iv3b
        XAMUKUGrlgXOvDO3FPFWrBY=
X-Google-Smtp-Source: AA0mqf738Gs5I0lrBAoe29QbCV9a5W807bm7cyGibw3MpzHTwugNtndaKFNC0SupOSol3lziDNbwfA==
X-Received: by 2002:a17:90a:1b0a:b0:219:46fa:cdc0 with SMTP id q10-20020a17090a1b0a00b0021946facdc0mr1341036pjq.14.1670460458537;
        Wed, 07 Dec 2022 16:47:38 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5529983pjb.1.2022.12.07.16.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:47:37 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:47:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for
 insn->off < 0
Message-ID: <20221208004734.3deulbouezpiehrg@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
 <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
 <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
 <20221207180621.zkuztvz7hx4niout@macbook-pro-6.dhcp.thefacebook.com>
 <ea0259d9-2f29-bfbc-011f-810d3e2654a8@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0259d9-2f29-bfbc-011f-810d3e2654a8@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 06:39:38PM -0500, Dave Marchevsky wrote:
> >>
> >> 0000000000000000 <less>:
> >> ;       return node_a->key < node_b->key;
> >>        0:       79 22 f0 ff 00 00 00 00 r2 = *(u64 *)(r2 - 0x10)
> >>        1:       79 11 f0 ff 00 00 00 00 r1 = *(u64 *)(r1 - 0x10)
> >>        2:       b4 00 00 00 01 00 00 00 w0 = 0x1
> >> ;       return node_a->key < node_b->key;
> > 
> > I see. That's the same bug.
> > The args to callback should have been PTR_TO_BTF_ID | PTR_TRUSTED with 
> > correct positive offset.
> > Then node_a = container_of(a, struct node_data, node);
> > would have produced correct offset into proper btf_id.
> > 
> > The verifier should be passing into less() the btf_id
> > of struct node_data instead of btf_id of struct bpf_rb_node.
> > 
> 
> The verifier is already passing the struct node_data type, not bpf_rb_node.
> For less() args, and rbtree_{first,remove} retval, mark_reg_datastructure_node
> - added in patch 8 - is doing as you describe.
> 
> Verifier sees less' arg regs as R=ptr_to_node_data(off=16). If it was
> instead passing R=ptr_to_bpf_rb_node(off=0), attempting to access *(reg - 0x10)
> would cause verifier err.

Ahh. I finally got it :)
Please put these details in the commit log when you respin.

> >>        3:       cd 21 01 00 00 00 00 00 if r1 s< r2 goto +0x1 <LBB2_2>
> >>        4:       b4 00 00 00 00 00 00 00 w0 = 0x0
> >>
> >> 0000000000000028 <LBB2_2>:
> >> ;       return node_a->key < node_b->key;
> >>        5:       95 00 00 00 00 00 00 00 exit
> >>
> >> Insns 0 and 1 are loading node_b->key and node_a->key, respectively, using
> >> negative insn->off. Verifier's view or R1 and R2 before insn 0 is
> >> untrusted_ptr_node_data(off=16). If there were some intermediate insns
> >> storing result of container_of() before dereferencing:
> >>
> >>   r3 = (r2 - 0x10)
> >>   r2 = *(u64 *)(r3)
> >>
> >> Verifier would see R3 as untrusted_ptr_node_data(off=0), and load for
> >> r2 would have insn->off = 0. But LLVM decides to just do a load-with-offset
> >> using original arg ptrs to less() instead of storing container_of() ptr
> >> adjustments.
> >>
> >> Since the container_of usage and code pattern in above example's less()
> >> isn't particularly specific to this series, I think there are other scenarios
> >> where such code would be generated and considered this a general bugfix in
> >> cover letter.
> > 
> > imo the negative offset looks specific to two misuses of PTR_UNTRUSTED in this set.
> > 
> 
> If I used PTR_TRUSTED here, the JITted instructions would still do a load like
> r2 = *(u64 *)(r2 - 0x10). There would just be no BPF_PROBE_MEM runtime checking
> insns generated, avoiding negative insn issue there. But the negative insn->off
> load being generated is not specific to PTR_UNTRUSTED.

yep.

> > 
> > Exactly. More flags will only increase the confusion.
> > Please try to make callback args as proper PTR_TRUSTED and disallow calling specific
> > rbtree kfuncs while inside this particular callback to prevent recursion.
> > That would solve all these issues, no?
> > Writing into such PTR_TRUSTED should be still allowed inside cb though it's bogus.
> > 
> > Consider less() receiving btf_id ptr_trusted of struct node_data and it contains
> > both link list and rbtree.
> > It should still be safe to operate on link list part of that node from less()
> > though it's not something we would ever recommend.
> 
> I definitely want to allow writes on non-owning references. In order to properly
> support this, there needs to be a way to designate a field as a "key":
> 
> struct node_data {
>   long key __key;
>   long data;
>   struct bpf_rb_node node;
> };
> 
> or perhaps on the rb_root via __contains or separate tag:
> 
> struct bpf_rb_root groot __contains(struct node_data, node, key);
> 
> This is necessary because rbtree's less() uses key field to determine order, so
> we don't want to allow write to the key field when the node is in a rbtree. If
> such a write were possible the rbtree could easily be placed in an invalid state
> since the new key may mean that the rbtree is no longer sorted. Subsequent add()
> operations would compare less() using the new key, so other nodes will be placed
> in wrong spot as well.
> 
> Since PTR_UNTRUSTED currently allows read but not write, and prevents use of
> non-owning ref as kfunc arg, it seemed to be reasonable tag for less() args.
> 
> I was planning on adding __key / non-owning-ref write support as a followup, but
> adding it as part of this series will probably save a lot of back-and-forth.
> Will try to add it.

Just key mark might not be enough. less() could be doing all sort of complex
logic on more than one field and even global fields.
But what is the concern with writing into 'key' ?
The rbtree will not be sorted. find/add operation will not be correct,
but nothing will crash. At the end bpf_rb_root_free() will walk all
unsorted nodes anyway and free them all.
Even if we pass PTR_TRUSTED | MEM_RDONLY pointers into less() the less()
can still do nonsensical things like returning random true/false.
Doesn't look like an issue to me.
