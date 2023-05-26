Return-Path: <bpf+bounces-1340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C3713024
	for <lists+bpf@lfdr.de>; Sat, 27 May 2023 00:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73991C2112C
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A12A9FE;
	Fri, 26 May 2023 22:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9715B7
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 22:47:16 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D22116
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=9EKO8hXWZNvH9Aqx4tNKxixv/SmimkwxoUsCn2jXEpc=; b=SElx43vtfCE2bC/INapkkdiJNg
	JzGjPC+zJGakjyeawmt91vovHazhHq9kWQltY2Lfhn7Doa1XRGMMB+vZowWHSeF3mE/gjc60DA471
	zKxgrCwbGnA45lCd2jEklq0aFVd6C/5RxrPr3gh6UWP3roUFvke1SYH4HdXx9ORDWFmdKwrL5auWN
	bBr8V6AZOtFHQLQKrhRRcwaAcoQKHZMIP+TBO5J+o7tjkYCB6KbNc0n7c93oCH1usOn/vUjbvB17g
	P1QvuAEkBLVqfeKFi5M1MNLNKu96DyGkKfa3eQLqNYa9RvemXuCsfoMgIy/c7QNuF4uJ49QqZLnaq
	YhslMIEA==;
Received: from 44.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2gDK-0004Av-1Y; Sat, 27 May 2023 00:47:13 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: andrii@kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as statically linked
Date: Sat, 27 May 2023 00:47:09 +0200
Message-Id: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26919/Fri May 26 09:23:54 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Small fix for vmtest.sh that I've been carrying locally for quite a while
now in order to work around the following linker issue:

  # ./vmtest.sh -- ./test_progs -t lsm
  [...]
  + ip link set lo up
  + [ -x /etc/rcS.d/S50-startup ]
  + /etc/rcS.d/S50-startup
  ./test_progs -t lsm
  ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
  ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./test_progs)
  [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
  [    1.358950] reboot: Power down
  [...]

With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
runners like test_progs/test_maps/etc work just fine.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/Makefile  | 2 +-
 tools/testing/selftests/bpf/vmtest.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index cd2426cca3d0..4005d001f46c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -547,7 +547,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     $(TRUNNER_BPFTOOL)				\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
-	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
+	$(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
 	$(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
 	$(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
 		   $(OUTPUT)/$(if $2,$2/)bpftool
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 685034528018..455518745cf9 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -160,7 +160,7 @@ update_selftests()
 	local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
 
 	cd "${selftests_dir}"
-	${make_command}
+	TRUNNER_LDFLAGS=-static ${make_command}
 
 	# Mount the image and copy the selftests to the image.
 	mount_image
-- 
2.21.0


