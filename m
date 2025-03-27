Return-Path: <bpf+bounces-54783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5711CA72B50
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0C33B3252
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F36204F7F;
	Thu, 27 Mar 2025 08:22:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E04C62
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063778; cv=none; b=dEnih1FO0bG7t4E4S72dYd9KByBGzIWkhIvp9KiRo6rrf6IWifZb28ww9kBN/LOi/A6rEgjqL1LFXn9lBJzQf3PKvjrlHluIJzDyHijJnbHUglDcLeXg0YLpcnmk+hfb/Zv4A8prRX7C0ghFj69ny6TeSXlQU0CWa7sQhShdtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063778; c=relaxed/simple;
	bh=kEqkyFi3Q8FyTX8QrL22t/l1cMJs3+k1L1PLvlVI82k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lPsZygXNjOKXZdbevOi36cdbFzPcdWvdLIwvsKXceT1Rbx1Jq033TdIK/zXQoPFbhzfCxNd46N55WqDsZ/QIEbFHbwGhBFCW/I3Mzj9aCKxoxan+4EwuVf14UqpFJpCz+NIX320Y36JkWVgvHzoFORdptrVkSU3zhZzB/iWL+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8f5vLlz4f3m6j
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 480C91A0CD6
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S4;
	Thu, 27 Mar 2025 16:22:49 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 00/16] Support dynptr key for hash map
Date: Thu, 27 Mar 2025 16:34:39 +0800
Message-Id: <20250327083455.848708-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47AF18tr47Ary7Cw1Dtrb_yoW3ZFWkpa
	y8W3y3tr4xtFyxXw47Ca1xJrWFqws5Xr1UG3Wxt34ru348XryfZr4Ig3WFgF9xtryFqr45
	Aw1xtr98uw18CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to add the basic dynptr key support for hash map as
discussed in [1]. The main motivation is to fully utilize the BTF info
of the map key and to support variable-length key (e.g., string or any
byte stream) for bpf map. The patch set uses bpf_dynptr to represent the
variable-length part in the map key and the total number of
variable-length parts in the map key is limited as 2 now. Due to the
limitation in bpf memory allocator, the max size of dynptr in map key is
limited as 4088 bytes. Beside the variable-length parts (dynptr parts),
the fixed-size part in map key is still allowed, so all of these
following map key definitions are valid:

	struct bpf_dynptr;

	struct map_key_1 {
		struct bpf_dynptr name;
	};
	struct map_key_2 {
		int pid;
		struct bpf_dynptr name;
	};
	struct map_key_3 {
		struct map_key_2 f1;
		unsigned long when;
                struct bpf_dynptr tag;
	};

The patch set supports lookup, update, delete operations on normal hash
map with dynptr key for both bpf program and bpf syscall. It also
supports lookup_and_delete and get_next_key operations on dynptr map key
for bpf syscall.

However the following operations have not been fully supported yet on a
hash map with dynptr key:

1) batched map operation through bpf syscall
2) the memory accounting for dynptr (aka .htab_map_mem_usage)
3) btf print for the dynptr in map key
4) bpftool support
5) the iteration of elements through bpf program
When a bpf program iterates the element in a hash map with dynptr key
(e.g., bpf_for_each_map_elem() helper or map element iterator), the
dynptr in the map key has not been specially treated yet and the dynptr
is only treated as a read-only 16-bytes buffer, therefore the iteration
of dynptr-keyed map is disabled.

The patch set is structured as follow:

Patch #1~#2 introduce BPF_DYNPTR in btf_field_type and parse the
bpf_dynptr in the map key.

Patch #3 introduce a helper to check whether the map supports dynptr in
its map key or not.

Patch #4~#5 refactor check_stack_range_initialized() and support
dynptr-keyed map in verifier.

Patch #6~#8 updates the definition of bpf_dynptr, support the use of
bpf_dynptr in bpf syscall for map lookup, lookup_delete, update, delete
and get_next_key operations.

Patch #9~#13 update the lookup, lookup_delete, update, delete and
get_next_key callback correspondingly to support dynptr-keyed hash map.

Patch #14~#15 add positive and negative test cases for hash map with
dynptr key support.

Patch #16 adds the benchmark to compare the lookup and update
performance between normal hash map and dynptr-keyed hash map.

When the max length of str is greater than 256, the lookup performance
of dynptr hash-map will be better than the normal hash map. When the max
length is greater than 512, the update performance of dynptr hash map
will be better than the normal hash map. And the memory consumption of
hash-map with dynptr key is smaller compared with normal hash map.

a) lookup operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                | 11.2 M/s (1.7 MB)  | 8.2 M/s (1.4 MB)  |
| 128                |  6.6 M/s (2.2 MB)  | 6.6 M/s (1.7 MB)  |
| 256                |  3.7 M/s (4.2 MB)  | 4.8 M/s (2.3 MB)  |
| 512                |  2.1 M/s (8.2 MB)  | 3.1 M/s (3.8 MB)  |
| 1024               |  1.1 M/s (16 MB)   | 1.9 M/s (6.5 MB)  |
| 2048               |  0.6 M/s (32 MB)   | 1.1 M/s (12 MB)   |
| 4096               |  0.3 M/s (64 MB)   | 0.6 M/s (23 MB)   |

| string in file     | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  6.8 M/s (29 MB)   | 6.0 M/s (23 MB)   |
| string in BTF      |  7.2 M/s (22 MB)   | 6.9 M/s (16 MB)   |
| alexa top 1M sites |  2.7 M/s (191 MB)  | 3.1 M/s (138 MB)  |

b) update and delete operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                |  5.0 M/s           | 3.5 M/s           |
| 128                |  3.8 M/s           | 3.3 M/s           |
| 256                |  2.7 M/s           | 2.7 M/s           |
| 512                |  1.7 M/s           | 2.0 M/s           |
| 1024               |  0.9 M/s           | 1.4 M/s           |
| 2048               |  0.5 M/s           | 0.8 M/s           |
| 4096               |  0.l M/s           | 0.5 M/s           |

| strings in file    | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  3.3 M/s           | 2.6 M/s           |
| strings in BTF     |  3.7 M/s           | 3.0 M/s           |
| alexa top 1M sites |  2.3 M/s           | 2.2 M/s           |

As usual, comments and suggestions are always welcome.

---

Change Log:

v3: mainly address comments and suggestions from Alexei
 * use ->map_check_btf callback to check whether the map attributes
   are valid for dynptr-key map and to initialize the allocator for
   dynptr
 * don't use map_extra for hash map with dynptr key.
 * don't increase BTF_FIELDS_MAX
 * lift the max number of bpf_dynptr in map key from 1 to 2
 * merge the definition of bpf_dynptr_user into bpf_dynptr
 * disable the support of the iteration of dynptr-keyed map
 * add negative lookup test in benchmark
 * move the definition of bpf_dynptr_user_init from bpf_util to
   testing_helpers.h, otherwise it will break the build of samples/bpf
 * update benchmark result based on bpf_next/master
 * rebased on bpf_next/for-next

v2: https://lore.kernel.org/bpf/20250125111109.732718-1-houtao@huaweicloud.com/
  * remove the need to set BPF_F_DYNPTR_IN_KEY flag explicitly
  * remove bpf_dynptr_user helpers from libbpf
  * support dynptr-keyed map in verifier in a less-intrusive way
  * handle the return value of kvmemdup_bpfptr() correctly
  * add necessary comments for ->record and ->key_record
  * use __bpf_md_ptr to define the data field of bpf_dynptr_user
  * add always_inline for lookup_{nulls_elem|elem}_raw
  * add benchmark patch for dynptr-keyed hash map

v1: https://lore.kernel.org/bpf/20241008091501.8302-1-houtao@huaweicloud.com/

[1]: https://lore.kernel.org/bpf/CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com/

Hou Tao (16):
  bpf: Introduce BPF_DYNPTR and helpers to facilitate its parsing
  bpf: Parse bpf_dynptr in map key
  bpf: Add helper bpf_map_has_dynptr_key()
  bpf: Split check_stack_range_initialized() into small functions
  bpf: Support map key with dynptr in verifier
  bpf: Reuse bpf_dynptr for userspace application use case
  bpf: Handle bpf_dynptr in bpf syscall when it is used as input
  bpf: Handle bpf_dynptr in bpf syscall when it is used as output
  bpf: Support basic operations for dynptr key in hash map
  bpf: Export bpf_dynptr_set_size
  bpf: Support get_next_key operation for dynptr key in hash map
  bpf: Disable unsupported operations for map with dynptr key
  bpf: Enable the creation of hash map with dynptr key
  selftests/bpf: Add bpf_dynptr_user_init() helper
  selftests/bpf: Add test cases for hash map with dynptr key
  selftests/bpf: Add benchmark for dynptr key support in hash map

 include/linux/bpf.h                           |  22 +-
 include/linux/btf.h                           |   2 +
 include/uapi/linux/bpf.h                      |  11 +-
 kernel/bpf/btf.c                              |  46 +-
 kernel/bpf/hashtab.c                          | 330 ++++++++-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/map_in_map.c                       |  21 +-
 kernel/bpf/map_iter.c                         |   3 +
 kernel/bpf/syscall.c                          | 216 +++++-
 kernel/bpf/verifier.c                         | 392 ++++++++---
 tools/include/uapi/linux/bpf.h                |  11 +-
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  14 +
 .../selftests/bpf/benchs/bench_dynptr_key.c   | 648 ++++++++++++++++++
 .../bpf/benchs/run_bench_dynptr_key.sh        |  51 ++
 .../bpf/prog_tests/htab_dynkey_test.c         | 446 ++++++++++++
 .../selftests/bpf/progs/dynptr_key_bench.c    | 249 +++++++
 .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++
 .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |   9 +
 20 files changed, 2958 insertions(+), 165 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_dynptr_key.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_key_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c

-- 
2.46.1


