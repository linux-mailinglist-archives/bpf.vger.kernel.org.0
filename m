Return-Path: <bpf+bounces-42142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF099FF3C
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 05:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE21C24468
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED22186287;
	Wed, 16 Oct 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnXT/LKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22F43AA1;
	Wed, 16 Oct 2024 03:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048628; cv=none; b=Vm0jTAl0UmQkNTnMujUnfawV16hrb+pdPytg8qMUqdNTbm5vvLzVpaUN0QFc/fudbstDjKWsZbuDZDE+mXTfS9qby3VHGBjwMXJ4Idjzq3Gxf6/P075IcawzIqN1VOQ8TM1yVgf2G/VeC5BsGGmvHyoDrdpHN6XlvDIL6404Xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048628; c=relaxed/simple;
	bh=nW+Kqoc5SHj8vJTSbT5FN2JfIHivZD+sHFQeR9q7pGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/dbWG1WIlJj/aKGXDMGb8VMS6h0lYMtjyorSh97jEtJ7g4yAHP5DDaTjjyJuFBHTAHqxriQs4X5PQlH9C+WuF+emcyeM40SfwFiW+hgZu6ol0Cyk0zf7GmCq41FFHIm+SZ4y8xmzob2OiXHv+nWhABIK/WEclp/LWkrXzMAkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnXT/LKj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e483c83dbso4051643b3a.3;
        Tue, 15 Oct 2024 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729048626; x=1729653426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx6SJYCtNJsdJQyhVFfKeKjzk1kyxBkN12KJnhv9dRM=;
        b=jnXT/LKjbYUBUCCSORmvN/i3xJH1NSjyF5duEcLJ6rUc/xXvOMT2lwP8+1SKzglkCF
         nkcGOh66Pz8V88f4Jl5pJQQIqDubowgipwm1mDQvhAykFwuF3560SY1FobYW2ofLuPRV
         r1ovbrFlIYmCjouwNyTjaGxIrIpFsKcX6UKOVbPCgmWzLitdBFm6IPkco+kKASvJWqn4
         vTmCba5x4kIZkOcNMtpEhv0vkGTefG5SsZfe8Pzlvjt3TQmQVIAsxAQOI4vOGLHoLs8E
         ZfCBqDk8d+ZPVXEKe7YOPGgRCpi9SWE8ZKCVH9VUXq8mQGzhmiFk/0TAc6cmp+1+qFzx
         Tt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729048626; x=1729653426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sx6SJYCtNJsdJQyhVFfKeKjzk1kyxBkN12KJnhv9dRM=;
        b=clfLdVbzKCX5ydU63o+2g98mLbeN/WKsTFq9Y9mp8oQy9LwKmZKIJUlLLYmkR1jU79
         zkXlbvLWU8JJUbu+aWV1SnA2BJhhfg/EmnzeRk3gxBTCxeqLX7xx2H3WYcqdPNtGOOxk
         i6La8W15X4bP6SW+MkO6m9ByGDJ6/9h0Nqvatrm/E59cZkgqVzIVPeIUI2rzE3qR1eC3
         386j2XLYbSvrBoBORYZ/1q/D0JMsDfCEmRsQqFEicRdVjv5mYsEPJ1WaZWlmB+0TBf4/
         3DZPVPB/xtl/460P5zJ2jKf0QxcWWule7x6vgCLX0i76nR3ZUOWH3qsp55+Y+QsIonsT
         oXbA==
X-Forwarded-Encrypted: i=1; AJvYcCV12SChlPupZ9XJxJr1SV3xQjphuoGzBcRxQc1KOzr1K47r6cAWVUo1aZfyQ1Xv8yvapCZoF9c0JF85@vger.kernel.org, AJvYcCX63fxaovXOo48IH+t+xe3l3JqHO+RtIiCtoc42fmzjGM/rZsgBMzysbCX0AYbUWFfQTmA=@vger.kernel.org, AJvYcCXFlfOrx+7FPcLvOI1rGnTy5C5GZkuc8TUSzdI3Nu9bxBpw9iEntgdqhGm0UJQNvCmUfN+GLsK6YD+73wxx@vger.kernel.org
X-Gm-Message-State: AOJu0YxyyTHxNdNlRaNXEhOnBa4/3gEwCEF4Luxhqe6NcDILiStxccIn
	OGwwFvHPiYCSGxLU52x6ybevk3mxTLqJGxToofBfmfI+rGI+IXLwBA48431W/t4=
X-Google-Smtp-Source: AGHT+IGq+G09piZiaDvd9FaBJHaI6CYSu0CP8RRcEirqnTkzmU8vob6PwD5a18XD2vYr6B+5zXk0tg==
X-Received: by 2002:a05:6a00:2789:b0:717:8ee0:4ea1 with SMTP id d2e1a72fcca58-71e7d8b2ab8mr4911526b3a.0.1729048626499;
        Tue, 15 Oct 2024 20:17:06 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d38efsm2252069a12.46.2024.10.15.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:17:06 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] bonding: return detailed error when loading native XDP fails
Date: Wed, 16 Oct 2024 03:16:47 +0000
Message-ID: <20241016031649.880-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241016031649.880-1-liuhangbin@gmail.com>
References: <20241016031649.880-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bonding only supports native XDP for specific modes, which can lead to
confusion for users regarding why XDP loads successfully at times and
fails at others. This patch enhances error handling by returning detailed
error messages, providing users with clearer insights into the specific
reasons for the failure when loading native XDP.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b1bffd8e9a95..f0f76b6ac8be 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5676,8 +5676,11 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond))
+	if (!bond_xdp_check(bond)) {
+		BOND_NL_ERR(dev, extack,
+			    "No native XDP support for the current bonding mode");
 		return -EOPNOTSUPP;
+	}
 
 	old_prog = bond->xdp_prog;
 	bond->xdp_prog = prog;
-- 
2.46.0


