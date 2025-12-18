Return-Path: <bpf+bounces-76987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20ECCBF0E
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0D23107D36
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6B2328B73;
	Thu, 18 Dec 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdoW809W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03A2E8B83
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063238; cv=none; b=uhI+Wo5cumbzhBGesJYc7qoOBfj5MJ/9oAeX5W5g4euz/ZWF9p/uvJZxigqBJUq6zKv5bZCQusLkUCSk7pZUfbURO+ROsEbr0qE8tCFbkWj9tyI2wDQHyNAoCUynj5mwRAWv1DfOVlrNgD/HO9Ii7ymXKBh+rYMkPrCESwq0Aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063238; c=relaxed/simple;
	bh=TZ+mg3/PgNq4Be8wX9hZpd+y0t9hHYR5vNxg2s6h5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RxpyKQMA/kyVDx9dEuqpgVuVd2f7fDYTbbq7f9dM381FJz1KK6PEgjD86qodvlgucQfIUfTs565WfZMTtT0yDq2r2hZXOgN+nlAYpdN1YZKrfpCQ/KoH+6t74zDzmKAxKgxVsiRq4rCtf5Ay9nAGPtjSu7zSH1Uleui3qfIP0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdoW809W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0a95200e8so5354605ad.0
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766063236; x=1766668036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6MDSoNjVj8xGwzF3ZHeVHcF1K0gBl7qfRmDmp9Suac=;
        b=OdoW809WGjlI1Pf+KbvxZQo7VctMVdoyKGbUWZ4TqGSsUywHw7Yk4joH/DLbQlzDCT
         95NkSq5ASpr5Fyydj+9U3CqNEhlWFQZGpJRHAMoi7eh1p0KH+MGHABVNIwcHibFPgqNU
         cXF8khAiQSze0Fx54Vp3/2/yZxQDyqzyvOGTUn6BbheWIlX6FMTIJ0UfjyXyr05BzHuF
         QoiTQKIp8qIbiuHIVj7KoTWnCKSPjxYPU8oR1W9EEjnpqvYkserwLZU4dlYIvXyVkbNv
         GshfijHgdBUwrCkHATYH8wqs6bcGhHzTlUUvFdcRfwxWKhVQ56HESJH3ByNQiy6DH10v
         /bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063236; x=1766668036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6MDSoNjVj8xGwzF3ZHeVHcF1K0gBl7qfRmDmp9Suac=;
        b=ue+Bzg7Sbefb3b2YK7OrdFBdz7XiudC8943bWLl/EbGA5xjCIhhszN5yJo9j+Z32b3
         fQk8NWbvp1rHLrZS/CZAsX72poidKWnqp9ByoW0efhPRRzooOjDPchtmsORTXIs3LbdR
         lcvUftQXs849ugxHCc1NNham8b4BtHdx8X8RIe6Vb0H0W3vsFywAfhsSO7eSFmNHWGP9
         5fQtXYxSu6Gp7VT19M1fojKfwHWkQR6o/MDqxfSCs5mZ7kf5zrKp2ry4nUSkqrYDahW2
         PML1Eq/obMiJe7A6SFmhgojoN+NxfRsmZuA4mzGW9bBxKnjRr09dv6ISmwJ8Am5+aqr2
         qNLQ==
X-Gm-Message-State: AOJu0YxnOADhOTx50qOoTPb1a7VudiF9+GDLG4+oGWbsVyxfHUtQRLyy
	P/0J+7SFBmBNXvHqk6mnB4K9tyc9f9Mq8I2PyeytTnCIeHW8XLH6Y5Vk
X-Gm-Gg: AY/fxX5IENmYR1taLwiKxWesuHj7nM19AaFducAOtchJJQ25pJI1PLyuX1mEtH3SpK1
	VZj9MAl2YmLSpYB1Tl3KqhiHcmkEonq5OYXvZHe9dcViGXVCTUh5NQbVI1F7ncN/I5McwVmKcYc
	Czqs16p10wo6JqO68KgDmWVHrk1tNQu0lJFZTMd2hontkrwLHpWDwQW3dJnOyuDaCZIunbOvju3
	mEH3MvQK4cz/cI+2WxJh0bRsQlOk6ohWGBq18ZI+q66Mgu39yWRk2uYCgxq1WdanMHtodVNl0gc
	tTzxa67vxlIGNPZFG4O2O/7hOT5BBSlTkRwRz/NL6D8ekrq0E8josR3VEeGQ6qLaGb91qddBoIc
	Zoj8Z/jHdQ0tOzwhFB01muWGGsxfK5nPFxgf9t+stGKGQChMUfmaesK+A6D1VzbecvJTVfXeOE5
	Pvr3LaT2exxK+m9O5KHmdBRqMSIIA8h6nmgw8=
X-Google-Smtp-Source: AGHT+IHvO+1PD8RrEUebpSGTyKqxjCqg0KVzQG9kyzDrg3ZQ6OBh/WipWLO57nrDhnRsudiWhSkS4g==
X-Received: by 2002:a17:903:1986:b0:295:738f:73fe with SMTP id d9443c01a7336-29f23c7d087mr202108065ad.30.1766063236135;
        Thu, 18 Dec 2025 05:07:16 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cd2sm25539905ad.77.2025.12.18.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:07:15 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mhiramat@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing40@xiaomi.com
Subject: [PATCH 0/2] bpf: Add kretprobe fallback for kprobe multi link
Date: Thu, 18 Dec 2025 21:06:27 +0800
Message-Id: <20251218130629.365398-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides a fallback implementation of kprobe multi link
using the traditional kretprobe API When fprobe is not available.
This ensures compatibility with older kernels or platforms where
fprobe support is not compiled in.

Uses kretprobe's entry_handler and handler callbacks to simulate
fprobe's entry/exit functionality.The API remains identical to
fprobe-based implementation, allowing userspace tools to work
transparently with either backend. Cookie support, both entry
and return probes, and session handling are fully supported.

Jing Liu (2):
  bpf: Prepare for kprobe multi link fallback patch
  bpf: Implement kretprobe fallback for kprobe multi link

 kernel/trace/bpf_trace.c | 603 ++++++++++++++++++++++++++++-----------
 1 file changed, 443 insertions(+), 160 deletions(-)

-- 
2.25.1


