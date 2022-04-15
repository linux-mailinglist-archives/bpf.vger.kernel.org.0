Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35B502D6F
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347909AbiDOQGY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 12:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiDOQGW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 12:06:22 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82CB9D0F1
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:03:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r10so3740106pfh.13
        for <bpf@vger.kernel.org>; Fri, 15 Apr 2022 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DextvyFH+mA/MhwVPW/rEUDpHOjdq+Cdf/Cgk+NtJ9o=;
        b=EjVEZNFGYvzgX2DYXarCjujY0AXgKSXWO0/raUP8lDMFN1uDeISFpem5VmjjjDgrFH
         s5C5Rezx9lfcmsyZKk23roqKY4HlXOD/QxiG8veDVeFYKCckcnh/hq262IbrO0MunEgz
         RyP1OyWq/ubU/TdqEUWFuFFfY1CCYL21OsJJWXbKhO4ie/SSndWGTZsbgSfh66LZzANt
         Nz68MKvON6Yfi3ho5ir4RFCkXmESPMNHhbEmxi5viSXV8PIwd3N2d0diJjTbOT6N7B3N
         wj02LxtXp6LeCl20BjYTb6FJ69WH4hNGEwTHNYG/DVl5am9v3e5cx9qbyPW+VNlQctgP
         2gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DextvyFH+mA/MhwVPW/rEUDpHOjdq+Cdf/Cgk+NtJ9o=;
        b=C0oGnPjutMhAuAGU7Dafg10HveGdtvz8ts+qEeD8JF/hPKsusnhSZv4tSt9EOGPd5S
         Xmy1hISW7QPeOqtyjpiC7cjfQ9qXp2XombGLjiFh7i525P8UA3+JCmKHICqg89HDWmkN
         IcHJ7VKhAHmRItHlgmJ1V5eJ6NR9C7aq5v/E67nfYI+q23lNYM6eD5+KkP+1rXklvKPR
         mFo6KbuyzWaQn25BYk2UF1W3qoweMrv0CYo0s6Kkm8csp9n7OUQR1t5fpWR9zs3oH7i7
         5yo2ZV1afAKAe+5J9k8ec3YmzcJru8XZR+wjuX/cke0aml/WHpYCmBRr4Se/UuhV6buU
         N7pw==
X-Gm-Message-State: AOAM530pi5gxoiOiJ+gN6q1Ea3l+XfdU7zcsvtPi8RcBGnUhAV9mh6ll
        XOxnVcvmgmCUY6JiRG/Q5pC5TbBKwvw=
X-Google-Smtp-Source: ABdhPJzhDATjlndNYIKfKD0qSPzdTL7n1qy+KD9qOhpL2fEHGiaQVHqF74ESyzHK2XGzNGCyS4e42w==
X-Received: by 2002:a63:5441:0:b0:39d:4310:3f0e with SMTP id e1-20020a635441000000b0039d43103f0emr6914304pgm.586.1650038632969;
        Fri, 15 Apr 2022 09:03:52 -0700 (PDT)
Received: from localhost ([112.79.166.196])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm3397972pfu.56.2022.04.15.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:03:52 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v5 00/13] Introduce typed pointer support in BPF maps
Date:   Fri, 15 Apr 2022 21:33:41 +0530
Message-Id: <20220415160354.1050687-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10218; h=from:subject; bh=EIDQndulK8P9555bbQAe4ooEP0AaSDpH/ir7kmqTGS8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiWZdBhHpgWjAuhKbGCJ9aN6A17/1S9rG7V9wigf2H jbsQI4CJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlmXQQAKCRBM4MiGSL8RyvYwEA COHe56X6EF/lFuKZie4PmkU14sEnEsRzqih+Vw9cLkqyxqAAIlJW8q81+dL67HsuhDXvQ8z/Gq4zuE tU/vbn/Bkg9A90cSfh1H73vIUE5iajFqjHuZuysvU/Z5SwdOeazEsIqpgjXmVFWIthARYu9dRo1NRt 5jC2s86B1bbdSxd1DS5meoCHHfH2i/Kqkz5d5j/Au/noDAxUP9qY7V6xgREbOGwMqzAxTfXoR+XhTN A52J7K/TpByA6OmaMTtx2hh6eowStP1ujwbDE0LibfyIoagYodnXTtzLL4jpKr9T1s5NnooC1OmslD 6uKIEFP+PriNbbrt0rLibBzKWUSfskGsubEAj20eQRefidEPnySsqdNKtvw8xuHKAg7kaoYezhatV7 /sU5TlPBPP5f92GXdGklbQv5AvKHr5ZSyAMHWkSgFsbjVMIZ+uXa2tbX8FzBh9kM0xo2P3sddxb0YV iaga9+Z2kQWPY23/JJilAMj75a7D7RsA6pCIFIEsAohgV2LpImvD+K91B8E9sMiemMrbY81JFAavOM 0ijJEM1rzSQDISwEmuxRNmy3O1EBg/+gIoaLX9Wv7R6btGzyJ3N7CUfEfu2NiC6/C26eFdt4BHYqje tWq269p4Gp4vVl/yGSW+uhVjP3ZBnh8nSLaoxlZ8vjnkUYBe/DbHl2tnGNAQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set enables storing pointers of a certain type in BPF map, and extends the
verifier to enforce type safety and lifetime correctness properties.

The infrastructure being added is generic enough for allowing storing any kind
of pointers whose type is available using BTF (user or kernel) in the future
(e.g. strongly typed memory allocation in BPF program), which are internally
tracked in the verifier as PTR_TO_BTF_ID, but for now the series limits them to
two kinds of pointers obtained from the kernel.

Obviously, use of this feature depends on map BTF.

1. Unreferenced kernel pointer

In this case, there are very few restrictions. The pointer type being stored
must match the type declared in the map value. However, such a pointer when
loaded from the map can only be dereferenced, but not passed to any in-kernel
helpers or kernel functions available to the program. This is because while the
verifier's exception handling mechanism coverts BPF_LDX to PROBE_MEM loads,
which are then handled specially by the JIT implementation, the same liberty is
not available to accesses inside the kernel. The pointer by the time it is
passed into a helper has no lifetime related guarantees about the object it is
pointing to, and may well be referencing invalid memory.

2. Referenced kernel pointer

This case imposes a lot of restrictions on the programmer, to ensure safety. To
transfer the ownership of a reference in the BPF program to the map, the user
must use the bpf_kptr_xchg helper, which returns the old pointer contained in
the map, as an acquired reference, and releases verifier state for the
referenced pointer being exchanged, as it moves into the map.

This a normal PTR_TO_BTF_ID that can be used with in-kernel helpers and kernel
functions callable by the program.

However, if BPF_LDX is used to load a referenced pointer from the map, it is
still not permitted to pass it to in-kernel helpers or kernel functions. To
obtain a reference usable with helpers, the user must invoke a kfunc helper
which returns a usable reference (which also must be eventually released before
BPF_EXIT, or moved into a map).

Since the load of the pointer (preserving data dependency ordering) must happen
inside the RCU read section, the kfunc helper will take a pointer to the map
value, which must point to the actual pointer of the object whose reference is
to be raised. The type will be verified from the BTF information of the kfunc,
as the prototype must be:

	T *func(T **, ... /* other arguments */);

Then, the verifier checks whether pointer at offset of the map value points to
the type T, and permits the call.

This convention is followed so that such helpers may also be called from
sleepable BPF programs, where RCU read lock is not necessarily held in the BPF
program context, hence necessiating the need to pass in a pointer to the actual
pointer to perform the load inside the RCU read section.

Notes
-----

 * C selftests require https://reviews.llvm.org/D119799 to pass.
 * Unlike BPF timers, kptr is not reset or freed on map_release_uref.
 * Referenced kptr storage is always treated as unsigned long * on kernel side,
   as BPF side cannot mutate it. The storage (8 bytes) is sufficient for both
   32-bit and 64-bit platforms.
 * Use of WRITE_ONCE to reset unreferenced kptr on 32-bit systems is fine, as
   the actual pointer is always word sized, so the store tearing into two 32-bit
   stores won't be a problem as the other half is always zeroed out.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20220409093303.499196-1-memxor@gmail.com

 * Address comments from Joanne
   * Move __btf_member_bit_offset before strcmp
   * Move strcmp conditional on name to unref kptr patch
   * Directly return from btf_find_struct in patch 1
   * Use enum btf_field_type vs int field_type
   * Put btf and btf_id in off_desc in named struct 'kptr'
   * Switch order for BTF_FIELD_IGNORE check
   * Drop dead tab->nr_off = 0 store
   * Use i instead of tab->nr_off to btf_put on failure
   * Replace kzalloc + memcpy with kmemdup (kernel test robot)
   * Reject both BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG
   * Add logging statement for reject BPF_MODE(insn->code) != BPF_MEM
   * Rename off_desc -> kptr_off_desc in check_mem_access
   * Drop check for err, fallthrough to end of function
   * Remove is_release_function, use meta.release_regno to detect release
     function, release reference state, and remove check_release_regno
   * Drop off_desc->flags, use off_desc->type
   * Update comment for ARG_PTR_TO_KPTR
 * Distinguish between direct/indirect access to kptr
 * Drop check_helper_mem_access from process_kptr_func, check_mem_reg in kptr_get
 * Add verifier test for helper accessing kptr indirectly
 * Fix other misc nits, add Acked-by for patch 2

v3 -> v4
v3: https://lore.kernel.org/bpf/20220320155510.671497-1-memxor@gmail.com

 * Use btf_parse_kptrs, plural kptrs naming (Joanne, Andrii)
 * Remove unused parameters in check_map_kptr_access (Joanne)
 * Handle idx < info_cnt kludge using tmp variable (Andrii)
 * Validate tags always precede modifiers in BTF (Andrii)
   * Split out into https://lore.kernel.org/bpf/20220406004121.282699-1-memxor@gmail.com
 * Store u32 type_id in btf_field_info (Andrii)
 * Use base_type in map_kptr_match_type (Andrii)
 * Free	kptr_off_tab when not bpf_capable (Martin)
 * Use PTR_RELEASE flag instead of bools in bpf_func_proto (Joanne)
 * Drop extra reg->off and reg->ref_obj_id checks in map_kptr_match_type (Martin)
 * Use separate u32 and u8 arrays for offs and sizes in off_arr (Andrii)
 * Simplify and remove map->value_size sentinel in copy_map_value (Andrii)
 * Use sort_r to keep both arrays in sync while sorting (Andrii)
 * Rename check_and_free_timers_and_kptr to check_and_free_fields (Andrii)
 * Move dtor prototype checks to registration phase (Alexei)
 * Use ret variable for checking ASSERT_XXX, use shorter strings (Andrii)
 * Fix missing checks for other maps (Jiri)
 * Fix various other nits, and bugs noticed during self review

v2 -> v3
v2: https://lore.kernel.org/bpf/20220317115957.3193097-1-memxor@gmail.com

 * Address comments from Alexei
   * Set name, sz, align in btf_find_field
   * Do idx >= info_cnt check in caller of btf_find_field_*
     * Use extra element in the info_arr to make this safe
   * Remove while loop, reject extra tags
   * Remove cases of defensive programming
   * Move bpf_capable() check to map_check_btf
   * Put check_ptr_off_reg reordering hunk into separate patch
   * Warn for ref_ptr once
   * Make the meta.ref_obj_id == 0 case simpler to read
   * Remove kptr_percpu and kptr_user support, remove their tests
   * Store size of field at offset in off_arr
 * Fix BPF_F_NO_PREALLOC set wrongly for hash map in C selftest
 * Add missing check_mem_reg call for kptr_get kfunc arg#0 check

v1 -> v2
v1: https://lore.kernel.org/bpf/20220220134813.3411982-1-memxor@gmail.com

 * Address comments from Alexei
   * Rename bpf_btf_find_by_name_kind_all to bpf_find_btf_id
   * Reduce indentation level in that function
   * Always take reference regardless of module or vmlinux BTF
   * Also made it the same for btf_get_module_btf
   * Use kptr, kptr_ref, kptr_percpu, kptr_user type tags
   * Don't reserve tag namespace
   * Refactor btf_find_field to be side effect free, allocate and populate
     kptr_off_tab in caller
   * Move module reference to dtor patch
   * Remove support for BPF_XCHG, BPF_CMPXCHG insn
   * Introduce bpf_kptr_xchg helper
   * Embed offset array in struct bpf_map, populate and sort it once
   * Adjust copy_map_value to memcpy directly using this offset array
   * Removed size member from offset array to save space
 * Fix some problems pointed out by kernel test robot
 * Tidy selftests
 * Lots of other minor fixes

Kumar Kartikeya Dwivedi (13):
  bpf: Make btf_find_field more generic
  bpf: Move check_ptr_off_reg before check_map_access
  bpf: Allow storing unreferenced kptr in map
  bpf: Tag argument to be released in bpf_func_proto
  bpf: Allow storing referenced kptr in map
  bpf: Prevent escaping of kptr loaded from maps
  bpf: Adapt copy_map_value for multiple offset case
  bpf: Populate pairs of btf_id and destructor kfunc in btf
  bpf: Wire up freeing of referenced kptr
  bpf: Teach verifier about kptr_get kfunc helpers
  libbpf: Add kptr type tag macros to bpf_helpers.h
  selftests/bpf: Add C tests for kptr
  selftests/bpf: Add verifier tests for kptr

 include/linux/bpf.h                           | 110 +++-
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/btf.h                           |  23 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/arraymap.c                         |  14 +-
 kernel/bpf/btf.c                              | 526 ++++++++++++++++--
 kernel/bpf/hashtab.c                          |  58 +-
 kernel/bpf/helpers.c                          |  21 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/ringbuf.c                          |   4 +-
 kernel/bpf/syscall.c                          | 248 ++++++++-
 kernel/bpf/verifier.c                         | 412 ++++++++++----
 net/bpf/test_run.c                            |  45 +-
 net/core/filter.c                             |   2 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 .../selftests/bpf/prog_tests/map_kptr.c       |  37 ++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 190 +++++++
 tools/testing/selftests/bpf/test_verifier.c   |  55 +-
 .../testing/selftests/bpf/verifier/map_kptr.c | 469 ++++++++++++++++
 .../selftests/bpf/verifier/ref_tracking.c     |   2 +-
 tools/testing/selftests/bpf/verifier/sock.c   |   6 +-
 22 files changed, 2057 insertions(+), 199 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

-- 
2.35.1

