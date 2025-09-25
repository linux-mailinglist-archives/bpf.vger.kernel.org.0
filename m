Return-Path: <bpf+bounces-69750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75391BA0B92
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FA03A45AD
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B171A306B15;
	Thu, 25 Sep 2025 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/UgMLe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787853081A9
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819617; cv=none; b=sDO+gIONqGYpE0RfGuyP+P21/3G9WBc2ArW5fK4sZFO1q3dl6/oJHGPBezULk4yea2s1vYYchSnZvhAhzZpeijoOhLBdBdoolyOJpi9Esfez2IofqJtc6TCiEuhsvfAPHO4QQmD6nsw6P9mJKIyAZJWEMkuReJM8wVRZOzeKL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819617; c=relaxed/simple;
	bh=SPvutgf/0wlSxzU/BGGR07xozaCO3CWXty8/w3Fcp54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VcOXKjSK3on/KXC76RT7dkmADIc1eUIcTGZhBLR8HcvELOof03Z6KZGG7cFP6Iz5UcPcl340v8dNcwxg4BqSslAysbdWL8ZuAVR67mjnI1Huj9MrjHeDEIYUntNIwJIwqajaxMiIKxlW0oUoQabBIdxxCM/tzISE/T7BOdI1HH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/UgMLe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26a0a694ea8so11423295ad.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758819614; x=1759424414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyDMrFJ10ozuZKJidiIpM+48MXCub922AW0orXQAw94=;
        b=dJ/UgMLesl4e/UR6ScLdpZmcKEUnIPFFeato/M0guf6lPfmPXEfaSmu9xFKz4ua5KG
         PrpbYqP9w6vvezHHoaRToOj7q3imKLy8bK5X7VN/WXLrfyrgTrlsUhA7faG3GIkorQWq
         w0HDyDgwyQIKFuInD/hb5e44TqxUAfo+7wtcNxKS6X633PcloZS51BRatf3uoC/sR529
         svPDukhNNTIQe7WUStYgrVfLodgn/C6gKcc/65HMyKzLs2u6zbpAB9RfbUzHQ+ohe41o
         3s32zzkVV0rhzMQ5PScijs4ToGUTaWJpApGRvUH7wjQ5EBI784bNQdjqT2lZKJgBYsx4
         0daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819614; x=1759424414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyDMrFJ10ozuZKJidiIpM+48MXCub922AW0orXQAw94=;
        b=GAen8J+64eeko9JqZ8xSTLRgeXc8kftqzQADRZOLQY/3iwsR44Cfgl+4BpDevqqZNw
         U39NGFfbI9PqRgPrCoeTgabOTZnJHyzGqEIM3GRcjXK9xZwr4hCWRzfZTeXHNJhlBwWv
         2rhkObPOJUFkIIqY4T/P0r8uR06HDt+apZVi9PSX7UcZxs2+EXVLU6RAu6y870STM11B
         FediQ/C7picgm3v5kT8dmll+q2lqyKUqwbEYPoAFy7w2EyYzAW63CpiYSIuGxripoPpF
         oyy0Pd4b4vDX7rKZJBtTi21imljn6unnzrkP9pr7gXSX0yx9f4sVvK6TybpMsPwn6OMz
         WoIw==
X-Gm-Message-State: AOJu0YyjmfwH1C0j4xIsiugvlWM1x4vDcG4vyIFPP8JKtXGBlNm+47ca
	vDhwTpByivT7NaY3go9ue9AKZUc62elWZwVwwwjlc24tTC94IkTGmkzCq5Ir8A==
X-Gm-Gg: ASbGncuuhQkRQW0kXLMlsTvzCXj4wvgDnfGhz3Q77MlYfSbb8ps3/HXPgmwWLDnW4/9
	S+WA/yw76YsB4nNQHXUFaG8Jxg5VlnjwLM1ZBl3e2zgtC/ccc9aXqRdSYhkDl8VIz5JrjIC/8JW
	l+p0LoXqhszayv62Vn+xDnK5vulwYbYALb9Fjh8KDMsMMO/NUNhUDiL6PjN5Hivgx97lHmGv3JH
	EJzc+b7gHDPsOA1JrrTt9E72Czm/bOvyaoMo4D/f/wbzrqMgS17lPputZy9V/3saNiBAOZpV2c0
	WJ2gbmlTsyAeKGbJGONln0SwgZ5T1rdtKINEahwk2m63C/jLl0ONFg9iVg7Qkn5qwpVEjL1Ntq6
	gSlhLtRzrOxhOYTt01UuTmTA=
X-Google-Smtp-Source: AGHT+IECup8tv/RPmEj9LeHqIi9Nezmq0eALAm1L5tBiIgzTFrtGP33k18mujwoJhJTZsvz//a8CCQ==
X-Received: by 2002:a17:903:3d0e:b0:269:6e73:b90a with SMTP id d9443c01a7336-27ed49d0298mr42964225ad.15.1758819614292;
        Thu, 25 Sep 2025 10:00:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69beeafsm29744395ad.126.2025.09.25.10.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 10:00:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/2] bpf: Emit struct bpf_xdp_sock type in vmlinux BTF
Date: Thu, 25 Sep 2025 10:00:12 -0700
Message-ID: <20250925170013.1752561-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to other BPF UAPI struct, force emit BTF of struct bpf_xdp_sock
so that it is defined in vmlinux.h.

In a later patch, a selftest will use vmlinux.h to get the definition of
struct bpf_xdp_sock instead of bpf.h.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b20d59bb19b8..2af0a5f1d748 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7439,6 +7439,8 @@ u32 bpf_xdp_sock_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(struct xdp_sock, FIELD)); \
 	} while (0)
 
+	BTF_TYPE_EMIT(struct bpf_xdp_sock);
+
 	switch (si->off) {
 	case offsetof(struct bpf_xdp_sock, queue_id):
 		BPF_XDP_SOCK_GET(queue_id);
-- 
2.47.3


