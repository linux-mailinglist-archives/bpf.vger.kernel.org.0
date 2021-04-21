Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357FF366AAE
	for <lists+bpf@lfdr.de>; Wed, 21 Apr 2021 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhDUMZc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Apr 2021 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhDUMZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Apr 2021 08:25:30 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA01C06138A
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 05:24:56 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id x15-20020a0ce0cf0000b029019cb3e75c62so13538557qvk.15
        for <bpf@vger.kernel.org>; Wed, 21 Apr 2021 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=OD2jJ9yLCKnYZIcD98cpt1RR7ymAHhRQ2H9+zlmmjug=;
        b=Avtml08dV8RD/7rMgmE8OvfgkjFdUDKpPY/pGUuZzrs4SHKHLGtOaYo/MEW4pVtG3A
         Yvm2aK343VzqaJksCf19+sHWvrbtM7zz5B8N7J+QhUqieWsel9Po8IVRfk+LoCHw4qAl
         WkMdgnNXw/jJ4paY1dzzBdUpFK+wTHotoj9Iuo/IzjnXWVMUtAS9ptqW1R+qjK8F/Lhh
         N8BU5qKoBvxc2vW0I9UTSoIxLlt/HEqTVDdlontCV+qTfNQnkmdQ2KPjqtjjwNsNgUxT
         7QZW3LiixvtvtEbeBnceOU8FJx6orLMTyS+eWDh6IfNjspUAOAewHp50hN95RkaR0kT2
         ELmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=OD2jJ9yLCKnYZIcD98cpt1RR7ymAHhRQ2H9+zlmmjug=;
        b=qc1Gjb6YxutMvyLEkmxqF6iZQQ+wtcshkVtD0HNW4nAHgBc/OEvNvWg7F6Aqzs58i5
         gmmJDdEgqcG/kcBeAh6CVTxY6Ry48UUHW28tbQPLUhlabY9QIYNyiAaUJxn0ZlM4+tR8
         vgT8/nlhRm2BFkPAnN4j/fduV7Z/BS0b1M4NaMMsgu0IEDwgBICcc+KYv3dqwpUz99Gu
         +skdFjmlMykhdUCzuJWe1GgGZw7aQ5aBYJ6wLjS/f/2KEkwGxdFO/CUULD0gKm58I9Iy
         BS7YrS5vA+orRFSsG8RN8/NIGP30AXg7/1z322S0m/mQwtIG4+gp/RwGhnDDaa9pEHzp
         0WRQ==
X-Gm-Message-State: AOAM530gzISW3XfEwVAr+gfrR95W1efNckUu9Cu+bEQQUJFeo6CW6vXl
        OBIjHz3CSK/NwnGfmD5U7/7Oi0XWjXB69xLbOEVtkK1LCqBSuN9FLzwB+NZ9QeTZFWL+2AbUBDK
        f+Hw8BIjlaiA7+islNhYspTDfVc6/LqhxgSG4I+6+fM3dAwaLpM+M1AQ5Ja6/EHg=
X-Google-Smtp-Source: ABdhPJwdPqK7TVpIQ7Pri5OSevKRBEwXc8ZU2QtGuP5x3Hg+8x8ccehM6kZA+SSmO+esKvGhPL5q7ilIY2JSKw==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:f802:: with SMTP id
 r2mr32315555qvn.50.1619007895392; Wed, 21 Apr 2021 05:24:55 -0700 (PDT)
Date:   Wed, 21 Apr 2021 12:23:48 +0000
Message-Id: <20210421122348.547922-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Help with verifier failure
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Recently when our internal Clang build was updated to 0e92cbd6a652 we start=
ed
hitting a verifier issue that I can't see an easy fix for. I've narrowed it=
 down
to a minimal reproducer - this email is a patch to add that repro as a prog
test (./test_progs -t example).

Here's the BPF code I get from the attached source:

0000000000000000 <exec>:
; int BPF_PROG(exec, struct linux_binprm *bprm) {
       0:       79 11 00 00 00 00 00 00 r1 =3D *(u64 *)(r1 + 0)
       1:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 24) =3D r1
;   uint64_t args_size =3D bprm->argc & 0xFFFFFFF;
       2:       61 17 58 00 00 00 00 00 r7 =3D *(u32 *)(r1 + 88)
       3:       b4 01 00 00 00 00 00 00 w1 =3D 0
;   int map_key =3D 0;
       4:       63 1a fc ff 00 00 00 00 *(u32 *)(r10 - 4) =3D r1
       5:       bf a2 00 00 00 00 00 00 r2 =3D r10
       6:       07 02 00 00 fc ff ff ff r2 +=3D -4
;   void *buf =3D bpf_map_lookup_elem(&buf_map, &map_key);
       7:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0 ll
       9:       85 00 00 00 01 00 00 00 call 1
      10:       7b 0a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) =3D r0
      11:       57 07 00 00 ff ff ff 0f r7 &=3D 268435455
      12:       bf 76 00 00 00 00 00 00 r6 =3D r7
;   if (!buf)
      13:       16 07 12 00 00 00 00 00 if w7 =3D=3D 0 goto +18 <LBB0_7>
      14:       79 a1 f0 ff 00 00 00 00 r1 =3D *(u64 *)(r10 - 16)
      15:       15 01 10 00 00 00 00 00 if r1 =3D=3D 0 goto +16 <LBB0_7>
      16:       b4 09 00 00 00 00 00 00 w9 =3D 0
      17:       b7 01 00 00 00 10 00 00 r1 =3D 4096
      18:       bf 68 00 00 00 00 00 00 r8 =3D r6
      19:       05 00 0e 00 00 00 00 00 goto +14 <LBB0_3>

00000000000000a0 <LBB0_5>:
;     void *src =3D (void *)(char *)bprm->p + offset;
      20:       79 a1 e8 ff 00 00 00 00 r1 =3D *(u64 *)(r10 - 24)
      21:       79 13 18 00 00 00 00 00 r3 =3D *(u64 *)(r1 + 24)
;     uint64_t read_size =3D args_size - offset;
      22:       0f 73 00 00 00 00 00 00 r3 +=3D r7
      23:       07 03 00 00 00 f0 ff ff r3 +=3D -4096
;     (void) bpf_probe_read_user(buf, read_size, src);
      24:       79 a1 f0 ff 00 00 00 00 r1 =3D *(u64 *)(r10 - 16)
      25:       85 00 00 00 70 00 00 00 call 112
;   for (int i =3D 0; i < 512 && offset < args_size; i++) {
      26:       26 09 05 00 fe 01 00 00 if w9 > 510 goto +5 <LBB0_7>
      27:       07 08 00 00 00 f0 ff ff r8 +=3D -4096
      28:       bf 71 00 00 00 00 00 00 r1 =3D r7
      29:       07 01 00 00 00 10 00 00 r1 +=3D 4096
      30:       04 09 00 00 01 00 00 00 w9 +=3D 1
;   for (int i =3D 0; i < 512 && offset < args_size; i++) {
      31:       ad 67 02 00 00 00 00 00 if r7 < r6 goto +2 <LBB0_3>

0000000000000100 <LBB0_7>:
; int BPF_PROG(exec, struct linux_binprm *bprm) {
      32:       b4 00 00 00 00 00 00 00 w0 =3D 0
      33:       95 00 00 00 00 00 00 00 exit

0000000000000110 <LBB0_3>:
      34:       bf 17 00 00 00 00 00 00 r7 =3D r1
;     (void) bpf_probe_read_user(buf, read_size, src);
      35:       bc 82 00 00 00 00 00 00 w2 =3D w8
      36:       a5 08 ef ff 00 10 00 00 if r8 < 4096 goto -17 <LBB0_5>
      37:       b4 02 00 00 00 10 00 00 w2 =3D 4096
      38:       05 00 ed ff 00 00 00 00 goto -19 <LBB0_5>


The full log I get is at
https://gist.githubusercontent.com/bjackman/2928c4ff4cc89545f3993bddd9d5edb=
2/raw/feda6d7c165d24be3ea72c3cf7045c50246abd83/gistfile1.txt,
but basically the verifier runs through the loop a large number of times, g=
oing
down the true path of the `if (read_size > CHUNK_LEN)` every time. Then
eventually it takes the false path.

In the disassembly this is basically instructions 35-37 - pseudocode:
  w2 =3D w8
  if (r8 < 4096) {
    w2 =3D 4096
  }

w2 can't exceed 4096 but the verifier doesn't seem to "backpropagate" those
bounds from r8 (note the umax_value for R8 goes to 4095 after the branch fr=
om 36
to 20, but R2's umax_value is still 266342399)

from 31 to 34: R0_w=3Dinv(id=3D0) R1_w=3Dinv2097152 R6=3Dinv(id=3D2,umin_va=
lue=3D2093057,umax_value=3D268435455,var_off=3D(0x0; 0xfffffff)) R7_w=3Dinv=
2093056 R8_w=3Dinv(id=3D0,umax_value=3D266342399,var_off=3D(0x0; 0xfffffff)=
) R9_w=3DinvP511 R10=3Dfp0 fp-8=3Dmmmm???? fp-16=3Dmap_value fp-24=3Dptr_
; int BPF_PROG(exec, struct linux_binprm *bprm) {
34: (bf) r7 =3D r1
; (void) bpf_probe_read_user(buf, read_size, src);
35: (bc) w2 =3D w8
36: (a5) if r8 < 0x1000 goto pc-17

from 36 to 20: R0_w=3Dinv(id=3D0) R1_w=3Dinv2097152 R2_w=3Dinv(id=3D0,umax_=
value=3D266342399,var_off=3D(0x0; 0xfffffff)) R6=3Dinv(id=3D2,umin_value=3D=
2093057,umax_value=3D268435455,var_off=3D(0x0; 0xfffffff)) R7_w=3Dinv209715=
2 R8_w=3Dinv(id=3D0,umax_value=3D4095,var_off=3D(0x0; 0xfff)) R9_w=3DinvP51=
1 R10=3Dfp0 fp-8=3Dmmmm???? fp-16=3Dmap_value fp-24=3Dptr_
; void *src =3D (void *)(char *)bprm->p + offset;
20: (79) r1 =3D *(u64 *)(r10 -24)
21: (79) r3 =3D *(u64 *)(r1 +24)
; uint64_t read_size =3D args_size - offset;
22: (0f) r3 +=3D r7
23: (07) r3 +=3D -4096
; (void) bpf_probe_read_user(buf, read_size, src);
24: (79) r1 =3D *(u64 *)(r10 -16)
25: (85) call bpf_probe_read_user#112
 R0_w=3Dinv(id=3D0) R1_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D4096,imm=3D=
0) R2_w=3Dinv(id=3D0,umax_value=3D266342399,var_off=3D(0x0; 0xfffffff)) R3_=
w=3Dinv(id=3D0) R6=3Dinv(id=3D2,umin_value=3D2093057,umax_value=3D268435455=
,var_off=3D(0x0; 0xfffffff)) R7_w=3Dinv2097152 R8_w=3Dinv(id=3D0,umax_value=
=3D4095,var_off=3D(0x0; 0xfff)) R9_w=3DinvP511 R10=3Dfp0 fp-8=3Dmmmm???? fp=
-16=3Dmap_value fp-24=3Dptr_
 R0_w=3Dinv(id=3D0) R1_w=3Dmap_value(id=3D0,off=3D0,ks=3D4,vs=3D4096,imm=3D=
0) R2_w=3Dinv(id=3D0,umax_value=3D266342399,var_off=3D(0x0; 0xfffffff)) R3_=
w=3Dinv(id=3D0) R6=3Dinv(id=3D2,umin_value=3D2093057,umax_value=3D268435455=
,var_off=3D(0x0; 0xfffffff)) R7_w=3Dinv2097152 R8_w=3Dinv(id=3D0,umax_value=
=3D4095,var_off=3D(0x0; 0xfff)) R9_w=3DinvP511 R10=3Dfp0 fp-8=3Dmmmm???? fp=
-16=3Dmap_value fp-24=3Dptr_
invalid access to map value, value_size=3D4096 off=3D0 size=3D266342399
R1 min value is outside of the allowed memory range
processed 9239 insns (limit 1000000) max_states_per_insn 4 total_states 133=
 peak_states 133 mark_read 2

This seems like it must be a common pitfall, any idea what we can do to fix=
 it
and avoid it in future? Am I misunderstanding the issue?

Cheers,
Brendan

---
 .../selftests/bpf/prog_tests/example.c        | 17 ++++++++
 tools/testing/selftests/bpf/progs/example.c   | 42 +++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/example.c
 create mode 100644 tools/testing/selftests/bpf/progs/example.c

diff --git a/tools/testing/selftests/bpf/prog_tests/example.c b/tools/testi=
ng/selftests/bpf/prog_tests/example.c
new file mode 100644
index 000000000000..9c36858019b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/example.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#include "example.skel.h"
+
+void test_example(void)
+{
+	struct example *skel;
+	__u32 duration =3D 0;
+
+	skel =3D example__open_and_load();
+	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
+		return;
+
+	example__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/example.c b/tools/testing/se=
lftests/bpf/progs/example.c
new file mode 100644
index 000000000000..6c90060e92e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/example.c
@@ -0,1 +1,42 @@
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+#define CHUNK_LEN (uint64_t)4096
+struct {
+  __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+  __uint(key_size, sizeof(int));
+  __uint(value_size, CHUNK_LEN);
+  __uint(max_entries, 1);
+} buf_map SEC(".maps");
+
+SEC("lsm/bprm_committed_creds")
+int BPF_PROG(exec, struct linux_binprm *bprm) {
+  /* Actual value doesn't make sense here, just picking something unknown =
to the
+   * verifier that produces simple disassembly
+   */
+  uint64_t args_size =3D bprm->argc & 0xFFFFFFF;
+  int map_key =3D 0;
+  void *buf =3D bpf_map_lookup_elem(&buf_map, &map_key);
+  uint64_t offset =3D 0;
+  if (!buf)
+    return 0;
+
+  for (int i =3D 0; i < 512 && offset < args_size; i++) {
+    void *src =3D (void *)(char *)bprm->p + offset;
+    uint64_t read_size =3D args_size - offset;
+
+    if (read_size > CHUNK_LEN) {
+      read_size =3D CHUNK_LEN;
+    }
+
+    (void) bpf_probe_read_user(buf, read_size, src);
+
+    offset +=3D CHUNK_LEN;
+  }
+
+  return 0;
+}
--
2.31.1.368.gbe11c130af-goog

