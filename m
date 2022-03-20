Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9ED4E1C61
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 16:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCTP4j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 11:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTP4i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 11:56:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCE54194
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u17so13530057pfk.11
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xv/eoEguFIxKX5chjtOUgOLZqiuh+xaini9ybGqfWMY=;
        b=bArHIgmPxzp6s4Dl/1Zi7jsDqCSuXxLqSsZZMB5O29+7xvCpGU7ZqV7PrLZbSJNxoK
         lZddbryqzPp7baHu08D1E//NA7RSbri0ndSXfO/V7W4qOUvszR+XYMMpN0GLabwSuh/E
         uEyJ0I2jlA91CcJrPoKlMViyzQ1kbHmLEgPqNVAtXGd1lC3SxfrGhrmUCZThqAimqI3k
         neW0GBatxD0j338tAwAaLi1J2Fu2LTANjCSi2fS0OJ+9fnF9Yh6vo6P2y9CNc1J1m7yA
         Q8zBnHXUAssdGZNa0iiBLlpoYBxqKYdC6ei9kXq+onjZLjuhkEdFsOLuu/+e56n0TrCt
         loGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xv/eoEguFIxKX5chjtOUgOLZqiuh+xaini9ybGqfWMY=;
        b=wKteqWZbnywocDC3PNTYcOcHLwF6/9iiQClOvIhz0KrXvuaYYf5Fkd657KgPZ/hbDN
         GXJ82ZKEf6/Zlyrua8W5VdiNNR0/ag1vhqbkZS06IdiaYp2qhgRjOgMgF84gITN31z2U
         z3YFHdU+Ql0u2MCZxWi+VFDGeXTXl+PMGmhxi/jj/GjMGmun2B3qdKJ81cuoGo3siC70
         iXPuEuht1H9u6nNd3fmGlHhgNOy7I0d8TMc4iN6Rb0v9bEwU4nrneL/wLN+89o56Pm28
         mbXK++xjag+uomAZtEh3AcFHKz2rky+brGm1vLAXUDmdR3wXIoFpgbjgscJqyJ7e0qwn
         VgWQ==
X-Gm-Message-State: AOAM532fia48NqUJnfR10MzP7udBOxLtqTNfLwgaZ7z+3qNsuunYWl9R
        S3IB8eXULssv7Zw2Cv0Vf3jYOVpftmw=
X-Google-Smtp-Source: ABdhPJyfKPujeiZeDe0wKVOUFQSYp11HU51x7p8mlgaUzqcJV/HUGnrBpsg7DhqTLMeBpnZbacHDxQ==
X-Received: by 2002:a05:6a00:887:b0:4f2:6d3f:5b53 with SMTP id q7-20020a056a00088700b004f26d3f5b53mr19580813pfj.21.1647791714165;
        Sun, 20 Mar 2022 08:55:14 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm17484768pfp.45.2022.03.20.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 08:55:13 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v3 00/13] Introduce typed pointer support in BPF maps
Date:   Sun, 20 Mar 2022 21:24:57 +0530
Message-Id: <20220320155510.671497-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7467; h=from:subject; bh=HbHjelMRAwKOoqAnfAMCK2J3Z11Xs6gzR2QRjONQ4A4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiN00xJ0C7otktzEIsiU70iuJRppyt4aVb0FzZuQGz J4Yk5VGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjdNMQAKCRBM4MiGSL8RyolXEA C81iCIn2WNl2L3HpaNKr4jvu3gcgD64Va7jqs1tlAnpIz1KOnwOwrYmkKC3jKwnn5cx36FsrpoGvva kIfsBZvI+flVDPRQp1BhHjphKlylSukGWISRCJopAMe7gyf9dNp/vIRkfVViIN5GVrzfSSwLUFXnrN W93IHi6DNkISttiAPsovXx7b9lXzy5PsB6+9jqRQujGpCx7L0oB0bTIgOUhoZjtmkLMdVn/5XtCRAp DQigrBwHH5Kxopt2uXFSGWvGbOkZXjrpWP7Rlo5SJDdvXz/TpvNjJ7YM3SR0YuL5ddKPDT0WMe4djo IjXspZdzHHF0+wKSW55sXbpexOi0B6vC/uz0/jC7UqTrODZV/pIx/xuy6/u1FRebkPkqzd9TaKVyFc X41vIgYui/oV9WqswMUWQgq3y9NySSA7PlnTC67v4/7tdZT+MvRma7bYXvbi7dsQXrGFV7v8n29QuW Y72R/2S3aB5kxHLbHoF6eSBi+XRJybY/lc/+JrVBOW29IQqHMPaLoLMhlzQLZCHjAqQbukSsdlTn0S SGsnuuUorNNDeiSGPBWQ7Vc8NcwfBX6lUESdn9Rbx2q09jkgETMRKOtNAQEBWWwZh3lCFlx5MLrCj4 fF9TfWaRH2C9IFmNXQkxUL6OC4Q6q3JuS96WjV3zQAp7RBAZBR8Gt563f1MQ==
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
  bpf: Indicate argument that will be released in bpf_func_proto
  bpf: Allow storing referenced kptr in map
  bpf: Prevent escaping of kptr loaded from maps
  bpf: Adapt copy_map_value for multiple offset case
  bpf: Populate pairs of btf_id and destructor kfunc in btf
  bpf: Wire up freeing of referenced kptr
  bpf: Teach verifier about kptr_get kfunc helpers
  libbpf: Add kptr type tag macros to bpf_helpers.h
  selftests/bpf: Add C tests for kptr
  selftests/bpf: Add verifier tests for kptr

 include/linux/bpf.h                           | 113 +++-
 include/linux/btf.h                           |  23 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/arraymap.c                         |  14 +-
 kernel/bpf/btf.c                              | 506 ++++++++++++++++--
 kernel/bpf/hashtab.c                          |  29 +-
 kernel/bpf/helpers.c                          |  22 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/ringbuf.c                          |   2 +
 kernel/bpf/syscall.c                          | 211 +++++++-
 kernel/bpf/verifier.c                         | 379 +++++++++++--
 net/bpf/test_run.c                            |  39 +-
 net/core/filter.c                             |   1 +
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 .../selftests/bpf/prog_tests/map_kptr.c       |  20 +
 tools/testing/selftests/bpf/progs/map_kptr.c  | 194 +++++++
 tools/testing/selftests/bpf/test_verifier.c   |  49 +-
 .../testing/selftests/bpf/verifier/map_kptr.c | 445 +++++++++++++++
 19 files changed, 1931 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

-- 
2.35.1

