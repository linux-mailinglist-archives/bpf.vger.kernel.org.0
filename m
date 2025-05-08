Return-Path: <bpf+bounces-57778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B26AB0168
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 19:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7AB188EAFB
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F8286D45;
	Thu,  8 May 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOjQ3zxX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1042868B0
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725191; cv=none; b=Oin5Uibd6EKT5NtKBqArW+MwuLzt1mLy+0kiz9BZI253qmfizL4qe4qRLNPT86b5YdLBG8dzmrNs9SSyAptmlUOsVqYwPlzWSM+lyM26gzfP2jIDT64nwpG7yj3PE7Q5ROKZlmLigPbZJfRlINqI6V/jcoh3Oi22Y18y6D3cXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725191; c=relaxed/simple;
	bh=HE8TRSvFA3HhTCthoL6NLbaTdhlJClwbkdTsmBtcveA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dj30PSRhSX/0USvIg4CjJk2Xwyq9ar0Hoyc6DqFDJ4Gd9HgH8l68AAigLA+nvRwJjqyAl+zLV5j7PnpVqBUwHa3TKEr8DDpHdRn6lhACEEcgz8iG8nWrxBH0sdfz5clx5SWmZ//GY+R8g42PMAffu4zxyttYNPW9QhGeTuJdIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOjQ3zxX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so12902865e9.1
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746725188; x=1747329988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z5t0c0WQs4dd6GTjzNN9izSd8ZyS6dC5eniHhd9VVaM=;
        b=HOjQ3zxXHH1g7w9nK+3mbJy0DijdajFDxSNnix6eZblOikLmobpz/c/17Deg+WWBtp
         IW7YSkHZpgX167WKHh3MKUIlrY1bLT0jUwS46dnqZbHtI6XN4WGWn76WQSk8udCfO2Lw
         wkYMA9GHH/U8FyUU3SvKuaP2lwAkdlfcKLIlo59EnuxPs+b8D6WFlE60MMo2zpgArwe/
         xThT73tx6zc7HQZuHLgCqapdoVPPwG3imdb4OweYQYQ4TUg1fJTKk/t9RX4YscI8OWmK
         taZghmqBd9ahH28BVw/8ikpSJSgPq8wGho+UY0D2C2TB4gE4TDfn6x6Ixht55BdczCrX
         4uFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746725188; x=1747329988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5t0c0WQs4dd6GTjzNN9izSd8ZyS6dC5eniHhd9VVaM=;
        b=I+FFmTRprCeEaglkEQi0GmIa6rzTtaEAuZ0KWzv0AYganMdvLzk245pREUxpWR49QU
         BGatqITjsxiA+SfhAbsnMkwX7FwuEjjcMSBMnknuW6th6gYyPZewJ0si9ETpfO++1eW3
         6JLPsQfniPDNc4F2UGwmFUCC8l26QnS/03YD+qHLCAPmXy5bPUHdKRB2AZkh9ZAxeSgF
         sglorb1u6uIvrlM/ao0XwGVSU2QpMhafJXLO7nTbfO9usOscrEq5qv1xAjFimqOye/Cy
         3ByaPqL12JaaWgqYz90+lMwQ43JiRWpRucHIiCgp/bOJwMitKZbkb89fzfKic3+tHQkg
         8uyQ==
X-Gm-Message-State: AOJu0YzoK1Qss+FOAr7KPMbldwlVYeoPUUddvmCPmw1RNDgQgN1LultV
	YerQC/EMvHHwoxkERMLd/NGOwRQ4Iako7i4ID5d35g3hRYeEMK3vtOZVew==
X-Gm-Gg: ASbGnctUpinIe/LX34n/BmOqaUffMxAVMKMx+JnZ5nmUXnqVizhIeTnv9GjDzLahprO
	C33imoQ1hcWTbxJS/uXKP/HUePSQ7nru5LKgbk7RduUwaKJFF86sIV+7tpF4Q295dZetllIt9Gm
	DKjlDudR3qJMLdP8taw7PgNBh58TueU+88CyvS0bRPYq24g5zBBfGI4BQdxgO26m5PZXijRvfOi
	eaHlGzC7eI4tZJtYvCO5xx4qPX2vd82sbwFM1pnG+Zcr9G5ozg/A/5mPo7L8M3wxd5a9ECAxPqg
	D5lWQWSw1N6ctIWpmem3Q2d/abIIR6daesdIDeCJT7EikNuFGIz+kK3l4QrFjgKigorwwQ==
X-Google-Smtp-Source: AGHT+IFP7zQeJBTUystbBbJV9UVyrnKTcq3r56VB2r4GoLhYLiWC+3VF9ORplceMhP/l88XmH+M7Hw==
X-Received: by 2002:a05:600c:8509:b0:441:b076:fcdf with SMTP id 5b1f17b1804b1-442d6d1f98amr1473175e9.8.1746725187499;
        Thu, 08 May 2025 10:26:27 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67ed1c9sm1800415e9.21.2025.05.08.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:26:27 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/3] Introduce kfuncs for memory reads into dynptrs
Date: Thu,  8 May 2025 18:26:04 +0100
Message-ID: <20250508172607.158382-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

Mykyta Yatsenko (3):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs

 include/linux/bpf.h                           |  14 ++
 kernel/bpf/helpers.c                          |  22 +-
 kernel/trace/bpf_trace.c                      | 193 ++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 218 ++++++++++++++++++
 6 files changed, 449 insertions(+), 12 deletions(-)

-- 
2.49.0


