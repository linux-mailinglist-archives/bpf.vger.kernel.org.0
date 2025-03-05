Return-Path: <bpf+bounces-53382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0042A508AB
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610F417631D
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513BE25290B;
	Wed,  5 Mar 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kuN8C7Vb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D782512D6
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198152; cv=none; b=Tc2equs/BdhHkAqRGbcEpfoK7H1RpP/O7L1xvm03XY9kTmh22Ddo5w3Gdyo73UaTHjR0AohexL8v0Khi68nA+HtLdA2vFFUMKoKM87LVBvJ/OH1MmgiGAtZkQX4FdpNVl9FhdiiQsiPF/mGKBJqo2XDJgnVckarS0HJdaxBeZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198152; c=relaxed/simple;
	bh=TMYJJlrCKSQZCcdMd1zXdYIHHKwYt61VvQSuzMKoqkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTqFr7iX73Y1fq3toZNdvWddVpxpdhdUy4Jim+iLvJBkKcWlisTi7gR+AXSc9dZKsFejQJdDbb1wOqs45VBXiUSUYQ4ObQcUgKoH+wMoplH0vBndZO6xny/sogRVnAAOTZcMvU/q4Uj+Z57paC6hrMPdwRerTPaLSUuh9s+7iJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kuN8C7Vb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223594b3c6dso126648015ad.2
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741198150; x=1741802950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JDOLyKKadEy+ulLyQr89yMyXan48P03nG7aI65rkLw=;
        b=kuN8C7VbJx+sE3kTFmgofOOZWfbslO5TMFe+od6O4DH3D+BUmyKhUGyxB+FmXGkifT
         QBjmFW2U2+BEaTVFoGJuGlO3cSY6vsagyHm1HBF6HoHXvv1tPt/4o1RZN5GOEg83QiKL
         n2zE+Y09Hx/Ngpk4z83H+4jVnjMIY+C1mcPX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198150; x=1741802950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JDOLyKKadEy+ulLyQr89yMyXan48P03nG7aI65rkLw=;
        b=Ms/jSTiqMn55yHmb4ldkTMlZEWOgwystWGhfUXgo7XqKtkkKpbvP3ria+Mbwc+1/Yc
         ztwCn7yJxFMbBNu/v4P3DOVfr/3UedZGi2XRvMY3ib+rojzyTa/sTs1mqzhe6KmWbgIs
         fAknzfHqeXC2m9xXu/4SctJS2+hyd66+ro0X/Kslci2fjEyr6iZuYV7CwSwGe4bHktnh
         /ZFqFt4+z6VjCRPtmV2GjTYQDDQ0/6gafiIT1mU/TsZzHrv7P4jhQ+VDHZAPhd5pSvUa
         IZ1qBOkr6FddRb2/ngOTdFUjJO0dfNuYvpP1Cwxq8W7Y3vESmoypgX4LBRHslsOepaQj
         n05A==
X-Forwarded-Encrypted: i=1; AJvYcCUbOVvXAScqceFt3DGI6H6zCOOoJ+O0AdcF2E8Fsb0AQvUUm/yBbK5VfvvQSohcVRa2ABU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49MPUVsXvyo00Fx/pkTQlDd4iyUjVeRFZr7teChOrHstcAsDz
	QO7iRhn6zk8mifVMWjLzKzKSJS+ceRY2VQL87QeWyJ952nVBEEaCNMn3kYVEkXs=
X-Gm-Gg: ASbGncuVNqaNAAxTd9QCtzOU5+HD9cI1ryXnZUzzwOweo4bJnAVdXVHH1vuq/+FG2mg
	6Aiyo1k/ystEhzsufdfdtKlsYcwF40+ZmheArRIxRDOycZ3Sz+CRGXOsP9NE5z8e7szfcJQgSbd
	b/9eFSgoVnOpVO3fAk65/Y+xcFJDc9Sdu20d0YclzIyx/VOVvs53ygzMG5XHMNpPF86vNOzYU0j
	28gzVfolz+Hn9yGtED1MKcc8aXjBWMrYDJDMOVv+Eb1nLxe5J8tyU+nVwATaB1IYFi2kxbUNGxh
	QSP8XVu7TDCSUIXENIOofz3ILxQ33A+7CmiSogTB0SlOmGqkJzuX
X-Google-Smtp-Source: AGHT+IHHP9qQRDNcIJ6SYkbk3gQTYwbtsOWJYWum8dEqxwJMevmC/aplCxv04Fpb3qqFTQ3JZrfYzA==
X-Received: by 2002:a17:902:ec89:b0:224:76f:9e59 with SMTP id d9443c01a7336-224076fa0damr12749675ad.10.1741198149933;
        Wed, 05 Mar 2025 10:09:09 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db77fsm115568055ad.162.2025.03.05.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:09:09 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	avigailx.dahan@intel.com,
	anthony.l.nguyen@intel.com,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH iwl-net] igc: Fix XSK queue NAPI ID mapping
Date: Wed,  5 Mar 2025 18:09:00 +0000
Message-ID: <20250305180901.128286-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b65969856d4f ("igc: Link queues to NAPI instances"), the XSK
queues were incorrectly unmapped from their NAPI instances. After
discussion on the mailing list and the introduction of a test to codify
the expected behavior, we can see that the unmapping causes the
check_xsk test to fail:

NETIF=enp86s0 ./tools/testing/selftests/drivers/net/queues.py

[...]
  # Check|     ksft_eq(q.get('xsk', None), {},
  # Check failed None != {} xsk attr on queue we configured
  not ok 4 queues.check_xsk

After this commit, the test passes:

  ok 4 queues.check_xsk

Note that the test itself is only in net-next, so I tested this change
by applying it to my local net-next tree, booting, and running the test.

Cc: stable@vger.kernel.org
Fixes: b65969856d4f ("igc: Link queues to NAPI instances")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/igc/igc_xdp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 13bbd3346e01..869815f48ac1 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -86,7 +86,6 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		napi_disable(napi);
 	}
 
-	igc_set_queue_napi(adapter, queue_id, NULL);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	set_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
 
@@ -136,7 +135,6 @@ static int igc_xdp_disable_pool(struct igc_adapter *adapter, u16 queue_id)
 	xsk_pool_dma_unmap(pool, IGC_RX_DMA_ATTR);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &rx_ring->flags);
 	clear_bit(IGC_RING_FLAG_AF_XDP_ZC, &tx_ring->flags);
-	igc_set_queue_napi(adapter, queue_id, napi);
 
 	if (needs_reset) {
 		napi_enable(napi);

base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66
-- 
2.34.1


