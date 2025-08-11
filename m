Return-Path: <bpf+bounces-65388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C5B21726
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 23:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53967463CE7
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600382E3395;
	Mon, 11 Aug 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqvP65Cl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67434311C02;
	Mon, 11 Aug 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946847; cv=none; b=TfmfoCZxTw41ypgfGgj2S+RjjnGNiiR8abS6fBKU1hgYxbQR/fdVV2E8ZoqfgLB/p/2xc+UaHbwFXwBLUs7IDckeltyHLzKzWyVSwu2QcLW4HKBXYQXgGViHthXPW90YQ9U6yGB1WvLiSmh3i3evaVFfT+NpPKB3nrk4WHmqB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946847; c=relaxed/simple;
	bh=ATUPQkfmyzaYw4IE7/IhVB6QoMZYMK/aXVdH95S936Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlaiZ8vqGq4gP9rtkOu9faT1kJjXK7zBDs2ggiwpp9JG1yVyNkpSUEdIVpQAD8AjniGfvw+H/R4Hhn+5kbLbbnVWRCWWE1Pug8yqFvIxS/pcjx5y+5JD/brHv/Fj4WgjmE7WklpBbkZ3/Kyl1vJ6y33RasAhkIwpAZs1puAEvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqvP65Cl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so2676535f8f.1;
        Mon, 11 Aug 2025 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754946844; x=1755551644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So6x7WfH0VN3Df514nXpOI1L0fKOnrRpI/fu2ZjoXZQ=;
        b=eqvP65ClQpKmSQ0KzhE6kMtffJZJawMebif21nr/x3c8W2GjfKzVklvNOiz0v/3JLH
         pBNZ6jlbgmmKQIZNbcWol4pIHABKDwhQ5bcr/hTKBSanwk33TpE1ymf4ldXQbL8Cb2Y1
         EalX6J7bOV+SrchK4gg1lefs0Jn/CEps98EwyGocdcl8FMyPGvcZTNUZAU6lMJGY5DiX
         CUALBakcj5GsElEdNvvqfNsW4p942ZzycBgD3tCKABdA7PuyZH2NC5FFJDk/5sxinE6S
         D05+0nNoZsvDNHWJwCnZncnmVKT02lvnK9LyM+DqTq8DWDE/jdee1YUY4mAf0OdHSc/t
         ittA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754946844; x=1755551644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=So6x7WfH0VN3Df514nXpOI1L0fKOnrRpI/fu2ZjoXZQ=;
        b=oiC4+1GXgQma+yQjaBdtnK1WbmOBdI5W/DxmpgS7JTHiDCXJV09TwXQ4XiKahl5oTc
         Fue0ngfQiJj779gLAhm+WV3RppAFxY+WEgqoyu468k8Km1kkhHUc3ah9PZotthFi1eh7
         Xm2zwJvQw4dnqB56J9TReREirgp9kDQ16BCnw7wYPvpVzyzrUN400nd1O91u7prl8wW8
         fywUzrl6x6TNkPBp2vBFVI9g2CekKERl4px1bZvPrt7HJ8qsdNR1XAF8JXDiBoPAP6vc
         DWr35ZInyW0n/p5GC7MPuGziD2arxbzePW1EkJFqOWniiXfLN6attlWooa/SH7Uv6S9D
         53Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXBphObN5jDJz3LtzDKj5bvFwqxRdmgxT8hKU5o+FXlNgI4vDZtsHK0tYetwyJYCepjheU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6fzDaebgQs48zuCzFeJrdMs8x/aMhRF+6gDf8RKuKLfLoNND
	Yam4JPuqUUb7ZFdhWI5mW7vjpNzpu82Kpg/LC4dEc+NwH5eNHSpJOR9bHF0aLZz+
X-Gm-Gg: ASbGnctnBmu4GOWjAs2KmWf1lIj8ViZo/EQVGDBPXFJ9Kih5i/hb0RKlKVXf2BMIryT
	Hge9vsLnFkPninM61I2w26EraTQ4W+Zd86sNttsiZr49HiHWnRAMyhlwcWdqSe36Q/v9XkNAMm2
	qeNwcZUeCRDJHsEBkkmK9BqUVztfavYuAefUgxIHpWkEhBjnxUK+mIhdw8btMGg/eoTQqO5AyCt
	hKxx5AVLOcYIOY8teJTe5bR39+TzhbZKIlGdPgny6WeZIJb3fKOfUdNjOEhIfqxfXwmvTxKPe8S
	Pc+rp0wBkPERbnt+ES19XboXyYLStcXT91iDFVXhOnpPyi/9CSjJLPevUbjZC49yb//W5nNE3zD
	O1JVGc7cIY+Ht8zBTs9knIwkrm48rKQc=
X-Google-Smtp-Source: AGHT+IE1SD3p0MF6/Ofq94DLCXDmvfiU+2jHbuNZBOVigCzF6FDrtATc9xbM8oGf8lbAXntVGGHE3g==
X-Received: by 2002:a05:6000:178d:b0:3b7:8a49:eee9 with SMTP id ffacd0b85a97d-3b910fdb265mr804944f8f.8.1754946844326;
        Mon, 11 Aug 2025 14:14:04 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e054036bsm32180277f8f.31.2025.08.11.14.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:14:02 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@google.com,
	hawk@kernel.org,
	horms@kernel.org,
	jdamato@fastly.com,
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev,
	aleksander.lobakin@intel.com
Subject: [PATCH net-next V2 2/9] eth: fbnic: Update Headroom
Date: Mon, 11 Aug 2025 14:13:31 -0700
Message-ID: <20250811211338.857992-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250811211338.857992-1-mohsin.bashr@gmail.com>
References: <20250811211338.857992-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fbnic currently reserves a minimum of 64B headroom, but this is
insufficient for inserting additional headers (e.g., IPV6) via XDP, as
only 24 bytes are available for adjustment. To address this limitation,
increase the headroom to a larger value while ensuring better page use.
Although the resulting headroom (192B) is smaller than the recommended
value (256B), forcing the headroom to 256B would require aligning to
256B (as opposed to the current 128B), which can push the max headroom
to 511B.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 626c8a137720..2154a9aac3a7 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -50,8 +50,9 @@ struct fbnic_net;
 
 #define FBNIC_RX_TROOM \
 	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define FBNIC_RX_HROOM_PAD		128
 #define FBNIC_RX_HROOM \
-	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
+	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
-- 
2.47.3


