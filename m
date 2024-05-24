Return-Path: <bpf+bounces-30483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6AC8CE59D
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EC6B220B8
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 13:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C47127B4D;
	Fri, 24 May 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="NkN5FOOe"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229585C79;
	Fri, 24 May 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555692; cv=none; b=UEixFxCjy4xdgMWjLye/sdR0ejOLvFyF9jyHMnotPVBZ+GT9/naXGd2MWigvdzVC4JSCx/a7wW9PYSjlgL6Bxe34QTnUGXfGTegDJuV8gkyxoL6Z0dAYcFxchobotJPR1oyvL+igt50KLd3hbmFPkgdeU2RkCp/ff/GJWWNYPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555692; c=relaxed/simple;
	bh=W44WPaTBomKN1HqhFb9uSwCEX6wCjxb0g/hFjuGUKpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXUne6w66Rcohu4u6lhwWTp56sFztTUn/xq4N1WwqTyMSQ8lmThtNZ6UUCVGjn6/HTQFbaG4W7E0bRz69ENkwCJXFizJaXUstVuO38AEA3sZVHMifmGd5+5FbQvivFNKNyqrg2j5v9XqJhzROjXG8kua9MPijgrROpjb7AeC1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=NkN5FOOe; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H8H1nYgoGwazInwWLdG4v/d2OWD3y0iYjQ9rmqKuzY0=; b=NkN5FOOeJwFdskXcZgPHECYsXe
	NyD80oqwQqfUHvC6fEX7SXr66HVLOnlJmHYTb4i8r3ekr/a98cCl+J9DHksZFxvEDVLdo7uMlWJ/o
	3HIr/s3mi2QKjAprAkCd9sHReeleHZEr6OutWOuFqrH+mOen5YxQZX7vfgpbYfttEuG1xfsZaZQKt
	YP0PMjoVL5Mo2sOh+rv2C8RwzJiJO4WWEN53Qh4X+uyEjRddRoFouF+MnJk/Hzg/IENgAF77wB2M3
	jy7WpNKfooZPctVB/CZY008UY9jt92vTDrujFDLXQ8rB4ZjoRbdn+88QuQ0gQfrjuoXeqGA5fCi+N
	wOYJ5jDw==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAUXy-000K5U-Hm; Fri, 24 May 2024 15:01:22 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: martin.lau@kernel.org
Cc: razor@blackwall.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 4/5] selftests/bpf: Add netkit tests for mac address and mtu
Date: Fri, 24 May 2024 15:01:14 +0200
Message-Id: <20240524130115.9854-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240524130115.9854-1-daniel@iogearbox.net>
References: <20240524130115.9854-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

This adds two simple tests around setting MAC addresses in the different
netkit modes as well as syncing MTUs.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/tc_netkit.c      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
index 15ee7b2fc410..598f9d5e656b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_netkit.c
@@ -73,6 +73,25 @@ static int create_netkit(int mode, int policy, int peer_policy, int *ifindex,
 			 "up primary");
 	ASSERT_OK(system("ip addr add dev " netkit_name " 10.0.0.1/24"),
 			 "addr primary");
+
+	ASSERT_OK(system("ip link set dev " netkit_name " mtu 4000"),
+			 "set mtu");
+	ASSERT_OK(system("ip link show dev " netkit_peer " | grep 4000 > /dev/null"),
+			 "get mtu");
+	ASSERT_OK(system("ip link set dev " netkit_peer " mtu 1500"),
+			 "set mtu");
+	ASSERT_OK(system("ip link show dev " netkit_peer " | grep 4000 > /dev/null"),
+			 "get mtu");
+
+	if (mode == NETKIT_L3) {
+		ASSERT_EQ(system("ip link set dev " netkit_name
+				 " addr ee:ff:bb:cc:aa:dd 2> /dev/null"), 512,
+				 "set hwaddress");
+	} else {
+		ASSERT_OK(system("ip link set dev " netkit_name
+				 " addr ee:ff:bb:cc:aa:dd"),
+				 "set hwaddress");
+	}
 	if (same_netns) {
 		ASSERT_OK(system("ip link set dev " netkit_peer " up"),
 				 "up peer");
-- 
2.34.1


