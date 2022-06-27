Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6106F55C38E
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbiF0SY4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiF0SYi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 14:24:38 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186EA193F2
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 11:23:20 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o5tOB-000FYO-04; Mon, 27 Jun 2022 20:23:11 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf] bpf, docs: Better scale maintenance of BPF subsystem
Date:   Mon, 27 Jun 2022 20:22:55 +0200
Message-Id: <5bdc73e7f5a087299589944fa074563cdf2c2c1a.1656353995.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26586/Mon Jun 27 10:06:41 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The BPF subsystem consists of a large number of pieces. There is not a
single person that understands it all. Yet reviews are crucially important
for the BPF community to provide productive quality feedback to contributors
in a timely manner and therefore to ultimately expand the number of active
developers in the community.

So far, the BPF community had a two-stage review system, that is, a weekly
rotation among 7 developers (Alexei, Daniel, Andrii, Martin, Song, Yonghong,
John) as a first-level review of all inbound patches accompanied by a BPF CI
system which runs the in-tree BPF selftests to check for regressions for
every new patch, and then, a final check by Alexei, Daniel, Andrii to apply
the patches to either bpf or bpf-next trees.

This system worked well for the last ~3.5 years, but clearly reaches its
limits these days as it does not scale enough. Especially, as we also need
to allow enough room for every developer to contribute patches themselves,
integrate with their day to day job, and in particular avoid burnout. We
want to better scale both horizontally and vertically going forward.

On the horizontal scale, we are adding more developers (KP, Stan, Hao, Jiri)
to the overall core reviewer team, thus growing to 11 people in total. The
weekly rotation for the horizontal oncall reviewer is shortened to 1/2 week
(Mo - Wed and Thur - Fri). Instead of just patches, the coverage however
extends also generally to triage and reply to mailing list traffic (e.g. RFCs,
questions, etc).

On the vertical scale, there is clearly a need for deep expertise areas to
assign dedicated maintainer/reviewer teams that are responsible for code
reviews and help with design of individual building blocks. To some degree
we have been doing this implicitly, but the point is to formalize the teams
and commitment.

There is an overlap between areas and boundaries are intentionally grey. These
additional entries provide a guidance on who has to look at the patches. The
patch series which span multiple areas will be looked at by multiple people.
The vertical review with areas of deep expertise are bundled at the same time
with the horizontal side.

This patch cleans up a bit the BPF entries, adds mentioned developers to
the horizontal scale and creates new sub-entries with teams for developers
committing to the above outlined vertical scale.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Martin KaFai Lau <martin.lau@linux.dev>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Mykola Lysenko <mykolal@fb.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: KP Singh <kpsingh@kernel.org>
Acked-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
---
 MAINTAINERS | 108 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15a2341936ea..dbf978014e8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3614,16 +3614,18 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 F:	drivers/iio/accel/bma400*
 
-BPF (Safe dynamic programs and tools)
+BPF [GENERAL] (Safe Dynamic Programs and Tools)
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Andrii Nakryiko <andrii@kernel.org>
-R:	Martin KaFai Lau <kafai@fb.com>
-R:	Song Liu <songliubraving@fb.com>
+R:	Martin KaFai Lau <martin.lau@linux.dev>
+R:	Song Liu <song@kernel.org>
 R:	Yonghong Song <yhs@fb.com>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	KP Singh <kpsingh@kernel.org>
-L:	netdev@vger.kernel.org
+R:	Stanislav Fomichev <sdf@google.com>
+R:	Hao Luo <haoluo@google.com>
+R:	Jiri Olsa <jolsa@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Supported
 W:	https://bpf.io/
@@ -3660,7 +3662,6 @@ K:	bpf
 
 BPF JIT for ARM
 M:	Shubham Bansal <illusionist.neo@gmail.com>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
 F:	arch/arm/net/
@@ -3669,7 +3670,6 @@ BPF JIT for ARM64
 M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Zi Shen Lim <zlim.lnx@gmail.com>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/arm64/net/
@@ -3677,14 +3677,12 @@ F:	arch/arm64/net/
 BPF JIT for MIPS (32-BIT AND 64-BIT)
 M:	Johan Almbladh <johan.almbladh@anyfinetworks.com>
 M:	Paul Burton <paulburton@kernel.org>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/mips/net/
 
 BPF JIT for NFP NICs
 M:	Jakub Kicinski <kuba@kernel.org>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/net/ethernet/netronome/nfp/bpf/
@@ -3692,7 +3690,6 @@ F:	drivers/net/ethernet/netronome/nfp/bpf/
 BPF JIT for POWERPC (32-BIT AND 64-BIT)
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Michael Ellerman <mpe@ellerman.id.au>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/powerpc/net/
@@ -3700,7 +3697,6 @@ F:	arch/powerpc/net/
 BPF JIT for RISC-V (32-bit)
 M:	Luke Nelson <luke.r.nels@gmail.com>
 M:	Xi Wang <xi.wang@gmail.com>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/
@@ -3708,7 +3704,6 @@ X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn@kernel.org>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/
@@ -3718,7 +3713,6 @@ BPF JIT for S390
 M:	Ilya Leoshkevich <iii@linux.ibm.com>
 M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/s390/net/
@@ -3726,14 +3720,12 @@ X:	arch/s390/net/pnet.c
 
 BPF JIT for SPARC (32-BIT AND 64-BIT)
 M:	David S. Miller <davem@davemloft.net>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
 F:	arch/sparc/net/
 
 BPF JIT for X86 32-BIT
 M:	Wang YanQing <udknight@gmail.com>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Odd Fixes
 F:	arch/x86/net/bpf_jit_comp32.c
@@ -3741,13 +3733,60 @@ F:	arch/x86/net/bpf_jit_comp32.c
 BPF JIT for X86 64-BIT
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
-L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Supported
 F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
-BPF LSM (Security Audit and Enforcement using BPF)
+BPF [CORE]
+M:	Alexei Starovoitov <ast@kernel.org>
+M:	Daniel Borkmann <daniel@iogearbox.net>
+R:	John Fastabend <john.fastabend@gmail.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/verifier.c
+F:	kernel/bpf/tnum.c
+F:	kernel/bpf/core.c
+F:	kernel/bpf/syscall.c
+F:	kernel/bpf/dispatcher.c
+F:	kernel/bpf/trampoline.c
+F:	include/linux/bpf*
+F:	include/linux/filter.h
+
+BPF [BTF]
+M:	Martin KaFai Lau <martin.lau@linux.dev>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/btf.c
+F:	include/linux/btf*
+
+BPF [TRACING]
+M:	Song Liu <song@kernel.org>
+R:	Jiri Olsa <jolsa@kernel.org>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/trace/bpf_trace.c
+F:	kernel/bpf/stackmap.c
+
+BPF [NETWORKING] (tc BPF, sock_addr)
+M:	Martin KaFai Lau <martin.lau@linux.dev>
+M:	Daniel Borkmann <daniel@iogearbox.net>
+R:	John Fastabend <john.fastabend@gmail.com>
+L:	bpf@vger.kernel.org
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	net/core/filter.c
+F:	net/sched/act_bpf.c
+F:	net/sched/cls_bpf.c
+
+BPF [NETWORKING] (struct_ops, reuseport)
+M:	Martin KaFai Lau <martin.lau@linux.dev>
+L:	bpf@vger.kernel.org
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/bpf_struct*
+
+BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
 M:	KP Singh <kpsingh@kernel.org>
 R:	Florent Revest <revest@chromium.org>
 R:	Brendan Jackman <jackmanb@chromium.org>
@@ -3758,7 +3797,27 @@ F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
 F:	security/bpf/
 
-BPF L7 FRAMEWORK
+BPF [STORAGE & CGROUPS]
+M:	Martin KaFai Lau <martin.lau@linux.dev>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/cgroup.c
+F:	kernel/bpf/*storage.c
+F:	kernel/bpf/bpf_lru*
+
+BPF [RINGBUF]
+M:	Andrii Nakryiko <andrii@kernel.org>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/ringbuf.c
+
+BPF [ITERATOR]
+M:	Yonghong Song <yhs@fb.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	kernel/bpf/*iter.c
+
+BPF [L7 FRAMEWORK] (sockmap)
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Jakub Sitnicki <jakub@cloudflare.com>
 L:	netdev@vger.kernel.org
@@ -3771,13 +3830,26 @@ F:	net/ipv4/tcp_bpf.c
 F:	net/ipv4/udp_bpf.c
 F:	net/unix/unix_bpf.c
 
-BPFTOOL
+BPF [LIBRARY] (libbpf)
+M:	Andrii Nakryiko <andrii@kernel.org>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	tools/lib/bpf/
+
+BPF [TOOLING] (bpftool)
 M:	Quentin Monnet <quentin@isovalent.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	kernel/bpf/disasm.*
 F:	tools/bpf/bpftool/
 
+BPF [SELFTESTS] (Test Runners & Infrastructure)
+M:	Andrii Nakryiko <andrii@kernel.org>
+R:	Mykola Lysenko <mykolal@fb.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	tools/testing/selftests/bpf/
+
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
-- 
2.21.0

