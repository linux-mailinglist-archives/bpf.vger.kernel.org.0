Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EC54FCFF
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiFQS2l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiFQS2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 14:28:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D632EC0
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 11:28:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id go6so129238pjb.0
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 11:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPswYsxqtC1oZ0etiJP07gT7b1rpEa53QlAztj0chnw=;
        b=BmUqgFFPgSU9u0HBQ4RjYVJjsY3qlgDVDaSuNMRUOLnm84cKru8qSpcJgkrjcwWCbr
         GECEqGrPophEbKNbhxq2Nro4t82EgCWvFVxT8XWdet7ZAJf94YC8NbBuGcqtxZ9Ly+5+
         B2AC/NQ2ldBxQLufX+KBLbPAZj9YVT80SmoYk2Cz3g6TvXyXYUCNypkO0Ejk5yhH8gcf
         HlduthUAFbT+rgNwuifa3RjFtx4RWmzETsKi1D4biLsuEkdjGOm47YFBAvYvzI2msZul
         zfGAIaPMAB5xyNG5XiUlGASdWc07lGguhjVozawcIhchtutca60JAbau58R5/SRhX9sz
         IRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPswYsxqtC1oZ0etiJP07gT7b1rpEa53QlAztj0chnw=;
        b=skDKtjpRxNcwUhFlXv6mcZlyE5UMIvq7KULtNvhtbBKadMTY2jNy8QijIJytTvxAJh
         +zILrJ+BEefVDajD+0MuYIl+uRoDz6yP7fOJA+s6s30qbL/wPCWfDCLrBB4GFuiCe2GS
         PEvmDeGpXvV7ic5R7QJpGE3wsrbcbiwsbg3wn5AsDDhB0rsXhQhSl3NlvWKvzapRuezu
         AoG9/Q/FCfPUNE2KW6FN00OGMpUn9aXwR3GDHN2a3MqWX3b0wqvqrWX/KUpjFwPF3Fal
         iJ/5dKA0vRySN89NK5MKwr9BtJxtT//VAf3aiF1AQhI0HOMBrmeuby12ReekylIvmgqK
         2atA==
X-Gm-Message-State: AJIora/DgNL6WbaslsUf/b2kuIDEhi7e0zCkHJxBLdi+L3sdeBQ0m12+
        UsbW84fmUYPK0KXXR1I7fH+nc/JigWjgqQyASXdCcQ==
X-Google-Smtp-Source: AGRyM1uCRt48L5gWUiHbeLcPZWpDdEFxZh+bfMDcLVGDD2SZfJZ+ZS01NdwLtO3xo/4EO34Jb0AGFNEQgH4wkNcLNU0=
X-Received: by 2002:a17:90b:380b:b0:1e6:67f6:f70c with SMTP id
 mq11-20020a17090b380b00b001e667f6f70cmr22650014pjb.120.1655490515286; Fri, 17
 Jun 2022 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220610165803.2860154-1-sdf@google.com> <20220610165803.2860154-7-sdf@google.com>
 <20220617054249.iedbzuakyzg67o75@kafai-mbp>
In-Reply-To: <20220617054249.iedbzuakyzg67o75@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 17 Jun 2022 11:28:24 -0700
Message-ID: <CAKH8qBsRKNNR+9zvn5G3DtruYqWJ0eF0TZp1ORM5VH2WKiBVng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 06/10] bpf: expose bpf_{g,s}etsockopt to lsm cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 10:42 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jun 10, 2022 at 09:57:59AM -0700, Stanislav Fomichev wrote:
> > I don't see how to make it nice without introducing btf id lists
> > for the hooks where these helpers are allowed. Some LSM hooks
> > work on the locked sockets, some are triggering early and
> > don't grab any locks, so have two lists for now:
> >
> > 1. LSM hooks which trigger under socket lock - minority of the hooks,
> >    but ideal case for us, we can expose existing BTF-based helpers
> > 2. LSM hooks which trigger without socket lock, but they trigger
> >    early in the socket creation path where it should be safe to
> >    do setsockopt without any locks
> > 3. The rest are prohibited. I'm thinking that this use-case might
> >    be a good gateway to sleeping lsm cgroup hooks in the future.
> >    We can either expose lock/unlock operations (and add tracking
> >    to the verifier) or have another set of bpf_setsockopt
> >    wrapper that grab the locks and might sleep.
> Another possibility is to acquire/release the sk lock in
> __bpf_prog_{enter,exit}_lsm_cgroup().  However, it will unnecessarily
> acquire it even the prog is not doing any get/setsockopt.
> It probably can make some checking to avoid the lock...etc. :/
>
> sleepable bpf-prog is a cleaner way out.  From a quick look,
> cgroup_storage is not safe for sleepable bpf-prog.

Is it because it's using non-trace-flavor of rcu?

> All other BPF_MAP_TYPE_{SK,INODE,TASK}_STORAGE is already
> safe once their common infra in bpf_local_storage.c was made
> sleepable-safe.

That might be another argument in favor of replacing the internal
implementation for cgroup_storage with the generic framework we use
for sk/inode/task.

> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/bpf.h  |  2 ++
> >  kernel/bpf/bpf_lsm.c | 40 +++++++++++++++++++++++++++++
> >  net/core/filter.c    | 60 ++++++++++++++++++++++++++++++++++++++------
> >  3 files changed, 95 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 503f28fa66d2..c0a269269882 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2282,6 +2282,8 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> >  extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
> >  extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
> >  extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> > +extern const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto;
> > +extern const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto;
> >  extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
> >  extern const struct bpf_func_proto bpf_find_vma_proto;
> >  extern const struct bpf_func_proto bpf_loop_proto;
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 83aa431dd52e..52b6e3067986 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -45,6 +45,26 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
> >  BTF_ID(func, bpf_lsm_sk_free_security)
> >  BTF_SET_END(bpf_lsm_current_hooks)
> >
> > +/* List of LSM hooks that trigger while the socket is properly locked.
> > + */
> > +BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
> > +BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
> > +BTF_ID(func, bpf_lsm_sk_clone_security)
> From looking how security_sk_clone() is used at sock_copy(),
> it has two sk args, one is listen sk and one is the clone.
> I think both of them are not locked.
>
> The bpf_lsm_inet_csk_clone below should be enough to
> do setsockopt in the new clone?

Hm, good point, let me drop this one.

I wonder if long term, instead of those lists, we can annotate the
arguments with __locked or __unlocked (the way we do with __user
pointers)? That might be more scalable and we can let sleepable bpf
deal with __unlocked cases. Just thinking out loud...

> > +BTF_ID(func, bpf_lsm_sock_graft)
> > +BTF_ID(func, bpf_lsm_inet_csk_clone)
> > +BTF_ID(func, bpf_lsm_inet_conn_established)
> > +BTF_ID(func, bpf_lsm_sctp_bind_connect)
> I didn't look at this one, so I can't comment.
> Do you have a use case?

No, let's drop as well. I didn't want those lists to contain only the
cases I want, otherwise it doesn't feel generic. But sctp seems dead
anyway.


> > +BTF_SET_END(bpf_lsm_locked_sockopt_hooks)
> > +
> > +/* List of LSM hooks that trigger while the socket is _not_ locked,
> > + * but it's ok to call bpf_{g,s}etsockopt because the socket is still
> > + * in the early init phase.
> > + */
> > +BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
> > +BTF_ID(func, bpf_lsm_socket_post_create)
> > +BTF_ID(func, bpf_lsm_socket_socketpair)
> > +BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
> > +
