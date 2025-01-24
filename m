Return-Path: <bpf+bounces-49668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2810A1B80C
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1F18843A5
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143E13C3D6;
	Fri, 24 Jan 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwQXRoc6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A170808;
	Fri, 24 Jan 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737729885; cv=none; b=JLTfXTHTWWxhCjLqkrBtJnY/PrytvYK7sAhAFRwIgbQulnMcyA7R6R2M3demwbvhp0jsZtFAQ+TYYlLpVsPsN0hvXxDxKnrQBDqNmRYwwOTWBXRVQ51b0nSlIDgk21SWBjtw8VHjAgw+Luvq57xSCQpGqfS+m4wYZEsxCvRN9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737729885; c=relaxed/simple;
	bh=heb+mA4o16bdxWJFrs9OXlNb+GD3wEhC80HOEJ6Qmk4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OBm4mkNG6cVtHpa74kr5AsnWxc6kJfi1O6y4114p4WJ/qhARVIaRejzuQLxYgf+p6tmXMEQG059dsoD4gqRXWB5tsbZ60vPJZuLyZ93zF1ooCgfnmin9kfx9d68rvdL1fn6FddFTTB6uK62+wXPlySBRXRrjTjeFYCaqrwO73F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwQXRoc6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21c2f1b610dso48482955ad.0;
        Fri, 24 Jan 2025 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737729884; x=1738334684; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvLNKFod13XEC3k0qGKm40sOQ+I3WkBBUiFQyOI8+Xk=;
        b=CwQXRoc6jKVQZ9A5/qHmMp4XpU1OL6saZJWhClkTPfYq/nbh5q4417xismkbepPNxM
         uilN7+8WfAslralH9wDaJeom+4f2wc5xvN9pP600SPgOXr0kZlFJWa4RxSAGRqaUKcwK
         iDGJtKizzrn9A0kQq7d2zsO+7WmPmp17r8zal7R3SKRnCuPLW5vE33+ladTj62HkLe44
         28LWSYTSlAtloVWvDk8cQqQijTYpomwUA/WAokW8tsBjk6PvVNm8X3mZDzR1GYVMXtjX
         BZVi+CdhrNG9lrhGlTyXiaUZ+Jrkqjk1LYcgVroXRSCtumbIJens+ddkqaJHYeULjMS8
         eiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737729884; x=1738334684;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvLNKFod13XEC3k0qGKm40sOQ+I3WkBBUiFQyOI8+Xk=;
        b=q6NcbPbre9h3r+rvTYDPKel7CEjk+yrA83dRtSZ0PqRLo6m2n2XHucDW5k7c7aqGmb
         P3K/tXb+e4z3qkijqSOs7MrvlSkEDgaFwuT4h40COMYT+cBGVDn0zrKHUgRc1KlWkYG5
         AhYjv3zgXNMVV8GeNT09uWexJvkxRSYMaiQfhVrtnx7e0XqFcFoBCUGBMH7Bux9Jukyy
         +pzN48qe5gcRsCB4wyWH9a1icH7c0q3TYe9JUoKrQ2zC7daG4eY71eV7V5vTwaKNQlt6
         NBVNg3PGxoo7j4XIHvS8JHyd6rfHLl6DgXbj0PKjIDpoNXzuUYH5J+FTIz818lE8K+zL
         5Izg==
X-Forwarded-Encrypted: i=1; AJvYcCWTIg/C1OqOFYjo5Mzs7jay5WPWPuixDA9Dv8Sl18ssqK5iElovj1KOjaU9wmR0u+Eet4QP88VPzdvc9zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhURLMd6hiIrixvDTil1LIaq3GMxQgPxwEz4h8LT4X9Jhpv918
	jG041w1JJ2hcK4bN3eClUccQw2Jd2r7bqvuWeCH9eYA8Wx7XBKcr
X-Gm-Gg: ASbGncvH0nxod60G5uxQ2WdEE3EQkF3eZsFgzrC+uoaokJ3eTJJrWM50mblpyQlMj4o
	UXQbJwy6ibgVVqAb6RgzlMVTvh2fVGHupjfHhwVU8dBv+bYEiQYsWHIgPYr8b+kTMR/aHV1vQhm
	dWjQFJ6fLO97wGqMDRLEVMrQ/CYHi3+75WOtnmJHVse/CbmsZHy6OpEuZAdKXtnsmDwoWWfaGDL
	wdH11s4ax/CqSKR2EHP2i6tTIV0qPyC5IN2k4l/QUEWm6RbLOPfKmTwpi8JB4fPaiMGdxTRq7lU
	AtxNrg==
X-Google-Smtp-Source: AGHT+IEgjdCVs1Ibjn93xIPVZ238ClXaDvfj0wNQaifrKYCraqxM534PEMjgyCV98NA1Kp1wPHVYSg==
X-Received: by 2002:a17:902:fc4e:b0:215:b75f:a1e0 with SMTP id d9443c01a7336-21c352dde3dmr409714155ad.7.1737729883538;
        Fri, 24 Jan 2025 06:44:43 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da4141bf1sm16919375ad.151.2025.01.24.06.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2025 06:44:43 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/3] Add prog_kfunc feature probe
Date: Fri, 24 Jan 2025 22:44:08 +0800
Message-Id: <20250124144411.13468-1-chen.dylane@gmail.com>
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

Tao Chen (3):
  libbpf: Refactor libbpf_probe_bpf_helper
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        | 17 ++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_probes.c                 | 68 +++++++++++++++----
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 ++++++++++
 4 files changed, 108 insertions(+), 13 deletions(-)

-- 
2.43.0


