Return-Path: <bpf+bounces-55089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11A8A780DF
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 18:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDBF168882
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106F220AF67;
	Tue,  1 Apr 2025 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPhSqSZV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1F194C96
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526464; cv=none; b=oxxVNEGlppy1yIVWQxu/Dp5z403qSwuvmvCgNoCIBaITkUhZ4lSxKf6g6mDCqmkE2/Akc24F6lbIiAPzGMMkEUugmXbYLts32328Iqufx93SOs8iQgXQlL9I14M/Xi3O6W6yIiGiUj6Wfvdz4d5FfqS5LslcT0p7JmGDiG+zALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526464; c=relaxed/simple;
	bh=tiR1NGMSHYa66HsUPMGvGoaVW2QbWXfRy7mLBSrMgX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlF0qiKqgED6Imo83qfLInV9+abxg7gQHDrplXP2CjpQQiTNZglo2w0yuVM+W/543BbexLdVWx15X7LV+2ZRKFTnC6FIbiwGM++PVPwO8IDXi7X99gfOlphVaPGX9fuRx0TG2EVJ6a1rE9ymfR6vxcZilzEMbo1dJrZ0M7b0xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPhSqSZV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1174062f8f.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743526461; x=1744131261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jESi+RT+VRuJbxvwNGqWWFrSx3NTOs8uAPSXu5nVIY=;
        b=lPhSqSZVJcPzzQyE0vaLpGiV3jDwuckxEBDQX3vcjAm0ErwG63paFIDo1gz0qdRpNs
         AuBQDdr3D4VrFJPQay3WeMaEic33KinSh6Tc9hHEa9Ed7BNfxNaDkkwrY7UPraZ2Ewtu
         YWQKoM9CSo0V8WV2FW4FYV2QKigDmtKP7io0DO7ONS1h4VUQb+nvft2LsPMwtNYnOJAE
         jlksyxe7hdGw9tVNrgrKL9JZ58Ew5oV0P09fhd0kLpIvzj6I9ohzUvxaPg3VTDctt5z+
         A2f8Nmd+r+RXERrn/Kv+rwhVb3g0n2ZUsvFQMnIUdnohiyHItgPy5NX6NLlnuwH8auU3
         LW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743526461; x=1744131261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jESi+RT+VRuJbxvwNGqWWFrSx3NTOs8uAPSXu5nVIY=;
        b=I25IVs4WQGAqDfCRSzzkGaJ6uiHcmEvTEXa3TIRhUNfUF3I0Lj8OnNTsb6D5X8xnde
         1BHt0olUtlJsci8U+pAzakV7Tc1V+xkTbuYG25CcvisaktdNW0hVNDSyaJ8a4VdDpqpi
         9+2YT2VHG+QBz0ilCeQ4pvdbl26j9H4akMxl16HRjQbSEr79j/j0v+XuDR14Zr9rWI1E
         KmrCMwGqE55nIcMfSJfBmII24hy9288FK9gk+BxuDvlC0hsSlo6DIqrZRW4djN/qpunt
         M/ZZH1Ar+1Isz62VSwmVq2NU11tHQisy3Ybj7Kbm5ulI3NFj2x5tHCDKFCu7T8mXpOvm
         qRDA==
X-Gm-Message-State: AOJu0YxMTIhPAPWef+ILhuxK22kDkWO9cpu0i2FZbEOgaQQUaRmzoOiG
	QUlWX1h0hryB+gqcwPA73NLNPFLAdYYDfcIXNI8RSyo9PFFyrLgLnUeCTw==
X-Gm-Gg: ASbGnctq5PM7YrqyCdAFxpPJniu1Efb/UZC2KY3hWXg6AaY0Ez2mQH+Y+1++EGkZE6P
	CXnmWJ2VKf2d5mZUqVdmaB2fn3GX/tMfGqcvP2SdjnMq7YLTLlOx7CQjNvR9hZFNrVQqEEFbSG+
	tu0a0k1nP3II2x+cvPqklIofB27ORXbgZ41HEMCm11JzMhJlp2tIBQn38bfo9pyBXY7B+gX5e+h
	r2YsLFF5G4Sw2ixI2aL21kjAXiy8EewpXw92aDqmxDF8chAsStUX7qbAtRcWF0eMrEV/o12s0lv
	yMFT9kUuAanx5n9zGDpWAuobRKdVu3IoF+iNHPdtkx1RoiU+xU/0/zQlEtNC0Oo=
X-Google-Smtp-Source: AGHT+IGzrsgBJKYSa2B8QaYfsnC5qMbt8l+ECyDxouqPd4eCExJmz1XlunerrXSp4dI1qAXnjvloSg==
X-Received: by 2002:a5d:47c7:0:b0:39a:ca0c:fc90 with SMTP id ffacd0b85a97d-39c120de403mr10623926f8f.14.1743526461022;
        Tue, 01 Apr 2025 09:54:21 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d84632ffcsm201397215e9.31.2025.04.01.09.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:54:20 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 0/2] libbpf: introduce line_info and func_info getters
Date: Tue,  1 Apr 2025 17:54:15 +0100
Message-ID: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com>
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

 tools/lib/bpf/libbpf.c                        |  24 ++++
 tools/lib/bpf/libbpf.h                        |   6 +
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 111 ++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        |  21 ++++
 5 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

-- 
2.49.0


