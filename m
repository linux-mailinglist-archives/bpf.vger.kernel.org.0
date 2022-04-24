Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8993D50D559
	for <lists+bpf@lfdr.de>; Sun, 24 Apr 2022 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiDXVvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Apr 2022 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiDXVvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Apr 2022 17:51:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA2644DF
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s17so22939739plg.9
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbLDxubf4lRkJyt8uU+hC5VIrnfeSQO+w6FvBazHua0=;
        b=DanO6cXg1/daBvYHqMJkITvrJIpgeA2HRcHOSGj9U4Lw9uwCBuzgFtjwEy8Z4hSt+P
         1Ru3tC7WEhK/PwI2dbViw8jJYXEBgFUWiH/NE5vUvOswrzJWebZI635211b4haxFUmAH
         k4G4xbRdWm2zbsMAPXEF8viC9Bc4axiL8PCaLs6gU42M0PGIcIVEwDt0ZJg6hRORcKVA
         7HlbXqNLEKxOJg+zEfUUzoTURHtmgGBGkubXBkXmkvnDCnsaOP9u4bgCwXi+mQKRS16g
         rK67A/yBlDV0ygGpinZUoY352ZsG8TeuV2QpDcHijBgHeVwsZ9nDlxtZsizzO6azTFJz
         zCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbLDxubf4lRkJyt8uU+hC5VIrnfeSQO+w6FvBazHua0=;
        b=5Jx8Bs6PDMckAxxnibGBN/qX3LPQrZDAtEx+t2r8ik2PwNKlObpftu27gT9LdZZFLd
         vQ+z71sL31RQps1+EHnNhClc+gMRJZu2tFNdJ4fg9WyzzodpkYgtjeKtkY4t/txcmtrI
         6mpJD7sClvnSmcGkfPh2dWianVAdUhTWCKu9g7s69fGdMjwrRPS2eD0Ai815tdPSsykx
         0/uCuKv5Y1tbnbHQqbvVlE4WvpKADEbc8qWuEb1S0sjHDbqs4HQ8DVmMGfGf1bFqL0Qe
         e0vPRBO1Lhkj/mykno/CXH69MREeIV1mdmdhyNb9sVLGYM/1geXFzr5cDZ27/E/ZcB27
         aOWg==
X-Gm-Message-State: AOAM531glKelTmPJR9xX7qqDnrhfUmIloUsapGjM+kcdjbrT75yaOSam
        tep2UZyxIBnHzjVPHNiokBcB6SftPkI=
X-Google-Smtp-Source: ABdhPJxHpNfZdDlU1lYFXTY/RR3I7p5ov3LPPjgve1W+bO7wHrGZ2mbRuXb4a9oXMHNXv/Vn26eQIg==
X-Received: by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id j8-20020a170903024800b00155ecb7dfafmr15171370plh.84.1650836924466;
        Sun, 24 Apr 2022 14:48:44 -0700 (PDT)
Received: from localhost ([157.49.66.127])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79429000000b0050ad02027d9sm9044280pfo.197.2022.04.24.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 14:48:44 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v6 00/13] Introduce typed pointer support in BPF maps
Date:   Mon, 25 Apr 2022 03:18:48 +0530
Message-Id: <20220424214901.2743946-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11238; h=from:subject; bh=pRwLVO3omwXz08eGE0bcRkxhaIicEWSph8Y0oheC4HI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiZcTKb6+j/0VCcZi9nmpXZC9lnjchjUH3gpSIOZti QH7e1iaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYmXEygAKCRBM4MiGSL8RytrjD/ 9YIXbSxSVVh7j9IA5BrQq//EEW+DOE0EJNQNKG3XKfiMe1qMfyWY1MDLGaEN4xt4RnYjuj9AS/Hp15 TrPJMiAKbKTQQO5KLnoizY0vK7ythyvjNh4YGrvTdxiQUGWa+N4tNnI35WRWEhVbpihhrIuwAlnmCS wEyiYFKjjwvHoO1VhrbEGWWmLBF0yQpyulz75XRoCBX/6k6/C8qKpk6OHAJMPbMahHpylJBp9bLLSG NUFAMGtWnErPwHy/iIRRoZPURjj6d1F1MnpiSeXPYNjOuuXQr9ymnOxtIt8NgMA4BIdh7NAPuewlZy /w4z4e0EWnbavIhCs9YmRE5mLH754gO7Yh9PwyB2/4pSlxyzuX+XsGDIvCOCOuBl5RLV8BQ5gSgodj vHRDFUBMDke+7NDGwFJKeiouPYGPC9wmI/pMumDwtq+0TIKZcuR9Om8rvaifVCGbnWY6VXcRMhPrxz 9uaqvoM626Y3FsS1yInA5Ywo9/aTTOkXAkF96PFAxD9q1a10SmCBmxklasMbc2m99AMdXu/S/Q/kgF Yzsi3QlZux2veTTVcwQYmy/304aJT8ryqpNN5TZ3NFLDApFTV//hdDkFCmhtpXIwUs2A3W6zmjaQWz 4dDfXtRXjBSx+gGQ1LWiOAxMmnJ28jqE3FA7WxvW9Lnp8TgGa6q6kLHvcbzQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
v5 -> v6
v5: https://lore.kernel.org/bpf/20220415160354.1050687-1-memxor@gmail.com

 * Address comments from Alexei
   * Drop 'Revisit stack usage' comment
   * Rename off_btf to kernel_btf
   * Add comment about searching using type from map BTF
   * Do kmemdup + btf_get instead of get + kmemdup + put
   * Add comment for btf_struct_ids_match
   * Add comment for assigning non-zero id for mark_ptr_or_null_reg
   * Rename PTR_RELEASE to OBJ_RELEASE
   * Rename BPF_MAP_OFF_DESC_TYPE_XXX_KPTR to BPF_KPTR_XXX
   * Remove unneeded likely/unlikely in cold functions
   * Fix other misc nits
 * Keep release_regno instead of replacing with bool + regno
 * Add a patch to prevent type match for first member when off == 0 for
   release functions (kfunc + BPF helpers)
 * Guard kptr/kptr_ref definition in libbpf header with __has_attribute
   to prevent selftests compilation error with old clang not support
   type tags

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
  bpf: Allow storing unreferenced kptr in map
  bpf: Tag argument to be released in bpf_func_proto
  bpf: Allow storing referenced kptr in map
  bpf: Prevent escaping of kptr loaded from maps
  bpf: Adapt copy_map_value for multiple offset case
  bpf: Populate pairs of btf_id and destructor kfunc in btf
  bpf: Wire up freeing of referenced kptr
  bpf: Teach verifier about kptr_get kfunc helpers
  bpf: Make BTF type match stricter for release arguments
  libbpf: Add kptr type tag macros to bpf_helpers.h
  selftests/bpf: Add C tests for kptr
  selftests/bpf: Add verifier tests for kptr
  selftests/bpf: Add test for strict BTF type check

 include/linux/bpf.h                           | 113 +++--
 include/linux/bpf_verifier.h                  |   3 +-
 include/linux/btf.h                           |  23 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/arraymap.c                         |  18 +-
 kernel/bpf/btf.c                              | 460 +++++++++++++++--
 kernel/bpf/hashtab.c                          |  64 ++-
 kernel/bpf/helpers.c                          |  21 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/ringbuf.c                          |   4 +-
 kernel/bpf/syscall.c                          | 234 ++++++++-
 kernel/bpf/verifier.c                         | 370 +++++++++++---
 net/bpf/test_run.c                            |  67 ++-
 net/core/filter.c                             |   2 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   7 +
 .../selftests/bpf/prog_tests/map_kptr.c       |  37 ++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 190 +++++++
 tools/testing/selftests/bpf/test_verifier.c   |  55 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  20 +
 .../testing/selftests/bpf/verifier/map_kptr.c | 469 ++++++++++++++++++
 .../selftests/bpf/verifier/ref_tracking.c     |   2 +-
 tools/testing/selftests/bpf/verifier/sock.c   |   6 +-
 23 files changed, 2032 insertions(+), 162 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

-- 
2.35.1

