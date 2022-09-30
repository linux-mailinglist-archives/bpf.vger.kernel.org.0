Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176015F14AF
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiI3VYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiI3VYI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:24:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E12A1C2F84
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:24:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dv25so11524129ejb.12
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUJLe7dvdWZXjzQ3C9TAKtBkBk/We8TEPoorzoujsKI=;
        b=BrRY4SNJuK2+JX0/VCkb4TusF8ygGLY/jyDzecy9fRtz1dHR5mDtRvpCkLpBlD7fu8
         nm8C+mHONhS9qz0EtOWKAQaxW8UI2hNgX0NCMjgrVePgUGOomPKlgxRPmZFxLujqZS+B
         EMiUgbTtDa+ZqOqcCG9E6TQvOm4wz8a1BmYjOpAJBDWtjQSct7/3ArcR0wcP7Ir60Tts
         5rcpb3iYunPrcwus9nP1NFawzNBLkMfGJxYjk7Tn0XClDnlWH4UxsKaZAVpqWAxbi8Tm
         HlPcXM9vG4Kh8ulfzyVDfOHE8hvtfhS+sJTuhiT7a+NNF8uwFrzQhlRSPZhTapuwBkf0
         qxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUJLe7dvdWZXjzQ3C9TAKtBkBk/We8TEPoorzoujsKI=;
        b=eFYz3Nq0Zakc7NGDmpi1zRXX83Ihbzc7aElk+WvRAvKJ3EV1eUPZYHJDTOkJyj1QsB
         nkSoTl2s6pJQw+A/tt08x5/gQbohEaRoeFKSWRk3pAWmKW3biI40ZkzFGQRAPlHV4z+q
         AQbsvpIf69wguzz/1tKUHwDtFO+qguduCUwUhtam3O7z5E91825yHCQpVuOKwzDdiANl
         NA0KHPkZOP7oca+aWAca3m0c4L8Q56P/CNNaUENufpHiANCZAJ5W777g7pBJK+/Mc7B4
         k6XcjDAry91NDTEyD+N+tG+GEeyHWnbXL7/y68cC4uX+Srn6Ib/+MaYEo/27wctyhVco
         xLAg==
X-Gm-Message-State: ACrzQf1/uLco+HsptveshNWCg8VpTYxAvBYNN9QsGKEe3TJxWer/YH40
        gyrJLUzG1UCzhnSMnKyfzk0qG31oCaMZkQeL5bc=
X-Google-Smtp-Source: AMsMyM4WA7Kc4nAK278BzI0POtNnrYovPc0lYk69OFKJ2Nt6FZd0rWWsCjE/udIcwuIFjXTug41Yb//IFpD2xhN3hGE=
X-Received: by 2002:a17:907:3fa9:b0:782:ed33:df8d with SMTP id
 hr41-20020a1709073fa900b00782ed33df8dmr7759836ejc.745.1664573044644; Fri, 30
 Sep 2022 14:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <1664292894-21490-1-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzYfU0ajPAHrvJQW+ggFaQ4Ut3eVs6rLjbnjcPwDtEQv6A@mail.gmail.com> <02af4666-22a9-2d26-8ec9-9bdb1a4d141f@oracle.com>
In-Reply-To: <02af4666-22a9-2d26-8ec9-9bdb1a4d141f@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 14:23:52 -0700
Message-ID: <CAEf4BzYsTNi4bn8Cq62eML9t=nXPmqs4zcXNJBvCO1eL2aXKeA@mail.gmail.com>
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

On Wed, Sep 28, 2022 at 7:06 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 27/09/2022 22:06, Andrii Nakryiko wrote:
> > On Tue, Sep 27, 2022 at 8:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>
> >> BTF deduplication is not deduplicating some structures, leading to
> >> redundant definitions in module BTF that already have identical
> >> definitions in vmlinux BTF.
> >>
> >> When examining module BTF, we can see that "struct sk_buff" is redefined
> >> in module BTF. For example in module nf_reject_ipv4 we see:
> >>
> >> [114280] STRUCT 'sk_buff' size=232 vlen=28
> >>         '(anon)' type_id=114463 bits_offset=0
> >>         '(anon)' type_id=114464 bits_offset=192
> >>         ...
> >>
> >> The rest of the fields point back at base vmlinux type ids.
> >>
> >> The first anon field in an sk_buff is:
> >>
> >>         union {
> >>                 struct {
> >>                         struct sk_buff * next;           /*     0     8 */
> >>                         struct sk_buff * prev;           /*     8     8 */
> >>                         union {
> >>                                 struct net_device * dev; /*    16     8 */
> >>                                 long unsigned int dev_scratch; /*    16     8 */
> >>                         };                               /*    16     8 */
> >>                 };
> >>
> >> ..and examining its BTF representation, we see
> >>
> >> [114463] UNION '(anon)' size=24 vlen=4
> >>         '(anon)' type_id=114462 bits_offset=0
> >>         'rbnode' type_id=517 bits_offset=0
> >>         'list' type_id=83 bits_offset=0
> >>         'll_node' type_id=443 bits_offset=0
> >>
> >> ...which leads us to
> >>
> >> [114462] STRUCT '(anon)' size=24 vlen=3
> >>         'next' type_id=114279 bits_offset=0
> >>         'prev' type_id=114279 bits_offset=64
> >>         '(anon)' type_id=114461 bits_offset=128
> >>
> >> ...finally getting back to the sk_buff:
> >>
> >> [114279] PTR '(anon)' type_id=114280
> >>
> >> So perhaps self-referential structures are a problem for
> >> deduplication?
> >>
> >> The second union with a non-base BTF id:
> >>
> >>         union {
> >>                 struct sock *      sk;                   /*    24     8 */
> >>                 int                ip_defrag_offset;     /*    24     4 */
> >>         };
> >>
> >> ...points at
> >>
> >> [114464] UNION '(anon)' size=8 vlen=2
> >>         'sk' type_id=113826 bits_offset=0
> >>         ...
> >>
> >> [113826] PTR '(anon)' type_id=113827
> >>
> >> [113827] STRUCT 'sock' size=776 vlen=93
> >>         ...
> >>         'sk_error_queue' type_id=114458 bits_offset=1536
> >>         'sk_receive_queue' type_id=114458 bits_offset=1728
> >>         ...
> >>         'sk_write_queue' type_id=114458 bits_offset=2880
> >>         ...
> >>         'sk_socket' type_id=114295 bits_offset=4992
> >>         ...
> >>         'sk_memcg' type_id=113787 bits_offset=5312
> >>         'sk_state_change' type_id=114758 bits_offset=5376
> >>         'sk_data_ready' type_id=114758 bits_offset=5440
> >>         'sk_write_space' type_id=114758 bits_offset=5504
> >>         'sk_error_report' type_id=114758 bits_offset=5568
> >>         'sk_backlog_rcv' type_id=114292 bits_offset=5632
> >>         'sk_validate_xmit_skb' type_id=114760 bits_offset=5696
> >>         'sk_destruct' type_id=114758 bits_offset=5760
> >>
> >> Again, sk_error_queue refers to a 'struct sk_buff_head':
> >>
> >> [114458] STRUCT 'sk_buff_head' size=24 vlen=3
> >>         '(anon)' type_id=114457 bits_offset=0
> >>         'qlen' type_id=23 bits_offset=128
> >>         'lock' type_id=514 bits_offset=160
> >>
> >> ...which, because it contains a struct sk_buff * reference
> >> uses the not-deduped sk_buff above.
> >>
> >> [114455] STRUCT '(anon)' size=16 vlen=2
> >>         'next' type_id=114279 bits_offset=0
> >>         'prev' type_id=114279 bits_offset=64
> >>
> >> Ditto for sk_receive_queue, sk_write_queue, etc.
> >>
> >> sk_memcg refers to a non-deduped struct mem_cgroup where
> >> only one field is not in base BTF:
> >>
> >> [113786] STRUCT 'mem_cgroup' size=4288 vlen=46
> >> ...
> >>         'move_lock_task' type_id=113694 bits_offset=31296
> >> ...
> >>
> >> and this is a pointer to task_struct:
> >>
> >> [113694] PTR '(anon)' type_id=113695
> >>
> >> [113695] STRUCT 'task_struct' size=9792 vlen=253
> >> ...
> >>                 'last_wakee' type_id=113694 bits_offset=704
> >> ...
> >>
> >> ...so we see that the self-referential members cause problems here
> >> too.
> >>
> >> Looking at the code, btf_dedup_is_equiv() will check equivalence
> >> for all member types for BTF_KIND_[STRUCT|UNION]. How will such
> >> an equivalence check function for a pointer back to the same
> >> structure?
> >>
> >> With a struct, btf_dedup_struct_type() is called, and for each
> >> candidate (hashed by name offset, member details but not type
> >> ids), we clear the hypot_map (mapping hyothetical type
> >> equivalences) and add a hypot_map entry mapping from the
> >> canon_id -> cand_id in btf_dedup_is_equiv() once it looks
> >> like a rough match.
> >>
> >> when we delve into its members we recurse into reference types
> >> so should ultimately use that mapping to notice self-referential
> >> struct equivalence.
> >>
> >> However looking closely, btf_dedup_is_equiv() is being called from
> >> btf_dedup_struct_type() with arguments in the wrong order:
> >>
> >>         eq = btf_dedup_is_equiv(d, type_id, cand_id);
> >>
> >> The candidate id should I think precede the type_id, as we see in
> >> function signature:
> >>
> >> static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> >>                               __u32 canon_id)
> >>
> >> ...and with this change the duplication disappears in the modules.
> >>
> >> Fixes: d5caef5b56555bfa2ac0 ("btf: add BTF types deduplication algorithm")
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index b4d9a96..a4ee15c 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -4329,7 +4329,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
> >>                         continue;
> >>
> >>                 btf_dedup_clear_hypot_map(d);
> >> -               eq = btf_dedup_is_equiv(d, type_id, cand_id);
> >> +               eq = btf_dedup_is_equiv(d, cand_id, type_id);
> >
> > Unfortunately this is not the right fix (and CI points this out, e.g.,
> > at [0]; so yay tests). You got confused by candidate terminology. In
> > btf_dedup_struct_type we iterate over candidate types that could be
> > canonical types. So what is cand_id is meant to be canonical for type
> > identified by type_id. And type_id is pointing to a candidate type as
> > far as an equivalence check goes (that is btf_dedup_is_equiv()). It's
>
> Ok, I _think_ I understand. So the cand_id arg to btf_dedup_is_equiv() is
> the one we hope will - through deduplication with canon_id - get eliminated.
> So here's my point of confusion then - when we do the hypothetical map lookup,
> why don't we do it using cand_id?
>
> I'd assumed the idea was the hypot_map could be used to map candidate
> types to the suspected canonical type, i.e. "we think this candidate
> type will dedup to this canonical one". The code semes to use the
> opposite mapping, getting a hyptothetical type id from the canonical type,
> for comparison with the candidate. I can't figure out how this helps
> deduplication yet though, would you mind explaining this?

I can only suggest looking at [0]. It's a very subtle thing, if I
didn't explain it well in [0], right now I won't be able to do it
better for sure. The specific equivalence mapping direction wasn't
arbitrary. This has to do with one of the sides of comparison
potentially represent the same type using two separate type_ids. So
there was a one-to-many mapping between candidate and canonical types
(don't remember whether 1 x cand -> N x canon or the other way
around).

  [0] https://nakryiko.com/posts/btf-dedup/#pass-2-non-reference-types-deduplication

>
> This possibly explains why my "fix" worked better with self-referential
> structs; with the arguments swapped, we actually used a mapping from
> candidate -> canonical. At the top level of the struct traversal,
> this mapping was established, so when we later reached a reference
> type which pointed back at the struct itself, the hypot_map
> considered a self-referential pointer in the candidate equivalent
> to one in the canonical type (since the hypot_map pointed the
> candidate type at the canonical type).
>
> > somewhat confusing, but really type_id is a candidate we are trying to
> > dedup and cand_id is a *potential* canonical type (there could be
> > multiple potential canonical types due to hash collisions).
> >
>
> Yeah there's definitely something going on here, but I'm still
> struggling to understand the dedup algorithm so I jumped on the first
> thing that looked like it might explain it. With respect to the
> test failure, is it possible that we're getting a better dedup?
>
> Specifically, the test that fails is
>
> VALIDATE_RAW_BTF(
>                 btf2,
>                 "[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>                 "[2] PTR '(anon)' type_id=5",
>                 "[3] FWD 's2' fwd_kind=struct",
>                 "[4] PTR '(anon)' type_id=3",
>                 "[5] STRUCT 's1' size=16 vlen=2\n"
>                 "\t'f1' type_id=2 bits_offset=0\n"
>                 "\t'f2' type_id=4 bits_offset=64",
>                 "[6] PTR '(anon)' type_id=8",
>                 "[7] PTR '(anon)' type_id=9",
>                 "[8] STRUCT 's1' size=16 vlen=2\n"
>                 "\t'f1' type_id=6 bits_offset=0\n"
>                 "\t'f2' type_id=7 bits_offset=64",
>                 "[9] STRUCT 's2' size=40 vlen=4\n"
>                 "\t'f1' type_id=6 bits_offset=0\n"
>                 "\t'f2' type_id=7 bits_offset=64\n"
>                 "\t'f3' type_id=1 bits_offset=128\n"
>                 "\t'f4' type_id=8 bits_offset=192",
>                 "[10] STRUCT 's3' size=8 vlen=1\n"
>                 "\t'f1' type_id=7 bits_offset=0");
>
> Reconstructing from test failure output, the actual BTF generated is
>
>                 "[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
>                 "[2] PTR '(anon)' type_id=5"
>                 "[3] FWD 's2' fwd_kind=struct"
>                 "[4] PTR '(anon)' type_id=3"
>                 "[5] STRUCT 's1' size=16 vlen=2"
>                 "'f1' type_id=2 bits_offset=0"
>                 "'f2' type_id=4 bits_offset=64",
>                 "[6] PTR '(anon)' type_id=7",
>                 "[7] STRUCT 's2' size=40 vlen=4"
>                 "'f1' type_id=2 bits_offset=0"
>                 "'f2' type_id=6 bits_offset=64"
>                 "'f3' type_id=1 bits_offset=128"
>                 "'f4' type_id=5 bits_offset=192"
>                 "[8] STRUCT 's3' size=8 vlen=1"
>                 "'f1' type_id=6 bits_offset=0'"
>
> So the difference here is that the two struct s1s were
> deduplicated, whereas they were not expected to be.
>
> Is that a valid dedup? I'm not sure, but the s1s shallow
> match on size/vlen/names, and certainly the first
> member is ok, since in both cases it's a ptr reference back
> to the struct itself. The second member is a pointer to
> a fwd definition of struct s2 (type id 3) in the case
> of the first s1 struct, and in the second it's a pointer
> to struct s2 itself, which I _think_ are supposed to be
> equivalent?

no they are not and your dedup is incorrect. Two s1 structs are not
equivalent exactly for the reason you pointed out. First s1 (from base
BTF) has f2 pointing to fwd struct s2 (not complete struct), while
struct s1 from split BTF has fuller information, it points f2 to full
struct s2. Base BTF can't be modified, so we are stuck with first
struct s1, but if we ignore second struct s1 we are losing important
information (pointer to a concrete struct s2 instead of its forward
declaration).

>
> > So there might be a bug with dedup, but it's somewhere else.
> >
>
> Is it possible the hypot_map usage could be the real issue?
>
> Thanks!
>
> Alan
>
> >   [0] https://github.com/kernel-patches/bpf/actions/runs/3137048529/jobs/5095008504
> >
> >>                 if (eq < 0)
> >>                         return eq;
> >>                 if (!eq)
> >> --
> >> 1.8.3.1
> >>
