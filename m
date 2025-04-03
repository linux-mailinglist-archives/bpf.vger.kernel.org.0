Return-Path: <bpf+bounces-55269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA23A7B207
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75BD1895F38
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 22:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029D1A841E;
	Thu,  3 Apr 2025 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgaJxyzi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAB2E62AE
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743719296; cv=none; b=ls8c3pZ45tWP7azFRgYo8EraunmfLX2/S0H3E7bufqCWQacwv3SDZ4twlotQIN2UCYWfcNp513puQVqwgLyeFEaQ42dzVs65QGqmG6MgBb5neUBEmUggGVbs4oYObdqVD30bQ7ugglLmH/wL5tQVHrEwEyTZfI+u796oFbvOtqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743719296; c=relaxed/simple;
	bh=qZE8am2bWKnrFmImbFZBsYnKDe9tAvni7rSIIhn2PN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9yQc/PmKcpB1LCSN13SaK3vTmj6fW/z/0aMIdHdY9wabpbhz1qrU+aSwWr2rXdQBSXuSsn+h1vlh0DvU+b4SU6FGckFWDfd0zOWweABrIK8/2vdM52RtwE7aDxNXpGnei6dp9kTqoRqHNyP3V6PsS++rJ45vUDy9PfXVUWsesQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgaJxyzi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso8234605e9.3
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743719293; x=1744324093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XNzm1Bugmhxnjbd1guURZiDSX1Jl4jbEaVlTKKtqd0=;
        b=SgaJxyziQBezlV3mSJZvDjzh5qQdFUw98tGW3aKHSumhrmI0u3RN4ffVTuPOnhgOwy
         NFqXrsAAFXeZCnSJVYsEH6DkAsj2U2ZxcB7FJmd0c+KYwch5kUkr1HPbcwqhQ3QtAebv
         YOyPvc1SiNlHNDLn21fOlnyI24pi62CgrATeMPTwe61bo3wxdxx/0JT1TeYmvQpK99sd
         pr+wJ8sTowXc3v70JT/8VSKYUne/1U6z4ZeTZ8AgjeBHkOCob25E/Q2/dFYnrmjw1KGb
         Kpqp1myEECtTs/XLATSdsWK+b1iAMGqGT+klv4Gof3XJhwRoaFU/+eyZkMeyvEsWGxVH
         CJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743719293; x=1744324093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XNzm1Bugmhxnjbd1guURZiDSX1Jl4jbEaVlTKKtqd0=;
        b=tZtDvtBxwyfXnCorDnqV18dksOD+ZBb3pr3X2PP0nij/jTt7Vr3KZUG3nUYeBCpr5j
         Fuubkr3dBbHocB5cji4sXn32VqPxIdbiCy2RBfpFHrK5quGY8x8rEJx1NU7VUxT7X6dk
         kw8N0QBqQL/UHEtlkqNv55xJ0Tju4V7OSqnD1Hd2slN5ii7N1gRTV8p4OGVeo5r8LAAr
         LnZPBYlh5Rb0FMDivi5e3p4Gsu9iE7w5svL7QHpiJ+XNYVwAuq28haYpznzJtCQFz24e
         vIG96vzUiyWAUVy/CZPiUGhbZxGeLwT8RVAMeFoiu7jhtrQkT6mDG2R0TygTc7nW3okw
         INEQ==
X-Gm-Message-State: AOJu0YwBGoPRhCzteZle2+iwzf0dCBLUEPEwZoqnPx5+k+qfn3pOiCkE
	o82BYOfNWuIza2cLuU9FKnqjEqIdB2cgp2KHJCcCVzCaV9faFip/ALvA2A==
X-Gm-Gg: ASbGncsG523Sh6GO7fcgAU6+LTafX+1dX0Lq4agVSVBPAFU4Xs9CAiuAdU5OI6q4B6j
	0KPgDOPaBytVnZI3lPwxC+De6vfCLFkWNOU+sMDKEPBiFUUjpUgQMqv1vt6/coKozhXoGs+y84e
	UHH+4BbPoag3i7Zs/Gty8vnoZXqEAuL15vButkWeXWA/MSPsZDfVe39VZPo7ACAJGdg1cbsc21A
	ZO8IJLB0P9Ss1nyvjkDHJhxOhOEvIHnU2YTuHSz/vuaYtEv72rKwaCc12epGWijT+z2yDVHId0C
	LD9cYvyP5zfGpc9IRVPNoAnLYQ6UCWDsnWDqR30mg+FPciq781B9AE9CYQDQMwc=
X-Google-Smtp-Source: AGHT+IEteCYNj0Flv8MxdNHyLGotOvVvwYys45Mzb0nW2oc79myUe/52QJamcclUKjF46cp0JhEGsw==
X-Received: by 2002:a05:600c:1389:b0:43d:cc9:b09d with SMTP id 5b1f17b1804b1-43ecf9c6111mr5001935e9.20.1743719292339;
        Thu, 03 Apr 2025 15:28:12 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301b816csm2846925f8f.57.2025.04.03.15.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 15:28:11 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 0/2] libbpf: introduce line_info and func_info getters
Date: Thu,  3 Apr 2025 23:28:07 +0100
Message-ID: <20250403222809.90634-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patchset introduces new libbpf API getters that enable the retrieval
of .BTF.ext line and func info.
This change enables users to load bpf_program directly using bpf_prog_load,
bypassing the higher-level bpf_object__load API. Providing line and
function info is essential for BPF program verification in some cases.

v3 -> v4
 * Fix nits in selftests, disable some asserts for s390x, as it seems that
kernel inserts preamble into function entry point.
 
v2 -> v3
 * Return ENOTSUPP if func or line info struct size differs from the one in
 uapi linux headers.
 * Add selftests.

v1 -> v2
 Move bpf_line_info_min and bpf_func_info_min from libbpf_internal.h to
 btf.h. Did not remove _min suffix, because there already are bpf_line_info
 and bpf_func_info structs in uapi/../bpf.h.

Mykyta Yatsenko (2):
  libbpf: add getters for BTF.ext func and line info
  selftests/bpf: add BTF.ext line/func info getter tests

 tools/lib/bpf/libbpf.c                        | 24 +++++++
 tools/lib/bpf/libbpf.h                        |  6 ++
 tools/lib/bpf/libbpf.map                      |  4 ++
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 69 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        | 26 +++++++
 5 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

-- 
2.49.0


