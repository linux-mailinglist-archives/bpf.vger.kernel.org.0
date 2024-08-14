Return-Path: <bpf+bounces-37185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E7951FA2
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD741283080
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED71B9B3C;
	Wed, 14 Aug 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="QQkhUmtw"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896731B8EBC;
	Wed, 14 Aug 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652282; cv=none; b=pB8kkW7beVK1+pw9NInHz8MY2EKJn84bkYQmxQ60FAx2QTIYrqfodZxH4/atBkbCfgl/xb1sdwpz8SIoxSo+zxhVD2o+mJtRbjskuuiZUwKj9hWqHx8xE0bHdkY6ILNI0cA/XljgZ1rx0o3EWBFbbWFBeFa6GGcBipCXFngAuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652282; c=relaxed/simple;
	bh=NQTpemzt4Tj8++a5VIsyfyK7+ZLyBcJfu2xffJVhs0k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FitGZ79Mce+3lI2neqBvawvBfBkjvd2mtWxwDVpdd2ugdALtVcEke5fzaBEUoLjGl3A+HDcaMisS5xdXuxtiSpWyCYSY7xtEQiZGwozHXnP1r2KQLidVZtUhIlixDtZerFks6jyKAkuI144gt8y1HlOtN2+5SNicLoTsYKjq21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=QQkhUmtw; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1seGh1-00H1Fi-33; Wed, 14 Aug 2024 18:17:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID;
	bh=eO5sD2wD20qYLIyQAYTr+NiDMBMypw6HCWvaYXpaa6s=; b=QQkhUmtwnl8ckO8bW0pQNcbx2m
	gyEKnUqLeYNWPm3KCygcbh+QFQGqL3H7Qkt8c3EDXk6xjjU1fHzKyBs6QltpBiu1n0adkfj5S2QKQ
	ygHDNDPKGq1v+KVKZbK9XaWKjKThS/fUVmsyax5sKkXl9ZVhw1s+NgapuTE49iTX8LgVNbCNs0oF4
	6W9mZxjSumKrdmPDh6TZdOYVI8RmPjT3kljfg2kTOV4fwM8UetI7Yo8E9/CLQE6OUK9muPDOw14fD
	OLvaqseKMRpDgi6O71HoD1lhuxIOu4+tNoFm34s8f1JPOXioFsceOiPBi3b+NFLoASfjcmp0AWWwN
	hzeDIF7Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1seGh0-0005Xd-9h; Wed, 14 Aug 2024 18:17:46 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1seGgw-00EOyD-7r; Wed, 14 Aug 2024 18:17:42 +0200
Message-ID: <55559365-8dea-4458-a6f3-3b0cff9f051f@rbox.co>
Date: Wed, 14 Aug 2024 18:17:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] selftests/bpf: Support AF_UNIX SOCK_DGRAM socket pair
 creation
From: Michal Luczaj <mhal@rbox.co>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
 <87y159yi5m.fsf@cloudflare.com>
 <249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
 <87ttfxy28s.fsf@cloudflare.com>
 <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Handle AF_UNIX in init_addr_loopback(). For pair creation, bind() the peer
socket to make SOCK_DGRAM connect() happy.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 38e35c72bdaa..c50efa834a11 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -1,6 +1,7 @@
 #ifndef __SOCKMAP_HELPERS__
 #define __SOCKMAP_HELPERS__
 
+#include <sys/un.h>
 #include <linux/vm_sockets.h>
 
 /* include/linux/net.h */
@@ -283,6 +284,15 @@ static inline void init_addr_loopback6(struct sockaddr_storage *ss,
 	*len = sizeof(*addr6);
 }
 
+static inline void init_addr_loopback_unix(struct sockaddr_storage *ss,
+					   socklen_t *len)
+{
+	struct sockaddr_un *addr = memset(ss, 0, sizeof(*ss));
+
+	addr->sun_family = AF_UNIX;
+	*len = sizeof(sa_family_t);
+}
+
 static inline void init_addr_loopback_vsock(struct sockaddr_storage *ss,
 					    socklen_t *len)
 {
@@ -304,6 +314,9 @@ static inline void init_addr_loopback(int family, struct sockaddr_storage *ss,
 	case AF_INET6:
 		init_addr_loopback6(ss, len);
 		return;
+	case AF_UNIX:
+		init_addr_loopback_unix(ss, len);
+		return;
 	case AF_VSOCK:
 		init_addr_loopback_vsock(ss, len);
 		return;
@@ -390,21 +403,27 @@ static inline int create_pair(int family, int sotype, int *p0, int *p1)
 {
 	__close_fd int s, c = -1, p = -1;
 	struct sockaddr_storage addr;
-	socklen_t len = sizeof(addr);
+	socklen_t len;
 	int err;
 
 	s = socket_loopback(family, sotype);
 	if (s < 0)
 		return s;
 
-	err = xgetsockname(s, sockaddr(&addr), &len);
-	if (err)
-		return err;
-
 	c = xsocket(family, sotype, 0);
 	if (c < 0)
 		return c;
 
+	init_addr_loopback(family, &addr, &len);
+	err = xbind(c, sockaddr(&addr), len);
+	if (err)
+		return err;
+
+	len = sizeof(addr);
+	err = xgetsockname(s, sockaddr(&addr), &len);
+	if (err)
+		return err;
+
 	err = connect(c, sockaddr(&addr), len);
 	if (err) {
 		if (errno != EINPROGRESS) {
-- 
2.46.0


