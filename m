Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF20500213
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiDMWyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 18:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDMWyo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 18:54:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671342A26
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 15:52:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso2859291ybs.20
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RX7bek4DlBUU9/z5kShIr/wrkr/b2Sl9JJHd+lNi1Ew=;
        b=FiHkOWqZ086ZkQSokMmRl1+HxvYZ25Cqv/++Tl3DfAV2Pra0vZx5c5B2K80ZG4+M0c
         unmXZRdAuKafHGZ/JwMOflOpygwfLSaleMGqlMf7Iv6Yn5+oHYCcRY1k9IuhgubHLPbf
         jU4c+4UjHdM1PgfkCakWn7FXSK4nvZNudOTR3sxjvviw0T5P/itDIvr3kGhvR8AucnHs
         gGHWhy65fI2pISqCkySEYao6xETUQP/Ti8YzGsc0zJGSS++nicBM8axmdZnPN9E14DCF
         FkSZtAAWCIIKPD5x8d+SFaU30qjyuc8pLqlYmVttCGD98ZIWrdhVuBv32G/0tmZfBNoS
         P33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RX7bek4DlBUU9/z5kShIr/wrkr/b2Sl9JJHd+lNi1Ew=;
        b=TR5cxR6pTJoLLOcbvqbnRMOxRrSpcOgjfpw7sP7gVn8vFQGZDS5XPzq+Y4+5Rq0mA9
         62tEG+KSqFXcQzAZJ+lMzoUBa2veaYjvQlSOTDZ9V+4uVSUWQur/2Ocxv6MClCy7zVi/
         6TGNa+kZHF/vLeHtUpFavOvBx48InT/DhGynLrFzw+FPGEkpjRu4kHG5k4EwCuPXBG48
         syaOzHLaaGHBgnifJbK/h/FsG8DC+34ePYJjI4VcRulwzxDRsHAyjqXplXLNd++bKS+E
         wQqhpn+2u4Chpeg1zQYAvuYotAPj2Kd4hFkZS0lhHLnw9N95lY+Pl4geEYthqSJElN4+
         whGQ==
X-Gm-Message-State: AOAM532ISDVmZy4nhOKB7j9ilzjgpU6588+wyIIVpXTldU6tUa3Fw4uy
        0aZD5uKnYAQWykVCCise87RXeAk=
X-Google-Smtp-Source: ABdhPJzr9d1pi4G0Mdm0E7FUfpnNKgN3s+93J/X/NgAK2FHmnkoA4045DFwPEm31GaZPQPy4UkPT3eI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:45c6:42d5:e443:72cc])
 (user=sdf job=sendgmr) by 2002:a25:9984:0:b0:624:5b01:5075 with SMTP id
 p4-20020a259984000000b006245b015075mr920365ybo.463.1649890341265; Wed, 13 Apr
 2022 15:52:21 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:52:18 -0700
In-Reply-To: <20220413223216.7lrdbizxg4g2bv5i@kafai-mbp.dhcp.thefacebook.com>
Message-Id: <YldUIipJvL/7tK4P@google.com>
Mime-Version: 1.0
References: <20220413183256.1819164-1-sdf@google.com> <CAEf4Bzb_-KMy7GBN_NsJCKXHfDnGTtVEZb7i4dmcN-8=cLhO+A@mail.gmail.com>
 <Ylcm/dfeU3AEYqlV@google.com> <CAEf4BzYuTd9m4_J9nh5pZ9baoMMQK+m6Cum8UMCq-k6jFTJwEA@mail.gmail.com>
 <20220413223216.7lrdbizxg4g2bv5i@kafai-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf-next] bpf: move rcu lock management out of
 BPF_PROG_RUN routines
From:   sdf@google.com
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/13, Martin KaFai Lau wrote:
> On Wed, Apr 13, 2022 at 12:52:53PM -0700, Andrii Nakryiko wrote:
> > On Wed, Apr 13, 2022 at 12:39 PM <sdf@google.com> wrote:
> > >
> > > On 04/13, Andrii Nakryiko wrote:
> > > > On Wed, Apr 13, 2022 at 11:33 AM Stanislav Fomichev <sdf@google.com>
> > > > wrote:
> > > > >
> > > > > Commit 7d08c2c91171 ("bpf: Refactor BPF_PROG_RUN_ARRAY family of  
> macros
> > > > > into functions") switched a bunch of BPF_PROG_RUN macros to inline
> > > > > routines. This changed the semantic a bit. Due to arguments  
> expansion
> > > > > of macros, it used to be:
> > > > >
> > > > >         rcu_read_lock();
> > > > >         array = rcu_dereference(cgrp->bpf.effective[atype]);
> > > > >         ...
> > > > >
> > > > > Now, with with inline routines, we have:
> > > > >         array_rcu = rcu_dereference(cgrp->bpf.effective[atype]);
> > > > >         /* array_rcu can be kfree'd here */
> > > > >         rcu_read_lock();
> > > > >         array = rcu_dereference(array_rcu);
> > > > >
> > >
> > > > So subtle difference, wow...
> > >
> > > > But this open-coding of rcu_read_lock() seems very unfortunate as
> > > > well. Would making BPF_PROG_RUN_ARRAY back to a macro which only  
> does
> > > > rcu lock/unlock and grabs effective array and then calls static  
> inline
> > > > function be a viable solution?
> > >
> > > > #define BPF_PROG_RUN_ARRAY_CG_FLAGS(array_rcu, ctx, run_prog,  
> ret_flags) \
> > > >    ({
> > > >        int ret;
> > >
> > > >        rcu_read_lock();
> > > >        ret =
> > > > __BPF_PROG_RUN_ARRAY_CG_FLAGS(rcu_dereference(array_rcu), ....);
> > > >        rcu_read_unlock();
> > > >        ret;
> > > >    })
> > >
> > >
> > > > where __BPF_PROG_RUN_ARRAY_CG_FLAGS is what
> > > > BPF_PROG_RUN_ARRAY_CG_FLAGS is today but with __rcu annotation  
> dropped
> > > > (and no internal rcu stuff)?
> > >
> > > Yeah, that should work. But why do you think it's better to hide them?
> > > I find those automatic rcu locks deep in the call stack a bit obscure
> > > (when reasoning about sleepable vs non-sleepable contexts/bpf).
> > >
> > > I, as the caller, know that the effective array is rcu-managed (it
> > > has __rcu annotation) and it seems natural for me to grab rcu lock
> > > while work with it; I might grab it for some other things like cgroup
> > > anyway.
> >
> > If you think that having this more explicitly is better, I'm fine with
> > that as well. I thought a simpler invocation pattern would be good,
> > given we call bpf_prog_run_array variants in quite a lot of places. So
> > count me indifferent. I'm curious what others think.

> Would it work if the bpf_prog_run_array_cg() directly takes the
> 'struct cgroup *cgrp' argument instead of the array ?
> bpf_prog_run_array_cg() should know what protection is needed
> to get member from the cgrp ptr.  The sk call path should be able
> to provide a cgrp ptr.  For current cgrp, pass NULL as the cgrp
> pointer and then current will be used in bpf_prog_run_array_cg().
> A rcu_read_lock() is needed anyway to get the current's cgrp
> and can be done together in bpf_prog_run_array_cg().

> That there are only two remaining bpf_prog_run_array() usages
> from lirc and bpf_trace which are not too bad to have them
> directly do rcu_read_lock on their own struct ?

 From Andrii's original commit message:

     I think BPF_PROG_RUN_ARRAY_CG would benefit from further refactoring to  
accept
     struct cgroup and enum bpf_attach_type instead of bpf_prog_array,  
fetching
     cgrp->bpf.effective[type] and RCU-dereferencing it internally. But that
     required including include/linux/cgroup-defs.h, which I wasn't sure is  
ok with
     everyone.

I guess including cgroup-defs.h/bpf-cgroup-defs.h into bpf.h might still
be somewhat problematic?

But even if we pass the cgroup pointer, I'm assuming that this cgroup  
pointer
is still rcu-managed, right? So the callers still have to rcu-lock.
However, in most places we don't care and do "cgrp =  
sock_cgroup_ptr(&sk->sk_cgrp_data);"
but seems like it depends on the fact that sockets can't (yet?)
change their cgroup association and it's fine to not rcu-lock that
cgroup. Seems fragile, but ok. It always stumbles me when I see:

cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
bpf_prog_run_array_cg_flags(cgrp.bpf->effective[atype], ...)

But then, with current, it becomes:

rcu_read_lock();
cgrp = task_dfl_cgroup(current);
bpf_prog_run_array_cg_flags(cgrp.bpf->effective[atype], ...)
rcu_read_unlock();

Idk, I might be overthinking it. I'll try to see if including
bpf-cgroup-defs.h and passing cgroup_bpf is workable.
