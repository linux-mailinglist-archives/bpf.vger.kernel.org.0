Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71855FAAA9
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJKCk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKCk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 22:40:56 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C5262914;
        Mon, 10 Oct 2022 19:40:55 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id x13so5227547qkg.11;
        Mon, 10 Oct 2022 19:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaW5NqvrT9ryF2V36Z7H5qvsA3vRQVY2KYHhoBnRvN0=;
        b=i0hwyYMuuKGJpbnjBEXGZ85DalZmAgq8kSqWw1poQIPtq0HENy0OoOEDEk7WTTU9mV
         ps9d22bo2b3ZiEtDDbXT1wra92iAzVghlcSY1uWIJoLvebHG1xg5s+xRGC6eJT/PwH0y
         3DhWvNkgscSd/r+ZHVLqNhBUPlTBfMZoclLiQc2O5GBeXoji4q3k5NoL65KPHx8wtm8k
         3Ct7UqGry3RusYA3GyPnD9w3IxzxQw3C2n68woV9fCoLYNtaGjTQhRn+IGhHsJ9ZDZ/W
         wX12TLRxvPX1dVXbl6HDGLx+HTmUOJzCuJzZDq0n+nIuSgtakhs8565bvuJ6U7rFjlaw
         9oog==
X-Gm-Message-State: ACrzQf2RQTy9zctExSIBUm6wAdGaeYiaZmr844o0sD7WF1pynmuQbi8p
        7xnnFTITUP3tM6yzw37CnVU=
X-Google-Smtp-Source: AMsMyM7vSBtEa6m8/UizCbxnfZZVL7aY5CXwJMXCth/sANClFMuzkga1/HD6LCzGk2NcHH0K0vAi3g==
X-Received: by 2002:a05:620a:40c1:b0:6ee:1fa9:6c48 with SMTP id g1-20020a05620a40c100b006ee1fa96c48mr3201888qko.718.1665456054478;
        Mon, 10 Oct 2022 19:40:54 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::7fb0])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a280e00b006be8713f742sm11726531qkp.38.2022.10.10.19.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:40:54 -0700 (PDT)
Date:   Mon, 10 Oct 2022 21:40:51 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <Y0TXs5Um506K+vSg@maniforge.dhcp.thefacebook.com>
References: <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
 <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
 <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev>
 <CAP01T77tCdKTJo=sByg5GsW1OrQmNXV4fmBDKUVtbnwEaJBpVA@mail.gmail.com>
 <YztbOo7TgOoN1bVB@maniforge.dhcp.thefacebook.com>
 <CAP01T76rCLdExKZ0AdP9L6e_g+sj9D7Ec59rr+ddMJ-KU+h8QQ@mail.gmail.com>
 <YzxM+HSSqIDCPCUf@maniforge.lan>
 <CAP01T76zg0kABh36ekC4FTxDsdiYBaP7agErO=YadfFmaJ1LKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76zg0kABh36ekC4FTxDsdiYBaP7agErO=YadfFmaJ1LKQ@mail.gmail.com>
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

On Tue, Oct 11, 2022 at 07:59:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Tue, 4 Oct 2022 at 20:40, David Vernet <void@manifault.com> wrote:
> >
> > On Tue, Oct 04, 2022 at 12:22:08AM +0200, Kumar Kartikeya Dwivedi wrote:
> > > > Thanks for providing additional context, Kumar. So what do we want to do
> > > > for this patch set? IMO it doesn't seem useful to restrict
> > > > bpf_kfunc_acquire() to only be callable by non-sleepable programs if our
> > > > goal is to avoid crashes for nested task structs. We could easily
> > > > accidentally crash if e.g. those pointers are NULL, or someone is doing
> > > > something weird like stashing some extra flag bits in unused portions of
> > > > the pointer which are masked out when it's actually dereferenced
> > > > regardless of whether we're in RCU.  Trusting ctx loads sounds like the
> > > > right approach, barring some of the challenges you pointed out such as
> > > > dealing with fexit paths after free where the object may not be valid
> > > > anymore.
> > > >
> > > > In general, it seems like we should maybe decide on what our policy
> > > > should be for kfuncs until we can wire up whatever we need to properly
> > > > trust ctx.
> > >
> > > Well, we could add it now and work towards closing the gaps after
> > > this, especially if bpf_task_acquire is really only useful in
> > > sleepable programs where it works on the tracing args. A lot of other
> > > kfuncs need these fixes as well, so it's a general problem and not
> > > specific to this set. I am not very familiar with your exact use case.
> > > Hopefully when it is fixed this particular case won't really break, if
> > > you only use the tracepoint argument.
> >
> > I'm also interested in using this with struct_ops, not just tracing. I
> > think that struct_ops should be totally fine though, and easier to
> > reason about than tracing as we just have to make sure that a few
> > specific callbacks are always passed a valid, referenced task, rather
> > than e.g. worrying about fexit on __put_task_struct().
> >
> > I'm fine with adding this now and working towards closing the gaps
> > later, though I'd like to hear what Martin, Alexei, and the rest of the
> > BPF maintainers think. I think Martin asked if there was any preliminary
> > work you'd already done that we could try to tie into this patch set,
> > and I'm similarly curious.
> >
> 
> It's mostly a few experimental patches in my local tree, so nowhere
> close to completion. Ofcourse doing it properly will be a lot of work,
> but I will be happy to help with reviews if you want to focus on
> pointers loaded from ctx for now and make that part of this set, while
> not permitting any other cases. It should not be very difficult to add
> just that.

Sounds good, I'll include that in the v3 iteration of the patch set. We
can worry about black-listing certain unsafe tracing programs, and doing
whatever other fancier things we can think of as well later.

> So you can set KF_TRUSTED_ARGS for your kfunc, then make it work for
> PTR_TO_BTF_ID where it either has PTR_TRUSTED, ref_obj_id > 0, or
> both. Just that PTR_TRUSTED is lost for the destination reg as soon as
> btf_struct_access is used to walk pointers (unlike PTR_UNTRUSTED which
> is inherited). Note that you don't _set_ PTR_UNTRUSTED here for the
> dst_reg.

Makes sense, I think I know what needs to change and it should only be a
few small places in the verifier (plus the testing we'll add to validate
it).

> This should enable your immediate use case, while also being useful
> for future work that builds on it. It should also preserve backwards
> compatibility with existing stable helpers. You set PTR_TRUSTED when
> you access ctx of tracing or struct_ops etc. All this will be handled
> in is_valid_access callback/btf_ctx_access and setting the flag in
> bpf_insn_access_aux. Unless I missed some detail/corner case it won't
> be a lot of code.
> 
> If that turns out to be too restrictive/coarse for your use case, we
> can just go with this as is for now.

Alright, works for me. Let me mess around with this and see if it's as
easy as we think it is. If so, v3 will include those changes. If not,
it'll just include a couple of small fixes that Martin pointed out on
the v2 revision.

Thanks for reviewing these patches.

- David
