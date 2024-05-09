Return-Path: <bpf+bounces-29249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE98C163D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE62281428
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3461369BA;
	Thu,  9 May 2024 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ1i/hQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001913666F
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284905; cv=none; b=IIW5o60uAomXIiKYtMaQnQp+tV/Bj5FfmKLV0YPcYErzzL2ZJk7gMuMpgEquK7fwjFXlfCLg3afWN5mXO3vvDJVyEWw70WOyg1nymq5knnCpUZDqTyWA3ulUrhG6UYZf6laE3fpyWSUnxi96ZqgYGISI0I3Vxq4mvLux7FAUcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284905; c=relaxed/simple;
	bh=IwTjZ+QkHecjItm4ac17VTR49XMvagwZXgy5gGzNQGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yg5GqGyZafuaFFbYbcYy2F0LYm1p2nGJyYPmdfIJOrGuSGO9TV2f92zAqI9//BmSWXe18qRkHIYGj2Yek3WLCkrreeqOnRBl/9zUHq22TWBhn+k+pXVkz05bDGGhrfYaqA06SujUqImtLeiqPF9yGzt9/6MTnyYubH3n3eRVAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ1i/hQ3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de615257412so2188762276.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284902; x=1715889702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=hZ1i/hQ3iQYjcf2650k3wXoi0TtKjLrsTyOhLuuTzHrQfURK5hdVS4XfEvSiLsPFpM
         g/S2AeXQFJb0jMwwhSYRy/chnRePBxIJwgDq24ueEa/o5td+sslYBrmiBahvYan0jCWH
         pZlQZwu9URZtWSSo5/pvUZ8HFU8fe9aIYDYha369Y+elTzT0h8sRzFuLO4VkYAo1j+uD
         dfqa9H3Sn+OQbmG4Knz5s+MW+0xK6k6p5B9YviwXnlun2rOaQmPtHEQSbB4UTM/TV9Om
         m4fW35iF9TUfeacThNS5809727tL6HRWPgTYIqjM8PRkssbguoXYaokaJ5lRiuEQcIo+
         vOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284902; x=1715889702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=Qbfk4gDbvy0fYKonpIVvohgP6gw5LUMs6iCFBHryUS1ZAsWgFbL81ozzEetZ4MaPEG
         NV4i0rZXJ3OoY6lsQAwhysan6us18+h+7IsXUjs/Q9d5uwGI2w5QQIR5/MNWDr8Weogf
         5wqnyRXhFCGdZ4KRsCY8j51oa9KLU97r0n9Fo+cS47Dv2tXwWBxyVGHosg4LPCbPmSHs
         ojxem7jpt9mp9yD6hA0Aq316DBKi4SyqhIVEMN3Q6mvVDWXOTYEReplSCdPEeYq6iBhM
         cjy31/2EyJI7bptyTHya1YPfU/IHLq4NrEE+veto9otCzuWfvPn/xlpMxHI4ZjOQZZd0
         MeqA==
X-Forwarded-Encrypted: i=1; AJvYcCWrLtlW1rPfSA3Y5DVdBHbBh5KrFYOp6CqAhDSYUkUsR51IIM5v4tg98tPXk56NkvChxlBSotftPfERbFgj5Sh2wvNq
X-Gm-Message-State: AOJu0Ywh1qLqHQQeMFnAeYW5CV+GNmiWsJw70jtW/xANUHSH3A6xDNb/
	V0kcVdPbb7Y7HIQugj4TrSEsjSP7m6HQATxS2j9Bj5i+uCuV4GYm825ObWZwUZOAdTtI6RGmHyi
	FYQ==
X-Google-Smtp-Source: AGHT+IHyuWY5940dXI+8MYdK3cHUYO5oPq33T22zpT2ioJu3FvZMtTFAIbDVKX9sxGXi1YbC+ZrN2B4TRNI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a5b:182:0:b0:de5:4ed6:d3f3 with SMTP id
 3f1490d57ef6-dee4f2e03c0mr141982276.6.1715284901753; Thu, 09 May 2024
 13:01:41 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:11 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-20-edliaw@google.com>
Subject: [PATCH v3 19/68] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


