Return-Path: <bpf+bounces-42266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446499A1869
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7ABB25AEF
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5C1304B0;
	Thu, 17 Oct 2024 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+pqMI1j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033B1F16B;
	Thu, 17 Oct 2024 02:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130832; cv=none; b=S2omgaAR/kl582e9Ial0hc+XaC7ZHgA9JLt+phz4sX2yW71E2InMxGGD5q2EQ4HQlSWR9BOHg6asP41y4Ex3uD8jag3yw4R/ARtIRvW55VzPfjSMfNMaInpz07vk8zkqDnrNqHoucU2vjfBwnmyU4w/XPK0RdyfradNFvdH6yVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130832; c=relaxed/simple;
	bh=1jK1zqbxXZ+IbcwlEzbn+aILTiHmg3l0M8DzNP6zKk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGu04cRyepj5VR0wUAGA9TfYmVXPqf+622jBEIGN5swHSjYE2IDnJnUgAHpKQdTBMk+klWdIAvn/AzuT8HLR0kQJdmWF9ibVp33Bnk7YNAV7b8qw8mFJoUFmLEOMJnUw4tLAJ2bSbsk36njD3AW5HV+YtaoGbWwMVQUI1wgNKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+pqMI1j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbcd71012so4076965ad.3;
        Wed, 16 Oct 2024 19:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729130828; x=1729735628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iCKLUisoAifEvpM04td+f/cHzG6MtlISMkh2YpMB3M=;
        b=R+pqMI1jHqk9sagMD0SXtt3A9mjf47EDvwXKCYjaeTfeU5w2vPWQ0o1T6tIt/awNZm
         8rflw6NYIkFApFZg4lIH/duE9cQ+yarov7DsATQ8g55+QbkEunAV4n/tS0zXTAN0kqs6
         Q9JLHFpVgrhBWlg7DNVRPYq06DBuKXfINVQSC7SVniGYCPh5G80owPnpAPt6M/NdvJRQ
         riL+tI7jfzoXGpAKUU+kDejGxjBnlHmvKOIMefqj0lnXh5A3eb8hgCPtDkPvdMO5dxhh
         kqra2Ybv27dhEv8XHG+LCVYR4f5+lbQajGSaYil1RDzQS4m0+qixoAuvpZRt5Kn/A1RR
         FI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130828; x=1729735628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iCKLUisoAifEvpM04td+f/cHzG6MtlISMkh2YpMB3M=;
        b=YobEiux/wxQJccQcvhuv5TjSUMAyOXhgDBYITC4J0fCBLxE3BUYWMJ9U5d5PB0O0A6
         IUBBN2xVkAi8fXsrHP7YJavBUSkoaxDyEiC6K8ko30u+nsSGX+ivA0AXok16ursKxQRT
         6YtxAVJo8tWuMc+PvFD3FjJUT1H5EZBpAjlicXTcZK5zHF8/tI0Yhkn7+n3x2MG6gss+
         iSQI21GfQWfNjnen9gWudt+lYurQQWBh674B2Sp9iwJV9xdgF/YAXBmrtZga7EHqgtPC
         ajTNZGzUGlHSxGuSYW7Ovph4VZ/EA8aGNEcmwwLpWGzvZAYrseyPIOStz8+Ogx/WE8dc
         xkqw==
X-Forwarded-Encrypted: i=1; AJvYcCWgb8ciPdiYZGzJodIbas8e0YDc/gQ9SvPWuaeBbN6zDUdCalDfLFMgfnoPGqTZz7XtSb0v3ZTEhXBpPq6g@vger.kernel.org, AJvYcCXTgQD6ycCggiw3rjKJORBpEVcNt2T64msiyzbrdfEpzZzE2qFPy+aTm0oKI12sUabMwVonmiQn6WJj@vger.kernel.org, AJvYcCXYrpwtXFKdjkAgMiAXldBdJhi3h4LDKreOhFTJDa283/OAnSR5zgPYX0gJp5Uzf1tjWME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3MBppPNCwSFmDmDWzl53cJpUyQKcGG8El9rXTaI5XDG8Y7fN
	obiQr3ZtdMaofytgD1Tkh9q0GyBhszYqebAkZSpS+yD9jDc1N/BLJf8XLggTRoA=
X-Google-Smtp-Source: AGHT+IH8fYeJPsFWMnhDriYvegqE4QYm5mP/9UxGP9jvwBRKWAaWB6e272bXsdk5KFBueqfDqzn8dQ==
X-Received: by 2002:a17:903:32c1:b0:20c:9d79:cf82 with SMTP id d9443c01a7336-20cbb2af58dmr215818485ad.58.1729130828441;
        Wed, 16 Oct 2024 19:07:08 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c868ef6sm3343225a12.65.2024.10.16.19.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:07:08 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCHv2 net-next 2/3] bonding: use correct return value
Date: Thu, 17 Oct 2024 02:06:37 +0000
Message-ID: <20241017020638.6905-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017020638.6905-1-liuhangbin@gmail.com>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a slave already has an XDP program loaded, the correct return value
should be -EEXIST instead of -EOPNOTSUPP.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index f0f76b6ac8be..6887a867fe8b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		if (dev_xdp_prog_count(slave_dev) > 0) {
 			SLAVE_NL_ERR(dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
-			err = -EOPNOTSUPP;
+			err = -EEXIST;
 			goto err;
 		}
 
-- 
2.46.0


