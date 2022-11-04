Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C076261A030
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 19:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiKDSmZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 14:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiKDSmQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 14:42:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16B41995
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 11:42:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n12so15470225eja.11
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RT+Qd1ObW4o+XeJSHqGJUz8gFH7LsChhLbQVi31XESE=;
        b=QtUak57pW8BIaAE6AMcchhg6GBei/KfvXv5xgtTzlxW+qw1jWs42GLqz0DL7ZwYY3k
         8PXnco7Thz0Ir40khtsA+RlY/zY01ffBeBCwIj3xBwqf8y6Aw/3iZt2QXgDIrvanFxTc
         6ef6AFyhxAZVeItQrL3uYwqydnvmzFKJEDzB5WJy504do7n9snZInthx3KnAIwWFoJC+
         jHHJgRkBQldswMGBBGrDKkY2YZOv1yfrGdX9iM0FZAm7rebkORdQA9u7wBlFBD0VM2Dy
         DXFmMUuq47daRVD6SGW1uMD0BW/UYYwcS15+nYaHjStd9duhrlkixkJdkJbBhvU7K61t
         2x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT+Qd1ObW4o+XeJSHqGJUz8gFH7LsChhLbQVi31XESE=;
        b=AGnUp/ddQPHiVnbVoIp9r6M5gGvq/XE+01IKRrmhXJi9Y/VIT08uaf+Ac1CtEtSCJ8
         42S4rzCXqli+XcNYChAAiLTYxABfziHkbN456i+ox5gJAtyvg6mVtTsqibqg4wTlWc4O
         L33Ks/Bbd1s+EI3GHeLehFXhrJLG/93ErAX4fR+dfCxVxf6SUgxikEN/Ray3Nnz+S3qx
         EE3ku/o26RbRAUcpWrFredsiXbmyOGKTNUek2+56sObwL4QJ03a4xu6xPu09GOgwhvXJ
         8Yu5NmL7oAEfgyLLk4B9z9EksTIApEGxSilWSpIgTnlh/BHg+BstCyYa89kvQbf6uMsT
         M01w==
X-Gm-Message-State: ACrzQf16M2Z5lcvKneB+3TtqRaFZvin1CpLBduiBmeAzXEhg16Ovs/CC
        hgvadSh+rVjau1mHQ3VR+IBzBjUdLBJwGDIxpM8=
X-Google-Smtp-Source: AMsMyM5yGyj0JnS60soHMnKJewZ6bt+kTqftZXnZ5py0hlm7CsOv8Rmh62eoILUn+DT3v08sYKFPtYy54otmC2DVNTw=
X-Received: by 2002:a17:907:8a24:b0:795:bb7d:643b with SMTP id
 sc36-20020a1709078a2400b00795bb7d643bmr36621489ejc.115.1667587325265; Fri, 04
 Nov 2022 11:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221103033430.2611623-1-eddyz87@gmail.com> <20221103033430.2611623-2-eddyz87@gmail.com>
In-Reply-To: <20221103033430.2611623-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 11:41:53 -0700
Message-ID: <CAEf4BzYDuixeeFxVOntJWkCh_owZnMyVdAUSFLX3_Zf=VrtjEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: hashmap interface update to
 uintptr_t -> uintptr_t
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        alan.maguire@oracle.com
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

On Wed, Nov 2, 2022 at 8:35 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> An update for libbpf's hashmap interface from void* -> void* to
> uintptr_t -> uintptr_t. Removes / simplifies some type casts when
> hashmap keys or values are 32-bit integers. In libbpf hashmap is more
> often used with integral keys / values rather than with pointer keys /
> values.
>
> This is a follow up for [1].
>
> [1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

I think this is a pretty clear win. Keys are almost always (if not
always) integers, so this is very natural. And pointer values are
relatively infrequent and casts there look quite clean anyways (there
was a place where you were casting to some long-named struct, in C we
can cast to void * and rely on compiler to coalesce pointer types, so
even such casts can be short).

But you forgot to update perf, so it's build is badly broken with
these changes, please convert perf as well. Also cc Arnaldo
(acme@kernel.org) on this patch set, please.

>  tools/bpf/bpftool/btf.c    | 23 ++++++++------------
>  tools/bpf/bpftool/common.c | 10 ++++-----
>  tools/bpf/bpftool/gen.c    | 19 +++++++----------
>  tools/bpf/bpftool/link.c   |  8 +++----
>  tools/bpf/bpftool/main.h   |  4 ++--
>  tools/bpf/bpftool/map.c    |  8 +++----
>  tools/bpf/bpftool/pids.c   | 16 +++++++-------
>  tools/bpf/bpftool/prog.c   |  8 +++----
>  tools/lib/bpf/btf.c        | 43 +++++++++++++++++++-------------------
>  tools/lib/bpf/btf_dump.c   | 16 +++++++-------
>  tools/lib/bpf/hashmap.c    | 16 +++++++-------
>  tools/lib/bpf/hashmap.h    | 35 ++++++++++++++++---------------
>  tools/lib/bpf/libbpf.c     | 18 ++++++----------
>  tools/lib/bpf/strset.c     | 24 ++++++++++-----------
>  tools/lib/bpf/usdt.c       | 31 +++++++++++++--------------
>  15 files changed, 127 insertions(+), 152 deletions(-)
>
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 68a70ac03c80..ccb3b8b0378b 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -815,8 +815,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
>                 if (!btf_id)
>                         continue;
>
> -               err = hashmap__append(tab, u32_as_hash_field(btf_id),
> -                                     u32_as_hash_field(id));
> +               err = hashmap__append(tab, btf_id, id);
>                 if (err) {
>                         p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
>                               btf_id, id, strerror(-err));
> @@ -875,17 +874,15 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
>         printf("size %uB", info->btf_size);
>
>         n = 0;
> -       hashmap__for_each_key_entry(btf_prog_table, entry,
> -                                   u32_as_hash_field(info->id)) {
> +       hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
>                 printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
> -                      hash_field_as_u32(entry->value));
> +                      (__u32)entry->value);

so if we make key/value as long, we won't need such casts, we can just
do %lu in printfs

I still prefer long vs uintptr_t, and this is one reason for this. I
don't understand how uintptr_t simplifies anything with 32-bit
integers as uintptr_t is 64-bit on 64-architecture, so you'd still
have to handle 32-to-64 conversions.

If you are worried about unsigned vs signed conversions, I don't think
it's a problem:

$ cat t.c
#include <stdio.h>

int main(){
        int x = -2;
        int lx = (long)x;
        int xx = (int)lx;
        unsigned ux = 3000000000;
        long ulx = (long)ux;
        unsigned ulxx = (unsigned)ulx;

        printf("%d %x %ld %lx %d %x\n", x, x, lx, lx, xx, xx);
        printf("%u %x %ld %lx %u %x\n", ux, ux, ulx, ulx, ulxx, ulxx);
}
$ cc t.c
$ ./a.out
-2 fffffffe 4294967294 fffffffe -2 fffffffe
3000000000 b2d05e00 3000000000 b2d05e00 3000000000 b2d05e00


So please clarify what won't work.

>         }
>
>         n = 0;
> -       hashmap__for_each_key_entry(btf_map_table, entry,
> -                                   u32_as_hash_field(info->id)) {
> +       hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
>                 printf("%s%u", n++ == 0 ? "  map_ids " : ",",
> -                      hash_field_as_u32(entry->value));
> +                      (__u32)entry->value);
>         }
>
>         emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");

[...]
