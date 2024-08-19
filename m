Return-Path: <bpf+bounces-37527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D54957037
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A70A1C214B1
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAF173357;
	Mon, 19 Aug 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQaCnSja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9B82D94;
	Mon, 19 Aug 2024 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084894; cv=none; b=c9IxcDiqrTLZWotiZodv27h+6F9lxd5faUMjlcprNvZy8oSgww5CS3LruJ/XIuSTHfmiei8mMYTlgcMQqTAvZNx5OVOt9Mlt4OyAoJNZP9ONXzqqct3CRnD7Ha50zxg4/14zVA8qwN2htN5z6Y/RKuUMmSPASFSjThnA3KAS0cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084894; c=relaxed/simple;
	bh=vC9JAIfCuvDHh7vpdNb6h8RbUtFwdoeMHPGlMRafj+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQpL3UrRZOPrwTkTNtuU3M9N3GgqZwnw9O1STIbYRscyxD9iOPDQMiCOIYnG13JxyhStIMF08mnv1A7gMbNtBRuMqPsMFer+VXsLAp8sB5IGaAIPCe9+/fzGvEbxxFKLRxPErQKm+L+0KLi2QFynw4gJo1/SgUgjwYl1rl1EqPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQaCnSja; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e0d18666so35536705e9.3;
        Mon, 19 Aug 2024 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724084891; x=1724689691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtz0Af5ja2u23xZFCVerYShafOsW3acMuX/GcH2zaIU=;
        b=QQaCnSjap6erogFB8k7pDOKWpHjxj3yihkdwo+AORPqaeNXFIiRLnAUqR+8WB5onIg
         0AkEluIgVgj2cRwoEqSW8CglTsrnaM5QMXuuoRdYoN29bNHOK9km3lEFWKpCOT7GyOB/
         4cJmRK+IMM0sWqlgk7oASNjiEOFAWQO6zU5tbrzXUOBWcCBM888NPwHA2DuTNF/QU9ga
         lYQ+jc7R26yjAteya7vVMn1XlsnjVKXp9P6wQWttzEr/m+RQANeqMbAwvxRPa2mkNhqw
         FhRTPd+JhTB8LId5/kV1RH/AHWJfCvB4JWYhnCA+IJdw364P7/8oprkZ6nZOZNOujjvt
         j4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084891; x=1724689691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtz0Af5ja2u23xZFCVerYShafOsW3acMuX/GcH2zaIU=;
        b=Atj0p23KI+9DcG7RxqYURWGGl3lCDnQhADdLwTmcWohu0MUc4dB7bU4Rx8cWSKP1C2
         WcvkptTjfUnstLAW+lLNVxxlijqayDAQylN8ov/k7cllaaw56dDH1bC4CrxDP8aYn7T/
         3pYW1pFAxNoN+Cy+P841cXRfhVBB8tWbf6fh/hcd3gLw/LPgJvGOBPocxr2Dl4Av1pr3
         pXJqqWiwUrKpuuPe0zDIyjOK+TXjYHCXoudK8ttTKuAwhsunAU5Ad1idZ7sEo3MT5lFv
         DqN0PQmgUV2A6Ejihnkc83brWAKv6Ezfy0QbP9mR1JuWyBS8fMI24/Rtry8m92ybpW5S
         KuEA==
X-Forwarded-Encrypted: i=1; AJvYcCXCX07dz9Md3xSckH00w8DKvcP0eyDkWOg+MnVTK3QwWVwDOekN/c4oOiv8CUw5SIzSp/IXayX5Fp+l5ZS5jTmyyNYRxLUoMGAx3L4nlofGO0nVuI8MSwaBrWy9G4AD9/ndfM33s9B/
X-Gm-Message-State: AOJu0YwR3ZiqXDMLH9L4fX8pLpXjgAdmk1NgbesLJCxhc7/mzo5k4hKp
	uxd2sPDWAF+qNGmSKssFcINozWiB3W46JTlpk921oWI2X0TAohdx
X-Google-Smtp-Source: AGHT+IFEcNFUEhJLZ3PYy+FuRg5XepkePxsp8HpYtd+htRsRv2HU3fXlWmv3c5vq1aSIBJhNut3zNw==
X-Received: by 2002:a05:6000:1006:b0:371:8eaf:3c49 with SMTP id ffacd0b85a97d-371946a32a9mr7080797f8f.40.1724084890478;
        Mon, 19 Aug 2024 09:28:10 -0700 (PDT)
Received: from lenovo.fritz.box ([151.72.61.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897029sm10922134f8f.74.2024.08.19.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:28:09 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v6 0/2] bpf: enable some functions in cgroup programs
Date: Mon, 19 Aug 2024 18:28:03 +0200
Message-ID: <20240819162805.78235-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

Enable some BPF kfuncs and the helper bpf_current_task_under_cgroup()
for program types BPF_CGROUP_*.
These will be used by systemd-networkd:
https://github.com/systemd/systemd/pull/32212

v5->v6:
Called register_btf_kfunc_id_set() only once
Fixed build error with !CONFIG_CGROUPS

v4->v5:
Same code, but v4 had an old cover letter

v3->v4:
Reset all the acked-by tags because the code changed a bit.

Signed-off-by: Matteo Croce <teknoraver@meta.com>

Matteo Croce (2):
  bpf: enable generic kfuncs for BPF_CGROUP_* programs
  bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*

 include/linux/bpf.h      |  1 +
 kernel/bpf/btf.c         |  8 ++++++--
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 24 ++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 27 ++-------------------------
 5 files changed, 35 insertions(+), 27 deletions(-)

-- 
2.46.0


