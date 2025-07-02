Return-Path: <bpf+bounces-62079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C50AF0D57
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143F61C2382A
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266D231A23;
	Wed,  2 Jul 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL9LGCpl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F514C62;
	Wed,  2 Jul 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443101; cv=none; b=GyG25JM2kGApfnE0io5x3Peq4gQB9Ns9uPIDgw7FjvHnriQ7py3LcvC0YO4vQVzkd5thY1sH3pkLxuSRgSIIaXaZEaUqjT0XAm9Aah3YBuRcR+acqbKrOuvV8O67j5Td12j9VEbWCIcwTSu5z2RIr8kRXoN+Haei3Bxl8xy1Tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443101; c=relaxed/simple;
	bh=1LJqahTJT53+fLu9xji5BGVOylitLicsEW0XIPFnVOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GIyzDW+uAKlY0fxeqLlY6C4Hg7zkaHFp0nwKGVjf1RCf6RC7NzpK4YldbdOezmtsioSha9vMya259iEmuJjhNxlEQ7qYjFp4QTd2lG9IFKswXA3/hcMW/tiGTBGIVPXjyL+Mnm/4HcdvBBlbHwrowcKZVrXI0K/NlhO0CAPLnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL9LGCpl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ea292956so38538705ad.1;
        Wed, 02 Jul 2025 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751443099; x=1752047899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMrPa+nCyVOrTi/KimE81WsU7dXcbbOJzv0t/rpE1q0=;
        b=bL9LGCplNPgeSBEPAUnvEzXdCW6jaKUQKKaI5KePUzNf7Hseaopu+P5Q47N7FagGwb
         AVQ/yqmFa6eYJXSftwxbCoTMFo83CmERdeFpxNH/bqjZFry+Bs0yO6MfSwRF4wz/KNsl
         LtwFLkWvrQKPichJO28R2jvTbzor67r+TzZAsBA4yq0voI2+Ck7lKO1goQ7cHAd6BKlD
         D8ItzpwScnO59vZXALV909b8V+/VCiDtrdMrC+Jn6uqN2pURyY5Wdn7wt9QkmMHZFTMN
         H4QEw3SIHDOcNRXuHJO4llyvPf+DM28E73CuHWk9OP1/lnmFPZWLRj5jV1ib1kz5+5ok
         GiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751443099; x=1752047899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMrPa+nCyVOrTi/KimE81WsU7dXcbbOJzv0t/rpE1q0=;
        b=xFniAHo8+MtzG3jXb/M61hx33TU0Lc8DW73M02EWkQc9Mn7uVTfGRCslcJoAXpSNRH
         GJ/mHzJ7BXb9KFUClIGL37iYoRsG/8FEB+5ktyvhTd9UISIfLDAGrkIbvADUPC92Ac5+
         xthYYbM39W9b3G9ktVNgMUlOdFfhJLtvn/irYnj3zBb6B1Itukm9x2ujYSDb2cmxHG9B
         4+LQohJiDeVbEspa++hwgKCqnMH/Wyg9U5Mz9Ps5JyVh31wFIKOGOVNt72U7jgEW+bIL
         UL3SK2HuOYvj5Gjex14YWL09HcnqD1JPvlku6nb1B/KkjVoi3uAZmK8km+tkzJllDr9l
         S4sw==
X-Forwarded-Encrypted: i=1; AJvYcCV7h3Tk4YCG9/O9efkUIliXfd2Yq5QivEoYVpMjLyIlTvGrfyt++4tWL6ZgR+6BhqpIHo715/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0V5UWjtxYLjkIBPh2GpJGMzcXAYTTcSuxqTtPrL5ZGLVgb7/
	fJ6oiuddtFg+OGyqQ/xkoE+wEoxr5UalzP1iNHoBdG3WRMeP18ts99FJ
X-Gm-Gg: ASbGncs1mC419xb1cbL+kubiHOplR+ERbjrtXjOKtvMjj5fbZKXmzfb9TN28DHvQbrL
	25s4SCgD7Pd3RCM4DEJ80h1YmhzUcd9sATzpJ02kzpexDL6dxWzVhO1BxUIHe0juF1jJExaNaEM
	c9uAwJeJHarrwRzAayrETUSyLXUtuKjUf9F4VXJV2HPaaiS3LcymU5Qt+ykESzbFXUtSL/bZ5K1
	2fLSwUpTvOKMR1UBwJGksuk2jEJoWQrMASwiS/FSd+mCbI6tGG7MiPWl5uPnwzgU7L7Lu+KCGZc
	ZVBnozthG76aIpv4xCqo/57ge13lIiJApq2KpjXe9ig6USKrm5pJcSCI7iRJ9kSjGYywSb2n/3h
	EJV7YePHnF0slO2HU/Lq3zHyyMu7bsvLvDA==
X-Google-Smtp-Source: AGHT+IHLDutWch0IE2Bvaph3sB0QawPJ6Z0hKCLgrQShX7CnSrpXHC5UwFey5MHn8lcu2vldiVGXsQ==
X-Received: by 2002:a17:903:4b4c:b0:234:f182:a734 with SMTP id d9443c01a7336-23c6e54ff8fmr30013685ad.31.1751443099079;
        Wed, 02 Jul 2025 00:58:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e2493sm131262725ad.48.2025.07.02.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:58:18 -0700 (PDT)
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
Subject: [PATCH net-next v2] Documentation: xsk: correct the obsolete references and examples
Date: Wed,  2 Jul 2025 15:58:11 +0800
Message-Id: <20250702075811.15048-1-kerneljasonxing@gmail.com>
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
in the various xdp-projects, like the following link:
https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example

[1]
commit f36600634282 ("libbpf: move xsk.{c,h} into selftests/bpf")
[2]
commit cfb5a2dbf141 ("bpf, samples: Remove AF_XDP samples")

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
V2
Link: https://lore.kernel.org/all/20250628120841.12421-1-kerneljasonxing@gmail.com/
1. restore one part of doc and keep modifying a bit.
---
 Documentation/networking/af_xdp.rst | 39 +++++++++++++----------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
index dceeb0d763aa..a206c3636468 100644
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


