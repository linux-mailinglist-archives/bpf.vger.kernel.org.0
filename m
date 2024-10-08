Return-Path: <bpf+bounces-41199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7FA99439F
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231A8B20FC1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B98178384;
	Tue,  8 Oct 2024 09:02:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F13C827
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378151; cv=none; b=adc4vfh1RAgYhPP6ot/RhV/6JXOPM7KJ5cBXYdtlk7BwtquyopzScgk5Yi71uWMgDc1S48zdC+CVNpDZBW7p3hgHUjoeAUvuywZwCz1t2leJY4PwywDyHwRGCiEw0EKj+Rp+EPCCl0i08HE93wl1H/4pbcK2Vt1nKINPdKPfNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378151; c=relaxed/simple;
	bh=yHUt9QyWE3vnnQPt5wTBR4XfGqzL20PL6N9aOdb0Pi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTvqmZ0Ox0QnciZ9zLmRuVAMfTL9TCTVs7bep0YihWFRhBjDCqHpvw4137DssQtAKuuXdd0KnkfZyA2MgiRqTSoRouj97w3go086s9W2SexpxHykXtTmpAL1n1JF/ypl/dKneSHYQ1odxI111L5Q8FJA+T2CF/28ih1uYU6MCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XN94v52Sfz4f3jY1
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8064A1A08FC
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S4;
	Tue, 08 Oct 2024 17:02:22 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 00/16] Support dynptr key for hash map
Date: Tue,  8 Oct 2024 17:14:45 +0800
Message-ID: <20241008091501.8302-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF47AF18tr47Ary7tF17trb_yoWxuryxpa
	y0g3y3trWxtFy7Xw43Aa1xAFWFvws5uw1UGF18t34Fk34kX343ZrWxK3ZY9F98tryfWr4f
	Zw1Dt343uw18CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbX4S5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to add the basic dynptr key support for hash map as
discussed in [1]. The main motivation is to fully utilize the BTF info
of the map key and to support variable-length key (e.g., string or any
byte stream) for bpf map. The patch set uses bpf_dynptr to represent the
variable-length part in the map key and the total number of
variable-length parts in the map key is limited as 4 now. And due to the
limitation in bpf memory allocator, the max size of dynptr in map key is
limited as 4088 bytes. Beside the variable-length parts (dynptr parts),
the fixed-size part in map key is still allowed, so all of the following
map key definitions are valid:

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

The patch set supports lookup, update, delete operations on hash map
with dynptr key for both bpf program and bpf syscall. It also supports
lookup_and_delete and get_next_key operations on dynptr map key for bpf
syscall.

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

Patch #1~#5 introduce BPF_F_DYNPTR_IN_KEY map flag, parse the bpf_dynptr
in the map key and verify the use of bpf_dynptr in map related helpers.

Patch #6~#10 introduce bpf_dynptr_user, support the use of
bpf_dynptr_user in bpf syscall for map lookup, lookup_delete, update,
delete and get_next_key operations.

Patch #11~#15 update the lookup, lookup_delete, update, delete and
get_next_key callback correspondingly to support key with bpf_dynptr for
hash map.

Patch #16 adds positive and negative test cases for hash map with dynptr
key support.

The following are the benchmark results on hash map with dynptr key.

(1) the benchmark compares the performance and memory usage between
normal hash map and dynptr-keyed hash map.

The key definitions for these two maps are show below:

struct norm_key {
	__u64 cookie;
	unsigned char desc[MAX_LEN];
};

struct dynptr_key {
	__u64 cookie;
	struct bpf_dynptr_user desc;
};

When the max length of desc is greater than 256, the lookup performance
of dynptr hash-map will be better than the normal hash map. When the max
length is greater than 512, the update performance of dynptr hash map
will be better than the normal hash map. And the memory consumption of
hash-map with dynptr key is smaller compared with normal hash map.

a) lookup operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                | 12.1 M/s (? MB)    | 7.5 M/s (? MB)    |
| 128                |  7.5 M/s (? MB)    | 6.3 M/s (? MB)
| 256                |  4.6 M/s (4.9 MB)  | 4.9 M/s (? MB)    |
| 512                |  2.6 M/s (8.9 MB)  | 3.5 M/s (4.6 MB)  |
| 1024               |  1.3 M/s (17 MB)   | 2.2 M/s (7.4 MB)  |
| 2048               |  0.6 M/s (33 MB)   | 1.2 M/s (13 MB)   |
| 4096               |  0.3 M/s (65 MB)   | 0.6 M/s (24 MB)   |

| string in file     | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  5.4 M/s (32 MB)   | 5.4 M/s (25 MB)   |
| string in BTF      |  6.8 M/s (23 MB)   | 6.8 M/s (17 MB)   |
| alexa top 1M sites |  3.2 M/s (192 MB)  | 3.0 M/s (139 MB)  |

b) update and delete operation

max_entries = 8K (randomly generated data set)
| max length of desc | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
|  64                |  4.3 M/s           | 3.2 M/s           |
| 128                |  3.6 M/s           | 2.9 M/s           |
| 256                |  2.8 M/s           | 2.6 M/s           |
| 512                |  1.9 M/s           | 2.0 M/s           |
| 1024               |  1.0 M/s           | 1.3 M/s           |
| 2048               |  0.5 M/s           | 0.8 M/s           |
| 4096               |  0.3 M/s           | 0.5 M/s           |

| strings in file    | normal hash-map    | dynptr hash-map   |
| ---                |  ---               | ---               |
| kallsyms           |  3.0 M/s           | 2.0 M/s           |
| strings in BTF     |  3.9 M/s           | 3.0 M/s           |
| alexa top 1M sites |  2.4 M/s           | 2.3 M/s           |

(2) the benchmark uses map_perf_test under samples/bpf to test the
overhead of adding dynptr key support in hash map. The test is conducted
on a Intel Xeon CPU and the base kernel version is v6.11.

It seems adding dynptr key support in hash map degrades the lookup
performance about 12% and degrades the update performance about 7%. Will
investigate these degradation first.

a) lookup

max_entries = 8K

before:
0:hash_lookup 72347325 lookups per sec

after:
0:hash_lookup 64758890 lookups per sec

b) update/delete/lookup

max_entries = 8K

before:
0:hash_map_perf pre-alloc 675275 events per sec
0:hash_map_perf kmalloc 666535 events per sec

after:
0:hash_map_perf pre-alloc 626563 events per sec
0:hash_map_perf kmalloc 617234 events per sec

As usual, comments and suggestions are always welcome.

[1]: https://lore.kernel.org/bpf/CAADnVQJWaBRB=P-ZNkppwm=0tZaT3qP8PKLLJ2S5SSA2-S8mxg@mail.gmail.com/

Hou Tao (16):
  bpf: Introduce map flag BPF_F_DYNPTR_IN_KEY
  bpf: Add two helpers to facilitate the btf parsing of bpf_dynptr
  bpf: Parse bpf_dynptr in map key
  bpf: Pass flags instead of bool to check_helper_mem_access()
  bpf: Support map key with dynptr in verifier
  bpf: Introduce bpf_dynptr_user
  libbpf: Add helpers for bpf_dynptr_user
  bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
  bpf: Handle bpf_dynptr_user in bpf syscall when it is used as output
  bpf: Disable unsupported functionalities for map with dynptr key
  bpf: Add bpf_mem_alloc_check_size() helper
  bpf: Support basic operations for dynptr key in hash map
  bpf: Export bpf_dynptr_set_size
  bpf: Support get_next_key operation for dynptr key in hash map
  bpf: Enable BPF_F_DYNPTR_IN_KEY for hash map
  selftests/bpf: Add test cases for hash map with dynptr key

 include/linux/bpf.h                           |  22 +-
 include/linux/bpf_mem_alloc.h                 |   3 +
 include/linux/btf.h                           |   2 +
 include/uapi/linux/bpf.h                      |   9 +
 kernel/bpf/btf.c                              |  46 +-
 kernel/bpf/hashtab.c                          | 314 ++++++++++--
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/map_in_map.c                       |  19 +-
 kernel/bpf/memalloc.c                         |  14 +-
 kernel/bpf/syscall.c                          | 222 ++++++++-
 kernel/bpf/verifier.c                         | 183 ++++++-
 tools/include/uapi/linux/bpf.h                |   9 +
 tools/lib/bpf/bpf.h                           |  27 ++
 .../bpf/prog_tests/htab_dynkey_test.c         | 451 ++++++++++++++++++
 .../bpf/progs/htab_dynkey_test_failure.c      | 270 +++++++++++
 .../bpf/progs/htab_dynkey_test_success.c      | 399 ++++++++++++++++
 16 files changed, 1902 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dynkey_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_test_success.c

-- 
2.44.0


