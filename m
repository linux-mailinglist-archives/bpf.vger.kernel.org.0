Return-Path: <bpf+bounces-70512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D74BC1A47
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F83934F8AE
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306272E1C5C;
	Tue,  7 Oct 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="PWedq49G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FE1CF96;
	Tue,  7 Oct 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846010; cv=none; b=RfYGeEnwdt8pdd9SOSW775p+xhKIWX2gXOkWClfJxFodVpnSb0fltIiA7mS0/FK8e2AQKDpLNVxsoyo/ejs567hIwouWtH2jY9+Xrm9dirp0QdYss58eVAUau4jRsLUqvk4zggUjnAGVMBF7fAeohSFw8kDNNfHpmTdt+pBghs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846010; c=relaxed/simple;
	bh=OPDdaWDKOAxCmqxFbeyTYOQIkH9eX6dgPSJpCJciY7A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sb0yaZ274enarrzac9j+iEJw1gvSCipyLsNyAc2xOWXJBDFEa7JvdqYCe79aCs/DElHsnGpmtAkQ2wzfWHcAo/VUW0ZfDtdkOeyi39LoYLt6WBkfJvCq7VFFEny7zhTZ5SPUcmqmme+6khq8Asz5iTJHZDdvAgIsTK9KPjVguwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=PWedq49G; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 1EBBB10C7800;
	Tue,  7 Oct 2025 17:06:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 1EBBB10C7800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1759846006; bh=B1h/NhFSvGKzs2lwZsaJd9XPGSb5oFBLrlRbiHNX/9M=;
	h=From:To:CC:Subject:Date:From;
	b=PWedq49G9GDTRIMhAZ6HsoT51da3zvEClnj1OMhTG98yi38j6TMuls3waf+sPbqoB
	 m6Z/2KucoCT+K3rMXDrDeh5Rg6wiFan5KjmucN6MLVQNTSua+qrlZPmucRFF3ZXZVE
	 Z51k7kvGZFaopZxn3/vtz1mlRmhN8PurQ5tW4DCk=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 19CE630CD6C9;
	Tue,  7 Oct 2025 17:06:46 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Magnus Karlsson <magnus.karlsson@intel.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Song
 Yoong Siang" <yoong.siang.song@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net v2] xsk: Fix overflow in descriptor validation
Thread-Topic: [PATCH net v2] xsk: Fix overflow in descriptor validation
Thread-Index: AQHcN5OdnXCPK8VDDEqW23qLq6U3NQ==
Date: Tue, 7 Oct 2025 14:06:45 +0000
Message-ID: <20251007140645.3199133-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/07 12:47:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/07 12:37:00 #27889104
X-KLMS-AntiVirus-Status: Clean, skipped

The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
option is also set, the value of the expression
'desc->len + pool->tx_metadata_len' can overflow and validation
of the incorrect descriptor will be successfully passed.
This can lead to a subsequent chain of arithmetic overflows
in the xsk_build_skb() function and incorrect sk_buff allocation.

To reproduce the overflow, this piece of userspace code can be used:
       struct xdp_umem_reg umem_reg;
       umem_reg.addr =3D (__u64)(void *)umem;
       ...
       umem_reg.chunk_size =3D 4096;
       umem_reg.tx_metadata_len =3D 16;
       umem_reg.flags =3D XDP_UMEM_TX_METADATA_LEN;
       setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
       ...

       xsk_ring_prod__reserve(tq, batch_size, &idx);

       for (i =3D 0; i < nr_packets; ++i) {
               struct xdp_desc *tx_desc =3D xsk_ring_prod__tx_desc(tq, idx =
+ i);
               tx_desc->addr =3D packets[i].addr;
               tx_desc->addr +=3D umem->tx_metadata_len;
               tx_desc->options =3D XDP_TX_METADATA;
               tx_desc->len =3D UINT32_MAX;
       }

       xsk_ring_prod__submit(tq, nr_packets);
       ...
       sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
v2: Add a repro
 net/xdp/xsk_queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index f16f390370dc..b206a8839b39 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -144,7 +144,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_=
buff_pool *pool,
 					    struct xdp_desc *desc)
 {
 	u64 addr =3D desc->addr - pool->tx_metadata_len;
-	u64 len =3D desc->len + pool->tx_metadata_len;
+	u64 len =3D (u64)desc->len + pool->tx_metadata_len;
 	u64 offset =3D addr & (pool->chunk_size - 1);
=20
 	if (!desc->len)
@@ -165,7 +165,7 @@ static inline bool xp_unaligned_validate_desc(struct xs=
k_buff_pool *pool,
 					      struct xdp_desc *desc)
 {
 	u64 addr =3D xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metad=
ata_len;
-	u64 len =3D desc->len + pool->tx_metadata_len;
+	u64 len =3D (u64)desc->len + pool->tx_metadata_len;
=20
 	if (!desc->len)
 		return false;
--=20
2.39.5

