Return-Path: <bpf+bounces-8737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505D7893FC
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 07:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C172819EA
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E20A53;
	Sat, 26 Aug 2023 05:58:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1062E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 05:58:29 +0000 (UTC)
Received: from out-245.mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03C2136
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:58:27 -0700 (PDT)
Message-ID: <298e6363-ad91-752a-5470-76e2e9de79d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693029505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dqjxGFSk201Brgxp7c7Gq2+EzjwcGFBEWVStY4gVXE=;
	b=nCImKhfLkyXZjMOZFSBRB2bBQWbVR+v4cdf4cL5sc3x5+pS315XHLFksVzrK1gt83FH1PG
	TyA4d2imJlLXkV9yjKcWkE6rkK6DNInP3Jq7zVVOFw1jSdKBuyWIofdCPJ5pWML6ViQwqi
	uvjBCX2Zd3veXCZatbyo2WCibBmNbLQ=
Date: Fri, 25 Aug 2023 22:58:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 00/13] bpf: Add support for local percpu kptr
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230825195328.92126-1-yonghong.song@linux.dev>
Content-Language: en-US
In-Reply-To: <20230825195328.92126-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/25/23 12:53 PM, Yonghong Song wrote:
> Patch set [1] implemented cgroup local storage BPF_MAP_TYPE_CGRP_STORAGE
> similar to sk/task/inode local storage and old BPF_MAP_TYPE_CGROUP_STORAGE
> map is marked as deprecated since old BPF_MAP_TYPE_CGROUP_STORAGE map can
> only work with current cgroup.
> 
> Similarly, the existing BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE map
> is a percpu version of BPF_MAP_TYPE_CGROUP_STORAGE and only works
> with current cgroup. But there is no replacement which can work
> with arbitrary cgroup.
> 
> This patch set solved this problem but adding support for local
> percpu kptr. The map value can have a percpu kptr field which holds
> a bpf prog allocated percpu data. The below is an example,
> 
>    struct percpu_val_t {
>      ... fields ...
>    }
> 
>    struct map_value_t {
>      struct percpu_val_t __percpu *percpu_data_ptr;
>    }
> 
> In the above, 'map_value_t' is the map value type for a
> BPF_MAP_TYPE_CGRP_STORAGE map. User can access 'percpu_data_ptr'
> and then read/write percpu data. This covers BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE
> and more. So BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE map type
> is marked as deprecated.
> 
> In additional, local percpu kptr supports the same map type
> as other kptrs including hash, lru_hash, array, sk/inode/task/cgrp
> local storage. Currently, percpu data structure does not support
> non-scalars or special fields (e.g., bpf_spin_lock, bpf_rb_root, etc.).
> They can be supported in the future if there exist use cases.
> 
> Please for individual patches for details.
> 
>    [1] https://lore.kernel.org/all/20221026042835.672317-1-yhs@fb.com/
> 
> Changelog:
>    v1 -> v2:
>      - does not support special fields in percpu data structure.
>      - rename __percpu attr to __percpu_kptr attr.
>      - rename BPF_KPTR_PERCPU_REF to BPF_KPTR_PERCPU.
>      - better code to handle bpf_{this,per}_cpu_ptr() helpers.
>      - add more negative tests.
>      - fix a bpftool related test failure.
> 
> Yonghong Song (13):
>    bpf: Add support for non-fix-size percpu mem allocation
>    bpf: Add BPF_KPTR_PERCPU as a field type
>    bpf: Add alloc/xchg/direct_access support for local percpu kptr
>    bpf: Add bpf_this_cpu_ptr/bpf_per_cpu_ptr support for allocated percpu
>      obj
>    selftests/bpf: Update error message in negative linked_list test
>    libbpf: Add __percpu_kptr macro definition
>    selftests/bpf: Add bpf_percpu_obj_{new,drop}() macro in
>      bpf_experimental.h
>    selftests/bpf: Add tests for array map with local percpu kptr
>    bpf: Mark OBJ_RELEASE argument as MEM_RCU when possible
>    selftests/bpf: Remove unnecessary direct read of local percpu kptr
>    selftests/bpf: Add tests for cgrp_local_storage with local percpu kptr
>    selftests/bpf: Add some negative tests
>    bpf: Mark BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE deprecated
> 
>   include/linux/bpf.h                           |  22 +-
>   include/linux/bpf_verifier.h                  |   1 +
>   include/uapi/linux/bpf.h                      |   9 +-
>   kernel/bpf/btf.c                              |   5 +
>   kernel/bpf/core.c                             |   8 +-
>   kernel/bpf/helpers.c                          |  16 ++
>   kernel/bpf/memalloc.c                         |  14 +-
>   kernel/bpf/syscall.c                          |   4 +
>   kernel/bpf/verifier.c                         | 191 +++++++++++++++---
>   tools/include/uapi/linux/bpf.h                |   9 +-
>   tools/lib/bpf/bpf_helpers.h                   |   1 +
>   .../testing/selftests/bpf/bpf_experimental.h  |  31 +++
>   .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>   .../selftests/bpf/prog_tests/percpu_alloc.c   | 125 ++++++++++++
>   .../selftests/bpf/progs/percpu_alloc_array.c  | 183 +++++++++++++++++
>   .../progs/percpu_alloc_cgrp_local_storage.c   | 105 ++++++++++
>   .../selftests/bpf/progs/percpu_alloc_fail.c   | 164 +++++++++++++++
>   .../selftests/bpf/test_bpftool_synctypes.py   |   9 +
>   18 files changed, 848 insertions(+), 53 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
>   create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_array.c
>   create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_cgrp_local_storage.c
>   create mode 100644 tools/testing/selftests/bpf/progs/percpu_alloc_fail.c

There is a test failure for libbpf_str/bpf_map_type_str reported by CI,
I will fix it in the next revision.

