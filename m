Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451076BA34A
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 00:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCNXEf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Mar 2023 19:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCNXEe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Mar 2023 19:04:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F964211E5;
        Tue, 14 Mar 2023 16:04:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j11so22033459lfg.13;
        Tue, 14 Mar 2023 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678835070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2vneAVJ5AkvY7dS7jax0Op42kUtEq9kyuo4hXq411I=;
        b=o2FuPgTXnEs8b1w8IRKxurFb2KbajBdGnAXGYhabLZMGQvme094OqMs+7w2FSbQX7X
         Ky1Gr5yEr0qU1wM6FSFhqQfmMDBWCc7Egvj23xQXWcAQ8wu63WL20lRtMg8RwTd1mPQl
         XHeOhVVAdphoeealc0+9t6ybVpkaZUyYqk3p9YDDg9YraEJaIVgwsgr4RGEvVCr/SGKI
         SyLKrfyTr1z9sbTjq75L8B7rt4k5+Hvl4JzKgqihXJVAUXHfAqs3hEvJ1sz8G6ZNOPLy
         21Q8dHI/F5ZgbICTXPikdKOPeKxlla2E5kq1gfMYr/AaZMBpTsxzjFyj2WKX/mHECGWH
         p9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678835070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2vneAVJ5AkvY7dS7jax0Op42kUtEq9kyuo4hXq411I=;
        b=TjPbtcGvTX0pO+g0d2Cpu+cg4W3/neBo2keu4A+YtZz/LT8BjA61uBEi1IlBW+YJCf
         XHczHhoF1OJ+rmIQMgw9O7pUFhxhKOwxntH1YsiGvgk4PoRgZHoR/gjU6FNvSya1t62f
         hRoAkXtNm0lU8CAb/47G5p3bqymXUihPZL56cz+obIaWA32zU1LtHvbWb+uP3gp/JNVf
         uXmYnPUoiDwOp+AzEH6i2OcF8KO++VzzGD24+lkxEIA79FrAcSmKnKn7yepm1kk4r17u
         TkNGef5EI0M8yb3qN/6ztrAmUsD7jFi4U8wjjselPb8ZVDo89Uk2F3LbP/nl1/lnmcwm
         t6wg==
X-Gm-Message-State: AO0yUKWXQhgza9pldwMK2uLvzVSXuVvEvw5bp0TNW2T7nHHOCd7X/bqa
        yoWPvHfALYFqxE1OTqj4fFTyG1ZTe584o6uK
X-Google-Smtp-Source: AK7set90+aOlVhxphWWn0K+44gFaP0hhib1SdKnjMAb563I+mpCFq2Xim9Ubne5zcbweKgP4dxL70Q==
X-Received: by 2002:ac2:5094:0:b0:4dd:a73f:aede with SMTP id f20-20020ac25094000000b004dda73faedemr1227607lfm.10.1678835069787;
        Tue, 14 Mar 2023 16:04:29 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004cc7acfbd2bsm569638lfq.287.2023.03.14.16.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 16:04:29 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v2 0/5] Support for new btf_type_tag encoding
Date:   Wed, 15 Mar 2023 01:04:12 +0200
Message-Id: <20230314230417.1507266-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In recent discussion in BPF mailing list ([1], look for Solution #2)
participants agreed to add a new DWARF representation for
"btf_type_tag" annotations.

Existing representation is DW_TAG_LLVM_annotation object attached as a
child to a DW_TAG_pointer_type. It means that "btf_type_tag"
annotation is attached to a pointee type.

New representation is DW_TAG_LLVM_annotation object attached as a
child to *any* type. It means that "btf_type_tag" annotation is
attached to the parent type.

Here is an example:

    int __attribute__((btf_type_tag("tag1"))) *g;

And corresponding DWARF:

    0x0000001e:   DW_TAG_variable
                    DW_AT_name      ("g")
                    DW_AT_type      (0x00000029 "int *")

    0x00000029:   DW_TAG_pointer_type
                    DW_AT_type      (0x00000032 "int")

    0x0000002e:     DW_TAG_LLVM_annotation
                      DW_AT_name    ("btf_type_tag")
                      DW_AT_const_value     ("tag1")

    0x00000032:   DW_TAG_base_type
                    DW_AT_name      ("int")


This patch adds logic necessary to handle such annotations in the
pahole tool. Examples like below are supported:

  #define __tag(val) __attribute__((btf_type_tag("__" #val)))

  struct      alpha {};
  union       bravo {};
  enum        charlie { X };
  typedef int delta;

  struct echo {
    int          * __tag(a)  a;
    int            __tag(b) *b;
    int            __tag(c)  c;
    void           __tag(d) *d;
    void           __tag(e) *e;
    struct alpha   __tag(f)  f;
    union  bravo   __tag(g)  g;
    enum   charlie __tag(h)  h;
    delta          __tag(i)  i;
    int __tag(j_result) (__tag(j) *j)(int __tag(j_param));
  } g;

Implementation details
----------------------

Although this was not discussed in the mailing list, the proposed
implementation acts in a following way (for compatibility reasons):
- both forms could be present in the debug info;
- if any annotations corresponding to the new form are present in the
  debug info, annotations corresponding to the old form are ignored.

Because the new form of type tags could be applied to any type it is
somewhat invasive from implementation point of view:
- Types `struct btf_type_tag_type` and `struct llvm_annotation` are
  consolidated as a single type `struct llvm_annotation`, in order to
  reside in a single `annots` list associated with struct/union/enum
  or typedef.
- The `annots` list, used to hold references to annotation objects,
  is put directly in `struct tag`.
- At the load phase it is not yet known whether new or old form is
  used for type tags encoding, so `struct llvm_annotation` objects are
  not added to the types table.
- The recode phase now consists of several steps:
  - depending on the results of the load phase, `struct llvm_annotation`
    objects corresponding to either old or new representations are
    added to the types table;
  - `tag__recode_dwarf_type()` is executed as usual, but it also
    collects information about type tags;
  - references to types that have type tag annotations are updated to
    point to the first annotation object.

Corresponding clang changes are tracked in [6].

Testing
-------

To verify the changes I used the following:
- Tools:
  - "LLVM-main"   :: LLVM at revision [3];
  - "LLVM-new"    :: LLVM at revision [3] with patches [6] applied;
  - "gcc"         :: GCC version 11.3 (no support for btf_type_tag annotations);
  - "pahole-next" :: dwarves at revision [4];
  - "pahole-new"  :: dwarves at revision [4] + this patch,
  - "kernel"      :: Linux Kernel bpf-next branch at revision [5]
- test cases:
  - kernel build;
  - kernel BPF test cases build, BPF tests execution
    (test_verifier, test_progs, test_progs-no_alu32, test_maps);
  - btfdiff script (suggested by Arnaldo, [2]).
- tool combinations (kernel compiler / clang for BPF tests / pahole version):
  - LLVM-main / LLVM-main / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok (modulo diff #1, see below)
  - gcc       / LLVM-main / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok
  - LLVM-new  / LLVM-new  / pahole-next
    - kernel build : ok with warnings (see warn #1 below)
    - bpf tests    : ok
    - btfdiff      : fails (see diff #2 below)
  - LLVM-new  / LLVM-new  / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok (modulo diff #1, see below)
  - gcc       / LLVM-new  / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok

Note on BPF tests: test case `verif_scale_loop6` fails for all
configurations above and 'LLVM-main / LLVM-main / pahole-next',
thus I consider this issue as unrelated.

Diff #1: Difference in flexible printing, several occurrences as below:

  @ -10531,7 +10531,7 @ struct bpf_cand_cache {
          struct {
                  const struct btf  * btf;                 /*    16     8 */
                  u32                id;                   /*    24     4 */
  -       } cands[0]; /*    16     0 */
  +       } cands[]; /*    16     0 */
   
          /* size: 16, cachelines: 1, members: 5 */
          /* last cacheline: 16 bytes */

Diff #2: pahole-next does not know how to print type name for types
with type tags, when reading from BTF:

  @ -72998,8 +73022,8 @ struct sock {
          /* --- cacheline 19 boundary (1216 bytes) --- */
          int                        (*sk_backlog_rcv)(struct sock *, struct sk_buff *); /*  1216     8 */
          void                       (*sk_destruct)(struct sock *); /*  1224     8 */
  -       rcu *                      sk_reuseport_cb;      /*  1232     8 */
  -       rcu *                      sk_bpf_storage;       /*  1240     8 */
  +       <ERROR                    > sk_reuseport_cb;     /*  1232     8 */
  +       <ERROR                    > sk_bpf_storage;      /*  1240     8 */

(Also DWARF names refer to TYPE_TAG, not actual type name, fixed in pahole-new).

Warn #1: pahole-next complains about unexpected child tags generated
by clang, e.g.:

  die__create_new_tag: unspecified_type WITH children!
  die__create_new_base_type: DW_TAG_base_type WITH children!


Performance impact
------------------

The update to `struct tag` might raise concerns regarding memory
usage, additional steps in recode phase might raise concerns regarding
execution time. Below is statistics collected for Kernel BTF
generation.

LLVM-new / LLVM-new / pahole-new:

$ /usr/bin/time -v pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf
    ...
	User time (seconds): 22.29
	System time (seconds): 0.47
	Percent of CPU this job got: 483%
    ...
	Maximum resident set size (kbytes): 714524
    ...

LLVM-new / LLVM-new / pahole-next:

$ /usr/bin/time -v pahole -J --btf_gen_floats -j --lang_exclude=rust .tmp_vmlinux.btf
    ...
	User time (seconds): 20.96
	System time (seconds): 0.44
	Percent of CPU this job got: 473%
    ...
	Maximum resident set size (kbytes): 700848
    ...

Changelog
---------

V1 -> V2:
- The patch is split in 5 parts to (hopefully) simplify the review:
  - #1, #2: two simple patches for fprintf and btf_loader to fix printing
    issue for types annotated by BTF type tags;
  - #3:  merges `struct llvm_annotation` and `struct btf_type_tag_type`
    as a preparatory step;
  - #4: introduces `struct unspecified_type` as a preparatory step;
  - #5: main logic for `btf:type_tag` support, this once can't
    be split further w/o parts loosing some functionality for kernel
    build and/or bpf tests.
- `reallocarray()` in `push_btf_type_tag_mapping()` is replaced by
  `realloc()` (suggested by Alan);
- The sequence `free(dcu->hash_tags); free(dcu->hash_types);` added in
  V1 is removed from `dwarf_cu__delete()`. It was a fix for some
  valgrind errors reported for `pahole -F dwarf`, but this is
  unrelated and the fix is incomplete.

Links & revisions
-----------------

[1] Mailing list discussion regarding `btf:type_tag`
    Various approaches are discussed, Solution #2 is accepted
    https://lore.kernel.org/bpf/87r0w9jjoq.fsf@oracle.com/
[2] Suggestion to use btfdiff
    https://lore.kernel.org/dwarves/ZAKpZGSHTvsS4r8E@kernel.org/T/#mddbfe661e339485fb2b0e706b31329b46bf61bda
[3] f759275c1c8e ("[AMDGPU] Regenerate sdwa-peephole.ll")
[4] a9498899109d ("dwarf_loader: Support for btf:type_tag")
[5] 49b5300f1f8f ("Merge branch 'Support stashing local kptrs with bpf_kptr_xchg'")
[6] LLVM changes to generate btf:type_tag, revisions stack:
    https://reviews.llvm.org/D143966
    https://reviews.llvm.org/D143967
    https://reviews.llvm.org/D145891
[7] V1 of this patch-set
    https://lore.kernel.org/dwarves/2232e368e55eb401bde45ce1b20fb710e379ae9c.camel@gmail.com/T/

Eduard Zingerman (5):
  fprintf: Correct names for types with btf_type_tag attribute
  btf_loader: A hack for BTF import of btf_type_tag attributes
  dwarf_loader: Consolidate llvm_annotation and btf_type_tag_type
  dwarf_loader: Track unspecified types in a separate list
  dwarf_loader: Support for btf:type_tag

 btf_encoder.c     |  13 +-
 btf_loader.c      |  15 +-
 dwarf_loader.c    | 760 +++++++++++++++++++++++++++++++++++++---------
 dwarves.c         |   1 +
 dwarves.h         |  64 ++--
 dwarves_fprintf.c |  13 +
 6 files changed, 686 insertions(+), 180 deletions(-)

-- 
2.39.1

