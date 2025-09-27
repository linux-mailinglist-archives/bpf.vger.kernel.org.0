Return-Path: <bpf+bounces-69881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3BBA59C6
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 08:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219DE17D64C
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 06:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47A258CE9;
	Sat, 27 Sep 2025 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2FRKvFn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECE22422B
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953539; cv=none; b=IXZD/LmhFmUIpwRJHrIrVE1S5kaCmx+QMLnbZXTigiHwM8bcGS7Rczu75slTHQYrzwFLhXqWy7yXt1XvSV5n5R8SSYYi+hle0HzfwHsaYWr3dIEFd463blU6dZIHKIUul15Q8pns/D7Py0LKjP7lnX/C5t5JHzRdkFtMeTGDU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953539; c=relaxed/simple;
	bh=S3l06A1JhTVKNOxW4NkqhS6UTCCL23vhN0vivrl4ftk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc70LdMeotIVWSmRazqEh3ZNjHO9Nu8U4t2VYxVxem3nmOaa9TIbp04bUVe2idf4JwFLLaMOLDX4iAVSKzArHvBU+L2tmfgjn1KRidkQYxHMjf6puU1y0qZCYaYHBy5nyPb8O5VzB8HvSRoxKr6I/e/vr2tDbC2aQ4ZJk62niio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2FRKvFn; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78125ed4052so715515b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953537; x=1759558337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=h2FRKvFnM2QvlLTKNm93QTjvFGMEXmT851L9FMbzHxRTRxyQTb+H+K2t3kwhYEdkyr
         2/BC8GqRQ84QBmXvkqPeRRCHZ6d/OHTGwMEvg9bdSddhRFxr5tzLobKs5B1JYmxoDth3
         kBRyL7pJ21u+GDpcyRAvf87BRmCTkZfWkh0c4NB8HY3Hc27tIPIe9+dBkQMycXzdrNQF
         vRHWUaj8UhjTw/5nzc7iukSeoS7/yqDUy44Fr6QwOPNG66AHUO1n0/FuWhCkygjt/ELU
         Qaw6Jw3+HztrZcYt0GJfAKc8tLimS1Ubb13tM6xxlkBxv8jyjBxK1qcI9DzlvoIaXbj6
         QkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953537; x=1759558337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0/bqr20eD9aHdr5W+3qtM0zghikkgsYOauT28Yj4ME=;
        b=Ypewq4k1jR9KDGv3oraKbteJz3uHpGQ0MSXhk21YluxrQdQHheKVeRlMgXzbsI/h2U
         1xHseuMB8YiJOeAG9Klr9bUwVLZm7LwRs2HNv6oCP0fROap4hsSEoVafq6Yl0jJuFFVd
         1lfYHnc7Pz+5gA5vwOanFEgpSjEwLythiPC7dFejvx0JVMKO9wfdtqMZQ9+vqyDHgwdS
         QIpzKNmE4T/jzMSpqUKDN29pzuelTsI9hRr/KhUTrzPnY50JaCIkGhbkV8AYQtfxwq3L
         FjvuQ5MLzUxRHE0Bk5+erw//RDYAi445ZSaAfHliTiLb2xwgeWUHP7RIIIfG9LXiF0xB
         9CyA==
X-Gm-Message-State: AOJu0YyLL0Onw+UFjQMUpTyT9PIl4MbUD/VuJJeX5aHc6p5hhlnHtjKs
	pyENY39iuWwyjYJJjPAfIkgCF74mfU0+ZeiJkGCRHoVOzVSV7VHTGYME/pBWiW+wO3c=
X-Gm-Gg: ASbGncvr8MgPGUy7pmyk+B/R9ih24wuF26t0v1iD2erOfqOeqyTbc2qu1BzTUqbX1Iy
	/Sbynz7IOHhqoAOUuVF858ZIwbDgJ2MgpcjbWAd8p5OIxptIwdpDCP8A/5F1m4STdlldiy/n30v
	DqKF7Nou5J50ch2b8K7OdLc3C2AFbT5QKAFqB6fa1yatADEYeSGxUO1GZkeDn1ulugMHjSLZG+G
	gwKR4i0GbsFZcCA7fB6DIGQN3Kftn+lMRBTk7pExlLKWXi7CUNyzWfyHQsCdQG5Bam0GQyVv6q/
	pcRmWzP+GonNZDRwhgtDsJxI1w+CQBw2WvCd04NXk7cp1ASa0wnbyxowomzxVv0T0NW/dIeKW+G
	jm9zXFAnu8A1OydZUleCzPqntRSrApw==
X-Google-Smtp-Source: AGHT+IFs9pSrNNpTib391I/iqQ3SZvzLn53SsMSuMurvpANlMS9GOQCN/CHJaj4SpF+KTUi5oYCZTw==
X-Received: by 2002:a05:6a00:3e0b:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-780fcef7c3emr9599121b3a.30.1758953537252;
        Fri, 26 Sep 2025 23:12:17 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 0/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:07 +0800
Message-ID: <20250927061210.194502-1-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can do the memory read with bpf_core_cast, which is faster
than bpf_probe_read_kernel. But the memory probe read is not aware of the
read failure, and the user can't get such failure information.

I wanted to introduce a fault_callback to the BPF program, which can be
called when the memory read fails. Then I saw the BPF stream interface,
and it's already used in the error reporting. So I implement the probe
fault base on the BPF stream.

This series adds a new function bpf_prog_report_probe_violation to report
probe fault to BPF stderr. It is used to report probe read fault and probe
write fault.

The shortcoming of this way is that we can't report the fault event if the
memory address is not a kernel address. I remember that we will check if
the address is a kernel address in the JIT compiler, and it will not
trigger the fault event if the address is not a kernel address. If we
implement the fault callback, we call the callback during the address
checking by JIT.

Menglong Dong (3):
  bpf: report probe fault to BPF stderr
  x86,bpf: use bpf_prog_report_probe_violation for x86
  selftests/bpf: add testcase for probe read fault

 arch/x86/net/bpf_jit_comp.c                   |  2 ++
 include/linux/bpf.h                           |  1 +
 kernel/trace/bpf_trace.c                      | 18 +++++++++++++++
 .../testing/selftests/bpf/prog_tests/stream.c | 22 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 21 ++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.51.0


