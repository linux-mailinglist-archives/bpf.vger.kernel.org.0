Return-Path: <bpf+bounces-42567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECCA9A592B
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CBE2824DD
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC91CF7AC;
	Mon, 21 Oct 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4B/d0VB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481531A60;
	Mon, 21 Oct 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480373; cv=none; b=L/sK/WDr2iAeS+aob0aSdewfwjLBybt7YMukgyeYPR4e1cmuDHQu8vLjZb5SGKrCHPGvpmBPHyobjvqia8BDOnGeUmWbCcEbZ6Eo+oPdhJZbMZ5ZPitnKjKxtA1sTDGwKjAcGo1jTh6LGWo9/bt4KsAVv473Q/qjRgneN1/Z/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480373; c=relaxed/simple;
	bh=fOLDmvWp03EDMC/jF5pgUB9+gKQ4S8vdFti47RUJux0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDNH+HvrCsA1qgSqqoCJJF56YMrrM7yZvBi66VCnfEqwTdHbhXNXhpqs3OcXRvmi5Sx62kUMBMoTF0keMxYW0HVAWVJ8pfORYF191IZWqc2uBxp8ICRPbo56cDiMmEl5VEEztsEG/TY6oVfjymIXUe+3eEfNaeyGjALaehpYODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4B/d0VB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20e576dbc42so25583155ad.0;
        Sun, 20 Oct 2024 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729480370; x=1730085170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9uyhhZHz3cwvmGlgJcmKlovJH7fLo1iSETQBpUvqrE=;
        b=M4B/d0VB1LU5NAIlxbuFYy5ToyR/HVULFEVm4ciuWPbje0mcdD6Ym7y53SzSkA48E7
         Nwjf+7JLtZXDU62IEkqbT8bDdBRHiIzMMhp9KlGWbwwd5wvP/Sp6AjhEAju5vMPCdnwG
         nghhO11LpGYk5ckSyRbWJDr41OwhERxSuS6Ir5YNqB7Ph5CYXClQHwxnR6JT7QeywdKP
         j3LsHBK1V/8zefmnQL3SJnDVqCdl9oEY3Z3TpBDCHteBIfz7pWLVQDpQN41E5ChKaA+b
         aNW4dLqxPiyuDMIHPTpz+d/JnrWWu6DOz90HPSk8VIIFWQ1fdYORU+yNRamS9VLvlug/
         nepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729480370; x=1730085170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9uyhhZHz3cwvmGlgJcmKlovJH7fLo1iSETQBpUvqrE=;
        b=QLq6l0RN2Ki4TUFqUcTq0HBIzP+mj80TyhqcGkpIi/IoI+Q/jVMpQYw/Jwchx5VNnY
         P/tqvoWWkItQjvZzTc7uqbC8ODH5ub4cUkz7nF/mhOQv7GuaygxYNyiOYp3On7EWYaTe
         K5qGkYsN/VW7TfbjACHSTGq3NfXi0PRgN6Sw6WwbeGYB+lAH+uvuooWqo9xTQWqeHLAr
         0YgZYpf7/mfn6aoJ+bMJkm1ksQpprsJVDiaXTt67fJch2SOWEI0BxhViR1dJKYaMIUOk
         ULdvkAeY+WEPD0cCBpDfR5hcIq7Q1PTbcNSSnovjI3yYWseIfGW/NZ90QVTCrL5ZFFS3
         T/rA==
X-Forwarded-Encrypted: i=1; AJvYcCU4FNHxCHH9cffjOw/4WOeuoEuD+dAFCohiTTnXtbqseHPhuZEEaXkgAOq/YT/j5WHplRYfsUisqrCW@vger.kernel.org, AJvYcCUJujXzUKpKBQN7VHR8eY3YnCZnkj/Zd085laS5qhGxcG1rbeWcz6+fzUQQxC49y09NfW0=@vger.kernel.org, AJvYcCXXx4/bXThSgfLPDh1ZNjsdPOw4HYOQbyU4I0pCKd2Mue4DJJ5/fa64jL4VP81gTMYvuZVtQ/TJkU8shz4a@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0macxeZ8wSZQKh0fPX5h7w5a8XEbgVtJeW1vhCl9pA1/jbJB
	Da/jjAG4nCMVp+YootmKpG7NNu/MhQ5KFYqx4DYR6NwZ1qkuvvFknrvBrmEmAMA=
X-Google-Smtp-Source: AGHT+IH+03AHqmQUUE5TU4bSFfRQnNY4XsqORm1ADpzBvIcC549dB6BcgfFw6JBBuF2A2Hw5JWGhFg==
X-Received: by 2002:a17:902:e883:b0:20c:7898:a8f5 with SMTP id d9443c01a7336-20e5a90df51mr137221975ad.28.1729480369584;
        Sun, 20 Oct 2024 20:12:49 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee658esm16377845ad.13.2024.10.20.20.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:12:48 -0700 (PDT)
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/2] Documentation: bonding: add XDP support explanation
Date: Mon, 21 Oct 2024 03:12:11 +0000
Message-ID: <20241021031211.814-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021031211.814-1-liuhangbin@gmail.com>
References: <20241021031211.814-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add document about which modes have native XDP support.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e774b48de9f5..7c8d22d68682 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -2916,6 +2916,17 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
 then restore the MAC addresses that the slaves had before they were
 enslaved.
 
+9.  What bonding modes support native XDP?
+------------------------------------------
+
+  * balance-rr (0)
+  * active-backup (1)
+  * balance-xor (2)
+  * 802.3ad (4)
+
+Note that the vlan+srcmac hash policy does not support native XDP.
+For other bonding modes, the XDP program must be loaded with generic mode.
+
 16. Resources and Links
 =======================
 
-- 
2.46.0


