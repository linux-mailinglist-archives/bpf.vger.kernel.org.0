Return-Path: <bpf+bounces-62640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D85DAFC2BA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 08:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425471AA6624
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 06:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5D220F36;
	Tue,  8 Jul 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvCbcXBG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392921FF36;
	Tue,  8 Jul 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956161; cv=none; b=aBfBwNDQNl/C1Ets2WPwido1vfhNy6oaG6FgDlQY7HKMdxckAns2Vsx1yEmWfUGY/6i0VHVlOmlusJ6cKbDBHMCn8XXHVsxgPQhSh8RsTQg4XWON5Emwqa4qflXpAabcAbD9LZfXQ4IqzuXKHRH5TJxf05HCIuYkhiq+GH65/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956161; c=relaxed/simple;
	bh=VQO1BWDKKkzWZeBi8r4Cz/5ygzDdUPmz1dq3H2y1CyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VXh5/tGSWC9/bW4JPsf4G2uXsx7DlDRbFZDKZh0fGAdfxoG6DYtv8LcnxBQDzE+33iDdDdpsnKyZ6xS7N9a1MBAd2hQHgLlcMSkUv/MFsTlcOsHipe7ExU8YKBe30Wd9fKv7TRUtqHXS0+WvseYIl4dnnPDl4uQcKgZzS1FbqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvCbcXBG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390136ed88so1702028a12.2;
        Mon, 07 Jul 2025 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956159; x=1752560959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ6pKoaOwInj8BVGchJJ9OPUe1p8Pr6plu975PQ9X7c=;
        b=WvCbcXBGeT+0JGML4Lv1/qUzQEXeREcD0GO47gb8C3I8b6MkpAS7XHiMGKpawq3W1x
         ufqfLUOIXeJFxU9XL8piKSP4IzJ6MQOUz2bXbkHz5vpVWUwIWECKJm0kMijkJy9Rh9/v
         1eSWuzgIXzPPpTBMSXWl62aPmHtDzOCDlalGu6c5n/29F6YXv53ZGLyjvooufZvaNpla
         LM6UqOKuTlQps8ZDvtcKFKoUFImKJD1+tEPAptNWab6X1PiiFIEW9Q/vFoDGWBDwPvRY
         GBBKVG2P14UIrQvXQHkzD/C5iOHxLeTfeJVp/aH9Pj2edtR9i7YqaJZ8NZu0wu4SlPfa
         yqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956159; x=1752560959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ6pKoaOwInj8BVGchJJ9OPUe1p8Pr6plu975PQ9X7c=;
        b=vrn45eMmyBmGVMECXDM8s4lQefXViUsPevqd7Bknhse51CLeP5qqFJRouW2qzh+yr7
         GMQyKyAClczPZWjElo1gPv+IwBjiWAuDzFbaS9fPACbk78RY1sZFt2ACOZi8sN8LJiFr
         v35ChIatNZw8yfY0ugx09EGeHoJ/KzLgD1lxSerIBtbUHxJQ0aEB7DqbvftNXuz5wYQN
         8HGlU1vJCYvNhp6GSvgJaJRcD55InKSQl2tPllckVd92mUM4ijgjcGKGT2wOx6f7q78f
         9buK9rSMJC062cnyl6MCD0TZFx3kkPnBUJ0gbIGzQcmCuq9qi/+gvHMJ91ufIKTfdR7z
         4bJw==
X-Forwarded-Encrypted: i=1; AJvYcCXtRPreAS0T2eit0KCz5fVK6+xY5L9cnpvMO5MOqf5w/oOsrq6x7zVr9hUn4LY8lC71DjNMGVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfR/mR4n7rEdLPCWTYqsftlLAkFc/M/iO3Qbt6gkEjVJPkGgol
	tO0ZlkumW9eNxaRjp0PM0cTDQT89I9DwTuLibSRKEmnqyVkKD1Bf5fOW
X-Gm-Gg: ASbGnctwSR1Ts4pA9AsFPt7xhi3Y88s2m3PZgwPzgfq66NJGx9amCAgFuQjRfN1Pyxn
	+pldUX7IGu62et4LJVeKW0SSl9HqSgNRM8HFkgmyz4SuwI+l8+xikSY6Zui1NszPcWGR7I2FARj
	E+anD7DBxlzE8xi2GR9egQ1QBJpk914m7CUcUHn6GIlft2OR09k9Jun/ptF8X5huGRsQVmCKGNe
	7nRIZnoRnfb93C6u2NEzRVQh0UmVnP4WL9ba4ZLsXa4wjZtHABoltwRzAWjLQTtrHrm2jLc6S0u
	+60MQ+U0UwYH8DNnUzynLjlw6zC3iJUZYS35OlY1XL5PDZSqp5cF0nu9d/+AlOWaCyZ3/XuC2PP
	zRJO7uRSt4n9YI0KFnnAlsRWRVAXFjUNO8Q==
X-Google-Smtp-Source: AGHT+IH/IvLaY8p6hg0qcXy1f9VWgQtP35cGCQrRgcphdNvql73hjCDoYRiPLJX3com39oh5QR3INA==
X-Received: by 2002:a05:6a21:3285:b0:220:af86:7e01 with SMTP id adf61e73a8af0-22b1daba202mr4211226637.29.1751956159130;
        Mon, 07 Jul 2025 23:29:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ba014sm10548452b3a.19.2025.07.07.23.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:29:18 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v3] Documentation: xsk: correct the obsolete references and examples
Date: Tue,  8 Jul 2025 14:29:07 +0800
Message-Id: <20250708062907.11557-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The modified lines are mainly related to the following commits[1][2]
which remove those tests and examples. Since samples/bpf has been
deprecated, we can refer to more examples that are easily searched
in the various xdp-projects, like the following link:
https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

[1]
commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
[2]
commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v3
1. remove './' from './tools/' in the doc.
2. add a few reviewed-by.

V2
Link: https://lore.kernel.org/all/20250628120841.12421-1-kerneljasonxing@gmail.com/
1. restore one part of doc and keep modifying a bit.
---
 Documentation/networking/af_xdp.rst | 39 +++++++++++++----------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..d486014bb31d 100644
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
+in tools/testing/selftests/bpf/xsk.h for facilitating the use of
+AF_XDP. It contains two types of functions: those that can be used to
+make the setup of AF_XDP socket easier and ones that can be used in the
+data plane to access the rings safely and quickly.
 
 We recommend that you use this library unless you have become a power
 user. It will make your program a lot simpler.
@@ -372,9 +369,8 @@ needs to explicitly notify the kernel to send any packets put on the
 TX ring. This can be accomplished either by a poll() call, as in the
 RX path, or by calling sendto().
 
-An example of how to use this flag can be found in
-samples/bpf/xdpsock_user.c. An example with the use of libbpf helpers
-would look like this for the TX path:
+An example with the use of libbpf helpers would look like this for the
+TX path:
 
 .. code-block:: c
 
@@ -549,12 +545,12 @@ later in this document.
 Usage
 -----
 
-In order to use AF_XDP sockets two parts are needed. The
-user-space application and the XDP program. For a complete setup and
-usage example, please refer to the sample application. The user-space
-side is xdpsock_user.c and the XDP side is part of libbpf.
+In order to use AF_XDP sockets two parts are needed. The user-space
+application and the XDP program. For a complete setup and usage example,
+please refer to the xdp-project at
+https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example.
 
-The XDP code sample included in tools/lib/bpf/xsk.c is the following:
+The XDP code sample is the following:
 
 .. code-block:: c
 
@@ -752,11 +748,12 @@ to facilitate extending a zero-copy driver with multi-buffer support.
 
 Sample application
 ==================
-
-There is a xdpsock benchmarking/test application included that
-demonstrates how to use AF_XDP sockets with private UMEMs. Say that
-you would like your UDP traffic from port 4242 to end up in queue 16,
-that we will enable AF_XDP on. Here, we use ethtool for this::
+There is a xdpsock benchmarking/test application that can be found at
+https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
+that demonstrates how to use AF_XDP sockets with private
+UMEMs. Say that you would like your UDP traffic from port 4242 to end
+up in queue 16, that we will enable AF_XDP on. Here, we use ethtool
+for this::
 
       ethtool -N p3p2 rx-flow-hash udp4 fn
       ethtool -N p3p2 flow-type udp4 src-port 4242 dst-port 4242 \
@@ -773,7 +770,7 @@ can be displayed with "-h", as usual.
 This sample application uses libbpf to make the setup and usage of
 AF_XDP simpler. If you want to know how the raw uapi of AF_XDP is
 really used to make something more advanced, take a look at the libbpf
-code in tools/lib/bpf/xsk.[ch].
+code in tools/testing/selftests/bpf/xsk.[ch].
 
 FAQ
 =======
-- 
2.41.3


