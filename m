Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CC462969
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhK3BHH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhK3BHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:07:07 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D0C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:03:49 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f9so47541015ybq.10
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvT6MQsVss9FBg6PYCKKqyAEXS+hpHER6NQUO8rwU7o=;
        b=MN0CzDStp09hAPW+bSlIs8pUz5ql04f5TaIv8yUYXf70XAcIBJnOdcT0HUYi1NyOUL
         ZPb1FDOsQk/3HgaGL0k3N3cCI0nBrY7TSRuotRo7fUMSuIBJktMgqy3Z3136ycY+vCTD
         5+1N9KWm4jCMAzaFyIbzbrXCoy2d4gwe+FlpiTXIMwru2jUgkldCILuXkqbRNkMhCjfx
         GWWpoUqrHucbzQo5qBXnCZZdywEjemf1iugNESkD5M2CeXwLI68UY8e/k/hTel/QEitm
         QfUP8lpRbt0n0Dbit2S9lexM13all2yspeYQoNttBfZq6reYLSfpJQx6dYjHXcdpjVxZ
         gO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvT6MQsVss9FBg6PYCKKqyAEXS+hpHER6NQUO8rwU7o=;
        b=5kHPre1sWGwIwvlo7xY3iEksP92tVCDsSBBIX8hQhPPZSgjBGugSf/RlX5Gn2cNYti
         jp77apGs0/hi2NLktxaCkWz+JxknaOFQPbApdBSbXf3dIw1pKCdWNO8mYjV8roqjHPWT
         6bCrl/TTFIRpfjxaz28IW9vGip/GaM72OrvjxWVgHCRvsJWO2G6cGqG/AnbjGFbyO4lC
         gohAxYB0ymXrxaKIVRVcTc/P/mobQ7jLIEw3d+0HWc6K1avCkk5tR1VypHB3I892tiPT
         1kzWHcWe4axHwMUsno9qr4k/vUbPpdNQqAFSgcsGtK1Vj86lQPzreoXLxMt72RM/tE3i
         Ek/g==
X-Gm-Message-State: AOAM531LLdOeeGOZZIzMrWVmQXHa97YcawVw4WrdJWVOAry0r9KnEO30
        2H+hKGWVx+bHFbiTbWHAjRy91gTUWhvlHYcaP0g=
X-Google-Smtp-Source: ABdhPJzaX/VDkiM5StDzW29tga7SwbjyDg2a3GtTf+jC5sUVIcJeR3wRzStzchU/Lh2k7kbq7BpfvVzMhJ/57l/pDHc=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr38079786ybs.308.1638234228191;
 Mon, 29 Nov 2021 17:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com> <20211124060209.493-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20211124060209.493-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 17:03:37 -0800
Message-ID: <CAEf4BzYNkgP-t_icXjLAxddOPWgN7GZZ7vWrsLbCDycN=z9KzA@mail.gmail.com>
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

On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Given BPF program's BTF root type name perform the following steps:
> . search in vmlinux candidate cache.
> . if (present in cache and candidate list >= 1) return candidate list.
> . do a linear search through kernel BTFs for possible candidates.
> . regardless of number of candidates found populate vmlinux cache.
> . if (candidate list >= 1) return candidate list.
> . search in module candidate cache.
> . if (present in cache) return candidate list (even if list is empty).
> . do a linear search through BTFs of all kernel modules
>   collecting candidates from all of them.
> . regardless of number of candidates found populate module cache.
> . return candidate list.
> Then wire the result into bpf_core_apply_relo_insn().
>
> When BPF program is trying to CO-RE relocate a type
> that doesn't exist in either vmlinux BTF or in modules BTFs
> these steps will perform 2 cache lookups when cache is hit.
>
> Note the cache doesn't prevent the abuse by the program that might
> have lots of relocations that cannot be resolved. Hence cond_resched().
>
> CO-RE in the kernel requires CAP_BPF, since BTF loading requires it.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/btf.c          | 250 +++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/relo_core.h |   2 +
>  2 files changed, 251 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index dbf1f389b1d3..cf971b8a0769 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -25,6 +25,7 @@
>  #include <linux/kobject.h>
>  #include <linux/sysfs.h>
>  #include <net/sock.h>
> +#include "../tools/lib/bpf/relo_core.h"
>

[...]

> +static void populate_cand_cache(struct bpf_cand_cache *cands,
> +                               struct bpf_cand_cache **cache,
> +                               int cache_size)
> +{
> +       u32 hash = jhash_2words(cands->name_len,
> +                               (((u32) cands->name[0]) << 8) | cands->name[1], 0);

maybe add a helper func to calculate the hash given struct
bpf_cand_cache to keep the logic always in sync?

> +       struct bpf_cand_cache *cc = cache[hash % cache_size];
> +
> +       if (cc)
> +               bpf_free_cands(cc);
> +       cache[hash % cache_size] = cands;
> +}
> +

[...]

> +static struct bpf_cand_cache *
> +bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
> +{
> +       const struct btf *local_btf = ctx->btf;
> +       const struct btf_type *local_type;
> +       const struct btf *main_btf;
> +       size_t local_essent_len;
> +       struct bpf_cand_cache *cands, *cc;
> +       struct btf *mod_btf;
> +       const char *name;
> +       int id;
> +
> +       local_type = btf_type_by_id(local_btf, local_type_id);
> +       if (!local_type)
> +               return ERR_PTR(-EINVAL);
> +
> +       name = btf_name_by_offset(local_btf, local_type->name_off);
> +       if (str_is_empty(name))
> +               return ERR_PTR(-EINVAL);
> +       local_essent_len = bpf_core_essential_name_len(name);
> +
> +       cands = kcalloc(1, sizeof(*cands), GFP_KERNEL);
> +       if (!cands)
> +               return ERR_PTR(-ENOMEM);
> +       cands->name = kmemdup_nul(name, local_essent_len, GFP_KERNEL);

it's pretty minor, but you don't really need kmemdup_nul() until
populate_cand_cache(), you can use name as is until you really need to
cache cands

> +       if (!cands->name) {
> +               kfree(cands);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +       cands->kind = btf_kind(local_type);
> +       cands->name_len = local_essent_len;
> +
> +       cc = check_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> +       if (cc) {
> +               if (cc->cnt) {
> +                       bpf_free_cands(cands);
> +                       return cc;
> +               }
> +               goto check_modules;
> +       }
> +
> +       /* Attempt to find target candidates in vmlinux BTF first */
> +       main_btf = bpf_get_btf_vmlinux();
> +       cands = bpf_core_add_cands(cands, main_btf, 1);
> +       if (IS_ERR(cands))
> +               return cands;
> +
> +       /* populate cache even when cands->cnt == 0 */
> +       populate_cand_cache(cands, vmlinux_cand_cache, VMLINUX_CAND_CACHE_SIZE);
> +
> +       /* if vmlinux BTF has any candidate, don't go for module BTFs */
> +       if (cands->cnt)
> +               return cands;
> +
> +check_modules:
> +       cc = check_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
> +       if (cc) {
> +               bpf_free_cands(cands);
> +               /* if cache has it return it even if cc->cnt == 0 */
> +               return cc;
> +       }
> +
> +       /* If candidate is not found in vmlinux's BTF then search in module's BTFs */
> +       spin_lock_bh(&btf_idr_lock);
> +       idr_for_each_entry(&btf_idr, mod_btf, id) {
> +               if (!btf_is_module(mod_btf))
> +                       continue;
> +               /* linear search could be slow hence unlock/lock
> +                * the IDR to avoiding holding it for too long
> +                */
> +               btf_get(mod_btf);
> +               spin_unlock_bh(&btf_idr_lock);
> +               cands = bpf_core_add_cands(cands, mod_btf, btf_nr_types(main_btf));
> +               if (IS_ERR(cands)) {
> +                       btf_put(mod_btf);
> +                       return cands;
> +               }
> +               spin_lock_bh(&btf_idr_lock);
> +               btf_put(mod_btf);

either need to additionally btf_get(mod_btf) inside
bpf_core_add_cands() not btf_put() it here if you added at least one
candidate, as you are storing targ_btf inside bpf_core_add_cands() and
dropping refcount might leave dangling pointer


> +       }
> +       spin_unlock_bh(&btf_idr_lock);
> +       /* populate cache even when cands->cnt == 0 */
> +       populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
> +       return cands;
> +}
> +
>  int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
>                    int relo_idx, void *insn)
>  {
> -       return -EOPNOTSUPP;
> +       struct bpf_core_cand_list cands = {};
> +       int err;
> +
> +       if (relo->kind != BPF_CORE_TYPE_ID_LOCAL) {
> +               struct bpf_cand_cache *cc;
> +               int i;
> +
> +               mutex_lock(&cand_cache_mutex);
> +               cc = bpf_core_find_cands(ctx, relo->type_id);
> +               if (IS_ERR(cc)) {
> +                       bpf_log(ctx->log, "target candidate search failed for %d\n",
> +                               relo->type_id);
> +                       return PTR_ERR(cc);
> +               }
> +               if (cc->cnt) {
> +                       cands.cands = kcalloc(cc->cnt, sizeof(*cands.cands), GFP_KERNEL);
> +                       if (!cands.cands)
> +                               return -ENOMEM;
> +               }
> +               for (i = 0; i < cc->cnt; i++) {
> +                       bpf_log(ctx->log,
> +                               "CO-RE relocating %s %s: found target candidate [%d]\n",
> +                               btf_kind_str[cc->kind], cc->name, cc->cands[i].id);
> +                       cands.cands[i].btf = cc->cands[i].btf;
> +                       cands.cands[i].id = cc->cands[i].id;
> +               }
> +               cands.len = cc->cnt;
> +               mutex_unlock(&cand_cache_mutex);
> +       }
> +

cache is not locked at this point, so those cands.cands[i].btf objects
might be freed now (if module got unloaded meanwhile), right?

This global sharing of that small cache seems to cause unnecessary
headaches, tbh. It adds global mutex (which might also block for
kcalloc). If you used that cache locally for processing single
bpf_prog, you wouldn't need the locking. It can probably also simplify
the refcounting, especially if you just btf_get(targ_btf) for each
candidate and then btf_put() it after all relos are processed. You are
also half-step away from removing the size restriction (just chain
bpf_cand_caches together) and having a fixed bucket-size hash with
non-fixed chain length (which probably would be totally fine for all
practical purposes).


> +       err = bpf_core_apply_relo_insn((void *)ctx->log, insn, relo->insn_off / 8,
> +                                      relo, relo_idx, ctx->btf, &cands);
> +       kfree(cands.cands);
> +       return err;
>  }
> diff --git a/tools/lib/bpf/relo_core.h b/tools/lib/bpf/relo_core.h
> index f410691cc4e5..f7b0d698978c 100644
> --- a/tools/lib/bpf/relo_core.h
> +++ b/tools/lib/bpf/relo_core.h
> @@ -8,8 +8,10 @@
>
>  struct bpf_core_cand {
>         const struct btf *btf;
> +#ifndef __KERNEL__
>         const struct btf_type *t;
>         const char *name;
> +#endif

why? doesn't seem to be used and both t and name could be derived from
btf and id

>         __u32 id;
>  };
>
> --
> 2.30.2
>
