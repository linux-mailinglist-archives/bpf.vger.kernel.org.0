Return-Path: <bpf+bounces-62821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CAEAFEFF6
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31AC3BD5B2
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A823370A;
	Wed,  9 Jul 2025 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfQIIIGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFEF230D2B;
	Wed,  9 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082667; cv=none; b=izcwa3tTXCugb6qaK2RhdMzs1De9xorP5TsOHz48e9cuH11h2+VQ239hvkOFFqQWyItAf5WNjX4b0LTQcr5x+UPTMM8f5HdI6AXhwxJM4183QBgLAKyyEvPfALwLU5eZheNrfGh4B5M6GvqCpYM7nD8o9lPxnM0/kG6W/2Xlht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082667; c=relaxed/simple;
	bh=1gZpUDwTSy0yw4iTCi2xeacRJBhw0u5mnJO2WFSvX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/BhE7axO3Khytl+O36bpom9PML8GdHTpnELEFC4wuWc0lqa9qp1aWIoz9s2boH5NNzptOkfqJVgnzdDD2LzKBbtHr7NFeaGZXeEVEUgeE755zDmn51+liiaS8IfZ2mKMSC020FJatuP2fjl8BtbKTSZG/Tk0yLjUXCToKh0+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfQIIIGv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a463so141410f8f.1;
        Wed, 09 Jul 2025 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082663; x=1752687463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI/CdLAUZ4D6ZFVUjUJXlmHQhesmh8grM2Oun3Io+fA=;
        b=RfQIIIGvnv8n74aXqnhqzMnBMVlycDjF53MC8RX/JRfUEpFRPYplGUuiFCWj3X6lvI
         HxwLgNOTYs5UBxlkiuCnRGc+uATBu6XXeuSNEeVb9om6xHkcBEVKQ5PePnMXNaUmrNYy
         BYbvCEFhcK/56LaUsl23Z/NBbwZHTluG7NhhwDDJeGP4bwOIM5Cj8O1B0tj1Zm/OLAoA
         1yWCfP3muieJOMbsljL4wfQT2Kha6rHcJfUNw1JWrKbpBAN32dU7AG64CvZujLeVKo4+
         qmaNTV9CTnyGLORjmtqHjhrTE3Wr9DVSJ7RJ24/IPRxv+WpCdvW778wuVl02Px4LrXY/
         Q2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082663; x=1752687463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI/CdLAUZ4D6ZFVUjUJXlmHQhesmh8grM2Oun3Io+fA=;
        b=GfRA7kUHlfajoUTWn1XJUCOP7itP1SKX5U2FJsQNPKyWjLFZAi7RS4OCHxC8LVrYTl
         u4qgEKdwnQH8GLiyIzzcZ3wlld/jSaLvc8cGiyoGPiJMb4XLFfz6HqA1UjDFzq1YAQVd
         osvlElV7dkPq8T90ZHUZ2GkDWIHl4cKpvXh60pSUMinyAghgHjC4/YwIyS71/sQtHkKF
         v2IOIPL6BS9PMx4FiQ0Ho6YE/dPOXzabEM+R7QkgVXzDb2ehiwWESezi6Dok14VqYdVV
         +wOBuSLt2Q9FE0rwWPp1XdUzYe5qWnxutW+Urbyl4+prV7lDIfwPNlSRmJBkvPOgpOwv
         NP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNIyAh/KLE/hz8EgcQywV22lHFTAnhPQpO8SXCsnZNtC8Fav7ft3fGi5MQUZ9vk5UK1lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JQL7Zy7PcqeE9sz3+6FRpivRZsVzb9rGh9f9hS/P0Q2WVrlX
	8ezri0c36gs6lIYh2JKkA1Hpevyb9kOd1T0x7oaA/EjT/riF+DGepYZGljYjm5hG
X-Gm-Gg: ASbGnctW6CyxazKSe1/DxTc5RlCVOxM4mN6sSFDdfN+3ukNJA4zhQE4+rda0h13HzcL
	/yxy+mZ9o/dlrFXJnbIZVMfrwOCeUP92VEKNVgGQyi17yLcBbauw0vVbuDTqvjipDlH/cqABIFV
	z/T+Mx4O1fmajBFXlarsRgcF3erHyLS8KbBCbR5Wc2+hRAg4q/Fs/jjGptQlxiKgTdnMl9CJJNt
	OwVy8gT3Qr1xPli2aondYIcunFrb5W3cHU1gPEiV8BeEBlZVtEaUnirdSyIX6z2D73n5SOadF5y
	SKYcykZZHwN/gVe8+GV1wA0wsb4Yo2sc3/r/D1HCs6PQP/OnT1CfebRbQopUaTJq4d+41WQ=
X-Google-Smtp-Source: AGHT+IGXivKPunvVPP0NY5AnDHUp6I7CVI7/dJrDRrwTcdRhVE11H5KISYJYodiISWWUNRO6Kb+CIg==
X-Received: by 2002:a05:6000:1acf:b0:3a5:1388:9a55 with SMTP id ffacd0b85a97d-3b5e7f0a33emr335461f8f.5.1752082662533;
        Wed, 09 Jul 2025 10:37:42 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d4fc333dsm32927665e9.0.2025.07.09.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:37:41 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/5] selftests: drv-net: Add bpftool util
Date: Wed,  9 Jul 2025 10:37:03 -0700
Message-ID: <20250709173707.3177206-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
References: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf utility to simplify the use of bpftool for XDP tests included in
this series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 2 +-
 tools/testing/selftests/net/lib/py/utils.py            | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index fce5d9218f1d..39968bc3df43 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -15,7 +15,7 @@ try:
         NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen
+        rand_port, tool, wait_port_listen, bpftool
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 34470d65d871..acf0e2c38614 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -175,6 +175,10 @@ def tool(name, args, json=None, ns=None, host=None):
     return cmd_obj
 
 
+def bpftool(args, json=None, ns=None, host=None):
+    return tool('bpftool', args, json=json, ns=ns, host=host)
+
+
 def ip(args, json=None, ns=None, host=None):
     if ns:
         args = f'-netns {ns} ' + args
-- 
2.47.1


