Return-Path: <bpf+bounces-49856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA34A1D666
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 14:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF123A6D39
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B871F1FF1DF;
	Mon, 27 Jan 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSLjNTZw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D311FF1B4
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983635; cv=none; b=dFrXIqFO4BVgg57Q+1gx651hjAZZv9f5W+Uy85dcUDqLDVJF8uvTA4yESiRZ6SEWvLO/E3Aq7sp/cDaJ8oISuH/wEKB65aIFxNd9Q+MH7V47XvmNNFXjCVl4dTs5qlAXfeQDcO3JkFZmUoIad4INCCBtGAkTkoLQtAJ2rPFkzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983635; c=relaxed/simple;
	bh=UG1uWB9PPsdJVySf4XB80nqQdIhk5TQ8Trsvg6yxuvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KIrKY9xhnf6Rotai1En3pfXBVsktPuhTUt2Z2cn8a9hFZn8wr6GJx5Bw8ifUO3h1tKF3Xgc86g3X9kT9ZgtARiDgInMWV6YSWBuhY/1u/83LnxiXduymF2s5nVKYYhaS/yjYqCDeFn4depFPS1aHKOCgkv1dl8ytZ60IOSgyemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSLjNTZw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737983632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcUM4E5/zqehZHkTb/+XMPrTsEhKyeNv3Vdv9RdTApE=;
	b=PSLjNTZw2wDC2whzo5r8R4XdzbUtuXTze4J/u8SPcfWsoWtrpl8Kva8XWYkejsZhmMiCmT
	23FemoPyDCVIac/rmMmo0idsAFCPsFzARroHpr+JM1KLGkQJNtZCTEbQnV45cyDwYIB9Kt
	t+gfHhrG/sPEFxqIM4hVdyqLoIf8mio=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-0fa3LLS0PQCqsB43rUqxGQ-1; Mon, 27 Jan 2025 08:13:51 -0500
X-MC-Unique: 0fa3LLS0PQCqsB43rUqxGQ-1
X-Mimecast-MFC-AGG-ID: 0fa3LLS0PQCqsB43rUqxGQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aab954d1116so419763166b.3
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 05:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737983630; x=1738588430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcUM4E5/zqehZHkTb/+XMPrTsEhKyeNv3Vdv9RdTApE=;
        b=o785OROgGIkjMcKTuGi7Rx7ZF2/Cb3SHHVuGAeWlVOZYBL4jRZsC5kYtOpQR1z08ig
         pfHS9TZHqUQpIFlY2om9p9Yc/bLlvafXn/qez8GsudCHzixFuB8tSN69DTsC+NxUVcXG
         F7rw+UK26EIOqBzktz81T+HP9HdhXMUNgwk56mTTeB8PvYfR+njdxHjHQgRytdVoDaEa
         mupZJly6REYqwIZ8rTXnIpB5z4AKLy90+FA3XGXrtODaWdYR7OUmSqMbMpjoG1cUYTZd
         mNJz1hAAN5+WWZzC96MLamm6FHgJ6QVKFlB0R+2UiXhaVqlCnZRq10InI7bNMuOfaa4Q
         2tXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSm11fI46yNXFnpsrMYdXUaJcPLdu6aIbFjxWBM4/m5m5TUu20mvZMA4Nz54JAG/XOGSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavP/kuURGR2PXqk5z9KpJtTPTUHgQ9v9kX7B+Rb7txyEd2W9H
	A2749B7iU1bYwDV86y9s76IKIVAji5FyYdbz3fXqsvjFUWDJZ5O4eB09WkpK1HC9Ouj7cihV7BW
	nLfHBgF0Uuwol4+L1s5HUFAJ4AqQmQFLY2VxkVwjbrG+2xf3Uxg==
X-Gm-Gg: ASbGnct2AkLmfNP1uUcAL3h0mbkiIkdvborb5wJRNsKaU9BYLZjj9+j6aykcS9+xgri
	Qrs1AOd3kZq8tHllYf4WDwV3e2BzeKRer6ARkbAlj71fh2NPLViSrYEsJJR+/hIJGmZPftug0Ax
	kMlQujvTUcJLiIn/EPlE7aMQsorJ1qp/Hs1HHF2IQ4me6OML+O4SX9Deozq4KxF9MHqQvSPIYdN
	iXeg27xEt/1+e5r22x/24B4lyBDcCXxpAD97oU89bamiLLW6XRN4MJ/mmcXrTHvXPENuMoYK5tW
	bc511n6u2PRg/BefjOd/XjpqAEtnBQ==
X-Received: by 2002:a17:906:4e95:b0:ab3:9fda:8de6 with SMTP id a640c23a62f3a-ab39fda9d0fmr2873612866b.53.1737983630015;
        Mon, 27 Jan 2025 05:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVolCeZJHuXjqdhHG/qXr2B3y0CAjTQR5vG/mpSIuxPZT28Ss3xWkda9FoT57ev6ADNksOrA==
X-Received: by 2002:a17:906:4e95:b0:ab3:9fda:8de6 with SMTP id a640c23a62f3a-ab39fda9d0fmr2873610066b.53.1737983629669;
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69051b1ddsm357596366b.180.2025.01.27.05.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 05:13:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 05397180AEB5; Mon, 27 Jan 2025 14:13:47 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/2] net: xdp: Disallow attaching device-bound programs in generic mode
Date: Mon, 27 Jan 2025 14:13:42 +0100
Message-ID: <20250127131344.238147-1-toke@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Device-bound programs are used to support RX metadata kfuncs. These
kfuncs are driver-specific and rely on the driver context to read the
metadata. This means they can't work in generic XDP mode. However, there
is no check to disallow such programs from being attached in generic
mode, in which case the metadata kfuncs will be called in an invalid
context, leading to crashes.

Fix this by adding a check to disallow attaching device-bound programs
in generic mode.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/r/dae862ec-43b5-41a0-8edf-46c59071cdda@hetzner-cloud.de
Tested-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..c1fa68264989 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9924,6 +9924,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "Program bound to different device");
 			return -EINVAL;
 		}
+		if (bpf_prog_is_dev_bound(new_prog->aux) && mode == XDP_MODE_SKB) {
+			NL_SET_ERR_MSG(extack, "Can't attach device-bound programs in generic mode");
+			return -EINVAL;
+		}
 		if (new_prog->expected_attach_type == BPF_XDP_DEVMAP) {
 			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
 			return -EINVAL;
-- 
2.48.1


