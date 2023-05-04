Return-Path: <bpf+bounces-9-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2CF6F7599
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87079280E2C
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F615489;
	Thu,  4 May 2023 19:46:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016A15483
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:46:19 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23087AD12
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 12:46:00 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115eef620so14934277b3a.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683229493; x=1685821493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1LUAqxcfLlmLk1v7GnRWwyAbMTMlI3KTDY+rSZwyiXw=;
        b=Kf1Aq9AJyTZOlgnqyZ46nWogarjffDh+ha7QEH0UffCQd9ixt0UUmbw1JpQtkp/kvF
         qZ0KrVCbaLUb9ckk3rDa9Ea6izYK1EjJHIifrbWCSRu01L2bLzGxbxWk9Unu38wZw9lr
         PKobytPFSCWzyrRKMpHmnbgERAAWlPoVBuxXzS90PVQrWY0CcFJGUHdrqFwrAn1cQ3sw
         mghf/WbE2bT+2RodkxZeruTHC38Eu6j7YL1virIPbNoxeag9oSv9F9Wru/QfBM3DWhvz
         0CUtgOx6s9XKyRH0MA2/kXXPWnHPtybk59dy4NgtQDgrcXv4krGKxr9oST/Ml7+N5Agu
         KDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683229493; x=1685821493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LUAqxcfLlmLk1v7GnRWwyAbMTMlI3KTDY+rSZwyiXw=;
        b=ZMwyDvn9F6pPTAR+8o/WHEEtEdfNBLH2LzXvqV4dAD7X6KVNKhYF/jTczspy3KM4a/
         Tmw0tB9nN7uet9GA/HHGeQxlQWqeVBhvZVEiPUbDgRjjV1raZjbo/Z74E/yMw1BEW8+d
         jp08XREzGr8G9m56y2GGP58op2zR8c3xTd7Yad/WpDrMIxz4DOjBLOaFB2vJK4pgxV9A
         saqc5lLu2/n3SzkU8bHFz3jjf4v3+pF4tWg+E7R5xCy2G6/qv0nSveSHmQVjhoklnacH
         NmvvfFeqkFmrtBuufRC9U2IqWGtMLjSV3GcyRQE4kPFzfvPpRrgZvqJjuhOTk8N6F56b
         vxiQ==
X-Gm-Message-State: AC+VfDwdy++7KuAr9lGGn176POPLb6ha19NmaXsusDeiiTQRN//uamZN
	Xh6Jegl6aOxuVsdJtcTuY7c=
X-Google-Smtp-Source: ACHHUZ7HazrMbbODNFGvYy4Jcd3RDbdEm2lBuchYgDAjwcuvFMaKYcQx2iXu9nA3X9UilkXQx316bg==
X-Received: by 2002:a17:902:d48e:b0:1a9:68d2:e4ae with SMTP id c14-20020a170902d48e00b001a968d2e4aemr5452514plg.2.1683229492077;
        Thu, 04 May 2023 12:44:52 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::6:168f])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090abb0900b00249604258b1sm3407655pjr.38.2023.05.04.12.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 12:44:51 -0700 (PDT)
Date: Thu, 4 May 2023 12:44:49 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/10] bpf: encapsulate precision backtracking
 bookkeeping
Message-ID: <20230504194449.dtriu3rtyf6iwr27@MacBook-Pro-6.local>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-4-andrii@kernel.org>
 <20230504025309.actotyekpawodfar@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <CAEf4BzZ7jbEQ6MSdthOe=bj1eptCft3spJ_KucERi7jGxuSqzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ7jbEQ6MSdthOe=bj1eptCft3spJ_KucERi7jGxuSqzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 04, 2023 at 12:02:22PM -0700, Andrii Nakryiko wrote:
> On Wed, May 3, 2023 at 7:53 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Few early comments so far...
> >
> > On Tue, Apr 25, 2023 at 04:49:04PM -0700, Andrii Nakryiko wrote:
> > > Add struct backtrack_state and straightforward API around it to keep
> > > track of register and stack masks used and maintained during precision
> > > backtracking process. Having this logic separately allow to keep
> > > high-level backtracking algorithm cleaner, but also it sets us up to
> > > cleanly keep track of register and stack masks per frame, allowing (with
> > > some further logic adjustments) to perform precision backpropagation
> > > across multiple frames (i.e., subprog calls).
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf_verifier.h |  15 ++
> > >  kernel/bpf/verifier.c        | 258 ++++++++++++++++++++++++++---------
> > >  2 files changed, 206 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > > index 3dd29a53b711..185bfaf0ec6b 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -238,6 +238,10 @@ enum bpf_stack_slot_type {
> > >
> > >  #define BPF_REG_SIZE 8       /* size of eBPF register in bytes */
> > >
> > > +#define BPF_REGMASK_ARGS ((1 << BPF_REG_1) | (1 << BPF_REG_2) | \
> > > +                       (1 << BPF_REG_3) | (1 << BPF_REG_4) | \
> > > +                       (1 << BPF_REG_5))
> > > +
> > >  #define BPF_DYNPTR_SIZE              sizeof(struct bpf_dynptr_kern)
> > >  #define BPF_DYNPTR_NR_SLOTS          (BPF_DYNPTR_SIZE / BPF_REG_SIZE)
> > >
> > > @@ -541,6 +545,16 @@ struct bpf_subprog_info {
> > >       bool is_async_cb;
> > >  };
> > >
> > > +struct bpf_verifier_env;
> > > +
> > > +struct backtrack_state {
> > > +     struct bpf_verifier_env *env;
> > > +     u32 frame;
> > > +     u32 bitcnt;
> > > +     u32 reg_masks[MAX_CALL_FRAMES];
> > > +     u64 stack_masks[MAX_CALL_FRAMES];
> > > +};
> > > +
> > >  /* single container for all structs
> > >   * one verifier_env per bpf_check() call
> > >   */
> > > @@ -578,6 +592,7 @@ struct bpf_verifier_env {
> > >               int *insn_stack;
> > >               int cur_stack;
> > >       } cfg;
> > > +     struct backtrack_state bt;
> > >       u32 pass_cnt; /* number of times do_check() was called */
> > >       u32 subprog_cnt;
> > >       /* number of instructions analyzed by the verifier */
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index fea6fe4acba2..1cb89fe00507 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -1254,6 +1254,12 @@ static bool is_spilled_reg(const struct bpf_stack_state *stack)
> > >       return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL;
> > >  }
> > >
> > > +static bool is_spilled_scalar_reg(const struct bpf_stack_state *stack)
> > > +{
> > > +     return stack->slot_type[BPF_REG_SIZE - 1] == STACK_SPILL &&
> > > +            stack->spilled_ptr.type == SCALAR_VALUE;
> > > +}
> > > +
> > >  static void scrub_spilled_slot(u8 *stype)
> > >  {
> > >       if (*stype != STACK_INVALID)
> > > @@ -3144,12 +3150,137 @@ static const char *disasm_kfunc_name(void *data, const struct bpf_insn *insn)
> > >       return btf_name_by_offset(desc_btf, func->name_off);
> > >  }
> > >
> > > +static inline void bt_init(struct backtrack_state *bt, u32 frame)
> > > +{
> > > +     bt->frame = frame;
> > > +}
> > > +
> > > +static inline void bt_reset(struct backtrack_state *bt)
> > > +{
> > > +     struct bpf_verifier_env *env = bt->env;
> > > +     memset(bt, 0, sizeof(*bt));
> > > +     bt->env = env;
> > > +}
> > > +
> > > +static inline u32 bt_bitcnt(struct backtrack_state *bt)
> > > +{
> > > +     return bt->bitcnt;
> > > +}
> >
> > I could have missed it, but it doesn't look that any further patch uses
> > the actual number of bits set.
> > All uses are: if (bt_bitcnt(bt) != 0)
> >
> > Hence keeping bitcnt as extra 4 bytes and doing ++, -- on it
> > seems wasteful.
> > Maybe rename bt_bitcnt into bt_empty or bt_non_empty that
> > will do !!bt->reg_masks[bt->frame] | !!bt->stack_masks[bt->frame]
> 
> Yes, number of bits doesn't matter, it's whether there are any or not.
> So I'll rename.
> 
> As for the counter. I did it to avoid going over all MAX_CALL_FRAMES
> frames to calculate the final mask. So it was a choice of maintaining
> count proactively, or doing a loop each time we need to know if there
> are any bits set:
> 
> u64 mask = 0;
> 
> for (i = 0; i <= bt->frame; i++)
>     mask |= bt->reg_masks[i] | bt->stack_masks[i];
> 
> return mask != 0;
> 
> 
> I don't think this one is very expensive either, so I can just switch
> to this, if you prefer that. That will eliminate all the ifs, of
> course.

I see. Missed the loop over frames part.
I guess I'm fine whichever way. Interesting trade off.

