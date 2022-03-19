Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1937D4E18F3
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 00:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiCSXCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiCSXCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 19:02:31 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A11A9CBD
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 16:01:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w21so3994045pgm.7
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GJF5nPiDHvPuQlndnJ/7pGO3mHMaaot5JT0fPLseLXU=;
        b=A9Ib8IPWItb0bXH13yBB3G8JQEJ1QPQCwQuJZuf21/LXGfNK9KnNbaC45LGbea/UZA
         FXl1eVoy5kmtOgiI36gqfG0dpw2xmBgACSr4T/oh78wr2Tskll2Po7wNNvOdVCsz7UYy
         7jAmYRmDRlNbRDgXCGaZyMZXPQcpnQ3glBqzqBmbOFowowtW9W16L1iTL2sNgs5fmmGZ
         JNQHMNpSkAQJ4LHBKNayfGh2WxCgeWi0nbbJNevD5igxKCfyNA0Wq9QJ/cGKTbFnBBzZ
         yL7i3rUNaAHIeFcXKphuQr3br8TmjDzv4Q3PMRSjfh27FCzw/mBlvBjDTkhjeOMTDLRA
         IVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJF5nPiDHvPuQlndnJ/7pGO3mHMaaot5JT0fPLseLXU=;
        b=MBVnPJ95OmWHYNbU3GRHzJqafCxPrlKiWBu+ApZdSc0NB5RPuEQQjcFqxfnTKWZosu
         AdxoR1Sp8m3SzJrLbE0lHx59QIgq19STwd4Z2l134hmO1WfibZ4MG60ysbX2SWbXJuST
         dTm8bLqW+a993HLlKd0X7VvyIiaoP4oNkabv49wYYe6Ru6sJTUDIJlozHpws1bpQy65+
         wFSFdZyonUnVoqjOBYXfRyXg0oXx0qRgtPED28+J+jnQrkS9Gg5G3cfsy6v4bfqqbyfK
         BMxtnk7mizLkKHjdDQhJZVZRA8HyJ2GR9sq6C2kX7+rfLXbDyWJNeFzxMrh/hJgHUD+K
         NrZg==
X-Gm-Message-State: AOAM5307/dG0T6ODnW51WXWDGza6/ixdWwPyGeRUr9s+w0dGklrwZPMn
        UQgB6BFeGO+EM6h3rVLbxNE=
X-Google-Smtp-Source: ABdhPJyfh5K1ju6jn9QAWpkufjMqSCxJ07JcBDuNC+nwgEC0pQBuyGFUIbVNT+3rKECFzGfYVfynTg==
X-Received: by 2002:a63:2316:0:b0:381:ac6:94a5 with SMTP id j22-20020a632316000000b003810ac694a5mr12860838pgj.501.1647730868474;
        Sat, 19 Mar 2022 16:01:08 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:be42])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm6160444pfe.49.2022.03.19.16.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 16:01:08 -0700 (PDT)
Date:   Sat, 19 Mar 2022 16:01:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Message-ID: <20220319230105.ueamwe4uc2pmndp4@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-6-memxor@gmail.com>
 <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
 <20220319190409.7n3bkjdp67finojx@apollo>
 <20220319212620.vbzfxsn2xitkzv5t@ast-mbp.dhcp.thefacebook.com>
 <20220319214505.yn5a24jrfwdhzpfv@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319214505.yn5a24jrfwdhzpfv@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 03:15:05AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sun, Mar 20, 2022 at 02:56:20AM IST, Alexei Starovoitov wrote:
> > On Sun, Mar 20, 2022 at 12:34:09AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Sun, Mar 20, 2022 at 12:00:28AM IST, Alexei Starovoitov wrote:
> > > > On Thu, Mar 17, 2022 at 05:29:47PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
> > > > > map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
> > > > > of pointers accepting stores of such register types. On load, verifier
> > > > > marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
> > > > > PTR_MAYBE_NULL.
> > > > >
> > > > > Cc: Hao Luo <haoluo@google.com>
> > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > ---
> > > > >  include/linux/bpf.h   |  3 ++-
> > > > >  kernel/bpf/btf.c      | 13 ++++++++++---
> > > > >  kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
> > > > >  3 files changed, 33 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > index 702aa882e4a3..433f5cb161cf 100644
> > > > > --- a/include/linux/bpf.h
> > > > > +++ b/include/linux/bpf.h
> > > > > @@ -161,7 +161,8 @@ enum {
> > > > >  };
> > > > >
> > > > >  enum {
> > > > > -	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> > > > > +	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> > > > > +	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
> > > >
> > > > What is the use case for storing __percpu pointer into a map?
> > >
> > > No specific use case for me, just thought it would be useful, especially now
> > > that __percpu tag is understood by verifier for kernel BTF, so it may also refer
> > > to dynamically allocated per-CPU memory, not just global percpu variables. But
> > > fine with dropping both this and user kptr if you don't feel like keeping them.
> >
> > I prefer to drop it for now.
> > The patch is trivial but kptr_percpu tag would stay forever.
> 
> Ok, I'll drop both this and user kptr for now.
> 
> > Maybe we can allow storing percpu pointers in a map with just kptr tag.
> > The verifier should be able to understand from btf whether that pointer
> > is percpu or not.
> 
> This won't work (unless I missed something), it is possible to see the type when
> a store is being done, but we cannot know whether the pointer was percpu or not
> when doing a load (which is needed to decide whether it will be marked with
> MEM_PERCPU, so that user has to call bpf_this_cpu_ptr or bpf_per_cpu_ptr to
> obtain actual pointer). So some extra tagging is needed.

The pointer in bpf program should probably be marked as normal __percpu then.
So that types match during both store and load.
It will be a combination of btf_tags __kptr and __percpu.
Anyway let's table this discussion until main feature lands.
