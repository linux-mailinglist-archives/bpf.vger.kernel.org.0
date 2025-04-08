Return-Path: <bpf+bounces-55489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A78A8197C
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 01:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69483BCEF9
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E62226D03;
	Tue,  8 Apr 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAePThN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DD522A
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744155934; cv=none; b=Xt7pqKr3o4k9B81IhdtlHhIuyXWfY/tOUDHFQhlFIbIyKmXI24liv8OFhQCs9VKoEx0uoIlvd+zuge+W/dX4gRQnyYt8dACL2mYE+5YxGaPySbcKE77+RSPyRt7LGBs//ndcva8WzeUkndqQi46lJVM5KTjk2afA1FPXcMDpYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744155934; c=relaxed/simple;
	bh=56lZxgXc/OS0Qmk4rHgnQXFt6lE91KvaWpeGivBO/w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFKg/sDSCNgHxweeXRnH5GhBzL3ehugVTUaRtSaVFbhWUZDOMcOMQJO9Hd9lK65BHJtEOX4WKqcv9Zk/qinPT4C6+dhY0T6AWWTSPdlAd9ATO7A63My62oTHxaVCJ/39zO85gf7bQtSgwVdBI5MwI+n1uMRLtM0Mu9aBzj5kTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAePThN3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so5755142f8f.2
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744155931; x=1744760731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmRXTmedtLEduzinV6eFdnuFoCIQTSbgs+qPYS8ns5k=;
        b=MAePThN3L/henzhBcqdxUjolxu7NxqY2nvlPllehTOERSvtmzF970g5U72F4/YEs6K
         IJqwjjuctax54ZTjGKt5wnLI0Hczou2oA7kotFyIAasLDDZRQm5s9R9NB10L4pYYd714
         LNjnr4L9kHPqOwIVNryYA2bKYu4Tq/vGEBq259sgVoOdy50GppR/HEQPe47U0FeGMB/Y
         TaxA+uGN/ZMJPrG93YR8CbmNej/X08Dwornp/8eo9eu1cvkXrqM4qLVW6NzaPrwNaPpt
         7KO3/VsC5sgpCd516iMvJXtNm6ErDQCJQ5fRRpsdVLM6nsx6TXQxAapp9w/1+GiKzTJC
         rkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744155931; x=1744760731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmRXTmedtLEduzinV6eFdnuFoCIQTSbgs+qPYS8ns5k=;
        b=HGmllePP03H2GAibWnSDd/FgUsXTQbDWMYwGTTfwfl1kcGTfOBsr8d8Xacw4hXT5Bc
         rfYBNbELZGWNDe/HTACvg+iJiI+MthbRf/bDEaJcTJAHyDohJzXFPnjtlD9V0gMqhDP6
         TWuP7x1X6NJ/5oDofut4Q3doBMJnywiYLGFcuhYXK02LLa+5AcyBNuT5xL8z3I0cORdK
         xMjSa+SC+FXYsR+pclNR7hia1FuRcP1zfVJyT2UJlBsHhhWKRpscYfRzAoLRnOMM3Wen
         VuKDENC8jypdrut/wbEM0GebxcxLzLXkjJGVZmKVz5qz6P75Htd+zwzxQU6NZV4EUxKo
         Cseg==
X-Gm-Message-State: AOJu0Yx2EPmZSUrUUgG9x+89ORmDn7rZ6PG1/V+ooacBf3bkaz7yt+Qw
	HamQSXNlsH6XnWaG45Oi5Twre4Mz/xVUCHX6ZX1I4vv7ZTmDN5z30OIB/A==
X-Gm-Gg: ASbGncsl15VKxvsp6MVJa+cWU+5vY5WNkf1sak4aemzP35lx0GcnCQ1eXMaLLjFAw7g
	Q1dcIne3vkUu/yJoKH/qGjM6hON3WaIUCgUDFjPbtXRlYmdQyyGSa1Y0BGqb0pb2rLcHRtMCqtz
	EwOPcMxfDJoGfnMeqvSNHKqVIu5NVaWrxProrVp6CVmmKF2UcWzZw5o2s4CeeGnIrasuQvsRAO0
	nYI2JpCRNea9tNgccERrX9AXwfUA4KW9eYMKs5Ms5xnsm2K0VnbdHt3t534aNiuPh+ByHedFIRk
	BrCJdJ5riQr9bDIWgqIJPLRWuTAMKRXd5cmrJhI812/Q8dhofph2U743wresU+c=
X-Google-Smtp-Source: AGHT+IHFhrAh22R70xDhcSJ2wjmXvFeOkIYCQkcgW4e6Z+8QnxA2tgEi1GZbDmjqxsNkR6b6WlTrTw==
X-Received: by 2002:a05:6000:1863:b0:39c:11c0:eba1 with SMTP id ffacd0b85a97d-39d87aa1bb0mr743256f8f.12.1744155930682;
        Tue, 08 Apr 2025 16:45:30 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ec97csm3012485e9.6.2025.04.08.16.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 16:45:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 0/2] libbpf: introduce line_info and func_info getters
Date: Wed,  9 Apr 2025 00:44:15 +0100
Message-ID: <20250408234417.452565-1-mykyta.yatsenko5@gmail.com>
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

v3 -> v5
 * Fix tests on s390x, nits.
 
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
 .../selftests/bpf/prog_tests/test_btf_ext.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_btf_ext.c        | 22 +++++++
 5 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c

-- 
2.49.0


