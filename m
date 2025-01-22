Return-Path: <bpf+bounces-49492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A3A196FE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B263AC7F6
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE128215187;
	Wed, 22 Jan 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMo9ZhTC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16321518B;
	Wed, 22 Jan 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737564940; cv=none; b=qeUMEZfoycFROhAI5eCChp7YsX4mOJx5To3ERWJyiU7YkvIlxF97tDO7LEfo6Po3yKYhun9Utz0n05/8eiQ2vKkmC3Ipg6N3zVukjebzlUh0RWTft5OVPpodr6+MkilSq82xhYHmQjGWil+J7L8d9doUlNKogstXQHzgkGiwcZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737564940; c=relaxed/simple;
	bh=tDh/mOS6P7ygFbCpjoHq826cKO7iE1Bzif0WualZ6Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hkXx2oP0LbaoAPWNkzVaDJYrmURI27iZmU23mISznS11axmH7gV4U0E+wHNhnRns+TLAtZ9E1/bt5cg9ABUxs7usWLu46+DnD+j8VgpowiXEfiUtBxFjXPGwa+DbaytARmMZuQ5nphk6aDBddQAN0VnT5tq6txIonE5DHfY8t+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMo9ZhTC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so17068a91.3;
        Wed, 22 Jan 2025 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737564938; x=1738169738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zINL8i15bfcigl3lUWFYKL/YF1uNpTwZIKUV5mY0Z8=;
        b=FMo9ZhTCCx4Qaru6kemhuK3miyH2KTYsx7Sc2XFUSrrUQMeFgxev5mQKORNXBHiSfx
         HVtJHq/7EFOHxL3/XYN/Ga8CCH53blLY5FV75XsClPhXln8eBBACvg14hCKLtTiKtKyt
         BS4wBvTQepGXn6sy7zg8KATvFaovZq40J1HwKw7xBJCgsV0cd4FjRlVcFVjHmiH28Fc4
         VcoDoscSWg0Xk7rgQsOo+BPTUIwfQBGS2ayNIbIE/JkzDpTTwvJsa2LpC5l7GeB0PZIm
         33B8nDZWuH/9m3z1ycS0Vdmcgg6updeEqMrYYRhwgyXnAnXxKEvdAH/B1N0Iz+htpRmW
         zsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737564938; x=1738169738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zINL8i15bfcigl3lUWFYKL/YF1uNpTwZIKUV5mY0Z8=;
        b=h4K5g4Gp8DhXvZmLacJoxpwUj2fY+fF61+R6+IDNjAZvlql6EfN47lB8lC/pcnyFOj
         rpV0MT5Wigyd2Gf+0rxMt/+b8TYeWz2SisM0CDkbWFPxHlW4RwHw11RDpqE7r/YYGAP+
         4ng5w9ojL6J9RXwlbVqfNm2ry0IU8lViwgoh0IVgGbBKE2Wc02o8v2mA+OLXyzji4mgd
         sfIqslPVJpssw+2fMLTTDpDXNvg6cmFHZSrAlSJo2ZgmIIcpIP3WelmxHTOx2oy8AZec
         mOPzzwJG6kOsfzczj3RKVWiuVOBgJ1tc+BTJVkUNZD7aIFzydRVg/86SEcOvLucLxd5L
         VrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7BltTrS2mhf1mUQjAhU0ua8JIs6XzO4NH4JoE6JtCqCWEq5phq7ZYjyHduogF9lrMDltpiDp/X7D7z84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQksYVaTa44KXpfhd8mM5QMT+mqCc/XNF7ugX5xN3fnDN9bl6
	u00ezk009A2ZKvVBFSPL0TZ/bRc1X89lMwQxL9HeU79A2GQtdiQe
X-Gm-Gg: ASbGncslFDBD+WE1pEFxG9CooMHFYAmM3+V2ldtzdgmavV0iyVTIgY2B1ir4Zq++aG+
	pTmHLDWQLzUNJtPmpAQoSgGnXRXNq8XETuKfwQSW+EV+rP5rxherpwxrzu2twqPSHq6FXhfhKac
	FIIe5n/pjK2e9qXb7YCYHpdzlXjimbBuI4aZ7GIiecr6r4Eev4Bqqf2rtt0LSBvPQjfme00cz96
	RO5xF/TJIQG/uRdRegLm5/6tT+u3v37XSwxEaJGX/R/8vxngQeQr7izG0QIRVXDMUIv4Q==
X-Google-Smtp-Source: AGHT+IEp320gGbJtM34VVrkXpDxQlcpD8oIpQY6SM5ichHNIpxVrTiTslGvS6c1kGFaimj3zbMNC8w==
X-Received: by 2002:a05:6a00:10d1:b0:72d:a208:d366 with SMTP id d2e1a72fcca58-72dafaa5962mr35884812b3a.20.1737564937805;
        Wed, 22 Jan 2025 08:55:37 -0800 (PST)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab848321sm11329300b3a.76.2025.01.22.08.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:55:37 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [RFC PATCH bpf-next 0/2] Add prog_kfunc feature probe
Date: Thu, 23 Jan 2025 00:55:21 +0800
Message-Id: <20250122165523.1033775-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Tao Chen (2):
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        | 16 ++++++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_probes.c                 | 36 +++++++++++++++++++
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 30 ++++++++++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.43.0


