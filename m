Return-Path: <bpf+bounces-68609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E44B7EF13
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089547ACBEE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92123D281;
	Wed, 17 Sep 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KL2RAhlI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A3149E17
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079220; cv=none; b=jjCHiyfq6xowUdDlQTEkiF9gJ4SWIGIPzUp0OpdMxuXKxG6USIl7GWMz0azPhjgqF198+s54zueRmVz2mKNihDYRAdP0V4yW/W89x8bZ9o55uiB+P9dgL3VYB+1b2A0Y8CApsOcrnWYCyKWmiq0tEJCx3oWpEWx5sm6D2XBHLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079220; c=relaxed/simple;
	bh=0NrPbk9e0ZfOnttlykm1JnzOktvXSNzbzPIzch+O+ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXIBDcT4ayc9vvjsxhhGy/DYbhAkWoC4fWdjHJBSkTS6tE/y24mEocfEDiwht0pJoW0/4+U8zEVhHzRdFGH9fY0lqpGR/vG+5AXQ6oR9p9gAeeDfc9Joyb71anxFXOWE+B77IZUvxgob2LJ1BHD3fnWh6FypMQVY19b5gjOJJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KL2RAhlI; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3ecbcc16948so847511f8f.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079216; x=1758684016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uzgl6fcIFVnbHWWW8LVUq1Pp38aK4XEO+cGsjGlVrjM=;
        b=KL2RAhlINU3sWkoSjNxh8C1WVWBoMGsZ6AZLLQxrCLU/Rj7u2EQ4ybJGR0AN+lV5Pg
         EJ0D9x28r6I7eXoDmleQvUcchAb2yBIjvC81Etx40hHT+/7CMacLTgiFBGyh5+hIm5ph
         lsNcYVtvXC1C3pzRkPeo0ieUNMetgVH8kVJ06BDQyIc1nPpv+zAdAJxhg/zGqMYPxuhz
         Q3LTV81Awppougq7Kpin171QZKiIpjihMFpNajKgA3m+CNkqKcN/22jtFAd4QuIe5g1n
         d7yAjc+A7wQD1gYqYuD/8t0v24i8sG0Ry5PzXo9oNESyuHLvzPBTJ3/Y2F9k3pqpR89v
         DaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079216; x=1758684016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uzgl6fcIFVnbHWWW8LVUq1Pp38aK4XEO+cGsjGlVrjM=;
        b=fZ6/EInmiPRJEdNg6wvSjXvzghPHPwxLp2TfTiLoy0DYZR45G4kiDM0FIIZir249Ed
         M4bmphELU8AO0QuS8Dm+baZoYkTIi1r9fVNhkqsUK434S+bE8+rDiDX1NpkmtNcl+Emp
         OSwphSLFazwMmRk2mayBrjuUUw8T6mW6pjBQBNfKXfRnNDLVoaJDKC0qUpmZXBNI/o75
         K7+byI+PJ9CKua2Gwrc+NhKYscuKGWT84HNMVZB4UO90fmPmbyx+91dqF0WL8cZ3LgiZ
         OMPEugaKIKmVAse9u2uMmdS6oHxBK0v4JxiF0KwkwOE1rMi272KHE8bWYPoAcZ0Vpvem
         XGiw==
X-Gm-Message-State: AOJu0Yx4wtBzxe04tfThXeojpKQSUFhOsZUvd9oR/hGnMwnfiQmaaOku
	/J0GbVKRYQCmIjADAqhnXu6oBJgaQytj/B7MCUNxPWecfWMzJjj9DG1dD7lf62j1
X-Gm-Gg: ASbGncuQ13GfMfzZ0pj0VYvkhdUguI6OlvO46n9RGwizYO7XNEb7xWSgS9aZChIps5a
	3+nqFEuUHxaSwTMEzLIRQa4tPAaGEOFpgoP5o0et+lL4+H2qNGlckGR1CLcCyWyJkgGfJfv0eCC
	079Vhe5tB27lQFoT0B6ZUiRX4yuq1H2GCBFewStGtcw3yecKdLiIuwTNcrmjwt+2E3NKWG4WmWx
	fFnp6jk3Y7xw5m4sPw5ZizNTbbHyp7MKDhgp1oKVgTlRZgU/WCcu8Zdti0fSIL2m2z3hYc7edRt
	H99hFRNaEWYHrIoucSLp4RIhDo8kNd36p75ZLNAzlqpXR9nGhQT0IaQxz3gRrIPRQQepv67xGmk
	4c6aUPSC7eptpbc9lQwZvfqiPszNAPMb1WZx0qGGKsm09
X-Google-Smtp-Source: AGHT+IFMJu2dSXVeeKAdYbxqIaljRlJTROn2bS5fbgglnAhgCzPpjvMJRgzkrV/9gKGYL8S0yDhMrA==
X-Received: by 2002:a5d:5847:0:b0:3ea:63d:44c8 with SMTP id ffacd0b85a97d-3ecdfa5f22bmr482941f8f.46.1758079216272;
        Tue, 16 Sep 2025 20:20:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45f321032a1sm32754415e9.2.2025.09.16.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:20:15 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Update KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:20:12 +0000
Message-ID: <20250917032014.4060112-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914; i=memxor@gmail.com; h=from:subject; bh=0NrPbk9e0ZfOnttlykm1JnzOktvXSNzbzPIzch+O+ro=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiiXbP9JnjFcwVeuJDA/wmVmaGljUkfWlAKGz YNMmETZT5uJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoolwAKCRBM4MiGSL8R ymK4D/9xbeRVTLieqb/QbpGL4wbxkUOIgVvnnNkMtMkPKv5EKY1NynxdsDDmCz5Prd0oEyssOfQ 8sN08WnpqQQEYRmOc/l2ggbWKfMXnDWQCOXZSIWDMuDhcDm29nbnqYhX8Cw11NhdbfGVhHS73Kf 1xlZFmREBldwCfWvaqOhCRhNog+LHHzBBvA4a8QqZgPVVUqdfPsA9iimkvnmXEh2eGR4TsXhL6o 33dmQrDcSlGjyxL6rrFQHqqrzT4VpUi8fdlyLTy070xxJ01/7sfSC/KWMynV68sMOvYzalg1j05 HwjzCOW9+a0nYHlFyAvbdZ3FUZUXgm0FZSb+xGvw5dul/uXelMGWm9DC+EksZJ4Hg76TII5o7J6 DjMz9irmMNJSv5kYFqcuxb4BK46HHRR3F9GvIY3oBQKZoQfacXb24dUGfRVtaWiMCaqNSzhktab evsyRcH/md96DKxiZLG4swvJdepHzcDacJbZAgD05Zqsi3yBSyOa4wWrFf5+UTuvQ+HSf6T+wl9 vgGBQeKQtCHzhsyoqY0LLzYRBc1o6Uv8zcRpFo/AMC37i70xqno1JtP58EZ+sVxcyjJvrbE0b7j kr2/bDPi5DaBhvzEAQCE2YdhSFgq9C0BxztIPmCq8fUaVAkGmiqcV5kbt0MCz2UwqQ2sl34xGsY kx4yuC1olb0I5yQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, KF_RCU_PROTECTED only applies to iterator APIs and that too
in a convoluted fashion: the presence of this flag on the kfunc is used
to set MEM_RCU in iterator type, and the lack of RCU protection results
in an error only later, once next() or destroy() methods are invoked on
the iterator. While there is no bug, this is certainly a bit unintuitive,
and makes the enforcement of the flag iterator specific.

In the interest of making this flag useful for other upcoming kfuncs,
e.g. scx_bpf_cpu_curr() [0][1], add enforcement for invoking the kfunc
in an RCU critical section in general.

In addition to this, the aforementioned kfunc also needs to return an
RCU protected pointer, which currently has no generic kfunc flag or
annotation. Add such a flag as well while we are at it.

  [0]: https://lore.kernel.org/all/20250903212311.369697-3-christian.loehle@arm.com
  [1]: https://lore.kernel.org/all/20250909195709.92669-1-arighi@nvidia.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250915024731.1494251-1-memxor@gmail.com

 * Drop KF_RET_RCU and fold change into KF_RCU_PROTECTED. (Andrea, Alexei)
 * Update tests for non-struct pointer return values with KF_RCU_PROTECTED.

Kumar Kartikeya Dwivedi (2):
  bpf: Enforce RCU protection for KF_RCU_PROTECTED
  selftests/bpf: Add tests for KF_RCU_PROTECTED

 Documentation/bpf/kfuncs.rst                  | 13 +++++-
 kernel/bpf/verifier.c                         | 10 ++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
 .../selftests/bpf/progs/iters_testmod.c       | 46 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 7 files changed, 85 insertions(+), 4 deletions(-)


base-commit: b13448dd64e27752fad252cec7da1a50ab9f0b6f
-- 
2.51.0


