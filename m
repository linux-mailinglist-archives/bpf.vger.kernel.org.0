Return-Path: <bpf+bounces-68612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C234B7F64F
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E920D525132
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527952E9ED7;
	Wed, 17 Sep 2025 03:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALqUYuiv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E7149E17
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079680; cv=none; b=ODd5rVEUwJ0unaWvlTk3JASbNOwg6L1PAW2Y1M+WP8lDBPD8sBFASA6og8i1V5uuA/mPX2dsdXeNXTksQBV/N2j3odfSLhqYSqU4pvwppB5wSD3isl1zEI2p0mf4fRZefIBgmmTmIsvvCNM61pPxiSObdxQuMuntL04yXDWKyuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079680; c=relaxed/simple;
	bh=sRW+GldAW47UGF1RkoV1M5f1+Olc7USMW9B4EXGChFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3HduXsb/JhUHmojvae8f9Lkylbdqwv2YYaiq6OmLrXI9gjhhnWlN/vdlkUzmoXP7ylEtzJCJioW3XY26xl0siAkVQV0wOEtPlCVnVzW1TReVAAdCzOQ2/PHSq30Wiw3C/QDqVohUBYtW00cNJ6fUls8rnRbqznZXOLFgsPVKOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALqUYuiv; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3e9a9298764so2431618f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 20:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758079677; x=1758684477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kugQoSsofJ61g3aYjjcsPz327riPrjDSLImWY67RxnY=;
        b=ALqUYuivLoMhU7WC7aMFxPhwe2MkEJU6iJntX0bZj5c7uT3iScdrqKjlNVrHpJ9gV5
         97Yp1x5CFqiVMNLx0217S3INCKi1neaD2nMVy6Heg6CP1YfykjPKe9mVlw71k8JdJT/1
         AMCKTyMGxDPGLLI4PRijElgbwKO+ExPZ1gk43bJQSnzUqBVxMABIwcCxqwufATtpV/Lr
         Yq+H5MYhhgVjNEPgHJEx0s4i343C6zm9HvwxQnIv8STlD6mwAXwyDREDN+chRkcHMM7k
         KE9Ak1ZG/WOWXPDecQzzyEkJDFg4cV3VSHIpxxz/WndWRfOBcrcHWK/GYXhMkHrAIYVj
         1R2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758079677; x=1758684477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kugQoSsofJ61g3aYjjcsPz327riPrjDSLImWY67RxnY=;
        b=Uqj3BWfP1CenvnEBEUAVRLncKJ9v4t1jbBhUmIKo6l5QWWV71N2Hrh4kzoFHKWoHQL
         Wu6a41HyxJ/FKmCCGR2A44/1MlGC/fXGbWEy8Jjt6B9bzTeHY/oXBqHIusZuBSdLBpJJ
         cv+zAIg5tAX5qMC4/K54ua9FxP7kVq3a459d4aKdqb9bkKB+HM/R1HroC5tEERq4KR/R
         eedMvdwNqTs3AWKmGMVJxbnTAp+ogM1OtpYMUEGTRV82FLHNMBQzANOhVx2jFaVhYDua
         X3IWeBEgXFt5/s42FjNEX8j4aa/KKl8rBnstS0Cqyi/HUak+nPlz5LH9IJzZaKv1I2N8
         L5yQ==
X-Gm-Message-State: AOJu0YzpbMLHHSaEHg77PyM3rKayG0MErAelk8y3Hajm8NedY1rHcCWr
	blfc15pB1K0419sSVzq7DBAFh6dmXp/gZK1/8psrqzgW/gmfnTguPN6CiMHOeK/J
X-Gm-Gg: ASbGncuojclqT3gepbi9sKmbkPBdrl1Zd9+XqDd4iuguMthPp+tnu+UQqG4Y6dKZH0d
	iqVCnC4qLovV521HZTnmO2fnI3onlMA6L3d/yowJ3UUEi6j7xR281jTRiWBY9naVAziOS8iRyZy
	DBJ5x5Cg/YX0hDYT448pwXu3qP3tUwELXuxOiC60ZmIvMvn6rOMlKiJnK9pLBPgMUJ8MYUVWsjq
	xQ1aMU2HKyRBJnzesCcUwOOsRextNobiyRDdktnjVk1dBS2CDrHLOJ1s+97aBpr/7RmawUxgKWR
	DBWKE3nChSVh3W5xBB28pNAd5gVYhi/DCmRqaiRulB8KBKEmN7h5mxtN/WDB+o1D5NW/twX1zCr
	gabjQUUxOPrE4zJJkOGhPnXfVFWHGUcTAJKARawXeHMuD
X-Google-Smtp-Source: AGHT+IEwK3Zklr5jUzvOH+8IoOoU/34CFzc/N25WG2rhunw16xo5bzwgN29kGHzBLvrnUHcoIWKRhg==
X-Received: by 2002:a05:6000:178c:b0:3e9:ad34:2b2e with SMTP id ffacd0b85a97d-3ecdfa2a681mr445904f8f.46.1758079676767;
        Tue, 16 Sep 2025 20:27:56 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ecdf0bbf24sm1047309f8f.63.2025.09.16.20.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 20:27:56 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/2] Update KF_RCU_PROTECTED
Date: Wed, 17 Sep 2025 03:27:53 +0000
Message-ID: <20250917032755.4068726-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=memxor@gmail.com; h=from:subject; bh=sRW+GldAW47UGF1RkoV1M5f1+Olc7USMW9B4EXGChFU=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBoyiqteFtM24rbbZ0UsvAjIl+Ijj5GmNbEbcIxE jowti+pt0GJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaMoqrQAKCRBM4MiGSL8R yp5RD/4hPesOe9NSfcg86P3uf4soFtpNEfUYm3htJSOiJxafCmg/PEffV4lKkOvcskIXIpKedUc q5l4zvBjZq4xcQ4//xpIpPRRSEMc6XNIGkNJF638u9xcDJ7Lv0gabQDK8W+ePQ2hka+qWeovnx9 bXNVOdppln1fFhMaQgo0S2hG2wRROY9q5zG5cnaZSCBbAXhyx8F4BEFdF7El8af9NZ73iFNShQg 2D0GvtvniIIkwSw1PHFJ16XRCQFH8eOQ8MMRNUpHQ3nW8n7cuRCrn0sxA+o8kmGpJpvQbZdXBsi AQZPfVLijU7MKrCtyWNdNkD58dFSoor13JNlhpmwfNzBMbk572hGCQveO3eM9Evl1Uv/5/RifDW gODPJb0NYiQsyqKsUUhZ3n/XPPavpWPwGjHTBekfzOJ7aa+kitDNoqVTA0sW72g/+LHIUyTeCza z7D75Ujmmhkc7h/Q1962x4+9CO+adEUsFPjtoaVb5pdAK33kKhnN+44kKQrcb0TTxqIMmYZnwmp JNym3lgHFPGitflzFmqsI3xuDM4YxlsGr/VFDIpvzrAufPaEWysOHH7oLBrJP4S6HOQQTUiTrWO ia0QSYh+ZaCljZOKrfa2bnoLSDsZ1IUchzweHcnD68V/ym6z6+DPZdm5AXC6KSZ86EIuyMUGGG2 kqKwN1rWdVfHw7Q==
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
v2 -> v3
v2: https://lore.kernel.org/bpf/20250917032014.4060112-1-memxor@gmail.com

 * Add back lost hunk reworking documentation for KF_RCU_PROTECTED.

v1 -> v2
v1: https://lore.kernel.org/bpf/20250915024731.1494251-1-memxor@gmail.com

 * Drop KF_RET_RCU and fold change into KF_RCU_PROTECTED. (Andrea, Alexei)
 * Update tests for non-struct pointer return values with KF_RCU_PROTECTED.

Kumar Kartikeya Dwivedi (2):
  bpf: Enforce RCU protection for KF_RCU_PROTECTED
  selftests/bpf: Add tests for KF_RCU_PROTECTED

 Documentation/bpf/kfuncs.rst                  | 19 +++++++-
 kernel/bpf/verifier.c                         | 10 ++++
 .../selftests/bpf/progs/cgroup_read_xattr.c   |  2 +-
 .../selftests/bpf/progs/iters_task_failure.c  |  4 +-
 .../selftests/bpf/progs/iters_testmod.c       | 46 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 12 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  2 +
 7 files changed, 91 insertions(+), 4 deletions(-)


base-commit: b13448dd64e27752fad252cec7da1a50ab9f0b6f
-- 
2.51.0


