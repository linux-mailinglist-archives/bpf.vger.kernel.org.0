Return-Path: <bpf+bounces-52400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED1A42A7A
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96984189AD20
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD22627E1;
	Mon, 24 Feb 2025 17:55:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547B264FB6
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419731; cv=none; b=uqEIJ7lThSQLjmEeA6i/Qz6zYc7YOEy6fx3LdmS0QCmx5KQ2oOR0jJhY2rq4PxJfoMk3dTRhxJ4Vkp4TxTwfZ8IBQ27zO6GGWtrJrP+VCTU7nUqKz0HQdVmq28gVRtd9oGmxNk895Hotq1A35dhCyFr3bPiWOHIvAV8kAtdF0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419731; c=relaxed/simple;
	bh=79iUO6K7aT9JLGDFaKkPiMbedwCfVgqTJLvQqlkMZm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7m6yi7fgwaQHTDmKywEQox/gBG80IMuOrjn+/mIxkYBbN2Nh3LDk0YHugwEfxJuxGlRiH0YgcoyB92ajqt26WExuBXBMo52rS7b9sUzIEbZnTnsf9CVYVBH1nV1vgF4kLAt+fsh7hCIs/AOBAW0a4M5knrcPKayinE8bm/Myjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 06F911C8D612; Mon, 24 Feb 2025 09:55:15 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Vlad Poenaru <thevlad@meta.com>
Subject: [PATCH bpf-next] bpf: Fix kmemleak warnings for percpu hashmap
Date: Mon, 24 Feb 2025 09:55:14 -0800
Message-ID: <20250224175514.2207227-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Vlad Poenaru from Meta reported the following kmemleak issues:

  ...
  unreferenced object 0x606fd7c44ac8 (size 32):
    comm "floodgate_agent", pid 5077, jiffies 4294746072
    hex dump (first 32 bytes on cpu 32):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc 0):
      pcpu_alloc_noprof+0x730/0xeb0
      bpf_map_alloc_percpu+0x69/0xc0
      prealloc_init+0x9d/0x1b0
      htab_map_alloc+0x363/0x510
      map_create+0x215/0x3a0
      __sys_bpf+0x16b/0x3e0
      __x64_sys_bpf+0x18/0x20
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x4b/0x53
  unreferenced object 0x606fd7c44ae8 (size 32):
    comm "floodgate_agent", pid 5077, jiffies 4294746072
    hex dump (first 32 bytes on cpu 32):
      d3 08 00 00 00 00 00 00 d3 08 00 00 00 00 00 00  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc d197b0fe):
      pcpu_alloc_noprof+0x730/0xeb0
      bpf_map_alloc_percpu+0x69/0xc0
      prealloc_init+0x9d/0x1b0
      htab_map_alloc+0x363/0x510
      map_create+0x215/0x3a0
      __sys_bpf+0x16b/0x3e0
      __x64_sys_bpf+0x18/0x20
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x4b/0x53
  ...

Further investigation shows the reason is due to not 8-byte aligned
store of percpu pointer in htab_elem_set_ptr():
  *(void __percpu **)(l->key + key_size) =3D pptr;

Note that the whole htab_elem alignment is 8 (for x86_64). If the key_siz=
e
is 4, that means pptr is stored in a location which is 4 byte aligned but
not 8 byte aligned. In mm/kmemleak.c, scan_block() scans the memory based
on 8 byte stride, so it won't detect above pptr, hence reporting the memo=
ry
leak.

In htab_map_alloc(), we already have

        htab->elem_size =3D sizeof(struct htab_elem) +
                          round_up(htab->map.key_size, 8);
        if (percpu)
                htab->elem_size +=3D sizeof(void *);
        else
                htab->elem_size +=3D round_up(htab->map.value_size, 8);

So storing pptr with 8-byte alignment won't cause any problem and can fix
kmemleak too.

The issue can be reproduced with bpf selftest as well:
  1. Enable CONFIG_DEBUG_KMEMLEAK config
  2. Add a getchar() before skel destroy in test_hash_map() in prog_tests=
/for_each.c.
     The purpose is to keep map available so kmemleak can be detected.
  3. run './test_progs -t for_each/hash_map &' and a kmemleak should be r=
eported.

     unreferenced object 0x607e08c1fd30 (size 8):
       comm "test_progs", pid 1969, jiffies 4294706961
       hex dump (first 8 bytes on cpu 2):
         03 00 00 00 00 00 00 00                          ........
       backtrace (crc 844a0efa):
         pcpu_alloc_noprof+0xf33/0x14a0
         bpf_map_alloc_percpu+0x9c/0x200
         prealloc_init+0x1e7/0x730
         htab_map_alloc+0x698/0xc70
         map_create+0x489/0xcb0
         __sys_bpf+0x443/0x560
         __x64_sys_bpf+0x7c/0x90
         do_syscall_64+0x58/0xf0
         entry_SYSCALL_64_after_hwframe+0x76/0x7e

cc: Vlad Poenaru <thevlad@meta.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/hashtab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..c308300fc72f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -198,12 +198,12 @@ static bool htab_is_percpu(const struct bpf_htab *h=
tab)
 static inline void htab_elem_set_ptr(struct htab_elem *l, u32 key_size,
 				     void __percpu *pptr)
 {
-	*(void __percpu **)(l->key + key_size) =3D pptr;
+	*(void __percpu **)(l->key + roundup(key_size, 8)) =3D pptr;
 }
=20
 static inline void __percpu *htab_elem_get_ptr(struct htab_elem *l, u32 =
key_size)
 {
-	return *(void __percpu **)(l->key + key_size);
+	return *(void __percpu **)(l->key + roundup(key_size, 8));
 }
=20
 static void *fd_htab_map_get_ptr(const struct bpf_map *map, struct htab_=
elem *l)
@@ -2354,7 +2354,7 @@ static int htab_percpu_map_gen_lookup(struct bpf_ma=
p *map, struct bpf_insn *insn
 	*insn++ =3D BPF_EMIT_CALL(__htab_map_lookup_elem);
 	*insn++ =3D BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 3);
 	*insn++ =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_0,
-				offsetof(struct htab_elem, key) + map->key_size);
+				offsetof(struct htab_elem, key) + roundup(map->key_size, 8));
 	*insn++ =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
 	*insn++ =3D BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
=20
--=20
2.43.5


