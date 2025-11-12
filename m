Return-Path: <bpf+bounces-74315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B42FC53DAB
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52BF3BC46D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E1348866;
	Wed, 12 Nov 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJOzGbuo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161128FFF6
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970383; cv=none; b=TqbYllqTjqt8nd+vyUYUkQDqS1wBwJ0Q6TO7VSVrbR9HGvObXR/85HMXT5hdWpTDt/3e/E+4zhlBI05weJnE9YdkaNKny4f9UPfWbBESqr2SNTdWpwNUCopa+ANkfrtYw9uUvnx5ISCvPtn71j+0yIwv/2sdB+muCwv7TZ9E7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970383; c=relaxed/simple;
	bh=jI3VWN3ADwpJwIXRCeV0B1Eop8ytKizhCylFoP60k7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KgtyAZ9kqxmy5GiOQtyPVJT25v5uZuKpB/HQt8Uo2LDNUeVw3P6IqP4RCg38LeDMV4KFHzHIOPknCKDb/MetIlHD5RcJicdGVcGpd9tA3U6R48PXzt2HbpU/s6P+d1m0eZqek7LEbUQ+xM28rADhqPf/MqLSpUjnKWEgxOJoDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJOzGbuo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso35704b3a.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 09:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762970381; x=1763575181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tQOfuJqavTu38cNA6pks4fJDQNJUesRiRlsLxK7cd4U=;
        b=nJOzGbuouN2huUw8/aagapVCws7x4IEb+TTrfjX66c8rcKsBzmW/1uRldXEazBM4oI
         zEDEkJzNZrvLvBtxEyInQK32g7htAg7yt9FyGHe4zjV1oASdMAsJr3JoIpqxuCFIIFQO
         fN67KLDHESlPV4ciSwuhFjXq/BddU68TNA4aY1HRTIQC0D+fB7RfikN7AjrIXqQLoojM
         Wfp+bXE4ney599VZlgCbTx1oG1zgmOr9BdMhsvieuP6qNS+4O9houQvRirV9/Ve9B0FT
         k6jXkj9oaGKAWOfz6g8+t3vQ7XcNaR1jUCKV/uEzid7htETl1c4hfAf/SjxFKRmfRpvV
         saUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762970381; x=1763575181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQOfuJqavTu38cNA6pks4fJDQNJUesRiRlsLxK7cd4U=;
        b=XRQC9guCOGgWgOxQgMuq+9gb33F66YZ25SkoWrIe6H+m9x3vg5F/qdBY6XxaLi22ZS
         BdejSiUnvvEqAeI+Us2SNvxIxfaTNL/DHrT/FT/7Zj+9LHviWjqjhHNIFW9q56AogcOI
         +BkGbhTXMkPGwGcuX5rVaGRpJJNAudRqLyq8J3JaufYVL5hr6eVEX9ZrcNmrjFXqZh+L
         lcHVWzjrw917dwrHIHaQL695mHtReJxI8f2oFenNAmuIDouc1817gQhPYz0b+an8izeq
         KXgJw62TB0SYUy08hyaiT9h2UFqpLgemPdqBq9+sxwDqqoXroj0K77N795wI4JlOdxXx
         U8Ng==
X-Gm-Message-State: AOJu0YwLAA3g270DGIgm1VSyYas5JZnMjQwWWZw3xxwMLC6DYOEBIAXm
	uunux1ZZlMRWBQU/huPmYjYfBAOiXukEOTEeh9Ww00EHqG5NAD8XHZ5iip26dA==
X-Gm-Gg: ASbGnct5ishXjMooz7CkKqHMa/hjq2bJqmlC4EqpibsZfn4B1AZ4UmuHVXGBOr+Cdqv
	pE8sdtV4EC29cnM2PBDn3WmFPPGrHaIg5njxFnKx2duoUIpCkWs98RXWDviDalul/hXibfyRUE2
	5E0bvDcD3eQ8xJGB8Kf27JcDa4/RVeJUJyV69xRzikLGDIz3XymtSJsGclGdbd6R935T3GiejmO
	/SPv4jIX62Awky7+fGYU1qB876indMAUz35MwMIU0+WBEAk1uN4Wi9cEwYoFvrwA4z80iHiczET
	+tJBKSyiNT/xh2Dw6vFMnXKaxhKXjWbTtX8WdRIzMM6iKXsliu35XcsmtNIK5Nh0GrI8GD2eBh8
	+4w/B784SJ1jS4+Wo4TNDxsKXh/xg7Ab0DYrS8xa2H4XX+s/6fnFmQBhewC/UWOSIcw==
X-Google-Smtp-Source: AGHT+IEKOE4rT1sMg/mZpwUozkPb1oBAAAKc4IxHTrhCh5DN0O31+oHVoMPu0zHGcy21alRC6uEisg==
X-Received: by 2002:a05:6a20:6a20:b0:342:5ba7:df9f with SMTP id adf61e73a8af0-3590b812ac2mr5349152637.55.1762970380790;
        Wed, 12 Nov 2025 09:59:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd5c75bsm19177460b3a.70.2025.11.12.09.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:59:40 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH RFC bpf-next 0/2] Switch to kmalloc_nolock() in BPF local storage
Date: Wed, 12 Nov 2025 09:59:34 -0800
Message-ID: <20251112175939.2365295-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patchset tries to simplify bpf_local_storage.c by switching to
kmalloc_nolock() unconditionally. Currently, local storage adopted
BPF memory allocator in task and cgroup local storage or when PREEMPT_RT
is enabled to allow getting memory in different context without deadlock.
However, due to performance reasons socket local storage did not switch.
Using different memory allocators added a decent amount of complexity.
Therefore, to make [1] and other future work in local storage simpler,
this patchset consolidates the memory allocation/deallocation paths by
switching to kmalloc_nolock() unconditionally.
 
Benchmark

./bench -p 1 local-storage-create --storage-type <socket,task> \
  --batch-size <16,32,64>

The benchmark is a microbenchmark stress-testing how fast local storage
can be created. For task local storage, switching from BPF memory
allocator to kmalloc_nolock() yields a small amount of improvement. For
socket local storage, it losses some when switching from kzalloc() to
kmalloc_nolock().


Socket local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
kzalloc           16    104.217 ± 0.974k/s  4.15 kmallocs/create
(before)          32    104.355 ± 0.606k/s  4.13 kmallocs/create
                  64    103.611 ± 0.707k/s  4.15 kmallocs/create
                  
kmalloc_nolock    16    100.566 ± 0.560k/s  1.13 kmallocs/create  -3.5%
(after)           32     99.708 ± 0.684k/s  1.15 kmallocs/create  -4.5%
                  64     98.375 ± 1.757k/s  1.13 kmallocs/create  -5.1%
                   
Task local storage
memory alloc     batch  creation speed              creation speed diff
---------------  ----   ------------------                         ----
BPF memory        16     24.668 ± 0.121k/s  2.54 kmallocs/create
allocator         32     22.899 ± 0.097k/s  2.67 kmallocs/create
(before)          64     22.559 ± 0.076k/s  2.56 kmallocs/create
                  
kmalloc_nolock    16     25.399 ± 0.142k/s  2.51 kmallocs/create  +3.0%
(after)           32     23.495 ± 1.285k/s  2.66 kmallocs/create  +2.6%
                  64     23.701 ± 0.207k/s  2.63 kmallocs/create  +5.1%

[1] https://lore.kernel.org/bpf/20251002225356.1505480-1-ameryhung@gmail.com/

---

Amery Hung (2):
  bpf: Always charge/uncharge memory when allocating/unlinking storage
    elements
  bpf: Use kmalloc_nolock() in local storage unconditionally

 include/linux/bpf_local_storage.h |  12 +-
 kernel/bpf/bpf_cgrp_storage.c     |   2 +-
 kernel/bpf/bpf_inode_storage.c    |   2 +-
 kernel/bpf/bpf_local_storage.c    | 283 +++++-------------------------
 kernel/bpf/bpf_task_storage.c     |   2 +-
 net/core/bpf_sk_storage.c         |   6 +-
 6 files changed, 53 insertions(+), 254 deletions(-)

-- 
2.47.3


