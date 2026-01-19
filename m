Return-Path: <bpf+bounces-79424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55622D39F42
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B833018D50
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771792D592C;
	Mon, 19 Jan 2026 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTBlbN63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1FE283FF9
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806183; cv=none; b=cRnfu2vlJBfFylo3zJwQ5/UwQf689Kf+OnFJmnkLTqCAByJdisuIZjBsbl6ycxjTbuS8dVTCRwxax9LcEVaDklLNaCl5PuzzbaV9KZlWgJFRzuV7o5yJ/3TpaA9ruEUd+rRPmXCmw4eCMauTWzjkg3rjYVbvUa03Pk/TBhn/MhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806183; c=relaxed/simple;
	bh=DdgCNbFnRFaEMMfPy9jfiV+sBRHcEwM8dVKuFJjqdSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ss8FSMVbsiN3qP/+KkU6+nFdDmDfcpLKDIFvMIorwX0KpBBWNziTkrPh/Y2NUQHsZaUNDozXXXMYQAYvntTbOmeDzEmqwUgUJ/Lj0OOHSFPgN92KriStuuiRntLbUcHPWjUOpWwEufspLp+i+TvdZLDJXtzs8KnyBqO5LXVp8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTBlbN63; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso1425053a12.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 23:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768806181; x=1769410981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cdRzCfUgSJDKZEWtKLgkcTp+mO+wBFV38oyrlfiOmQ=;
        b=ZTBlbN630zQCkj+hPuw8492sPwm/c66poOr5g+4nnYTkl8IBp6mxKCdgFHtiLf7cZA
         me3ZeUnwsOebYH4mo3BBZdWMf0vKCIGjR9Shg9Nl7MqAiolzbdor2mo9VNZIPAHDUuEZ
         HDj9niVBgpjnyjgrr2FbHThfEosGcWmI6JBgieG0Z4m2tz0nrf7UkQWfq82CIGZdv6bJ
         rtASabbQM/FUxl+aOLyc93OnLxeCRNmCb1mlGJ2csQllLRLPekbyF8JHQbLUezFrro64
         LZaXlcA6u38szPPsrqFj3C2m/8uu78MJsk8DnrpaCDbpgmOd9lnXlzpruTD4AZB9ZXer
         IrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806181; x=1769410981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cdRzCfUgSJDKZEWtKLgkcTp+mO+wBFV38oyrlfiOmQ=;
        b=wqQPy1lplck/PLcaLdGoBSSM/rRvNvsf5vsOxPB55PX1P+MX3eOehsFmy2jGPVZBuN
         xaDqXu5tPC8HXE5k8RKAVSi1uLuqBl+0uuYkJLKY63JHQR6QEVqL7dAFiIUKUCLej/kT
         bKgPlmfHiomypsWNv9Kcm59W8naR3ReylvZlVtGIX3QkHex0miCzIJzA4bTrQr8DfHuf
         hFQvNSZ/o8TPgJKr9pBeFIVJvhy6cxiySSZAmZJLFHoETdAUd5Tw2n2R/mdOF/g/PUbQ
         6uPK+TZgbJrnqnj/nmB6cTowKK94HzcZxacGYKUY2DJIwXr3vPYmA3X9CE4X5QGKi62w
         FxEw==
X-Forwarded-Encrypted: i=1; AJvYcCW088BgMp3KP6Y2J1AXbjZEWPvaVkbL61gX5DzTedKELoaqIqvBiJ/IJHvh8QhIAyr+kbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZLxJa2qWbZPQV0eZWLFEMa8vFP3BzZhC8kphDgBhs81mkhhA
	3w2Tsb2YvXl/93Qi1cXGNfWFH94Y1dWutFAVg/OmHX/qtOU1i0G38cKC
X-Gm-Gg: AZuq6aLUBmDKMR9w32rOIKvybY/SelEGPZtkZTIdYHtyaUZjMOVpQDzICTgxxXVSzmc
	EcozEW5y63bN/wwdAqMF5IKeiLUGXdCMigU+DK5eUoNsL40UmvTrHMAwpi9hkKT7qtTF86igPcS
	ky4RAtC+7joqYyhv4tCO/Sm4LsRiuR/ZFwB1i4L9mlN1Fdr/Z1TVOV3OsZKhonKg8Uy6H02voER
	GC5u6uceUpgT4d9YWhD5eR3BEf0lIR8rEdoZ17Tw5KUfF6zPkNBMrbs9FskEZqjseMfk18QR//5
	/DSECrk36Nq7kJiD9zCqhI//FJI5ySkfwLd0VxSVkSmAejMh+n4vULKVi6mebNaaDZninHUVLVH
	yfyp49jGROOWkjRV9x+3Qifo8d6EUzPkWtJ5510UMUqqz6EukupECrr2djhPj0CmNgR4e3+ZyEw
	3FAF92lH4I/ZbnkjlBSbI=
X-Received: by 2002:a17:90b:5344:b0:34c:cb3c:f544 with SMTP id 98e67ed59e1d1-35273179d01mr8288444a91.14.1768806181104;
        Sun, 18 Jan 2026 23:03:01 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec7dasm10772027a91.8.2026.01.18.23.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:03:00 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Mon, 19 Jan 2026 15:02:44 +0800
Message-ID: <20260119070246.249499-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance, and add the testcase for it.

Changes since v4:
* don't support the !CONFIG_SMP case
* v4: https://lore.kernel.org/bpf/20260112104529.224645-1-dongml2@chinatelecom.cn/

Changes since v3:
* handle the !CONFIG_SMP case
* ignore the !CONFIG_SMP case in the testcase, as we enable CONFIG_SMP
  for x86_64 in the selftests

Changes since v2:
* implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT (Alexei).

Changes since v1:
* add the testcase
* remove the usage of const_current_task

Menglong Dong (2):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: test the jited inline of bpf_get_current_task

 kernel/bpf/verifier.c                         | 22 ++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0


