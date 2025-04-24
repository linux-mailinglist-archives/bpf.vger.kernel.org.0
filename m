Return-Path: <bpf+bounces-56580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D56A9AAF3
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E59D465938
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956122129E;
	Thu, 24 Apr 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmDIVKYl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD501E5B6A;
	Thu, 24 Apr 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491790; cv=none; b=dhBnWGQEng5GscqGZt//yj471Gxiek9bVrZO5poyuweKM3SNXgC8CvCeISYCKK0xM/p3DO2ZCoFZizVoxiArLRk+X3/iNJSOGBz0elL/kVUGM0r9P4EHPOgY/gSs5rpbGmGf6Sd0FCYLr5bbrRG60THt0Yy9vm74hn9m/Ks+gE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491790; c=relaxed/simple;
	bh=y5UC+0QaHNVuSZ7b7lcARL6lAthFtXPgUV/0j6xkD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt1pr5HyGq6kQEYP68vUfPd0d/rQX3Qh9o/JWo0C8Js+hdHahydXyLJqlyhmhKufdPUgKvwQfANU+GOcs0k3zuu3mrvJepNmo2rEwz2Y7XvgzCK5r8BGlW2zmfNFY9Kf8qnDj2xypNlYOHL/4GJ1YxKXLF5yb3GVFv1ULRviFTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmDIVKYl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7398d65476eso657210b3a.1;
        Thu, 24 Apr 2025 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491788; x=1746096588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+02iLfKsjMgHXk7NErynQYY2k7PwcNHBpBTjscdThQ=;
        b=XmDIVKYlmMijk4uAyaWTLOPcbfBfvdkiLcUhkkdB5ULsolaPpyDBZ2EH9Gw3YfjdZN
         aWJ+izD/vbvP3/bgQJ2obUT2Lj5NJbnxsSCv87lXv6qMLquRCsvQtl9+1iHA1Y3OGqob
         AW1z25GcFjfcyosRgrfpDgFnj4O6WYjyfRyQw6dn3vAgMD0qg2thiFAxHDXYgX6pt+OY
         kJTxaLtM3m/WgKLdUT7ELNZhfx2xGFBLlvbIbMuKoJAxKKty6Knqx1EopgsQRnRfZjct
         OiD39Xzy7N5VpCoG+f3s0Pq48rwCbwfmyUf3Dtv+e5+KAxL/uqN2cWGsaFHUQ0xs8Ut4
         2UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491788; x=1746096588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+02iLfKsjMgHXk7NErynQYY2k7PwcNHBpBTjscdThQ=;
        b=oCP1bIWLXE0sXrwXkQ1YURSjys6463KjIslBBwzZL0ZOHRQlxsOKQd2Vnf0xE1Z2Nq
         9CT7QAEZ9eT2/beSjegUiRZBXS2IN7EYQ+KeevZWpeK5w3Eq8K0Hfh9PYqAU9bayThAk
         rU3XYqjlVz8hi/pfiIypX7BDTKAqjE09KN0d3fvKGNusvQ0GjtXTDuSavYDrHVdOcwG8
         tCklBg//bMVOamuBynQrVFHBZ3++k6ZcW89qUcv8x+Adh0Olwm6Gj/9s/O7nDbNHL9vN
         hzNNFM5zGyF5tFJirEhYqHKUBlBhf/9yJoFh/u/FSm8gJY9BVvdeqfzS7Q6F/a1FQ17U
         gHzA==
X-Forwarded-Encrypted: i=1; AJvYcCU6BcTAxccT3Z3wZlm9YdReozlZj1Hn31fAulxDzkf92NVVBY4FJa79AXpwVMIq8afgONHdIiWb@vger.kernel.org, AJvYcCVT9w1pukLmWg8ULVFJ9IUhIBSlrkHqLNIiw5ZTGXZCKCR9H4hCpdDrPytN+/ecpKUG0X8=@vger.kernel.org, AJvYcCVlvjiAbh2RG98o8AK5b7EfgmIZk+ZAI4euVw4MaBLRNtZGhNaG9csOFxMt4/xGqHeRkY09hpaQIhMdkb4b@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qlqanShV94sOG4MjvnQgxyICC44jpN2Z3hCcN9AI+PxHyLjI
	zNg31T4wlPbbK7R8eI5P/OlyKeoXLJjg7MVji3XHM0qmzZ24gGTw
X-Gm-Gg: ASbGncuwUW+r9dSjLFAYgz8QhjAJnfaYoNCIaVIgYg1YCAX8c7bFqf63F0b5aZpu7cD
	x/GY9GGoot97/4jxFO9vzND75Zc71umR2NpQQLyrK7HiX7mL2sK7q6NY+QLsoHd6YWZdmpm8t8G
	EyPCBy5BbnfrZQVjnOHcbU++Vcme3fnko+4pdFNVYOSXbU7iCO2DhZHqT3pSCNqEk4lyfPYohQ8
	uo0D1HNbn7QmW5egrxCavBxMLmfAG3k6EntL0mbtHsBgzLwtSSpp7VRHO3LvjScN7IIEZODGgNO
	MGaj80hC5+JrTQJSI1duxVuzIbEi13N68d8C6FcjWO1dZbccJTcb85AS
X-Google-Smtp-Source: AGHT+IGZl/Ps7N6nQdKZ4AknXdjfnXgB0PEOrC9xf1nO1gV083gjQZJge/dA5JrgWqsmo/D7YV3B/Q==
X-Received: by 2002:a05:6a00:6c98:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-73e267e25dfmr3221332b3a.6.1745491788482;
        Thu, 24 Apr 2025 03:49:48 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:49:48 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 0/3] virtio-net: disable delayed refill when pausing rx
Date: Thu, 24 Apr 2025 17:47:13 +0700
Message-ID: <20250424104716.40453-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This only includes the selftest for virtio-net deadlock bug. The fix
commit has been applied already.

Link: https://lore.kernel.org/virtualization/174537302875.2111809.8543884098526067319.git-patchwork-notify@kernel.org/T/

Version 5 changes:
- Refactor the selftest

Version 4 changes:
- Add force zerocopy mode to xdp_helper
- Make virtio_net selftest use force zerocopy mode
- Move virtio_net selftest to drivers/net/hw

Version 3 changes:
- Patch 1: refactor to avoid code duplication

Version 2 changes:
- Add selftest for deadlock scenario

Thanks,
Quang Minh.

Bui Quang Minh (3):
  selftests: net: move xdp_helper to net/lib
  selftests: net: add flag to force zerocopy mode in xdp_helper
  selftests: net: add a virtio_net deadlock selftest

 tools/testing/selftests/drivers/net/Makefile  |  2 -
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
 tools/testing/selftests/drivers/net/queues.py |  4 +-
 tools/testing/selftests/net/lib/.gitignore    |  1 +
 tools/testing/selftests/net/lib/Makefile      |  1 +
 .../{drivers/net => net/lib}/xdp_helper.c     | 19 +++++-
 7 files changed, 90 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (90%)

-- 
2.43.0


