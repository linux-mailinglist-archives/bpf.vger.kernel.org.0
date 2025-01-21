Return-Path: <bpf+bounces-49357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6CAA17B69
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 11:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516027A1C7C
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5A1F2C5C;
	Tue, 21 Jan 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dxRtPjQX"
X-Original-To: bpf@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA061F1920;
	Tue, 21 Jan 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454950; cv=none; b=jqaXLsTHfsc5rETF3pzFhKADgFTcLdx847sEoW91AFuYuGbgPdfy17RmJV3BQT7+2eYPt4097cCrznfqv3Swdiu4keiLZnz+F2ak2Lz5orNiOf9fn1DPRAOuusC4tsIjNamuXHkdPI6MMFnSZjgYMYrgrW2qtVFwo7wqdmYelmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454950; c=relaxed/simple;
	bh=lPF21v0QCf4TQJl06JOjzYaiGuIDd/wbm8HXl/8BZTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cowPKw0YRHelk0crTriujPHRtaxuxF+daDg08Luewx9FpfVQvjmLNbTpD5gI9fzOtlab1eEXw/wCVwc5itV6b67Y3whl2ZWwkpsAzsBKav+z8UI7hokvRqZEYMF2wusk42zLxcOX2SehntQYF8noS66uHJ4KaqKq9Hy1/6RGQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dxRtPjQX; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EFA3240014;
	Tue, 21 Jan 2025 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737454945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBT+mxeaQwIc5Sp34PwBOPaxZFkUBRct8wsZOppLvVI=;
	b=dxRtPjQX8XKIowG2Ys1iec6AeybDvYi/qBCUgsy1gkBAGt1ZgcT2GfcjMpHYrgbadZRd07
	4ArcXyksKF5xCOsGULUl9JBIMFzZGN84zV4ECZN0433BYHtBNnZHkzbkSV6rWDmNTIcrcL
	r3XtClFQc8qmJ9MfBv9qQTexBxI92W3LJ6DG2KNJ+58dkvp/8FQ2Janqp6CTk5kStjjcEN
	f+oADVGYjF/QCPiykELmo/+HSRoGwwfgIQfevcq5509qfMlLal9P2d9gUwz4q/x/e5KSex
	V5hVickQw2CAr/DjmcZd74If1SUoczE/dCvo5fdiEAJC43HTs+s8zGu04wFKLw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 21 Jan 2025 11:22:20 +0100
Subject: [PATCH bpf-next 06/10] selftests/bpf: test_xdp_veth: Add new test
 cases for XDP flags
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-redirect-multi-v1-6-b215e35ff505@bootlin.com>
References: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
In-Reply-To: <20250121-redirect-multi-v1-0-b215e35ff505@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: bastien.curutchet@bootlin.com

The XDP redirection is tested without any flag provided to the
xdp_attach() function.

Add two subtests that check the correct behaviour with
XDP_FLAGS_{DRV/SKB}_MODE flags

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c       | 27 ++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 0aa1583b741b15f573bbb979b2047a0109070544..62a315d01e51739a7f13dddda3d5a569eab24ceb 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -33,6 +33,7 @@
 #include "xdp_dummy.skel.h"
 #include "xdp_redirect_map.skel.h"
 #include "xdp_tx.skel.h"
+#include <uapi/linux/if_link.h>
 
 #define VETH_PAIRS_COUNT	3
 #define NS_SUFFIX_LEN		6
@@ -185,26 +186,26 @@ static int check_ping(void)
 }
 
 #define VETH_REDIRECT_SKEL_NB	3
-void test_xdp_veth_redirect(void)
+static void xdp_veth_redirect(u32 flags)
 {
 	struct prog_configuration ping_config[VETH_PAIRS_COUNT] = {
 		{
 			.local_name = "xdp_redirect_map_0",
 			.remote_name = "xdp_dummy_prog",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		},
 		{
 			.local_name = "xdp_redirect_map_1",
 			.remote_name = "xdp_tx",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		},
 		{
 			.local_name = "xdp_redirect_map_2",
 			.remote_name = "xdp_dummy_prog",
-			.local_flags = 0,
-			.remote_flags = 0,
+			.local_flags = flags,
+			.remote_flags = flags,
 		}
 	};
 	struct bpf_object *bpf_objs[VETH_REDIRECT_SKEL_NB];
@@ -262,3 +263,15 @@ void test_xdp_veth_redirect(void)
 
 	cleanup_network();
 }
+
+void test_xdp_veth_redirect(void)
+{
+	if (test__start_subtest("0"))
+		xdp_veth_redirect(0);
+
+	if (test__start_subtest("DRV_MODE"))
+		xdp_veth_redirect(XDP_FLAGS_DRV_MODE);
+
+	if (test__start_subtest("SKB_MODE"))
+		xdp_veth_redirect(XDP_FLAGS_SKB_MODE);
+}

-- 
2.47.1


