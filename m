Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6758A3604
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3LvN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:51:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbfH3LvN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 07:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4992D18C893F;
        Fri, 30 Aug 2019 11:51:13 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7B1C60C05;
        Fri, 30 Aug 2019 11:51:11 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, iii@linux.ibm.com, jolsa@redhat.com
Subject: [PATCH v3] bpf: s390: add JIT support for bpf line info
Date:   Fri, 30 Aug 2019 14:51:09 +0300
Message-Id: <20190830115109.3896-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
References: <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 30 Aug 2019 11:51:13 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for generating bpf line info for JITed programs
like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
line info") does for powerpc, but it should pass the array starting
from 1 like x86, see commit 7c2e988f400e ("bpf: fix x64 JIT code
generation for jmp to 1st insn").

That fixes test_btf.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---

The patch is on top of "bpf: s390: add JIT support for multi-function
programs"
 
V1->V2:

- pass address array starting from element 1.

V2->V3:

- Fix braces in the commit message.

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

