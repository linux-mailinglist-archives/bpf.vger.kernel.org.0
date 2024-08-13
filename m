Return-Path: <bpf+bounces-37016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375989504CE
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBFB28312F
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD11991BF;
	Tue, 13 Aug 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBhyIjq+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39741CF9A;
	Tue, 13 Aug 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551668; cv=none; b=KPyn1QETPB6ipAPbnh/YD1CafOol9+01uXmjAMubzSSbZwRBW0FmNIwPU4bJeamie7ZSqFAz5x3jG3F0gAaK4g9i2p2YepXNRvb9jxfEozPTpj/7j/KU1m8NKR/XeHI82VAcn4ybLbK074ZudkN6qOGdQHX92U5D2Se6iFRdov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551668; c=relaxed/simple;
	bh=b52W3h2G4P5UP8NCESlyaSLBng5JFv09JHWK+kZaCyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9dRS7mLxuaez3IbsPq4VXUf/7YAoWCNi9VDoM7JPJRUfQ3W8Hi5nAizEkT//bWj1NU1Cp5ClJXvADpdomQlPWQ8NPF8pMpeB6EAjoshY9WXMo27Lb5V7QY2Ubz5OTPZfZJK2mz8BgpDdIwdBN/zJSufQxZn8nMTjU7ML1wL0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBhyIjq+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aada2358fso961089766b.0;
        Tue, 13 Aug 2024 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723551665; x=1724156465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOAxsiK+wFcTkNnMl59b++r9YDEJAEV6e8wbnPnFndE=;
        b=UBhyIjq+j7KTQXocKomgxp1Hw9jlk+shJlJO4q9himOK4pQIbZeYr8JL1om3L+wo5r
         bMiHwdHVSvgWxGZ6AyorIBIwOnDUd+c1EayV4YI1UybNrAVOaMk5YiIbHrGvK8H3YQJH
         gbx+Qc2smhjMGYyVBqCFcPnyIUTZr9S8I6lm7OuaQkYIRU4CQr/h4SJ1SCTxm8E0jYtQ
         H+blEi+Z7Go0cdCvFnxWflbmWA28axiD3Pd79PMbT6fQ9vLG2P0UTW3JUHA3HSkMMChP
         g3Im0OE+cYhOR3JLKKWiHosC0Z4GrSjGym3WiZG4GC4VGc6FJo4hwYb8b4bSrlS0RLYu
         kXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551665; x=1724156465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOAxsiK+wFcTkNnMl59b++r9YDEJAEV6e8wbnPnFndE=;
        b=PX8WI7Czj57w0a5ilAg7FIb9Z1BeljsQEuFa+IwMSWCyKGmxvoqxdpG0Cj8HUOTmJu
         cd/8dPKUT0uRmFumly81lQijrgqc4wSiObrCPzFCc3araPoXdo2wRz2DFj9tVJ+JUsip
         H9Ah0YRMSAvbjNe3Q7MJCN0JUprLxr0cbAvTMtQ6Q4pcrI46/NIX3nxI3ch6a+2JWGMv
         j/GLd7auNvcseR5iSbyuuPScdF1d0L7PZgotSfDN2NlUHEGUqtUGjJHsV0Zh/g3Hq4Jk
         cT2D4PsoE/DO+bkeEkviZyT/cCmJ6e3qnpg921z2z4W4ffrizkIwZSJjnQa4vdub6+W2
         Zqdw==
X-Forwarded-Encrypted: i=1; AJvYcCVHrDweQLlz/r/h4UlVDJveICoPrHQeBL3etO9WG86l5fvd5jk1Ir86bY5Kn2XyQEC2D25WM7RZQ+akIv7A9A9Yybf5Qe7WvMmdRZc4Bwmk2dBxs9mF8vJTzE7wsoKavhkylUmLNLBM
X-Gm-Message-State: AOJu0Ywi59MnuGD/h+CQzyRKLs1cT6Uv+Gzfv0hXZbAJTwTVmQOoA4cU
	8PfAtsmi/WoKibk3uIGpWDXa9/y50V3m7Q/+UXLwfbskf5fUjG+bNq30Ui5l
X-Google-Smtp-Source: AGHT+IGJ5TE9O3tHCy1/atK/zuV+3v75/AcaMaf9xeoF6ny9L0FD+LMoJa02LnJ7uqKabW2N71aH2A==
X-Received: by 2002:a17:907:7e92:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a80f0b9d525mr261524066b.25.1723551664640;
        Tue, 13 Aug 2024 05:21:04 -0700 (PDT)
Received: from lenovo.homenet.telecomitalia.it (host-79-17-17-86.retail.telecomitalia.it. [79.17.17.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f41849cesm65358766b.199.2024.08.13.05.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:21:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Tue, 13 Aug 2024 14:20:58 +0200
Message-ID: <20240813122100.181246-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

From: Matteo Croce <teknoraver@meta.com>

These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
should be safe also in BPF_CGROUP_* programs.

Reset all the acked-by tags because the code changed a bit.

Signed-off-by: Matteo Croce <teknoraver@meta.com>

Matteo Croce (2):
  bpf: enable generic kfuncs for BPF_CGROUP_* programs
  bpf: allow bpf_current_task_under_cgroup() with BPF_CGROUP_*

 include/linux/bpf.h      |  1 +
 kernel/bpf/btf.c         |  8 ++++++--
 kernel/bpf/cgroup.c      |  2 ++
 kernel/bpf/helpers.c     | 29 +++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 23 -----------------------
 5 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.46.0


