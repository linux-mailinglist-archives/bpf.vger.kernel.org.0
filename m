Return-Path: <bpf+bounces-45855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE439DBE5F
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 02:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F5164B9C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4711F92A;
	Fri, 29 Nov 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj179ClF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AD17C77;
	Fri, 29 Nov 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843357; cv=none; b=BzK3EgXMkSiZbbClIuVtAQBsphSSYe/ZcSGGxBN4a6jnzw1TI/7up9PJSJWfkUSinJwnivMEFudNtIyHrIiRg6xxcEKUubJ/mSjPUIHs2ofUpabx20mV/+pBHl/2B8xKGgs7xyPwpta2MoY0yuGDG4LVT/sZzFCELlcyNT7/jrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843357; c=relaxed/simple;
	bh=fJ789znw+pfGIHXh87akZzviWRl3wPB+lGevWQgv08o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PdwWVJWgunWTpFMQkMOrYue3aqV9lAyWURi2sNgzB+ckJl61HDrNJ9wyTkG+Z7s6aCwAOAIyOXCPlg27UlJOh1swjSMyqulkysb+THYI9WGg5is/pJ3KsweyFClw0Q3mQ5dJOrIU58hi3yi0kVHNh0vtERz8grvVcqlrZQ2T6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj179ClF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea1c453f0eso962868a91.1;
        Thu, 28 Nov 2024 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732843355; x=1733448155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPc3Co4ldVHrMRzPOt+DOWF0B/8XpbePcgDN8Gbz8Ns=;
        b=kj179ClFvLghaIYCkZ5Upz9wbglfd6E1PjPWT52XRjStStbgb7Uq5bwiYICgvyhgI9
         hN2aSy4hFOsb2vuC4jZzI3HxAvVfRvPBtlj2pTqm/X7GdO7b0SZ48Zc2owfukzMypKvf
         QQXT0XrNFBZc5NHfIGfhx7LhELfJlHjgP2BXKuoHoNv12FjPo/I0K327qkd6UMoN80Up
         ijoKlCkhWwQSkp0ghH/VUbJxdFJ4BjsYKO5dIMBHmAJNleXa/C6NgncnXZITOWn42L5R
         mBrlQ+V0TbIUSezd9nhDY8SJH5R/fCYrKjftwpp0tLphV7XHnTQgWHlyCFSi9MxAxepz
         bOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732843355; x=1733448155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPc3Co4ldVHrMRzPOt+DOWF0B/8XpbePcgDN8Gbz8Ns=;
        b=VfU7k/MlzvXJFBo451RrvSEZJ/bpCfQ3IxRgYwfhXg3A63+RA9YtZsSCZ6dD+PeIxa
         cNFp0hc0fl88mHrjd5A0NxjBSoAqmOgcaSXgD4vEnUXbnSgfRFmAItPK6KahvhenRiID
         DsE3Wy9/BvZ6Kk4pp/Ju9gRUYID3fZIHiboGhlaDqixSvJaEMfUKQR0IsEGJ5yXl3IB5
         H2fL8YRNscZ1OHsEpw76t4STgbCyx4FvmRRXxnhjpZRhGWTcR1u6Gl7ZWvcQkUtBUBZJ
         Bd4ujSaHOl22F/nyleRK0fT86eyvuoEyVT2kAzNP9fafHc8c3xAAaBMPmblOc+BjTnol
         mIAg==
X-Gm-Message-State: AOJu0Yz373ROChEBuzNioxwyW9vTRkMuCDJD7HSo/IuJG6l4F0Hg/nVv
	erZfy8Z206aQLMMiLBmb+GPQEtCwvN5jyiDkNt+N/n2wRvidnSaPDaV42g==
X-Gm-Gg: ASbGncttlwHrw51zLXiH3WXG7c7ujn6abmGYhiZJTOmOyKTM81xErh3eSWxPlfuEHLS
	DIB5njzgT5ONI3RP0nzRpEC1IFsFOrTyGOB0eHcWTWuxc12z0us5PYNSwM9AAZL8fEcEPGzK5xb
	Sr56t4dsi6yC65gddKRC5QVEolKqnzYOiyEsJiBwS9sqjChVgVLaEJL78QEVa/moIZryQsi5aZ3
	I6CNx0dZGnrHI+K+0JEYT/0EsZ5QZwRIKaDcAnrxJ5Q1m9dAsnd1bwh55OeGsZwQFIu62Rj1hMC
	VlE=
X-Google-Smtp-Source: AGHT+IH++R4xCW/SfLd24apZitcHNtouIQ4ZNnCnpffi14NpDw+5gW2WPqfFp3D1vQJlGRJke9wnwQ==
X-Received: by 2002:a17:90b:4d0d:b0:2ea:853b:2761 with SMTP id 98e67ed59e1d1-2ee097e3d26mr12213057a91.37.1732843354698;
        Thu, 28 Nov 2024 17:22:34 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:7990:ba58:c520:e7e8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521905120sm20010215ad.80.2024.11.28.17.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 17:22:34 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [Patch bpf v2 1/4] bpf: Check negative offsets in __bpf_skb_min_len()
Date: Thu, 28 Nov 2024 17:22:18 -0800
Message-Id: <20241129012221.739069-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
References: <20241129012221.739069-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

skb_network_offset() and skb_transport_offset() can be negative when
they are called after we pull the transport header, for example, when
we use eBPF sockmap at the point of ->sk_data_ready().

__bpf_skb_min_len() uses an unsigned int to get these offsets, this
leads to a very large number which then causes bpf_skb_change_tail()
failed unexpectedly.

Fix this by using a signed int to get these offsets and ensure the
minimum is at least zero.

Fixes: 5293efe62df8 ("bpf: add bpf_skb_change_tail helper")
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/core/filter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6625b3f563a4..c1982fd04b25 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3734,13 +3734,22 @@ static const struct bpf_func_proto bpf_skb_adjust_room_proto = {
 
 static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 {
-	u32 min_len = skb_network_offset(skb);
+	int offset = skb_network_offset(skb);
+	u32 min_len = 0;
 
-	if (skb_transport_header_was_set(skb))
-		min_len = skb_transport_offset(skb);
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		min_len = skb_checksum_start_offset(skb) +
-			  skb->csum_offset + sizeof(__sum16);
+	if (offset > 0)
+		min_len = offset;
+	if (skb_transport_header_was_set(skb)) {
+		offset = skb_transport_offset(skb);
+		if (offset > 0)
+			min_len = offset;
+	}
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		offset = skb_checksum_start_offset(skb) +
+			 skb->csum_offset + sizeof(__sum16);
+		if (offset > 0)
+			min_len = offset;
+	}
 	return min_len;
 }
 
-- 
2.34.1


