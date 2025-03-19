Return-Path: <bpf+bounces-54374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE8AA68F6D
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08FC1895B51
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9C1BDA97;
	Wed, 19 Mar 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b="EOUE4a5r"
X-Original-To: bpf@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658161B3927
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393945; cv=none; b=AP7QXI9DXirffS2Ecy5Q8AH7HvbDAZafhK94c4dvaLi8UrWaRcjY+9vq4f8GUrfMSHaqVldPGW7lRpyIYBEvDgbhtx7Ary2hLHOEFAQCVQUbSvblvjTUykbcEJ20g6bDjAFkryCJkzup+tV9iKR7GVM8jJgUgABHm6vYIL4knEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393945; c=relaxed/simple;
	bh=2L1hcEbbpNxwS2XQn1kzLK0IbRFrHfVbWmh856XdmwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oZeFaVK9OioTQpd7qiMs6oHw1wKpv4aLv9uXLjt5ex87TF8Oy0INzyH3sh1LDA8h4o1J0fhuaNiMkbZ0zJ8RdTCVgZsYSEnUzZEg9e/wXk3JJ1Q94G/7TvSZNPalUcdVuwj1qCQc/xS9Kr0lKd7VuJIzeRL3Lhn7/Wb9pe7fp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=zdenek.bouska@siemens.com header.b=EOUE4a5r; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025031914185424006384514bbc3c8a
        for <bpf@vger.kernel.org>;
        Wed, 19 Mar 2025 15:18:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=zdenek.bouska@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FXf6tL/+fXL9ZakOV01DQToLMo02isnVavTFvix+Ba0=;
 b=EOUE4a5rtVTenrtqYNTdHbRZYiix4F6UPZZaUfLC9KR+J+VW2I4JzXjU0fhpb3yc/pJhgG
 BfiHg7QNxOvU4sCp6rMCoRiFHaqd/cegjSrLxQ4kYctXFLuVMoS8ZehW3owXNSoKqnhSUWb3
 n+6w6dNm+gWOqA5Qo/JQzZV67sl0ws2zlPIVdnHkeYElI+FtaOTtrBiLI9uzd2ETDBq2VzZK
 aBju6jIeizNfSdVWRfLzp37P0X+O4Id9B8dA2qry6Pm3V0WZcCb+/IQqXuo20IRkwTZoqsls
 083OVNl2TAjQ3WDz91CS8mdaccSShswMP3BA4vtZZ+gmMnCl5pUPknZw==;
From: Zdenek Bouska <zdenek.bouska@siemens.com>
Date: Wed, 19 Mar 2025 15:18:48 +0100
Subject: [PATCH net-next] igc: Fix TX drops in XDP ZC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-igc-fix-tx-zero-copy-drops-v1-1-d90bc63a4dc4@siemens.com>
X-B4-Tracking: v=1; b=H4sIAEfS2mcC/x3MQQrCMBBG4auUWftDpokgXkVclHSss0nCJEhs6
 d0NLj94vIOqmEql+3SQyUer5jTAl4nie0mbQNdhmt18dZ4ddIt4aUfr2MUyYi5frJZLBcew3Dg
 Edt7TGBSTUf7nD0rSkKQ3ep7nD3oYTEp2AAAA
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andre Guedes <andre.guedes@intel.com>, 
 Vedang Patel <vedang.patel@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jithu Joseph <jithu.joseph@intel.com>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Zdenek Bouska <zdenek.bouska@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328595:519-21489:flowmailer

Fixes TX frame drops in AF_XDP zero copy mode when budget < 4.
xsk_tx_peek_desc() consumed TX frame and it was ignored because of
low budget. Not even AF_XDP completion was done for dropped frames.

It can be reproduced on i226 by sending 100000x 60 B frames with
launch time set to minimal IPG (672 ns between starts of frames)
on 1Gbit/s. Always 1026 frames are not sent and are missing a
completion.

Fixes: 9acf59a752d4c ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Zdenek Bouska <zdenek.bouska@siemens.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 472f009630c9..f2e0a30a3497 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3042,7 +3042,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	 * descriptors. Therefore, to be safe, we always ensure we have at least
 	 * 4 descriptors available.
 	 */
-	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
+	while (budget >= 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
 		struct igc_metadata_request meta_req;
 		struct xsk_tx_metadata *meta = NULL;
 		struct igc_tx_buffer *bi;

---
base-commit: 8ef890df4031121a94407c84659125cbccd3fdbe
change-id: 20250310-igc-fix-tx-zero-copy-drops-1c4a81441033

Best regards,
-- 
Zdenek Bouska

Siemens, s.r.o.
Foundational Technologies


