Return-Path: <bpf+bounces-49785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F4A1C2CF
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607003A6441
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FF6207DF8;
	Sat, 25 Jan 2025 10:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7EA1DB154
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802754; cv=none; b=mbY9kfEq6oLVaknuvLmqQkPwsdD7Em8S6GUJzzaI5rkZXKN8NCkb6nYiLEg6dl2jda/zWCNdE/+3xSOZOnXYeO+pOwljkxiY09Gmjol/AoW9GXkeQNdGS+DG6XgFNdhitTc+D/NTiww7n0I4326F7onu7n1k7tz1+FAJ6wQK+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802754; c=relaxed/simple;
	bh=FoLuAmC0+ybBKKcbKFN5mUJIY1uvWwLxTl6ZYh+6jUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YKuE91ifxhwvT1cf1TxMrp2+Q6nfBd3LehP3SK4CiklJkZ0kXPXXvil24b1ldjJo2igMwfzdzIArbeFb9TC2jNn6FCthiHCOKP97jIEVBFjONbAvu7G4BZJRChpOfOLRpvzI/O3Bx2kcRDAhx+R850J5H3j0JY973t7ZmzQ5cH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWC2trtz4f3jqx
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E7E081A0DDA
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S4;
	Sat, 25 Jan 2025 18:59:01 +0800 (CST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 00/20] Support dynptr key for hash map
Date: Sat, 25 Jan 2025 19:10:49 +0800
Message-Id: <20250125111109.732718-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47AF18tr47Ary7uFWrGrg_yoW3ur1kpa
	y0g3y3tryxtFy7Xw47Ca1xAr4Fvw4kXw1UG3Wxt348G34UXryfZr1xK3W09F9xtryFqr45
	Zwn7tr93uw10kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UZ4SrUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to add the basic dynptr key support for hash map as
discussed in [1]. The main motivation is to fully utilize the BTF info
of the map key and to support variable-length key (e.g., string or any
byte stream) for bpf map. The patch set uses bpf_dynptr to represent the
variable-length part in the map key and the total number of
variable-length parts in the map key is limited as 1 now. Due to the
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
is only treated as a read-only 16-bytes buffer.

The patch set is structured as follow:

Patch #1~#2 introduce BPF_DYNPTR in btf_field_type and parse the
bpf_dynptr in the map key.

Patch #3~#7 remove the need to specify BPF_F_DYNPTR_IN_KEY explicitly,
introduces an internal BPF_INT_F_DYNPTR_IN_KEY map flag, set the
internal flag when there is any bpf_dynptr in the map key btf, and also
verify the value of max_extra is valid when it is set.

Patch #8~#9 refactor check_stack_range_initialized() and support
dynptr-keyed map in verifier.

Patch #10~#12 introduce bpf_dynptr_user, support the use of
bpf_dynptr_user in bpf syscall for map lookup, lookup_delete, update,
delete and get_next_key operations.

Patch #13~#17 update the lookup, lookup_delete, update, delete and
get_next_key callback correspondingly to support dynptr-keyed hash map.

Patch #18~#19 add positive and negative test cases for hash map with
dynptr key support.

Patch #20 adds the benchmark to compare the lookup and update
performance between normal hash map and dynptr-keyed hash map.

Patch set v2 mainly address the suggestions and comments in v1. It
mainly includes:
1) remove the need to set BPF_F_DYNPTR_IN_KEY flag explicitly
2) remove bpf_dynptr_user helpers from libbpf
3) support dynptr-keyed map in verifier in a less-intrusive way
4) add always_inline for lookup_{nulls_elem|elem}_raw to alleviate
   the performance degradation

The performance results in v2 are almost the same as v1. When the max
length of str is greater than 256, the lookup performance of dynptr
hash-map will be better than the normal hash map. When the max length is
greater than 512, the update performance of dynptr hash map will be
better than the normal hash map. And the memory consumption of hash-map
with dynptr key is smaller compared with normal hash map.

a) lookup operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                | 12.0 M/s (1.7 MB)  | 8.3 M/s (1.4 MB)  |
| 128                |  6.4 M/s (2.2 MB)  | 6.6 M/s (1.7 MB)  |
| 256                |  3.7 M/s (4.2 MB)  | 4.8 M/s (2.3 MB)  |
| 512                |  2.1 M/s (8.2 MB)  | 3.1 M/s (3.8 MB)  |
| 1024               |  1.1 M/s (16 MB)   | 1.9 M/s (6.5 MB)  |
| 2048               |  0.6 M/s (32 MB)   | 1.1 M/s (12 MB)   |
| 4096               |  0.3 M/s (64 MB)   | 0.6 M/s (22 MB)   |

| string in file     | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  7.7 M/s (29 MB)   | 7.3 M/s (22 MB)   |
| string in BTF      |  8.0 M/s (22 MB)   | 7.3 M/s (16 MB)   |
| alexa top 1M sites |  3.9 M/s (191 MB)  | 3.7 M/s (138 MB)  |

b) update and delete operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                |  5.0 M/s           | 3.6 M/s           |
| 128                |  3.8 M/s           | 3.4 M/s           |
| 256                |  2.7 M/s           | 2.7 M/s           |
| 512                |  1.7 M/s           | 2.1 M/s           |
| 1024               |  0.9 M/s           | 1.5 M/s           |
| 2048               |  0.5 M/s           | 0.9 M/s           |
| 4096               |  0.3 M/s           | 0.5 M/s           |

| strings in file    | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  3.9 M/s           | 2.9 M/s           |
| strings in BTF     |  4.1 M/s           | 3.3 M/s           |
| alexa top 1M sites |  2.7 M/s           | 2.5 M/s           |

As usual, comments and suggestions are always welcome.

PS: I will soon start my long Chinese Lunar New Year holiday, so my
replies may be a bit slow.

---

Change Log:
v2:
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

Hou Tao (20):
  bpf: Add two helpers to facilitate the parsing of bpf_dynptr
  bpf: Parse bpf_dynptr in map key
  bpf: Factor out get_map_btf() helper
  bpf: Move the initialization of btf before ->map_alloc_check
  bpf: Introduce an internal map flag BPF_INT_F_DYNPTR_IN_KEY
  bpf: Set BPF_INT_F_DYNPTR_IN_KEY conditionally
  bpf: Use map_extra to indicate the max data size of dynptrs in map key
  bpf: Split check_stack_range_initialized() into small functions
  bpf: Support map key with dynptr in verifier
  bpf: Introduce bpf_dynptr_user
  bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
  bpf: Handle bpf_dynptr_user in bpf syscall when it is used as output
  bpf: Support basic operations for dynptr key in hash map
  bpf: Export bpf_dynptr_set_size
  bpf: Support get_next_key operation for dynptr key in hash map
  bpf: Disable unsupported operations for map with dynptr key
  bpf: Enable BPF_INT_F_DYNPTR_IN_KEY for hash map
  selftests/bpf: Add bpf_dynptr_user_init() helper
  selftests/bpf: Add test cases for hash map with dynptr key
  selftests/bpf: Add benchmark for dynptr key support in hash map

 include/linux/bpf.h                           |  40 +-
 include/linux/btf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   6 +
 kernel/bpf/btf.c                              |  46 +-
 kernel/bpf/hashtab.c                          | 319 ++++++++-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/map_in_map.c                       |  21 +-
 kernel/bpf/syscall.c                          | 363 +++++++++--
 kernel/bpf/verifier.c                         | 373 ++++++++---
 tools/include/uapi/linux/bpf.h                |   6 +
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  10 +
 .../selftests/bpf/benchs/bench_dynptr_key.c   | 612 ++++++++++++++++++
 .../bpf/benchs/run_bench_dynptr_key.sh        |  51 ++
 tools/testing/selftests/bpf/bpf_util.h        |   9 +
 .../bpf/prog_tests/htab_dynkey_test.c         | 427 ++++++++++++
 .../selftests/bpf/progs/cpumask_common.h      |   2 +-
 .../selftests/bpf/progs/dynptr_key_bench.c    | 250 +++++++
 .../bpf/progs/htab_dynkey_test_failure.c      | 216 +++++++
 .../bpf/progs/htab_dynkey_test_success.c      | 383 +++++++++++
 20 files changed, 2946 insertions(+), 194 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_dynptr_key.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_dynptr_key.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynptr_key_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c

-- 
2.29.2


