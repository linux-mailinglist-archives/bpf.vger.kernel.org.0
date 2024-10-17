Return-Path: <bpf+bounces-42267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F382B9A1870
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 04:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F374B25E30
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A34C62B;
	Thu, 17 Oct 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tja51A7Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14213B286;
	Thu, 17 Oct 2024 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130836; cv=none; b=Eor2sF2TjgvzsodPSaEFoXp4HLx0+6xLuSFc4wj+DudSsgcl3mzdARMJAafpsO6H5qG7rjnQcF1AjtBF2OF8tXjT58R5qanaA8UAhsYp7DJkdBjAee87tcoz6BuTq9nKcOsETMz9sqrgnQ+5XXnmLIQx8icv/pmH6sDjZ9wNYVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130836; c=relaxed/simple;
	bh=kWHMkhXoFbE4zr3LNeKQaz/w1kf90KGzTz5eV1SXGb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjXhY2PUbsaF5NKrdUuVo/GQ/K6ghEZuGdZqZsE5FAwILoIcgy/MepNbZdYKMdZL0qKlZFtxcUYWUsEadXheqZaIsnuVZPpJzFMKoIHJgHxOfCiuGz9elrQ/r5VqTd+cB9LOGiKlCh8Ld2BJ9pO3kiJo0RjgSbrVvbZs9lrMuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tja51A7Y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e57d89ffaso320897b3a.1;
        Wed, 16 Oct 2024 19:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729130834; x=1729735634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlKv0iAW/kK+YzP9Z5U8UE3V4EU3m7I9KuWjM6JEtBQ=;
        b=Tja51A7YqLPHyHAlihr9RTWti4RCK6yJGfgwDbabutX0LczeiwLJxxiDzdDkqzXfZg
         F/ntUjLfX9pKQFLf9AmKO7pTA4EdNWUjHfnxp/qRLWVLIxGBE6QEcH3vKEC0kODQwxeC
         f+YKyG71FqHErcJBsZQIgFxUIqZr0PyOPHzUSSvzuCLzbEP/UIuBTzK5PPkSlpv9/D7m
         05JagDTgQK1W1w6lD4YFARITfsa7fGQy1w/bcsyyzIf7AFt2HYj58J3MxKy9CkDuD9YI
         QSTkiRR7kg9lxWvoHgW0OZm8DH6iu/b1HpM/HJWtCbcyBjetRGLmedlO56EVu9xs2Uqj
         5NLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729130834; x=1729735634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlKv0iAW/kK+YzP9Z5U8UE3V4EU3m7I9KuWjM6JEtBQ=;
        b=MV/ych3qs1uQpXPo/NZKhqFiw+fYWrbYdC1PD1Mcr0jMUARY9t4b4jfgC30GAWgTvm
         eGOIw4dn8ej0W1MABNNZbscC9Ct/N5in4piurIkbAdHUhp8jzlQSpQ9sfTg6FXn2K7SV
         jWSZveSyfbpc4Emhx/wWXUe8nKXoYVKf4nWTXwQ3dP6l/EkQ3wvSLqRF+nAlQtPrhOkp
         wOyw677SFrUCZMo4hcBCa9bpVqzAQ76U23CzwZix3HPwZbzbc1XhdQGUfTf1PXHFPYeF
         nulZfXJl174XdbcWOmsqUf43ilTVF4wFrnLQ1A8ckcUyIayGcIqnnRRO6LAU6oNczDNm
         oXng==
X-Forwarded-Encrypted: i=1; AJvYcCV8Q5fXeSDf71f/YTATK60pbnMatj9po2IPNbv2I4lzWDpH3FgBRXdPRKGir0f1ChWccTo=@vger.kernel.org, AJvYcCVzbFmFPdYH+akpA8tKLqxGxoYcYUGgSAfOWkCP5YwZ3Aul2085C17Ozh3fY/pKefN9UK5Y23fJcLtw@vger.kernel.org, AJvYcCWAks3HuOwB3w1ueECTutvX7cvtuCHWL4AtiFEFh+yjYrj2fzyBAts49jg8J5tcDbZI7jztV+z9xNXhUJB3@vger.kernel.org
X-Gm-Message-State: AOJu0YybRdphDUVZ5L1zX3hFjCB2DO+qPfnUKjrK6NzmPMP1LLYFqExd
	gu1YLJfisyaY2+vSeLJZXFjg9wY6UmK5SMqI/bwEzThAF/Xan8ou4+sSRYZ7SNw=
X-Google-Smtp-Source: AGHT+IFF8AOLqYg1TLhhDr0ve9D9Z/luocW4qHrkLB3OZqIC5lPqy4Em44Icdw5lqY9BHs2Kln/bJQ==
X-Received: by 2002:a05:6a00:4b53:b0:71e:44f6:6900 with SMTP id d2e1a72fcca58-71e44f66bc4mr26538922b3a.16.1729130834222;
        Wed, 16 Oct 2024 19:07:14 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c868ef6sm3343225a12.65.2024.10.16.19.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:07:14 -0700 (PDT)
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
Subject: [PATCHv2 net-next 3/3] Documentation: bonding: add XDP support explanation
Date: Thu, 17 Oct 2024 02:06:38 +0000
Message-ID: <20241017020638.6905-4-liuhangbin@gmail.com>
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

Add document about which modes have native XDP support.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e774b48de9f5..5c4a83005025 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
 then restore the MAC addresses that the slaves had before they were
 enslaved.
 
+9.  What bonding modes support native XDP?
+------------------------------------------
+
+Currently, only the following bonding modes support native XDP:
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


