Return-Path: <bpf+bounces-35191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8649384FC
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5751F21296
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88116087B;
	Sun, 21 Jul 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk9c6Dkt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B4150980;
	Sun, 21 Jul 2024 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721572467; cv=none; b=uuvDSqt8skUAmLsU0s+cgoPEwQbOjz4Kxt82AzKZyoZ13fQebbXGTWn/Tocjc4R6cLZ//SyisoV9I35FuhLJQzGFIa413pexkqPU+rnt5h78NEHLEoF0VErXiQ177YWaEsgC4+ngjwsZYrru1aFHvP420paHx4ZwxNhCYb6ew70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721572467; c=relaxed/simple;
	bh=3Wqd8DnWTw3/yvGmd99tidm+18F0caRu421PpqBqslc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mk4scZh1r6I9lRplNuGjoRF1nhn0xcNXG0Y4/Aulwm6E8oVwsRcj5gXJRncL9dSeYq3NjaMbk+fHMdVMCb5xgnIEGPt2XgNexmQ6RI7tWBGuyj1uYaAgga9ehfdiJ+ZdQU7ejjmV6kkk3Ljv9y7qrSJFi6mKCE1rtpyR4GCOazA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk9c6Dkt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3992f09efa7so5766765ab.2;
        Sun, 21 Jul 2024 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721572465; x=1722177265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGAJWfp7/xOOMmZFct4BfOvzv2JnXADRkl1E3DONea0=;
        b=Vk9c6DktrXPmZcD5RbUPZIT8ZxHSBMEpT93llBxcWZolNDGsTQGSGbIyQvreqc304Q
         yUbQAW7msq3iNfpR0q5te4QwtCE9EK/acJhjhsDhEt9C5gFxxFZ47Zd4K4gCedBXT8+Z
         3dx6Hh/JuXcau9MFiHg48LUbypvT1Wsvx+c9IWzHCEyk3/D+WdkdWAQLX3H1ex2ICRfv
         YzSGfqvGHLwyBrQgYjW+9iGiHBo2Pq+PZpnhmvW0ystQwmv7Sv9B+cSorTGNMD0j1uM6
         LUzalj9fOM0JFZc/ZfCmEY1z/qqoftDQeJ4CEVfZlu9If26GypFSRdW7UvsqYbueeJ0D
         ks/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721572465; x=1722177265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGAJWfp7/xOOMmZFct4BfOvzv2JnXADRkl1E3DONea0=;
        b=rrF7WYjFJNdpJjL5hTSBrTJFPpJxP5BXx/OoPtdStDEZBWGNKtUbAEGtb9m0v3Faac
         /BET54qjMcwl0zEIL/bL1cQmMPd2bQXLAN8KxqZPMdem1/u7MhxOkEtj7lqyOiWXVEmq
         iXBffAxbB6bRkxrhCc2fUiKJVEa7lEpXroN/FTSXxMst4tjvZHV9BtV0RGpqujA0QPSC
         idaAuBuIKfyf6WcOr8g0/iM1CT2eAgORHAlmVE0mIhDIL1at6wfcIDu1GgifzPpmyjPa
         U5SgsWNUK5Rl91zkWmkE6sNi4/6Eza9MOUg4WOXTpk/sVWSHu2TC78CPg6TF+OdRruHG
         GvJg==
X-Forwarded-Encrypted: i=1; AJvYcCXysF4r1qC2wOmcrXTw/n14CpI09sF4tjymGv6tq1JEujdlCKrC2VptW4XSmzJYgMkyEcEz0AoPcsH6fJsukCqUWJ6FZyIyhFOqsPOFfO9czZtKea7GkeXqAP/nN5Yttwsl
X-Gm-Message-State: AOJu0Yy7pxVcyFHUEGlJSTYue3Ax29Swiie8nGgmDNj9DEmXtci1Dcnx
	AGf4NbT187POEXJWmvGec6hnKHzB8hWsvn/IYHTEKMp3v8o3ZMPG
X-Google-Smtp-Source: AGHT+IEjb9XMEGtagKQYnR1JriMds7jZC/GeK1ui0ZrwDy49zby0nhfycjAQXkekoPIVVPxJDr9Evg==
X-Received: by 2002:a92:c262:0:b0:398:3b82:4ac8 with SMTP id e9e14a558f8ab-399403e65a9mr53491205ab.24.1721572464569;
        Sun, 21 Jul 2024 07:34:24 -0700 (PDT)
Received: from localhost ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0f5448desm3209048a12.81.2024.07.21.07.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 07:34:24 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH bpf-next 1/4] bpftool: refactor xdp attach/detach type judgment
Date: Sun, 21 Jul 2024 22:33:50 +0800
Message-Id: <20240721143353.95980-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721143353.95980-1-chen.dylane@gmail.com>
References: <20240721143353.95980-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit no logical changed, just increases code readability and
facilitates TCX prog expansion, which will be implemented in the next
patch.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/net.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..1b9f4225b394 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -684,10 +684,18 @@ static int do_attach(int argc, char **argv)
 		}
 	}
 
+	switch (attach_type) {
 	/* attach xdp prog */
-	if (is_prefix("xdp", attach_type_strings[attach_type]))
-		err = do_attach_detach_xdp(progfd, attach_type, ifindex,
-					   overwrite);
+	case NET_ATTACH_TYPE_XDP:
+	case NET_ATTACH_TYPE_XDP_GENERIC:
+	case NET_ATTACH_TYPE_XDP_DRIVER:
+	case NET_ATTACH_TYPE_XDP_OFFLOAD:
+		err = do_attach_detach_xdp(progfd, attach_type, ifindex, overwrite);
+		break;
+	default:
+		break;
+	}
+
 	if (err) {
 		p_err("interface %s attach failed: %s",
 		      attach_type_strings[attach_type], strerror(-err));
@@ -721,10 +729,18 @@ static int do_detach(int argc, char **argv)
 	if (ifindex < 1)
 		return -EINVAL;
 
+	switch (attach_type) {
 	/* detach xdp prog */
-	progfd = -1;
-	if (is_prefix("xdp", attach_type_strings[attach_type]))
+	case NET_ATTACH_TYPE_XDP:
+	case NET_ATTACH_TYPE_XDP_GENERIC:
+	case NET_ATTACH_TYPE_XDP_DRIVER:
+	case NET_ATTACH_TYPE_XDP_OFFLOAD:
+		progfd = -1;
 		err = do_attach_detach_xdp(progfd, attach_type, ifindex, NULL);
+		break;
+	default:
+		break;
+	}
 
 	if (err < 0) {
 		p_err("interface %s detach failed: %s",
-- 
2.34.1


