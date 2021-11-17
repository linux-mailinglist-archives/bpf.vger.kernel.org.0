Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CCF454E1E
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 20:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbhKQTqJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 14:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhKQTqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 14:46:09 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C02CC061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:43:10 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id n2so6412641yba.2
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wi2ZXeAxl1Jrt+mW7451DwqL69lzKyqTqtVFaf6ioKo=;
        b=kNMsL4uDwWu33Wjr2sMuiysAIv66bug7yn9uvE8bSm6Ul/3uM+bRbdibsBRCvChObU
         FkBy1jXWRtdgQMThr9Eyj7EisliEdpGai3DcJbBtRHfYg5IUjZsIcoOxG9SlxLFZn247
         ehbPvd4gkL5/eWWNiCHKU2v0tLqv78zJZ5uyC//UQgGlC3vxThQcGHWjR9Qzwvv2EqHR
         AUe9uNkqyMEngkBE6rHVOfN5qaElIKRly9/SeWhv86gEREuquII+R4LmTnQUnWUHGrW5
         cN277/LdDNuAeodk+lxFm76JJoy7wo2Uk/foc5tL09NsLxLclLfUTHXAb45n7qiF6Drt
         GTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wi2ZXeAxl1Jrt+mW7451DwqL69lzKyqTqtVFaf6ioKo=;
        b=XVCBJ5Lx1QCL/puUN7QjWdGjJqilkYaNbIr6WUMOsYHKK343SoR62oH08LqEvC9FAF
         feoKilU08ffE4Jdccy/CUNTYG9ltlAtHPGc8/Qu4TpEy7qf0mgrIbF+JS+zarSwQgipO
         AsyYMHxGdh9830aE6HdbG1vUrW6w59ZXZAvunaD9Hp3o3zn6Wr4FM5BHIEbDKfzgAnPa
         fiB+QUwaqdOvjd95pOiH+2Ksxxpq3oAANpf2fXFmGayjwsiyEjsAqDaAN0ybVO5QPdPu
         vvS+uzHBM7TlGC40oa+aeHViqCb5J/jhSuwMm3Bt7NJ6LHpds2c/auPljDczLMJPT8tJ
         7IVQ==
X-Gm-Message-State: AOAM531nxYOC2+QKi4ueGiCjRoSp72iIEweOWffXNnVUipSRVcvDmbM7
        Xfjz16hB3WMrZIu76DDgYzUyQksjmKZybC0X/aY=
X-Google-Smtp-Source: ABdhPJwzT1wwZE4eMoyDLYV7nB37MaQUXVhcElGkAYdb21w3DnCOlTiIX4Wm6hH1F8OerUEZzuzHmoDgZYU4dsveVS0=
X-Received: by 2002:a25:d010:: with SMTP id h16mr22789265ybg.225.1637178189777;
 Wed, 17 Nov 2021 11:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20211117194114.347675-1-andrii@kernel.org>
In-Reply-To: <20211117194114.347675-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 17 Nov 2021 11:42:58 -0800
Message-ID: <CAEf4Bza2NSV8MBb0jSokmUcrzy0SpLvY2uqu4mG9ObxnT-jQLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: accommodate DWARF/compiler bug with
 duplicated structs
To:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 17, 2021 at 11:41 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> According to [0], compilers sometimes might produce duplicate DWARF
> definitions for exactly the same struct/union within the same
> compilation unit (CU). We've had similar issues with identical arrays
> and handled them with a similar workaround in 6b6e6b1d09aa ("libbpf:
> Accomodate DWARF/compiler bug with duplicated identical arrays"). Do the
> same for struct/union by ensuring that two structs/unions are exactly
> the same, down to the integer values of field referenced type IDs.

Jiri, can you please try this in your setup and see if that handles
all situations or there are more complicated ones still. We'll need a
test for more complicated ones in that case :( Thanks.

>
> Solving this more generically (allowing referenced types to be
> equivalent, but using different type IDs, all within a single CU)
> requires a huge complexity increase to handle many-to-many mappings
> between canonidal and candidate type graphs. Before we invest in that,
> let's see if this approach handles all the instances of this issue in
> practice. Thankfully it's pretty rare, it seems.
>
>   [0] https://lore.kernel.org/bpf/YXr2NFlJTAhHdZqq@krava/
>
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b6be579e0dc6..e97217a77196 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3477,8 +3477,8 @@ static long btf_hash_struct(struct btf_type *t)
>  }
>
>  /*
> - * Check structural compatibility of two FUNC_PROTOs, ignoring referenced type
> - * IDs. This check is performed during type graph equivalence check and
> + * Check structural compatibility of two STRUCTs/UNIONs, ignoring referenced
> + * type IDs. This check is performed during type graph equivalence check and
>   * referenced types equivalence is checked separately.
>   */
>  static bool btf_shallow_equal_struct(struct btf_type *t1, struct btf_type *t2)
> @@ -3851,6 +3851,31 @@ static int btf_dedup_identical_arrays(struct btf_dedup *d, __u32 id1, __u32 id2)
>         return btf_equal_array(t1, t2);
>  }
>
> +/* Check if given two types are identical STRUCT/UNION definitions */
> +static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id2)
> +{
> +       const struct btf_member *m1, *m2;
> +       struct btf_type *t1, *t2;
> +       int n, i;
> +
> +       t1 = btf_type_by_id(d->btf, id1);
> +       t2 = btf_type_by_id(d->btf, id2);
> +
> +       if (!btf_is_composite(t1) || btf_kind(t1) != btf_kind(t2))
> +               return false;
> +
> +       if (!btf_shallow_equal_struct(t1, t2))
> +               return false;
> +
> +       m1 = btf_members(t1);
> +       m2 = btf_members(t2);
> +       for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> +               if (m1->type != m2->type)
> +                       return false;
> +       }
> +       return true;
> +}
> +
>  /*
>   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
>   * call it "candidate graph" in this description for brevity) to a type graph
> @@ -3962,6 +3987,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>
>         hypot_type_id = d->hypot_map[canon_id];
>         if (hypot_type_id <= BTF_MAX_NR_TYPES) {
> +               if (hypot_type_id == cand_id)
> +                       return 1;
>                 /* In some cases compiler will generate different DWARF types
>                  * for *identical* array type definitions and use them for
>                  * different fields within the *same* struct. This breaks type
> @@ -3970,8 +3997,18 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>                  * types within a single CU. So work around that by explicitly
>                  * allowing identical array types here.
>                  */
> -               return hypot_type_id == cand_id ||
> -                      btf_dedup_identical_arrays(d, hypot_type_id, cand_id);
> +               if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
> +                       return 1;
> +               /* It turns out that similar situation can happen with
> +                * struct/union sometimes, sigh... Handle the case where
> +                * structs/unions are exactly the same, down to the referenced
> +                * type IDs. Anything more complicated (e.g., if referenced
> +                * types are different, but equivalent) is *way more*
> +                * complicated and requires a many-to-many equivalence mapping.
> +                */
> +               if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
> +                       return 1;
> +               return 0;
>         }
>
>         if (btf_dedup_hypot_map_add(d, canon_id, cand_id))
> --
> 2.30.2
>
