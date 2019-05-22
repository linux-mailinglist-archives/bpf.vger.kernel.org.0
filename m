Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 003BA26F16
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbfEVTyd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 15:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731671AbfEVTZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 15:25:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 890E421851;
        Wed, 22 May 2019 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553138;
        bh=8TQcUMQCZVzH7mNHS/hd5ONN6+PvdivAyMMx2MV8PqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVLWUMjQ0PcfJwGCGz29z233f1hIITsz7zLn/3CNOyVCIWtVeib8v2WNlKct9RviT
         XmonaZIzCtxaG2lgtWqAqQto4KfDiHiieeoELaYAVblIXRWVuHbEJ1nMTlKscUuJcS
         TEgTQIv9G26deK0v3EqmsJQkQMgLRhBxvwUQ2OsM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel T. Lee" <danieltimlee@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 068/317] libbpf: fix samples/bpf build failure due to undefined UINT32_MAX
Date:   Wed, 22 May 2019 15:19:29 -0400
Message-Id: <20190522192338.23715-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Daniel T. Lee" <danieltimlee@gmail.com>

[ Upstream commit 32e621e55496a0009f44fe4914cd4a23cade4984 ]

Currently, building bpf samples will cause the following error.

    ./tools/lib/bpf/bpf.h:132:27: error: 'UINT32_MAX' undeclared here (not in a function) ..
     #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
                               ^
    ./samples/bpf/bpf_load.h:31:25: note: in expansion of macro 'BPF_LOG_BUF_SIZE'
     extern char bpf_log_buf[BPF_LOG_BUF_SIZE];
                             ^~~~~~~~~~~~~~~~

Due to commit 4519efa6f8ea ("libbpf: fix BPF_LOG_BUF_SIZE off-by-one error")
hard-coded size of BPF_LOG_BUF_SIZE has been replaced with UINT32_MAX which is
defined in <stdint.h> header.

Even with this change, bpf selftests are running fine since these are built
with clang and it includes header(-idirafter) from clang/6.0.0/include.
(it has <stdint.h>)

    clang -I. -I./include/uapi -I../../../include/uapi -idirafter /usr/local/include -idirafter /usr/include \
    -idirafter /usr/lib/llvm-6.0/lib/clang/6.0.0/include -idirafter /usr/include/x86_64-linux-gnu \
    -Wno-compare-distinct-pointer-types -O2 -target bpf -emit-llvm -c progs/test_sysctl_prog.c -o - | \
    llc -march=bpf -mcpu=generic  -filetype=obj -o /linux/tools/testing/selftests/bpf/test_sysctl_prog.o

But bpf samples are compiled with GCC, and it only searches and includes
headers declared at the target file. As '#include <stdint.h>' hasn't been
declared in tools/lib/bpf/bpf.h, it causes build failure of bpf samples.

    gcc -Wp,-MD,./samples/bpf/.sockex3_user.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes \
    -O2 -fomit-frame-pointer -std=gnu89 -I./usr/include -I./tools/lib/ -I./tools/testing/selftests/bpf/ \
    -I./tools/  lib/ -I./tools/include -I./tools/perf -c -o ./samples/bpf/sockex3_user.o ./samples/bpf/sockex3_user.c;

This commit add declaration of '#include <stdint.h>' to tools/lib/bpf/bpf.h
to fix this problem.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 8f09de482839e..64762a62c008d 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -26,6 +26,7 @@
 #include <linux/bpf.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
 
 #ifdef __cplusplus
 extern "C" {
-- 
2.20.1

