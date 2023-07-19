Return-Path: <bpf+bounces-5309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E5759720
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407B71C20FBA
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4F13FE5;
	Wed, 19 Jul 2023 13:25:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDF21D4A;
	Wed, 19 Jul 2023 13:25:51 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCD11A6;
	Wed, 19 Jul 2023 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773148; x=1721309148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=btMEqfPJdz24ajU0aJZF0IeGeFF/1NrmUw/U4+YuNPo=;
  b=GIhwbxx0TfiTtiCGIb5yQuvaXTFzs96vA4AFNU+It0yvL+vA9R2Wa9CZ
   CWsPN+47XOlmQ4Uv1sH1EwAye9gbZOv0EgXn487/zlcb544vZ23lKhD2b
   xd4pMhlDgeZs1zi3h7RVC8MftdemQGHAP5OuCAKN3YFzadvIM6K/Cun71
   u0SwFYpakU6MbsMXTOqmUoartQYcRdAeHqqfSRp8pGTJqYsf4Vr6M0tRN
   bxC2yVFEZ/8PVgTs79EsAnHO+fGGXOPW9XBx3lsg8aq6jc1jIJzOrmvMZ
   CI/Gp0BDycH2LEW3ga2/5jfqtbQGeoLN96Ijynm4OfgzvYYrZYFQKCQHA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920860"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920860"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978233"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978233"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:25:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 24/24] selftests/xsk: reset NIC settings to default after running test suite
Date: Wed, 19 Jul 2023 15:24:21 +0200
Message-Id: <20230719132421.584801-25-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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


