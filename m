Return-Path: <bpf+bounces-65460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5FB23B93
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643901B64E88
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6222E2DD7;
	Tue, 12 Aug 2025 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K08rgSuq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D172E2679;
	Tue, 12 Aug 2025 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755036127; cv=none; b=EKh+dTqdXildR3Ap5CaQEC0aGz8wuPN4qswr/RVcP+t1n17gmSmtqjVY5t9c4Hor0pOULngdjpDH/HA3UvvLpFQ8vOWwr2/LHfDu5eSGlhhtRQzSGS1/n79WNsuHuvdFv9YLZHFEG4vXK4wNKJs6y5CgYIK0RuRxJH0RXcOSe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755036127; c=relaxed/simple;
	bh=8nMCVzoU/BearI+JQrhJPJzWNf0Lg3T4RMINzhVG8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoMWqQ09FZyXserd/PcsNISQOwBuQqgkjUm67CkvGa6Mw0GT5IeXFp3/BaZyTp2dr6Gu8OtUvIfV/SRUnDRts6XLhX6/7aq01YmgS/6aqHCIZ9jgCwhXHxCJYHa7AaVejy5jRo6lOpAIR3PC9hpyPaKyLLEzbBwhGwGLHf+xRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K08rgSuq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso37028095e9.0;
        Tue, 12 Aug 2025 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755036124; x=1755640924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYPaKl7yRBI57VFUozUf+op94ciBF1/TM6xrDSp5DaE=;
        b=K08rgSuqLXvbZHgFSfkA7ipQGdescc0zsKWa3rBpj70Na/SJm3MwQzw1KqLLw8s4Bk
         hF2bi56SSGWmRXF9/ecDAZdUH2V4ZLzSvvTzi7RBRiJCXCRNW9VH9Wbh7RoeTlQ4p6AB
         RPZBZZ3gVK0S0ZnjwVynLhnwWfcvBNt7Qnngw7Km6aKeyJEJLFdw1VJijg6+GQpCvu6K
         q2hfmKdVppPOBKYidGG0K69MKtJvII+r1uNPwA2VLkAh3QE77yLAvQG+oEUpO8UVPKKS
         yw7Fw7XoEvNIOaQTyD+Lo1bzA+EEVYhDpwsX1uHTc9IKZbVkUw4dzJvwMZ9x4Jwy8O/H
         YGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755036124; x=1755640924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYPaKl7yRBI57VFUozUf+op94ciBF1/TM6xrDSp5DaE=;
        b=tayeZXI68DzFm2StRIf2Vn/ivVyVm8p1q9NnGDgBsPzpsTq614a32DepLRyh5TYyjA
         WU39o6KGlCJ8ZhkZ6OhioS251XjG/sw+2wqwTdxYoGIZUjkHJlkwP3XNEe/SXOCvbRDj
         9M+n6h1JmHF24FrROJk4wE3mjz16wSK3Qx1zqct6GqLAuj77n+Zz3H3I1GJtkcjougHB
         6LrGztJjz7gs3/tTUO4x/XzgScF83LlmnQt5H2yOnAyi//BgUKTmq8WIPQQD/f+Jx6TT
         AFu+PScaznHMw6lt+I/6ChVSDUk1luOl0Y+eANaAfP0XKdauW+GBI3us/jKXt6mPI+/1
         hqRA==
X-Forwarded-Encrypted: i=1; AJvYcCUgnavZeoH3xly82SAV1GmOFcOP/dROjvTgjNa31Xj9LLvJcLNee4rIHUHSSfwbV0gYEuu0i2DOdPW0@vger.kernel.org, AJvYcCVdLtxvqyA+D0/LnzJ2oSaMe0xVmNCujZWdrRJn8XWfbDo+IiHiDkrOF3AzOku7q15rlqlxbOwhIUfkHsOd@vger.kernel.org, AJvYcCXbLhb/DFHVmq9+5wY058mULlootWmmvxv0cXDklyev/0GldmOk7DciPoQ8dqcEsduP3bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBF0ScIK4prZZ3WK/Izh0GtLejlyMNShWtb0jIHwzI1qEazt/y
	5/GLVhQulGxM23DbMwPVmKaVo+zHDqKYzubARXCDKqZmRJ4mF+PcVkY2m9Ccudj+
X-Gm-Gg: ASbGncvT6CWz9xdoPaMpbva32TbqtuJIje0y7o7MN99Idzv+JEe7jyuXBycup5HmX5e
	Fn88wg+6YiJS5OAoy8Rw7COb0v3mDg6b9VIv3z5dtHQcDcRa4+i+rhbR7RmI+qT1lRdA4Yh1Rqd
	7WaL0J7silqizQuEjn+9Rn/jIzSJE4Z88UWgJVO2wb99k/EMSCIDFzVmExS/O3NDXU6oFZh82sl
	Jw2Iqn75BKcFpaGEs3tbGUnwiZWjeybON5VhydTRw3pFgFFhRYk8icFMKhkHl7Gx+XFxRiHFEhS
	4d5FSBUrpiIFndTg8W7UfaLyJEN3vYvFe0ajW37ay6U44oT4uY9KW/fIwd+aqCDuhA3A2KYAYj6
	QXLhDLIP6JnBXOEKKVHcZ9x9AWblhn6xS6Xo=
X-Google-Smtp-Source: AGHT+IGA+lQaRjauHr/xIfL8afdVo3CJ1CCJYJQ7ehQBK6ony5LTadYXZaduZfT0BcLg0LjCR4h6Rg==
X-Received: by 2002:a05:6000:2204:b0:3b9:16a3:cfa9 with SMTP id ffacd0b85a97d-3b917e37acamr355311f8f.18.1755036123552;
        Tue, 12 Aug 2025 15:02:03 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530a8sm45390167f8f.38.2025.08.12.15.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 15:02:01 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: aleksander.lobakin@intel.com,
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
	john.fastabend@gmail.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V3 2/9] eth: fbnic: Update Headroom
Date: Tue, 12 Aug 2025 15:01:43 -0700
Message-ID: <20250812220150.161848-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812220150.161848-1-mohsin.bashr@gmail.com>
References: <20250812220150.161848-1-mohsin.bashr@gmail.com>
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
index 7d27712d5462..66c84375e299 100644
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


