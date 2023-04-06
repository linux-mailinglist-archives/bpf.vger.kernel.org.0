Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E16D979C
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjDFNGg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 09:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjDFNGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 09:06:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2FF4
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 06:06:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so5772987wmb.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680786393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KWnOYOOmJ2+Hsz2+ql2JlR9/kav8s50+fNDjDb4rgd0=;
        b=eUrkKxWmpxjrGDFwl2JcYQECtemk+qA6M3NDKMBpyP7BQwcVk3cEdBz/G+ri8Teuni
         +y+/33S+RN/gWJVrtEKaHwMEXFqNRP+2a9y+QKKMIEDBbGga5K0P/5ddZJmg3Xs1o8fj
         FZXkcyX7r8WFe07w0D1nmJpHZf8OkE8J7m7MOVLfsvdBJ8EsRouzuolCcLS6lePZAnbg
         jIHYNGBL2pZdQ78iwlE5/91AhWZ0JJ0TBUkqXNxUKUK77Vbpksx3JNO5QOZHvp3NWqZX
         anHI7umDVBQbE4nJFA3/aMLYXoVhgFhp3zWedmckeO7Ocx2A/vbHGIYhf1qfDuAVq4gX
         +fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680786393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWnOYOOmJ2+Hsz2+ql2JlR9/kav8s50+fNDjDb4rgd0=;
        b=KS9wKzP4GfUi0b3pHvTZSGLscQejaJM59ZspiVOv96G7JC43Dn2RBzNg+jtkLmnLx/
         46p8qGUtTmOXF24/OzzYkB1sDhuIIExuQ/nea88zzAGR0uGz4wi6PeEXuM22qYgY/1XI
         jbHkdEwr6E1CwN3sT/DI8HYSNZpbxBPrLgc87ItDeKVjWaUfofzB6eO2cTZ3Dk4bnTBk
         ZVqjLEeGHqnfDDLc1m5zg9b4Fir3YwLUXgTWEGUaZmSBHbkSMjYfviuHLqnpcwgRLt2V
         9wd5FeIiTxgHGDiyyivqWc1VevR/xmSESQdAwc2H9qGITNYSUQjM68W0M0WePC528+aL
         wLzA==
X-Gm-Message-State: AAQBX9dMrXAvuY189SsziD30cOCJu9qb9qHX/o3KHIOKr0edTD++uk1B
        CiNn7ReOunVSo2vZ86CXtnE=
X-Google-Smtp-Source: AKy350aIftk1R/RisvIXv3W1CPDCnCOqodVGJCPEYvAvvJHqB2jjo1R7FB0iLmbGMwHLJy0b+qIg0Q==
X-Received: by 2002:a1c:7211:0:b0:3ef:7584:9896 with SMTP id n17-20020a1c7211000000b003ef75849896mr7085193wmc.26.1680786392837;
        Thu, 06 Apr 2023 06:06:32 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm5303062wms.1.2023.04.06.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:06:32 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Apr 2023 15:06:29 +0200
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v6] bpf: Support 64-bit pointers to kfuncs
Message-ID: <ZC7D1bH8zK7vDChQ@krava>
References: <20230405213453.49756-1-iii@linux.ibm.com>
 <ZC6UgfMdSZJ8BCT8@krava>
 <62501084abbb6cc9492df60ff4d427a17e731fe4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62501084abbb6cc9492df60ff4d427a17e731fe4.camel@linux.ibm.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 02:31:06PM +0200, Ilya Leoshkevich wrote:
> On Thu, 2023-04-06 at 11:44 +0200, Jiri Olsa wrote:
> > On Wed, Apr 05, 2023 at 11:34:53PM +0200, Ilya Leoshkevich wrote:
> > 
> > SNIP
> > 
> > >  
> > > +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> > > +                      u16 btf_fd_idx, u8 **func_addr)
> > > +{
> > > +       const struct bpf_kfunc_desc *desc;
> > > +
> > > +       desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
> > > +       if (!desc)
> > > +               return -EFAULT;
> > > +
> > > +       *func_addr = (u8 *)desc->addr;
> > > +       return 0;
> > > +}
> > > +
> > >  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env
> > > *env,
> > >                                          s16 offset)
> > >  {
> > > @@ -2672,14 +2691,19 @@ static int add_kfunc_call(struct
> > > bpf_verifier_env *env, u32 func_id, s16 offset)
> > >                 return -EINVAL;
> > >         }
> > >  
> > > -       call_imm = BPF_CALL_IMM(addr);
> > > -       /* Check whether or not the relative offset overflows desc-
> > > >imm */
> > > -       if ((unsigned long)(s32)call_imm != call_imm) {
> > > -               verbose(env, "address of kernel function %s is out
> > > of range\n",
> > > -                       func_name);
> > > -               return -EINVAL;
> > > +       if (bpf_jit_supports_far_kfunc_call()) {
> > > +               call_imm = func_id;
> > > +       } else {
> > > +               call_imm = BPF_CALL_IMM(addr);
> > 
> > we compute call_imm again in fixup_kfunc_call, seems like we could
> > store
> > the address and the func_id in desc and have fixup_kfunc_call do the
> > insn->imm setup
> 
> We can drop this diff in fixup_kfunc_call():
> 
> -       insn->imm = desc->imm;
> +       if (!bpf_jit_supports_far_kfunc_call())
> +               insn->imm = BPF_CALL_IMM(desc->addr);
> 
> in order to avoid duplicating the imm calculation logic, but I'm not
> sure if we want to move the entire desc->imm setup there.
> 
> For example, fixup_kfunc_call() considers kfunc_tab const, which is a
> nice property that I think is worth keeping.
> 
> Another option would be to drop desc->imm, but having it is very
> convenient for doing lookups the same way on all architectures. 

ok, I see..  so should we do following in fixup_kfunc_call:

	if (!bpf_jit_supports_far_kfunc_call())
		insn->imm = desc->imm;

by default there's func_id in insn->imm

jirka

> 
> > > +               /* Check whether the relative offset overflows
> > > desc->imm */
> > > +               if ((unsigned long)(s32)call_imm != call_imm) {
> > > +                       verbose(env, "address of kernel function %s
> > > is out of range\n",
> > > +                               func_name);
> > > +                       return -EINVAL;
> > > +               }
> > >         }
> > >  
> > > +
> > 
> > nit, extra line
> 
> Ouch. Thanks for spotting this.
> 
> > 
> > >         if (bpf_dev_bound_kfunc_id(func_id)) {
> > >                 err = bpf_dev_bound_kfunc_check(&env->log,
> > > prog_aux);
> > >                 if (err)
> > > @@ -2690,6 +2714,7 @@ static int add_kfunc_call(struct
> > > bpf_verifier_env *env, u32 func_id, s16 offset)
> > >         desc->func_id = func_id;
> > >         desc->imm = call_imm;
> > >         desc->offset = offset;
> > > +       desc->addr = addr;
> > >         err = btf_distill_func_proto(&env->log, desc_btf,
> > >                                      func_proto, func_name,
> > >                                      &desc->func_model);
> > > @@ -2699,19 +2724,19 @@ static int add_kfunc_call(struct
> > > bpf_verifier_env *env, u32 func_id, s16 offset)
> > >         return err;
> > >  }
> > >  
> > > -static int kfunc_desc_cmp_by_imm(const void *a, const void *b)
> > > +static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
> > >  {
> > >         const struct bpf_kfunc_desc *d0 = a;
> > >         const struct bpf_kfunc_desc *d1 = b;
> > >  
> > > -       if (d0->imm > d1->imm)
> > > -               return 1;
> > > -       else if (d0->imm < d1->imm)
> > > -               return -1;
> > > +       if (d0->imm != d1->imm)
> > > +               return d0->imm < d1->imm ? -1 : 1;
> > > +       if (d0->offset != d1->offset)
> > > +               return d0->offset < d1->offset ? -1 : 1;
> > >         return 0;
> > >  }
> > >  
> > 
> > SNIP
> > 
> > > +/* replace a generic kfunc with a specialized version if necessary
> > > */
> > > +static void fixup_kfunc_desc(struct bpf_verifier_env *env,
> > > +                            struct bpf_kfunc_desc *desc)
> > > +{
> > > +       struct bpf_prog *prog = env->prog;
> > > +       u32 func_id = desc->func_id;
> > > +       u16 offset = desc->offset;
> > > +       bool seen_direct_write;
> > > +       void *xdp_kfunc;
> > > +       bool is_rdonly;
> > > +
> > > +       if (bpf_dev_bound_kfunc_id(func_id)) {
> > > +               xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog,
> > > func_id);
> > > +               if (xdp_kfunc) {
> > > +                       desc->addr = (unsigned long)xdp_kfunc;
> > > +                       return;
> > > +               }
> > > +               /* fallback to default kfunc when not supported by
> > > netdev */
> > > +       }
> > > +
> > > +       if (offset)
> > > +               return;
> > > +
> > > +       if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
> > > {
> > > +               seen_direct_write = env->seen_direct_write;
> > > +               is_rdonly = !may_access_direct_pkt_data(env, NULL,
> > > BPF_WRITE);
> > > +
> > > +               if (is_rdonly)
> > > +                       desc->addr = (unsigned
> > > long)bpf_dynptr_from_skb_rdonly;
> > > +
> > > +               /* restore env->seen_direct_write to its original
> > > value, since
> > > +                * may_access_direct_pkt_data mutates it
> > > +                */
> > > +               env->seen_direct_write = seen_direct_write;
> > > +       }
> > 
> > could we do this directly in add_kfunc_call?
> 
> Initially I thought that it wasn't possible, because
> may_access_direct_pkt_data() may depend on data gathered during
> verification. But on a second look that's simply not the case, so this
> code can indeed be moved to add_kfunc_call().
> 
> > 
> > thanks,
> > jirka
> 
> [...]
