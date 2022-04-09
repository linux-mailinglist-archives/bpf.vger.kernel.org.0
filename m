Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6FC4FA673
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiDIJey (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJew (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 05:34:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD73762CC
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 02:32:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md4so2459021pjb.4
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AEowN6yMnjNJ2uBo1CopN+vDgJhbBhPYzQN53m6w5U=;
        b=ND0gBVdZFXktzhrbB8yLTUZE+j35qX+2M/K0RsXYTfL2p0jzW2GQcs0JZ5n/zuCWfm
         RZ5WFo7YhlW7QbHuVkkoetdTaPhrvohMav+rXgmZREmNfRRiM+pnl/eR2itZeAMCwLbF
         Rh0NIziD24I3ua58Al/IT8FBGTEjWSCAJb8qc55Mxw+h7wpcWsAhEXuSNwVXQVBhFmvv
         iXsqxnit8AgSBagT4jZPrtQMpsG4XnP+fCC0z0/YARKGfPYWuGbb/b73JXxbS5GH196z
         NBQCPS0XJpPn3uqMxHkzZk46QTzEgKfT8IKXBHK1tNMhWLPdcuYdbqF2m7qzYWs43BDM
         z4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2AEowN6yMnjNJ2uBo1CopN+vDgJhbBhPYzQN53m6w5U=;
        b=S49unrkByZ4Lf7pNxIfNByqnn7hR2xTQj29drbXqZRdnwdh7WqwlsjStwwCN/7SIJw
         FaLDcOtt+7lCAtyGEu9cpsRKr4eJyuVGxzpsRl/fl94/bw93U+TvcMlYxQP/toZ1F2lr
         Wwx9rEcDUjNW4SBdh59StrQTKCWls/gnAhnkXuXgwxZOdYtOKdtyARVpUDsOwkJfaB92
         rdAyC8TJ837HTgP0lCZHEDnN6vAn7E5d53Xaqc4/l88sGN9HK/CgbH7RN3XhWJqb+gO/
         9udw1crI2xm8CFjeowdq+QL1XqGKFfFDZ5oO460VqnPA/n41lusfxor482ri9EXu+hY0
         wHiQ==
X-Gm-Message-State: AOAM530N/CijjMquyK9ajwwe9uqC3QhxIzwT1YngW58Fz/bqV9sBb10R
        R8WJxy+JNATEIHx1kO+2Xkp4tyVd/54=
X-Google-Smtp-Source: ABdhPJwoLXpdG4Wh63zGQRi7p/g1sMdWdBrVhAbCCekV9wbeUljxBpPuhYBrxkzHfcVmL6YoCFymoQ==
X-Received: by 2002:a17:903:32c5:b0:156:b466:c8ed with SMTP id i5-20020a17090332c500b00156b466c8edmr23089019plr.34.1649496765100;
        Sat, 09 Apr 2022 02:32:45 -0700 (PDT)
Received: from localhost ([112.79.142.148])
        by smtp.gmail.com with ESMTPSA id k10-20020a056a00168a00b004f7e2a550ccsm28302837pfc.78.2022.04.09.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:32:44 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v4 00/13] Introduce typed pointer support in BPF maps
Date:   Sat,  9 Apr 2022 15:02:50 +0530
Message-Id: <20220409093303.499196-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8723; h=from:subject; bh=5Ve+WJgMa8mI8bfkeo0NV6bzPopO/dGzf8Sscrn9oOE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiUVFz7OzzAieD4tYUrGsJy1kvkF/+LAmqXeAZiA8m e8uUxgmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYlFRcwAKCRBM4MiGSL8Ryj/6EA C9xLGUfApkQyFn1YuosKm8m3ZDXl2vOhJ/+CE1ZpGutHC+YBFgq4iQwVHtr/XxF7BJKXQohx2Cl0sp 8nspQuP70OnB7fKlS91UgzQIbKBMcwTlXHwSg60BGuJdz/atrfBfWz4mNtjalruBV9YGVw+N5V2Of+ hF9aO45bEqoSEqkDGqXi24nyjkw//Wh/gvyrvP39LTZKEgW9zcpruHWRkqh8ePO1Em06RkEQtvdMbB 2hvbrIYQz5W2TKIqQBATREykNJVzlDXZBKsoFKjyQl989OXhzgP5haLROP9Pop/oz/b4fOBRuobXFb bgYoqZwQ9fXJXSMM+4u4ers/d797iBZrBz31QM43R19om+2YDsviwjsjnF1Ttm+LPMssNjkJQU1Pmx CoYgKawwz1EEIDIVztcWhK6v1LPn1++eLvsoX5XjC4orroYGEmu+Phm6NMZDAc6DEl3HSQbi49Whse FfdQFPlpC72nwN8vli6lQIk70kEhfYxGsY8HnqWb+Sd2dS1Tz+WA/ALtt+M9PE3ftKfedPktvne/X2 7Obpe9CumvMkG3e+PyQ9/lUrqHBc3SAFOBFvKb4pyTfm1WeC1LHw3FjQFyRtQMAMA9HkwClejt7unJ bpuHy0wkmOdBGTRxFRfzESA5n+US0Unjt9pZQbIUqiHqxEOVs9s4UIpl3YfA==
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

 include/linux/bpf.h                           | 107 +++-
 include/linux/btf.h                           |  23 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/arraymap.c                         |  14 +-
 kernel/bpf/btf.c                              | 520 ++++++++++++++++--
 kernel/bpf/hashtab.c                          |  58 +-
 kernel/bpf/helpers.c                          |  21 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/ringbuf.c                          |   4 +-
 kernel/bpf/syscall.c                          | 249 ++++++++-
 kernel/bpf/verifier.c                         | 368 +++++++++++--
 net/bpf/test_run.c                            |  45 +-
 net/core/filter.c                             |   2 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 .../selftests/bpf/prog_tests/map_kptr.c       |  37 ++
 tools/testing/selftests/bpf/progs/map_kptr.c  | 190 +++++++
 tools/testing/selftests/bpf/test_verifier.c   |  55 +-
 .../testing/selftests/bpf/verifier/map_kptr.c | 446 +++++++++++++++
 19 files changed, 2014 insertions(+), 156 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

-- 
2.35.1

