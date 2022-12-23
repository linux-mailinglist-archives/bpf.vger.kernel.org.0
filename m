Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E3654BDF
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 05:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiLWEHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 23:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiLWEHC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 23:07:02 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27F222B26
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 20:06:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso7691578pjp.4
        for <bpf@vger.kernel.org>; Thu, 22 Dec 2022 20:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNn1oup5QeHRrkRW1TU6zdgHsqi0mFj9gfebNbDtMN4=;
        b=LQV61lmbMtNhgOh6x0iX611A/aFfABuSDvnJjlb5m27LZX9MUjifKJdLQIAtdgYISo
         AjXBaSJlDuMPrnA8X3NSAb7sFJ+9ScvYhWB/JzdEGBY6/KvEFpI9ZVBtxyFSH9itiJwh
         YWupT4g1C2rEZde88NYjGZM9Fb9avAR5egjOAKorPrLUftEGKghNSluxpdts+js7RQyG
         KXBYJkslzHJRZkMFYPLhm4LiW77n76uYLAuIRnsouDXEvCOu2VrQ7uzhKE0uwmbl6VPT
         b7Of9I0zpid8vzHI7MhgYmfIV+dyorFpa60HCMIZbFmfelzIgMOngHH3vJcsGHaVQPm2
         Be3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNn1oup5QeHRrkRW1TU6zdgHsqi0mFj9gfebNbDtMN4=;
        b=sPCAfPK6qjXD3SF/5kREOy/xVbUJjyeoW/lTQMeRKdb/42VYz4dJK8sJicVq/4Ghu0
         ZoqH6gq243UYTafOIAdeWnlbkSBUXr0M5qwddL8YYeuCveiGu7euhAXebYcVywAxyrOD
         uV0MrJdnSrR6yfCmYbtqr+HnicVPtEcUI/vm3Mvj7NQHJ53+DQCv7nJglm9NCeAiierp
         +z3rhX+3GVpb0b1D8lRlgATVmu9Qxm/VwpElDOkgFckLqEm/+XG3qFPDwoqJ3RurRfVx
         Ioz5aBKmwBUt/TZAW6gxi046BQPTwXCHGzrKnaCQenpu/kn3pSgzVv1FYRc+iidhcdT3
         yCvw==
X-Gm-Message-State: AFqh2kqT0yDODpxGoW1RglryxABSnaf4as4msTPVrfRdxFDJIQR0/djU
        gVHugVZDVAu2DnwF9Tslc6I5pIMUK+/9P16RvnvV3w==
X-Google-Smtp-Source: AMrXdXt+h45RVd3i8TtC86EoE0v+nBwvgtK61mE1B55sppFDH1E6uOxbmLFuM5FLOqhEv5IU91b/VUeOzudNOoDBvJo=
X-Received: by 2002:a17:90a:5296:b0:219:fbc:a088 with SMTP id
 w22-20020a17090a529600b002190fbca088mr933955pjh.162.1671768408887; Thu, 22
 Dec 2022 20:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com> <20221220222043.3348718-9-sdf@google.com>
 <5983e0f0-e1ee-5843-33ea-64d139e2e849@linux.dev>
In-Reply-To: <5983e0f0-e1ee-5843-33ea-64d139e2e849@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 22 Dec 2022 20:06:36 -0800
Message-ID: <CAKH8qBtCrAqxTzSECyG2VjO7rx27mdSEKMwXadrvVOvDaf5rBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 4:37 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 12/20/22 2:20 PM, Stanislav Fomichev wrote:
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 0e3fc743e0a8..60978a1f9baa 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -187,17 +187,13 @@ static void __bpf_offload_dev_netdev_unregister(struct bpf_offload_dev *offdev,
> >       kfree(ondev);
> >   }
> >
> > -int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> > +static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *netdev)
> >   {
> >       struct bpf_offload_netdev *ondev;
> >       struct bpf_prog_offload *offload;
> >       int err;
> >
> > -     if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> > -         attr->prog_type != BPF_PROG_TYPE_XDP)
> > -             return -EINVAL;
> > -
> > -     if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > +     if (!netdev)
>
> Is this !netdev test needed?

Seems safe to drop. _inherit has a 'old_prog->aux->offload' check and
_init has a check after dev_get_by_index.

> >               return -EINVAL;
> >
> >       offload = kzalloc(sizeof(*offload), GFP_USER);
> > @@ -205,21 +201,13 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> >               return -ENOMEM;
> >
> >       offload->prog = prog;
> > +     offload->netdev = netdev;
> >
> > -     offload->netdev = dev_get_by_index(current->nsproxy->net_ns,
> > -                                        attr->prog_ifindex);
> > -     err = bpf_dev_offload_check(offload->netdev);
> > -     if (err)
> > -             goto err_maybe_put;
> > -
> > -     prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
> > -
> > -     down_write(&bpf_devs_lock);
> >       ondev = bpf_offload_find_netdev(offload->netdev);
> >       if (!ondev) {
> >               if (bpf_prog_is_offloaded(prog->aux)) {
> >                       err = -EINVAL;
> > -                     goto err_unlock;
> > +                     goto err_free;
> >               }
> >
> >               /* When only binding to the device, explicitly
> > @@ -227,25 +215,80 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> >                */
> >               err = __bpf_offload_dev_netdev_register(NULL, offload->netdev);
> >               if (err)
> > -                     goto err_unlock;
> > +                     goto err_free;
> >               ondev = bpf_offload_find_netdev(offload->netdev);
> >       }
> >       offload->offdev = ondev->offdev;
> >       prog->aux->offload = offload;
> >       list_add_tail(&offload->offloads, &ondev->progs);
> > -     dev_put(offload->netdev);
> > -     up_write(&bpf_devs_lock);
> >
> >       return 0;
> > -err_unlock:
> > -     up_write(&bpf_devs_lock);
> > -err_maybe_put:
> > -     if (offload->netdev)
> > -             dev_put(offload->netdev);
> > +err_free:
> >       kfree(offload);
> >       return err;
> >   }
> >
> > +int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
> > +{
> > +     struct net_device *netdev;
> > +     int err;
> > +
> > +     if (attr->prog_type != BPF_PROG_TYPE_SCHED_CLS &&
> > +         attr->prog_type != BPF_PROG_TYPE_XDP)
> > +             return -EINVAL;
> > +
> > +     if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> > +             return -EINVAL;
> > +
> > +     netdev = dev_get_by_index(current->nsproxy->net_ns, attr->prog_ifindex);
> > +     if (!netdev)
> > +             return -EINVAL;
> > +
> > +     down_write(&bpf_devs_lock);
> > +     err = bpf_dev_offload_check(netdev);
> > +     if (err)
> > +             goto out;
> > +
> > +     prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
>
> nit. move the bpf_dev_offload_check() and offload_requested assignment out.  I
> don't think they need lock protection so that it is clear what the lock is
> protecting in the future reading.  It seems the original code have them outside
> also.

Sure.

> > +
> > +     err = __bpf_prog_dev_bound_init(prog, netdev);
> > +     if (err)
> > +             goto out;
>
> nit. goto can be saved.

Ack, will drop here; although, will still keep the goto above for
dev_put(netdev).

> > +
> > +out:
> > +     dev_put(netdev);
> > +     up_write(&bpf_devs_lock);
> > +     return err;
> > +}
> > +
> > +int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog, struct bpf_prog *old_prog)
> > +{
> > +     int err;
> > +
> > +     if (!bpf_prog_is_dev_bound(old_prog->aux))
> > +             return 0;
> > +
> > +     if (bpf_prog_is_offloaded(old_prog->aux))
> > +             return -EINVAL;
> > +
> > +     down_write(&bpf_devs_lock);
> > +     if (!old_prog->aux->offload) {
> > +             err = -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     new_prog->aux->dev_bound = old_prog->aux->dev_bound;
> > +     new_prog->aux->offload_requested = old_prog->aux->offload_requested;
>
> nit. Same here, I think the initialization can be moved outside of the lock.

Agreed. Seems like this will cause bpf_prog_dev_bound_destroy to be
called when we return with an error below; but seems safe since we're
also doing an 'aux->offload' check in there.

> > +
> > +     err = __bpf_prog_dev_bound_init(new_prog, old_prog->aux->offload->netdev);
> > +     if (err)
> > +             goto out;
>
> goto can be saved.

Thx.

> > +
> > +out:
> > +     up_write(&bpf_devs_lock);
> > +     return err;
> > +}
> > +
> >   int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
> >   {
> >       struct bpf_prog_offload *offload;
> > @@ -687,6 +730,22 @@ bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *netdev)
> >   }
> >   EXPORT_SYMBOL_GPL(bpf_offload_dev_match);
> >
> > +bool bpf_prog_dev_bound_match(struct bpf_prog *lhs, struct bpf_prog *rhs)
> > +{
> > +     bool ret;
> > +
> > +     if (bpf_prog_is_offloaded(lhs->aux) != bpf_prog_is_offloaded(rhs->aux))
> > +             return false;
> > +
> > +     down_read(&bpf_devs_lock);
> > +     ret = lhs->aux->offload && rhs->aux->offload &&
> > +           lhs->aux->offload->netdev &&
> > +           lhs->aux->offload->netdev == rhs->aux->offload->netdev;
> > +     up_read(&bpf_devs_lock);
> > +
> > +     return ret;
> > +}
> > +
> >   bool bpf_offload_prog_map_match(struct bpf_prog *prog, struct bpf_map *map)
> >   {
> >       struct bpf_offloaded_map *offmap;
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 11c558be4992..64a68e8fb072 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2605,6 +2605,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
> >                       goto free_prog_sec;
> >       }
> >
> > +     if (type == BPF_PROG_TYPE_EXT && dst_prog) {
>
> Does it also need to test the bpf_prog_is_dev_bound(dst_prog->aux)?  Otherwise,
> the bpf_prog_dev_bound_inherit() below will fail on everything for !CONFIG_NET.

We do the following in bpf_prog_dev_bound_inherit which should be enough?

if (!bpf_prog_is_dev_bound(old_prog->aux))
     return 0;

Or am I missing something?


> > +             err = bpf_prog_dev_bound_inherit(prog, dst_prog);
> > +             if (err)
> > +                     goto free_prog_sec;
> > +     }
> > +
> >       /* find program type: socket_filter vs tracing_filter */
> >       err = find_prog_type(type, prog);
> >       if (err < 0)
> > @@ -3021,6 +3027,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >                       goto out_put_prog;
> >               }
> >
> > +             if (bpf_prog_is_dev_bound(prog->aux) &&
>
> Like here.
>
> > +                 !bpf_prog_dev_bound_match(prog, tgt_prog)) {
> > +                     err = -EINVAL;
> > +                     goto out_put_prog;
> > +             }
> > +
> >               key = bpf_trampoline_compute_key(tgt_prog, NULL, btf_id);
> >       }
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 320451a0be3e..64f4d2b5824f 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16537,11 +16537,6 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >       if (tgt_prog) {
> >               struct bpf_prog_aux *aux = tgt_prog->aux;
> >
> > -             if (bpf_prog_is_dev_bound(tgt_prog->aux)) {
> > -                     bpf_log(log, "Replacing device-bound programs not supported\n");
> > -                     return -EINVAL;
> > -             }
> > -
> >               for (i = 0; i < aux->func_info_cnt; i++)
> >                       if (aux->func_info[i].type_id == btf_id) {
> >                               subprog = i;
>
