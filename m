Return-Path: <bpf+bounces-16256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D17FEE84
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 13:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB0BB20E1F
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2554503C;
	Thu, 30 Nov 2023 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novoserve.com header.i=@novoserve.com header.b="MtblwAJh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117984
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 04:04:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bc39dcbcbso1238719e87.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 04:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=novoserve.com; s=google; t=1701345872; x=1701950672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biKlA3SqBh1c2m8RfvMfF38GHC4RXRIIZ9C8YrbJL70=;
        b=MtblwAJhghUmDoOdjGz+W2DqSYQW75yuOgstF6laCrMmUQApO70KhNqzZ7QJMIrbJF
         dLjPzoAgB2hThG5UIIuVZTVYKv8bygeXWLmk8mNF0CZf4iGZklKK1XVFSDij8i7RD+Ql
         B9Mgkax2K3z+1/r6w0/QQjSi0UcFH60SLJ1JBYZdeIjtsfvacpds0Skl+QvDl1Z0BXGO
         eP4JOv54Pyiyo8o8jymDHpOu5DskbmFOIqf+40QFgjK+L9Pwc66Si8Tlr2bjnKcqd48c
         oixz7fY/aGz3yssYnl6L0W9ZFGfQRnYzvFzWnIUcL/P9Llh74gr1gXCkKJFm4XWsphUK
         lO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701345872; x=1701950672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biKlA3SqBh1c2m8RfvMfF38GHC4RXRIIZ9C8YrbJL70=;
        b=e5TIGFzxuUqCNNqU+flEeSe0TEWGL0Tl7jYeFNagC8ypNBg3hzT1rH2tgH0QmzG9Qi
         Vb2gbaba94+HhIX102b4mhrBJnmMMFr7vcNiBAE4Y9HuyWsXLICp9QcqZtSGpDsyZ569
         a7BPlEvC4kEqPGpXW3hBcQgXG+v8f38O/NrjwcdbpQf8SO6G9In+0Fs2ex9TpPPwT2ec
         dB/75UQJyDIIehfB9I2gmF2rY/fevIw4zumGpmeW+Auobucy2QSIFyvBtHFOm0cg0Qdv
         /rbz3BofxsjS2Gm0V4M7aVJuCpydM0kK76aXzPIc8jqS4fhbUKjz1WTH9ZHi6WaxH9jY
         1zdQ==
X-Gm-Message-State: AOJu0YyrdXy1jeBsYwTr0tHdMPaEnoiAc5C/+yAkKE0CtEXxpNyTPS8x
	sxXeLTYFrtij1aa60rLqKc5D0QHxeOWrQj3WJNl2SQ==
X-Google-Smtp-Source: AGHT+IHLrXhE7XsNRYFnjTrJqrrjbhok/37kXNcOgadEiZ8wrEfnmIVYnCaosz6cKPYW8WVg3m/S7w==
X-Received: by 2002:a05:6512:acc:b0:50b:d103:2e3a with SMTP id n12-20020a0565120acc00b0050bd1032e3amr1152243lfu.10.1701345872386;
        Thu, 30 Nov 2023 04:04:32 -0800 (PST)
Received: from localhost.localdomain ([185.80.233.233])
        by smtp.gmail.com with ESMTPSA id v9-20020aa7d9c9000000b0054b1fca00c7sm486052eds.74.2023.11.30.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:04:31 -0800 (PST)
From: Jeroen van Ingen Schenau <jeroen.vaningenschenau@novoserve.com>
To: bpf@vger.kernel.org
Cc: maximmi@nvidia.com,
	tariqt@nvidia.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	Jeroen van Ingen Schenau <jeroen.vaningenschenau@novoserve.com>,
	Minh Le Hoang <minh.lehoang@novoserve.com>
Subject: [PATCH] selftests/bpf: fix erroneous bitmask operation
Date: Thu, 30 Nov 2023 13:03:53 +0100
Message-Id: <20231130120353.3084-1-jeroen.vaningenschenau@novoserve.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_synproxy_kern.c is a BPF program that generates SYN cookies on
allowed TCP ports and sends SYNACKs to clients, accelerating synproxy
iptables module.

Fix the bitmask operation when checking the status of an existing
conntrack entry within tcp_lookup() function. Do not AND with the bit
position number, but with the bitmask value to check whether the entry
found has the IPS_CONFIRMED flag set.

Link: https://lore.kernel.org/xdp-newbies/CAAi1gX7owA+Tcxq-titC-h-KPM7Ri-6ZhTNMhrnPq5gmYYwKow@mail.gmail.com/T/#u
Signed-off-by: Jeroen van Ingen Schenau <jeroen.vaningenschenau@novoserve.com>
Tested-by: Minh Le Hoang <minh.lehoang@novoserve.com>
---
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 80f620602d50..518329c666e9 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -467,13 +467,13 @@ static __always_inline int tcp_lookup(void *ctx, struct header_pointers *hdr, bo
 		unsigned long status = ct->status;
 
 		bpf_ct_release(ct);
-		if (status & IPS_CONFIRMED_BIT)
+		if (status & IPS_CONFIRMED)
 			return XDP_PASS;
 	} else if (ct_lookup_opts.error != -ENOENT) {
 		return XDP_ABORTED;
 	}
 
-	/* error == -ENOENT || !(status & IPS_CONFIRMED_BIT) */
+	/* error == -ENOENT || !(status & IPS_CONFIRMED) */
 	return XDP_TX;
 }
 
-- 
2.34.1


