Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB86E377293
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHPXR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 May 2021 11:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEHPXR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 May 2021 11:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9919061155;
        Sat,  8 May 2021 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620487335;
        bh=1Jpp0mNVX3vrMiyD9zJICNyxEYv/4w8Z8fZcO/gNx2U=;
        h=Date:From:To:Cc:Subject:From;
        b=T8WSCXLHwM8iEN0msYdUaxbDh7VSzM+7QLwfdwtbfiXn/Wd76/YBnF26qnCU6pvDO
         Gcqt8UXBRCiUwGetS3XJ5dXVw+83t1Qz5c4fWrW/xTSUexfCkYVGr7LgMgPri004DE
         A3TXFV4NW9sdcwQSZwdJyR/CpFwtON5zBF4tOJqybxtSZPUgnqritUPHYZAEkXtLEz
         l2vhmd+V8/oUtQG9FbJ2Q7QRMywLGj8DOTLe5ProKZLE1iVh6Mnt2vbBQwGjSBZXnj
         d6mtlEz5qQhOLjJX47P9RwsxHeGpqYsMb0aGwgurKSpJVgZB9tMzERtkmJ8SGYKH3N
         yGrKuSJamUSAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE1C24034C; Sat,  8 May 2021 12:22:12 -0300 (-03)
Date:   Sat, 8 May 2021 12:22:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>, bpf@vger.kernel.org
Subject: [PATCH 1/1] libbpf: Provide GELF_ST_VISIBILITY() define for older
 libelf
Message-ID: <YJaspEh0qZr4LYOc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Where that macro isn't available.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/libbpf_internal.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ee426226928f1283..acbcf6c7bdf82cf2 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -41,6 +41,11 @@
 #define ELF_C_READ_MMAP ELF_C_READ
 #endif
 
+/* Older libelf all end up in this expression, for both 32 and 64 bit */
+#ifndef GELF_ST_VISIBILITY
+#define GELF_ST_VISIBILITY(o) ((o) & 0x03)
+#endif
+
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
-- 
2.26.3

