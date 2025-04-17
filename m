Return-Path: <bpf+bounces-56130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A81A91BCF
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8068E17EA3E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1423817C;
	Thu, 17 Apr 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="XOc9N1kG"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F0221F07
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892509; cv=none; b=pk1CkhG8OAcWb0YiOI2vB6BYtJ4Bn/KovpUU6G9247F5R9qmb3Xd0oMMx67R0i+lKahmlNKnVzheHlRvH7Uzw7EQ4lHBIA1XBNlkhxGmeFFwmOzi+b6JhltpTUrWhqkTHb4Spxfz8X2GakaplcBEwwFryfzLduAaSiXkjz4opQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892509; c=relaxed/simple;
	bh=yim53aUfLmVou/JvqKYODc4xwB/wJ3VFd3Zy7HjYysY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRaVjnR+g/Y4nbYA2X73NWdzeuGiWven3MsCwRLIpwJjLDVw+jCJcuzcyXPj+rzpf3shyRbrNW4BiptFIj1/Gzhm2WREpeabSJwzoWUf5HMKtbzwA4pVbEMtdaNE2dDLNhOb43XVMX8u7GiZ4976XqTUxPE8j8Nx5wgzNdXsGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=XOc9N1kG; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 6B3361C0E7C
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 15:21:43 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1744892498; x=
	1745756499; bh=yim53aUfLmVou/JvqKYODc4xwB/wJ3VFd3Zy7HjYysY=; b=X
	Oc9N1kG+w3/vx99U9s8X5y6758ClWEjdx19507zYFz9q2Do3Y8vk+aqtdbjqvuO0
	gaYW9Hv7+/VfmiJBmrptxC76ElMdYVcSwt9UQvZErnFNwBoihJsgLDLU5GK2Dz0p
	tfywXE5fd0bSHBjAhK6xZV+AXrqxCVgNTbgDDGPFBM=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Wu1hCZhEo8yP for <bpf@vger.kernel.org>;
	Thu, 17 Apr 2025 15:21:38 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id B90721C08D8;
	Thu, 17 Apr 2025 15:21:30 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Juergen Gross <jgross@suse.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()
Date: Thu, 17 Apr 2025 12:21:17 +0000
Message-ID: <20250417122118.1009824-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function xdp_convert_buff_to_frame() may return NULL if it fails
to correctly convert the XDP buffer into an XDP frame due to memory
constraints, internal errors, or invalid data. Failing to check for NULL
may lead to a NULL pointer dereference if the result is used later in
processing, potentially causing crashes, data corruption, or undefined
behavior.

On XDP redirect failure, the associated page must be released explicitly
if it was previously retained via get_page(). Failing to do so may result
in a memory leak, as the pages reference count is not decremented.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/net/xen-netfront.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 63fe51d0e64d..1d3ff57a6125 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -985,20 +985,27 @@ static u32 xennet_run_xdp(struct netfront_queue *queue, struct page *pdata,
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_TX:
-		get_page(pdata);
 		xdpf = xdp_convert_buff_to_frame(xdp);
-		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
-		if (unlikely(!err))
-			xdp_return_frame_rx_napi(xdpf);
-		else if (unlikely(err < 0))
+		if (unlikely(!xdpf)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			break;
+		}
+		get_page(pdata);
+		err = xennet_xdp_xmit(queue->info->netdev, 1, &xdpf, 0);
+		if (unlikely(err <= 0)) {
+			if (err < 0)
+				trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_frame_rx_napi(xdpf);
+		}
 		break;
 	case XDP_REDIRECT:
 		get_page(pdata);
 		err = xdp_do_redirect(queue->info->netdev, xdp, prog);
 		*need_xdp_flush = true;
-		if (unlikely(err))
+		if (unlikely(err)) {
 			trace_xdp_exception(queue->info->netdev, prog, act);
+			xdp_return_buff(xdp);
+		}
 		break;
 	case XDP_PASS:
 	case XDP_DROP:
-- 
2.43.0


