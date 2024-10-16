Return-Path: <bpf+bounces-42141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1399FF38
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 05:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9170A2836EC
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1517333A;
	Wed, 16 Oct 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O02zfJMy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42321E3DE;
	Wed, 16 Oct 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048622; cv=none; b=AtVKzgUzUjRsxqbgcYJBRgcJjZLfIIuBNCOIeYNVP0H8dxy+gUEZ8RT458ifchLELASjeodPUWPMPpvii9CSXW01X7bcugoevk6wBR08DlUm3waRomloDcfBif4yqOGUAKjETPEmgx9Oiz76C6P/yoW9QXmdWM1gHBReTSjFrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048622; c=relaxed/simple;
	bh=ASW3zdLVSI8D9vmOu25Mx9j2/E5M51YIq4KKa6Ixvew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VHZ4PKzu9AVVId62oha3EgnOy6M+ZDRLwIRQOdRxvmuj4lYTh9ezFyGEey30y482pMqSQuk1CuVdKCrczloUZgWm7qBzj7xnKasy4ZGgHEF+Omp8XlnX6yPrQA6GOCndoGxb8qtu4BhPVO4WqgGP2nngZ9dwDFHsku0YSLx3aXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O02zfJMy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e5a62031aso2231769b3a.1;
        Tue, 15 Oct 2024 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729048620; x=1729653420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrvNd2WlzSvZn8SbdWzM4Sh6su3A2CAUIFV/xhzZWgc=;
        b=O02zfJMy+zmf+zXmipWh1Hx3Cc9ZmkKL4EmeriZZt0hpp92/aFmm43zysXlWzVx8F+
         IlFrRvti3Ys2CeQC1CSKzVsPpfRtDPU6LjXcr0iZykddg7YXEQcwzZq3em001PLe2y43
         mGYE4BItTt0LDOlDyTX0JiNfwW92M3h9BiKW+EKMXYF+luTip+WJww3zMkcsFQJ7IrBW
         hpdi/kpBt8KNsXX883dcmzrKdFdKgz6beg32n+nuEVbxiDrhU9tpKh84jvTFge/GcbmW
         icb20BncZWbMI3fJRFcRbeGbiWwqgEnKZegqP/7PWJ7ybZwNBObMz2njwfnTxE8oV2tj
         Zkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729048620; x=1729653420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrvNd2WlzSvZn8SbdWzM4Sh6su3A2CAUIFV/xhzZWgc=;
        b=J8+6bT4lYND8CAdu3NYgwgNTuTcbT4SPAcUf3DDSxmW6OTGvn5GTDWeVjg31RozQ35
         kXZmRvVPU/IVLk5FgH7zaritsexKkeNLjfvUa4JhCMjsPHrkAu574eDqfV+ZJo/86CtT
         5stxmmZ0ZeeoDe+MDfazGKfJSqNmst7fj9+iZdQpLsdAB/LrLBOIzsZ1TQwfqtogBz12
         hp0aaxMHOJT9WiMbxsaOzjhz0bQuSftqCfAPdC9p60exiQlceSBMp0YKuj6K5mCKK3nR
         YHSCBwHh7eBzNqk3umUod/F1FU3zyf2R142Vht+wtOfqNwiJQPrXVWWm/rk484pXgInI
         xXVA==
X-Forwarded-Encrypted: i=1; AJvYcCUxqzpNDhGyEb7Z8DodLlKUbqSjXUTDKYQeK4/lC8pZe3sqY7b3H7ffeuDGXTEjOngv6Wc=@vger.kernel.org, AJvYcCX6XDdkZUVKPtnYUJf1fV2TKmLKzmtv0o0FOZMTRlhMxpesf6lHRRiy+KX8gW3jo2kEJCTefwYe53tI@vger.kernel.org, AJvYcCXwEL/okploWUPeCHqjFiNvxFGUTA6Vur0EyvZqYtUqFjLa/lHI9Q78mmymLrFGEJ1kjMFVVshfD2GF7JvH@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqmYaG+y9zQTKTDS07X+nbPtP4l4WaSjkQRh+RZmLmogK+tGn
	lOvSlukM5VSqjl1fan0znKh9o82+MtiX6bDSJTXm9dlGYSX8mR/xOwP52Obg1Jc=
X-Google-Smtp-Source: AGHT+IELQeqEDvdT/vrZkCOL6DQv+33n6ABMuAf6dx9KFO5yJCURgHzST5FyecShQEAECnrjYICmQA==
X-Received: by 2002:a05:6a00:21d5:b0:71e:14c:8d31 with SMTP id d2e1a72fcca58-71e4c17c145mr21358477b3a.16.1729048620008;
        Tue, 15 Oct 2024 20:17:00 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d38efsm2252069a12.46.2024.10.15.20.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:16:59 -0700 (PDT)
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
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/3] Bonding: return detailed error about XDP failures
Date: Wed, 16 Oct 2024 03:16:46 +0000
Message-ID: <20241016031649.880-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set return detailed error about XDP failures. And update
bonding document about XDP supports.

Hangbin Liu (3):
  bonding: return detailed error when loading native XDP fails
  bonding: use correct return value
  Documentation: bonding: add XDP support explanation

 Documentation/networking/bonding.rst | 12 ++++++++++++
 drivers/net/bonding/bond_main.c      |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.46.0


