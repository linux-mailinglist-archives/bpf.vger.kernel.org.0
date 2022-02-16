Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A835A4B9452
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 00:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiBPXGm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 18:06:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiBPXGl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 18:06:41 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71702C0506
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 15:06:27 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c10so3427089pfv.8
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 15:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYy1uKYc71k8DY9W/w/O9E3TFrivn7NCxyOxV7XqaLk=;
        b=IoHgV8vvhStN6jCIln4TjfRLydR4QP2vaE1zP3smZelt0QgH9CRxdPwadnuz+aogow
         wFhn2Ed9vcQUoKHG2TYH3ADgPmsPUREYQrIwYRZJDtx94BOBdrienPQ6Gj7xnwlyTRJg
         DYtfG/DGrLzpHfnYdtfPVfWc/R7nRDZ1OazLZuy5/6bjHo6+YnZT9lS+opQ0uoGcvJzh
         B8TYrzau5/tJbB1lCixFdrdZg1w7enVXnoqAS+gEA8IM1z/QoMxjoLajiIeCdR2CxnM9
         GgmtyWvbXA+TWHYceskYNF+m7wnAl2di4Bdm43NRpmXVX+tBmAqAJeybm3gY3ufGfoDg
         X5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYy1uKYc71k8DY9W/w/O9E3TFrivn7NCxyOxV7XqaLk=;
        b=FvXx9ULpEwWTqZjvlyXJEv59eeu4K7mG34UTIbGH2cj3MJ+c8ArhlurNdqVFQFZSQX
         +bEAFD7qFuEAXDQP9JO9OuplzvnOGvbCx1tE2E/IXR2/QVygzNFMrtMbEdqs18y6g2ng
         28FJXTSYcXSMUPSG2Gi3cFRlY0DZ0YLkjRGUJlN/+zhcrwxN2rfXI9KD7/vZlUJ8bsdj
         xjK340ahfWK3kb2ICC8FwGQNLk197SoDWc6O0A7YVrHoeC35h9nVWJmJrFaaxdUf9Gn2
         lVY00VCBA4S40VKcrmInfwgQOFDpoKrQ+SsbqCNEQjgoBIrg5lTJIh9gROIHHfi+s2/z
         mnUQ==
X-Gm-Message-State: AOAM5332Iey3BizgKjZ+0lDieqkORx2kJyGPIL1ZDkxMpk1UNvaPRJdT
        LAGoAjwJhmb0EpXzcPz1h2g=
X-Google-Smtp-Source: ABdhPJymKY/OCdkNwG89IgiGBPWZXNEpOynhCK3efXRyrVvO8Mou7PPlN3pZOWstLJ7L172rFawStg==
X-Received: by 2002:aa7:8601:0:b0:4cc:783a:a2d2 with SMTP id p1-20020aa78601000000b004cc783aa2d2mr284058pfn.65.1645052786884;
        Wed, 16 Feb 2022 15:06:26 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f367])
        by smtp.gmail.com with ESMTPSA id 19sm7925223pfz.153.2022.02.16.15.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 15:06:26 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:06:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type >
 __BPF_REG_TYPE_MAX
Message-ID: <20220216230615.po6huyrgkswk7u67@ast-mbp.dhcp.thefacebook.com>
References: <20220216091323.513596-1-memxor@gmail.com>
 <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
 <20220216173348.luidfddtou6yfxed@apollo.legion>
 <CAADnVQJ-wMjyBQUYELYCjDTST8M5+TKRw2fi7nfrv79319fwog@mail.gmail.com>
 <20220216182954.jwzrum5ivekxca72@apollo.legion>
 <20220216194956.dl3kjtxfrdownoga@ast-mbp.dhcp.thefacebook.com>
 <20220216205842.hurazq2qkduhsuye@apollo.legion>
 <20220216214405.tn7thpnvqkxuvwhd@ast-mbp.dhcp.thefacebook.com>
 <20220216222341.z7thlblap2jwmwlc@apollo.legion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216222341.z7thlblap2jwmwlc@apollo.legion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 03:53:41AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > >
> > >
> > > Good point. I did think about this problem. Right now when you load a referenced
> > > pointer from the BPF map, we mark it as PTR_UNTRUSTED, so you can dereference
> >
> > you mean UNreferenced pointer, right? Since that's what your patch is doing.
> >
> 
> You caught a bug :). Instead of...
> 
> 	else if (!ref_ptr)
> 		reg_flags |= PTR_UNTRUSTED;
> 
> it should simply be 'else', then for non-percpu BTF ID pointer and non-user BTF
> ID pointer, only XCHG (from referenced pointer) unsets PTR_UNTRUSTED, both
> CMPXCHG and LDX have untrusted bit set during mark_btf_ld_reg.

btw please drop CMPXCHG for now.
The "} else if (is_cmpxchg_insn(insn)) {" part looks incomplete.
The verifier cannot support acquire/release semantics, so the value
of cmpxchg is dubious.
Let's brainstorm after the main pieces land.

> > >
> > > It is already marked PTR_UNTRUSTED for sleepable too, IIUC, but based on above I
> > > guess we can remove the flag for objects which are RCU protected, in case of
> > > non-sleepable progs.
> >
> > Probably not. Even non-sleepable prog under rcu_read_lock shouldn't be able
> > to pass 'struct tcp_sock *' from the map into helpers.
> > That sock can have refcnt==0. Even under rcu it's dangerous.
> >
> 
> Good point, so instead of helpers doing the inc_not_zero each time, prog can do
> it once and pass into other helpers.

The kptr_get helper will do it once too.
So it's the same overhead.

> > > We also need to prevent the kptr_get helper from being
> > > called from sleepable progs.
> >
> > why is that?
> 
> My confusion comes because I don't think that normal call_rcu/synchronize_rcu
> grace period for the object waits for RCU trace readers. In sleepable prog, that
> same xchg+release can happen while we hold a untrusted pointer from LDX in the
> RCU trace section. Then I think that kptr_get may be wrong, because object may
> already have been freed without waiting for sleepable prog to call
> rcu_read_unlock_trace.

Right. If we go with the helper approach we can do:
BPF_CALL_2(bpf_kptr_get, void **, kptr, int, refcnt_off)
{
        void *ptr;

        rcu_read_lock();
        ptr = READ_ONCE(kptr);

        if (!ptr)
                goto out;
        /* ptr->refcnt could be == 0 if another cpu did
         * ptr2 = bpf_kptr_xchg();
         * bpf_*_release(ptr2);
         */
        if (!refcount_inc_not_zero((refcount_t *)(ptr + refcnt_off)))
                goto out;
        rcu_read_unlock();
        return (long) ptr;
out:
        rcu_read_unlock();
        return 0;
}

and it will work in sleepable progs.
But if we allow direct LDX to return PTR_TO_BTF_ID | PTR_UNTRUSTED
then we need to support explicit bpf_rcu_read_lock|unlock() done
inside bpf prog which is unnecessary overhead for everyone put PREEMPT=y.
Plus a bunch of additional complexity in the verifier to support
explicit RCU section.
Pros and cons.
Anyway post your patches and will get it from there.

I've been thinking about
obj = bpf_obj_alloc(bpf_core_type_id_local(struct my_obj), BPF_TYPE_ID_LOCAL);
...
bpf_obj_put(obj);
on top of refcnted ptr_to_btf_id stored into maps.
That's another huge discussion.
