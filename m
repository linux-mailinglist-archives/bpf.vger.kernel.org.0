Return-Path: <bpf+bounces-64785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6724AB16E87
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9268C565ABE
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AA82BDC01;
	Thu, 31 Jul 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLyCdbKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CB1E571B;
	Thu, 31 Jul 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953882; cv=none; b=q5CI0u7zrUqeTJv5Gh0UiLXJXt2qerrMMZKxu9olBasnMaB5TMzg9X+qM+g9WtKnVXXliSks1ABKMIuKECTXGbTHnCrEjkB1fTWP8kidgylzFyAnyqWseWBDtAhBYqkbe9mhUHKyU8adIfghHPsuWbkGuzq77VUc8n7PcOS8U/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953882; c=relaxed/simple;
	bh=tKTH83Dy7XBfL3jn1KkIty1QhhYF4uYL/kODvG9ar+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rj7QOTDu6qDtBdd+6Z4uYxdLN92YAsDV9tz6O8CYxKap8hKliR2uOqckLB4OrRDvrD12nPXa/aWLNWIgcqvNk4ZcTkgpNRJaqhUuMhjBCeJqipt+b0yXKavFwwBQkFsOSvcqZG5NUYpIXXr2rN3LFYmnd7a/OM7K5tCHuueqGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLyCdbKQ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74931666cbcso596935b3a.0;
        Thu, 31 Jul 2025 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753953880; x=1754558680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RgKa3Xgv6uVT9xD5DgmEO+/WTMgOvLSMAALLsetcqBk=;
        b=VLyCdbKQqDcTHL7QKLbYzMOVz82aogsjrgcooH3SmoCQ8iLGpJ3LG7X35ezo4FoBL6
         vsDeq9pwJW2xBxOnsKurqHxF/i1jzSrCwcaTsWHb/l41TBM8rQLE4VM/M7n3uezPyZkM
         VTxY9blsJn8bDuNCjMSwDdCzN2K75tenY9Yqr/KkQPraI+PPWUd6Lkmg/xPnOAgeGCLG
         mYUZZaRlpy73uIF6RUAcsJkM8tQ13+bh53DojopIuiKUS61adr9IWMM2lLmpteKJujJU
         meEM2X5+xxiXeZZaXon5MJ09RxOo2PS0d5cdzp5EKvINNHx9Ej5pYAP/0cWQOCBMWmCL
         pVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753953880; x=1754558680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgKa3Xgv6uVT9xD5DgmEO+/WTMgOvLSMAALLsetcqBk=;
        b=tmh3oHyHz9azebPj6lL+pbZ+aE/c3tzFSu02vfoz3TPbou+LlaRphJaPYw2tKXWX/W
         pMOWFJvU5TZHceykpP7ueCdNSOePTwupJleVmo5AYPFq1UZIOzQwvFQBtkP9VSPa0vhX
         A/e+kB3xhoKq3rg0827c4YhehoPrn7uRcsYGtqzz7B2PSg4xAoihnc8GYnp/JmUYlA/p
         2qB3jf49Zamyi1uyzzlS30YwpmWg+tRL+NwqrpiNqgFfS1cx14tPTOF9UdUL5FMZXXMo
         Y90qwWEPNx7+Si2IClTfaDz5Iw05NQLslzcvIekPqTmvX485PLidyvcVomCdWqCBkPeX
         ToVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK+uNH3npRoHxxY79FHyVOG7X03UXkqf91xkzd/Z5PbBIceZKcjrYW7kfY17Gm+kSVGEQ=@vger.kernel.org, AJvYcCV57mM/gK4QbmQl0DfnFgnA/k0/zp8enCYldkwHzrJaJS67DyXytX/iuXbaLSaKBITtzNIXKAjKzW5JqXSbV3G6ybzd@vger.kernel.org, AJvYcCV8G7RSLz7HTY63tWdA5b94aWsafwww44p2wx+TBhz7uOTWwA42Fvb1MK6y6B38aBnflHFSbUANaS2Co1pA@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGmpxUrUUJKdrCrXsnefKNjkjytPB7SyriLpAkdUzmVMWMB6e
	tthKmVgC6gV9qf9wmG4n8uA/6Xqgu8rRmnXr6E2+JJtSMOG8qUklG98S
X-Gm-Gg: ASbGncuDqQqtXsiCx50buWwjVLBNVCx1M+VOG++UzDD4eqUoAJ1fbd8RZaVYn/iBm7r
	WF+pDLtvBO8bzNQTrskg+6OiDnsroujtBy2khSexDn4aDdNO1pvKkHWRmsq9ZP4phKLTnhVxD9G
	rG5KufBDZB7mhS1Yk6FReAjiYe9t+FBVADGOqIMtvJDZKSI77PBOS3PGUYPDzcppjc8Xhja01TT
	yj0E8v9SukT/2WYjuCOGg3mOI4HXULe9UPvk8aNQ26obetg8C04v1QQbXGGiXBsmtPZaIbn8/3U
	omn5qiTBJ3uAZLNfo0YPXxeHT79XPg9ehfFgCDc4//82C7pK5ujXRG0bDM/gz2/iEzafW0sJ5Sv
	fii9aYX5K5jnHoFbe5nWirZaitHgRHg==
X-Google-Smtp-Source: AGHT+IGtkmXb9ArXHu/MpvDiHD8BAWmojtoLZ129hf+vH308ZaB7eDck8Oxz2ScKsd8NMZAK0my0+A==
X-Received: by 2002:a05:6a20:a124:b0:220:9174:dd5f with SMTP id adf61e73a8af0-23dc0d90c40mr10342749637.15.1753953880047;
        Thu, 31 Jul 2025 02:24:40 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd1a7sm1108143b3a.73.2025.07.31.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:24:39 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] fprobe: use rhashtable for fprobe_ip_table
Date: Thu, 31 Jul 2025 17:24:23 +0800
Message-ID: <20250731092433.49367-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, the budget of the hash table that is used for fprobe_ip_table is
fixed, which is 256, and can cause huge overhead when the hooked functions
is a huge quantity.

In this series, we use rhltable for fprobe_ip_table to reduce the
overhead.

Meanwhile, we also add the benchmark testcase "kprobe-multi-all" and, which
will hook all the kernel functions during the testing. Before this series,
the performance is:
  usermode-count :  889.269 ± 0.053M/s 
  kernel-count   :  437.149 ± 0.501M/s 
  syscall-count  :   31.618 ± 0.725M/s 
  fentry         :  135.591 ± 0.129M/s 
  fexit          :   68.127 ± 0.062M/s 
  fmodret        :   71.764 ± 0.098M/s 
  rawtp          :  198.375 ± 0.190M/s 
  tp             :   79.770 ± 0.064M/s 
  kprobe         :   54.590 ± 0.021M/s 
  kprobe-multi   :   57.940 ± 0.044M/s 
  kprobe-multi-all:   12.151 ± 0.020M/s 
  kretprobe      :   21.945 ± 0.163M/s 
  kretprobe-multi:   28.199 ± 0.018M/s 
  kretprobe-multi-all:    9.667 ± 0.008M/s

With this series, the performance is:
  usermode-count :  888.863 ± 0.378M/s 
  kernel-count   :  429.339 ± 0.136M/s 
  syscall-count  :   31.215 ± 0.019M/s 
  fentry         :  135.604 ± 0.118M/s 
  fexit          :   68.470 ± 0.074M/s 
  fmodret        :   70.957 ± 0.016M/s 
  rawtp          :  202.650 ± 0.304M/s 
  tp             :   80.428 ± 0.053M/s 
  kprobe         :   55.915 ± 0.074M/s 
  kprobe-multi   :   54.015 ± 0.039M/s 
  kprobe-multi-all:   46.381 ± 0.024M/s 
  kretprobe      :   22.234 ± 0.050M/s 
  kretprobe-multi:   27.946 ± 0.016M/s 
  kretprobe-multi-all:   24.439 ± 0.016M/s

The benchmark of "kprobe-multi-all" increase from 12.151M/s to 46.381M/s.

I don't know why, but the benchmark result for "kprobe-multi-all" is much
better in this version for the legacy case(without this series). In V2,
the benchmark increase from 6.283M/s to 54.487M/s, but it become
12.151M/s to 46.381M/s in this version. Maybe it has some relation with
the compiler optimization :/

The result of this version should be more accurate, which is similar to
Jiri's result: from 3.565 ± 0.047M/s to 11.553 ± 0.458M/s.

The locking is not handled properly in the first patch. In the
fprobe_entry, we should use RCU when we access the rhlist_head. However,
we can't use RCU for __fprobe_handler, as it can sleep. In the origin
logic, it seems that the usage of hlist_for_each_entry_from_rcu() is not
protected by rcu_read_lock neither, isn't it? I don't know how to handle
this part ;(

Changes since V2:

* some format optimization, and handle the error that returned from
  rhltable_insert in insert_fprobe_node for the 1st patch
* add "kretprobe-multi-all" testcase to the 4th patch
* attach a empty kprobe-multi prog to the kernel functions, which don't
  call incr_count(), to make the result more accurate in the 4th patch

Changes Since V1:

* use rhltable instead of rhashtable to handle the duplicate key.

Menglong Dong (4):
  fprobe: use rhltable for fprobe_ip_table
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 include/linux/fprobe.h                        |   2 +-
 kernel/trace/fprobe.c                         | 155 +++++++-----
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 9 files changed, 401 insertions(+), 286 deletions(-)

-- 
2.50.1


