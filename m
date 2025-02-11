Return-Path: <bpf+bounces-51137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81292A309CC
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DE63A4231
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58E1F7569;
	Tue, 11 Feb 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONGXSZVc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28391CEACB;
	Tue, 11 Feb 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272746; cv=none; b=kP1oVX75fCFBPEZpoA+b8T1t0nSUo8Xzo0Vv4I692Dcu2wwwiA9NJ5W8nEq1y/z1Z44OBby/tXwhgnPKz7kandI1bUZGhjkfoPn6VSWCRmyI2gKOFPJM2WxG+JrEDR5AZXxEwm6H0BHZdfOUCwN1SNcP122KI4MxQGeLguTgYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272746; c=relaxed/simple;
	bh=m90Uo35ohboEs5VBqY3BSSvXLDhE3Jh/m2Ly9HyGYIQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mUoN8oJtnOmGJqv8g9RvTksF9Sk/1ip8O0V8yS636yFfUXiIjY4yqkyZ/gnBACczvzzca8O2YFTl1E3cDXoG2IVMfYK9+S70IEECGOCBqxfXvvMBKA4sqeaQKulPGFbucVa/Agvg5OS2Ee4Ev5Gy+szWESY+nU71uksvRjC25cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONGXSZVc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f7f03d7c0so50703395ad.3;
        Tue, 11 Feb 2025 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739272744; x=1739877544; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq6lIc1bo9c0QqvPBAEag1o830/WQ7+wfRJEwYT/u6o=;
        b=ONGXSZVcdL1wYvHpCwLnTI9OEaHg4WUYKCQqESBNOXS8PrNBB15GN3y/6CtTZ1QUvJ
         oYbfJOw9oLuHRC594AZIHiiMCcT785Tc8ibueLbDfh8uqP42BouCIFKSkMeslJgXusLn
         8NfWlM7lyNqpiOVb/omgrX5CqP/C1doVBTkOLQfaqS5uBh0gujUrmw6+UPK3vhQhbFBA
         R6cURQWt7qysOLHBEvStAwTCn8cXttB4xvIYDdp79UQzleNvRYYVyzopMr1IKHZXxXNY
         XSnusO8kjtxsg2ouNQI9i4sN+Jxi1zxm0bwtZW3ILqAHvyMX9ClwEyKxSQGs6paRUwQw
         xAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272744; x=1739877544;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sq6lIc1bo9c0QqvPBAEag1o830/WQ7+wfRJEwYT/u6o=;
        b=piK5aQdNkoZWrW1qA8jwr5ODtYDalndF5MbksQgWOvGq7CM3LEogvZpI4r4LHzEcIB
         jt8h9MDQyUljgEeP7XXFNo4FEyZQUg039hhcCPNpCNkKMKfO3VIVBo1c/qBDo816mVxn
         LGWY1Y1avhz03lCgGyVhfnBnrPdtMhyqBdJL7F+EIZPtyal866xKbrk/8Fhi5wlJNeZ5
         55A7do5h0+wA1AhJLfWXCNK0jJu6V7PT/q54ebfw07tSb5sGnYKfTPQxo4phRAAQxBWo
         +Zu02RLcRxitooL5FVx6ZBEyk6wnTWCIRaZX1ZkzjY7Ku49prFr+Z0KU9f0Z2LmkzkRU
         UEsA==
X-Forwarded-Encrypted: i=1; AJvYcCWsCJwSlvLMpWJDmtUtdWLUnxN/3miOfLw11icjdfAbw5yCP2W3v/HHfdo0JKRIDgHlpmOsnPSkLxgmR5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbKpa7ugd2DaNUXtjBkRXKE+1e2pCQN7Zt43m4gr5bK23JQJ1
	/sgyazLQ2oj1DyM6XXtIDEQLFL/+LRYRNYW9mIaVfPCNi2dyw7py
X-Gm-Gg: ASbGnctHBpDa9lgRS5jgWIwulspVI8ntiE2WlalgPm0nkSUfS+vtAneVqvroIcaGrlc
	zunKlKek9y9DKyACrrw0PNZzG54K6omGEFz6PPQXG/VZoEJ9dIIZU9oPie6TSl/8qcqBsQ4p58W
	+KCTZNiFta8iBxYgImjahfHZSsgRV7dG6BlFrYdi3+BqD4xAsdntOBocahbWuoTMt/uqMy1Exfy
	M/EmFtD1KgnUrac/gNARgwwT/3h5gMv/5VGpBun/7o7sXufVvRKH3fhDfdKGL4XEN5urJI1p8dT
	brCnXdji5jw7h3np
X-Google-Smtp-Source: AGHT+IGEwyIDegUedvAshshUsBUv70DQuEhl5077bGg3Qq4E7P7WjPswXyRx1aPPegslZOQl1sjKWQ==
X-Received: by 2002:a17:902:eccd:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-21f4e6ab27amr262937295ad.19.1739272743631;
        Tue, 11 Feb 2025 03:19:03 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f8c2d9d71sm40207305ad.148.2025.02.11.03.19.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2025 03:19:03 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next v6 0/4] Add prog_kfunc feature probe
Date: Tue, 11 Feb 2025 19:18:55 +0800
Message-Id: <20250211111859.6029-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Change list:
- v5 -> v6:
  - remove fd_array_cnt
  - test case clean code
- v5
  https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com

- v4 -> v5:
  - use fd_array on stack
  - declare the scope of use of btf_fd
- v4
  https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/

- v3 -> v4:
  - add fd_array init for kfunc in mod btf
  - add test case for kfunc in mod btf
  - refactor common part as prog load type check for
    libbpf_probe_bpf_{helper,kfunc}
- v3
  https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com

- v2 -> v3:
  - rename parameter off with btf_fd
  - extract the common part for libbpf_probe_bpf_{helper,kfunc}
- v2
  https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com

- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - check verifier info when kfunc id invalid
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (4):
  libbpf: Extract prog load type check from libbpf_probe_bpf_helper
  libbpf: Init fd_array when prog probe load
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        |  19 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  84 ++++++++++---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
 4 files changed, 200 insertions(+), 15 deletions(-)

-- 
2.43.0


