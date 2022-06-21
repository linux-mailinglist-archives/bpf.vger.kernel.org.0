Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AC553933
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351511AbiFURvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351651AbiFURv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 13:51:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E381DA73
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:51:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g186so13794408pgc.1
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUgOkPWmdTzqjCyoQyB0JKUSM/4JzNNajACBP/VIFNA=;
        b=l4CxnTICd7svVFJe5qjC/vDcZkoNa9Jc7uXvtg33EqKO6PdttAg433cGqQhOXV9Zwr
         N5cjoBMm6nEZSBjGHYfXz/PAnIF7o3aXu7wYOkRSOuooqhFZDClDTlBfAglPUCdLg6xx
         k1qy830GxvAo2inLBhYfxj1lND37DILxHQpgZeoJWPA7pkotyHk0uikjuv4bj/0UkRaw
         jJUvKbuBR2LpSbu4GnMoZwSx0tCypoXhy3IoipuKQLKPvwFRnMWTK/P+878wr5Yd+1NQ
         vJSoT9cQ5aU5KvB5RSzyJbSwAw9mhyBbp97eG5VoumHRoHKDERXo013yCabMW4hczrdP
         aC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUgOkPWmdTzqjCyoQyB0JKUSM/4JzNNajACBP/VIFNA=;
        b=FXPDSQbX2+dq5giHGUBKy8BZQ1qopTvnOYQcMLQ/C1NndOCOmNmtSmlCSwRAM1b90i
         H7ocMWK+pc8F4G3NAwdNI/ATQ6ztRGr+NBFJ03TSPMPP2oF4xbAF32EjISS+x/k38q/G
         qS2aV3PQA4XLjSnvqewsYsGkFtXxu1J7dUaaWcBXfnxyKuVxc4WErJqokWaYTxW8OVRM
         1y3btA9FEnog1/EjNrpKfrPkux7sPUx+0VCPhiwU3Rqi6GPfs+0iL8iXuryLwzl6DrQJ
         1ramikv9bTa2DTbUTpJ7k298GXO23PYqakLzQ4Ue1Gb7JvRcuZgFDCvVIUTDv7d7bi3O
         +SGQ==
X-Gm-Message-State: AJIora+bzqOOwdmer7i9jnf2KUDZsqLqsu4Rw9rt4HL8RyPj48jWLmBa
        NslqbC+B8rlVtlqPF+wXYojNrYgxg/AkEgQq66BKrA==
X-Google-Smtp-Source: AGRyM1u4D1pKTSa30SFd8SVXhqa46hLI6wlh0WnFiGhtdiRQqOo4ePLBEABwVJMO41wOQDjhlgHKc08bI4mu1N8yXmQ=
X-Received: by 2002:a63:1408:0:b0:408:ab3d:9310 with SMTP id
 u8-20020a631408000000b00408ab3d9310mr27448695pgl.253.1655833884207; Tue, 21
 Jun 2022 10:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220610165803.2860154-1-sdf@google.com> <20220610165803.2860154-7-sdf@google.com>
 <20220617054249.iedbzuakyzg67o75@kafai-mbp> <CAKH8qBsRKNNR+9zvn5G3DtruYqWJ0eF0TZp1ORM5VH2WKiBVng@mail.gmail.com>
 <20220617230756.tt6wth646ntqwph3@kafai-mbp>
In-Reply-To: <20220617230756.tt6wth646ntqwph3@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 21 Jun 2022 10:51:13 -0700
Message-ID: <CAKH8qBvkWFGqp+TCo4v+uXBOpTahVPX+kgY7QLJpcPqK5bnirw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 06/10] bpf: expose bpf_{g,s}etsockopt to lsm cgroup
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, Yonghong Song <yhs@fb.com>
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

On Fri, Jun 17, 2022 at 4:08 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jun 17, 2022 at 11:28:24AM -0700, Stanislav Fomichev wrote:
> > On Thu, Jun 16, 2022 at 10:42 PM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > > On Fri, Jun 10, 2022 at 09:57:59AM -0700, Stanislav Fomichev wrote:
> > > > I don't see how to make it nice without introducing btf id lists
> > > > for the hooks where these helpers are allowed. Some LSM hooks
> > > > work on the locked sockets, some are triggering early and
> > > > don't grab any locks, so have two lists for now:
> > > >
> > > > 1. LSM hooks which trigger under socket lock - minority of the hooks,
> > > >    but ideal case for us, we can expose existing BTF-based helpers
> > > > 2. LSM hooks which trigger without socket lock, but they trigger
> > > >    early in the socket creation path where it should be safe to
> > > >    do setsockopt without any locks
> > > > 3. The rest are prohibited. I'm thinking that this use-case might
> > > >    be a good gateway to sleeping lsm cgroup hooks in the future.
> > > >    We can either expose lock/unlock operations (and add tracking
> > > >    to the verifier) or have another set of bpf_setsockopt
> > > >    wrapper that grab the locks and might sleep.
> > > Another possibility is to acquire/release the sk lock in
> > > __bpf_prog_{enter,exit}_lsm_cgroup().  However, it will unnecessarily
> > > acquire it even the prog is not doing any get/setsockopt.
> > > It probably can make some checking to avoid the lock...etc. :/
> > >
> > > sleepable bpf-prog is a cleaner way out.  From a quick look,
> > > cgroup_storage is not safe for sleepable bpf-prog.
> >
> > Is it because it's using non-trace-flavor of rcu?
> Right, and commit 0fe4b381a59e ("bpf: Allow bpf_local_storage to be used by sleepable programs")
> is to make it work for both flavors.
>
> >
> > > All other BPF_MAP_TYPE_{SK,INODE,TASK}_STORAGE is already
> > > safe once their common infra in bpf_local_storage.c was made
> > > sleepable-safe.
> >
> > That might be another argument in favor of replacing the internal
> > implementation for cgroup_storage with the generic framework we use
> > for sk/inode/task.
> It could be a new map type to support sk/inode/task style of local storage.
>
> I am seeing use cases that the bpf prog is not a cgroup-bpf prog
> and it has a hold of the cgroup pointer.  It ends up creating a bpf hashmap with
> the cg_id as the key.  For example,
> https://lore.kernel.org/bpf/20220610194435.2268290-9-yosryahmed@google.com/
> It will be useful to support this use case for cgroup as sk/inode/task
> storage does.  A quick thought is it needs another map_type because
> of different helper interface, e.g. the bpf prog can create and
> delete a sk/inode/task storage.

Good point. We've also discussed that new map type internally with
Yosry. And for me the biggest issue with a new map was some major
differentiating factor from the existing one. Making it work with
non-cgroup progs might be it. Another, as you mention, is the ability
to remove the value. Having special treatment for
bpf_get_local_storage (in terms of always assuming non-null return
value) might be problematic for the internal conversion to the common
storage framework :-(

> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  include/linux/bpf.h  |  2 ++
> > > >  kernel/bpf/bpf_lsm.c | 40 +++++++++++++++++++++++++++++
> > > >  net/core/filter.c    | 60 ++++++++++++++++++++++++++++++++++++++------
> > > >  3 files changed, 95 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 503f28fa66d2..c0a269269882 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -2282,6 +2282,8 @@ extern const struct bpf_func_proto bpf_for_each_map_elem_proto;
> > > >  extern const struct bpf_func_proto bpf_btf_find_by_name_kind_proto;
> > > >  extern const struct bpf_func_proto bpf_sk_setsockopt_proto;
> > > >  extern const struct bpf_func_proto bpf_sk_getsockopt_proto;
> > > > +extern const struct bpf_func_proto bpf_unlocked_sk_setsockopt_proto;
> > > > +extern const struct bpf_func_proto bpf_unlocked_sk_getsockopt_proto;
> > > >  extern const struct bpf_func_proto bpf_kallsyms_lookup_name_proto;
> > > >  extern const struct bpf_func_proto bpf_find_vma_proto;
> > > >  extern const struct bpf_func_proto bpf_loop_proto;
> > > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > index 83aa431dd52e..52b6e3067986 100644
> > > > --- a/kernel/bpf/bpf_lsm.c
> > > > +++ b/kernel/bpf/bpf_lsm.c
> > > > @@ -45,6 +45,26 @@ BTF_ID(func, bpf_lsm_sk_alloc_security)
> > > >  BTF_ID(func, bpf_lsm_sk_free_security)
> > > >  BTF_SET_END(bpf_lsm_current_hooks)
> > > >
> > > > +/* List of LSM hooks that trigger while the socket is properly locked.
> > > > + */
> > > > +BTF_SET_START(bpf_lsm_locked_sockopt_hooks)
> > > > +BTF_ID(func, bpf_lsm_socket_sock_rcv_skb)
> > > > +BTF_ID(func, bpf_lsm_sk_clone_security)
> > > From looking how security_sk_clone() is used at sock_copy(),
> > > it has two sk args, one is listen sk and one is the clone.
> > > I think both of them are not locked.
> > >
> > > The bpf_lsm_inet_csk_clone below should be enough to
> > > do setsockopt in the new clone?
> >
> > Hm, good point, let me drop this one.
> >
> > I wonder if long term, instead of those lists, we can annotate the
> > arguments with __locked or __unlocked (the way we do with __user
> > pointers)? That might be more scalable and we can let sleepable bpf
> > deal with __unlocked cases. Just thinking out loud...
> I think the btf_tag may help here. Cc: Yonghong.

Exactly. I haven't looked closely, but that seems like the right thing
to leverage. Thx!
