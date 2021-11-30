Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC512462AFB
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 04:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhK3DVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 22:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhK3DVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 22:21:40 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AC9C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 19:18:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id u80so19091068pfc.9
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 19:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aXlhI282UQ6zS2RqX7IPlPh3oKJYqo0TWGOAJlH5a2Y=;
        b=Ki6oZEDiJKD6ncIl448PXd+D6R+ytf9y8DtJ3Rp+7yek+aR0vfS/TIsgKO6GPFHWzw
         apz2CKuiLOOksvFG89qWoDxelqV51j3Mgm/GjgF6W0WUwr7Y1RApmuvfS6t5vD0qA62n
         Qm0rlnccQUJ9gurBTsaNWTs6bCCPCnI5v+90g8uWho9bxNun5LgJ+PWdP/ovrzRwr18E
         ZghZjV3yfdqFtSJn4yYffTCPYrmnb2jeY/5i2IJwlHJP7XfCFIA8asMuhcXs4w5oEAf6
         HRLjy/MGupgTVF0V0SJS6YleMyKml5LtOeAbplYhVuP4BpvxV0iGkAklSkhXeOb59x8u
         uBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aXlhI282UQ6zS2RqX7IPlPh3oKJYqo0TWGOAJlH5a2Y=;
        b=1wBc6FXiSwqHZMtsopFFrPC4desdnJfNnIuLEUWgv+CZ61cpX3MPzWhJ0XllPwFnLL
         8aNOjpHWHG8ZhQGmsE/TLcBbpY7zefLnOLAkG1MLSSU5AC76OXo9+ruGubNpYxxfJb8U
         GprgfcEcydtVB5vAlgAvUyzo2fEZE8yWQ7s6MKwDzRDx4It3EEk6JuybLVZaEUk3Y2yY
         YcpUPOIKLogzVFe3I9HGxfhYrnsU0esgbC2+7X1+QqR8ljMCRekv9WLGGbsjRiCL5yUQ
         jd7NazxfDQGtoZzkoZ5Lx8A8NEBBxvBL7FiHNRIRz+KL4TK8A2n/DefAoPTqcTT1E6Yn
         kCpA==
X-Gm-Message-State: AOAM533t/vecUsiEA/bljN8wyUflf5dAAmiMj9EQAQFJVO8ITEHfHAaK
        tG2YaO2Zr7iACTouE5FzD4LRwe/D2Kc=
X-Google-Smtp-Source: ABdhPJy6Q4IoBK6BNi05+fZ153gqfr61wU2btKqDRQ7kd6tT+bP+6i/s0kBoSP8HS6NzQTWLE0fiMA==
X-Received: by 2002:a63:8749:: with SMTP id i70mr32047141pge.379.1638242301749;
        Mon, 29 Nov 2021 19:18:21 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1efa])
        by smtp.gmail.com with ESMTPSA id l21sm660942pjt.24.2021.11.29.19.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 19:18:21 -0800 (PST)
Date:   Mon, 29 Nov 2021 19:18:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
Message-ID: <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com>
 <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 05:03:37PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Given BPF program's BTF root type name perform the following steps:
> > . search in vmlinux candidate cache.
> > . if (present in cache and candidate list >= 1) return candidate list.
> > . do a linear search through kernel BTFs for possible candidates.
> > . regardless of number of candidates found populate vmlinux cache.
> > . if (candidate list >= 1) return candidate list.
> > . search in module candidate cache.
> > . if (present in cache) return candidate list (even if list is empty).
> > . do a linear search through BTFs of all kernel modules
> >   collecting candidates from all of them.
> > . regardless of number of candidates found populate module cache.
> > . return candidate list.
> > Then wire the result into bpf_core_apply_relo_insn().
> >
> > When BPF program is trying to CO-RE relocate a type
> > that doesn't exist in either vmlinux BTF or in modules BTFs
> > these steps will perform 2 cache lookups when cache is hit.
> >
> > Note the cache doesn't prevent the abuse by the program that might
> > have lots of relocations that cannot be resolved. Hence cond_resched().
> >
> > CO-RE in the kernel requires CAP_BPF, since BTF loading requires it.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/btf.c          | 250 +++++++++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/relo_core.h |   2 +
> >  2 files changed, 251 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index dbf1f389b1d3..cf971b8a0769 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/kobject.h>
> >  #include <linux/sysfs.h>
> >  #include <net/sock.h>
> > +#include "../tools/lib/bpf/relo_core.h"
> >
> 
> [...]
> 
> > +static void populate_cand_cache(struct bpf_cand_cache *cands,
> > +                               struct bpf_cand_cache **cache,
> > +                               int cache_size)
> > +{
> > +       u32 hash = jhash_2words(cands->name_len,
> > +                               (((u32) cands->name[0]) << 8) | cands->name[1], 0);
> 
> maybe add a helper func to calculate the hash given struct
> bpf_cand_cache to keep the logic always in sync?

I felt it's trivial enough, but sure I can do that.

> > +       struct bpf_cand_cache *cc = cache[hash % cache_size];
> > +
> > +       if (cc)
> > +               bpf_free_cands(cc);
> > +       cache[hash % cache_size] = cands;
> > +}
> > +
> 
> [...]
> 
> > +static struct bpf_cand_cache *
> > +bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
> > +{
> > +       const struct btf *local_btf = ctx->btf;
> > +       const struct btf_type *local_type;
> > +       const struct btf *main_btf;
> > +       size_t local_essent_len;
> > +       struct bpf_cand_cache *cands, *cc;
> > +       struct btf *mod_btf;
> > +       const char *name;
> > +       int id;
> > +
> > +       local_type = btf_type_by_id(local_btf, local_type_id);
> > +       if (!local_type)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       name = btf_name_by_offset(local_btf, local_type->name_off);
> > +       if (str_is_empty(name))
> > +               return ERR_PTR(-EINVAL);
> > +       local_essent_len = bpf_core_essential_name_len(name);
> > +
> > +       cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
> > +       if (!cands)
> > +               return ERR_PTR(-ENOMEM);
> > +       cands->name = kmemdup_nul(name, local_essent_len, GFP_KERNEL);
> 
> it's pretty minor, but you don't really need kmemdup_nul() until
> populate_cand_cache(), you can use name as is until you really need to
> cache cands

I thought about it, but didn't do it, because it complicates the code:
bpf_core_add_cands() would somehow need to differentiate
whether cands->name came as a 1st call into bpf_core_add_cands()
or it's a subsequent call.
It could be a flag in struct bpf_cand_cache that will tell
whether bpf_free_cands() needs to be freed or not, but feels
unnecessary complex.

> 
> > +       if (!cands->name) {
> > +               kfree(cands);
> > +               return ERR_PTR(-ENOMEM);
> > +       }
> > +       cands->kind = btf_kind(local_type);
> > +       cands->name_len = local_essent_len;
> > +
> > +       cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> > +       if (cc) {
> > +               if (cc->cnt) {
> > +                       bpf_free_cands(cands);
> > +                       return cc;
> > +               }
> > +               goto check_modules;
> > +       }
> > +
> > +       /* Attempt to find target candidates in vmlinux BTF first */
> > +       main_btf = bpf_get_btf_vmlinux();
> > +       cands = bpf_core_add_cands(cands, main_btf, 1);
> > +       if (IS_ERR(cands))
> > +               return cands;
> > +
> > +       /* populate cache even when cands->cnt == 0 */
> > +       populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> > +
> > +       /* if vmlinux BTF has any candidate, don't go for module BTFs */
> > +       if (cands->cnt)
> > +               return cands;
> > +
> > +check_modules:
> > +       cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
> > +       if (cc) {
> > +               bpf_free_cands(cands);
> > +               /* if cache has it return it even if cc->cnt == 0 */
> > +               return cc;
> > +       }
> > +
> > +       /* If candidate is not found in vmlinux's BTF then search in module's BTFs */
> > +       spin_lock_bh(&btf_idr_lock);
> > +       idr_for_each_entry(&btf_idr, mod_btf, id) {
> > +               if (!btf_is_module(mod_btf))
> > +                       continue;
> > +               /* linear search could be slow hence unlock/lock
> > +                * the IDR to avoiding holding it for too long
> > +                */
> > +               btf_get(mod_btf);
> > +               spin_unlock_bh(&btf_idr_lock);
> > +               cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
> > +               if (IS_ERR(cands)) {
> > +                       btf_put(mod_btf);
> > +                       return cands;
> > +               }
> > +               spin_lock_bh(&btf_idr_lock);
> > +               btf_put(mod_btf);
> 
> either need to additionally btf_get(mod_btf) inside
> bpf_core_add_cands() not btf_put() it here if you added at least one
> candidate, as you are storing targ_btf inside bpf_core_add_cands() and
> dropping refcount might leave dangling pointer

Module will not go away while cands are being searched and cache ops are done.
purge_cand_cache() is called from MODULE_STATE_GOING.
I've considered doing the purge from btf_put(),
but we don't guarantee the context in there, so mutex_lock
would complicate btf_put too much.
It's simpler to do purge from MODULE_STATE_GOING.
But more below...

> > +               for (i = 0; i < cc->cnt; i++) {
> > +                       bpf_log(ctx->log,
> > +                               "CO-RE relocating %s %s: found target candidate [%d]\n",
> > +                               btf_kind_str[cc->kind], cc->name, cc->cands[i].id);
> > +                       cands.cands[i].btf = cc->cands[i].btf;
> > +                       cands.cands[i].id = cc->cands[i].id;
> > +               }
> > +               cands.len = cc->cnt;
> > +               mutex_unlock(&cand_cache_mutex);
> > +       }
> > +
> 
> cache is not locked at this point, so those cands.cands[i].btf objects
> might be freed now (if module got unloaded meanwhile), right?

right, looks easier to do btf_get here while copying the pointer.
and do a loop of btf_put after bpf_core_apply_relo_insn.
Doing btf_get inside bpf_core_add_cands adds complexity to cache replacement
and purging.
Right now __purge_cand_cache is just kfree of the whole slot
with multiple btf pointers in there potentially from different modules.
With btf_get in add_cands it would need to be a loop and
bpf_free_cands would need to have a loop.
btw the earlier versions of this patch set had the same issue,
so thanks for the good catch!

> This global sharing of that small cache seems to cause unnecessary
> headaches, tbh. It adds global mutex (which might also block for
> kcalloc). If you used that cache locally for processing single
> bpf_prog, you wouldn't need the locking. It can probably also simplify
> the refcounting, especially if you just btf_get(targ_btf) for each
> candidate and then btf_put() it after all relos are processed. You are
> also half-step away from removing the size restriction (just chain
> bpf_cand_caches together) and having a fixed bucket-size hash with
> non-fixed chain length (which probably would be totally fine for all
> practical purposes).

and that would be a almost done hashtable? why add that complexity?
The size restriction is necessary anyway for a global cache.
Even for per-program hashtable some size restriction might be
necessary. CAP_BPF is a target for "researchers" to do
weird things with the kernel.

> 
> 
> > +       err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> > +                                      relo, relo_idx, ctx->btf, &cands);
> > +       kfree(cands.cands);
> > +       return err;
> >  }
> > diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> > index f410691cc4e5..f7b0d698978c 100644
> > --- a/tools/lib/bpf/relo_core.h
> > +++ b/tools/lib/bpf/relo_core.h
> > @@ -8,8 +8,10 @@
> >
> >  struct bpf_core_cand {
> >         const struct btf *btf;
> > +#ifndef __KERNEL__
> >         const struct btf_type *t;
> >         const char *name;
> > +#endif
> 
> why? doesn't seem to be used and both t and name could be derived from
> btf and id

exactly, that's why CO-RE in the kernel doesn't use them,
but libbpf uses both for debugging and for passing information
back and forth between layers.
