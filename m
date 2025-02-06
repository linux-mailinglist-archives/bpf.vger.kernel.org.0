Return-Path: <bpf+bounces-50607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B31A29FF9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 06:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6C11887B46
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 05:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8F222580;
	Thu,  6 Feb 2025 05:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYyygQuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789F13A41F;
	Thu,  6 Feb 2025 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819095; cv=none; b=I6j1jq6cuACW8y/6HQ+aKVU6BxWFw5dfV9BdkYJJg0JBQLVxr4ViuWeuevh+Y0fi4UgtJBhsaDwM2VtIdcFeTiqCnuIUoy2I3b1fhsr0PkQrZUOly90veF+26iwIHJ9Ff1/QtcYcIhfxI900WmpxHPyTsOUI2Ij8NSaJ9Fjg0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819095; c=relaxed/simple;
	bh=+aPBt3SpUMrDnxouQD6JSVQcqVP96/nYHNCsAKWPCA8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MO5nCurpzf8sa0q4KYiEo7K58THBGUZIMH/vXwKcEN0WwW9USzPaOYs2TIOMGtb8A4mwsRDvHQ1kSVvLxdsRyGdkS7ZpssFIhxdN7sBZ2ognDuqucmrS+MCNtEsUg/DCGcdGvv2Zl/nbClMDtVsNbsAsLtnERtXuUJ1n5/ewd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYyygQuQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21effc750d2so8607285ad.3;
        Wed, 05 Feb 2025 21:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738819093; x=1739423893; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKJ2RPSDuexqAeZMky5ctWE7NpMtniAk7Eny0kdlQeM=;
        b=NYyygQuQIrHofivXvaI+9UbWQ9cRuLcabGEFOBBr/AhypQXw1IyNi6yhCZqn2ZjGZ/
         1rARNMgTsed/3bb9aTMx1ZV1U5pQi4dB8ksgLBlwjl9IcACVTxQR2hiBFRjxMl5XIWB2
         EB1rOuhnBug4hZxlIt1+XGCv/ufgtxFRrN7nPaGM/DgihNbWypXV9ltL05X2Vzorn+7C
         lLdB5Vz6lkrzxAW29MMZP10rbsKbe8vKXfHZ7WLx4cVc7ye2h8ycRoIHQ+91J/v2ZYb0
         ajrj6llB3sY8WA3u08BIiqEoDD+8mxG1z4Ysej4b9RQ2OOcXEKXCBReWWnFGvglKFMXE
         kbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819093; x=1739423893;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKJ2RPSDuexqAeZMky5ctWE7NpMtniAk7Eny0kdlQeM=;
        b=HOFEWVMjv+PKNClI3bSKmN1ze41ayI4x3IAtWoHx/NZSh4E74esEbVxDWTdwLuGMv1
         By8pGGcpHM37lMqhRddjVpF5RJdAIicgOzlKgFxW1RcIjWcu6fgwvDDPT+HFt+pyAgYz
         +ObdOyR1ISUp4dr/4YuAUnROoK+YZVeyoHBHT6KLAlgHC5k5AXFDMHu0lOYoIqHWlwVb
         rsgC6fw1P3BjRVM6MUQ33USCoCfwBs+QoUoEIAHGlWA8UxTZnx1As7XU8073EiKE0LJK
         0Ws8+gpLauSFklHeZMAhKkpKjgAZqt+yEgnB7w4dP2qcJL0BAWU8vTFCzF+w7VMY3ADP
         38gw==
X-Forwarded-Encrypted: i=1; AJvYcCV5nAYY7hIrNkLafobialuvbvUjC1hNDoziMdbVpAzj4f6UbQNGUetMUp0tywSbiKDx+CbyPLhexCrEPQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckF00UpYTAD+NKERHV4etwi813aOrXp1fgrtUTJxJiE/9t2j2
	E68WLMOvXbGAeTyb4SLfYSXnhazyH/A6ttycr3Cn7GsCMaaib40e
X-Gm-Gg: ASbGncuX70O52cP8ZedklMsM/ObNHdzjk09sfqwXBs20+6uszRZmMqI+dLnXCYj/oGe
	sVVOhmJ5oDenthWuHdleWxH448JafXj4BVBmHLmNJHM5A3s+bQBeN0lrk2PiR2UAha+lA7hcCO+
	MI+J8I+f6DvVPmSDycpmQJHi6lmbVtfw2l4zebf8VkUNQVPP3fEEfVLiyF/93iaSASxYEl7TKhn
	I5swqoaI+s4unZO27xMIq6fA65mW28AOIdzSn3mvmhMOkpK1aCtmj4T91c56Lw/+Zi6GtnvNKL5
	Etr1Kw/Wga6ALrOz
X-Google-Smtp-Source: AGHT+IHYNK/bKk38i8gB/49HPtenACDdHmNk+tRiohB6DJbRrVthuDBMMV5Ry2pAZwrgDryfUL7k0g==
X-Received: by 2002:a05:6a00:ad8a:b0:72f:d7ce:500f with SMTP id d2e1a72fcca58-730351f0926mr9240455b3a.21.1738819093262;
        Wed, 05 Feb 2025 21:18:13 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d1efsm394098b3a.25.2025.02.05.21.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2025 21:18:12 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/4] Add prog_kfunc feature probe
Date: Thu,  6 Feb 2025 13:15:53 +0800
Message-Id: <20250206051557.27913-1-chen.dylane@gmail.com>
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

 tools/lib/bpf/libbpf.h                        |  18 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  91 ++++++++++++--
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 118 ++++++++++++++++++
 4 files changed, 214 insertions(+), 14 deletions(-)

-- 
2.43.0


