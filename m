Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78455A129
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 20:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiFXSjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiFXSjW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 14:39:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A762722
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:39:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cv13so3550757pjb.4
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqWTZEcbCPX0UW7X9vuVT6podCwyN4RLB/8d9OeVzwM=;
        b=FkukQT/V1ykxmVqpyPQfA3HnmIxAFK6rvd+p1ovDRmzxErhdexLCEkBWFvJrs8n03C
         wCXxApl8V+qq76VqCbyg6ZFNNr7y8+5DAJQ229l9ULgQLxo8xbRvCKaIHwJ8bFAw2c1I
         tNWx4SxEb23dXbO5Z+izugwimY8CWoIUoC8sJGRHozp/4i2qyoW6hPuMBh8ADmIAhqbM
         tiEdMMz3PHWCoKvvpBQrqTDTb9rFKxAzjjy1syfcL+OtK05SPjHPons6PDYIXvVR2TUr
         UQFyWAE5IrYV2rn1Fq3N1hbTYHhoheLMRQ4Y/4N0kfLoNCJYUTvE0lhGMUnZ/gPENYMy
         3/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqWTZEcbCPX0UW7X9vuVT6podCwyN4RLB/8d9OeVzwM=;
        b=FaqkLjpE9vzeQwuwzE/lyIfXbPHGdA5u2vM5gl+8miWr878W/rmJ1jmDOtT4lyqC8z
         Ad06cpKMTXg51JST+z5PToJ9Nqn4ZKM98mUx3Wufy/IxCb/hlZJnV4j+BoZcvY9RywqF
         ef4I8sGMvaLziLcaJvWV0PTnWhaClIKckv+TVAnt5dagL4QYVtH9c5OA8Vdr56fsFBMF
         FZzJVmIg1i2B5sKEChV8fWEIMSW18HYPBeLA5KqjigsXlhogB4KRj3QWTUuGHNq4isxd
         34lh77bOKfmBwvYHq+mV6jG1/1gJ/l4wLQwgokFoU8AOwhRV7eAm0P6jP9ZZnu5sqgS4
         CM5Q==
X-Gm-Message-State: AJIora8Uq2E1hTq0pCHQeDvG803CDweWHx1BrzThsuZQNdHN4956h9kP
        RRJaUdoAIk2tS14zaWzPZTY=
X-Google-Smtp-Source: AGRyM1uPu1pVN3i3xzB4Q6P94V5VAhmEvy1QcZeMMInAALS8I0BDAp8rdEKiPyIGyllVBibTvjzWBg==
X-Received: by 2002:a17:903:4043:b0:16a:6806:114a with SMTP id n3-20020a170903404300b0016a6806114amr465810pla.119.1656095961383;
        Fri, 24 Jun 2022 11:39:21 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2620:10d:c090:400::5:1151])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a5b0c00b001e29ddf9f4fsm2141482pji.3.2022.06.24.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:39:20 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:39:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, john.fastabend@gmail.com,
        yhs@fb.com
Subject: Re: [RFC bpf-next] Speedup for verifier.c:do_misc_fixups
Message-ID: <20220624183918.qatsud6fdrtjj3qy@MacBook-Pro-3.local>
References: <43f4de24e5981152b8a31d4629e199c012c4f52c.camel@gmail.com>
 <20220623031101.q7kwa5jb4e7czqso@macbook-pro-3.dhcp.thefacebook.com>
 <5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c297e5009bcd4f0becf59ccd97cfd82bb3a49ec.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 05:02:34PM +0300, Eduard Zingerman wrote:
> > On Wed, 2022-06-22 at 20:11 -0700, Alexei Starovoitov wrote:
> [...]
> > tbh sounds scary. We had so many bugs in the patch_insn over years.
> > The code is subtle.
> 
> In terms of testing strategy the following could be done:
> - use pseudo-random testing to verify that `bpf_patch_insn_data` and
>   the mechanism suggested in my email produce identical code.
> - use pseudo-random testing to verify that offsets after rewrite point
>   to expected instructions (e.g. use .imm field as a unique marker for
>   the instruction).
> - hand-written tests for corner cases.
> 
> Would you consider this to be sufficient?  (Probably does not sound
> too reassuring from the person[me] who submits patches with trivial
> use after free errors :)
> 
> [...]
> 
> > Before proceeding too far based on artificial test please collect
> > the number of patches and their sizes we currently do across all progs
> > in selftests. Maybe it's not that bad in real code.
> 
> I will collect and share the stats on Saturday or Sunday.
> 
> > As far as algo the patch_and_copy_insn() assumes that 'dst' insn is a branch?
> > I guess I'm missing some parts of the proposed algo.
> 
> Sorry, I made a mistake in the original email, the code for
> patch_and_copy_insn() should look as follows:
> 
> static void patch_and_copy_insn(struct bpf_patching_state *state, int pc,
> 				struct bpf_insn *dst, struct bpf_insn *src) {
> 	memcpy(dst, src, sizeof(struct bpf_insn));
> 	// TODO: other classes
> 	// TODO: also adjust imm for calls
> 	if (BPF_CLASS(src->code) == BPF_JMP) {
> 		int new_pc = pc + lookup_delta_for_index(state, pc);
> 		int dst_pc = pc + src->off + 1;
> 		int new_dst = dst_pc + lookup_delta_for_index(state, dst_pc);
> 		dst->off = new_dst - new_pc - 1;
> 	}
> }
> 
> 
> The logic is as follows:
> - compute new instruction index for the old pc
> - compute new instruction index for the (old pc + offset)
> - use these values to compute the new offset
> 
> The draft implementation of this algorithm is at the end of this
> email.
> 
> > Instead of delaying everything maybe we can do all patching inline
> > except bpf_adj_branches?
> > Remember only:
> >    int offset;             /* index inside the original program,
> >                             * the instruction at this index would be replaced.
> >                             */
> >    int insns_count;        /* size of the patch */
> >    int delta;              /* difference in indexes between original program and
> >                             * new program after application of all patches up to
> >                             * and including this one.
> >                             */
> > and do single bpf_adj_branches at the end ?
> 
> The algorithm consists of two parts:
> - To avoid excessive copying patches are accumulated in a separate
>   array and size of this array is doubled each time the capacity is
>   not sufficient to fit a new patch. This should have O(log(n))
>   complexity in terms of copied bytes.
> - To avoid excessive branch adjustment passes a single branch
>   adjustment pass is performed at the end. This pass visits each
>   instruction only once, however, for each instruction it will have
>   to query the delta value in a sorted array. Thus the overall
>   complexity of this pass would be O(n*log(n)). It is possible to
>   adjust some relevant fields in `env` during this pass as well.

Before jumping into coding let's explore the alternatives.
Can we use some of the compiler techniques?
Like:
- split a set of insn into basic blocks (BB)
- convert each jmp from relative offset to fixed bb index
- perform patching of insns. No jmp adjustments are necessary.
  Every patch applies within bb. Minimal realloc+copy of insns within bb.
- reconstruct a set of insn from a set of bb-s.

John, Yonghong, everyone,
may be other ideas?
