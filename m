Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5702E1D04B6
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 04:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgEMCRa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 May 2020 22:17:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44051 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726885AbgEMCRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 May 2020 22:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589336249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b2ocEgLohmOD0+o4CDszLQUsQLHB/iWWUZ7IvUfu/JY=;
        b=FGVccGNWL7RUHvz51TKGrsZcck0SRaOoMQKk49FRh8L8GRZY0Yz1POUgusUNm+agaH4quF
        AgEhF/IsBqFZtfkrgicRnVZUmuazufa3tbdZah68t8Zub3ahOVZ8dKf2//KrKUJenBFMMf
        2s3KHntovZO5fm5IMY6Nc3PxQwx7smA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-evzOWWIcMLaE2ll6Rj2jdQ-1; Tue, 12 May 2020 22:17:27 -0400
X-MC-Unique: evzOWWIcMLaE2ll6Rj2jdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC0F8014D5;
        Wed, 13 May 2020 02:17:26 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-2.ams2.redhat.com [10.36.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C938619AC;
        Wed, 13 May 2020 02:17:24 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH] selftests/bpf: install generated test progs
Date:   Wed, 13 May 2020 05:17:22 +0300
Message-Id: <20200513021722.7787-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before commit 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule") selftests/bpf used generic install
target from selftests/lib.mk to install generated bpf test progs by
mentioning them in TEST_GEN_FILES variable.

Take that functionality back.

Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and
test_maps w/ general rule")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7729892e0b04..c9a07cc7dede 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -263,6 +263,7 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
 TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST),	\
 					       $$(TRUNNER_BPF_SRCS)))
+TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
 
 # Evaluate rules now with extra TRUNNER_XXX variables above already defined
 $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
-- 
2.26.2

