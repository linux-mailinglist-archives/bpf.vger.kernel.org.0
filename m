Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16DA1D9277
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 10:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgESIuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 04:50:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726369AbgESIuG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 May 2020 04:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589878205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n8Op92B0hoMT28ivYwa2fErvlEmMTWzePt/rLMwDQLU=;
        b=Zh+2sjKCeo5TCgS5ZfAXV1b01GAwGCrkl60vdr+mTp5LBgnRxnyKVi19NB64e0PA+vKW40
        lNcaQoZYOJAM7Q+GiGhMhYqHeae8o/pl2NKgclYmwtLaugL3ELGhuyyDRx4d55RVzNp55N
        Eo2XJWiQEXX/zhDIzq3zlIvhJbg/RvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-xIxIQelfOJG33NMCs_Z4Ag-1; Tue, 19 May 2020 04:50:03 -0400
X-MC-Unique: xIxIQelfOJG33NMCs_Z4Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01F1C835B5C;
        Tue, 19 May 2020 08:50:02 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-234.ams2.redhat.com [10.36.114.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D197196AE;
        Tue, 19 May 2020 08:50:00 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] selftests/bpf: install btf .c files
Date:   Tue, 19 May 2020 11:49:57 +0300
Message-Id: <20200519084957.55166-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some .c files used by test_progs to check btf and they are missing
from installation after commit 74b5a5968fe8 ("selftests/bpf: Replace
test_progs and test_maps w/ general rule").

Take them back.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e716e931d0c9..d96440732905 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -46,6 +46,9 @@ TEST_GEN_FILES =
 TEST_FILES = test_lwt_ip_encap.o \
 	test_tc_edt.o
 
+BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
+TEST_FILES += $(BTF_C_FILES)
+
 # Order correspond to 'make run_tests' order
 TEST_PROGS := test_kmod.sh \
 	test_xdp_redirect.sh \
-- 
2.26.2

