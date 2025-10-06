Return-Path: <bpf+bounces-70417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8585BBD67B
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 11:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC4188CF04
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE6265CA8;
	Mon,  6 Oct 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="WrJ2cpU8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0C25785F;
	Mon,  6 Oct 2025 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759741260; cv=none; b=IqH6EmQuZust5dvOqCqeJY0nYigQFQcgkB0dz64Bjl8sE9sNAhrZLUIGt3D7COGLe5GKazNRdZ6UZ9n1rzrHZba1Ns2TcSOXP1c6g9t+jrn+pdPjh/Ygh/6e+3beveIoASFhVjmLX+Iq9ffJlR9Cf9Gj1H5ICvKUlkin26RX7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759741260; c=relaxed/simple;
	bh=3yL/MhIsstwXpp2kQreRg3k8ycTGLBAeFgRtPXuUXJk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HD+fvEL+MsTVZOXO/N+8diQYaNmTOZUuk/gJqtX3x7z2sOfxQRYTOOUPXOTHKnuuBOQLeViHtmokPYnvuzPQHXt+/1trYrfvkrhHjYxm23qTkDcfETvhPEiCcNmluLjgvOZ1mA3itD7VNKp+4pVWoriY/ADpbEUSVHtv6tFfCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=WrJ2cpU8; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id BE5BF111B77C;
	Mon,  6 Oct 2025 11:53:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru BE5BF111B77C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1759740798; bh=K//1oiUz0yl4wjuaNs+08F7DIiqQSpK/jGrr8MbB2P4=;
	h=From:To:CC:Subject:Date:From;
	b=WrJ2cpU8NKL7cB7l5/5n4nbRDTy8frsC0wYWG/eMrZZ8ecgw5+0GXMZsrOidpzUW3
	 CIkdvBPyBefibpobjX6c+/HzKB9nf9v5NTa1f1rpR+lQ/StbwUMf8Sb78b6FxcQ5d4
	 mIVMPW2pqlVrDKQ9qmothE5GkRjNySUKgX89RmUg=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id BB16230FC54C;
	Mon,  6 Oct 2025 11:53:17 +0300 (MSK)
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
Subject: [PATCH net] xsk: Fix overflow in descriptor validation@@
Thread-Topic: [PATCH net] xsk: Fix overflow in descriptor validation@@
Thread-Index: AQHcNp6oT200QhNWsUqu3koqEXW7oA==
Date: Mon, 6 Oct 2025 08:53:17 +0000
Message-ID: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2025/10/06 07:29:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2025/10/06 03:07:00 #27884785
X-KLMS-AntiVirus-Status: Clean, skipped

The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
option is also set, then the value of the expression
'desc->len + pool->tx_metadata_len' can overflow and validation
of the incorrect descriptor will be successfully passed.
This can lead to a subsequent chain of arithmetic overflows
in the xsk_build_skb() function and incorrect sk_buff allocation.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Cc: stable@vger.kernel.org
Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
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

