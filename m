Return-Path: <bpf+bounces-29406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC28C1B99
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D831282C1E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE86142E74;
	Fri, 10 May 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWkOa3oc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D50142E65
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299930; cv=none; b=d34tky+11fA5gxUG/WxUa7jaPla47ey4bEJuTy/4P9LEECJvKO+TEN1wsaunUxTfTyktzwMIfAh8xpAG+SsarsRX6yxn8GWsKABEIqCkkf0s0euptR5eB3hWuk8g5hde8sww+Fqu+FWjTS7zc+06bJhMd6GlWDikXevVbk/qpIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299930; c=relaxed/simple;
	bh=bCVhh8pEHF5ZqnCfhVzfgmGYze128EdwiIeM3B3No2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iqREtajVPKeuvb0fJgz6YhnDCP2HoewirH+ielknvDCd3QIX5ojXvKDE+OczfWS4ZD2oa6z2v2MPEVoQ3QzzmNMj/BH8mO9YK0lJnxPia3HxT0KNEGH45i8Cx2pXudbiOWp+vDcRbV4xMYX8UWJC1xv5P0dzpfaKsCyXR1TxV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWkOa3oc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46acb3537so1038199b3a.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299928; x=1715904728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRjTqL5jZBxzwk8RtqE4pMuTf8/KsRch8ACUgOLR1L4=;
        b=lWkOa3ocYSax8JLtAHNoYDrrJetns+4YcpbF+S+4+H0217kzf8AebuMk1hAvOIDe8u
         RPYdrwyYVADQjqQoPjQC8zC5b/kHdazbiBBsWqUFPws0r/tbDylGTQ5fwvoRAQRQUaNN
         7LFfm3qlj3bPJJvZKR4ArsjjZrnBB7xIn66XNoT6OmD43sjGkO5TtINc2un+vf1JSV5I
         NjOdSuzF2tjI+YrGfjjJUejJttzPuUlClL46QsCnYmBhNZgdNURjw7EBg5UU17LN1+Fo
         CoGUFPNBlwvrGaoP/R6XdA9ThVUT2rDJWc6aq8KjCxa0m8+YL5mzuEnFOLegVZ0bu9bj
         Euzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299928; x=1715904728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRjTqL5jZBxzwk8RtqE4pMuTf8/KsRch8ACUgOLR1L4=;
        b=tYbvVcHdbTEuHRXHhuCSGdCFYSo5Q6cYJgl7OvVgrkDkrZXTBwUfzltCQ2Ft74lTTP
         AofpGHjfs3ysXIWKfAj7ahiX9kIbtEkr8xwN3IHV6LyBT//aLD7+84nNx2bnO79gDahn
         5fv12U6AhRjaerhZtk14XerqszU/DLoA3oHJb8LVJIcPh2X0EQRJf9++AgI+iOmCxiQb
         mLJFGL632c+hyk8+eu6NFJn4JUj9NmrQNWZq6euKuGKA37nmznRV2d2PmbcqctmECnTX
         wY1yPkuPuOHJN7eZb9g3rqkhfeoSHAKWpnuzufrzjHuOFe7X/mAYqEhkHndCC2gYKwcR
         A+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVuStoPd4rX9p2PSDkd6aq5Kz9ofc+hbB4vUFeSMzPNiSrGAUg0DtZ6leyRSN1rcPWPb/0cGGBaX4I1P23EzjpMaLUf
X-Gm-Message-State: AOJu0YyqnPCaYeVNkOdLmc5nF2dTWqao99ONUXVW84reJc3TprMPBZVC
	2Fa5NBaJCG7QzaIofm+oiFxq3OpWahH/4uoXIXg+THWXJgwJlrOKRS7Bc3DJjskO4J8EHttI/Dv
	dcQ==
X-Google-Smtp-Source: AGHT+IGSF9WzQWuvr2wMEGyozUQO7K9UVp16MtXq9kPeGzg8zdiMSf7txQHGnyzqkIc1hkialPRFYFdBrZE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:8c82:b0:6ea:df4b:86d0 with SMTP id
 d2e1a72fcca58-6f4c91f346dmr13199b3a.2.1715299928188; Thu, 09 May 2024
 17:12:08 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:22 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-66-edliaw@google.com>
Subject: [PATCH v4 65/66] selftests/wireguard: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/wireguard/qemu/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index 3e49924dd77e..08113f3c6189 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
-
-#define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


