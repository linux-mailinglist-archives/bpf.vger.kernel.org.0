Return-Path: <bpf+bounces-51926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E2AA3BEBC
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769401745CF
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96641EB197;
	Wed, 19 Feb 2025 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QK51GLOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632271E32A2
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969483; cv=none; b=PeMvaIvnsQCqSCZKGEDud3lPoWlIRWHaLL3u104hO1eueNNfhWCnvOGMhy8hN/XNukqpfxNsZRU/a+i1858G3RIOj92KP6tUsRV/oNDOwmNk+wZhhw4lcDxm2iTfo7XUf3T4GzQiK5GUB5EOxRMYNHwkc7+gkP8KdDQASh3eezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969483; c=relaxed/simple;
	bh=0UsyMTfjHMAOZYMMYzH7/ilJdr02fR1xTqXuqb7bPSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWQnGUbSgcupILTgeHABKBQ/WAFGhZq5zOKGHwsXqPB+g/7M74ZGafIAxObGU71mBmskWZlmjNqjH4UMj+NreyAKLynh3bIeD1ia3othLKsnifzMOx/JgAIAOQnzdbYt4rNYlbTwg/wNH0QzNCN8+9yt2v3kOYGUzxSzTKZxeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QK51GLOV; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1337705166b.3
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969479; x=1740574279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kRN4oK9sSJRC/iT4rr9JgF16u+aJUbWaPdHlU6HR78=;
        b=QK51GLOVxKiLysJAgDo3gS7WB8N2ZbABmWGacuDEf/+Hoe+Wn4k0K0ugUpvs8+JNFy
         EUxucggvvgtU6+DCLGivZ2BLhlxPnHq1cyuc0l0GuIflVHXsHbP2u8W+NsmGFC/7W8s/
         Mn19Cfe/oUPtCyDmH8GTv88jXRUPjSLeGqHn9ApF6serKUE4+BGBgfIWUAyQF8r+HMaG
         TxymnFvy0JzR040mSyY09HVNKc2RBZKSaWOjH25PNfty2DN4jiJvIExGOMHBqjUStfzP
         AbgNjieOAOgN2lGykoDgJ3ueX1LXO3O6kLRO32hKXtMS1LovLHtFt39FTZEckSDahSbP
         fw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969479; x=1740574279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kRN4oK9sSJRC/iT4rr9JgF16u+aJUbWaPdHlU6HR78=;
        b=BbpBUxAgYRD7mQmIgIET3y0c6mE1QC40ESRX2k7TV4pBLBdosXqLQYHAMlFcouh8c3
         dJNvKdLfq9yiAOKD1DF3dxNo1NJHmAraoDX703qJ4WRj4XzMod6WEekSz7lFKyCDOGVF
         MulU+X5c1Acvy6paQxodMJZSEe5Xvd+YEh4PezG/kwUnxErUQtve+I1X2pJKV5MNYSjW
         xVnDVSQDyCvVfP6484gRUD8XwvJTTLcajMiREUsxz/2XLV6LxQ8zg2DyuZd+mGNZUfed
         eSj0AqyBkmGg4hnG14/mdFSuHBTtjcqkiOsx5oSztuy/1Jq9h0SOr63rNouWEVg/0QSO
         PAkw==
X-Gm-Message-State: AOJu0YyngARUI/J+OW5jB0f2AkOlDapaWtOi7eYpHFl+RZ2EsIG1qjHM
	73g1v0i7LU2OV9yaJPYl312hF+trj5Cik2Ei0k8Got6YJ5vzcnNF0Wx+g/xn
X-Gm-Gg: ASbGncsRERbzw6kpEeBZFO6gQCvDKp9y1IMRAq8Lr2ATUrIrk5tHausM1PsoJBAj2KQ
	vrXS5DmKzBTXZLbTx+pfcygjd/eV5x+OE8d6/n+Bs0STrwO+8/V3AqulPQcunfxYC2fSXjYAP7f
	p9Stk8Fy7GpQkNrNJykQax92EoG0nRqq9+mLtFQ5ct7eoyrzRimxAuMiAhMdl8CRfqwwe2/JrZa
	0wZwu/DnG9IvvbRUpE5gVVTmxSwLilC66F1QPDGufsK2+mCzTDHwf4P1Kn+kfF+7mcLbRGO6TnV
	yw==
X-Google-Smtp-Source: AGHT+IHWp1FHbKjq9XromLyC2/c/ZjxXMu6DrpjRAyvF7F28PMMi40GKWV6O8VHYO1//q5RrdpVCNg==
X-Received: by 2002:a17:907:6d02:b0:ab7:83c2:bdbf with SMTP id a640c23a62f3a-abbcd0767a8mr384048166b.41.1739969478424;
        Wed, 19 Feb 2025 04:51:18 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba910e8b11sm979485166b.21.2025.02.19.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:17 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 0/2] Fix bpf_dynptr_slice_rdwr stack state
Date: Wed, 19 Feb 2025 04:51:14 -0800
Message-ID: <20250219125117.1956939-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=642; h=from:subject; bh=0UsyMTfjHMAOZYMMYzH7/ilJdr02fR1xTqXuqb7bPSw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBntdMxuIKmNr/PiJmjjMO93FSqa7++KjYWuRGFrwkN KK+7MU2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ7XTMQAKCRBM4MiGSL8RylnlEA CrtveGpga/obo9e2R1dWNRSvWS7JrBXWR6lEIHIyV7QLvkcg84FdwmRt6H9pGaaDhrgpJ/NO6dUGbQ E/ddh0noMRq+xRqMoguLxtZSLM1/h/eZ/wz8f8LAtbiXr6ELU/AMLBhJgAmlPiImyHaIgCUBATVBkc TAvO1jEQE/krdCtEF8vYULSADg8N4kBVkJVKelliakQqvf8R0tudVTYV+GnFnx4NQxWXO+jm7PipMs YX46CKuUYsgIzO8QYTr2kdGqaGmDYLcpqfzUXyJ6iFNeYWQTTe3Yik9n82q6H5m8f22ii0MkJ49hMl yfFggHYes7xzChOzTuDY5GfT/1VEyr9AHqRIvnJDeTTj4oU8drgzoP+Ps2smom33/gEDtA/LqA+yFm i2ppGErqESIKB5tHu4IP5Y+IEPbv/lFIUdS1hPvWfSb5JW83pP2Ei6An7hEQL1zTmVrm5gwcDPmgZf DM3QtlpHk2MRWPwsgJ9jOtApnh276CImhEznL9l19y9/DXsMkfRbkVwU52uLvEQX1WGNH+SItpBumv mh0u1FABHBkMVU7+QE+G8zqrMcE4RmbTIQ50rA6fsDZ/p+T91XrxtbUO0saWDfzKVzVZCh1CiYv9UU 1+6W/5+4Y0nrrWf+4JixsyIB+du8nTZ7yKMOwJtn8oIlUGMJanzqW0243dBA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Fix verifier state tracking in case of stack pointer passed to
bpf_dynptr_slice_rdwr. Add an associated selftest to verify the
fix. Details in the commit log.

Kumar Kartikeya Dwivedi (2):
  bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
  selftests/bpf: Add selftest for bpf_dynptr_slice_rdwr r0 handling

 kernel/bpf/verifier.c                         | 51 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 45 ++++++++++++++++
 2 files changed, 96 insertions(+)


base-commit: 654765b5c6d62efad270ec5f8a57802dc253d128
prerequisite-patch-id: c5126a1279e394882a332d246dbb726b224ba690
-- 
2.43.5


