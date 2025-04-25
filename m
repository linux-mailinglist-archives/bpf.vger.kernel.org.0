Return-Path: <bpf+bounces-56689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AAFA9C9B7
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34381188A341
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEB2500DE;
	Fri, 25 Apr 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+shBA+v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83323D2A0
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585968; cv=none; b=f1FXHrIyxv5Ev6eMQtHes7susGU68+s/ArCTQmVEhmcIDWz/85HZ/4UbBDUfUbSDGV5p46D4SmO4HJadQT5Iy2bPdsYbVMa2E/CTwMgnCFzHG0bp/CSaP4EjNusrs3/dhHd55U70F5KNpq4IPglvjLLlsVJejJoOI55u5zEFl+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585968; c=relaxed/simple;
	bh=kTCoh0iKZD68d71MuE3Jh5SnP5+ijuTynlLTF11auOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkI9t445hnhNJGtyo7GRP+na5RK6vNnvFyGwNqZOfeYyN51QiBbyK3HJQVZKj11yWD6hNUIlbu7kQ23cIrgKp0Wb5L+BtotL5+pFBh2HrfZD9CuRVpJNWuBgKUAIPJxwn2RAZ8QEjKhFgYjCVYlIGRYLBmEW9N/pA0AFgWDllgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+shBA+v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso123571a12.0
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745585965; x=1746190765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOD17jfn3XGE4DjKfqIjEU15/NKx9j1OOrHFteW+K6o=;
        b=V+shBA+vrUY2+NurdN71n4HwwsBDeoumHHHzwyy5JQDFGgb+RZ+nVAgynWMEAz6GDB
         XcsqMYXf5SvSIzJAizAfg45DojNc/y4du+fTGylLNwMEG2RHp3YUx8bbiumLq4jbdui+
         hGyIny5FEhGdnlVI+i+G/ylr+NgGw1R33ZMshXcLnURweSPDeXGyIBftvzbjoYDeIswW
         Y0xH+MeiSNl8M9dXzpLx71CAjW3PYakMJnVFj0A1dl085ftXFYPXOhxZ9osq1hlCyymV
         djWOmDPpJj/KV3VByExGSR35OoMad6QILJ1PMF+Ui6jDkJLXHvvYlppGZOtz4HmQxU+Q
         BhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745585965; x=1746190765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOD17jfn3XGE4DjKfqIjEU15/NKx9j1OOrHFteW+K6o=;
        b=f6zMiyFjS4p0CeaX23piAk0Bt4/UqRtYH285WyvyYpgqd6M0XhD4Zy8MbjLDn3MrTW
         nPohJ6JSaKegXrSnfkbW4Vm5eB7F5K4FhW4K4hlvHckIKjEhIk6DV2PwhQqcztznliBu
         xSwEyKU2pt9/zOP+JNwHd5wzYDUs6RlXQD/3y6RPCKXjWvKYmkbJfSHztHcUGl3sDtEE
         uzLHOgjyjVxQuuPhn8gc8HzJ0s+QMtVXY91Se9W2V8kUBVrX2YtTQlduwe49O4ZOaIPo
         17tYubtnjhzKyTGbaWjZ1aeFfYiZl3bDMp42jze8aCbMCFacxxk2A0zR0sG7nRKxAmdJ
         pm/A==
X-Gm-Message-State: AOJu0Yy9Ji6M+sLQLbJ1zdndg6Uk36clNB4bq1WTwgayK8lhbf5oPfx5
	kyYkr2jO1NkgKiF9FEVjfZyR7cDfxzJNVrXrufIKMTwLyiv0lRhhZbjoLQ==
X-Gm-Gg: ASbGncs2L5ltmgg9p9ujRwuYuPvqgsGp+4ebN8xnwnV/CCnGnA/6Io3+tpDjhIEH58B
	EfgoENrF4n5G3Y8Anx0LzQqDMkPwVvlte/CN7Ia77z88d3GiSvdGHvTOrgpRA+4xcnigC0945Dr
	m/upPuIybkMhRYLoHRhLS7foWxOO4o5ZJ+FzrsoYNrWPX/mO37b7wgi2iSvT5moRUzFdCRO/NNI
	KgIBZX0al5gEUzGfHoLORt+xgAahn02Xs4NNNaiWqH9MnmraT2zrgTCVgVDJlP0KQjcUUTuXMxh
	h9j3QaTL5X8UsIJe6cJiLVcDyqv3Z50vvCfwiWdiOqkH57mZ2F7G
X-Google-Smtp-Source: AGHT+IGn/pDrzj4PPdS7psA/E1vqOpwo5nSDLEnhgLOchLh6dbUw4WbKU7TaKcX757kbER5XvTO7Rg==
X-Received: by 2002:a05:6402:13c3:b0:5ed:19b4:98ea with SMTP id 4fb4d7f45d1cf-5f6eefb3194mr5367456a12.0.1745585964658;
        Fri, 25 Apr 2025 05:59:24 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:eb6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f701106bcbsm1224669a12.10.2025.04.25.05.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:59:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 0/4] Introduce kfuncs for memory reads into dynptrs
Date: Fri, 25 Apr 2025 13:58:35 +0100
Message-ID: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

Mykyta Yatsenko (4):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs
  selftests/bpf: disable test_probe_read_user_str_dynptr

 include/linux/bpf.h                           |   7 +
 kernel/bpf/helpers.c                          |  14 +-
 kernel/trace/bpf_trace.c                      | 199 +++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 ++
 .../selftests/bpf/progs/dynptr_success.c      | 201 ++++++++++++++++++
 6 files changed, 432 insertions(+), 3 deletions(-)

-- 
2.49.0


