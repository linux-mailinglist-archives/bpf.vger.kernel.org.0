Return-Path: <bpf+bounces-62023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECA5AF074B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 02:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30053B3688
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 00:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F762D299;
	Wed,  2 Jul 2025 00:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="CoFzktcS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15146BF
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751416443; cv=none; b=dgQ1o9WvCdwAg65Z1aB/shR+5H8TJOb7YPUV6scSqRup52QkaCC8LTyU1YoT5Vs0MIctgAgOrGNM0zNyfVcnVN/YZ/NBratrCYEEy3WcOODMQ0FT/pFwRe5YShwpSfjO7so+8Ah+VpqlU30+ef/S2Cv8Z9RKxc6d3FsZwylMH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751416443; c=relaxed/simple;
	bh=cfTwsbs8kyH2+Pk1a/qLJunSfkDSS98lDl+IJiaq95A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQR21ztb7zsoBmC4KKO+Vqs+Dzglb5ozGcl1Lxr15QduFwOfH7dKbYuDvYGgHGxtWqwuvOf/2DJkJr7t+Q5HsWVuoNDBFHHumVFGrfjFiyJ3LAf8qTKeWjnOowtdrThsw9BhLnx6Nw2MCjT8uQ1TNAjh9I4i7fYH54i0ohubMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=CoFzktcS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d402c901cbso572142685a.3
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1751416440; x=1752021240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GX32mATd1s5671Zj3o3qTfz7OF+swGtCtQ+PtpfirIk=;
        b=CoFzktcSOdg/miiiWmNUczox/y62ncs1Be+0iuFes9HTpfp3myRf9Tc42aXTgNb6wP
         YpcAYW6ZT+XciwlIPpOdFRydMkUxPcokIxMRcRbv8EbrhD4PmQKXvLRVDodDiL2LIlIF
         LB7HE/f8Tcy3uyTRQBfz+uWtcHDneyAf5NkzSda57rFft7qj+lVkZfrgG3ZS46toJqmM
         JXwRM3rWeIo+awKQDOPXelxC66I1Jq+qM1FXrhrMSBB/QgDJb1BuKqd/2T1e2AQ2Lgxd
         CCCu9V6+dg8IGd+fYFA3Zc4FAKvQFxhxqJxdjZG1Td5eqNizl/FF5ZDpz2HKf1GSD++6
         UHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751416440; x=1752021240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX32mATd1s5671Zj3o3qTfz7OF+swGtCtQ+PtpfirIk=;
        b=NUiDyUD11SpIf1d2VZ23WqdO/z+BQNvEVU2FdCNKEeHXe+VOog5zI7pRbzH45ZmcRK
         3VOqH4ETzU7BQh3fafgDuGiwnW+dTvvJ+T2ZFNJwkVLKcNaphrGY26/UzfYtf50PqTe+
         ojkyiSpmni4E+c9Wixb0aHEkLAosDJrubaK7CKiFoTqMPGuFuo6iyzI7KisTkzNXDciM
         GNHXAeH3HLg1JcH3h3pewIWxGN/HA/wWrJEwKvGkdEj9h/nt4oCt9wIqqrUUZR0XRjzv
         12D3X9CwcuWbpdK0KzpBy98Dc0p+/G/npshkZxQD1ALgcY5GZkjbh2a8uppAKyebECYm
         hP0g==
X-Gm-Message-State: AOJu0YxHPN4Nrd2xIF5J3cUXI2qfzgsGF6NOoXiuSSYulbF1smkaXKYx
	T/PnepsEwnQYkXZkLpUKz4nMsD3RhF6uRBP/zPHAnxwbsIZNIl+hZ06TPAnLxsiAujPDB1N2mrU
	CI9qiV5WCuw==
X-Gm-Gg: ASbGncuXkoQjh6ecHfgNoD9bWZBlNMsV3eATe3TqF09h4GM/kEGd0dvfdgO/v2ES+hM
	6B/AEmwY48HBKW5mknOUX5qbsMdrViTWjqyxYuJ+yjfQV8WjachHFxKuSr883qXkoSvJOGz71R+
	rFb7N6KrRNHsV/SURGnt50YsGbe5VMJqBkLlU974g7/Ww3DOQO1Yo2nn2nN3W+u6icORZZZyDdW
	3Tew4XRXZdU1H2TGy3U9u5RqzGfJoSaHWg7VufteULiv6ct+rlNGA+WpCUYlhrVCZ9RJ6/RLZiW
	3EaX0SDKLDAluZldWBASYcL6Q7X4XUxRox99z+yaaz+iaRWUahKaje1EWIU=
X-Google-Smtp-Source: AGHT+IF6UEl5mtsxl7o9WPZRz7/ZwBJ7CERCKjiQ+Qs5hzHkbmNf1pT+SXxz56MDZ1bWQaFNUcw8qQ==
X-Received: by 2002:a05:620a:1992:b0:7c5:f696:f8e5 with SMTP id af79cd13be357-7d5c46890femr133034085a.14.1751416440556;
        Tue, 01 Jul 2025 17:34:00 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317cc43sm853106285a.46.2025.07.01.17.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 17:34:00 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 0/2] bpf/arena: Add kfunc for reserving arena memory
Date: Tue,  1 Jul 2025 20:33:49 -0400
Message-ID: <20250702003351.197234-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc for BPF arenas that reserves a region of the mapping
to prevent it from being mapped. These regions serve as guards against
out-of-bounds accesses and are useful for debugging arena-related code.

CHANGELOG
=========

From v1 (20250620031118.245601-1-emil@etsalapatis.com)
------------------------------------------------------

Addressed feedback by Alexei & Kartikeya:
	- Changed terminology from guard pages to reserved pages.
	- Removed the additional guard range tree. Adjusted tests
	  accordingly. Reserved regions now behave like allocated
	  regions, and can be unreserved using bpf_arena_free_pages(). 
	  They can also be allocated from userspace through minor faults.
	  It is up to the user to prevent erroneous frees and/or use the
	  BPF_F_SEGV_ON_FAULT flag to catch stray userspace accesses.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf/arena: add bpf_arena_reserve_pages kfunc
  selftests/bpf: add selftests for bpf_arena_reserve_pages

 kernel/bpf/arena.c                            |  43 +++++++
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
 4 files changed, 247 insertions(+)

-- 
2.49.0


