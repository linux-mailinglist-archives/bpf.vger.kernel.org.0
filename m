Return-Path: <bpf+bounces-42144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027FA99FF44
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 05:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B542D285FEB
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 03:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D917BEC7;
	Wed, 16 Oct 2024 03:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsQNWSoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BBB4204D;
	Wed, 16 Oct 2024 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048640; cv=none; b=FVKODkvKTTrguMhU+TU7XPF+dQdc/2cq7Ntxr1TH3SvdZzjYldqSgduUE9P2KJz+mfT3NLj5Fu5A8BN61YRNWpae1XVypnAVc6NoiEwcwsqm4OTRGnWKZHBVdmLvQLWRF28QbHvWaouWjXhq4udG7IkjALKjglnpolq46JpoH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048640; c=relaxed/simple;
	bh=vh1dFbc7x6vrVDPy+BjwaS0MMNLkaIVZv8Aou7KgSgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnNjFikOMBvJVEvaQQ4siyWD8Np0BkZ4kU/IK6SLatiJ8Hx0nHUev1Yfz1ej5g9xnnhBKuPAU07TcOQnBq09j/MFfwSeVF1gf1IuQJiLpG41VM7YicUT5CcuaYL68ilNKQbiQtj1XJMQP5ciwaEEkItAySvLdWvaU22WjfVEwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsQNWSoh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so49506305ad.2;
        Tue, 15 Oct 2024 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729048638; x=1729653438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpYzvDQhnwNP9kxmh9fTljbaZysRMd8pIZ9gwHK1rBQ=;
        b=GsQNWSohGGpubP1LkLE04Qf7SBH+IXZHKbfYW+39iglbXWT1QQsIHtw7nR8Gcv6iVJ
         33jR7rPI4impN65kPiaUsxv0KnzW13oyygPoH0Qze9Pcj1b9eY0zasNsSCE2C2KgIHJp
         HrH4Ga9nQIC/Wn/4EkqSY23Teg+/FC/IwZoO9/28ORtNy9jCDY1upNRyenmWxWdRPzVC
         8+SX6ZS6LGR2YDadQSCLipCGyFjAknGfroSOrV/AO7PJJbBRF8O3fpWkOmUnpdorPJLT
         JsEAO9I1aJlwAzDzvDP/VeYjESYj5yZHg1uaT7mICiFQzsGH90rjx4JsT0d0wyeOFMWm
         Rf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729048639; x=1729653439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpYzvDQhnwNP9kxmh9fTljbaZysRMd8pIZ9gwHK1rBQ=;
        b=Y74pLqMP2Jr79ugY92mvBzlzHlAL+ef4Pro+w/6pEzEXj1BFoQWwK3Fuqy4ke9eTbD
         8GfpogD3WiqJk6h2cGYXLQSNJkZDuNwl6AE6mXWzw66z2DyW3Ze0IxKY9E3eZWWvGzVJ
         QZ4QXh3aS8dx1aQBKp1yVSGEMdi2vfrvCXlsPSSoVbIbFmAi/rxYFyQqQ/ZI+kbx5BXD
         FHsT8nEMo9cYIseHH71BgMuwdOdTPK7LKimSJJe2LW4lNSGNY1hJVbofutaUF6wYw+uP
         d/R2h9GquKnn6QjGcU0rHfq52dT/H/M6nHoYQyV+I7v8ksJq163+heCBbE5onFkthsll
         c8RA==
X-Forwarded-Encrypted: i=1; AJvYcCW87RIE7mRMUW+2izYcSmmJw+q2Kv7GwVbIQbua/ZyI14aJe0cJOoHlEbUw4ZmgzyIsxtkJhEmnIHaIAvuV@vger.kernel.org, AJvYcCXFX/1H9AcQ2rK1sS6vYsNQAITn05gAw0NgnSaqMYoJHm92sf+GqGSfr5mv4QpXBVwQWd1lEz3E36Zc@vger.kernel.org, AJvYcCXH90sP8wAaQ721PvjoqQP540n6iQHcM4uEinEN2zJCdkmcq4bqv+Rghab3VdIRRjPdQNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cruOzbKUYSBJGh6PfinaYn/EtvdpO4ekUyA8sw3nZwIGVjn5
	DVjWveifU0cpScYCuBXBgscOBWLIgp4aybOVoz7bavs5E+zh8DYdkGzETRAm/to=
X-Google-Smtp-Source: AGHT+IEokm1iHPDGyXWKqqEwK7RxI2yY7ngJrnA/gnkvoxeLeXpbXd4wOfO3EMdtDJ/5zCFQAyokKg==
X-Received: by 2002:a17:902:dace:b0:20b:a5b5:b89 with SMTP id d9443c01a7336-20d27eeaba2mr32278775ad.35.1729048638520;
        Tue, 15 Oct 2024 20:17:18 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d38efsm2252069a12.46.2024.10.15.20.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:17:18 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] Documentation: bonding: add XDP support explanation
Date: Wed, 16 Oct 2024 03:16:49 +0000
Message-ID: <20241016031649.880-4-liuhangbin@gmail.com>
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

Add document about which modes have native XDP support.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bonding.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index e774b48de9f5..6a1a6293dd3a 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
 then restore the MAC addresses that the slaves had before they were
 enslaved.
 
+9.  What modes does bonding have native XDP support?
+----------------------------------------------------
+
+Currently, native XDP is supported only in the following bonding modes:
+  * balance-rr (0)
+  * active-backup (1)
+  * balance-xor (2)
+  * 802.3ad (4)
+
+Note that the vlan+srcmac hash policy is not supported with native XDP.
+For other bonding modes, the XDP program must be loaded in generic mode.
+
 16. Resources and Links
 =======================
 
-- 
2.46.0


