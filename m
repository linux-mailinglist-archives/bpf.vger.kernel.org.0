Return-Path: <bpf+bounces-42143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBAC99FF40
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 05:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AAF1F22602
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692E187FFE;
	Wed, 16 Oct 2024 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiYL/9DK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AD4204D;
	Wed, 16 Oct 2024 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048635; cv=none; b=XeRKVMjg4Yr4imBEFqHH3dtxlSStXwkwoHk2gLGGD/emdfDDWnfinSSqqQix1h6jtXdmF1pGLgZLBr8/obpwI/bKZJ0fA/Tgh2psxBaDH5b32PG3S8mDnwvLUTz0CmiefdsSqNc+2iamCn5K3zk6HPZDBF6URaGXkSjQ7OvwVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048635; c=relaxed/simple;
	bh=thdANUtqaaKiyMVhV/djgOt5d4lw4emq9W/Om171bsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBDq5zJr9zW8vZrPtPdmGqlc9SOiPHhokKrheTXeUOCsEKPr3tk5hESJLV13qrWKJNolB/UUfXp/1yLx28PKWyWeAAIj7V6dm83NFRpLZ8sVNJHrFflGW1s43UQgjgpYIBa23ljGw9NhlfmytbeRiq5HTZnnCotqj20hPJUPv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiYL/9DK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5298461a12.2;
        Tue, 15 Oct 2024 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729048633; x=1729653433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07dGghuwhdp7zbjQZqkHSTauXgxJT3fLEpvu2LI9bFw=;
        b=kiYL/9DKx5jkDx2L1fU9EfkGa47Qt+UYj2BG2+SER+wz0hHNEe3+EJovZLh1gdEMr2
         J79Nui4soOuQCF0ItqjKD5VprzmBsalEUDWmExGOe+P9T7omHJ0BZ64z/fkYQntWPIfi
         vPqxAsIuD5lApNhrpeULYTnsLVh4wNXj1hquZjyD597mGyz86UTqYgxIHPd/zyOQdAHR
         eBv7P7O/YPHn3G9/HqTnXgBkjkreJDXkzsPEMkZ3JmSOgiKzAqGl020KtOCVvgC0w4Jh
         +vTwiuo25PyoBsssx9aWoJwsGU/PX3MXW9As4ViX8iZo3/NmfDFlGb6HyeVlRSZrrCI8
         3MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729048633; x=1729653433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07dGghuwhdp7zbjQZqkHSTauXgxJT3fLEpvu2LI9bFw=;
        b=D6LTZjWWax6/LMZY0+OAbKZrpyC2+VtBzyeAJ4Xk36a3B0L9TJW/qDcdBMoPtlDBHW
         BiV1oNgzxS6PSPUkQIkNMw5XDgoo/UZ7YVe+nFSuVGRHfHMvJhkjV4WviPv6FRklmNeU
         YlZBDMczg65yqRMi1Sv+UrKqCvZ0n/gQmEb8LboXO+HpJLcefUTdGWHjYk7qKL/ywh3w
         DERx4kiLTZElXhUi3/ZnAyGCHBgYgS21+agKqDoQEI7aq2pT8SVWPebEHPZyn1ZS7Bv3
         T+2gyTIwZ5970OFDQ7V3zzpP5iAYuE0yeCLylCzgouZ4czk9j7blCHCDo1j5t7u3cfvA
         Wx3A==
X-Forwarded-Encrypted: i=1; AJvYcCU9GRLv9Lp30Tlvq4fpusul7t46CduwG14v+TWrvyK5ywmU/MyZbWlr/f5qysybcicViIv6YV/ULCeF@vger.kernel.org, AJvYcCUSww4KTOoMYEsOh+9yLSU4aY4x/Ksk0TpuRDMbQO77kRLYF17CYaVlJSWCrSfFwcCCahzI0jJSJh+8HuTd@vger.kernel.org, AJvYcCW0PBVbLan9XnDbP1pPCbXjhfDqxT/kA5fW7eunzPDW4PCfJTnoqSIA5xL81MPh58ws0do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFcNP3hUO7p+V9YqS2Qv1ceE6T7ZxtF2Vu5H8ao4Wljsfh4Df
	gQy8LdjZgJ2eebwScpqMeQhpjXJlOyIM95OTfUyeShxtMyZo+J9hR0q5Z+VfGhA=
X-Google-Smtp-Source: AGHT+IENF5jzncVEfg2fyzO5DWpCAtXM8I9x2aGfawiLEuC+qVe4mG07VWCBDZDe5GUkVDm5qWKErA==
X-Received: by 2002:a05:6a21:a24c:b0:1d8:a267:b06c with SMTP id adf61e73a8af0-1d905ec024fmr3198736637.18.1729048632721;
        Tue, 15 Oct 2024 20:17:12 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d38efsm2252069a12.46.2024.10.15.20.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:17:12 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] bonding: use correct return value
Date: Wed, 16 Oct 2024 03:16:48 +0000
Message-ID: <20241016031649.880-3-liuhangbin@gmail.com>
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

When a slave already has an XDP program loaded, the correct return value
should be -EEXIST instead of -EOPNOTSUPP.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
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


