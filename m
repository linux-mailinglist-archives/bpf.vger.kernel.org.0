Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140D3271E3
	for <lists+bpf@lfdr.de>; Sun, 28 Feb 2021 11:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhB1Kb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Feb 2021 05:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhB1Kb4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 28 Feb 2021 05:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614508230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2Sx6ZZNqBEEPl4NlfeY2tbY98x3VujYLKzzEu61eOj4=;
        b=UmUjDxhAGg+IDFZPDP+dApUJGNaj8DDtxZ8em1RWi4zPaQ8yiZKPpzj7KKd/bKT0g0l8yV
        D3P8Zi79rPxME61kTA/2eOEtVtZf+qwSSF8nZS+M3+i2hWGGLvaj2QoADWw5DevSa/J70T
        HTXCzZht3903Ls1/CfxWmosUzXacBnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-cSHT3oMNO3m97N7XvHTs_A-1; Sun, 28 Feb 2021 05:30:27 -0500
X-MC-Unique: cSHT3oMNO3m97N7XvHTs_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8477010059D3;
        Sun, 28 Feb 2021 10:30:26 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-173.ams2.redhat.com [10.36.112.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D908608DB;
        Sun, 28 Feb 2021 10:30:18 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, toke@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH] bpf: selftests: test_verifier: mask bpf_csum_diff() return value to 16 bits
Date:   Sun, 28 Feb 2021 12:30:17 +0200
Message-Id: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier test labelled "valid read map access into a read-only array
2" calls the bpf_csum_diff() helper and checks its return value.
However, architecture implementations of csum_partial() (which is what
the helper uses) differ in whether they fold the return value to 16 bit
or not. For example, x86 version has:

	if (unlikely(odd)) {
		result = from32to16(result);
		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
	}

while generic lib/checksum.c does:

	result = from32to16(result);
	if (odd)
		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);

This makes the helper return different values on different
architectures, breaking the test on non-x86. To fix this, add an
additional instruction to always mask the return value to 16 bits, and
update the expected return value accordingly.

Fixes: fb2abb73e575 ("bpf, selftest: test {rd, wr}only flags and direct value access")
Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/verifier/array_access.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
index bed53b561e04..1b138cd2b187 100644
--- a/tools/testing/selftests/bpf/verifier/array_access.c
+++ b/tools/testing/selftests/bpf/verifier/array_access.c
@@ -250,12 +250,13 @@
 	BPF_MOV64_IMM(BPF_REG_5, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
 		     BPF_FUNC_csum_diff),
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_array_ro = { 3 },
 	.result = ACCEPT,
-	.retval = -29,
+	.retval = 65507,
 },
 {
 	"invalid write map access into a read-only array 1",
-- 
2.29.2

