Return-Path: <bpf+bounces-51329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A7A33432
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 01:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35511885DB1
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D9B70820;
	Thu, 13 Feb 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INZ96AzW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EE4D8A3;
	Thu, 13 Feb 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407445; cv=none; b=HcLKlT4ORFTmeMcSAYcGYirxv+NzpaH0/chjqn7FydoxNn2OtPQ8Sowv00TpdNWdpOXAdFHeBxqBho4X4ZND4PSLM6BEstVowvtY/sorvgfGVyid8Z0SaoHwkz6EmpySLuMNFeHjpJ+/vTp5KXCfXW4XYikAm3H0x+X3ElrkkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407445; c=relaxed/simple;
	bh=noHOyu9YyI1F/QtIPNZXFq2XOBMNP0ul9/0Laym0Pr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ie7s4jH9CpuvP0rnuUFwMpd4RoZFnSZfCO3MyiV1eGZaGULPHY+kNz4Zr7TnFNLuIXibdJZ5se7ta9+zhmOXA27wTV1qzTUkgW0imy5Ak9yu5Gf9jtiSfLP5tCw7hY39psWDGM2OT+bklUqcYVeBxv/p2svKjWudJ/CcURzDmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INZ96AzW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa2c456816so581392a91.1;
        Wed, 12 Feb 2025 16:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739407443; x=1740012243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKWqLMFQKYun2lq3SINKeigAEDx+Cz3zR58bcom2PV0=;
        b=INZ96AzWn56PCrI2aNT5ViNflvQXE2dVJ1tiCkC1NMloksLU0rakSsZNiWK/Vg4np+
         Xn8v8RxUWwwZmnDMIZ6CSlPp7oDTylkRQfY5gn9VWkPwpd6Ua6T1KAWk+CQlbNGujlp0
         1kLieTukl50m9MzSD797VA9l9fgq4M7U/gzsgPqHot+1YMwsfw9XjvqNTxj6vjt+sBvA
         7JfDs2zFHhi1si3/xE8Tre62wCgivUoa68GRtqx0F6z8m1TAaN/Np2VHzgEO/nXkD9Pa
         dwtn15vw7Fp3n8ULQwqZwKSdegsRXYlPZWjyopkU34plrLc9U+yYq3TArPrrmfashlZk
         1yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739407443; x=1740012243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKWqLMFQKYun2lq3SINKeigAEDx+Cz3zR58bcom2PV0=;
        b=NtCfJRC/wYrY9lEEOYrxI00JWMMC+dJe65ZQ8xrSYc00WlndBF2EgDhH/AJWxfkCJk
         jGvS0K9clifP5uJ2ZR9YKPPVZ37EqkaYGwskWM/HT+WgFWne9KYJvBfGU/Ba1c85u3UV
         vT8YAu3y5XD0u+nDg8ryRqAAmsK5EltL7tDroThDBrFrzDx1cdnZ0QjkC0byysAbZ6Gb
         tfKfFOEmVD9b6pxw0YMeVRwmWklPNaYCMtwF9ImkBXvBrwuDq3khzsQUy4nDLRvXwBmv
         nRDbIG3Q9ybdEpeJ91b8/vR536Xs0xcly1sckuDxrj0B2FJT4lwXdov8cwFPhnadnrVu
         ho5A==
X-Forwarded-Encrypted: i=1; AJvYcCW7E3lynsxT/5dRCw9uUgk/tPOkIbqVoK2CemLxTF99Xf5ZNghJXUxaDeUE0Aw8KtM9QaBXZn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65Czb+OnMQI/gE96Wa+3RTcV0M/VZuoYMmUR4AXngvU8Z1F6o
	UWWInx5VLQ1NGaGc+vcw7faR6XEOp1YAOeVLFWs0FInN0+PT+cEq
X-Gm-Gg: ASbGncu2MEHt1rbejgQG0KDq2HRArH8vGxOheMICElEXRrPg6L85TKyKguX2N4F6FGL
	vd5tszgPGMWV6KDTqlGUVOUn+Fulhus8CrICZqAWuuW5UFRUHGr+zZMI4n5k8MYQ/lqk2jlLf9I
	ELUyy2UK/jzO9gFbQ3migE0WSR3XAnkindlTZU9T8jut2Ib7Uz/3PtgSx9XS1c7W7Pw+52O4pzF
	TH4tXSKEsG+XhfV41tsYb7hW5GdSxCDN0PSLD7I9w0yG9tav0LGUmDBJyQg3Gwun4jADy40uS7U
	HAn46ysYLw1zaAqPPxZR0TWmQWq519Gslphh2ucip//0Gh3C6yuADg==
X-Google-Smtp-Source: AGHT+IH2xwmtY2xTvS9l4hFg4Gz4V5Twj7yK77nNbDGpQeJ0+RnvgdXfdhHgfuxSPAJcfAlqMFGiGw==
X-Received: by 2002:a17:90b:38c6:b0:2ee:f80c:6884 with SMTP id 98e67ed59e1d1-2fc0f0db50dmr1910178a91.33.1739407443366;
        Wed, 12 Feb 2025 16:44:03 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([111.201.25.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad3fb8sm63618a91.26.2025.02.12.16.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 16:44:02 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@amazon.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 0/3] bpf: support setting max RTO for bpf_setsockopt
Date: Thu, 13 Feb 2025 08:43:51 +0800
Message-Id: <20250213004355.38918-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support max RTO set by BPF program calling bpf_setsockopt().
Add corresponding selftests.

Jason Xing (3):
  tcp: add TCP_RTO_MAX_MIN_SEC definition
  bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
  selftests/bpf: add rto max for bpf_setsockopt test

 Documentation/networking/ip-sysctl.rst        |  3 +-
 include/net/tcp.h                             |  1 +
 include/uapi/linux/bpf.h                      |  2 ++
 net/core/filter.c                             |  6 ++++
 net/ipv4/sysctl_net_ipv4.c                    |  3 +-
 net/ipv4/tcp.c                                |  3 +-
 tools/include/uapi/linux/bpf.h                |  2 ++
 .../bpf/prog_tests/tcp_hdr_options.c          | 28 +++++++++++++------
 .../bpf/progs/test_tcp_hdr_options.c          | 26 +++++++++++++++++
 .../selftests/bpf/test_tcp_hdr_options.h      |  3 ++
 10 files changed, 66 insertions(+), 11 deletions(-)

-- 
2.43.5


