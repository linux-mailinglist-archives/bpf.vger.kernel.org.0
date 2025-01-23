Return-Path: <bpf+bounces-49581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAFA1A83B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9C316460A
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 16:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AB1537CE;
	Thu, 23 Jan 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHH2v72x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8311448E4;
	Thu, 23 Jan 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651379; cv=none; b=T2P1G2whcWbq597v4dewHXBygAknUHJXNeO1AMhYDykEAdB1mhX3Rn7Dqvd29JbjoUElEHZP+5dgEgPOANcFeYFBEZHOvvBw+d3Ql3jTflW5oxwjt+TgtfWYcN0mjFMcU5KVTPldUWQKJoiUzp1jkM7H9pHJVM+zyLRZBoe+Hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651379; c=relaxed/simple;
	bh=57gNsFeGAMlR0TbDCGi1s/wIv4wDl8lGHmb+XUT1DpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ssqyqlahj3eMYcRlqqmeQxvbznuL2lAJLR4ZBSomxBzHIqSq17w/8mtF6lyThGRCqrb1o1ubI+U3as/Q0o7KxuOk1OFxB2urmKqu6bD3b5HMaPNVYmLxNrvghjKD5nQiWNE2fYWNTiSVaqnEd6A2gl4O2C46xILhanagSiiCNEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHH2v72x; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so3836695a91.0;
        Thu, 23 Jan 2025 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651377; x=1738256177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5cHnouL9ni1UHHCnJzcDlfamXCkVHhgw5c2JHRsxX4=;
        b=WHH2v72xW4uKjylVJ0/Ds94G9pFK9S9y22+tSX/xQWrKZsermBieN2XstYiI6rj3uv
         ooIrVUVWUn/9BlsWWUmF2uCoI21CVXqGJ8BDdLYXpNrpfPi1TpMGjMbxL5mUNHPKp55a
         8vo3U5rRdkxEhlD7kFFTfv70LzUEDl6E5EBWhnm+KewugSyJeeEIYVjhY0hFF5MVRdD1
         1yTmAgFspdASsaN4GnlJUUJ90Nm/h1yjlTAow8VyghzEMxi3ZgG5wg2M3a1+NMDCfzIW
         /SF4xeDLbCR9E/lOdh43SbjT9/Kqyz8mqM4Azc4nQALbq4dSNuWTzP/HoAlzYf83KTt8
         SPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651377; x=1738256177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5cHnouL9ni1UHHCnJzcDlfamXCkVHhgw5c2JHRsxX4=;
        b=uO+iZx+Smc63b2F7mrcS20UTzl3X4Cbf8CrtExyTh8DfBRNzxccnSTPC8d9MrNTi3Y
         mwWt9vjDiRlVGUQWT160mb9V2/SUuZiiq6RWJedaazf7MYXamBHoktDWnFs0tELGlhfS
         3tVRvKWu4wFN3F1wMWwqWxS4A5+WgoOB6jUYH7zSHf3ecOEaC89n+/1wFS8sdsLtM7UG
         fkUCf2J2RxCbAAmGAYDxlLl6Zd9Rg6w9qfgLhUKA3WVmby6OCrQ3Y5G38u2choXyPikf
         vvtqaI8DdpySdZfryi8N9waSLTaIiCxve7z/GCyt0eNwJUi78sOzTjmH0GOkr4vpuuTS
         olog==
X-Forwarded-Encrypted: i=1; AJvYcCXx2oKvIdgc2NOI70IBimrYOElKyqYw/GjsWVYGHMYGrmsgBcUpMoEbrFZXxHiKZUBsTY3yZNJQWfbDuWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFacWJhJQhYSFC1BnIwvjo6QBmczL1CcSGMWpuoQu+Hw7zPRI
	czcTV1FJDIZ5BmX7GllAUdQZEn7B1vG103AfzqEbSTqNUJFaPwfm
X-Gm-Gg: ASbGncvL1FleN9xIMBRP5yC/fPw+AAzhqPGnF7Vx6v4i6Bj7QK9TUIAiD6UyB7RoIzN
	+6o+R5QwBJ4BeE4gDbvsOH0kqxxhYKBnZ01rXHPaPRvchbmXWBXXNgQ2e1ztqGuwlBPY+If6dAI
	PCYvMUx97vegOQKlb4+zLAwsfxWvbu0wa7TgQBx+TR1amWvyIP1n4xekHNAX9cgmGY/G9mmCGQH
	iRoDUYqMZedHeAELjMT76a4pvA9/+37B0G7LMr7gqZc+qVSehgUAFeDa68nogUIIIOKEWGyYO8l
	/Out2qJUzYKY+Q==
X-Google-Smtp-Source: AGHT+IEwwod62JC96ZjrtaF+fP91AqZZheS2JldxQl2U5g0PVBNqvy9lIjGePQr+Wa501aI8RZQSOQ==
X-Received: by 2002:a05:6a00:1947:b0:72d:25ae:cafb with SMTP id d2e1a72fcca58-72f7d223053mr6652175b3a.7.1737651376719;
        Thu, 23 Jan 2025 08:56:16 -0800 (PST)
Received: from localhost ([117.147.90.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b31besm157300b3a.54.2025.01.23.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 08:56:16 -0800 (PST)
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
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Add prog_kfunc feature probe
Date: Fri, 24 Jan 2025 00:55:46 +0800
Message-Id: <20250123165548.272140-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Change list:
- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - chenk verifier info when kfunc id invalid

Revisions:
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (2):
  libbpf: Add libbpf_probe_bpf_kfunc API
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        | 17 ++++++-
 tools/lib/bpf/libbpf.map                      |  1 +
 tools/lib/bpf/libbpf_probes.c                 | 47 +++++++++++++++++++
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 35 ++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.43.0


