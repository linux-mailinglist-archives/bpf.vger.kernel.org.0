Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9E54FDCD
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiFQTmu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 15:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbiFQTmt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 15:42:49 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDAD66
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 12:42:46 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o2Hrg-0009kH-9J; Fri, 17 Jun 2022 21:42:44 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii@kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf] bpf, docs: Update some of the JIT/maintenance entries
Date:   Fri, 17 Jun 2022 21:42:33 +0200
Message-Id: <f9b8a63a0b48dc764bd4c50f87632889f5813f69.1655494758.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26575/Fri Jun 17 10:08:05 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Various minor updates around some of the BPF-related entries:

JITs for ARM32/NFP/SPARC/X86-32 haven't seen updates in quite a while, thus
for now, mark them as 'Odd Fixes' until they become more actively developed.

JITs for POWERPC/S390 are in good shape and receive active development and
review, thus bump to 'Supported' similar as we have with X86-64/ARM64.

JITs for MIPS/RISC-V are in similar good shape as the ones mentioned above,
but looked after mostly in spare time, thus leave for now in 'Maintained' state.

Add Michael to PPC JIT given he's picking up the patches there, so it better
reflects today's state.

Also, I haven't done much reviewing around BPF sockmap/kTLS after John and I
did the big rework back in the days to integrate sockmap with kTLS.

These days, most of this is taken care by John, Jakub {Sitnicki,Kicinski} and
others in the community, so remove myself from these two.

Lastly, move all BPF-related entries into one place, that is, move the sockmap
one over near rest of BPF.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 MAINTAINERS | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96158b337b40..795f7e40230c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3662,7 +3662,7 @@ BPF JIT for ARM
 M:	Shubham Bansal <illusionist.neo@gmail.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	arch/arm/net/
 
 BPF JIT for ARM64
@@ -3686,14 +3686,15 @@ BPF JIT for NFP NICs
 M:	Jakub Kicinski <kuba@kernel.org>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Supported
+S:	Odd Fixes
 F:	drivers/net/ethernet/netronome/nfp/bpf/
 
 BPF JIT for POWERPC (32-BIT AND 64-BIT)
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
+M:	Michael Ellerman <mpe@ellerman.id.au>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	arch/powerpc/net/
 
 BPF JIT for RISC-V (32-bit)
@@ -3719,7 +3720,7 @@ M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	arch/s390/net/
 X:	arch/s390/net/pnet.c
 
@@ -3727,14 +3728,14 @@ BPF JIT for SPARC (32-BIT AND 64-BIT)
 M:	David S. Miller <davem@davemloft.net>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	arch/sparc/net/
 
 BPF JIT for X86 32-BIT
 M:	Wang YanQing <udknight@gmail.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	arch/x86/net/bpf_jit_comp32.c
 
 BPF JIT for X86 64-BIT
@@ -3757,6 +3758,19 @@ F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
 F:	security/bpf/
 
+BPF L7 FRAMEWORK
+M:	John Fastabend <john.fastabend@gmail.com>
+M:	Jakub Sitnicki <jakub@cloudflare.com>
+L:	netdev@vger.kernel.org
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	include/linux/skmsg.h
+F:	net/core/skmsg.c
+F:	net/core/sock_map.c
+F:	net/ipv4/tcp_bpf.c
+F:	net/ipv4/udp_bpf.c
+F:	net/unix/unix_bpf.c
+
 BPFTOOL
 M:	Quentin Monnet <quentin@isovalent.com>
 L:	bpf@vger.kernel.org
@@ -11095,20 +11109,6 @@ S:	Maintained
 F:	include/net/l3mdev.h
 F:	net/l3mdev
 
-L7 BPF FRAMEWORK
-M:	John Fastabend <john.fastabend@gmail.com>
-M:	Daniel Borkmann <daniel@iogearbox.net>
-M:	Jakub Sitnicki <jakub@cloudflare.com>
-L:	netdev@vger.kernel.org
-L:	bpf@vger.kernel.org
-S:	Maintained
-F:	include/linux/skmsg.h
-F:	net/core/skmsg.c
-F:	net/core/sock_map.c
-F:	net/ipv4/tcp_bpf.c
-F:	net/ipv4/udp_bpf.c
-F:	net/unix/unix_bpf.c
-
 LANDLOCK SECURITY MODULE
 M:	Mickaël Salaün <mic@digikod.net>
 L:	linux-security-module@vger.kernel.org
@@ -13950,7 +13950,6 @@ F:	net/ipv6/tcp*.c
 NETWORKING [TLS]
 M:	Boris Pismenny <borisp@nvidia.com>
 M:	John Fastabend <john.fastabend@gmail.com>
-M:	Daniel Borkmann <daniel@iogearbox.net>
 M:	Jakub Kicinski <kuba@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.21.0

