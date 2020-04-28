Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880471BC6E4
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 19:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgD1RiN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 13:38:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727957AbgD1RiN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 13:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588095491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PTPSCtq1zt7d20hO1jQgmbMv9TtnDm1L+LloDTMHu9s=;
        b=Wv2ySCxs/2u/zEe8sefdpOGhAGgiyXO00atWrenJ6sQDxDzLUJBsaLtStJk0oGLvBnJArc
        /KtXA2FN3/GXlAp9mXWJJaOHrrr3s7wFFC09ZK9yQC5Too2ibdJ5KsFoIrDsoM3e6pg4qT
        NhTN8kkay9hC1JaJ8U3j6gSebSHR6Vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-FuT50Vs6PamIqCZ4bMhRSA-1; Tue, 28 Apr 2020 13:38:07 -0400
X-MC-Unique: FuT50Vs6PamIqCZ4bMhRSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96239835B42;
        Tue, 28 Apr 2020 17:38:06 +0000 (UTC)
Received: from steamlocomotive.redhat.com (unknown [10.40.195.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B65600DB;
        Tue, 28 Apr 2020 17:38:02 +0000 (UTC)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andriin@fb.com, brouer@redhat.com,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH v2] selftests/bpf: Copy runqslower to OUTPUT directory
Date:   Tue, 28 Apr 2020 19:37:42 +0200
Message-Id: <20200428173742.2988395-1-vkabatov@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

$(OUTPUT)/runqslower makefile target doesn't actually create runqslower
binary in the $(OUTPUT) directory. As lib.mk expects all
TEST_GEN_PROGS_EXTENDED (which runqslower is a part of) to be present in
the OUTPUT directory, this results in an error when running e.g. `make
install`:

rsync: link_stat "tools/testing/selftests/bpf/runqslower" failed: No
       such file or directory (2)

Copy the binary into the OUTPUT directory after building it to fix the
error.

Fixes: 3a0d3092a4ed ("selftests/bpf: Build runqslower from selftests")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
index 7729892e0b04..4e654d41c7af 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -141,7 +141,8 @@ VMLINUX_BTF :=3D $(abspath $(firstword $(wildcard $(V=
MLINUX_BTF_PATHS))))
 $(OUTPUT)/runqslower: $(BPFOBJ)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	\
 		    OUTPUT=3D$(SCRATCH_DIR)/ VMLINUX_BTF=3D$(VMLINUX_BTF)   \
-		    BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR)
+		    BPFOBJ=3D$(BPFOBJ) BPF_INCLUDE=3D$(INCLUDE_DIR) &&	\
+		    cp $(SCRATCH_DIR)/runqslower $@
=20
 $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(BP=
FOBJ)
=20
--=20
2.25.1

