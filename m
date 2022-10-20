Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C8605493
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 02:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJTAsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 20:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJTAsv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 20:48:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47291C39C4
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:48:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 20so680031pgc.5
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zyci/PZUAqG09KMGSdKtD4vsTrvNmov9kKxJ5X3wLlc=;
        b=f8QL9yYYr/oRNbttsch8BCf/5skXSeS2CmpRyCXyKtLHVHG0MncX/IXUQdOvCVc9yW
         BhtKGXvaSoaqugFI2psJrKXbfgAG3WGrzUAKeetgcr0b0D9IADi201WKZwqqCK4k5a9B
         2SJAVmf1YFxp7Ebc6FnT/mmKbk5uFdWhda0VW8pHCo7dvTHLQP0voVKDjjp3naBDhPGa
         iHMnELpySEFg+PTE48nU2tIPmYu+Jh6XygkHZNdWfWK8nD90Gmrm+mfDModslvBVTrhg
         e79frAArvWLjWQrFPwRzXRXJSd78aak1VaZGAWENnXOmVk/R/i8cJiHewsyInf7J30n4
         muYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyci/PZUAqG09KMGSdKtD4vsTrvNmov9kKxJ5X3wLlc=;
        b=hpRm0xJUrB647EaOjdWQ0YaTX4iNYOcmHLXdGNzTDPhpclHDTlKX52IstxrBuxFJQE
         2Z7USzQCWwy33da/QnZbOTZYH/QtO2tpVOgi90RNvqCoVzaRVFZ/leCq+uWDDpbqpAjz
         HA1icqjLCCj1vK3KYTnIvGF5Kyw36lbMHOIpRlV5q9jY/NnxbvUUq9UQgod65b5uZd8V
         EsqVtVtFf/7Qv8vqdjzb0WCcMjFckpXfJPWFbLM5Ma6xumIpP6xP+wNsW6olfKQp3Hef
         xv9Y2p64fYesebKgclx2KRm8gnUS2NT4Rt4e4fWLsejBkjjqgZLAhoegldHrv525CqbJ
         /JMA==
X-Gm-Message-State: ACrzQf0jesVld9yG3YgdcNoaowL/8qTZtnnXkweB0E4Oh+2XLcesyCpa
        GosgONqL0DdRzmFP6OZWGGY=
X-Google-Smtp-Source: AMsMyM4PKIE19C7C372ke0kQNKREpJ9DmwTjOlhiISXZDPmUXuRgafqHMNsm1ihTgr+PRbKpLzdbdg==
X-Received: by 2002:aa7:88d6:0:b0:563:9fe9:5da8 with SMTP id k22-20020aa788d6000000b005639fe95da8mr11390521pff.74.1666226929082;
        Wed, 19 Oct 2022 17:48:49 -0700 (PDT)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id w15-20020a63c10f000000b0042988a04bfdsm10758513pgf.9.2022.10.19.17.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 17:48:48 -0700 (PDT)
Date:   Thu, 20 Oct 2022 06:18:37 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v2 10/25] bpf: Introduce local kptrs
Message-ID: <20221020004837.qclzg6pgrqamcn7e@apollo>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-11-memxor@gmail.com>
 <582912fa-3d32-7c5a-cf24-fc79899a2e31@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <582912fa-3d32-7c5a-cf24-fc79899a2e31@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 10:45:22PM IST, Dave Marchevsky wrote:
> On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
> > Introduce the idea of local kptrs, i.e. PTR_TO_BTF_ID that point to a
> > type in program BTF. This is indicated by the presence of MEM_TYPE_LOCAL
> > type tag in reg->type to avoid having to check btf_is_kernel when trying
> > to match argument types in helpers.
> >
> > For now, these local kptrs will always be referenced in verifier
> > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > to such objects, as long fields that are special are not touched
> > (support for which will be added in subsequent patches).
> >
> > No PROBE_MEM handling is hence done since they can never be in an
> > undefined state, and their lifetime will always be valid.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h              | 14 +++++++++++---
> >  include/linux/filter.h           |  4 +++-
> >  kernel/bpf/btf.c                 |  9 ++++++++-
> >  kernel/bpf/verifier.c            | 15 ++++++++++-----
> >  net/bpf/bpf_dummy_struct_ops.c   |  3 ++-
> >  net/core/filter.c                | 13 ++++++++-----
> >  net/ipv4/bpf_tcp_ca.c            |  3 ++-
> >  net/netfilter/nf_conntrack_bpf.c |  1 +
> >  8 files changed, 45 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 46330d871d4e..a2f4d3356cc8 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -526,6 +526,11 @@ enum bpf_type_flag {
> >  	/* Size is known at compile time. */
> >  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +	/* MEM is of a type from program BTF, not kernel BTF. This is used to
> > +	 * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
> > +	 */
> > +	MEM_TYPE_LOCAL		= BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >  	__BPF_TYPE_FLAG_MAX,
> >  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > @@ -774,6 +779,7 @@ struct bpf_prog_ops {
> >  			union bpf_attr __user *uattr);
> >  };
> >
> > +struct bpf_reg_state;
> >  struct bpf_verifier_ops {
> >  	/* return eBPF function prototype for verification */
> >  	const struct bpf_func_proto *
> > @@ -795,6 +801,7 @@ struct bpf_verifier_ops {
> >  				  struct bpf_insn *dst,
> >  				  struct bpf_prog *prog, u32 *target_size);
> >  	int (*btf_struct_access)(struct bpf_verifier_log *log,
> > +				 const struct bpf_reg_state *reg,
>
> Not that struct_ops API is meant to be stable, but would be good to note that
> this changes that API in the summary.
>

Ack, will do.

> On that note, maybe passing whole bpf_reg_state *reg can be avoided for now
> by making this a 'bool disallow_ptr_walk' or similar, since that's the only
> thing this patch is using it for.
>

I did this in the RFC version, with bool local_type, but Alexei asked me to drop
it and just pass the register in. But more on that below...

> >  				 const struct btf *btf,
> >  				 const struct btf_type *t, int off, int size,
> >  				 enum bpf_access_type atype,
> > @@ -2076,10 +2083,11 @@ static inline bool bpf_tracing_btf_ctx_access(int off, int size,
> >  	return btf_ctx_access(off, size, type, prog, info);
> >  }
> >
> > -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> > +int btf_struct_access(struct bpf_verifier_log *log,
> > +		      const struct bpf_reg_state *reg, const struct btf *btf,
> >  		      const struct btf_type *t, int off, int size,
> > -		      enum bpf_access_type atype,
> > -		      u32 *next_btf_id, enum bpf_type_flag *flag);
> > +		      enum bpf_access_type atype, u32 *next_btf_id,
> > +		      enum bpf_type_flag *flag);
> >  bool btf_struct_ids_match(struct bpf_verifier_log *log,
> >  			  const struct btf *btf, u32 id, int off,
> >  			  const struct btf *need_btf, u32 need_type_id,
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index efc42a6e3aed..9b94e24f90b9 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -568,7 +568,9 @@ struct sk_filter {
> >  DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> >
> >  extern struct mutex nf_conn_btf_access_lock;
> > -extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log, const struct btf *btf,
> > +extern int (*nfct_btf_struct_access)(struct bpf_verifier_log *log,
> > +				     const struct bpf_reg_state *reg,
> > +				     const struct btf *btf,
> >  				     const struct btf_type *t, int off, int size,
> >  				     enum bpf_access_type atype, u32 *next_btf_id,
> >  				     enum bpf_type_flag *flag);
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 066984d73a8b..65f444405d9c 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6019,11 +6019,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
> >  	return -EINVAL;
> >  }
> >
> > -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> > +int btf_struct_access(struct bpf_verifier_log *log,
> > +		      const struct bpf_reg_state *reg, const struct btf *btf,
> >  		      const struct btf_type *t, int off, int size,
> >  		      enum bpf_access_type atype __maybe_unused,
> >  		      u32 *next_btf_id, enum bpf_type_flag *flag)
> >  {
> > +	bool local_type = reg && (type_flag(reg->type) & MEM_TYPE_LOCAL);
> >  	enum bpf_type_flag tmp_flag = 0;
> >  	int err;
> >  	u32 id;
> > @@ -6033,6 +6035,11 @@ int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> >
> >  		switch (err) {
> >  		case WALK_PTR:
> > +			/* For local types, the destination register cannot
> > +			 * become a pointer again.
> > +			 */
> > +			if (local_type)
> > +				return SCALAR_VALUE;
> >  			/* If we found the pointer or scalar on t+off,
> >  			 * we're done.
> >  			 */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3c47cecda302..6ee8c06c2080 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4522,16 +4522,20 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >  		return -EACCES;
> >  	}
> >
> > -	if (env->ops->btf_struct_access) {
> > -		ret = env->ops->btf_struct_access(&env->log, reg->btf, t,
> > +	if (env->ops->btf_struct_access && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
> > +		WARN_ON_ONCE(!btf_is_kernel(reg->btf));
> > +		ret = env->ops->btf_struct_access(&env->log, reg, reg->btf, t,
> >  						  off, size, atype, &btf_id, &flag);
> >  	} else {
> > -		if (atype != BPF_READ) {
> > +		if (atype != BPF_READ && !(type_flag(reg->type) & MEM_TYPE_LOCAL)) {
> >  			verbose(env, "only read is supported\n");
> >  			return -EACCES;
> >  		}
> >
> > -		ret = btf_struct_access(&env->log, reg->btf, t, off, size,
> > +		if (reg->type & MEM_TYPE_LOCAL)
> > +			WARN_ON_ONCE(!reg->ref_obj_id);
>
> Can we instead verbose(env, ...) and return error? Then when someone tries to
> add local kptrs that don't set ref_obj_id in the future, it'll be more obvious
> that this wasn't explicitly supported and they need to check verifier logic
> carefully. Also rest of check_ptr_to_btf_access checks do verbose + err.
>
> Similar for btf_is_kernel WARN above.
>

Ack.

> > +
> > +		ret = btf_struct_access(&env->log, reg, reg->btf, t, off, size,
>
>
> more re: passing entire reg state to btf_struct access:
>
> In the next patch in the series ("bpf: Recognize bpf_{spin_lock,list_head,list_node} in local kptrs")
> you do btf_find_struct_meta(btf, reg->btf_id). I see why you couldn't use 't'
> that's passed in here / elsewhere since you need the btf_id for meta lookup.
> Perhaps 'btf_type *t' param can be changed to btf_id, eliminating the need
> to pass 'reg'.
>
> Alternatively, since we're already passing reg->btf and result of
> btf_type_by_id(reg->btf, reg->btf_id), seems like btf_struct_access
> maybe is tied closely enough to reg state that passing reg state
> directly and getting rid of extraneous args is cleaner.
>

So Alexei actually suggested dropping both btf and type arguments and simply
pass in the register and get it from there.

But one call site threw a wrench in the plan:

check_ptr_to_map_access -> btf_struct_access

Here, it passes it's own btf and type to simulate access to a map. Maybe I
should be creating a dummy register on stack and make it work like that for this
particular case? Otherwise all other callers pass in what they have from reg.
