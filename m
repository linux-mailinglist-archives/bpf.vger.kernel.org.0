Return-Path: <bpf+bounces-61794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A499AEC6FE
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 14:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7831795D0
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141B246BC6;
	Sat, 28 Jun 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrL5bevD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB8202C5C;
	Sat, 28 Jun 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751112532; cv=none; b=mr9IMNIsg9GfnkQEG9SN5tFhrc1+L02LE1uggHuP4yEQgqESZOEuqDyhs3/AHx5fHad1ejEx5EATZP9yffd3I0hukUcxvixyFAuglvdVBJJjh+C17OMqWfC46T87zdSqyn8qoumYGgnzSo1QM4q/S7HGxPFpgbkKSYGBihzJ3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751112532; c=relaxed/simple;
	bh=k5Z2iAF0sC5WyQfdCk6aNaQdrz5OGx3w2Dkwqgga4Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CFTlP7MO2Cdx/KHPlIGU2DWp7osVeP1IpUEthEMQHSJAL14/xucEKc4XkDBW7kbhgLjPmedzFZdy79Ep0VF1rmnK9GlfheGJw5mKbUXEczLnMmes3YIzgNS6JZQBuIDcOTx0RbaaxaYk+CXCAjIFPgvWD8wLlTDZrVJSH4gKZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrL5bevD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748e63d4b05so538928b3a.2;
        Sat, 28 Jun 2025 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751112530; x=1751717330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7l+smYN0wCaYY53WV5qBskMdy8ZTkaaTLHuHbQPjliI=;
        b=hrL5bevDFb2pd2bKp4GlL2F59YoXLiPPs285ayUiViBfquu/H97fPdEjmSLrbIm5DJ
         e6+3hqdasCG7RMLY5y4O56VxS7wq4RZC37nMo7v+4ka5ZZk2vkjI9gE1DbvO3m5/l0Yi
         NYW13/iodlJRJjMuFwRARPJJKgsN8MW2ZH8B1/GsLSd7vVYAJGiKg8YJaRe07zecFUnU
         L/F1/RBx+dNKHdWbKLpXtVo1lhEuRxW4PArSj9yKxAUzE5rCAkxELgF9nD2gta/2Jj7j
         14MMSQBZXV14Jz37XYHmNfKCyxOw/xY5MdqiybYQsY0+thwRasZDmDRg3kuHdUMSUuWU
         NK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751112530; x=1751717330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7l+smYN0wCaYY53WV5qBskMdy8ZTkaaTLHuHbQPjliI=;
        b=YrV2ZkvhgMw2642Q13h1nyhDbyuDqO8ie41kGtfPCdLUMG/OxPrNvje/p2G+kLVxiJ
         uUCHP48z1u2mqng70ejSPCogIXOHtuYncgr4keBI3GX3hHoqQGQHKHbqw8sxAcEifank
         wilmCwuTi5F0t2tGol7luaiDJi9GlAQfl8ejf+nZw4czdNA3X2ULETsJcja8Kn9CRtn0
         Xav0CQ+PaQDcK4+iFUcrBAe1zoO2fkWgheI0aeUT3WNsfjuXdowphJ+7ZVP3NS3zBFjL
         hlCiOgwckkERsgpQaDpwJspxH4ty8HTTqOczN/zNXsfX1p1vuafgRbZubmhfuXx2Q7dL
         /4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWbtWQOBuEQhUyC8sRJnnuLmifVx4Y9jPMDV2Ulm5LPSjhNIL4iLHHkHz+0UlB0+8cPbqsSzZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqROgz6RqyzbEOmnGFonOl7NT5taDGRGKpzwVMDctxjOu4R0A
	zyHGyoyZYGcfgA8scvqbPNSmGl5eost9iRF9MYg3cBwIgL/9aq9dr9eT
X-Gm-Gg: ASbGncvzSDATLDO7BKbTVsBQjybYhn00W0SwL45cIOEXkMBai2OFaY47jyuWkndawO1
	AuRQZW3Sd1c+Z1HDzGEJv2ESXG6d0VNCy0cYcy1eyFJVuBpigYpAbWjGGrwxOXA+P3nktTW1GuC
	3xTFYJvTRDRGB8igpuigoxj5i0Cr371cFz1d5RRHgOc/hUDmmq6FtIPU8NEVgue1P+BTz7MOR+l
	63Es7gy2souV09dN/NnS1MGsGQnIh2rOP72bs8iTCHVzqBI13hzRwo3HoB/b7cv9jm90Xnmsh2W
	HBDmi3remWva3/9lPl7OdCWYJABpzUkuPM9jc4y0YaihumvOlwArMrYy1jxxKPTPbhS0ZUPKFpj
	ToGYdMB3th5SW9AOO9ZCVeIW3ZaC943C1Sw==
X-Google-Smtp-Source: AGHT+IGveKN4Qwhzh1e1reoGMGpL0/q6b9x3He7IJgMsNQFDOhLrPMFQSDeiwOOJOzaZ5TIwax5iAg==
X-Received: by 2002:a05:6a00:2394:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-74af6e8926amr8656688b3a.1.1751112529571;
        Sat, 28 Jun 2025 05:08:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57df00asm4435089b3a.148.2025.06.28.05.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 05:08:49 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] Documentation: xsk: correct the obsolete references and examples
Date: Sat, 28 Jun 2025 20:08:40 +0800
Message-Id: <20250628120841.12421-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The modified lines are mainly related to the following commits[1][2]
which remove those tests and examples. Since samples/bpf has been
deprecated, we can refer to more examples that are easily searched
in the various xdp-projects.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f36600634
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=cfb5a2dbf14

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 Documentation/networking/af_xdp.rst | 45 ++++++++---------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..37711619e89e 100644
--- a/Documentation/networking/af_xdp.rst
+++ b/Documentation/networking/af_xdp.rst
@@ -209,13 +209,10 @@ Libbpf
 
 Libbpf is a helper library for eBPF and XDP that makes using these
 technologies a lot simpler. It also contains specific helper functions
-in tools/lib/bpf/xsk.h for facilitating the use of AF_XDP. It
-contains two types of functions: those that can be used to make the
-setup of AF_XDP socket easier and ones that can be used in the data
-plane to access the rings safely and quickly. To see an example on how
-to use this API, please take a look at the sample application in
-samples/bpf/xdpsock_usr.c which uses libbpf for both setup and data
-plane operations.
+in ./tools/testing/selftests/bpf/xsk.h for facilitating the use of
+AF_XDP. It contains two types of functions: those that can be used to
+make the setup of AF_XDP socket easier and ones that can be used in the
+data plane to access the rings safely and quickly.
 
 We recommend that you use this library unless you have become a power
 user. It will make your program a lot simpler.
@@ -372,8 +369,7 @@ needs to explicitly notify the kernel to send any packets put on the
 TX ring. This can be accomplished either by a poll() call, as in the
 RX path, or by calling sendto().
 
-An example of how to use this flag can be found in
-samples/bpf/xdpsock_user.c. An example with the use of libbpf helpers
+An example with the use of libbpf helpers
 would look like this for the TX path:
 
 .. code-block:: c
@@ -551,10 +547,9 @@ Usage
 
 In order to use AF_XDP sockets two parts are needed. The
 user-space application and the XDP program. For a complete setup and
-usage example, please refer to the sample application. The user-space
-side is xdpsock_user.c and the XDP side is part of libbpf.
+usage example, please refer to the xdp-project.
 
-The XDP code sample included in tools/lib/bpf/xsk.c is the following:
+The XDP code sample is the following:
 
 .. code-block:: c
 
@@ -753,27 +748,11 @@ to facilitate extending a zero-copy driver with multi-buffer support.
 Sample application
 ==================
 
-There is a xdpsock benchmarking/test application included that
-demonstrates how to use AF_XDP sockets with private UMEMs. Say that
-you would like your UDP traffic from port 4242 to end up in queue 16,
-that we will enable AF_XDP on. Here, we use ethtool for this::
-
-      ethtool -N p3p2 rx-flow-hash udp4 fn
-      ethtool -N p3p2 flow-type udp4 src-port 4242 dst-port 4242 \
-          action 16
-
-Running the rxdrop benchmark in XDP_DRV mode can then be done
-using::
-
-      samples/bpf/xdpsock -i p3p2 -q 16 -r -N
-
-For XDP_SKB mode, use the switch "-S" instead of "-N" and all options
-can be displayed with "-h", as usual.
-
-This sample application uses libbpf to make the setup and usage of
-AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
-really used to make something more advanced, take a look at the libbpf
-code in tools/lib/bpf/xsk.[ch].
+Xdpsock benchmarking/test application can be found through googling
+the various xdp-project repositories connected to libxdp. If you want
+to know how the raw uapi of AF_XDP is really used to make something
+more advanced, take a look at the libbpf code in
+tools/testing/selftests/bpf/xsk.[ch].
 
 FAQ
 =======
-- 
2.41.3


