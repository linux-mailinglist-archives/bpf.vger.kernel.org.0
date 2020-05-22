Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E81DDE9A
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgEVENd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727914AbgEVENd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 May 2020 00:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9F4YBOs3UoMHmIPiFBgNRfM0D6Q+BBFbkC/xaHnj1w=;
        b=R3QOBlrJ02iqXN4/h3DfDlsCF6OZaLBdrx5YksCxHX4bl0dtIiriLQQOey3n2YEIRPXCBi
        RDNcRygFC9rGZQkODDi2+dRcNHRN86PHMkfPRx0i+srITeNolIPYahL11g/F3FhUGYwZWj
        7VvEbQ5H3TUeOZjcQcgoEoNPxPBgYdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-VBNGVs6qNIWz1NWmXp1Rkg-1; Fri, 22 May 2020 00:13:30 -0400
X-MC-Unique: VBNGVs6qNIWz1NWmXp1Rkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7834E80183C;
        Fri, 22 May 2020 04:13:29 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A1865D9C9;
        Fri, 22 May 2020 04:13:27 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 6/8] selftests/bpf: fix urandom_read installation
Date:   Fri, 22 May 2020 07:13:08 +0300
Message-Id: <20200522041310.233185-7-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

selftests/lib.mk does not prepend TEST_CUSTOM_PROGS with OUTPUT (vs
TEST_GEN_PROGS, TEST_GEN_PROGS_EXTENDED, TEST_GEN_FILES). So do it
in the bpf Makefile. Otherwise make install fails to install it on
out of tree build.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index efab82151ce2..31598ca2d396 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -82,7 +82,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench
 
-TEST_CUSTOM_PROGS = urandom_read
+TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.26.2

