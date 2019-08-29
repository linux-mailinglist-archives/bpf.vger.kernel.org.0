Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70585A2071
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfH2QNf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Aug 2019 12:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfH2QNe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Aug 2019 12:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93F393084031;
        Thu, 29 Aug 2019 16:13:34 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.36.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 535285D9D3;
        Thu, 29 Aug 2019 16:13:33 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, iii@linux.ibm.com, jolsa@redhat.com
Subject: [PATCH] bpf: s390: add JIT support for bpf line info
Date:   Thu, 29 Aug 2019 19:13:30 +0300
Message-Id: <20190829161330.14951-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 29 Aug 2019 16:13:34 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds support for generating bpf line info for JITed programs
like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
line info") does for powerpc.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---

The patch is on top of "bpf: s390: add JIT support for multi-function
programs"

---
 arch/s390/net/bpf_jit_comp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b6801d854c77..4ef783b67dfc 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1420,6 +1420,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	fp->jited_len = jit.size;
 
 	if (!fp->is_func || extra_pass) {
+		bpf_prog_fill_jited_linfo(fp, jit.addrs);
 free_addrs:
 		kfree(jit.addrs);
 		kfree(jit_data);
-- 
2.22.0

