Return-Path: <bpf+bounces-42566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10949A5927
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 05:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABEC1C21154
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1011CF2B3;
	Mon, 21 Oct 2024 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sle9d1sq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0D208A9;
	Mon, 21 Oct 2024 03:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480363; cv=none; b=VzZvOrGZEoq0nzOG6WT9IoNZFxqL+qLs5bR4eHtrFH5p14iEFD199VQHmHm5VL3gsyxDrvKOfe2/SgjIaqEz5RSRJxY/y6R5wHKBM7IDQzFaDi8kLObC7EM6zGNNuvHuzXpxtSsgd7PgV0lwOtDUsoOrMZ4WJRFaunPyUmTYbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480363; c=relaxed/simple;
	bh=tbFZzb3Ngplz3/wJWyh5VQWsoXKO6vWI78ThWMEmht4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PU4Hgch22i0/eCZINdFrzp2z1HcKZZzd8STtZ9MciLJueYZ4w3a+1cfdSDXr9+KszgC2pKTgfjSY8isxSXvbd+KeXo0KHxX7NG7ckTbLLQbJ/9sCvguwnUpg7AJzgjT3FOAgwGZR3Dr7RqCVnzFpFqgUpAbYIo0jOJxXJ0j2LEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sle9d1sq; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so29947075ad.1;
        Sun, 20 Oct 2024 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729480359; x=1730085159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8sXCsn2gCaFNnfySACDJ6PxpYF0rU39snIB3R0VNhY=;
        b=Sle9d1sqYM6rQPNHd9Zf5YwOzi1hjI7wAuYxs/1SUH8h7v2/6+YVydrC4zmEEKRt5P
         0LU/jxnEb6qZJg8AXTVzGEM/NKgChQ0YruwTbUW9GZT2FfqVZImL04XD9rbOGLG4LQSw
         E/Kif1oBVv8TFLnjbXXvcPMd4d/FajYcIy6JTRVjBBPmvu9ckhU+CycLCT0fFvhuIhCw
         1DrVESXYFPAqAZ1o54iBw0O8HRljhJlBH+SPrBZWGF6HSPQZyXwYQPdd/z2PjG5RWKia
         xgHjO8sxW4X5OgA44NX6AxDx/z1CVKn5Siv2vpQx3o/7YlA/RKLjXDhJiXfBWzn22EJK
         qn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729480359; x=1730085159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8sXCsn2gCaFNnfySACDJ6PxpYF0rU39snIB3R0VNhY=;
        b=RoHN6R8c2996wMNu9Cl0cbelYFveFraglJJhqahm3Lr21pO8/FwzgWubcXbnQ4+pBS
         fyjmtngnOBiVvNyF0IIP6ICvvlzntKmdl4Rf8JAAbDOuAb8yM/Mo2SuVZB7vcb2afOcI
         DxNEb7wfHvyLpR+5/eEvOpmLvPcPDSlkWhryTrFuRUwaMFdAvazb1fl3Hkyp2qeRc+rB
         diCrBhBV+kEoCYm1rFvwHNAG/BMGBVsTNwVqwkyN5WlHo191yJSYSPCKl9aqZJkBDfFw
         qxczs6YVmrOH2YhFv/FN2ScbPpNAOSNvq4wx/7kGLWXTtl4Cw1f71vrcs+8L5aWJni8O
         AwUg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpCuVZpux86Aril0diJdTwFFKHUWPZx1WikUdA9Nz+bjCjG6qQovU27aBGJH16M+A+JeQ+s6t6fzC@vger.kernel.org, AJvYcCWUYGJBi4IthXj1+wdBpQkFdbF3Q3qU67V8vF1S3UDJDmN0dQsAmOPIpTSo9jI1sKoWDBM=@vger.kernel.org, AJvYcCXzzMGQ+0hfSBY0rp1FlbDoTPhcAKh3vnizX4ZT5+0NOdg2+QZ2xZeBMjSkAIGLYkrHvkyCTFmzGnWWRwe4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqrjpgq/FUML4W20poJQobwJkryFLK6ojo5iahC3Hqm5d4V4U0
	Se2urfo4u648YKdheF1ECOI2IPCFZbyFt4o28j4xScDb/m7cSaciLz3gx1dcHGY=
X-Google-Smtp-Source: AGHT+IE8m/zRNXs5mHDN710q9UHS785xxIfQFJD4ErJjU9tsS2pz/tttnZRCX/E7nyvg0EKjIaoIJA==
X-Received: by 2002:a17:903:1c2:b0:20c:e262:2560 with SMTP id d9443c01a7336-20e5a95825fmr139194195ad.50.1729480359464;
        Sun, 20 Oct 2024 20:12:39 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee658esm16377845ad.13.2024.10.20.20.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:12:38 -0700 (PDT)
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
Subject: [PATCHv3 net-next 1/2] bonding: return detailed error when loading native XDP fails
Date: Mon, 21 Oct 2024 03:12:10 +0000
Message-ID: <20241021031211.814-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241021031211.814-1-liuhangbin@gmail.com>
References: <20241021031211.814-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bonding only supports native XDP for specific modes, which can lead to
confusion for users regarding why XDP loads successfully at times and
fails at others. This patch enhances error handling by returning detailed
error messages, providing users with clearer insights into the specific
reasons for the failure when loading native XDP.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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


