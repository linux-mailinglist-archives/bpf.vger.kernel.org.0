Return-Path: <bpf+bounces-65714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A3B278F6
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843F8600BD3
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2447221277;
	Fri, 15 Aug 2025 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBarbKLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D731984A;
	Fri, 15 Aug 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238715; cv=none; b=OdZ8dwM70HTlWG3MQEegLkHJXpMfdxN+gBK1cjXThY+g4f3gs8f517DR3krhjmR4G4LG21/5ADY1poBGhfT1KZTWjIMPBZmO7lXzdjtEnmSECyoUnWtj9h9YsYtynQlBQ9IF3zeGIY+QEf7ucXQW7zMOjOY4QSlph3P+NOjPD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238715; c=relaxed/simple;
	bh=ZxKuu8oK99HEeYcNZN+yhnDy/FX9YRizOzHm8MncMtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+Ote4QhtTapnHOZjYUV6JBxw3O7ySCg0ukgROP6siNKYASXQNt4U0XMKqWJWJhvkfYWiJAfu6nWrSadfVhD6sw58ybe0ZFFYSwIZP9dykHwzgAaW6C44ofqQsIF+AAtJ9hXLuFILAlYvVlNsqPtJ+0P6UWlZRwwNZCpzJpkBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBarbKLt; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso1313992b3a.1;
        Thu, 14 Aug 2025 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238713; x=1755843513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpgXOLKvk20z/Qdq1ivJNBHUehSj9Vyonj6S3GZ1D18=;
        b=HBarbKLtY0yc5SfFhj6pA6VtldXNMFqaDiHWSpZ1PTuvaXvCZWqm2uNNaRPBvj2mVK
         enZ2mUqELT01dM3LAly8zqO4ji31E7f5k06LkW5l6dWesDOsDKnEDlOIP2i6uwMf8B0X
         edLlXULmEOXu8l/6P/KLzlgvpK6e+c6t4bxL7c2xjD7APe0mjWixDM3RigC6Z+kDe/mz
         aJRd137EV6bon+f3tL489eR6bamvnh2Bwk7iSYUmyd/fvHRGpMnPh/0HOmSM7UJlW9Rt
         dhL3SI0jVbmx+8hE1mhmQNGCOk0EwS3+dfMLrVRMcEqrxbH23i/vtYH6dKBqUNlGulbI
         ZiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238713; x=1755843513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpgXOLKvk20z/Qdq1ivJNBHUehSj9Vyonj6S3GZ1D18=;
        b=ka3gdVzm/SRThZLKqtyohUBeYdFmQJETYOrEbwkW1INySdI4pqU/erkd7LyBw5iC0C
         EJ7c+YDPT52sfSgye0ygk/7TLJYUIFAAjAdtUM5rr3hfkjweYEVO/FjdJEkg8YjGhw1e
         Uj23+5zwvaY0bMfyimYPjxOeHMDrBNmUDXie1LaZ/9Hu6gsW5pasCX/bdNnuzKWsqi2l
         xR7P7a61lGt3zhHL0bumHLvLzQnp+RfyfpUZpSHFEFjHFUGm3ZEhQ6x4FpK6OBgGqWiW
         /U5etRVIo2LZQd8Uad3wHI6/gV2WoNhZ3MWUVgLstp+BPxwghtbeEHSRW+Kusc+ZByIY
         AUpg==
X-Forwarded-Encrypted: i=1; AJvYcCUmpBBoM9F/LxQAj4082RRnYHHvPb8gndh/zE6jlsPNgGyeu84y8MyD48kIaAte75VQx2UON9kh5tg1t1fp@vger.kernel.org, AJvYcCWIEVNwrOPjaI7W4sL3Ls1yYiTZHXEdQh0+4BEewwqbl2K8eRP9vgTSmp/1FZ5HorvVCUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBGWRY5iATtv379npCaVsBz3cL46v1KLtAmSpuIHx9TRv9pwW
	tBPbPIAQT2t0/9bJBkZB6ZghfZ9lyLb1Q8bhkaMXrR0V0Fk2UHf8vKZH
X-Gm-Gg: ASbGncvg7OyuszkYhNIMQtgOW0PYMm02EIbByEUorIizf8AK8XDque1D70WFY4UF2Ot
	0X80K1XGn4ZBx+ecTY8lIuRmGOOtsCB5SnlrIfuSe2YbMhKVNtGeAg9J41rku71LmkyQ93wQupY
	XXkoJ8YyyJ7gpUW5h3foYTqCBcCDEMIImFg894xInInmlnkPlwdQj4+S9UTyhEVSvlCPbFqv1YL
	aoj7A8emBO5heyvQfbEnajtBJ6sQseBgG4hosZJ/e66DtO1qya5Cw/UdL09pi4bdEQVibssQumf
	LFy3fl0uy3Gq7athcCRvc93BXFnMZGBBxiuG05QKGT/re/1r+nR7zYu9yTyj2+VxAMxkvzRKp2Z
	a4SggeoDd/Qw1ms3cteAmGYOhJ5dRHA==
X-Google-Smtp-Source: AGHT+IG5jaZNcStFK/vUUJ2UKM4okYUFoTBZDs8Z3dAlN1tFFzIYeFfrWv6iPO2OOPlD3NhhMsQJUQ==
X-Received: by 2002:a05:6a20:7284:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-240d2ec5f18mr1746024637.29.1755238713196;
        Thu, 14 Aug 2025 23:18:33 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:32 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/7] bpf: introduce and use rcu_migrate_{enable,disable}
Date: Fri, 15 Aug 2025 14:18:17 +0800
Message-ID: <20250815061824.765906-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

migrate_disable() and rcu_read_lock() are used to together in many case in
bpf. However, when PREEMPT_RCU is not enabled, rcu_read_lock() indicate
migrate_disable(), so we don't need to call it in this case.

In this series, we introduce rcu_migrate_disable and rcu_migrate_enable,
which will call migrate_disable and migrate_enable only when PREEMPT_RCU
enabled. And replace the migrate_enable/migrate_disable with
rcu_migrate_enable/rcu_migrate_disable in bpf.

Menglong Dong (7):
  rcu: add rcu_migrate_enable and rcu_migrate_disable
  bpf: use rcu_migrate_* for bpf_cgrp_storage_free()
  bpf: use rcu_migrate_* for bpf_inode_storage_free()
  bpf: use rcu_migrate_* for bpf_iter_run_prog()
  bpf: use rcu_migrate_* for bpf_task_storage_free()
  bpf: use rcu_migrate_* for bpf_prog_run_array_cg()
  bpf: use rcu_migrate_* for trampoline.c

 include/linux/rcupdate.h       | 18 ++++++++++++++++++
 kernel/bpf/bpf_cgrp_storage.c  |  4 ++--
 kernel/bpf/bpf_inode_storage.c |  4 ++--
 kernel/bpf/bpf_iter.c          |  4 ++--
 kernel/bpf/bpf_task_storage.c  |  4 ++--
 kernel/bpf/cgroup.c            |  4 ++--
 kernel/bpf/trampoline.c        | 12 ++++++------
 7 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.50.1


