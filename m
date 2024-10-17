Return-Path: <bpf+bounces-42264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8619A1861
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EE31F27978
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B640858;
	Thu, 17 Oct 2024 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ37FlWx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2541F16B;
	Thu, 17 Oct 2024 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130818; cv=none; b=st6lIiO4MUpy9G2XQSMax10O2odox74sSbBgUEnl563K6p38T91nAY4h6HvOb46r7d8TXcKpIKQXnKuEIDk5yoCcglbVsp4Bzkg8E0aiR7fge5612LMrkibIELj8YfQM8tQg80C4s7LzBrsELagoiUhVIQuqKV3CjOQg7Yc+Owc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130818; c=relaxed/simple;
	bh=Fvi9tLsZMtkg3z9qwzG3QWo5wuwiZOLaNI8W4fQXQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB6VxXNYtjvrkafQ4waiQxaJsjxbiMEf9/jQ2d8NNZzsLFXlpCiUU2RIqfw5p4zBA5TGQhQUdhMiAbvfbZ9rwkFt0qfh+W36SHE3Inf1muWuIfDNpXbL2EEZLpNdz2/eHcDOvhgUdgU+rcz4SmBtIYFA0xD+U9Jlik8dRse92+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ37FlWx; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so308229a12.1;
        Wed, 16 Oct 2024 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729130816; x=1729735616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCAVSKPO93EI2yxytuWUSSfeG9zt7o/VcVBnV8Vc6iQ=;
        b=jZ37FlWxh8TUWYJN5RR+PguYjVSKxpe+z/NejiyA4Dz0rZ1rJiUjtix8N4Rui0DtSV
         iV7aa84BlDzditmbvETE78nmSBlO9qra8WHNOIXSgFoF1l4FbJ6gsQDDXtU4vRLszy8c
         TEWjvC7o20J8Avme1jlwEqFQ21naymy1bKAHEq2fDPjEmRwfE9lUwXtAfX4f/0uKLxo6
         ZSO6U2SVOEL+2ZDeMbpTWYtMLDHecZEXM/njCGwobtWgs/vTaOZICSLTliyFxeo3GQ62
         adZ+vSTT9u26PZpIZRbL3t1qQsXpVqW9Z+vi5TTdl98DOciylGgBQgXnT7LL5O4nqnN7
         Yq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130816; x=1729735616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCAVSKPO93EI2yxytuWUSSfeG9zt7o/VcVBnV8Vc6iQ=;
        b=SaspTTX7dXyCldSxFQDeNACMaJLys21e+V1GfhXwOPf+34zgzbXT7Y9ePnSr0gcsr1
         w2n/BVUBirDfyAzDEa4dTVDgU90IChtqXXv6Bo3RWXg/GKrFQVCWU5AMYuTN98SD+EoP
         bcWltGBb/Vb7qJ9KRc0brjkigjCmncnzdRrSBnLhJcMGJn9MISynfQM2d129zVzGWF/Z
         DYTKr9zQ/oZ3V9ZPbdw3g3HrMxisNEOchl/nS98OXRT8WoAoQ32s55A5ugWa9c0LHOpD
         Eq9w9r7gqi5Ca+SwtBWxCBIdC2a6EcexEAzVLY3yFtLLsoPdElvRz50cVN55RucOXBNo
         /5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO9Os12hwvrGNy2s9TqFN9uHda4bHaL7mLFg7ePY5x8CXYfJUqD2hkfCFNTyLJhU1KfKA=@vger.kernel.org, AJvYcCUaB2QKqCuZBhO0xYw/osBmlQE7E5MLYn+JUnMpkPfBcvz/2qzzEufK4s+q3QZGguP8pZVHwQGx8XbW@vger.kernel.org, AJvYcCWy5N6QKdVPotO8W6CVIAJMooTWBbs2DphB9kRV1UvuPNApcly/14xBXlEoTE2HDFMQPs6luc6zMqHQ8mO2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jGSAGa9XWKrnIfshFI6i5Ty/NLCj1CITQeuG8cB7GRofEbEC
	0omIoYMsv7cbKK5nAw1+ybVA+qM1Xbm/kuQDx3dSSHb4w/ARKadYhKTpZrqy5HI=
X-Google-Smtp-Source: AGHT+IFNN4kW1GOqTZgay76FYTzTCelndyNFl040N+w5w6TgkQdNMAv1GK1OGWMMUY2l1lLXOjQIhw==
X-Received: by 2002:a05:6a21:1743:b0:1d8:aca7:912 with SMTP id adf61e73a8af0-1d8c95d5a38mr26203032637.28.1729130815606;
        Wed, 16 Oct 2024 19:06:55 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c868ef6sm3343225a12.65.2024.10.16.19.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:06:55 -0700 (PDT)
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
Subject: [PATCHv2 net-next 0/3] Bonding: returns detailed error about XDP failures
Date: Thu, 17 Oct 2024 02:06:35 +0000
Message-ID: <20241017020638.6905-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on discussion[1], this patch set returns detailed error about XDP
failures. And update bonding document about XDP supports.

v2: update the title in the doc (Nikolay Aleksandrov)

[1] https://lore.kernel.org/netdev/8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org/

Hangbin Liu (3):
  bonding: return detailed error when loading native XDP fails
  bonding: use correct return value
  Documentation: bonding: add XDP support explanation

 Documentation/networking/bonding.rst | 12 ++++++++++++
 drivers/net/bonding/bond_main.c      |  7 +++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.46.0


