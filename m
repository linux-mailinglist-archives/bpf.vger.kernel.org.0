Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87EC6460DD
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 19:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLGSG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 13:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGSG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 13:06:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ADC60B44
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 10:06:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2448399pjj.4
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hg+ZWWkTrugbnZD3wPB2xnvZQ+6QAA75J4d4BPEA5eA=;
        b=ky6q3QPTICIdECPIYTRFENuqxK83EvSpGmTsyxIL9Xurq8VUkEQXVR1iHH4j7+kxvF
         s/1CcFwt14kWwLIYo5VTfIQyALg5Lb74ytc3fSVtpZO4vqAm3BTTvDGf4KU3w/RnrNyC
         y9MDnC3QoCXT7EgchkLli427ZgFPfZYoeuGaiE4zqMlQZ6eLVfpv5sdNbuhN5zZ8B20Q
         Wtcd5zaarpnrRjTlLVMGVgq785fQ7Fzia04aN94fHmuW/7oqYgv5uN9AficuIvmYAKQ2
         aEGAHMhxi9ZIjCWy+6CkDNwQPfh5QrUdPog6KH0ybDq1gprYKGz5K8YoVoH63YA2PpHb
         QYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg+ZWWkTrugbnZD3wPB2xnvZQ+6QAA75J4d4BPEA5eA=;
        b=UwfECSHjwAwXCntOQcVNjAm8brxYuwWw4+OVgS2ayMAUldGkH9cXkMyfvVIW320RFj
         aRB/ojwc1MUfgEVAy6Z1T4n5EKDyjR0VwSic74pEcrsjvZFhIl4cBCS8MioikCmCraU2
         qqvRHL2xEBfyfGOmcoAxgOnGcj46h3ssRtN3ljpOJ86/kSIR6EevmCMt0SCM0hHDJ6zS
         Dbe+ZXuImOtI05YUYnRdOYzf+jDM+AUbB7bSs25MSfw7rAlSOKp9WgjABZG1Mj3hpLna
         2Qo5VNmiDAqhqMWL2W89kM/zsNb5wgJ7RWu+ZbTFXUyReAy8JkJgyVXKAcqyVQQ3kHmR
         TT8A==
X-Gm-Message-State: ANoB5pkV3NL+t3qOKylU5baKL6jufCA8Ye3TYwspCGHEG6dwmWrrlJm4
        //D/w1DEIi5Dmoip7hrXxnWizOC/N6o=
X-Google-Smtp-Source: AA0mqf7Svx5Hbvw0WKU3eWmBTXLf6shMgaa3cL4WkEfUolleuHLFg2touA32mmsTbwosF6dDDX1KCA==
X-Received: by 2002:a05:6a21:c016:b0:ac:a4fd:fff7 with SMTP id bm22-20020a056a21c01600b000aca4fdfff7mr637170pzc.23.1670436384530;
        Wed, 07 Dec 2022 10:06:24 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id a24-20020aa795b8000000b00575d06e53edsm12820503pfk.149.2022.12.07.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 10:06:24 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:06:21 -0800
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
Message-ID: <20221207180621.zkuztvz7hx4niout@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
 <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
 <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 01:46:56AM -0500, Dave Marchevsky wrote:
> On 12/6/22 9:39 PM, Alexei Starovoitov wrote:
> > On Tue, Dec 06, 2022 at 03:09:57PM -0800, Dave Marchevsky wrote:
> >> Current comment in BPF_PROBE_MEM jit code claims that verifier prevents
> >> insn->off < 0, but this appears to not be true irrespective of changes
> >> in this series. Regardless, changes in this series will result in an
> >> example like:
> >>
> >>   struct example_node {
> >>     long key;
> >>     long val;
> >>     struct bpf_rb_node node;
> >>   }
> >>
> >>   /* In BPF prog, assume root contains example_node nodes */
> >>   struct bpf_rb_node res = bpf_rbtree_first(&root);
> >>   if (!res)
> >>     return 1;
> >>
> >>   struct example_node n = container_of(res, struct example_node, node);
> >>   long key = n->key;
> >>
> >> Resulting in a load with off = -16, as bpf_rbtree_first's return is
> > 
> > Looks like the bug in the previous patch:
> > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> > +                                  meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> > +                               struct btf_field *field = meta.arg_rbtree_root.field;
> > +
> > +                               mark_reg_datastructure_node(regs, BPF_REG_0,
> > +                                                           &field->datastructure_head);
> > 
> > The R0 .off should have been:
> >  regs[BPF_REG_0].off = field->rb_node.node_offset;
> > 
> > node, not root.
> > 
> > PTR_TO_BTF_ID should have been returned with approriate 'off',
> > so that container_of() would it bring back to zero offset.
> > 
> 
> The root's btf_field is used to hold information about the node type. Of
> specific interest to us are value_btf_id and node_offset, which
> mark_reg_datastructure_node uses to set REG_0's type and offset correctly.
> 
> This "use head type to keep info about node type" strategy felt strange to me
> initially too: all PTR_TO_BTF_ID regs are passing around their type info, so
> why not use that to lookup bpf_rb_node field info? But consider that
> bpf_rbtree_first (and bpf_list_pop_{front,back}) doesn't take a node as
> input arg, so there's no opportunity to get btf_field info from input
> reg type. 
> 
> So we'll need to keep this info in rbtree_root's btf_field
> regardless, and since any rbtree API function that operates on a node
> also operates on a root and expects its node arg to match the node
> type expected by the root, might as well use root's field as the main
> lookup for this info and not even have &field->rb_node for now.
> All __process_kf_arg_ptr_to_datastructure_node calls (added earlier
> in the series) use the &meta->arg_{list_head,rbtree_root}.field for same
> reason.
> 
> So it's setting the reg offset correctly.

Ok. Got it. Than the commit log is incorrectly describing the failing scenario.
It's a container_of() inside bool less() that is generating negative offsets.

> > All PTR_TO_BTF_ID need to have positive offset.
> > I'm not sure btf_struct_walk() and other PTR_TO_BTF_ID accessors
> > can deal with negative offsets.
> > There could be all kinds of things to fix.
> 
> I think you may be conflating reg offset and insn offset here. None of the
> changes in this series result in a PTR_TO_BTF_ID reg w/ negative offset
> being returned. But LLVM may generate load insns with a negative offset,
> and since we're passing around pointers to bpf_rb_node that may come
> after useful data fields in a type, this will happen more often.
> 
> Consider this small example from selftests in this series:
> 
> struct node_data {
>   long key;
>   long data;
>   struct bpf_rb_node node;
> };
> 
> static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
> {
>         struct node_data *node_a;
>         struct node_data *node_b;
> 
>         node_a = container_of(a, struct node_data, node);
>         node_b = container_of(b, struct node_data, node);
> 
>         return node_a->key < node_b->key;
> }
> 
> llvm-objdump shows this bpf bytecode for 'less':
> 
> 0000000000000000 <less>:
> ;       return node_a->key < node_b->key;
>        0:       79 22 f0 ff 00 00 00 00 r2 = *(u64 *)(r2 - 0x10)
>        1:       79 11 f0 ff 00 00 00 00 r1 = *(u64 *)(r1 - 0x10)
>        2:       b4 00 00 00 01 00 00 00 w0 = 0x1
> ;       return node_a->key < node_b->key;

I see. That's the same bug.
The args to callback should have been PTR_TO_BTF_ID | PTR_TRUSTED with 
correct positive offset.
Then node_a = container_of(a, struct node_data, node);
would have produced correct offset into proper btf_id.

The verifier should be passing into less() the btf_id
of struct node_data instead of btf_id of struct bpf_rb_node.

>        3:       cd 21 01 00 00 00 00 00 if r1 s< r2 goto +0x1 <LBB2_2>
>        4:       b4 00 00 00 00 00 00 00 w0 = 0x0
> 
> 0000000000000028 <LBB2_2>:
> ;       return node_a->key < node_b->key;
>        5:       95 00 00 00 00 00 00 00 exit
> 
> Insns 0 and 1 are loading node_b->key and node_a->key, respectively, using
> negative insn->off. Verifier's view or R1 and R2 before insn 0 is
> untrusted_ptr_node_data(off=16). If there were some intermediate insns
> storing result of container_of() before dereferencing:
> 
>   r3 = (r2 - 0x10)
>   r2 = *(u64 *)(r3)
> 
> Verifier would see R3 as untrusted_ptr_node_data(off=0), and load for
> r2 would have insn->off = 0. But LLVM decides to just do a load-with-offset
> using original arg ptrs to less() instead of storing container_of() ptr
> adjustments.
> 
> Since the container_of usage and code pattern in above example's less()
> isn't particularly specific to this series, I think there are other scenarios
> where such code would be generated and considered this a general bugfix in
> cover letter.

imo the negative offset looks specific to two misuses of PTR_UNTRUSTED in this set.

> 
> [ below paragraph was moved here, it originally preceded "All PTR_TO_BTF_ID"
>   paragraph ]
> 
> > The apporach of returning untrusted from bpf_rbtree_first is questionable.
> > Without doing that this issue would not have surfaced.
> > 
> 
> I agree re: PTR_UNTRUSTED, but note that my earlier example doesn't involve
> bpf_rbtree_first. Regardless, I think the issue is that PTR_UNTRUSTED is
> used to denote a few separate traits of a PTR_TO_BTF_ID reg:
> 
>   * "I have no ownership over the thing I'm pointing to"
>   * "My backing memory may go away at any time"
>   * "Access to my fields might result in page fault"
>   * "Kfuncs shouldn't accept me as an arg"
> 
> Seems like original PTR_UNTRUSTED usage really wanted to denote the first
> point and the others were just naturally implied from the first. But
> as you've noted there are some things using PTR_UNTRUSTED that really
> want to make more granular statements:

I think PTR_UNTRUSTED implies all of the above. All 4 statements are connected.

> ref_set_release_on_unlock logic sets release_on_unlock = true and adds
> PTR_UNTRUSTED to the reg type. In this case PTR_UNTRUSTED is trying to say:
> 
>   * "I have no ownership over the thing I'm pointing to"
>   * "My backing memory may go away at any time _after_ bpf_spin_unlock"
>     * Before spin_unlock it's guaranteed to be valid
>   * "Kfuncs shouldn't accept me as an arg"
>     * We don't want arbitrary kfunc saving and accessing release_on_unlock
>       reg after bpf_spin_unlock, as its backing memory can go away any time
>       after spin_unlock.
> 
> The "backing memory" statement PTR_UNTRUSTED is making is a blunt superset
> of what release_on_unlock really needs.
> 
> For less() callback we just want
> 
>   * "I have no ownership over the thing I'm pointing to"
>   * "Kfuncs shouldn't accept me as an arg"
> 
> There is probably a way to decompose PTR_UNTRUSTED into a few flags such that
> it's possible to denote these things separately and avoid unwanted additional
> behavior. But after talking to David Vernet about current complexity of
> PTR_TRUSTED and PTR_UNTRUSTED logic and his desire to refactor, it seemed
> better to continue with PTR_UNTRUSTED blunt instrument with a bit of
> special casing for now, instead of piling on more flags.

Exactly. More flags will only increase the confusion.
Please try to make callback args as proper PTR_TRUSTED and disallow calling specific
rbtree kfuncs while inside this particular callback to prevent recursion.
That would solve all these issues, no?
Writing into such PTR_TRUSTED should be still allowed inside cb though it's bogus.

Consider less() receiving btf_id ptr_trusted of struct node_data and it contains
both link list and rbtree.
It should still be safe to operate on link list part of that node from less()
though it's not something we would ever recommend.
The kfunc call on rb tree part of struct node_data is problematic because
of recursion, right? No other safety concerns ?

> > 
> >> modified by verifier to be PTR_TO_BTF_ID of example_node w/ offset =
> >> offsetof(struct example_node, node), instead of PTR_TO_BTF_ID of
> >> bpf_rb_node. So it's necessary to support negative insn->off when
> >> jitting BPF_PROBE_MEM.
> > 
> > I'm not convinced it's necessary.
> > container_of() seems to be the only case where bpf prog can convert
> > PTR_TO_BTF_ID with off >= 0 to negative off.
> > Normal pointer walking will not make it negative.
> > 
> 
> I see what you mean - if some non-container_of case resulted in load generation
> with negative insn->off, this probably would've been noticed already. But
> hopefully my replies above explain why it should be addressed now.

Even with container_of() usage we should be passing proper btf_id of container
struct, so that callbacks and non-callbacks can properly container_of() it
and still get offset >= 0.

> >>
> >> A few instructions are saved for negative insn->offs as a result. Using
> >> the struct example_node / off = -16 example from before, code looks
> >> like:
> > 
> > This is quite complex to review. I couldn't convince myself
> > that droping 2nd check is safe, but don't have an argument to
> > prove that it's not safe.
> > Let's get to these details when there is need to support negative off.
> > 
> 
> Hopefully above explanation shows that there's need to support it now.
> I will try to simplify and rephrase the summary to make it easier to follow,
> but will prioritize addressing feedback in less complex patches, so this
> patch may not change for a few respins.

I'm not saying that this patch will never be needed.
Supporting negative offsets here is a good thing.
I'm arguing that it's not necessary to enable bpf_rbtree.
