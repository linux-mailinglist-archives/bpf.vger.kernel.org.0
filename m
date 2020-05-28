Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2FA1E6912
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391422AbgE1SJf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391412AbgE1SJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:09:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5699CC08C5C6;
        Thu, 28 May 2020 11:09:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a23so851365qto.1;
        Thu, 28 May 2020 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsD0J/iw0XgIt25s9OCTu4MwVzcqUiCd19+h1nF8Nbo=;
        b=oSakEXtm6BY9nRpS/NJGviwHgXPVQ7OomgpXByTdJX1ylWgu4+GdYHMRe6rewaxCkN
         aiDUJDvbhlUku8bry0fbviS60KFvsE046gwfgWRET/2fqzy+oaE29fiC0B/kOncTQklB
         QFdaIvogNSBUSOeBVWObd+ccJ2S0ab1y6WjZ8jVTsJ9mVsrXrbNSDVEqaDA4KkMc5faP
         NG0MoY3o57fRAoF9VTEJ0qdnUHNw2760Zth1STzs7AAtICF1+krAMTJjtRRi/K0Hm8Q1
         tnC/GvdATu9t06Srr1FoZ8eo+bvErM/KcducJX8QQoMI0Rs6gL9majuYTDOpXwlYihoV
         UZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsD0J/iw0XgIt25s9OCTu4MwVzcqUiCd19+h1nF8Nbo=;
        b=tRcBaOq1YgraTg5WvV7WK/f0gEpckC/g0UtK8WFKUw9HsB3pD0Y5qRfqcy9HOhF6jH
         3GQ9ywygmsX6UShellr+Ldxryb9iLhyyKiSmaufzv6sxE60z2aICeNGlfmrDucYxWym2
         pGX50D0zxiQmOtI5id9YLB7qWpIsUsoUloiwDgR9UPs28CIGQZ8qsG/wKV3TTqG+ZeHU
         HKMuIjBFHhqtD10l74pfhFQu+lOhTex9Njgkmuvwh8fMHgLQ3eU7dkXSygdslbqCySZj
         sY//A27pAmZFgWXRrUo1Ba+Q43o/wBxSiJVp3lqd29hc5NWMNgcMqOhyV//kXmMEK7IH
         HiAw==
X-Gm-Message-State: AOAM533aGJGWDzZxQ5sVceZI0Sc1hkbTz9rE8JbR0t+9NFmzdTPczduf
        M1MjEJ3m82OkHAlvpt8RrtP5xsa7YohnJD1wDSAdvL0W
X-Google-Smtp-Source: ABdhPJz3X0R3VCUk0anyr7QzF4X7MZfPUkeoV4+ViOUKtuGK8sgeFpAcerkN7Ls/9/U5Xv04WuqtEZtPMNEmqwAOvRI=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr4313604qta.141.1590689372229;
 Thu, 28 May 2020 11:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com>
 <20200527170840.1768178-6-jakub@cloudflare.com> <CAEf4BzZQQk8A9nUx2CrVXQqFcetr3PXnAtEm8JE05czHJvA5og@mail.gmail.com>
 <87pnao2qkd.fsf@cloudflare.com>
In-Reply-To: <87pnao2qkd.fsf@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 May 2020 11:09:20 -0700
Message-ID: <CAEf4Bzb8yy+ntiy2HJqdN2M58dWMNf1Y9_vD1cr3Tze0rZUbWQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add link-based BPF program attachment
 to network namespace
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 5:26 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Thu, May 28, 2020 at 07:56 AM CEST, Andrii Nakryiko wrote:
> > On Wed, May 27, 2020 at 12:16 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >>
> >> Add support for bpf() syscall subcommands that operate on
> >> bpf_link (LINK_CREATE, LINK_UPDATE, OBJ_GET_INFO) for attach points tied to
> >> network namespaces (that is flow dissector at the moment).
> >>
> >> Link-based and prog-based attachment can be used interchangeably, but only
> >> one can be in use at a time. Attempts to attach a link when a prog is
> >> already attached directly, and the other way around, will be met with
> >> -EBUSY.
> >>
> >> Attachment of multiple links of same attach type to one netns is not
> >> supported, with the intention to lift it when a use-case presents
> >> itself. Because of that attempts to create a netns link, when one already
> >> exists result in -E2BIG error, signifying that there is no space left for
> >> another attachment.
> >>
> >> Link-based attachments to netns don't keep a netns alive by holding a ref
> >> to it. Instead links get auto-detached from netns when the latter is being
> >> destroyed by a pernet pre_exit callback.
> >>
> >> When auto-detached, link lives in defunct state as long there are open FDs
> >> for it. -ENOLINK is returned if a user tries to update a defunct link.
> >>
> >> Because bpf_link to netns doesn't hold a ref to struct net, special care is
> >> taken when releasing the link. The netns might be getting torn down when
> >> the release function tries to access it to detach the link.
> >>
> >> To ensure the struct net object is alive when release function accesses it
> >> we rely on the fact that cleanup_net(), struct net destructor, calls
> >> synchronize_rcu() after invoking pre_exit callbacks. If auto-detach from
> >> pre_exit happens first, link release will not attempt to access struct net.
> >>
> >> Same applies the other way around, network namespace doesn't keep an
> >> attached link alive because by not holding a ref to it. Instead bpf_links
> >> to netns are RCU-freed, so that pernet pre_exit callback can safely access
> >> and auto-detach the link when racing with link release/free.
> >>
> >> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> >> ---
> >>  include/linux/bpf-netns.h      |   8 +
> >>  include/net/netns/bpf.h        |   1 +
> >>  include/uapi/linux/bpf.h       |   5 +
> >>  kernel/bpf/net_namespace.c     | 257 ++++++++++++++++++++++++++++++++-
> >>  kernel/bpf/syscall.c           |   3 +
> >>  net/core/filter.c              |   1 +
> >>  tools/include/uapi/linux/bpf.h |   5 +
> >>  7 files changed, 278 insertions(+), 2 deletions(-)
> >>
> >
> > [...]
> >
> >>  struct netns_bpf {
> >>         struct bpf_prog __rcu *progs[MAX_NETNS_BPF_ATTACH_TYPE];
> >> +       struct bpf_link __rcu *links[MAX_NETNS_BPF_ATTACH_TYPE];
> >>  };
> >>
> >
> > [...]
> >
> >>
> >> -/* Protects updates to netns_bpf */
> >> +struct bpf_netns_link {
> >> +       struct bpf_link link;
> >> +       enum bpf_attach_type type;
> >> +       enum netns_bpf_attach_type netns_type;
> >> +
> >> +       /* struct net is not RCU-freed but we treat it as such because
> >> +        * our pre_exit callback will NULL this pointer before
> >> +        * cleanup_net() calls synchronize_rcu().
> >> +        */
> >> +       struct net __rcu *net;
> >
> > It feels to me (see comments below), that if you use mutex
> > consistently, then this shouldn't be __rcu and you won't even need
> > rcu_read_lock() when working with this pointer, because auto_detach
> > and everything else won't be racing: if you got mutex in release() and
> > you see non-null net pointer, auto-detach either didn't happen yet, or
> > is happening at the same time, but is blocked on mutex. If you got
> > mutex and see net == NULL, ok, auto-detach succeeded before release,
> > so ignore net clean-up. Easy, no?
>
> Yes, right. Grabbing the mutex in auto_detach changes everything.
>
> I think I went about it the wrong way by trying to avoid a mutex there.
> I'll go with you advice and see if I can get rid of RCU pointers in v2.
>
> >
> >> +
> >> +       /* bpf_netns_link is RCU-freed for pre_exit callback invoked
> >> +        * by cleanup_net() to safely access the link.
> >> +        */
> >> +       struct rcu_head rcu;
> >> +};
> >> +
> >> +/* Protects updates to netns_bpf. */
> >>  DEFINE_MUTEX(netns_bpf_mutex);
> >>
> >> +static inline struct bpf_netns_link *to_bpf_netns_link(struct bpf_link *link)
> >> +{
> >> +       return container_of(link, struct bpf_netns_link, link);
> >> +}
> >> +
> >> +/* Called with RCU read lock. */
> >> +static void __net_exit
> >> +bpf_netns_link_auto_detach(struct net *net, enum netns_bpf_attach_type type)
> >> +{
> >> +       struct bpf_netns_link *net_link;
> >> +       struct bpf_link *link;
> >> +
> >> +       link = rcu_dereference(net->bpf.links[type]);
> >> +       if (!link)
> >> +               return;
> >> +       net_link = to_bpf_netns_link(link);
> >> +       RCU_INIT_POINTER(net_link->net, NULL);
> >
> > Given link attach and release is done under netns_bpf_mutex, shouldn't
> > this be done under the same mutex? You are modifying link concurrently
> > with update, but you are not synchronizing that access.
>
> After attaching the link to netns, there are no other updaters to
> net_link->net field. Link update has to modify link->prog, and update
> net->bpf.progs, but doesn't need to write to net_link->net, just read
> it.
>
> That's why I don't grab the netns_bpf_mutex on auto_detach.
>
> >
> >> +}
> >> +
> >> +static void bpf_netns_link_release(struct bpf_link *link)
> >> +{
> >> +       struct bpf_netns_link *net_link = to_bpf_netns_link(link);
> >> +       enum netns_bpf_attach_type type = net_link->netns_type;
> >> +       struct net *net;
> >> +
> >> +       /* Link auto-detached by dying netns. */
> >> +       if (!rcu_access_pointer(net_link->net))
> >> +               return;
> >> +
> >> +       mutex_lock(&netns_bpf_mutex);
> >> +
> >> +       /* Recheck after potential sleep. We can race with cleanup_net
> >> +        * here, but if we see a non-NULL struct net pointer pre_exit
> >> +        * and following synchronize_rcu() has not happened yet, and
> >> +        * we have until the end of grace period to access net.
> >> +        */
> >> +       rcu_read_lock();
> >> +       net = rcu_dereference(net_link->net);
> >> +       if (net) {
> >> +               RCU_INIT_POINTER(net->bpf.links[type], NULL);
> >> +               RCU_INIT_POINTER(net->bpf.progs[type], NULL);
> >
> > bpf.progs[type] is supposed to be NULL already, why setting it again here?
> >
> >> +       }
> >> +       rcu_read_unlock();
> >> +
> >> +       mutex_unlock(&netns_bpf_mutex);
> >> +}
> >> +
> >> +static void bpf_netns_link_dealloc(struct bpf_link *link)
> >> +{
> >> +       struct bpf_netns_link *net_link = to_bpf_netns_link(link);
> >> +
> >> +       /* Delay kfree in case we're racing with cleanup_net. */
> >> +       kfree_rcu(net_link, rcu);
> >
> > It feels to me like this RCU stuff for links is a bit overcomplicated.
> > If I understand your changes correctly (and please correct me if I'm
> > wrong), netns_bpf's progs are sort of like "effective progs" for
> > cgroup. Regardless if attachment was bpf_link-based or straight
> > bpf_prog-based, prog will always be set. link[type] would be set
> > additionally only if bpf_link-based attachment was done. And that
> > makes sense to make dissector hot path faster and simpler.
>
> Correct. netns link is heavily modelled after cgroup
> link. net->bpf.progs is like "effecttive progs". In fact, the next step
> would be to turn it into bpf_prog_array.
>
> > But if that's the case, link itself is always (except for auto-detach,
> > which I think should be fixed) accessed under mutex and doesn't
> > need/rely on rcu_read_lock() at all. So __rcu annotation for links is
> > not necessary, all the rcu dereferences for links are unnecessary, and
> > this kfree_rcu() is unnecessary. If that's not the case, please help
> > me understand why not.
>
> __rcu annotation for net->bpf.links is for auto_detach to access links
> with grace period guarantee, in its current form. If we can get around
> that, then I'm with you on that net->bpf.links doesn't need to an RCU
> protected pointer.
>
> I think you're right that grabbing netns_bpf_mutex in auto_detach will
> guarantee that bpf_link stays alive while we access it from there. We
> either see a non-NULL net->bpf.links[type] and know that release can't
> run before we finish working on it.
>
> Or we see a NULL net->bpf.links[type] and there is nothing to do.
> Thanks makes __rcu annotation and kfree_rcu not needed any more.
>
> Thanks, that is a great suggestion.
>
> >
> >> +}
> >> +
> >> +static int bpf_netns_link_update_prog(struct bpf_link *link,
> >> +                                     struct bpf_prog *new_prog,
> >> +                                     struct bpf_prog *old_prog)
> >> +{
> >> +       struct bpf_netns_link *net_link = to_bpf_netns_link(link);
> >> +       struct net *net;
> >> +       int ret = 0;
> >> +
> >> +       if (old_prog && old_prog != link->prog)
> >> +               return -EPERM;
> >> +       if (new_prog->type != link->prog->type)
> >> +               return -EINVAL;
> >> +
> >> +       mutex_lock(&netns_bpf_mutex);
> >> +       rcu_read_lock();
> >> +
> >> +       net = rcu_dereference(net_link->net);
> >> +       if (!net || !check_net(net)) {
> >> +               /* Link auto-detached or netns dying */
> >> +               ret = -ENOLINK;
> >
> > This is an interesting error code. If we are going to adopt this, we
> > should change it for similar cgroup link situation as well.
>
> Credit goes to Lorenz for suggesting a different error code than EINVAL
> for this situation so that user-space has a way to distinguish.
>
> I'm happy to patch cgroup BPF link, if you support this change.

Yeah, I guess let's do that. I like "link was severed" message for
that errno :) But for me it's way more about consistency, than any
specific error code.

>
> >
> >> +               goto out_unlock;
> >> +       }
> >> +
> >> +       old_prog = xchg(&link->prog, new_prog);
> >> +       bpf_prog_put(old_prog);
> >> +
> >> +out_unlock:
> >> +       rcu_read_unlock();
> >> +       mutex_unlock(&netns_bpf_mutex);
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int bpf_netns_link_fill_info(const struct bpf_link *link,
> >> +                                   struct bpf_link_info *info)
> >> +{
> >> +       const struct bpf_netns_link *net_link;
> >> +       unsigned int inum;
> >> +       struct net *net;
> >> +
> >> +       net_link = container_of(link, struct bpf_netns_link, link);
> >
> > you use to_bpf_netns_link() in few places above, but straight
> > container_of() here. Let's do this consistently (I'd rather stick to
> > straight container_of, but that's minor).
>
> Ah, yes. That's because bpf_link has const attribute here.  I think I
> can turn to_bpf_netns_link() into a macro to get around that.

maybe just stick to container_of()? multi-layer macro just to save few
characters, why?

>
> >
> >> +
> >> +       rcu_read_lock();
> >> +       net = rcu_dereference(net_link->net);
> >> +       if (net)
> >> +               inum = net->ns.inum;
> >> +       rcu_read_unlock();
> >> +
> >> +       info->netns.netns_ino = inum;
> >> +       info->netns.attach_type = net_link->type;
> >> +       return 0;
> >> +}
> >> +
> >> +static void bpf_netns_link_show_fdinfo(const struct bpf_link *link,
> >> +                                      struct seq_file *seq)
> >> +{
> >> +       struct bpf_link_info info = {};
> >> +
> >> +       bpf_netns_link_fill_info(link, &info);
> >> +       seq_printf(seq,
> >> +                  "netns_ino:\t%u\n"
> >> +                  "attach_type:\t%u\n",
> >> +                  info.netns.netns_ino,
> >> +                  info.netns.attach_type);
> >> +}
> >> +
> >> +static const struct bpf_link_ops bpf_netns_link_ops = {
> >> +       .release = bpf_netns_link_release,
> >> +       .dealloc = bpf_netns_link_dealloc,
> >> +       .update_prog = bpf_netns_link_update_prog,
> >> +       .fill_link_info = bpf_netns_link_fill_info,
> >> +       .show_fdinfo = bpf_netns_link_show_fdinfo,
> >> +};
> >> +
> >>  int netns_bpf_prog_query(const union bpf_attr *attr,
> >>                          union bpf_attr __user *uattr)
> >>  {
> >> @@ -67,6 +213,13 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >>
> >>         net = current->nsproxy->net_ns;
> >>         mutex_lock(&netns_bpf_mutex);
> >> +
> >> +       /* Attaching prog directly is not compatible with links */
> >> +       if (rcu_access_pointer(net->bpf.links[type])) {
> >> +               ret = -EBUSY;
> >
> > EEXIST would be returned if another prog is attached. Given in this
> > case attaching prog or link has same semantics (one cannot replace
> > attached program, unlike for cgroups), should we keep it consistent
> > and return EEXIST here as well?
>
> Makes sense, will switch to EEXIST.
>
> >
> >> +               goto unlock;
> >> +       }
> >> +
> >>         switch (type) {
> >>         case NETNS_BPF_FLOW_DISSECTOR:
> >>                 ret = flow_dissector_bpf_prog_attach(net, prog);
> >> @@ -75,6 +228,7 @@ int netns_bpf_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >>                 ret = -EINVAL;
> >>                 break;
> >>         }
> >> +unlock:
> >>         mutex_unlock(&netns_bpf_mutex);
> >>
> >>         return ret;
> >> @@ -85,6 +239,10 @@ static int __netns_bpf_prog_detach(struct net *net,
> >>  {
> >>         struct bpf_prog *attached;
> >>
> >> +       /* Progs attached via links cannot be detached */
> >> +       if (rcu_access_pointer(net->bpf.links[type]))
> >> +               return -EBUSY;
> >
> > This is more of -EINVAL?
>
> No strong feelings here. The intention of returning EBUSY on
> attach/detach was to signal that the attach point is in use, busy, by
> another incompatible attachment.

But we are doing detachment here. We are trying to detach something
that we didn't attach (because link can't be detached explicitly,
right?). So yeah, user clearly did something wrong here.

>
> EINVAL sends a message that I did a bad job passing argument to the
> syscall. But this is just my interpretation.
>
> >
> >> +
> >>         /* No need for update-side lock when net is going away. */
> >>         attached = rcu_dereference_protected(net->bpf.progs[type],
> >>                                              !check_net(net) ||
> >> @@ -112,14 +270,109 @@ int netns_bpf_prog_detach(const union bpf_attr *attr)
> >>         return ret;
> >>  }
> >>
> >> +static int __netns_bpf_link_attach(struct net *net, struct bpf_link *link,
> >> +                                  enum netns_bpf_attach_type type)
> >> +{
> >> +       int err;
> >> +
> >> +       /* Allow attaching only one prog or link for now */
> >> +       if (rcu_access_pointer(net->bpf.links[type]))
> >> +               return -E2BIG;
> >> +       /* Links are not compatible with attaching prog directly */
> >> +       if (rcu_access_pointer(net->bpf.progs[type]))
> >> +               return -EBUSY;
> >
> > Same as above. Do we need three different error codes instead of
> > consistently using EEXIST?
>
> Ok, EEXIST seems fine to me well.
>
> >
> >
> >> +
> >> +       switch (type) {
> >> +       case NETNS_BPF_FLOW_DISSECTOR:
> >> +               err = flow_dissector_bpf_prog_attach(net, link->prog);
> >> +               break;
> >> +       default:
> >> +               err = -EINVAL;
> >> +               break;
> >> +       }
> >> +       if (!err)
> >> +               rcu_assign_pointer(net->bpf.links[type], link);
> >> +       return err;
> >> +}
> >> +
> >
> > [...]
> >
> >> +       err = bpf_link_prime(&net_link->link, &link_primer);
> >> +       if (err) {
> >> +               kfree(net_link);
> >> +               goto out_put_net;
> >> +       }
> >> +
> >> +       err = netns_bpf_link_attach(net, &net_link->link, netns_type);
> >> +       if (err) {
> >> +               bpf_link_cleanup(&link_primer);
> >> +               goto out_put_net;
> >> +       }
> >> +
> >> +       err = bpf_link_settle(&link_primer);
> >
> > This looks a bit misleading. bpf_link_settle() cannot fail and returns
> > FD, but here it looks like it might return error. I think it would be
> > more straightforward to just:
> >
> >     put_net(net);
> >     return bpf_link_settle(&link_primer);
> >
> > out_put_net:
> >     put_net(net);
> >     return err;
>
> That reads better. Will change. Thanks.
>
>
> Appreciate the review. Thanks for all the feedback.
>

Sure, glad to help.

> -jkbs
>
> [...]
