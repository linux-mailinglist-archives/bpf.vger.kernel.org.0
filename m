Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EC2364BCE
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbhDSUqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 16:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242595AbhDSUpZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 16:45:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 609B2613D4;
        Mon, 19 Apr 2021 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618865090;
        bh=x2n7AHMk4xuQM/Nj3J0Y6kw8h5pEDWqP9+6+2bmkT/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7HZwSy/ptltV5d9eN3ZkG0NUTBjTqii2I2t1BniYXHejMAxq9cwKTtE1FHe9jdeQ
         JzCNNnPBTggTnH35fmBZrLMgz2ItDI1PAqoBK4X2CuOavTbnpqROqpdQsXcBZv16/k
         kvVgqtjnz9RYXPQAYnCzmB012hy0cPX14jxfEuI6eEqFXem0SwltEo+Rwxi3XczlCK
         lALT2pISpNcNq9G79bj1IXzI9BlFYb2nxd4/xniP6yCGTS6XAtbRADI9rbWYXUTQIg
         +2JgyXflcI4E5pvMr5/C3yUJaLlrnSGnX5P5A69Lzx+hLLKoswMK73PZ0+msBwhwnT
         VMxoi2KQZm1MQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 19/21] ia64: tools: remove duplicate definition of ia64_mf() on ia64
Date:   Mon, 19 Apr 2021 16:44:17 -0400
Message-Id: <20210419204420.6375-19-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419204420.6375-1-sashal@kernel.org>
References: <20210419204420.6375-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

[ Upstream commit f4bf09dc3aaa4b07cd15630f2023f68cb2668809 ]

The ia64_mf() macro defined in tools/arch/ia64/include/asm/barrier.h is
already defined in <asm/gcc_intrin.h> on ia64 which causes libbpf
failing to build:

    CC       /usr/src/linux/tools/bpf/bpftool//libbpf/staticobjs/libbpf.o
  In file included from /usr/src/linux/tools/include/asm/barrier.h:24,
                   from /usr/src/linux/tools/include/linux/ring_buffer.h:4,
                   from libbpf.c:37:
  /usr/src/linux/tools/include/asm/../../arch/ia64/include/asm/barrier.h:43: error: "ia64_mf" redefined [-Werror]
     43 | #define ia64_mf()       asm volatile ("mf" ::: "memory")
        |
  In file included from /usr/include/ia64-linux-gnu/asm/intrinsics.h:20,
                   from /usr/include/ia64-linux-gnu/asm/swab.h:11,
                   from /usr/include/linux/swab.h:8,
                   from /usr/include/linux/byteorder/little_endian.h:13,
                   from /usr/include/ia64-linux-gnu/asm/byteorder.h:5,
                   from /usr/src/linux/tools/include/uapi/linux/perf_event.h:20,
                   from libbpf.c:36:
  /usr/include/ia64-linux-gnu/asm/gcc_intrin.h:382: note: this is the location of the previous definition
    382 | #define ia64_mf() __asm__ volatile ("mf" ::: "memory")
        |
  cc1: all warnings being treated as errors

Thus, remove the definition from tools/arch/ia64/include/asm/barrier.h.

Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/arch/ia64/include/asm/barrier.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/ia64/include/asm/barrier.h b/tools/arch/ia64/include/asm/barrier.h
index 4d471d9511a5..6fffe5682713 100644
--- a/tools/arch/ia64/include/asm/barrier.h
+++ b/tools/arch/ia64/include/asm/barrier.h
@@ -39,9 +39,6 @@
  * sequential memory pages only.
  */
 
-/* XXX From arch/ia64/include/uapi/asm/gcc_intrin.h */
-#define ia64_mf()       asm volatile ("mf" ::: "memory")
-
 #define mb()		ia64_mf()
 #define rmb()		mb()
 #define wmb()		mb()
-- 
2.30.2

