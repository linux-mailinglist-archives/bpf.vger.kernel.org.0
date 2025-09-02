Return-Path: <bpf+bounces-67171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D9B40184
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62924188E676
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 12:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD32DC35D;
	Tue,  2 Sep 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o34fEPke"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78A2DCBEC;
	Tue,  2 Sep 2025 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817644; cv=none; b=VfrO/PtFxwggfpw698ppbuo3N0q1h/HKzClSu4LkGXn/vEXgD7t8/rBimGQqOwp2syZRW2brWcfGAuDivwc7y7ClxdzzIrnWGOda1HXgn1uZr4LMo0DGdI8dMIVoSWxOt1H/H4nwR7uc1z9Xxhzbvk8qnQ8NvdKRD7uZMd34OvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817644; c=relaxed/simple;
	bh=jbwyX8Pv/r9G8HGLbfomIMAf8qfNVVeRgQKhdS0mBFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkPjrTCGbrU+Wafw/bNMLkKJRHLMhFrrHNrj4PZ77lQupw3WIdgwMBjEz4rqLae3CtcXaxY2Wn4HI1ey+Omq+Rri/UhO7VtSVuIxeSBq7OnxgPoqoDBBbJagq6euNp8SF/eBkK4IvOxtOCnxtdohtul//kvoNLJtMNtUyGqArTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o34fEPke; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 164E91A09B9;
	Tue,  2 Sep 2025 12:54:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2B9E60695;
	Tue,  2 Sep 2025 12:54:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B4991C228A5D;
	Tue,  2 Sep 2025 14:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756817638; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JmrrjAsMsSmzWD7G/h8wp1LIy9K4Mv6aWYyPKQAPvQ8=;
	b=o34fEPkehiA9hkmfUFr5af7Zx5GflduQr4HiaUKgfaA2mZeYUi+NG2InpVr0pYO9NWcTLD
	+Hn5NANq4GGZRJgKxmKwCkSr2yYwtomUMC1kgXSa0v/DvxZ0DHS1Uw4DH2OFr0McZQQRtu
	4hEgN2khYeGbPMttFNQAj9Qjr51TwNC8ImwTWHNjGgVhtV/CiPWlSE/UAG9PyQxD6d+atS
	9kOaddg2XJtMhtKCY3lqg9PVdd4b0GPlE6ci7Z0PmPmR1ESWM9NcOTRf3bnwyARt+sEuUe
	l43sKM/0nN9iycGavuOWC9HmwD9wvpOJzkEHPZ3uCplcshnJ47hOgBI2rZkbOg==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Tue, 02 Sep 2025 14:49:55 +0200
Subject: [PATCH bpf-next v2 05/14] selftests/bpf: test_xsk: Release
 resources when swap fails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-xsk-v2-5-17c6345d5215@bootlin.com>
References: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
In-Reply-To: <20250902-xsk-v2-0-17c6345d5215@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

testapp_validate_traffic() doesn't release the sockets and the umem
created by the threads if the test isn't currently in its last step.
Thus, if the swap_xsk_resources() fails before the last step, the
created resources aren't cleaned up.

Clean the sockets and the umem in case of swap_xsk_resources() failure.

Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 978a72b477e0e37836eb3bb7b869dab09252d287..074cb8f9487e489834b4bd081cb58b51c73c3b75 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1873,8 +1873,13 @@ int testapp_xdp_prog_cleanup(struct test_spec *test)
 	if (testapp_validate_traffic(test))
 		return TEST_FAILURE;
 
-	if (swap_xsk_resources(test))
+	if (swap_xsk_resources(test)) {
+		clean_sockets(test, test->ifobj_rx);
+		clean_sockets(test, test->ifobj_tx);
+		clean_umem(test, test->ifobj_rx, test->ifobj_tx);
 		return TEST_FAILURE;
+	}
+
 	return testapp_validate_traffic(test);
 }
 

-- 
2.50.1


