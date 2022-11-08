Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50A7622054
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 00:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKHX36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 18:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKHX35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 18:29:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B5BF63
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 15:29:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u24so24770787edd.13
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6tMRttlR880k80IwgeMte2u0WeUqoX/EvYZokL5JRgA=;
        b=QB0vCjWrWaqUUGHvoWw0Kmeb/DKw4zi7FVZkVob0v10jQo6zMDzMyMwCa+qj8aWegI
         rsT1wa0Bhg1OF+0J5W9Hc2VBRdN1MSK39DWEIU8jAiPbID2tZO4QrqmZ7qNDAwkdz1VE
         fhuME7r36lY5fY1LhdMZhCWeSf1P2U5rRXEjJ/QhtPWoICITrim4PRcXeaggQidbnq4g
         8bWb8aarrR4sHmvU4d03Sm6b0o7dluk7rpCarr2EXh8QND7yK8y9ooO9oRPm8+AmMPyj
         8dcorK9mJjbqjwITxqtoZFDx2c7z/7ysizvVaNLpATuRJiLk/7+vAHWG9Q/PupCO4nPG
         nRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tMRttlR880k80IwgeMte2u0WeUqoX/EvYZokL5JRgA=;
        b=JUqR/qo5OzKiCkwGwl0TahMCjpZczRkEqe2DA9eVBRN6s2+O819xhYu7cqQbbF1lPX
         FYix7mjqPDts8MZfgbfSgb165MzC46O4ywY4t1BFReJoZLR44ZI+xDuHCRnJGgUIxRQ2
         ugk2b68uCSYBAOqJm5Y2Pi17wFdFAo+xngkHWZZHE6jTkP0hv/CRxEeaKOMm3CaHt1A6
         KDdxP4gSiUm+csLrPLztFBHGyUwRT8Tpqaz/sPCkbQG+ypdyo4gmcjowq6Wj21oXD3qY
         CBYIJxUkffqVwPpEI64UR/FmcOYqiUZ90g9NAbQl074rBppkGzYUJ1bE+8EA2CFgadpp
         iu0g==
X-Gm-Message-State: ACrzQf0sgglNPZIwMuXZh140/mG4ahzHEnmyf2uMfy/DRDabQHdvbNRG
        jhkZiOhdiVrXRxKk1ofVnbPHU02pQI1MBsCH/wg=
X-Google-Smtp-Source: AMsMyM5Ys1syQuVh1px2kXgOhNb+yWla5qC3ELbIDl9sxqselYwxOuQHUKB8Va7OImofueH/C83IeCo4YWI4sp8Lbdo=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr58925755edq.14.1667950193952; Tue, 08
 Nov 2022 15:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-7-memxor@gmail.com>
In-Reply-To: <20221107230950.7117-7-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Nov 2022 15:29:41 -0800
Message-ID: <CAEf4BzZRaN_zd07jvtom6QJEEDGmFQTLJy4BM1bKi1MH5+n5QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/25] bpf: Introduce local kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> program BTF. This is indicated by the presence of MEM_ALLOC type flag in
> reg->type to avoid having to check btf_is_kernel when trying to match
> argument types in helpers.
>
> Refactor btf_struct_access callback to just take bpf_reg_state instead
> of btf and btf_type paramters. Note that the call site in
> check_map_access now simulates access to a PTR_TO_BTF_ID by creating a
> dummy reg on stack. Since only the type, btf, and btf_id of the register
> matter for the checks, it can be done so without complicating the usual
> cases elsewhere in the verifier where reg->btf and reg->btf_id is used
> verbatim.
>
> Whenever walking such types, any pointers being walked will always yield
> a SCALAR instead of pointer. In the future we might permit kptr inside
> local kptr (either kernel or local), and it would be permitted only in
> that case.
>
> For now, these local kptrs will always be referenced in verifier
> context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> to such objects, as long fields that are special are not touched
> (support for which will be added in subsequent patches). Note that once
> such a local kptr is marked PTR_UNTRUSTED, it is no longer allowed to
> write to it.
>
> No PROBE_MEM handling is therefore done for loads into this type unless
> PTR_UNTRUSTED is part of the register type, since they can never be in
> an undefined state, and their lifetime will always be valid.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h              | 28 ++++++++++++++++--------
>  include/linux/filter.h           |  8 +++----
>  kernel/bpf/btf.c                 | 16 ++++++++++----
>  kernel/bpf/verifier.c            | 37 ++++++++++++++++++++++++++------
>  net/bpf/bpf_dummy_struct_ops.c   | 14 ++++++------
>  net/core/filter.c                | 34 ++++++++++++-----------------
>  net/ipv4/bpf_tcp_ca.c            | 13 ++++++-----
>  net/netfilter/nf_conntrack_bpf.c | 17 ++++++---------
>  8 files changed, 99 insertions(+), 68 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index afc1c51b59ff..75dbd2ecf80a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -524,6 +524,11 @@ enum bpf_type_flag {
>         /* Size is known at compile time. */
>         MEM_FIXED_SIZE          = BIT(10 + BPF_BASE_TYPE_BITS),
>
> +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> +        * tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> +        */
> +       MEM_ALLOC               = BIT(11 + BPF_BASE_TYPE_BITS),
> +

you fixed one naming confusion with RINGBUF and basically are creating
a new one, where "ALLOC" means "local kptr"... If we are stuck with
"local kptr" (which I find very confusing as well, but that's beside
the point), why not stick to the whole "local" terminology here?
MEM_LOCAL?

>         __BPF_TYPE_FLAG_MAX,
>         __BPF_TYPE_LAST_FLAG    = __BPF_TYPE_FLAG_MAX - 1,
>  };
> @@ -771,6 +776,7 @@ struct bpf_prog_ops {
>                         union bpf_attr __user *uattr);
>  };
>

[...]

> -int btf_struct_access(struct bpf_verifier_log *log, const struct btf *btf,
> -                     const struct btf_type *t, int off, int size,
> -                     enum bpf_access_type atype __maybe_unused,
> +int btf_struct_access(struct bpf_verifier_log *log,
> +                     const struct bpf_reg_state *reg,
> +                     int off, int size, enum bpf_access_type atype __maybe_unused,
>                       u32 *next_btf_id, enum bpf_type_flag *flag)
>  {
> +       const struct btf *btf = reg->btf;
>         enum bpf_type_flag tmp_flag = 0;
> +       const struct btf_type *t;
> +       u32 id = reg->btf_id;
>         int err;
> -       u32 id;
>
> +       t = btf_type_by_id(btf, id);
>         do {
>                 err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag);
>
>                 switch (err) {
>                 case WALK_PTR:
> +                       /* For local types, the destination register cannot
> +                        * become a pointer again.
> +                        */
> +                       if (type_is_local_kptr(reg->type))
> +                               return SCALAR_VALUE;

passing the entire bpf_reg_state just to differentiate between local
vs kernel pointer seems like a huge overkill. bpf_reg_state is quite a
complicated and extensive amount of state, and it seems cleaner to
just pass it as a flag whether to allow pointer chasing or not. At
least then we know we only care about that specific aspect, not about
dozens of other possible fields of bpf_reg_state.


>                         /* If we found the pointer or scalar on t+off,
>                          * we're done.
>                          */

[...]
