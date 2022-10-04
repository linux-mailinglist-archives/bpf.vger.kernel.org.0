Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247DA5F4636
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJDPKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJDPKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 11:10:46 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BB85C9CB;
        Tue,  4 Oct 2022 08:10:43 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id h28so8532211qka.0;
        Tue, 04 Oct 2022 08:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/YXrO25N+KhFCPbrFfILZlZqkK3nd29wf52is5QkoJM=;
        b=GbrqPmkqbP3UlAJsSYPsdkwpaHw/JPZ4z1frexjxyjY2o2pYbKAGNJ9lFN4D/D5U9f
         u3S4z+29fxpjVsvSfnVEXKAPcE+0gztdsiWEmsqbyJWpOj76tT6GB87xiiGxpPrIjWki
         z8Cd/aiMLXVKok6EzQTc5NYfPs80GvsswWq/+QlRpN+F+wLoik3l2V7angEPG4YhLaxn
         QBR8Me36RznKFB8hKKlsFCOo/oXkgod+Mj5Ny6Ocgl6LUmENICFpADPmp8hArni0aqHJ
         q/AQIxjlJ/ON9axlNY7W1qgLX/AkS7VmQGGTrkjzOzpcgFYw5NSEMCUQ+xS7gXdKWhWn
         i9Zg==
X-Gm-Message-State: ACrzQf0fVnbu2M3dyW7T2YjcT1xEhzDxmmu/bEF1NljrIsWjRXAo5Gqk
        g8Bsm+R/d8hGjC06nOFecGw8ZvOlcqKNzw==
X-Google-Smtp-Source: AMsMyM5ztO0GdMMh/VHvE5iiTrscw2GFsb76B+TbIYFFNTDtdJ/qcF/r9c8fR8PSO2efW4MhE/NvXA==
X-Received: by 2002:a05:620a:4709:b0:6ce:d97a:fc9a with SMTP id bs9-20020a05620a470900b006ced97afc9amr16922903qkb.340.1664896241736;
        Tue, 04 Oct 2022 08:10:41 -0700 (PDT)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id j16-20020a05620a289000b006b615cd8c13sm14674835qkp.106.2022.10.04.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:10:41 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:10:48 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yhs@fb.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2 2/2] bpf/selftests: Add selftests for new task kfuncs
Message-ID: <YzxM+HSSqIDCPCUf@maniforge.lan>
References: <20221001144716.3403120-1-void@manifault.com>
 <20221001144716.3403120-3-void@manifault.com>
 <CAP01T74TtMARkfYWsYY0+cnsx2w4axB1LtvF-RFMAihW7v=LUw@mail.gmail.com>
 <YzsBSoGnPEIJADSH@maniforge.dhcp.thefacebook.com>
 <CAP01T76OR3J_P8YMq4ZgKHBpuZyA0zgsPy+tq9htbX=j6AVyOg@mail.gmail.com>
 <fb3e81b7-8360-5132-59ac-0e74483eb25f@linux.dev>
 <CAP01T77tCdKTJo=sByg5GsW1OrQmNXV4fmBDKUVtbnwEaJBpVA@mail.gmail.com>
 <YztbOo7TgOoN1bVB@maniforge.dhcp.thefacebook.com>
 <CAP01T76rCLdExKZ0AdP9L6e_g+sj9D7Ec59rr+ddMJ-KU+h8QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T76rCLdExKZ0AdP9L6e_g+sj9D7Ec59rr+ddMJ-KU+h8QQ@mail.gmail.com>
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

On Tue, Oct 04, 2022 at 12:22:08AM +0200, Kumar Kartikeya Dwivedi wrote:
> > Thanks for providing additional context, Kumar. So what do we want to do
> > for this patch set? IMO it doesn't seem useful to restrict
> > bpf_kfunc_acquire() to only be callable by non-sleepable programs if our
> > goal is to avoid crashes for nested task structs. We could easily
> > accidentally crash if e.g. those pointers are NULL, or someone is doing
> > something weird like stashing some extra flag bits in unused portions of
> > the pointer which are masked out when it's actually dereferenced
> > regardless of whether we're in RCU.  Trusting ctx loads sounds like the
> > right approach, barring some of the challenges you pointed out such as
> > dealing with fexit paths after free where the object may not be valid
> > anymore.
> >
> > In general, it seems like we should maybe decide on what our policy
> > should be for kfuncs until we can wire up whatever we need to properly
> > trust ctx.
> 
> Well, we could add it now and work towards closing the gaps after
> this, especially if bpf_task_acquire is really only useful in
> sleepable programs where it works on the tracing args. A lot of other
> kfuncs need these fixes as well, so it's a general problem and not
> specific to this set. I am not very familiar with your exact use case.
> Hopefully when it is fixed this particular case won't really break, if
> you only use the tracepoint argument.

I'm also interested in using this with struct_ops, not just tracing. I
think that struct_ops should be totally fine though, and easier to
reason about than tracing as we just have to make sure that a few
specific callbacks are always passed a valid, referenced task, rather
than e.g. worrying about fexit on __put_task_struct().

I'm fine with adding this now and working towards closing the gaps
later, though I'd like to hear what Martin, Alexei, and the rest of the
BPF maintainers think. I think Martin asked if there was any preliminary
work you'd already done that we could try to tie into this patch set,
and I'm similarly curious.

> It is true that waiting for all the fixes will unnecessarily stall
> this, it is not clear how each of the issues will be addressed either.
> 
> Later its use can be made conditional in sleepable programs for
> trusted and rcu tagged pointers under appropriate RCU read lock. I
> will try to prioritize sending it out so that we resolve this soon.

Much appreciated!
