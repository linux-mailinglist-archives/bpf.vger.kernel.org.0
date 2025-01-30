Return-Path: <bpf+bounces-50116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67BA22C74
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 12:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB23A1A23
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1DB1BEF9C;
	Thu, 30 Jan 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="m+Q0RMOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC21A7046
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236228; cv=none; b=tazQZ/Dq2dOJJ2KMOVXxaA323JGw783Y81TeKjyHV1AOFW4vMpL/WNjI2O7InlqVz/0wKfgr1BRzbcYh5odqpO2k8kcExrIrfOHlqpfzZ2ajIgwDw9muR7uGUOxQbUjX39TSbOoojuTtxUCsvRqaZf8rpjtU7vp4hz6hqO/iYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236228; c=relaxed/simple;
	bh=XWL0SAKo0wrkB21bbinHpg118sILQhlDvo9SL92e36s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=peNbIzsVt7mB0+XwjmZ76uXsehWAwtxNdOcF5tZ1lMwlzilZd18IZDMTeULHJoDCWha9G+MvWZqjcHLWHAyr61rinDnVGWvUnxU+jEFun5pNYYu7fU1vJtO1i5kUg9X+9XbdROqYgzBpgFtV4dpUR0S2SIyWkXGiD/P+01bpuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=m+Q0RMOV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4362f61757fso6815245e9.2
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 03:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1738236225; x=1738841025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUg76uGfre2QMQU6sYpHszk4XRjurC9kh0W+SfC/O4k=;
        b=m+Q0RMOVLU6rc1kV80Mca4mG37YF/ftdZBOFAOsPc/8bTZVkdBJGMiVQqX/LOm7QdN
         PaLEnedT4T7B7PG4LTadL5WIYcTJlLis2aDom/yWfmNob2cFErBkyLwrChUaPKnXyK5w
         IeA3C/UvhLJyYldich/945OXnaLmtUcBG10k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236225; x=1738841025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUg76uGfre2QMQU6sYpHszk4XRjurC9kh0W+SfC/O4k=;
        b=Lk7MDIkPf8uFwslV9ytUlZYrXn+OGJJ8nmH+E/XO9qJEGgvgpXRKQDMWehozBhGYS3
         aESrEIwzjI63SxZ27d74LRnatYMoCGmcFI3XrmLxU4cy27yrGhpiASbiGft7NX8yvyNm
         GsXxblCH7RTwvX/JvZ7wSWRenMnREZA1Z3eWk6yoPrDSjzsXGA4UdOTXAiPn1q9dnbyQ
         EGfQFKT85F38LkCi7s+wUdGTXXHPTFRg2Dxnq15WVvNFG8ooIiaX5OoBf5WZcEL2KazZ
         RZacsUhVv/xMIin+dZiR3m8hQe4vxSYaAAPgX9iHIUEZ19JY4Wf+WSYYf3fTgjfgR8LH
         F3rg==
X-Gm-Message-State: AOJu0Yy6aLcgVe+9BSWW7nEkwXqJFV/UOgNBZu4Slu2YpVXLpYCgH+DD
	fnzUTg5Y+nYBcCiQpAlbVGVWeaM7GfFaM38nsyfYhIYHl1osktkwdXd4XGSTxlBTOOelsyI4S1B
	rG/E=
X-Gm-Gg: ASbGncsTbMn8w5AGXeExZIuqRkDTaaMQ9k1Go+JxOpKUtAJX9N5PQ4NWohunbKJSF1i
	70hNR7Bmf5i/mwlJ0GWdLiLcXj8aW8gqX4QQpYmmyzNCRTtBSxVfpTu5CF2yNcRG0kQujLsl9P+
	0sycEVYGI9sRUcpVUjNx2jZ/UOstbrWLmZiTMIuYqr1vj6i19N4MkSTxLicR8jMRhY7ecAqK2w9
	6YJf54215CMDtkn003uR9XIurAnbN7bRF04UJTqMS4CEH/PGE2RrnDHJAmDgoLlOdBTnAUpleFi
	b42NJwCaRytmXVTzGOD+Oj4eHUM2TqA4UfA26fNqoBmowOkYmr3QvIU=
X-Google-Smtp-Source: AGHT+IFLuF1Ucsx4cnRKM+ikllsiY/EE66t+b4kkrZiJ+BUKRH/iGEEFXmi9Q4xSfNQslv1Yy4YyzA==
X-Received: by 2002:a5d:648f:0:b0:38c:4a5f:bf70 with SMTP id ffacd0b85a97d-38c520b1055mr4991615f8f.55.1738236224823;
        Thu, 30 Jan 2025 03:23:44 -0800 (PST)
Received: from localhost.localdomain ([85.196.187.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1b51e1sm1678981f8f.77.2025.01.30.03.23.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jan 2025 03:23:44 -0800 (PST)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Subject: [PATCH v0 0/3] Add tnum_scast helper
Date: Thu, 30 Jan 2025 13:23:39 +0200
Message-Id: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series introduces a new tnum helper function called tnum_scast
which can perform sign extension on tnums. 

The goal of this patch is to help simplify (and unify) sign extension
operations performed on tnums inside the verifier. Additionally,
the changes also improve the precision with which boundaries are tracked
for s64/u64, since we can more accurately deduce said ranges. The patch
removes assignments to worst case {S,U}64_{MIN,MAX}.

There are a bunch of other places in which existing sign extensions can
be replaced with the new primitive, but I thought I'd start off with
register coercion as a minimal self contained example.

The first patch in the series introduces tnum_scast. The second patch
makes use of tnum_scast to simplify the logic in coerce_reg_to_size_sx
and coerce_subreg_to_size_sx. The last patch introduces some more tests
related to sign extension.

Dimitar Kanaliev (3):
  bpf: Introduce tnum_scast as a tnum native sign extension helper
  bpf: verifier: Simplify register sign extension with tnum_scast
  selftests/bpf: Extend tests with more coverage for sign extension

 include/linux/tnum.h                          |   3 +
 kernel/bpf/tnum.c                             |  29 ++++
 kernel/bpf/verifier.c                         | 124 ++++++------------
 .../selftests/bpf/progs/verifier_movsx.c      |  73 +++++++++++
 4 files changed, 144 insertions(+), 85 deletions(-)

-- 
2.43.0


