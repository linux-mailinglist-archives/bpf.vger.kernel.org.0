Return-Path: <bpf+bounces-1135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3370EA26
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AE7280D1E
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CA10EA;
	Wed, 24 May 2023 00:19:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC13EA0
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:19:07 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD17E9;
	Tue, 23 May 2023 17:19:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so158226e87.2;
        Tue, 23 May 2023 17:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684887542; x=1687479542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DfxdAAQYs2VAIh9xJpyKwb1PUb3uIqWqqZXeSZ/bj0=;
        b=eu1rbVbxGuhv7xcGnJXa2Dpv4hhauIB1XYWL770lDf+oRX4p8ZcD9bj2cjqkzG28WW
         QeTKd+gCyyJ03SE5bJzUGcrtF/iXcbAbyAPRJm3gVNCuYrW5RsIqJFtzILV+VR1Ea0oO
         Jlg+nlSbrNQ5LlOaodFMaU35YijuP60BPohl3NkwE9w5qBWyf7hEcF0hxOjLNvwzfWL8
         N33aDTI4XkIFZVNj7N1Bm0MVn4jOp67Wp/IaACmZzBhIt+q+3jmrFlJ/3nyy3PJl5R0t
         RgjZ9uXGJZwJjKwgCplwen/RCavfPWAhrOboRPOWeVBFG9NdJXqdSfD2vHhOo+c0ppG8
         +lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684887542; x=1687479542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DfxdAAQYs2VAIh9xJpyKwb1PUb3uIqWqqZXeSZ/bj0=;
        b=TnGtMUMZeAnoL6XisZ+/XvfzB06jtds/taPVUcG6UXYFG2PwefZa+RFByIibdYOyYx
         BMhWVOtF9I8SUKt6hv8+5Ils5MwoZABxBOHeHeFjsD6Rj2xgrnk2B+OILud32pFJZdMf
         ROCcz+JUZvOMsHelNFxS0WguNvhlUwUHPDsaAD554BAZp5n6yb1h/VpkqOBo+E7nhajV
         oqiLhl5lCCagzm8SdDhUyer9Hu2hyE0FpTxpNUfm0E7JfE9JZQdDwR2kF6XSlV1VNSXq
         1kzFVLNK5jioLCMiIuR8pMJPBrAfX9HYEvT+pSl//uWGzZ/oHwgAL/13q+J7usI5D1B0
         NhRQ==
X-Gm-Message-State: AC+VfDzE6g8HHso870EMcv9ojnh6DWHoT/nxSll//jvahnj2vDdAgkxK
	8AbvR4SoAb6H0TlxICiiFRZ0ywYNR4slwQ==
X-Google-Smtp-Source: ACHHUZ4x+qIzZNnYRYSQ2GpnC1Q76T2A76gAraFtkWZmSb8bs1TzEb4JkxmSaxnEqyz/6GOeYVNeEg==
X-Received: by 2002:ac2:52ad:0:b0:4f3:87d7:f7a4 with SMTP id r13-20020ac252ad000000b004f387d7f7a4mr4863031lfm.62.1684887541759;
        Tue, 23 May 2023 17:19:01 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w7-20020a19c507000000b004f138ab93c7sm1487305lfe.264.2023.05.23.17.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:19:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yhs@fb.com,
	jemarch@gnu.org,
	david.faust@oracle.com,
	mykolal@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 dwarves 0/6] Support for new btf_type_tag encoding
Date: Wed, 24 May 2023 03:18:19 +0300
Message-Id: <20230524001825.2688661-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In recent discussion in BPF mailing list ([1], look for Solution #2)
participants agreed to add a new DWARF representation for
"btf_type_tag" annotations.

Existing representation is DW_TAG_LLVM_annotation object attached as a
child to a DW_TAG_pointer_type. It means that "btf_type_tag"
annotation is attached to a pointee type.

New representation is DW_TAG_LLVM_annotation object attached as a
child to *any* type. It means that "btf_type_tag" annotation is
attached to the parent type.

For example, for the following C code:

    int __attribute__((btf_type_tag("tag1"))) *g;

CLANG generates the following DWARF (1):

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

However, using the new representation scheme DWARF looks as follows (2):

    0x0000001e:   DW_TAG_variable
                    DW_AT_name  ("g")
                    DW_AT_type  (0x00000029 "int *")
    
    0x00000029:   DW_TAG_pointer_type
                    DW_AT_type  (0x00000032 "int")
    
    0x00000032:   DW_TAG_base_type
                    DW_AT_name  ("int")
                    DW_AT_encoding  (DW_ATE_signed)
                    DW_AT_byte_size (0x04)
    
    0x00000036:     DW_TAG_LLVM_annotation
                      DW_AT_name    ("btf:type_tag")
                      DW_AT_const_value ("tag1")
    
Note that in (1) DW_TAG_LLVM_annotation is a child of
DW_TAG_pointer_type, but in (2) it is a child of DW_TAG_base_type.

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

The v3 of this patch-set includes changes suggested in discussion [2],
which simplifies the implementation. Here is an overview for each
patch in the patch-set:

1. "dwarves.h: expose ptr_table interface"
   Makes struct ptr_table related functions accessible from
   dwarves.h header.

2. "dwarf_loader: Track unspecified types in a separate list"
   [1] suggests that new type tags encoding for the following case:

     void __attribute__((btf_type_tag("tag1"))) *g;

   Creates a DIE of kind DW_TAG_unspecified_type with name "void"
   and attaches DW_TAG_LLVM_annotation children to it.

   The later patches would rely on identity of this unspecified type
   instance for recoding, thus this patch introduces special tag type
   to represent DW_TAG_unspecified_type DIEs in the object model.

3. "dwarf_loader: handle btf_type_tag w/o special pointer type"
   Changes the way type tags are encoded in the dwarves.h object model:
   - special pointer type btf_type_tag_ptr_type is removed;
   - field struct btf_type_tag_type::node is removed, instances of
     btf_type_tag_type no longer form a list, instead links between
     types are tracked via btf_type_tag_type::tag.type fields, as it
     is done for derived types (e.g. DW_TAG_const_type).

4. "dwarf_loader: support btf:type_tag DW_TAG_LLVM_annotation"
   Adds support for new type tags encoding, this includes:
   - Changes to visit child DIEs of the following types:
     - DW_TAG_unspecified_type
     - DW_TAG_base_type
     - DW_TAG_typedef
     - DW_TAG_array_type
     - DW_TAG_subroutine_type
     - DW_TAG_enumeration_type
     - DW_TAG_structure_type
     In order to collect DW_TAG_LLVM_annotation's.
   - Changes in recode phase.

5. "dwarf_loader: move type tags before CVR qualifiers when necessary"
   
   Kernel expects type tags to precede CVR qualifiers in BTF.
   However, DWARF encoding format agreed with GCC team in [3.2]
   does not allow to attach DW_TAG_LLVM_annotation tags to qualifiers.
   
   Hence, this patch, which adds a post-processing step that converts
   type chains like CONST -> VOLATILE -> TYPE_TAG -> ...
   to TYPE_TAG -> CONST -> VOLATILE -> ...

6. "btf_encoder: skip type tags for VAR entry types"
   
   Kernel does not expect VAR entries to have types starting from
   BTF_TYPE_TAG. Before introduction of support for 'btf:type_tag'
   such situations were not possible, as TYPE_TAG entries were always
   preceded by PTR entries.
   
   This patch changes BTF VAR generation code to skip any BTF_TYPE_TAG
   entries for VAR type.

Corresponding CLANG changes are tracked in [3], refer to [3.2] for
some encoding examples.

Testing
-------

To verify the changes I used the following:
- Tools:
  - "LLVM-main"   :: LLVM at revision [4];
  - "LLVM-new"    :: LLVM at revision [4] with patches [3] applied;
  - "gcc"         :: GCC version 11.3 (no support for btf_type_tag annotations);
  - "pahole-next" :: dwarves at revision [5];
  - "pahole-new"  :: dwarves at revision [5] + this patch-set,
  - "kernel"      :: Linux Kernel bpf-next branch at revision [6] with CI patch [7].
- test cases:
  - kernel build;
  - kernel BPF test cases build, BPF tests execution
    (test_verifier, test_progs, test_progs-no_alu32, test_maps);
  - btfdiff script (suggested by Arnaldo, [8]).
- tool combinations (kernel compiler / clang for BPF tests / pahole version):
  - LLVM-main / LLVM-main / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok (modulo diff #1, see below)
  - gcc       / LLVM-main / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok but dwarf dump sometimes segfaults
  - LLVM-new  / LLVM-new  / pahole-next
    - kernel build : ok (modulo warn #1, see below)
    - bpf tests    : ok
    - btfdiff      : ok (modulo diff #1, see below)
  - LLVM-new  / LLVM-new  / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok (modulo diff #1, see below)
  - gcc       / LLVM-new  / pahole-new
    - kernel build : ok
    - bpf tests    : ok
    - btfdiff      : ok

Diff #1: Difference in flexible array printing, several occurrences as below:

  @ -10531,7 +10531,7 @ struct bpf_cand_cache {
          struct {
                  const struct btf  * btf;                 /*    16     8 */
                  u32                id;                   /*    24     4 */
  -       } cands[0]; /*    16     0 */
  +       } cands[]; /*    16     0 */
   
Warn #1: pahole-next complains about unexpected child tags generated
         by clang, e.g.:

  die__create_new_tag: unspecified_type WITH children!
  die__create_new_base_type: DW_TAG_base_type WITH children!

Changelog
---------

V2 -> V3:
- Suggestion [2] from Arnaldo to represent type tags as separate
  derived types is applied. As a consequence, V3 rewrites V2 almost
  completely.
- "dwarf_loader: move type tags before CVR qualifiers when necessary"
  is added after discussion in [3.2].
- "btf_encoder: skip type tags for VAR entry types" 
  is added after additional testing (I'm not sure why this was not an
  issue for V2).

V1 -> V2:
- The patch is split in 5 parts to (hopefully) simplify the review:
  - #1, #2: two simple patches for fprintf and btf_loader to fix printing
    issue for types annotated by BTF type tags;
  - #3:  merges `struct llvm_annotation` and `struct btf_type_tag_type`
    as a preparatory step;
  - #4: introduces `struct unspecified_type` as a preparatory step;
  - #5: main logic for `btf:type_tag` support, this once can't
    be split further w/o parts losing some functionality for kernel
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
[2] Suggestion to treat DW_TAG_llvm_annotation as a derived tag
    https://lore.kernel.org/bpf/ZCVygOn0+zKFEqW2@kernel.org/
[3] LLVM changes to generate btf:type_tag, revisions stack:
    [3.1] https://reviews.llvm.org/D143966
    [3.2] https://reviews.llvm.org/D143967 - this one has a number of examples
                                             in the description.
    [3.3] https://reviews.llvm.org/D145891
[4] LLVM revision
    commit ec77d1f3d9fc ("[lldb] Simplify predicates of find_if in BroadcastManager")
[5] Dwarves revision:
    commit 31bc0d741057 ("dwarf_loader: DW_TAG_subroutine_type may have a DW_AT_byte_size")
[6] Kernel revision:
    commit df21139441b0 ("tracing: fprobe: Initialize ret valiable to fix smatch error")
[7] Kernel CI patch:
    https://github.com/kernel-patches/vmtest/commit/2d732ac4e06631d11f4326989eea28d695efb7f5
[8] Suggestion to use btfdiff
    https://lore.kernel.org/dwarves/ZAKpZGSHTvsS4r8E@kernel.org/T/#mddbfe661e339485fb2b0e706b313
[V1] https://lore.kernel.org/dwarves/2232e368e55eb401bde45ce1b20fb710e379ae9c.camel@gmail.com/T/
[V2] https://lore.kernel.org/dwarves/20230314230417.1507266-1-eddyz87@gmail.com/

Eduard Zingerman (6):
  dwarves.h: expose ptr_table interface
  dwarf_loader: Track unspecified types in a separate list
  dwarf_loader: handle btf_type_tag w/o special pointer type
  dwarf_loader: support btf:type_tag DW_TAG_LLVM_annotation
  dwarf_loader: move type tags before CVR qualifiers when necessary
  btf_encoder: skip type tags for VAR entry types

 btf_encoder.c  |  30 +-
 dwarf_loader.c | 731 ++++++++++++++++++++++++++++++++++++++++---------
 dwarves.c      |   7 +-
 dwarves.h      |  34 +--
 4 files changed, 655 insertions(+), 147 deletions(-)

-- 
2.40.1


