Return-Path: <bpf+bounces-56672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9780FA9BF6E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 09:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260889A2A66
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758752343D4;
	Fri, 25 Apr 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP+ukEfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AC231A55;
	Fri, 25 Apr 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565125; cv=none; b=UQZrN2FWeX3s8iSHipsDLnvzaaKtS1OIG/t6PRlviwNt54aHONGN8D0ZYf5ZfkTZckU8Zp6gvy3vYfBivAjMmXb2SZjVNBFNZWQPglR0k/ThlQSdpLjlcKzF3OVqItNfZ3rDM6OqChtKzX4qwf/ivNWRTan1crEZd6kj3wolZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565125; c=relaxed/simple;
	bh=fbFQYkrN1XH+y7ZVmfRanb5zZ2ao2S6rtD9w9lEiSmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGCv4gW21W/8owJ7ug8so0TtWJ0MA3CsmVx9+8e0uRdkwbxmJajFz7HpyUHcARJOvlwict6VzNNtM5vpYm5lmdtC4/X6cHZfJbY93kQH9wMD6etDxev0G4BMchJZkztsgTMVjCcJi6nj0rHG1W3aCRjNp7qqMtLN06tffTC+4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP+ukEfr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso1341806a91.2;
        Fri, 25 Apr 2025 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565123; x=1746169923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lldMq3GuKsNS7Tmp5QkmsxzmnppZ1kmVjOK5AIUcWk=;
        b=BP+ukEfr7/nydIyscoTYSGuqnEYOUp5vqz38LQ4C4PyL9AYDc6U/b16ZKwSiIkbn25
         pkQGpM646T6QPsx9PROgMl/CZmjZkcZfBEDOGy3eUgudNyvhqwjDesYzIQevI5J9fvgB
         dXLJd/ZpaVJqPV5uz2UQUdu3uNZgDmqWDPceXsLj041tskjtIO5mhtnooO87rVzCN5RN
         sK5OxJU2ffVzx34V2ELcqgzaeMJyTIRospUFB4h/Tbg0TmIKmqhfO+XqIko7nWEmfp37
         jAhiEkct5nzSWaKsWZVJzfdC8a/jZrvJBEkzCin55ad7MohS4hBScSIBB4/VIXlzds6o
         vYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565123; x=1746169923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lldMq3GuKsNS7Tmp5QkmsxzmnppZ1kmVjOK5AIUcWk=;
        b=f1yHQhuaAB7/4tR6JUdwnmsJ5ONTSyaoLRJAI89nj0FthCucxf/Mc1AtTJ18AkS6Ak
         KqAgmWWypxSubPN3mvVMySaFCmlV1+0hK5DWi0QZKD8cwehVfJl6WkEH051SCkRYcpX7
         sunY8cQzUnKMl9AkwdlmdKgXbPcMtldq1FoYL2c/rymn6bc1L2I74ADkjINa7at76y/7
         5RHy16CIH8Ll2o/RX/vjLILAFEIume7zMlnEN9D2TPU3qBJb5IZutFfLRFpMchh/eAVS
         heyYqKfPy7ysO76u2t7JhZvprIQ6I9aRINrQBVpkxfpQ5KNvSfqJkU3T2plZg7Od+mJ7
         n/3w==
X-Forwarded-Encrypted: i=1; AJvYcCVoTwXUFDR5D0drr6CtyaFfxVVXyILV+HaUOmTPPQDl2YRxT2nIpj7eVuIeoFhcLqLWFcCMTYaM@vger.kernel.org, AJvYcCWvhNT6uvEJxbgXd1rvqD6dExIKI6kNYQXwgIWydYSasbXna3aZ2t59e9vW8l2o50OnDvs=@vger.kernel.org, AJvYcCX/dZb6L5wbhDR6TJWn4sSSHRBUvsATHEFifdpAseSgMlCl5C/L32Cck8HnU8+Z7tQZ3X4jA2jL8myLxNeB@vger.kernel.org
X-Gm-Message-State: AOJu0YypERSq/GGVFAMM4yBHFhJv07mpUP8EbFnlNuMXggVoA65XONAW
	McwbgfFzc+3Teq8AhaV5Eu3F0H9ZZo74c5V9AzZXQJcSboRHws8Q
X-Gm-Gg: ASbGncu6u2m2nEHRGVVynqWXox5GiqCYXufLiWorXMUquM7X9Xu6I/TOHzf5mVhc1Zg
	07e5OoDIyaCGqhdyYqurTjmBHuDncCI6vKRdVsTjPQBRB4JHKL+jG7qH0dpHR+75fqbMvP5F7SS
	ZkaMBp7Xv+WFPS8qQ8rYTFjc8t7c7qM+OrxVjEOYxeuzkxfaUnKE9CPYbeSHeBwa19sbA4+7Wzd
	z+lprLuh31t/ehOuPg7ucfY1jXgCx1VJxREJOk6GsZ31MNC/5jNUUNriutQ0WiOF/jOoMVFjZKE
	nuxpxxE+TiSy2I7RykDHBrexPtm7bn5AvqJG1kaN5Cv67We+saSP3Non
X-Google-Smtp-Source: AGHT+IGOLflJPiM1kAIV4XAg02lYJ1F9ADWNr/7fQCvJe3nlEDTR3ljD5CXGvcCmPzqN9F2GvEwZqw==
X-Received: by 2002:a17:90a:bb8f:b0:305:5f32:d9f0 with SMTP id 98e67ed59e1d1-309f8db391amr1240737a91.19.1745565122928;
        Fri, 25 Apr 2025 00:12:02 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:12:02 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v6 3/4] selftests: net: retry when bind returns EBUSY in xdp_helper
Date: Fri, 25 Apr 2025 14:10:17 +0700
Message-ID: <20250425071018.36078-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When binding the XDP socket, we may get EBUSY because the deferred
destructor of XDP socket in previous test has not been executed yet. If
that is the case, just sleep and retry some times.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
index 6327863cafa6..eb025a9f35b1 100644
--- a/tools/testing/selftests/net/lib/xdp_helper.c
+++ b/tools/testing/selftests/net/lib/xdp_helper.c
@@ -38,6 +38,7 @@ int main(int argc, char **argv)
 	struct sockaddr_xdp sxdp = { 0 };
 	int num_desc = NUM_DESC;
 	void *umem_area;
+	int retry = 0;
 	int ifindex;
 	int sock_fd;
 	int queue;
@@ -102,11 +103,20 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) != 0) {
-		munmap(umem_area, UMEM_SZ);
-		perror("bind failed");
-		close(sock_fd);
-		return 1;
+	while (1) {
+		if (bind(sock_fd, (struct sockaddr *)&sxdp, sizeof(sxdp)) == 0)
+			break;
+
+		if (errno == EBUSY && retry < 3) {
+			retry++;
+			sleep(1);
+			continue;
+		} else {
+			perror("bind failed");
+			munmap(umem_area, UMEM_SZ);
+			close(sock_fd);
+			return 1;
+		}
 	}
 
 	ksft_ready();
-- 
2.43.0


