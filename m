Return-Path: <bpf+bounces-42265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4F9A1865
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6722D1C252EB
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B416F06D;
	Thu, 17 Oct 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsFSMool"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A91F16B;
	Thu, 17 Oct 2024 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130825; cv=none; b=A4RHgDfcBpQ4PRB/F846CvnDTZ6G0jZlyQbbMJ4nJtX5p+kiW2GRlXm6MlwnP+u7ZaEfarvRVJ6DK3XkbfgSX3HyZu7sM0Sow+Xk9WCU8op2svgATUE9anxnXtkIHpHrfmQ0NdPFLzn+HNP+e9JxnPihjDSw+hwAEV4goPuzYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130825; c=relaxed/simple;
	bh=dMmiM5MqFOe4YenaLoMKJ75vdQmoMXijc1eqvmoL9aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrBIB+5k0ahf1igFooC7ZaEmNmcsZfrZ7UAjejCpmWrvp4M4SZS+ifwkx/h6rP22DpL414TvS2B5BvOdhVkqqJeO22e3M9T3RYnUJAn4DidqaZZWecLnvMEJyE+D+t7FV0jPflwYWwUaN586YTF5UMSdynNHeaLFDcmvortfUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsFSMool; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso279164a12.1;
        Wed, 16 Oct 2024 19:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729130822; x=1729735622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXwhn/Akck4TY2SECOzkvt4kvX/uUN/prTBlY3O1OVs=;
        b=JsFSMoolnJPn0YU4tLkTiH8V8v1G/FVUuCLVK7lWj5rm20iuCuqAjWgheIJuushIaD
         IMMx99dd5qZ/JqOq4634R46geSWU/o1ARDk/M6cVLRqOWEStdW1VeEiEDJ1AtOeUovjp
         GhImP4HGBDeHZ3q8Y41Z+6teGr49UHPM1+mJYg01hn95o+siMBbXaWyRecoaHMuxhJdi
         2RImJlmJmbhUlQ0Y9GGfHAQOUfz/WHyHNDxG7Kg64J/C712pYgwMHy57dV6XrDVc2Jfj
         gF+jJxg+8p+DxUv98/5Lsg0JPFVHCdc7yw+3H3+38K9Oi0wI7R2B5rJToCP1I0W6H6C6
         +8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130822; x=1729735622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXwhn/Akck4TY2SECOzkvt4kvX/uUN/prTBlY3O1OVs=;
        b=LJgsuJwbVjQQ9ihm1E2urz//XXrYgfT5ss6yjpG+B8zlQsHdhAoAlsqjHeRs0Vqhbo
         MQ1AaQAxAiPka6kav7wY7i21Ngq/qCahU6uBGs1xc2iJ3zxFP4Qg3kDsCd/so3o7Pswi
         Z07WUympmGg5Ocr1l6CqcDVfy3YLVTvrLfhb7qloMeLcWGuld91AUZnuKApXIVqGgfvE
         eRmIjrUnlxN/e6lkTRlMSoixZurxm30d9G34Siey2oaKaONcZEjLiYQ9lkqDawC3g9as
         96mOjejlKBXBseYrxJLbghg+D8nW4wvs1okJ9MlAj3kLtHny8Uw/vPTVOeEpvWr8Re7E
         ASXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcNxGuBar1n0s5GA+/4JuhYmr5grIjphieeUS2/GAgdYlWYyXXHJXpYBE/phF3NcFAm5c=@vger.kernel.org, AJvYcCX0HjExiqNLJofBJyZHFAfkYS/e9A/Gb9tqPE/aRX/wVZ02smz+sBtoyG8lTt76zITA+JFA3iAKuTL4B6qY@vger.kernel.org, AJvYcCXvmgWlIArVOuYxW+Uzrj45vEcb8T+l84WlqQvvqALyMdeBvjU1/MnYITgfMZBQPM/JbaLqM3hqn36R@vger.kernel.org
X-Gm-Message-State: AOJu0YyrgoR/vfHauR3gxKLNzbdYFcowU8dhhwItfCdOwbT1YuT0jh9o
	8J7cVWgk8ZLAX0gWIyM/5P2PhtqVUXkIFV4GPaqCa4AeYjIuHvcU6RWfAF9MnnQ=
X-Google-Smtp-Source: AGHT+IHJMIvufmvV9n43VlBMS5SO43jhbf5L+U6H7rNLnMyM6ytxt2D0IVQS1NM4FA2yuo8j6S3FvQ==
X-Received: by 2002:a05:6a20:3944:b0:1ce:d403:612d with SMTP id adf61e73a8af0-1d91c6b6e8emr2081270637.13.1729130822111;
        Wed, 16 Oct 2024 19:07:02 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c868ef6sm3343225a12.65.2024.10.16.19.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:07:01 -0700 (PDT)
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
Subject: [PATCHv2 net-next 1/3] bonding: return detailed error when loading native XDP fails
Date: Thu, 17 Oct 2024 02:06:36 +0000
Message-ID: <20241017020638.6905-2-liuhangbin@gmail.com>
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

Bonding only supports native XDP for specific modes, which can lead to
confusion for users regarding why XDP loads successfully at times and
fails at others. This patch enhances error handling by returning detailed
error messages, providing users with clearer insights into the specific
reasons for the failure when loading native XDP.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


