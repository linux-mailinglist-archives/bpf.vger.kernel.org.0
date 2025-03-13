Return-Path: <bpf+bounces-53937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99233A5EEAA
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 09:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FF919C0664
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3D263F21;
	Thu, 13 Mar 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="MblLZ3Qk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA5262814;
	Thu, 13 Mar 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856241; cv=none; b=IyFZvafVi2NAuQd6TanJ/C2j2Mggi36Y8WqoTRIXiSOS7o5mO+PZ4D1gebtmHncTXy33KdRaJxflbW8FrY9mWLoVHK9EkWWtDC7eX9t5HGxeo+zVRw9dVA6UfBqIV5TWc6BfYEAO+KE2IAuSPJXohSUTJUebAy299fLAuXgjHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856241; c=relaxed/simple;
	bh=tpmeGUgGhllwUBBAGOlrE9cU2ApLt6CWcDTd6RNOAGo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mVGb+9HMt/24IdDUp6fwNL1pcmdOwpQtOqtO/5iZbFSn0war9B2H/eGQkASqPcHvrXT52x/DNPYb3B0yTgKptfSoIhuFhOilizyRZC8mGs5sNOPZMUxLxP2e3MoKMI86w7IvDge9vKIpwlYjGxoWQ+JeIib63hhH8Ee5bS1rsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=MblLZ3Qk; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 8495410B9393;
	Thu, 13 Mar 2025 11:50:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 8495410B9393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1741855808; bh=g0YsrEhjGz8lcic6OJN5Xenjkp1uFzhGdMlrY9qTx3c=;
	h=From:To:CC:Subject:Date:From;
	b=MblLZ3QkaC4Odm+VZcIN/XFNg2xu85pnqEzg4rJY8oA55qjLvuRkrS5crfkD4l8yV
	 JUgBFJcsnVPTIvAMG2YiTujbooZ0Wmp5USpDYsUg3tgchiOKVz98iOZvt1VokcI3qF
	 aBksXzRouly01wgzIg8J2Y3s7NEBziOa4lT264R4=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 80C4230375F8;
	Thu, 13 Mar 2025 11:50:08 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "bjorn@kernel.org" <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net] xsk: fix an integer overflow in
 xp_create_and_assign_umem()
Thread-Topic: [PATCH net] xsk: fix an integer overflow in
 xp_create_and_assign_umem()
Thread-Index: AQHbk/Tsm9QMCOUZtk69szSJlOz3iQ==
Date: Thu, 13 Mar 2025 08:50:08 +0000
Message-ID: <20250313085007.3116044-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2025/03/13 07:05:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/03/13 07:03:00 #27752837
X-KLMS-AntiVirus-Status: Clean, skipped

Since the i and pool->chunk_size variables are of type 'u32',
their product can wrap around and then be cast to 'u64'.
This can lead to two different XDP buffers pointing to the same
memory area.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 94033cd8e73b ("xsk: Optimize for aligned case")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
 net/xdp/xsk_buff_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f7975b49657..d158cb6dd391 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -105,7 +105,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct =
xdp_sock *xs,
 		if (pool->unaligned)
 			pool->free_heads[i] =3D xskb;
 		else
-			xp_init_xskb_addr(xskb, pool, i * pool->chunk_size);
+			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
 	}
=20
 	return pool;
--=20
2.39.5

