Return-Path: <bpf+bounces-22173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88F858530
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520111C21505
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C513541C;
	Fri, 16 Feb 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNMwGH7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951C1353E3
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108114; cv=none; b=tvZnzq2kETq0IrMFpL2BxaXsIyMfYc0bmy4diKdJJtJYxiptlihV5WusMVPEyDuHrkgfsb211IcDjQ8cUJHMnUTuqFRSMdzt4mdTZasnHPITnhShfB0pwx4uoRlskr01cu5d8WnSKB+E7g0kaS+qYpxNdqe7NkbeaC20EJGbSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108114; c=relaxed/simple;
	bh=OH5rISz/5kn7MnjGXQAieg1ZvNk53OVDUVf/OT6MS+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTLWOVgGaH5vRpWoYsop2ihCjqAGW8UN0Jr5eNYhfYIft6RfO5OduR58miVsVCZz1P/TK0ZkKyij/+Wz+MoGySnUjx4Bz4Z2pRaV0uy01pAaklRXF8vsxluAxv9dJpoZOEE27qa1CgI1GWO2TFagSNVMszYcHAjPwBarYRaIypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNMwGH7e; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607a84acf6aso9353787b3.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 10:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108112; x=1708712912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+5pQXP1w4itce2swiRVMNdVYUHxgl4dE1h9VmMyGs4=;
        b=cNMwGH7e3hwUMXFEmP56guhQQmS3z+O5NKX1FrgioGcnKQ4ob694kUZ+vbtzqtkiMw
         jJ/umakR4OeiGKrPyF4iytCGBMmTshogZfU0AWAZ3VDS9EEyOy8DSOet7ASskhDP67qX
         oWLbLuIklR+7fD5JOohedpjbwZOR9tHOjFCHOrY3QOxDs8s9raatErHqGf1YeGJ5JS6F
         DqKyjxkEJ29PXjKaxvkbmHTRq+zPe9pN9/BerkI7z5YqkFuDBJVrQboY9s20hDPAc4vV
         FztPvveRotvWKaOiiY1olTBVUlU3Se5YGJG3J52t4GuSzn2F/guGs5+F2lIf0+LHZOyf
         CfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108112; x=1708712912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+5pQXP1w4itce2swiRVMNdVYUHxgl4dE1h9VmMyGs4=;
        b=PS4v93xbFtPIIb34QzDS5TgKbmrN/qBECtJ7ql++7Ox0df6JP5y9xliRE4nkr6+zC8
         YFh+2t0Qqoa6WirJvpC3R7fBv6OWlEkxJo4ws0d8TZWmjp4GZK0isW8lEf/JuEDq/b6U
         z+g8hXnxnTXbFy2/jN/WzBJ9hdcUzqoHKbBal8RYP76FOoLehtRGF3ADB2IEF0kLiBgD
         DU9EcYHBXADXtbQLDp6czzLb7jlewBqQVSfAf3hYQ0awNUy23Qtv0+rky+GCgXZMYcwz
         wGRQ145JQ2VFiNfrtKAnUkLobxgYcUFS28iznm2mprt41gW8RDwixnUgm3hbXEdQlEav
         WMiw==
X-Gm-Message-State: AOJu0YxWGGMZXejXmVpSu/TkYxIRoxAONQxvkaMw6vx8GmwM8HPun1EE
	AaBB7znDT+mfdkNiJa8BUBijT/vGdjPGeXX2A8rdEJApRk85489crVa9rFpJ
X-Google-Smtp-Source: AGHT+IHMy1SCuMuaa61KxqqYM8BvoaXb3zVwvi1H9jtkKzI4tXSv8yRZhAEaS/VDTRsv7WX80+1L+g==
X-Received: by 2002:a81:ad54:0:b0:607:f691:cb97 with SMTP id l20-20020a81ad54000000b00607f691cb97mr3299502ywk.9.1708108111681;
        Fri, 16 Feb 2024 10:28:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id z20-20020a81c214000000b00604a3e9c407sm436190ywc.41.2024.02.16.10.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:28:31 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 0/2] Allow struct_ops maps with a large number of programs
Date: Fri, 16 Feb 2024 10:28:26 -0800
Message-Id: <20240216182828.201727-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The BPF struct_ops previously only allowed for one page to be used for
the trampolines of all links in a map. However, we have recently run
out of space due to the large number of BPF program links. By
allocating additional pages when we exhaust an existing page, we can
accommodate more links in a single map.

The variable st_map->image has been changed to st_map->image_pages,
and its type has been changed to an array of pointers to buffers of
PAGE_SIZE. The array is dynamically resized and additional pages are
allocated when all existing pages are exhausted.

The test case loads a struct_ops maps having 40 programs. Their
trampolines takes about 6.6k+ bytes over 1.5 pages on x86.

Kui-Feng Lee (2):
  bpf: struct_ops supports more than one page for trampolines.
  selftests/bpf: Test struct_ops maps with a large number of program
    links.

 kernel/bpf/bpf_struct_ops.c                   |  99 +++++++++++++----
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 ++++++++
 .../prog_tests/test_struct_ops_multi_pages.c  |  24 +++++
 .../bpf/progs/struct_ops_multi_pages.c        | 102 ++++++++++++++++++
 4 files changed, 250 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c

-- 
2.34.1


