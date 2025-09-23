Return-Path: <bpf+bounces-69478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A0B976F1
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 22:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD043322CAA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31E30BF6C;
	Tue, 23 Sep 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOKr9NwM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBF30BB81
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657652; cv=none; b=cghAACy3slPyKT9v1F6xQ1DCI/mCqDndZA2aGmk9YkLdrZ6Xmfq87fmcjoF+UiV9YOlWTumuNNZ9uStY7NaIyra0H8VzAnD+rSJWLy4svm+prNjS98wnRkJbzCpCrF2xtSRihTzstOu3AFu1aiwEFD+w/bHKUu1zKgjaPTbhHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657652; c=relaxed/simple;
	bh=0fk/n7B9mEiC2MeLQRlJTessoCBaV440mO7d/PjdBWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvrun7AmiXeU3gieY8202utaNmle/LlyOylRBt8GwUmvIXbam8RlvdLKATZSx/XkOo3QOtbI2lQOqzcBGdHc41gpzi+NW1k3aWNt6fCvcBjZqz13W0m7FNI2xkucpATkxdKBX9IGSIw8OQYRhJdM2cuUnrNo8Av73XWSL004+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOKr9NwM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b2b8b6a1429so44648066b.1
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657648; x=1759262448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxvGwdECme9sva+F1ujIW8jaKUJIsBLHPhmAsgPJYCQ=;
        b=QOKr9NwM/6or7EQebm5FE7VP3tOWQMPUKsh/107AMXeUNWsDB0R3F1KuSvB8poPTrg
         iTTGpClFIY2RCEirkfwu2C31vOBHY8+jNKt+xVTKqBWvAVTzHHD+o8kEu4lIRe8yeKiP
         G4uWeXFNfybb+cu11YBcb4Jfh6yyMcXxWPei60w+ezC6AYBKW/QWErcTYqm1tlaC+QcG
         2fzvNDOChGNsDZx7Qj5RxJTG/xD4duO6hkNaGcopWW+TVx9GUMRmOKgBZe8+aTfHDkM2
         aNKDu7x6Wx0GL4YpmdtpwyYQtp4j7rJyhr85qtPgkTiulzNcHdyTIgWXpPg0ow1Kkr+5
         Hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657648; x=1759262448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxvGwdECme9sva+F1ujIW8jaKUJIsBLHPhmAsgPJYCQ=;
        b=GGOtVPpJttVOsP+W4OZx+xPHeWvGoGgt8Fv94csgp4i99OF0GPkktXcl01anuXuIKQ
         hIVdgKTU04+Doe7OKD3sdbA/WcuUMN1PsZ08nVz7svkBe9KTOf3SdYIVFDqzK+6gBZyi
         yST1VPmLul9oGCkq5UKo/9p+Pvjo7vIrz5mUDVO9NgEmb8udrDqHF9aiVohmoTFb/ukk
         VKrfIeINaPUhaQZ5ADMhvgYwukz1uO1ZOR8JsTqsDcSSg75EgrNk/tpkTg+N/3oewT7W
         iZpuoazIsBpNMMW9k6/Oa3AY9+y4cVsWjZCieFdRVw0IIPWqGi68Mr/H8jblZjTd/ecB
         58jw==
X-Forwarded-Encrypted: i=1; AJvYcCW724homxQIHX/pQA5D2OVPxxoR5RH0SyE/DEUTBQKvEIJf3yMeM7VYfRzNUR6hfnsTLM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq1V+a+mohrk9KaDnBuOOpyxhV3UwJjqXIdPURw2Ps+J6gD7Y
	5EcMgafPGRCSYqPY762B9vJy0iRug4hrqcJSlv9cV/TDTv8JaFuZIfNd
X-Gm-Gg: ASbGncvBTP/O1jDUnjsRorLtltE8K5o7TCdnKspSZtzaPgr2Mw8nxLNdiWZjey5qTKG
	Xd7VAyxzTfd0S8B75ZAs2wU/pOpEu/s0p5H2sN3L//knUXjHEPIhi8QbtsQpOfA8LwR21ieEx1/
	kF1Kp8GryyZ3WltIlfTe+JfqtN9uI9UGuLwI1EFiNJ8bClgXGfB5bHfbKUPlQ4utetV7vc3iTWm
	7hyP/cfFztQ8eB8HW6urqzep4Gg9DOsS88grBtRZ21d92jW7WC76X6V/W5yvOoL3Xt+l3cTs5wB
	HX+vTVqAHUFjQCCdcsnGdUxUdF7nE472J0mtRv+irkYWVRBadPLR1eYmUtTKkvhHXHE0LAj/fWY
	aMMKXD1G33tTwrtWj35/VRBFlDUmJ+VK7m00=
X-Google-Smtp-Source: AGHT+IE9jKk/zzdKDwXkO7sxSkoqe/jjpTEgScJwrOwZYkbO90+nHVble2JF4n49Nmv6GbSPvrhTqg==
X-Received: by 2002:a17:907:940f:b0:af9:6580:c34f with SMTP id a640c23a62f3a-b302ae307b6mr174461766b.9.1758657648256;
        Tue, 23 Sep 2025 13:00:48 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:48 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 2/4] net: xdp: Add xmo_rx_queue_index callback
Date: Tue, 23 Sep 2025 22:00:13 +0100
Message-ID: <20250923210026.3870-3-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce xmo_rx_queue_index netdev callback in order allow the eBPF
program bounded to the device to retrieve the RX queue index from the
hw NIC.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 include/net/xdp.h |  5 +++++
 net/core/xdp.c    | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b40f1f96cb11..edbf66c31f83 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -547,6 +547,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_QUEUE_INDEX, \
+			   NETDEV_XDP_RX_METADATA_QUEUE_INDEX, \
+			   bpf_xdp_metadata_rx_queue_index, \
+			   xmo_rx_queue_index) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -610,6 +614,7 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_queue_index)(const struct xdp_md *ctx, u32 *queue_index);
 };
 
 #ifdef CONFIG_NET
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 491334b9b8be..78c0c63e343c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -962,6 +962,21 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_queue_index - Read XDP frame RX queue index.
+ * @ctx: XDP context pointer.
+ * @queue_index: Return value pointer.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
+ * * ``-ENODATA``    : means no RX queue index available for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_queue_index(const struct xdp_md *ctx, u32 *queue_index)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
-- 
2.51.0


