Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C12F4DEAFC
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 22:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiCSVqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 17:46:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5316F06C
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:45:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so11333481pjp.3
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMfjqaHJH0YZhpqH/hF3yGU6z7ZfQo+N+O7D8kwxeq0=;
        b=NirrHSKetB0k3LXrqTf0xBNqmTOssHdr1dXiEFGMoKhH6n6E8d81rcOfJQ4xaSdJcK
         8fJYTlDNFJED/Z25nosf8ljGafdUbdJB8WNIeRfIYv+YYE20ht+8s1A32nFjfFTWpkNu
         NqEPK7WZ/RluXXO8aQbP/ln3Oph1u4PdyWValMmrUDAuKhJivX7BdJCYZ0B2IBZ09n69
         jCEa11gjjqnLDdMc8nC3vw3uf4InRSDpk6wGRSl75/z5hZvAu2zIcwsYBAIG2MOBUWMi
         TpxGBx46eX5HmAEevlse4XvRur6QtDg30bpWvYjfV/Ae2Sc4UTxM6C3oBpnKQ9riImzT
         rsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMfjqaHJH0YZhpqH/hF3yGU6z7ZfQo+N+O7D8kwxeq0=;
        b=QkLJ1mTg/PlY/AiEwKmw+Ot6jpMkYi+plKRdHtj1PSH7LmnR4/9VomViD9j5i4o7Lr
         s2RXzYYQjo8OL9wLh/RYVIa0Q188B9RPm7H41YNCVrFRMHIzbQl2bdMX+ovQJTAz2IxF
         04v04O2AgPG0WZTHf6o0dFu5ppSgqieYKsWVLnB+tJlMFlU0FcXk6PPXmQNMbjkTJEpl
         kbdoud2UIWQ9e9XmvfcIN8RYpRyxzBcTo+jjz7p2GGRw+6uyoy9DBZg8BT7HnUq/iewY
         d/5zgnjdbFNdGdvGiBY4qsIZt/TyAFjDz73CdJ/WIAKx8P+mIIlvnHD93S2L1uY4TKzW
         CKAQ==
X-Gm-Message-State: AOAM533O802zEjRmfrJcI6lLRN5OlEmg/eeVHCU6gC4G47+rgvrL6KYf
        cADeABxPNzjrfcVgwLBCBHKxflAtWyI=
X-Google-Smtp-Source: ABdhPJzcdnHIFG9bnJWecjQdwNykwHdQgXMukRLsJtuExH3+jtRsXl5dk3WfIYnD6zposdh+4Yy7aA==
X-Received: by 2002:a17:902:e551:b0:154:48d5:4210 with SMTP id n17-20020a170902e55100b0015448d54210mr595209plf.2.1647726308916;
        Sat, 19 Mar 2022 14:45:08 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm12270441pjb.50.2022.03.19.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 14:45:07 -0700 (PDT)
Date:   Sun, 20 Mar 2022 03:15:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Message-ID: <20220319214505.yn5a24jrfwdhzpfv@apollo>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-6-memxor@gmail.com>
 <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
 <20220319190409.7n3bkjdp67finojx@apollo>
 <20220319212620.vbzfxsn2xitkzv5t@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319212620.vbzfxsn2xitkzv5t@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 02:56:20AM IST, Alexei Starovoitov wrote:
> On Sun, Mar 20, 2022 at 12:34:09AM +0530, Kumar Kartikeya Dwivedi wrote:
> > On Sun, Mar 20, 2022 at 12:00:28AM IST, Alexei Starovoitov wrote:
> > > On Thu, Mar 17, 2022 at 05:29:47PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
> > > > map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
> > > > of pointers accepting stores of such register types. On load, verifier
> > > > marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
> > > > PTR_MAYBE_NULL.
> > > >
> > > > Cc: Hao Luo <haoluo@google.com>
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > > >  include/linux/bpf.h   |  3 ++-
> > > >  kernel/bpf/btf.c      | 13 ++++++++++---
> > > >  kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
> > > >  3 files changed, 33 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 702aa882e4a3..433f5cb161cf 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -161,7 +161,8 @@ enum {
> > > >  };
> > > >
> > > >  enum {
> > > > -	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> > > > +	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> > > > +	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
> > >
> > > What is the use case for storing __percpu pointer into a map?
> >
> > No specific use case for me, just thought it would be useful, especially now
> > that __percpu tag is understood by verifier for kernel BTF, so it may also refer
> > to dynamically allocated per-CPU memory, not just global percpu variables. But
> > fine with dropping both this and user kptr if you don't feel like keeping them.
>
> I prefer to drop it for now.
> The patch is trivial but kptr_percpu tag would stay forever.

Ok, I'll drop both this and user kptr for now.

> Maybe we can allow storing percpu pointers in a map with just kptr tag.
> The verifier should be able to understand from btf whether that pointer
> is percpu or not.

This won't work (unless I missed something), it is possible to see the type when
a store is being done, but we cannot know whether the pointer was percpu or not
when doing a load (which is needed to decide whether it will be marked with
MEM_PERCPU, so that user has to call bpf_this_cpu_ptr or bpf_per_cpu_ptr to
obtain actual pointer). So some extra tagging is needed.

--
Kartikeya
