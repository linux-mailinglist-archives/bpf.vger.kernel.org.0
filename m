Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4259908E
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiHRWa5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 18:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiHRWa4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 18:30:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6C844D4
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 15:30:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r22so2353918pgm.5
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=5GjY6aKeRfSCHidJGpdaQbr1NenxS0OetI2qFGnJQ0A=;
        b=OB4GfSpxgZu+5leIc4KqudwV72Ysp8CKY+TXEKgVF+0ODXT7Vsj7vU06IQO68Y5+Dl
         qiMer9ThwDX3I4W0nFHoywrgNXJcOGTLcmG1AM2izFgvJ9OWyBLQyOrh7srle8ImwFiB
         9d4vcXP4BCT7tREXFYmQzwcwzwYJdlniF4ZqKheVMygb8WXQ/Cmzf/oSAL1wX2UCiIaD
         wRHzlCTaTfSi0Tv+Pflf3k+X/mpvpwa2y/cknKeE47v8KNZ+zEg6IBe2MZoTfZEpo7gF
         NBU/Tk0BUsUcpu8PQFgaAq6tAilK7YqFZBA0HMYLicGmZaqucQn3/7dqYrGzVPN5k/Fg
         zE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5GjY6aKeRfSCHidJGpdaQbr1NenxS0OetI2qFGnJQ0A=;
        b=c2q5je/2qUMJ6DxIM39aAwqpPpUxY8RBWKPcMj7nYtb7sFDA2ZKKxK83VXsO5g9Z4x
         Pt4rEyoJBdRZnRhAN3AdOJsqw/HBRp8e91NGCj+eznklstZ0qRVN8GgMO8yHzMLTNknX
         hBrs1sCfdTA2o+/EhrF+roXOGW85IO1DO6GgDY42W+ikZEWG576RrrOY+S0Pvw8/WKU7
         B+nOOExXAHNywCKNqhwGuqXmvrOQlZb/mZKel6jlS/3ZyobHMZ+rpI2/esI4FPwap07Q
         2JMnGpupR+yqtJmLJQ5pg8Z5h43YJYMP3a9vk9XJTRp4EHRG0Ub17bY2lvcVx5GjPEfg
         +vZw==
X-Gm-Message-State: ACgBeo10oPITijSF9QtolnG4+E3LRH1guhWgnU0kthiR+ZRESy0XE63f
        yBMdT25s86vfCeDj32ezsKkiBPw85V8=
X-Google-Smtp-Source: AA6agR5A64xY6cuzcVNHfXGOKBQslEu/ghLn6n8VKHcE/0ahHHGCq/wDsUeLis3axzJcLCihf40oxw==
X-Received: by 2002:a63:d047:0:b0:41d:d4e9:e182 with SMTP id s7-20020a63d047000000b0041dd4e9e182mr3945966pgi.328.1660861854948;
        Thu, 18 Aug 2022 15:30:54 -0700 (PDT)
Received: from MacBook-Pro-3.local.dhcp.thefacebook.com ([2620:10d:c090:500::1:aa5c])
        by smtp.gmail.com with ESMTPSA id h12-20020aa79f4c000000b0052e57ed8cdasm2140649pfr.55.2022.08.18.15.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:30:54 -0700 (PDT)
Date:   Thu, 18 Aug 2022 15:30:51 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        tj@kernel.org, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 01/12] bpf: Introduce any context BPF
 specific memory allocator.
Message-ID: <20220818223051.ti3gt7po72c5bqjh@MacBook-Pro-3.local.dhcp.thefacebook.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
 <20220817210419.95560-2-alexei.starovoitov@gmail.com>
 <CAP01T77L6e=B6OtLcM4bToM5n4+j3S6+p+ieTPtDGUgQUZ3o1Q@mail.gmail.com>
 <20220818003957.t5lcp636n7we37hk@MacBook-Pro-3.local>
 <CAP01T74gcYpXXoafBAEaL5a_7FaDdfAwzmoE86pOctzmeeVhmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74gcYpXXoafBAEaL5a_7FaDdfAwzmoE86pOctzmeeVhmw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 02:38:06PM +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > > Assume the current nmi free llist is HEAD -> A -> B -> C -> D -> ...
> > > For our cmpxchg, parameters are going to be cmpxchg(&head->first, A, B);
> > >
> > > Now, nested NMI prog does unit_alloc thrice. this does llist_del_first thrice
> >
> > Even double llist_del_first on the same llist is bad. That's a known fact.
> 
> Well, if you think about it (correct me if I'm wrong), at least in
> this kind of nesting scenario on the same CPU, just doing
> llist_del_first in NMI prog which interrupts llist_del_first of
> bpf_mem_refill isn't a problem. The cmpxchg will fail as head->first
> changed. The problem occurs when you combine it with llist_add between
> the READ_ONCE(entry->next) and cmpxchg of the interrupted
> llist_del_first. The main invariant of llist_del_first is that
> entry->next should not change between READ_ONCE and cmpxchg, but if we
> construct an ABA scenario like I did in my previous reply, _then_ we
> have a problem. Otherwise it will just retry loop on exit if we e.g.
> llist_del_first and kptr_xchg the ptr (which won't do llist_add).

Of course. In some race scenarios the llist will stay sane.
In others there will be leaks. In others crashes.
Like we don't really need 3 llist_del followed by 3 out of order llist_add-s
to observe bad things. 2 llist_del-s and 1 llist_add are just as bad.
That's why the doc says do one llist_del_first at a time and doesn't
specify all possible bad things.

> >
> > > This makes nmi free llist HEAD -> D -> ...
> > > A, B, C are allocated in prog.
> > > Now it does unit_free of all three, but in order of B, C, A.
> > > unit_free does llist_add, nmi free llist becomes HEAD -> A -> C -> B -> D -> ...
> > >
> > > Nested NMI prog exits.
> > > We continue with our cmpxchg(&head->first, A, B); It succeeds, A is
> > > returned, but C will be leaked.
> >
> > This exact scenario cannot happen for bpf_mem_cache's freelist.
> > unit_alloc is doing llist_del_first on per-cpu freelist.
> > We can have two perf_event bpf progs. Both progs would
> > share the same hash map and use the same struct bpf_mem_alloc,
> > and both call unit_alloc() on the same cpu freelist,
> > but as you noticed bpf_prog_active covers that case.
> > bpf_prog_active is too coarse as we discussed in the other thread a
> > month or so ago. It prevents valid and safe execution of bpf progs, lost
> > events, etc. We will surely come up with a better mechanism.
> >
> > Going back to your earlier question:
> >
> > > Which are the other cases that might cause reentrancy in this
> > > branch such that we need atomics instead of c->free_cnt_nmi--?
> >
> > It's the case where perf_event bpf prog happened inside bpf_mem_refill in irq_work.
> > bpf_mem_refill manipulates free_cnt_nmi and nmi bpf prog too through unit_alloc.
> > Which got me thinking that there is indeed a missing check here.
> 
> Aaah, ok, so this is what you wanted to prevent. Makes sense, even
> though NMI nesting won't happen in progs (atleast for now), this
> irq_work refilling can be interrupted by some perf NMI prog, or raw_tp
> tracing prog in NMI context.

Right. Doesn't matter which prog type that would be.
in_nmi() is the context that needs special handling.
It could happen not only in bpf_prog_type_perf_event.

> > We need to protect free_bulk_nmi's llist_del_first from unit_alloc's llist_del_first.
> > bpf_prog_active could be used for that, but let's come up with a cleaner way.
> > Probably going to add atomic_t flag to bpf_mem_cache and cmpxchg it,
> > or lock and spin_trylock it. tbd.
> 
> Hm, can you explain why an atomic flag or lock would be needed, and
> not just having a small busy counter like bpf_prog_active for the NMI
> free llist will work? bpf_mem_cache is already per-CPU so it can just
> be int alongside the llist. You inc it before llist_del_first, and
> then assuming inc is atomic across interrupt boundary (which I think
> this_cpu_inc_return for bpf_prog_active is already assuming), NMI prog
> will see llist as busy and will fail its llist_del_first.
> llist_add should still be fine to allow.

Good idea. The per-cpu counter is faster and simpler.

> Technically we can fail llist_add instead, since doing multiple
> llist_del_first won't be an issue, but you can't fail bpf_mem_free,
> though you can fail bpf_mem_alloc, so it makes sense to protect only
> llist_del_first using the counter.

Right. We cannot fail in unit_free().
With per-cpu counter both unit_alloc() and free_bulk_nmi() would
potentially fail in such unlikely scenario.
Not a big deal for free_bulk_nmi(). It would pick the element later.
For unit_alloc() return NULL is normal.
Especially since it's so unlikely for nmi to hit right in the middle
of llist_del_first().

Since we'll add this per-cpu counter to solve interrupted llist_del_first()
it feels that the same counter can be used to protect unit_alloc/free/irq_work.
Then we don't need free_llist_nmi. Single free_llist would be fine,
but unit_free() should not fail. If free_list cannot be accessed
due to per-cpu counter being busy we have to push somewhere.
So it seems two lists are necessary. Maybe it's still better ?
Roughly I'm thinking of the following:
unit_alloc()
{
  llnode = NULL;
  local_irq_save();
  if (__this_cpu_inc_return(c->alloc_active) != 1))
     goto out;
  llnode = __llist_del_first(&c->free_llist);
  if (llnode)
      cnt = --c->free_cnt;
out:
  __this_cpu_dec(c->alloc_active);
  local_irq_restore();
  return ret;
}
unit_free()
{
  local_irq_save();
  if (__this_cpu_inc_return(c->alloc_active) != 1)) {
     llist_add(llnode, &c->free_llist_nmi);
     goto out;
  }
  __llist_add(llnode, &c->free_llist);
  cnt = ++c->free_cnt;
out:
  __this_cpu_dec(c->alloc_active);
  local_irq_restore();
  return ret;
}
alloc_bulk, free_bulk would be protected by alloc_active as well.
alloc_bulk_nmi is gone.
free_bulk_nmi is still there to drain unlucky unit_free,
but it's now alone to do llist_del_first() and it just frees anything
that is in the free_llist_nmi.
The main advantage is that free_llist_nmi doesn't need to prefilled.
It will be empty most of the time.
wdyt?
