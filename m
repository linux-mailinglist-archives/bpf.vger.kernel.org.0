Return-Path: <bpf+bounces-61549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5CAE8B3A
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 19:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D641882804
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159E2BEC33;
	Wed, 25 Jun 2025 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWr221g2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CB269B01
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870756; cv=none; b=OtXXuy76IKAe5byD7SbMw3ldL0aT4RL1NB+rqtlYPb6Ffsxm8lxrZFIOZf0BWaz7z7LaM8Wjm74OOUX5ygfuTEVlhQR1CoJ1YXaCslFwKh/CO0/qMquuozM+gP7nr/bo3NrvuDzeckKkT6dj8ojG8dYLNT8trc5CuAGR6UhKY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870756; c=relaxed/simple;
	bh=XSMojdWkzJf5O6LtS7u6BDcvmbcPaNpEej9RhoX1i9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IzNFREcaNd3HXAR/DbAxXP/afwfIEgp33D4B8WmDyF7zmUeSChH7U2FpHahlibc+rmd62kEFqYvCTZCrjaBGZeoGyJDjoJmKoIZWLFwD77sCSI9DelzbCxk7yxzyBlHQy+/cyi1vnRCcsGuewTqIEs+vrQ3CLddpSZj5vjmt6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWr221g2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so51514a12.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870752; x=1751475552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfSrpz++dMmxby4TZp0ksLFsAPfR1edbNWtPdAgaKQ4=;
        b=VWr221g2P89xDg+dbtzy7TQ0A6eUHliFJztYB6DwEPWtc/D5wvz0fju10YebvukhCL
         q+prUlZ+fyoHLdc5wfH2YrzO/NGBw24dAGlKAswcrQNQtloXwVInRn89xRQ7RQG4Dd0L
         cMkKhul6QUzW/jTwEYjUBlOhJsxEFpJCU1QyC21RTSZo9+vwyiDzL0pZuGsvSK0mgelV
         ycKHsL1e3r6a8UIgYgAtVfPsx34Apbf8eR1/rGilrvYA7b5ZfLy8Hx1tQ0/aghdHRVAU
         A38NzgyQMqKgAfSew5Irxx/vIiODvcHRZEkeGzcBhcgnlqBM6ltUPak+bxX6L1AaEl3R
         gmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870752; x=1751475552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfSrpz++dMmxby4TZp0ksLFsAPfR1edbNWtPdAgaKQ4=;
        b=kmMQi5czp5wxdiSyCnW11uqadcDAbSUoGa1jl2wG0L2UOuj0slmTkD9NpuuQh2zaD4
         V+0q8rT09RLri3ggxp/Zi6T6b+IwKND14asEqexJt18EnGmfX3nvrXd8gxTA/XdsqT9a
         t5yhRYzzLKscSeDl8xZgMUfZYNPurA5+7TYDFiLJKhxgjlMRiKU9Hf3OxwKMj3WEuRFh
         xgJK7bUqaW2yaWMYyUoOksKnLi0gCLeRHTbnkxfPbDzewteNzhy1AguLseaVDsPA0AIK
         3LVEGZYJ3mkVWE8rA4xwtZLYrKpgE7OH5LZ6jUeR34k0Tunm9FFXMBRBd89lZR0kYK6a
         FozA==
X-Gm-Message-State: AOJu0YwXkGhOXhRvXUq+FAyC/nCFzAn5Q7QaxWUNwpEUr+Mvq9No5TTp
	w7vEIH44Azfd2EVcYQ4mN6wHfxB73HKtS6pP6Gso7Mw7HLDcX145xShqcELZ4Pvd
X-Gm-Gg: ASbGncs9qYPVw/Fap4Dhx3SfLHuTf6+3MOPCspMX0kK/bTfi3xsAI9DS+83sRpPod6O
	SoJhGWMkMFr04QA5MhNTJhKWTxrrupW0SWK/iPZuEi1BE9DSLghIUe8GQVa/bvl5auQBcH47Uj8
	vOyF2M3ACC0Ka7mIkH+/s4wTKSjlUhjQA3waW0AB2FSU/azzxjyuIw6QEJ9Xhrc4VYgQUuiov5W
	tgeSjiYjONWLwL0t/hhSM3MS87i4ZdPhdmyzigVnGKMUBRogNG0RuL7dsUEDZP7+fX8EGinhM7f
	I8KTY57J+NPuwq4xPLGKkHjPR2JmJ0NvCGV0V5SiDg==
X-Google-Smtp-Source: AGHT+IHPgXrdLD8avWncdHlyd8LF9uouqHcsma2RjkFaWPWdNDtU6D9ubN+NxRUKdZTnjEoYUIuj2A==
X-Received: by 2002:a05:6402:d0b:b0:607:f431:33f5 with SMTP id 4fb4d7f45d1cf-60c4d3b12f0mr3342643a12.25.1750870752230;
        Wed, 25 Jun 2025 09:59:12 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:b255])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4682c0sm2690310a12.52.2025.06.25.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:59:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 0/3] Support array presets in veristat
Date: Wed, 25 Jun 2025 17:59:01 +0100
Message-ID: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch series implements support for array variable presets in
veristat. Currently users can set values to global variables before
loading BPF program, but not for arrays. With this change array
elements are supported as well, for example:
```
sudo ./veristat set_global_vars.bpf.o -G "arr[0] = 1"
```

v4 -> v5
 * Simplify array elements offset calculation using  btf__resolve_size
 * Support white spaces in array indexes, e.g. arr [ 0 ]
 * Rename btf_find_member into adjust_var_secinfo_member

v3 -> v4
 * Rework implementation to support multi dimensional arrays
 * Rework data structures for storing parsed presets

v2 -> v3
 * Added more negative tests
 * Fix mem leak
 * Other small fixes

v1 -> v2
 * Support enums as indexes
 * Separating parsing logic from preset processing
 * Add more tests

Mykyta Yatsenko (3):
  selftests/bpf: separate var preset parsing in veristat
  selftests/bpf: support array presets in veristat
  selftests/bpf: test array presets in veristat

 .../selftests/bpf/prog_tests/test_veristat.c  | 127 ++++++-
 .../selftests/bpf/progs/set_global_vars.c     |  56 ++-
 tools/testing/selftests/bpf/veristat.c        | 343 ++++++++++++++----
 3 files changed, 423 insertions(+), 103 deletions(-)

-- 
2.50.0


