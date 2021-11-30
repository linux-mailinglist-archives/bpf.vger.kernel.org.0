Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5B2462B8B
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 05:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbhK3EN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 23:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhK3ENZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 23:13:25 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2061DC061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 20:10:07 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f9so48642515ybq.10
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 20:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3WddHA1MPs3vAE/DhD2n6VSzMivGm8e319un1OXMvg=;
        b=n28HsXbpUYdRF8wW12+hnz5ffMaKeJLEo42s4DuNA2NsJ5zBEquD/fN00oZ6LnyQpm
         uwfxcsuDiwSdZcI/1hxexA99yL3Tmfb9saDkkHhTtc7HYwRUq62PLBcS6l4xoO9BcdmY
         F+lJZt1NAn7UUMaOtCKxGbA7k7l+H5pYmoJcGIWobkjKKQhHTkJoGdSCk5+cljCe6cJW
         mJIZq+IyFQqkIxcDcqOSB4rzwt6ZKJlz91JOoPV5saPwtnR0nHSUl0keZ2CnIRQ3IvTn
         kA9lzf0SP+CrhRKPUGBKezG8cvRQnj2sWe5WlJklz6z3Vl6foLVi9BfxvUm/Nm410awL
         FKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3WddHA1MPs3vAE/DhD2n6VSzMivGm8e319un1OXMvg=;
        b=LCkzK8nE0b1FVM7jNo7yS9SWZHtS0aSWmLDuauDrXlxHTW0ih1sSNNX0zbPnNc0wTl
         zYFkraSz4dB/EbjjtS+UVk+NQc10ChQJi9IFpXPy/XT+HRMLdtT9vPySQGNAcIsDCYNx
         NY97NTZcMZa4CbKrv3vXVXpTijXrzMpWhqN+yfoMtKPHdtOLsE8QVDfG/M2ATYEWugRq
         kfEoQe97t/slZdZCD2mPAUSnDfKyFxCljEnRZPCvnlNj270ncOKIsmjUdjt1HiQvRH6U
         Ubu6F81wS/DL3tbzIpvdqYwzaIw5ub5Oxy47nzMAP/MEoJ7vQWFvBIZTX1ZgVQkp+u/H
         eZFw==
X-Gm-Message-State: AOAM530rkOXxvloBycmWZl0JGtlYHWedeWi8X2u5xORacZIHkS6WutIO
        kQgb9yhZ0+/V2EFxiD91pI6unPS2eoPzGd+YWyY=
X-Google-Smtp-Source: ABdhPJwxyro2wgpfiJDH5HjliQVhUzr6ebQ3N3aHem25S7lP55RI6gnAW/znDCzvm9LgrM6zrinVkhWg0j9oTHEtiik=
X-Received: by 2002:a25:6d4:: with SMTP id 203mr38039049ybg.83.1638245406119;
 Mon, 29 Nov 2021 20:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com>
 <20211124060209.493-8-alexei.starovoitov@gmail.com> <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
 <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211130031819.7ulr5cfqrqagioza@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 20:09:55 -0800
Message-ID: <CAEf4Bzb3E5qyf3WtOAWHWSiq9ptPLXErGg5pCFQTAdz0LhZCBw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/16] bpf: Add bpf_core_add_cands() and wire
 it into bpf_core_apply_relo_insn().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 7:18 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 29, 2021 at 05:03:37PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Given BPF program's BTF root type name perform the following steps:
> > > . search in vmlinux candidate cache.
> > > . if (present in cache and candidate list >= 1) return candidate list.
> > > . do a linear search through kernel BTFs for possible candidates.
> > > . regardless of number of candidates found populate vmlinux cache.
> > > . if (candidate list >= 1) return candidate list.
> > > . search in module candidate cache.
> > > . if (present in cache) return candidate list (even if list is empty).
> > > . do a linear search through BTFs of all kernel modules
> > >   collecting candidates from all of them.
> > > . regardless of number of candidates found populate module cache.
> > > . return candidate list.
> > > Then wire the result into bpf_core_apply_relo_insn().
> > >
> > > When BPF program is trying to CO-RE relocate a type
> > > that doesn't exist in either vmlinux BTF or in modules BTFs
> > > these steps will perform 2 cache lookups when cache is hit.
> > >
> > > Note the cache doesn't prevent the abuse by the program that might
> > > have lots of relocations that cannot be resolved. Hence cond_resched().
> > >
> > > CO-RE in the kernel requires CAP_BPF, since BTF loading requires it.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/btf.c          | 250 +++++++++++++++++++++++++++++++++++++-
> > >  tools/lib/bpf/relo_core.h |   2 +
> > >  2 files changed, 251 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index dbf1f389b1d3..cf971b8a0769 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/kobject.h>
> > >  #include <linux/sysfs.h>
> > >  #include <net/sock.h>
> > > +#include "../tools/lib/bpf/relo_core.h"
> > >
> >
> > [...]
> >
> > > +static void populate_cand_cache(struct bpf_cand_cache *cands,
> > > +                               struct bpf_cand_cache **cache,
> > > +                               int cache_size)
> > > +{
> > > +       u32 hash = jhash_2words(cands->name_len,
> > > +                               (((u32) cands->name[0]) << 8) | cands->name[1], 0);
> >
> > maybe add a helper func to calculate the hash given struct
> > bpf_cand_cache to keep the logic always in sync?
>
> I felt it's trivial enough, but sure I can do that.
>
> > > +       struct bpf_cand_cache *cc = cache[hash % cache_size];
> > > +
> > > +       if (cc)
> > > +               bpf_free_cands(cc);
> > > +       cache[hash % cache_size] = cands;
> > > +}
> > > +
> >
> > [...]
> >
> > > +static struct bpf_cand_cache *
> > > +bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
> > > +{
> > > +       const struct btf *local_btf = ctx->btf;
> > > +       const struct btf_type *local_type;
> > > +       const struct btf *main_btf;
> > > +       size_t local_essent_len;
> > > +       struct bpf_cand_cache *cands, *cc;
> > > +       struct btf *mod_btf;
> > > +       const char *name;
> > > +       int id;
> > > +
> > > +       local_type = btf_type_by_id(local_btf, local_type_id);
> > > +       if (!local_type)
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > > +       name = btf_name_by_offset(local_btf, local_type->name_off);
> > > +       if (str_is_empty(name))
> > > +               return ERR_PTR(-EINVAL);
> > > +       local_essent_len = bpf_core_essential_name_len(name);
> > > +
> > > +       cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
> > > +       if (!cands)
> > > +               return ERR_PTR(-ENOMEM);
> > > +       cands->name = kmemdup_nul(name, local_essent_len, GFP_KERNEL);
> >
> > it's pretty minor, but you don't really need kmemdup_nul() until
> > populate_cand_cache(), you can use name as is until you really need to
> > cache cands
>
> I thought about it, but didn't do it, because it complicates the code:
> bpf_core_add_cands() would somehow need to differentiate
> whether cands->name came as a 1st call into bpf_core_add_cands()
> or it's a subsequent call.

ah, I initially missed that bpf_core_add_cans() can also free
candidate list; yeah, it's fine, as I said minor

> It could be a flag in struct bpf_cand_cache that will tell
> whether bpf_free_cands() needs to be freed or not, but feels
> unnecessary complex.

right, flags suck

>
> >
> > > +       if (!cands->name) {
> > > +               kfree(cands);
> > > +               return ERR_PTR(-ENOMEM);
> > > +       }
> > > +       cands->kind = btf_kind(local_type);
> > > +       cands->name_len = local_essent_len;
> > > +
> > > +       cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> > > +       if (cc) {
> > > +               if (cc->cnt) {
> > > +                       bpf_free_cands(cands);
> > > +                       return cc;
> > > +               }
> > > +               goto check_modules;
> > > +       }
> > > +
> > > +       /* Attempt to find target candidates in vmlinux BTF first */
> > > +       main_btf = bpf_get_btf_vmlinux();
> > > +       cands = bpf_core_add_cands(cands, main_btf, 1);
> > > +       if (IS_ERR(cands))
> > > +               return cands;
> > > +
> > > +       /* populate cache even when cands->cnt == 0 */
> > > +       populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> > > +
> > > +       /* if vmlinux BTF has any candidate, don't go for module BTFs */
> > > +       if (cands->cnt)
> > > +               return cands;
> > > +
> > > +check_modules:
> > > +       cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
> > > +       if (cc) {
> > > +               bpf_free_cands(cands);
> > > +               /* if cache has it return it even if cc->cnt == 0 */
> > > +               return cc;
> > > +       }
> > > +
> > > +       /* If candidate is not found in vmlinux's BTF then search in module's BTFs */
> > > +       spin_lock_bh(&btf_idr_lock);
> > > +       idr_for_each_entry(&btf_idr, mod_btf, id) {
> > > +               if (!btf_is_module(mod_btf))
> > > +                       continue;
> > > +               /* linear search could be slow hence unlock/lock
> > > +                * the IDR to avoiding holding it for too long
> > > +                */
> > > +               btf_get(mod_btf);
> > > +               spin_unlock_bh(&btf_idr_lock);
> > > +               cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
> > > +               if (IS_ERR(cands)) {
> > > +                       btf_put(mod_btf);
> > > +                       return cands;
> > > +               }
> > > +               spin_lock_bh(&btf_idr_lock);
> > > +               btf_put(mod_btf);
> >
> > either need to additionally btf_get(mod_btf) inside
> > bpf_core_add_cands() not btf_put() it here if you added at least one
> > candidate, as you are storing targ_btf inside bpf_core_add_cands() and
> > dropping refcount might leave dangling pointer
>
> Module will not go away while cands are being searched and cache ops are done.
> purge_cand_cache() is called from MODULE_STATE_GOING.
> I've considered doing the purge from btf_put(),
> but we don't guarantee the context in there, so mutex_lock
> would complicate btf_put too much.
> It's simpler to do purge from MODULE_STATE_GOING.
> But more below...
>
> > > +               for (i = 0; i < cc->cnt; i++) {
> > > +                       bpf_log(ctx->log,
> > > +                               "CO-RE relocating %s %s: found target candidate [%d]\n",
> > > +                               btf_kind_str[cc->kind], cc->name, cc->cands[i].id);
> > > +                       cands.cands[i].btf = cc->cands[i].btf;
> > > +                       cands.cands[i].id = cc->cands[i].id;
> > > +               }
> > > +               cands.len = cc->cnt;
> > > +               mutex_unlock(&cand_cache_mutex);
> > > +       }
> > > +
> >
> > cache is not locked at this point, so those cands.cands[i].btf objects
> > might be freed now (if module got unloaded meanwhile), right?
>
> right, looks easier to do btf_get here while copying the pointer.
> and do a loop of btf_put after bpf_core_apply_relo_insn.
> Doing btf_get inside bpf_core_add_cands adds complexity to cache replacement
> and purging.
> Right now __purge_cand_cache is just kfree of the whole slot
> with multiple btf pointers in there potentially from different modules.
> With btf_get in add_cands it would need to be a loop and
> bpf_free_cands would need to have a loop.
> btw the earlier versions of this patch set had the same issue,
> so thanks for the good catch!

no prolem. Yeah, btf_get() here should work as well, I think.
>
> > This global sharing of that small cache seems to cause unnecessary
> > headaches, tbh. It adds global mutex (which might also block for
> > kcalloc). If you used that cache locally for processing single
> > bpf_prog, you wouldn't need the locking. It can probably also simplify
> > the refcounting, especially if you just btf_get(targ_btf) for each
> > candidate and then btf_put() it after all relos are processed. You are
> > also half-step away from removing the size restriction (just chain
> > bpf_cand_caches together) and having a fixed bucket-size hash with
> > non-fixed chain length (which probably would be totally fine for all
> > practical purposes).
>
> and that would be a almost done hashtable? why add that complexity?

well, my point was that you already have all this complexity :) I see
avoiding global mutex as less complexity, hashmap parts are just
annoying and mundate code, but not really a complexity.

But if you insist on a shared global mini-cache, that's fine.

> The size restriction is necessary anyway for a global cache.
> Even for per-program hashtable some size restriction might be
> necessary. CAP_BPF is a target for "researchers" to do
> weird things with the kernel.
>
> >
> >
> > > +       err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> > > +                                      relo, relo_idx, ctx->btf, &cands);
> > > +       kfree(cands.cands);
> > > +       return err;
> > >  }
> > > diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> > > index f410691cc4e5..f7b0d698978c 100644
> > > --- a/tools/lib/bpf/relo_core.h
> > > +++ b/tools/lib/bpf/relo_core.h
> > > @@ -8,8 +8,10 @@
> > >
> > >  struct bpf_core_cand {
> > >         const struct btf *btf;
> > > +#ifndef __KERNEL__
> > >         const struct btf_type *t;
> > >         const char *name;
> > > +#endif
> >
> > why? doesn't seem to be used and both t and name could be derived from
> > btf and id
>
> exactly, that's why CO-RE in the kernel doesn't use them,
> but libbpf uses both for debugging and for passing information
> back and forth between layers.

oh, I thought you added those fields initially and forgot to delete or
something, didn't notice that you are just "opting them out" for
__KERNEL__. I think libbpf code doesn't strictly need this, here's the
diff that completely removes their use, it's pretty straightforward
and minimal, so maybe instead of #ifdef'ing let's just do that?

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b59fede08ba7..95fa57eea289 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5179,15 +5179,18 @@ static int bpf_core_add_cands(struct
bpf_core_cand *local_cand,
                   struct bpf_core_cand_list *cands)
 {
     struct bpf_core_cand *new_cands, *cand;
-    const struct btf_type *t;
-    const char *targ_name;
+    const struct btf_type *t, *local_t;
+    const char *targ_name, *local_name;
     size_t targ_essent_len;
     int n, i;

+    local_t = btf__type_by_id(local_cand->btf, local_cand->id);
+    local_name = btf__str_by_offset(local_cand->btf, local_t->name_off);
+
     n = btf__type_cnt(targ_btf);
     for (i = targ_start_id; i < n; i++) {
         t = btf__type_by_id(targ_btf, i);
-        if (btf_kind(t) != btf_kind(local_cand->t))
+        if (btf_kind(t) != btf_kind(local_t))
             continue;

         targ_name = btf__name_by_offset(targ_btf, t->name_off);
@@ -5198,12 +5201,12 @@ static int bpf_core_add_cands(struct
bpf_core_cand *local_cand,
         if (targ_essent_len != local_essent_len)
             continue;

-        if (strncmp(local_cand->name, targ_name, local_essent_len) != 0)
+        if (strncmp(local_name, targ_name, local_essent_len) != 0)
             continue;

         pr_debug("CO-RE relocating [%d] %s %s: found target candidate
[%d] %s %s in [%s]\n",
-             local_cand->id, btf_kind_str(local_cand->t),
-             local_cand->name, i, btf_kind_str(t), targ_name,
+             local_cand->id, btf_kind_str(local_t),
+             local_name, i, btf_kind_str(t), targ_name,
              targ_btf_name);
         new_cands = libbpf_reallocarray(cands->cands, cands->len + 1,
                           sizeof(*cands->cands));
@@ -5212,8 +5215,6 @@ static int bpf_core_add_cands(struct
bpf_core_cand *local_cand,

         cand = &new_cands[cands->len];
         cand->btf = targ_btf;
-        cand->t = t;
-        cand->name = targ_name;
         cand->id = i;

         cands->cands = new_cands;
@@ -5320,18 +5321,20 @@ bpf_core_find_cands(struct bpf_object *obj,
const struct btf *local_btf, __u32 l
     struct bpf_core_cand local_cand = {};
     struct bpf_core_cand_list *cands;
     const struct btf *main_btf;
+    const struct btf_type *local_t;
+    const char *local_name;
     size_t local_essent_len;
     int err, i;

     local_cand.btf = local_btf;
-    local_cand.t = btf__type_by_id(local_btf, local_type_id);
-    if (!local_cand.t)
+    local_t = btf__type_by_id(local_btf, local_type_id);
+    if (!local_t)
         return ERR_PTR(-EINVAL);

-    local_cand.name = btf__name_by_offset(local_btf, local_cand.t->name_off);
-    if (str_is_empty(local_cand.name))
+    local_name = btf__name_by_offset(local_btf, local_t->name_off);
+    if (str_is_empty(local_name))
         return ERR_PTR(-EINVAL);
-    local_essent_len = bpf_core_essential_name_len(local_cand.name);
+    local_essent_len = bpf_core_essential_name_len(local_name);

     cands = calloc(1, sizeof(*cands));
     if (!cands)
diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
index 3b9f8f18346c..0dc0b9256bea 100644
--- a/tools/lib/bpf/relo_core.h
+++ b/tools/lib/bpf/relo_core.h
@@ -77,8 +77,6 @@ struct bpf_core_relo {

 struct bpf_core_cand {
     const struct btf *btf;
-    const struct btf_type *t;
-    const char *name;
     __u32 id;
 };
