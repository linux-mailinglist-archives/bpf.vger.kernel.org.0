Return-Path: <bpf+bounces-76032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324CCA2AE3
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 08:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B01D3006737
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 07:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16672301027;
	Thu,  4 Dec 2025 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYGpd9Gi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070E2FFF95
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834420; cv=none; b=sBWXiyT6v8U0pE8oyHmwQIm1V51a9Cqd6rwbfOSgh7yflgFct6ixMfq9ZIt8ZZRRTUNoHXH6AX2ZKgXt7GUrpKB827bIYb9DAW1iLS+v3L8pajDu1J04KWpMuC5uBQvsj9NTNAkuge1WCerz4GydnVAGt4ZNLyWtx1XGbdDpkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834420; c=relaxed/simple;
	bh=80SRJuOgcTTOlotUZtwxNq10fJ7vLgfVquViWgwDO0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SNErWeHcmlA1Dmz34XGRBL7VI6lw/jsv7tFelZgw1U8rItiG2yJw02G4X9ekkk1IfkSr7j78/61r9R1sRHofmDr1UiCN+EOpWOrkPrhTCESjGHvW6QVm/iivUH1/94vHTjxRlxEVHCN4NguoyTKqYuRw80ixuoMSmcNVmIabn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYGpd9Gi; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640e065991dso436355d50.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834418; x=1765439218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=VYGpd9Gi9+XUN1o1QF1ftGMaiBlY7c8AWMnkdyCUt+KEXYy/h+27pTSr5l/VBQ9P9K
         BL4LQP2mxLgWUNAAtxZj2ad+cVfRCXs5aYOhBuoVcd9wIFPzJvt4DoikNjyFDjKwqq/u
         TBTtJKolDpVgyWgTXONv2CUme93uYgj1MArdB4nUAtwWG6vCyGgIEidQ+9wBRveKHxEd
         lTSjmX9vHn/zWdkCqUsZxyimK+6i1PIz9Xv3Sf0q8x58XPd13++e0gYtX1jZjGsKdGcN
         sPTGyK0QfroDBZhZm4gSG6BHL0h1wrpTTQKHuEKCAmNu13Osne2oplw1cXSA0fzIfDbI
         w/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834418; x=1765439218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64al5XjBckKJlAGYWOzuZ9pNtheivLV4ZpzNmU/B6No=;
        b=wjJTDuGer2bUly7Y5k9SirifTdrtfitplBNJOUuQQdaBXhiKzTLhORxtKyxf6jwOky
         /wvmQwFcte0akTtn0DHQJf4ysxrwkydyaCbc3RvP9o3DKJG3PIB/WhHwETgWKq7+/tRx
         9p2tCLL2usDlQSm9wWE1djZwpThSVxkUNI4QqZ8zNr1RqhSmEs+wpxJRKoN2XmlvrTQY
         lp/tNqplovo3vAfA+JPHgab6vMfrGR0zhCpFKddsntpHgMnRcmM9eSvRSye9a7SmWdcP
         MYFKbJJkwDvnfV3WKqNTGLSqaFRN+lxQQ7Y0gWdYM3nEKCypLx6TJKary6wn3SGfkcKj
         rwww==
X-Forwarded-Encrypted: i=1; AJvYcCW3HY9b5ikgx1TD2KC4FLTfh1rIy8Pwge5pe1+6vEUCcATgDIJWNnMqK9Ftq9+7Mck7guQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMmYPAf4Yfnwku/GKN6FdbfL9iGjdH/wvxcCIIdq5d8l+wSJk
	yxEilhAaXwyJmScyGAi6oqPoueFMCmHccwgNFTPjQeJPNog6cljmAiXP
X-Gm-Gg: ASbGncvoWym7org/Oq1hHy5Q8c06++Ya3HOla19e//o7PD2qtikWS4w3nIhuojzkEep
	8yX7esezUdVNYR67556ywkDGV+WBjGT09wr3jNyqKuaJ0AMHGbOd50B5DT4dLUAZ0FXCRA16yXN
	7JePn2W7c3NyHWYctd23Yi24E4MlxdO7uNskqeFN/+BG1151nBCOmXqAlvto1S9kao6jlwDMn/H
	swVcIgqplWP6ovBZGuhZA0bhnQr739ubJ+P2FpxtySdwznXul4GboZAhDwcEV7Ey/X9rZR4k/dh
	+Y7z2PyECmEwdiPSK5sRKAFQ1LgCNqW9I8VkkuzV22LXOi6JtCSWbyNJe3vGJUEcljXPh/7TA7s
	EhdsNa2xjveWf0e7VUIuxGGAX3IkmAGOh4KkTyIlTwYwnnt2FD8kJox8ydmQY/NnkcUoDstWDA6
	IWarvL9oPlPQ+KZ2hp/DhITR9miAb7GeGbHPuKPPQIzBUNSe6zyI8=
X-Google-Smtp-Source: AGHT+IH9QdNew3zKd3MAg8XQ76QMKfr9y+L0i90gdPpGFMiV8Q8w/KZTKg3m0AoyZ7lPvAh4HwpkBg==
X-Received: by 2002:a05:690e:4101:b0:641:f5bc:6981 with SMTP id 956f58d0204a3-6443704bc86mr3412127d50.77.1764834417911;
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.46.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:46:57 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: fix bpf_d_path() helper prototype
Date: Thu,  4 Dec 2025 15:46:30 +0800
Message-ID: <20251204074632.8562-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a verifier issue with bpf_d_path() and adds a
regression test to cover its use within a hook function.

Patch 1 updates the bpf_d_path() helper prototype so that the second
argument is marked as MEM_WRITE. This makes it explicit to the verifier
that the helper writes into the provided buffer.

Patch 2 extends the existing d_path selftest to cover incorrect verifier
assumptions caused by an incorrect function prototype. The test program calls
bpf_d_path() and checks if the first character of the path is '/'.
It ensures the verifier does not assume the buffer remains unwritten.

Changelog
=========

v4:
  - Use the fallocate hook instead of an LSM hook to simplify the selftest,
    as suggested by Matt and Alexei.
  - Add a utility function in test_d_path.c to load the BPF program,
    improving code reuse.

v3:
  - Switch the pathname prefix loop to use bpf_for() instead of
    #pragma unroll, as suggested by Matt.
  - Remove /tmp/bpf_d_path_test in the test cleanup path.
  - Add the missing Reviewed-by tags.

v2:
  - Merge the new test into the existing d_path selftest rather than   
  creating new files.   
  - Add PID filtering in the LSM program to avoid nondeterministic failures   
  due to unrelated processes triggering bprm_check_security.   
  - Synchronize child execution using a pipe to ensure deterministic   
  updates to the PID. 

Thanks for your time and reviews.

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: add regression test for bpf_d_path()

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 90 +++++++++++++++----
 .../testing/selftests/bpf/progs/test_d_path.c | 23 +++++
 3 files changed, 96 insertions(+), 19 deletions(-)

-- 
2.52.0


