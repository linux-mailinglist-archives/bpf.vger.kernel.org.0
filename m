Return-Path: <bpf+bounces-60175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71BCAD386D
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA641899E91
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736342D4B42;
	Tue, 10 Jun 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JicdaJHj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD92D3A6D;
	Tue, 10 Jun 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560405; cv=none; b=jCmhIxeYQ1ScsDDa6AcKRVNvzN40WawTw9rIqNemtHJeC0+dG3NHyGv5/JclvNvJ/vjS24JTKiAmcA92qetf42OrWptrrRoYBubiy8ZZBlauoQuLZ+H24DeH/+kMqbZRD3srZ2Hnd1pgURaLmCY/wxx73Zc0Ugb6IIcHFxrX/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560405; c=relaxed/simple;
	bh=Fle9/5/Kw6s4JzhtO4dO+lRTtSR28VmEFpyBncawRsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSYpM/TEJiY+5ppAwLmR7KL/Y3vTnUOobbMd8BGYJjXC4IPqrvT8aBGMIYwM5i3AP1ehKbyDcyCIBHBySPAbRxeIaYNJ5wuzsE2u4SHZQBRHysbWN7MDNMEprLqW1xWGqcBdoJbAHaZX4Gh69RxKwvvOY05GbAJnNjaO7SYLzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JicdaJHj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so48426155e9.3;
        Tue, 10 Jun 2025 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560401; x=1750165201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzoV36DGLFEr0TlLZ7ZuNJ5ZvgQ7mL/O4zsxTiHx7SQ=;
        b=JicdaJHjzThoSZKSUHWBzym2Pdz3gc7AOX1Me3PqloQjwaoJBW0tUkOLriIRh7jmoJ
         pG9UuH9lm7itdg00NbmyeAPn5RCuxBuzAgyksGtlGieetj1SLAJVrhGVDZMCTDcViAgc
         bh1tdAhJEoBZfjWyVXMoHZ9rARhyKaH8xaHpTYhxx0WS4HR4c0EWhGuFNoSRso7S4lnK
         oXoz1RjWzTIFa0iQ276U0SDaWBRdjlH99K/8rS+kIGBRnPZShvyErUwskkMlF738izIV
         i7RLS/0Vt6ZtbY3eQEBnWKvZO1YmezdKYtw8/OymZkJf2UxnOKnOHS/hP6bQfTpJ/str
         AJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560401; x=1750165201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzoV36DGLFEr0TlLZ7ZuNJ5ZvgQ7mL/O4zsxTiHx7SQ=;
        b=Ev7KwsFUPBRkCbUNmjxB1i9Pwc2vODnL0rD1Ub4bkArqnesC20HOExGavp2d6gSRrq
         ZtRQrAlL3UUQhhyQQU/YIL+h6NPO2YCnHk3g0fR83gFQghKweZ62c+OcQSu8UD2LJWWx
         4GOx5fvpadrUiFz9uG5nI67hAOwr0NXKNW1XTHbHJf/ArjjgblFHC5oaKUZXx7Do2UMl
         o+QchAXn2KKX7gI9X8CcvSSItpoKCCh89oVgsDf+NTYOFe9iSpksf7rjCV2eafgGwXgU
         Bgmd5h9BMVMc+0dBYe7/tCkcM3e4xbMtFT3lWeoWQ6BVzeMThqCYJLfD34As5Bv5DLgN
         iciA==
X-Forwarded-Encrypted: i=1; AJvYcCXznbJ381jwD2ZTVDx+Oc6K9ac/DTHor/hM83DwkfBESFs5oGLEW+bs6JXgPcBVqxUr2h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeNsN0Q2bPBEP3+RsdgpHg2oOBQHkjfJxWlRe1VKKSPG+H1E2
	ZvzFAsmDITMq1nkIMqYjkReBJ69kDIBgaBrWnItGvtAk5iWCDjYsdAjYFMwPwA==
X-Gm-Gg: ASbGnct9WHa7OXmIw4+hCt9HTX9xZg8uY1ckcsXOxdz8A8f1MmGM7i83LDwLo0f+UPj
	zFMYNXDR46g4GiV0LhOAYVQQmZSQrqWI1v6zJ9phAQgM8o2ZX5XNKQhlzmVW3wwapZXpqrM+p7h
	esPpHnWSW+3Mwp3IPWL7v1APHcaMHz7lWRSyeSgTXqc+N12qZQ+lGxI1tYGWuwky7bUg2M7CgdG
	G6n+d42y6HbAGUH0YLJJJ+ot/orx6+MAEtHFINuuy7FZcaU2eGuggz5tFVw1FcnnnnQ8hOqQvM2
	LZFflyMw3jhk8RcTe4j4d/FgHUP0I5rVKzu7tSoSNL/+SRgYIZ03uvlZkf//0i0Mtpx8ziGWcFc
	AUOSDMgxU3BJveRA=
X-Google-Smtp-Source: AGHT+IHeslDW7TrDYFjTLS1WUYy8KcNXu0a/5bqFGKYi1tTcyCUMUHXRhABodi53HlW4wRTg2Az3ZA==
X-Received: by 2002:a05:600c:1c8b:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-45201294a71mr163375615e9.0.1749560400829;
        Tue, 10 Jun 2025 06:00:00 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 4/7] netlink: specs: fix up truthy values
Date: Tue, 10 Jun 2025 13:59:41 +0100
Message-ID: <20250610125944.85265-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up all truthy value warnings reported by yamllint in the
netlink specs:

    warning  truthy value should be one of [false, true]  (truthy)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml | 8 ++++----
 Documentation/netlink/specs/nl80211.yaml | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c3534e7e063e..939e7e12fe30 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -744,7 +744,7 @@ attribute-sets:
         name: flash-update-overwrite-mask
         type: bitfield32
         enum: flash-overwrite
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: reload-action
         type: u8
@@ -753,12 +753,12 @@ attribute-sets:
         name: reload-actions-performed
         type: bitfield32
         enum: reload-action
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: reload-limits
         type: bitfield32
         enum: reload-action
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: dev-stats
         type: nest
@@ -917,7 +917,7 @@ attribute-sets:
         name: caps
         type: bitfield32
         enum: port-fn-attr-cap
-        enum-as-flags: True
+        enum-as-flags: true
 
   -
     name: dl-dpipe-tables
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index ba0601474eff..55555038759f 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -680,7 +680,7 @@ attribute-sets:
         name: feature-flags
         type: u32
         enum: feature-flags
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: probe-resp-offload
         type: u32
-- 
2.49.0


