Return-Path: <bpf+bounces-48635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A324FA0A75B
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 07:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61F23A8A3F
	for <lists+bpf@lfdr.de>; Sun, 12 Jan 2025 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A951C5A;
	Sun, 12 Jan 2025 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfrA4A5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90E14EC60;
	Sun, 12 Jan 2025 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736664326; cv=none; b=JFdkREmt3SSg/o3r1WhJcOSOWTBLUW0L43PrO8IM15jv3gM4NSdBJLpfPPEiec9BijrQoOBKqGG/uk7LGR/R6OT15bQ7g6Xxac4DEO3Q4UqgrCrIrfIEuoB3QJz1cHEQB91O60VbxzLw/zVSqrlBi2PewFSH5d/MpJFjNkjrRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736664326; c=relaxed/simple;
	bh=Wo/niDj4XWuBrTD9vkbMN8C0xUkZN0B4d99vyjfKrpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c7bxzJTn2oPANRpQ0RcxlgraC2RMGiNQu6ehVL14+0bBEPBeREFhHRlzl+9bFC/+E64OlXMgFEmuZr0BMWxQPUrO24rxZC69l8Y5nk35/W4KlhZUdrFG3swlBvPJWXPgEpe7/R09YqCGtOGUCqQ7ODB3ZskzC2wJ4kXLg7arQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfrA4A5W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21a7ed0155cso55660185ad.3;
        Sat, 11 Jan 2025 22:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736664324; x=1737269124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KM8zEtHG+fY4X8Wwa0UgChQrVmmncC53lXbkZE2M4M=;
        b=mfrA4A5WVV/cQNAt6GozsBoLNRbThAP/2SLvpDvXt0pSdh4+3I5UU5/DmmREzQ/OAn
         xBhrH9JnAaGowy7lV6ED8xirAxGT81m9msxnXjEer4fKI32aphDpXNebPMI4bcsStb/U
         9y/q6IbX/xn/2GIv+LnXnASwbb8zbRvzRUruoUdxXXaxo/zEBXzOt5a63Ff52x75fCVV
         q7xXhOfy1c8dnWZgvwTFtzeBJBVEEr7N5C2bTGPJgOPp2cPfmHPGN0mRpzrn8dWQ4t9j
         Xn56VhNJewpW6gvQrNKwQvd6tpoKGVSepzkOSQcGAa4pVZsKrGvARBVMfhZuetviuCq7
         1GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736664324; x=1737269124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KM8zEtHG+fY4X8Wwa0UgChQrVmmncC53lXbkZE2M4M=;
        b=bQo79EDDIsG3C5BQbaJOVI9E9nwWhqemlkt5OOYyh3SZCUL3t48xKn5VN8HkzgRQ5d
         yt7l7t2vxJu/km7ZfxymzlTUwcyF++kBtFYj/+dgyVfaKgvR58D+sWg4H+v4S7CR1sNG
         9AU5MDeT2pPkDT+jhGfVyy+UMeshRFgwB0nQh8ekASp4fDf8uE2n1iq5YxURF11Xoyph
         ie56nhZrcVDYoMaz6KzoiuzsnrJiA/MgQonYfllHx38VeBGIFI5l/FlSDoagIeiH67n+
         v6LOHSXQYdIvBacBo80FP+nfo+UDYXiYE0Ymu0BuXtRKO7Y7QtqHbE79EoRWqxbqpt/i
         e6IA==
X-Forwarded-Encrypted: i=1; AJvYcCXIFvYbRFUf4oEn0G/uH2ZalpCWfEvU5XrFaZtRrm/hIR7kOtN55QtqJ0eMW19deR0X46HFVAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1d8Wz1Whtfn83rOLw8vTzJVK8jU+W6w61PB88kjLIV79unHF3
	tcEeulPJyCjroTiJEwGXhotneHSyIT5QVmtjuC05kR3IxWyvMWuw
X-Gm-Gg: ASbGncs7H0GanDMmvqByZpWr1/OSO9Z+C7U/9aGV3CIGXXee0wi2Khs66fTgxmetoUG
	I/wMx+GAFhu/AQkW9MGsxEmej7KbaIsnjrcaULvwS6G+KK3IYKsyT6oIrcveAJ6qW9/i7ECt//h
	ntsdvNPTtoXi1WfPEPZZQyDb/6DVhB32C3zaCO43pfcvDI/V6zuzzAdBEAKMAUsccHymKgn9Kj4
	uhntNT4nYOTCHpBj8iK5Lvl49lhxN2ktZrnCuRpOuncyQGXjAqAwbVMjuH2OOZjGa3ckcZVpfOj
	K2jI6Ts=
X-Google-Smtp-Source: AGHT+IGip7RqZ8aTxlkkWN3VaqnhMjyMaRTmQq12zBl1Ni8iqZ8MjuY/h6B0I+MArRsKqKb99LcIMQ==
X-Received: by 2002:a05:6a20:72a1:b0:1e0:c8c5:9b1c with SMTP id adf61e73a8af0-1e88d0a1e5amr27124372637.9.1736664324092;
        Sat, 11 Jan 2025 22:45:24 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4059485bsm3791166b3a.83.2025.01.11.22.45.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jan 2025 22:45:23 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	edumazet@google.com,
	dxu@dxuuu.xyz
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 0/2] libbpf: Add support for dynamic tracepoints 
Date: Sun, 12 Jan 2025 14:45:11 +0800
Message-Id: <20250112064513.883-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary goal of this change is to enable tracing of inlined kernel
functions with BPF programs.

Dynamic tracepoints can be created using tools like perf-probe, debugfs, or
similar utilities. For example:

  $ perf probe -a 'tcp_listendrop sk'
  $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
  enable  filter  format  hist  id  trigger

Here, tcp_listendrop() is an example of an inlined kernel function.

While these dynamic tracepoints are functional, they cannot be easily
attached to BPF programs. For instance, attempting to use them with
bpftrace results in the following error:

  $ bpftrace -l 'tracepoint:probe:*'
  tracepoint:probe:tcp_listendrop

  $ bpftrace -e 'tracepoint:probe:tcp_listendrop {print(comm)}'
  Attaching 1 probe...
  ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
  ERROR: Error attaching probe: tracepoint:probe:tcp_listendrop

The issue lies in how these dynamic tracepoints are implemented: despite
being exposed as tracepoints, they remain kprobe events internally. As a
result, loading them as a tracepoint program fails. Instead, they must be
loaded as kprobe programs.

This change introduces support for such use cases in libbpf by adding a
new section: SEC("kprobe/SUBSYSTEM/PROBE")

- Future work
  Extend support for dynamic tracepoints in bpftrace.

Changes:
v1->v2:
- Use a new SEC("kprobe/SUBSYSTEM/PROBE") instead (Jiri)

v1: https://lore.kernel.org/bpf/20250105124403.991-1-laoar.shao@gmail.com/

Yafang Shao (2):
  libbpf: Add support for dynamic tracepoint
  selftests/bpf: Add selftest for dynamic tracepoint

 tools/lib/bpf/libbpf.c                        | 29 ++++++++-
 .../bpf/prog_tests/test_dynamic_tp.c          | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynamic_tp.c  | 27 ++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dynamic_tp.c
 create mode 100644 tools/testing/selftests/bpf/progs/dynamic_tp.c

-- 
2.43.5


