Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DAE4DC550
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 13:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiCQMBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 08:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiCQMBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 08:01:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEC170D9C
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d19so6612844pfv.7
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SuWxsnxzDp3hbRrmwUZYln/lKMmAap/qOVGhA8ZqfM=;
        b=MfhKZ8d57x49m3/yRTRKRpKhsvITzVgSpm3JIlIZhFVzIguu1KFNi7ZDsBre40Ezk0
         12GXdATfHey5F3pU4HEN2dU26Y5rrvVL83u6tmbglBRU9XIdXw3n+RmLZDG3Z4Qvll10
         uhc1aBxs6ssykUg81yzMQkdTYFcSfELZpVkbtIdVIaPpH21zmgWe0EChKPHk3lDBYA9Z
         Vs/IfvAVQY3YhHh+rsg3KoNgwbw6Fg0UzUMwOw74JcnqcVros6mMG/1tM0gQMyec6NCn
         fNS5vyCRr5wI46aedz3g9t3TgvxcBpU03imr/LvtdX8cTes7t+36JR5m9BQij2Y3aZPI
         Xfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SuWxsnxzDp3hbRrmwUZYln/lKMmAap/qOVGhA8ZqfM=;
        b=bwArUrteuzGZ3jG5wXjZ+Pyc4PsXUaDPJUCETl1uNzzIxil4yjhKYBOd5r9l7V2phu
         AcIXbySpZmb9fs7jqpF9FH63lAVzA49XbSoVhWTJCpHg8nnlChmdR6atessads8UqGYS
         0SBU8tz+OwdKN9Z2WvLI6c32ABB2mUAmCpmoBPepzFYKzgc4GM/Vicuh8cs1swYC9dIA
         3dbt1GGP2h44PzMM9EUj+7CzNtlfn2osik80dJEd0/8gcKwzmMaZDbOA3CBf2V8OZUx6
         lHojzzjbwA71fOnhOvAbxivfboW2D/Cg9aw0V0bt0vPTIfl2LoMSgPC7sABEcWEMHIpo
         6GJw==
X-Gm-Message-State: AOAM532sKkePZvZEE1h5SrUa9PRM2xHMzARsdZ3l9CyVs8ika0dVJ15O
        AX8O8V4EuKodm9xgXVB7nmDDDaJlx0U=
X-Google-Smtp-Source: ABdhPJxnMtqF95LNQIAw2dNDU+uKWmVmHhAC1cahllg5zMoxC0QeYCu4MgLRNvQp/eCMvj6w4Hr5dA==
X-Received: by 2002:a05:6a00:c93:b0:4fa:a78:df25 with SMTP id a19-20020a056a000c9300b004fa0a78df25mr4761828pfv.34.1647518401270;
        Thu, 17 Mar 2022 05:00:01 -0700 (PDT)
Received: from localhost ([157.51.20.101])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090a521700b001bbfc181c93sm9293223pjh.19.2022.03.17.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:00:00 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 00/15] Introduce typed pointer support in BPF maps
Date:   Thu, 17 Mar 2022 17:29:42 +0530
Message-Id: <20220317115957.3193097-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7643; h=from:subject; bh=Pt180q7mq5mOZCXl03EsYfYpRzburhv2chHBS+wr+dY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiMyKiVkQHRyE5vgnNcGAMGIQP/i8moYzGqIjN+nIl HqetlQOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYjMiogAKCRBM4MiGSL8RytQhEA CENCBvANB4tZ1ZI+HhJyXZJqL4upZsbOOilcfCuCTie14p14vJP18ee/98DYi36QqGZ+L5sUmzZaW8 +tXjEdAK5RQjVYYkCUat0jjU+C9XiOgnT4WxC3CimIavvreYVzrQXoHSAPwgnVWVt9uPQ/Z8XhFFor FBOo7fQl9gV9MlXpe+nE+9D38tUtHP7DWtrY5Wqp10AFlbMFiRioekKoEyW2/PzdCgGL69E4StsvFC wcTqBJL5ksR4Rk9KLvTlrJX4qLA001ylNGxB11o5bzGNyQnH9YmFDgSxKl37OsHpZvAGnqVxdsVWfc p+lYoOQlru24b19UdgbBZBYW/jqKtotyj9KS9g/3Rb/39l4x2Um+XlaIxCxf9vmOoIoxJ0ikYY3/1W l2xo5NlzclVp067P+qJkcbZlrnn0vw+pyFn3Lvz22je+Tv3rXyN/pL69NsTgRY5F0rLI3tCy9axcPX J+xBcOZbncbomzs3a7YeEhC8c+Rt+XewFFy2birIi+kuo/nf0z9z09gQ/pszK4HMNzQTD+QxpWZspB LXRMQVjurexcbagfTYJq8yr/HIC935OC2AqRm7wKZAyyWMN6/aPCxFnatxkGxI3hyoQOn0Gn7GTEcd rDuLUJSV0gERxCHG2hpLScmajxXm3dBCwhMEc270EFsFA7cAqi8Xbpcs03kw==
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
four kinds of pointers obtained from the kernel.

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

3. per-CPU kernel pointer

These have very little restrictions. The user can store a PTR_TO_PERCPU_BTF_ID
into the map, and when loading from the map, they must NULL check it before use,
because while a non-zero value stored into the map should always be valid, it can
still be reset to zero on updates. After checking it to be non-NULL, it can be
passed to bpf_per_cpu_ptr and bpf_this_cpu_ptr helpers to obtain a PTR_TO_BTF_ID
to underlying per-CPU object.

It is also permitted to write 0 and reset the value.

4. Userspace pointer

The verifier recently gained support for annotating BTF with __user type tag.
This indicates pointers pointing to memory which must be read using the
bpf_probe_read_user helper to ensure correct results. The set also permits
storing them into the BPF map, and ensures user pointer cannot be stored into
other kinds of pointers mentioned above.

When loaded from the map, the only thing that can be done is to pass this
pointer to bpf_probe_read_user. No dereference is allowed.

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

Kumar Kartikeya Dwivedi (15):
  bpf: Factor out fd returning from bpf_btf_find_by_name_kind
  bpf: Make btf_find_field more generic
  bpf: Allow storing unreferenced kptr in map
  bpf: Allow storing referenced kptr in map
  bpf: Allow storing percpu kptr in map
  bpf: Allow storing user kptr in map
  bpf: Prevent escaping of kptr loaded from maps
  bpf: Adapt copy_map_value for multiple offset case
  bpf: Always raise reference in btf_get_module_btf
  bpf: Populate pairs of btf_id and destructor kfunc in btf
  bpf: Wire up freeing of referenced kptr
  bpf: Teach verifier about kptr_get kfunc helpers
  libbpf: Add kptr type tag macros to bpf_helpers.h
  selftests/bpf: Add C tests for kptr
  selftests/bpf: Add verifier tests for kptr

 include/linux/bpf.h                           | 109 ++-
 include/linux/btf.h                           |  23 +
 include/uapi/linux/bpf.h                      |  12 +
 kernel/bpf/arraymap.c                         |  14 +-
 kernel/bpf/btf.c                              | 623 ++++++++++++--
 kernel/bpf/hashtab.c                          |  28 +-
 kernel/bpf/helpers.c                          |  21 +
 kernel/bpf/map_in_map.c                       |   5 +-
 kernel/bpf/syscall.c                          | 204 ++++-
 kernel/bpf/verifier.c                         | 412 ++++++++--
 net/bpf/test_run.c                            |  39 +-
 tools/include/uapi/linux/bpf.h                |  12 +
 tools/lib/bpf/bpf_helpers.h                   |   4 +
 .../selftests/bpf/prog_tests/map_kptr.c       |  20 +
 tools/testing/selftests/bpf/progs/map_kptr.c  | 236 ++++++
 tools/testing/selftests/bpf/test_verifier.c   |  60 +-
 .../testing/selftests/bpf/verifier/map_kptr.c | 763 ++++++++++++++++++
 17 files changed, 2394 insertions(+), 191 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_kptr.c
 create mode 100644 tools/testing/selftests/bpf/verifier/map_kptr.c

-- 
2.35.1

