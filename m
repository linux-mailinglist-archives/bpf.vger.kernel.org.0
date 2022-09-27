Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CB35ECF1C
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 23:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiI0VGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 17:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiI0VGj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 17:06:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631391BCAFC
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 14:06:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u24so126184edb.11
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rin0PC6CBiwCDJ51TXvR5XtoBp9eNsj8u50k57d1sdo=;
        b=hOKorklHbpr90aUwaHo+wO/PkngYeBoRN3lptlJL69OuLDx3EI8awCMcID5G/O7l0B
         IAp2S0TR7rnE0IPj32uca5V1IxQR4R7iiGPT5/t3QEa49yj3HJX63BE+CaDlFjfliHfY
         b2+H3CHEk/VpHSaQb40KmPWcOfcVuAVuM7sooSui4Y3IzvWyPodPffE2l4kTzwCp7Au6
         nQU6e0U8DmB+t40lX0pbP7WFgiQrw+WZVGMbIZ8GZPkAcVsE8LmwtolSWdh/zXXD1FyJ
         +fy2yPA1jSwlzgYHEyAWOXxWDQ8Um38sRTIEcU+yVOlDMTt7XiOs03FKdXv3bp6eB4Uw
         iDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rin0PC6CBiwCDJ51TXvR5XtoBp9eNsj8u50k57d1sdo=;
        b=TYS+7ooVF5tPwerVtF4wW6/1oQEm8fPnyVxgiW2sK/eosJ6Kqyd2MxgGyMwSSuVG/D
         fl/N5QbH4Bkwl9c58hVne/g9X6JWBNKGboy2ABnZ8hoLMeD4QWha1JaCxP9eY/aSWTH0
         D3rX221VqkaGSZyYOBcJJvvA9dcz3zISdJ+ZqQNp/8G1NASmHrfkD79iZ47blHTebrwE
         7ZAz/4P+hGxB1K561Nlx0/hUc5AyyJq63dmXZB1PA7fM4aNIWONXB4zAxPCUbgJBo9b5
         czcXVEnG/Rs6DaKP5NZOeBrGxTbBLJziE6rYOLu/GszstILvmtBmC+emxAlG4FnwuPZp
         7NCQ==
X-Gm-Message-State: ACrzQf3H2Q0RWnRIrqjfQjALydmzhXw8hRI3V7RGgwLLIpejC3h7XpEU
        BAEPj9sG/SvJHjKRlVXPDKl4DWNSHSHQVk9tO91M6daxaLg=
X-Google-Smtp-Source: AMsMyM7i05AYWzzNJMkR6Csz6qMy8h57E+gZwoLqqcqbuaVJAw8qhJ03ZP45lW8EGBuQQlAe6393kcZ40Ih373xtO4A=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr29908523edb.333.1664312795221; Tue, 27
 Sep 2022 14:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <1664292894-21490-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1664292894-21490-1-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Sep 2022 14:06:22 -0700
Message-ID: <CAEf4BzYfU0ajPAHrvJQW+ggFaQ4Ut3eVs6rLjbnjcPwDtEQv6A@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix BTF deduplication for self-referential structs
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
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

On Tue, Sep 27, 2022 at 8:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> BTF deduplication is not deduplicating some structures, leading to
> redundant definitions in module BTF that already have identical
> definitions in vmlinux BTF.
>
> When examining module BTF, we can see that "struct sk_buff" is redefined
> in module BTF. For example in module nf_reject_ipv4 we see:
>
> [114280] STRUCT 'sk_buff' size=232 vlen=28
>         '(anon)' type_id=114463 bits_offset=0
>         '(anon)' type_id=114464 bits_offset=192
>         ...
>
> The rest of the fields point back at base vmlinux type ids.
>
> The first anon field in an sk_buff is:
>
>         union {
>                 struct {
>                         struct sk_buff * next;           /*     0     8 */
>                         struct sk_buff * prev;           /*     8     8 */
>                         union {
>                                 struct net_device * dev; /*    16     8 */
>                                 long unsigned int dev_scratch; /*    16     8 */
>                         };                               /*    16     8 */
>                 };
>
> ..and examining its BTF representation, we see
>
> [114463] UNION '(anon)' size=24 vlen=4
>         '(anon)' type_id=114462 bits_offset=0
>         'rbnode' type_id=517 bits_offset=0
>         'list' type_id=83 bits_offset=0
>         'll_node' type_id=443 bits_offset=0
>
> ...which leads us to
>
> [114462] STRUCT '(anon)' size=24 vlen=3
>         'next' type_id=114279 bits_offset=0
>         'prev' type_id=114279 bits_offset=64
>         '(anon)' type_id=114461 bits_offset=128
>
> ...finally getting back to the sk_buff:
>
> [114279] PTR '(anon)' type_id=114280
>
> So perhaps self-referential structures are a problem for
> deduplication?
>
> The second union with a non-base BTF id:
>
>         union {
>                 struct sock *      sk;                   /*    24     8 */
>                 int                ip_defrag_offset;     /*    24     4 */
>         };
>
> ...points at
>
> [114464] UNION '(anon)' size=8 vlen=2
>         'sk' type_id=113826 bits_offset=0
>         ...
>
> [113826] PTR '(anon)' type_id=113827
>
> [113827] STRUCT 'sock' size=776 vlen=93
>         ...
>         'sk_error_queue' type_id=114458 bits_offset=1536
>         'sk_receive_queue' type_id=114458 bits_offset=1728
>         ...
>         'sk_write_queue' type_id=114458 bits_offset=2880
>         ...
>         'sk_socket' type_id=114295 bits_offset=4992
>         ...
>         'sk_memcg' type_id=113787 bits_offset=5312
>         'sk_state_change' type_id=114758 bits_offset=5376
>         'sk_data_ready' type_id=114758 bits_offset=5440
>         'sk_write_space' type_id=114758 bits_offset=5504
>         'sk_error_report' type_id=114758 bits_offset=5568
>         'sk_backlog_rcv' type_id=114292 bits_offset=5632
>         'sk_validate_xmit_skb' type_id=114760 bits_offset=5696
>         'sk_destruct' type_id=114758 bits_offset=5760
>
> Again, sk_error_queue refers to a 'struct sk_buff_head':
>
> [114458] STRUCT 'sk_buff_head' size=24 vlen=3
>         '(anon)' type_id=114457 bits_offset=0
>         'qlen' type_id=23 bits_offset=128
>         'lock' type_id=514 bits_offset=160
>
> ...which, because it contains a struct sk_buff * reference
> uses the not-deduped sk_buff above.
>
> [114455] STRUCT '(anon)' size=16 vlen=2
>         'next' type_id=114279 bits_offset=0
>         'prev' type_id=114279 bits_offset=64
>
> Ditto for sk_receive_queue, sk_write_queue, etc.
>
> sk_memcg refers to a non-deduped struct mem_cgroup where
> only one field is not in base BTF:
>
> [113786] STRUCT 'mem_cgroup' size=4288 vlen=46
> ...
>         'move_lock_task' type_id=113694 bits_offset=31296
> ...
>
> and this is a pointer to task_struct:
>
> [113694] PTR '(anon)' type_id=113695
>
> [113695] STRUCT 'task_struct' size=9792 vlen=253
> ...
>                 'last_wakee' type_id=113694 bits_offset=704
> ...
>
> ...so we see that the self-referential members cause problems here
> too.
>
> Looking at the code, btf_dedup_is_equiv() will check equivalence
> for all member types for BTF_KIND_[STRUCT|UNION]. How will such
> an equivalence check function for a pointer back to the same
> structure?
>
> With a struct, btf_dedup_struct_type() is called, and for each
> candidate (hashed by name offset, member details but not type
> ids), we clear the hypot_map (mapping hyothetical type
> equivalences) and add a hypot_map entry mapping from the
> canon_id -> cand_id in btf_dedup_is_equiv() once it looks
> like a rough match.
>
> when we delve into its members we recurse into reference types
> so should ultimately use that mapping to notice self-referential
> struct equivalence.
>
> However looking closely, btf_dedup_is_equiv() is being called from
> btf_dedup_struct_type() with arguments in the wrong order:
>
>         eq = btf_dedup_is_equiv(d, type_id, cand_id);
>
> The candidate id should I think precede the type_id, as we see in
> function signature:
>
> static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>                               __u32 canon_id)
>
> ...and with this change the duplication disappears in the modules.
>
> Fixes: d5caef5b56555bfa2ac0 ("btf: add BTF types deduplication algorithm")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index b4d9a96..a4ee15c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4329,7 +4329,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
>                         continue;
>
>                 btf_dedup_clear_hypot_map(d);
> -               eq = btf_dedup_is_equiv(d, type_id, cand_id);
> +               eq = btf_dedup_is_equiv(d, cand_id, type_id);

Unfortunately this is not the right fix (and CI points this out, e.g.,
at [0]; so yay tests). You got confused by candidate terminology. In
btf_dedup_struct_type we iterate over candidate types that could be
canonical types. So what is cand_id is meant to be canonical for type
identified by type_id. And type_id is pointing to a candidate type as
far as an equivalence check goes (that is btf_dedup_is_equiv()). It's
somewhat confusing, but really type_id is a candidate we are trying to
dedup and cand_id is a *potential* canonical type (there could be
multiple potential canonical types due to hash collisions).

So there might be a bug with dedup, but it's somewhere else.

  [0] https://github.com/kernel-patches/bpf/actions/runs/3137048529/jobs/5095008504

>                 if (eq < 0)
>                         return eq;
>                 if (!eq)
> --
> 1.8.3.1
>
