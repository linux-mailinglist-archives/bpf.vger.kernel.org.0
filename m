Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735485FB751
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJKPcr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKPcX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 11:32:23 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD01AF1A;
        Tue, 11 Oct 2022 08:22:06 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id g9so9119812qvo.12;
        Tue, 11 Oct 2022 08:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI8/iw+T1k5N6jTBGY7530xalCx4rWDXOfzjPqNDZzg=;
        b=Nr9QxCkoICr7BtlS0Gt/g+A7oLmJ8tr7qXzbpgzsR+GWCDIWTjXNGbVUStTqnKSdMK
         c76ZVkqAybMG144Wgda4hBgdA0wtOwgNvbswR0Gwts/klfV/N43dd/yuDv6MohYXFGcu
         SrNfMbyQkyHxyDHV/+ZhA4t7r8vqFXRxlZPVflqX7lTkLIWktf4qAUYDY8wSKfy8GT3B
         WZDG4MmFxKRwvMn/9WIyH3nEFMUedU7V8HjAiUXRktK7URJsEFIfOC38DnnsdLqniTDv
         YVmpf8E7cX1+Gj1qCchL9XbRL5/IWU8W9HqCDZuGjEdVwPcwu0xGXWr+xWkA2lzEBZGj
         C2EQ==
X-Gm-Message-State: ACrzQf2kybYEaszmYbrUKaXQSLqqJ8IAbxdmo+PdbW/ZtlQayez/bUnq
        7glLsHmWPEI5jSYgdR2wvHI=
X-Google-Smtp-Source: AMsMyM4cPPBmEDDnA7fXR4IV3z0CAsMC55le7Y0+H6N3EiDni7okWR3i4nvBAH9zIe8uIFJesZd9/g==
X-Received: by 2002:a05:6214:3006:b0:499:1f87:dac9 with SMTP id ke6-20020a056214300600b004991f87dac9mr19719270qvb.0.1665501679626;
        Tue, 11 Oct 2022 08:21:19 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3552])
        by smtp.gmail.com with ESMTPSA id j15-20020ac8550f000000b0039a17374294sm4859147qtq.78.2022.10.11.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:21:19 -0700 (PDT)
Date:   Tue, 11 Oct 2022 10:21:16 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect
 real use-cases
Message-ID: <Y0WJ7FNlYIsWbTjP@maniforge.dhcp.thefacebook.com>
References: <20221002171012.3529521-1-void@manifault.com>
 <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
 <YzrpI4PWxDaejZ6d@maniforge.dhcp.thefacebook.com>
 <CAP01T74bA2-qf3-yTkqd01k-Ft-7LJBGnuc9yOWkZK_ZmydqLw@mail.gmail.com>
 <YzxRa6dBz6z/85ZV@maniforge.lan>
 <CAP01T77QYNc6BJP+OtVV3YQGgS06ZeWTUBdq3sp2FhKmeoo6-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T77QYNc6BJP+OtVV3YQGgS06ZeWTUBdq3sp2FhKmeoo6-A@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 08:10:26AM +0530, Kumar Kartikeya Dwivedi wrote:

[...]

> > > > > Also, even if you made it work, wouldn't you have the warning once you
> > > > > run more selftests using prog_test_run, if you just set the  destroyed
> > > > > bit on each test run?
> > > >
> > > > If we want to update the test to have the refcount drop to 0, we would
> > > > probably have to instead use dynamically allocated objects. At that
> > > > point, we'd probably just crash instead of seeing a warning if we
> > > > accidentally let a caller invoke acquire or release after the object had
> > > > been destroyed. Maybe the better thing to do here is to just warn
> > > > unconditionally in the destructor rather than setting a flag? What we
> > > > really want to ensure is that the final refcount that's "owned" by the
> > > > main kernel is never dropped.
> > >
> > > I think the refcount_t API already warns if underflow happens.
> >
> > Right, a warning would probably show up if we did a release that caused
> > an underflow, but it would not for an acquire after the refcount dropped
> > to 0.
> >
> 
> It should, see REFCOUNT_ADD_UAF in include/linux/refcount.h.

Ahh, right you are, fair enough and thanks for hand holding and pointing
me directly at the relevant code. I now agree that the warns on the
destroyed field are just redundant.

> > > To be clear, I don't mind if you want to improve this, it's certainly
> > > a mess right now. Tests can't even run in parallel easily because it's
> > > global. Testing like an actually allocated object might be a good way
> > > to simulate a real scenario. And I totally agree that having a real
> > > example is useful to people who want to add support for more kptrs.
> >
> > Ok, let me update the tests to do two things then:
> >
> > 1. Add a new test kfunc called bpf_kfunc_call_test_alloc() which returns
> >    a dynamically allocated instance of a prog_test_ref_kfunc *. This is
> >    similar in intention to bpf_xdp_ct_alloc().
> > 2. Update bpf_kfunc_call_test_acquire() and
> >    bpf_kfunc_call_test_release() to take a trusted pointer to that
> >    allocated prog_test_ref_kfunc *.
> 
> This should work, but you would have to go through a lot of tests,
> sadly I assumed it is global in a lot of places to make testing easier
> (e.g. observing count after releasing by doing p->next, which gave me
> a PTR_TO_BTF_ID that is preserved after release).
> Some other way would have to be found to do the same thing.

Hmmm, ok, let me spend a bit of time trying to make all of this dynamic.
If it becomes clear that it's too much of a PITA, I might just drop the
patch; especially considering that your __rcu kptr work will address
what I was really initially trying to fix (which is that the kptr_get
pattern used in the test would likely be racy for a real kfunc). Or if
we want to, we could keep what it has now, but I could just update
delayed_destroy_test_ref_struct() to do nothing other than
WARN_ON_ONCE() and remove the extra warns for
prog_test_struct.destroyed. We can make a final call when I send out v3.

> > 3. Keep the other changes which e.g. use RCU in
> >    bpf_kfunc_call_test_kptr_get() to synchronize on getting the kptr.
> >    Once the __rcu kptr variant is landed we can get rid of
> >    bpf_kfunc_call_test_kptr_get() and make bpf_kfunc_call_test_acquire()
> >    require an __rcu pointer.
> >
> 
> In the case of RCU I don't plan on passing the rcu pointer to acquire
> functions, but rather kptr_get stops taking pointer to pointer. I.e.
> in your point 3, kptr_get does what you want _acquire to do. It takes
> an rcu protected pointer to an object and safely increments its count.

Oh, ok. So the idea is that the acquire function takes a normal trusted
pointer, and kptr_get takes an RCU protected kptr (so it would still
have to do refcount_inc_not_zero()). Makes sense.

> > Continuing on point (3) above, we should _probably_ also have an example
> > for an object that isn't RCU-protected? I imagine that we don't want to
> > get rid of KF_KPTR_GET entirely once we have __rcu pointers because some
> > kptr_get() implementations may synchronize in other ways, such as with
> > spinlocks or whatever. Let's leave this until after __rcu lands though.
> >
> 
> I think it's unlikely kptr_get can work without it, spinlocks may be
> required internally (e.g. to inspect the object key/generation in
> SLAB_TYPESAFE_BY_RCU case without races) but that goes on top of RCU
> protection. But yes, it depends, maybe it will work for some special
> cases. Though I don't think it's worth adding an example for the
> uncommon case.

Yeah, let's leave it off for now until we have a concrete use case in
the kernel that we want to mirror in a testcase.
