Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF9046FAB2
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhLJGkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 01:40:36 -0500
Received: from 1.srv.vincent-minet.net ([91.134.209.153]:59825 "EHLO
        1.srv.vincent-minet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLJGkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 01:40:36 -0500
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Dec 2021 01:40:36 EST
Received: from localhost.localdomain (ns3003576.ip-5-196-75.eu [5.196.75.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 1.srv.vincent-minet.net (Postfix) with ESMTPSA id D56FF6003D;
        Fri, 10 Dec 2021 06:59:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vincent-minet.net;
        s=2017042601; t=1639115968;
        bh=b34hRrvicgynZ7ScVF+xGLhl/DvBZEY4v7o+1n7iczw=;
        h=From:To:Cc:Subject:Date;
        b=OaONBVEKdDecGqRL38f1uIFV44Z3gFbnRSTveRlCNuk5is+vIdIw/9U6dvERnvBCZ
         pwomXhwzqw5l+hR7m0ZKcCDDVMTG64kLIM+zvtVwx3wY0hpuBBxmBc9ycScKKMe8R6
         pZxtxSKVZiLW2+UkYnlqCkmp1oewmORZ5qgNLZGk=
From:   Vincent Minet <vincent@vincent-minet.net>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Vincent Minet <vincent@vincent-minet.net>
Subject: [PATCH] libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
Date:   Fri, 10 Dec 2021 07:31:12 +0100
Message-Id: <20211210063112.80047-1-vincent@vincent-minet.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The btf__dedup_deprecated name was misspelled in the definition of the
compat symbol for btf__dedup. This leads it to be missing from the
shared library.

This fixes it.

Signed-off-by: Vincent Minet <vincent@vincent-minet.net>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e171424192ae..9aa19c89f758 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3107,7 +3107,7 @@ int btf__dedup_v0_6_0(struct btf *btf, const struct btf_dedup_opts *opts)
 	return libbpf_err(err);
 }
 
-COMPAT_VERSION(bpf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)
+COMPAT_VERSION(btf__dedup_deprecated, btf__dedup, LIBBPF_0.0.2)
 int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, const void *unused_opts)
 {
 	LIBBPF_OPTS(btf_dedup_opts, opts, .btf_ext = btf_ext);
-- 
2.33.1

