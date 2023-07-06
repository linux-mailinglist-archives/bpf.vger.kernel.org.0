Return-Path: <bpf+bounces-4329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C24E74A568
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5FC1C20E2F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5FD182BC;
	Thu,  6 Jul 2023 20:48:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699E182B2;
	Thu,  6 Jul 2023 20:48:34 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EA91BD2;
	Thu,  6 Jul 2023 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676508; x=1720212508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btMEqfPJdz24ajU0aJZF0IeGeFF/1NrmUw/U4+YuNPo=;
  b=C55WK+dPthoqpHGwVEJqgATxKXti/CE/y4WsRoLIrb96Mq10hOsQinzT
   T2kYYeYCvJq+7qta8xADEYlW0YBRbFGUZUAvynykQy7MQjd31Gf1p+SSz
   IZJK/rIJPXlV3dI7ATwRw4HK8XU66WXP7gklMIRHNFA8NNe3fCazJIV7d
   GNJXN2CoCdE2pQzlWu4T1NCyRRC526NmqOjbVAuIQ28gYzLPoLRFjQTl+
   niOGFxXEnZU6uJVpdIBoi9mPouVU0yFm+BSeePtcMkvw3assrQvRnTgOY
   SMiHHEYuUNqbbyVoqSGlLTnBAYLuXuyM2J4nNkH9Cv4DY2qD+xMODUakO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195698"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195698"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059895"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059895"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 24/24] selftests/xsk: reset NIC settings to default after running test suite
Date: Thu,  6 Jul 2023 22:46:50 +0200
Message-Id: <20230706204650.469087-25-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, when running ZC test suite, after finishing first run of test
suite and then switching to busy-poll tests within xskxceiver, such
errors are observed:

libbpf: Kernel error message: ice: MTU is too large for linear frames and XDP prog does not support frags
1..26
libbpf: Kernel error message: Native and generic XDP can't be active at the same time
Error attaching XDP program
not ok 1 [xskxceiver.c:xsk_reattach_xdp:1568]: ERROR: 17/"File exists"

this is because test suite ends with 9k MTU and native xdp program being
loaded. Busy-poll tests start non-multi-buffer tests for generic mode.
To fix this, let us introduce bash function that will reset NIC settings
to default (e.g. 1500 MTU and no xdp progs loaded) so that test suite
can continue without interrupts. It also means that after busy-poll
tests NIC will have those default settings, whereas right now it is left
with 9k MTU and xdp prog loaded in native mode.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 tools/testing/selftests/bpf/test_xsk.sh    | 5 +++++
 tools/testing/selftests/bpf/xsk_prereqs.sh | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
index c2ad50f26b63..2aa5a3445056 100755
--- a/tools/testing/selftests/bpf/test_xsk.sh
+++ b/tools/testing/selftests/bpf/test_xsk.sh
@@ -171,7 +171,10 @@ exec_xskxceiver
 
 if [ -z $ETH ]; then
 	cleanup_exit ${VETH0} ${VETH1}
+else
+	cleanup_iface ${ETH} ${MTU}
 fi
+
 TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
 busy_poll=1
 
@@ -184,6 +187,8 @@ exec_xskxceiver
 
 if [ -z $ETH ]; then
 	cleanup_exit ${VETH0} ${VETH1}
+else
+	cleanup_iface ${ETH} ${MTU}
 fi
 
 failures=0
diff --git a/tools/testing/selftests/bpf/xsk_prereqs.sh b/tools/testing/selftests/bpf/xsk_prereqs.sh
index ae697a10a056..29175682c44d 100755
--- a/tools/testing/selftests/bpf/xsk_prereqs.sh
+++ b/tools/testing/selftests/bpf/xsk_prereqs.sh
@@ -53,6 +53,13 @@ test_exit()
 	exit 1
 }
 
+cleanup_iface()
+{
+	ip link set $1 mtu $2
+	ip link set $1 xdp off
+	ip link set $1 xdpgeneric off
+}
+
 clear_configs()
 {
 	[ $(ip link show $1 &>/dev/null; echo $?;) == 0 ] &&
-- 
2.34.1


