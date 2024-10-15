Return-Path: <bpf+bounces-41955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9099DCDF
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B0B2202D
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD11714B0;
	Tue, 15 Oct 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjFQVLrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B64A3C;
	Tue, 15 Oct 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963407; cv=none; b=RP4qzmaenVulCZ0avJUO3V80w6h7whuKDXkYtgbHb1PtUvySYyZAToG4DQZ6Zpizyhe7kfTswD3j6QFUMhcugSoYlWD59BtcFxyfH0mZql7qT4LoOmuC0LXiPkbLkmUmzTdnzul1zRGmgJGPCxOQjbnNcj9PtXRhuWKLzmtXyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963407; c=relaxed/simple;
	bh=IG3XD04vq8XRCloN1zWCeLhVLSJJ1bc/lJNrVV1t19Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8+PqAOeDKwy1zxKswfnMKBIRqRq0YotfmuzqKT2Tk4QMvEmnI1cQCyydkzW/4YgKFOsiNJJXhjnOf/hrzKXKzmj8I7xlK5D88mNvQWbGtgo5gIUkHQ/p95sJ1Zq3rQ8nRsqmibrs2muthk2dZHD1Zke6RUHtMx1iZWgEUt1mtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjFQVLrl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so2007001b3a.1;
        Mon, 14 Oct 2024 20:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728963405; x=1729568205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3pmHU7vhPrYcyCzss6urx3Tnp2KXqxZWV5m+7oVlXQ=;
        b=QjFQVLrlmcG568MQN0PMg1dV6UQ7+i+gheath0Ig3xPjghmso/Ng0q8Mhu7817z+fs
         zNLrZFX1m/7Q0O52K+OyiH8I9t+utXXp17BOJMd8CTjYnsSQvaaZbTRFN3lOTLGl4KKN
         ZHSUm2jPHCrHVswwoUPlHmZDgVIDn06ADOF5WoG0CSckgSMA9BNuR8L1+a6eqvL3mhpq
         1RgKrNwPALPSBJ1Q25n4ko1nqwzXL7jLdZFBQoqM90KqOVezoco+mOpboE3o27hEyV77
         HUXqJ2pJV/msg6Ya2nW1DO3ea943TL3HOTAHn22yWShCHOR2jZyeNrTlr5GwAezsGwXN
         OpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728963405; x=1729568205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3pmHU7vhPrYcyCzss6urx3Tnp2KXqxZWV5m+7oVlXQ=;
        b=EaGkQ7ch++1ZI3e/cggSkcYb6YEBUFTDtr228WeEhuhXoleQk+MjjMKvW6+ROXSRZx
         noNANVYIFRsyVNbBPOUzh8iHH4C49UWX/gP8neEr4SgkYsgtEM0gDmU2CHsagqYtspVo
         YUdrNG7n7NHdwLLtXtUujH8OjY7RFG3drKFIhzr0t347FZYHZsDQTUQAmLOVplwCAfUY
         BHHwvhhh9kP3qjfEd8L6Urv9DH4fKITkrzvCd+RGIF8MyY59la6lvufvf6JpZPngTRKm
         HByWk2dnrOcT/yBBbIj2/mbNerVks073RLKmW2lSPQ6hlBf0h8ZeIAuZJDBZMM8938t9
         9Vog==
X-Forwarded-Encrypted: i=1; AJvYcCVgzD8EY6AbMd+KOjyMWoH87YeB6sVgGLG4QuMdWZOo0VkW5qao0eLL1dROpGjLxbtKQps=@vger.kernel.org, AJvYcCVl/WohduNlRhajB2gGIujAcpWOrSzzk92dRvmOF0VM0ooA13twCsRIpyoez9BmbZbEUJKI1cHoj0x1XvDt@vger.kernel.org
X-Gm-Message-State: AOJu0YycuIlMHG+WEF7FhYIpWIgQoE+3NqoFfvITlhRWdyurmmHy/YIr
	LIhQMW7PqePLimUx4APcGrRqUyyDo/2IqD7Y7naHVxPQSdowswx3q8SB71Eh30o=
X-Google-Smtp-Source: AGHT+IF3ESuhQZCT1Iiw9p1S5INzWYGNFho5Yws1UkPDaoRKDK6B+H3B/zsxXOVuDAydY/j9A8J4EQ==
X-Received: by 2002:a05:6a00:859a:b0:71e:66e6:ca17 with SMTP id d2e1a72fcca58-71e66e6d110mr8433621b3a.9.1728963404599;
        Mon, 14 Oct 2024 20:36:44 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e775259a1sm300054b3a.204.2024.10.14.20.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:36:44 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
Date: Tue, 15 Oct 2024 03:36:32 +0000
Message-ID: <20241015033632.12120-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
specified"), the mode is automatically set to XDP_MODE_DRV if the driver
implements the .ndo_bpf function. However, for drivers like bonding, which
only support native XDP for specific modes, this may result in an
"unsupported" response.

In such cases, let's fall back to SKB mode if the user did not explicitly
request DRV mode.

Fixes: c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags specified")
Reported-by: Liang Li <liali@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-62339
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/core/dev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..e32069d81cd7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9579,6 +9579,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 
 	/* don't call drivers if the effective program didn't change */
 	if (new_prog != cur_prog) {
+reinstall:
 		bpf_op = dev_xdp_bpf_op(dev, mode);
 		if (!bpf_op) {
 			NL_SET_ERR_MSG(extack, "Underlying driver does not support XDP in native mode");
@@ -9586,8 +9587,17 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		}
 
 		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
-		if (err)
+		if (err) {
+			/* The driver returns not supported even .ndo_bpf
+			 * implemented, fall back to SKB mode.
+			 */
+			if (err == -EOPNOTSUPP && mode == XDP_MODE_DRV &&
+			    !(flags & XDP_FLAGS_DRV_MODE)) {
+				mode = XDP_MODE_SKB;
+				goto reinstall;
+			}
 			return err;
+		}
 	}
 
 	if (link)
-- 
2.46.0


