Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028F6B6D66
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 03:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCMCSC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMCSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 22:18:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AE49C2;
        Sun, 12 Mar 2023 19:17:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t11so13853517lfr.1;
        Sun, 12 Mar 2023 19:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohepQFdKTlUracQhpdWg6rLnJNs1EEhTKAf+9hWfGE0=;
        b=V3P0gkoO/j1HTW1BK7narWWab1w+TJK8AzdPgLaOqnHhCA7bY51rmB0BRzQMycwOtr
         o7EqyG92o1AQ/0rGpIYixx3X/IOt89S9jktGwKzwMPh4u5/6N2wCa0RXm1FOQz8uCpE8
         +B/mCtLH8aNeihESUVvLIL0D8sBIR8ovW435yRlB7jpF11qE5zbZswyXAj3xZBGdZcG9
         H4ehNYwXdiCJBfqkHtJmBw28WsQbCJUSMSIS/wauPsQNzjDZSR5harLN8+bHqTlUuVFO
         RE5g8xPC2THnhanNZ/KVnq3dj36lnGuOkEz6TUHnNxoaP+PW3NDln4VPt3vTLi/txFEL
         huXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohepQFdKTlUracQhpdWg6rLnJNs1EEhTKAf+9hWfGE0=;
        b=Qr3c2BakZoW/ZVAYltCUODRCMnFdL4SGpj6cFvlnmTOG1z7U9nP3B5aa9tPJO78zQT
         l6GxK7joNLeIVfLSTrOPY39Evfx+ZFf8xPxM8nUp7JO835LRWgScdM74VCmkRtgV+cJF
         myZYUlXzaHmxxFyHrNpASvORhwDuQmYzqh0dTXjb4Pj3D3UwWrAjumhi6Hs+tkqRfQS7
         Y8LNl0yIwYcdOfsqdOYQ7lcBYVNkKe9MFZbrvA4kTjg8iZD64k3KcbQmM3fBN08kZgrQ
         MbiB4L8DwWjKTKFcW/gWPxyxAwLQPmM0ecDFcxtxBYKJaSk2PqPxm13OnNX1aMcmM7xY
         lhfw==
X-Gm-Message-State: AO0yUKWiAF4/w0j3HM/qUlyahQN8FAseyvtxq4xecVOZfNcpaA/vPjj8
        D+5JupI2FIoUIPKuHAnWufpsqF/MwvIz7g==
X-Google-Smtp-Source: AK7set8cBKCRBBzEaFylB7vFA/wDTwFoWDjj+HTmKAr9Oju2PBTwI/kJffvXBSSVdUZMHE4R5WwEiw==
X-Received: by 2002:a19:f610:0:b0:4d8:5238:ae97 with SMTP id x16-20020a19f610000000b004d85238ae97mr7800251lfe.36.1678673876213;
        Sun, 12 Mar 2023 19:17:56 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h17-20020ac25971000000b004dc4c5149cfsm802103lfp.134.2023.03.12.19.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:17:55 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     dwarves@vger.kernel.org, arnaldo.melo@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@fb.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves 0/1] Support for new btf_type_tag encoding
Date:   Mon, 13 Mar 2023 04:17:43 +0200
Message-Id: <20230313021744.406197-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In recent discussion in BPF mailing list ([1]) participants agreed to
add a new DWARF representation for "btf_type_tag" annotations.

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

Links & revisions
-----------------

[1] Mailing list discussion regarding `btf:type_tag`
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

Eduard Zingerman (1):
  dwarf_loader: Support for btf:type_tag

 btf_encoder.c     |  13 +-
 btf_loader.c      |  15 +-
 dwarf_loader.c    | 763 +++++++++++++++++++++++++++++++++++++---------
 dwarves.c         |   1 +
 dwarves.h         |  68 +++--
 dwarves_fprintf.c |  13 +
 6 files changed, 693 insertions(+), 180 deletions(-)

-- 
2.39.1

