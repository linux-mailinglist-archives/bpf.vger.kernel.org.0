Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3DA277B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 21:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfH2T52 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 15:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfH2T51 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 15:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEFA410C6976;
        Thu, 29 Aug 2019 19:57:27 +0000 (UTC)
Received: from astarta-old.redhat.com (ovpn-116-63.ams2.redhat.com [10.36.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEF50404D;
        Thu, 29 Aug 2019 19:57:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, iii@linux.ibm.com, jolsa@redhat.com,
        yauheni.kaliuta@redhat.com
Subject: [PATCH v2] bpf: s390: add JIT support for bpf line info
Date:   Thu, 29 Aug 2019 23:02:17 +0300
Message-Id: <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <xunyd0go9cba.fsf@redhat.com>
References: <xunyd0go9cba.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 29 Aug 2019 19:57:27 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for generating bpf line info for JITed programs
like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
line info") does for powerpc, but it should pass the array starting
from 1 like x86, see commit 7c2e988f400e ("bpf: fix x64 JIT code
generation for jmp to 1st insn".

That fixes test_btf.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---

The patch is on top of "bpf: s390: add JIT support for multi-function
programs"

V1->V1:

- pass address array starting from element 1.

---
 arch/s390/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b6801d854c77..ce88211b9c6c 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1420,6 +1420,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	fp->jited_len = jit.size;
 
 	if (!fp->is_func || extra_pass) {
+		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
 free_addrs:
 		kfree(jit.addrs);
 		kfree(jit_data);
-- 
2.22.0

