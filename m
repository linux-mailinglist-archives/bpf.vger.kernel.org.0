Return-Path: <bpf+bounces-60786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDBADBE50
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E386A3B30F1
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662C14A4DB;
	Tue, 17 Jun 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGiBon4+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F926281
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121837; cv=none; b=dDM3W1RS+YQcNd/Zi5ZjI6N9WsJA4yrwfCZpkeNWKndo1kIO7SoYa6o3dGxYpDmpINtpe7+WrgkzWL3TjNvEMC0UvMqH3bKHCM8AT9T2UXYZ9HAzrBl5uzi0G63tfh1PYfLiWCj2wnn+RJ2QCqTqJXpfzqpWMOUW1u2xQr72rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121837; c=relaxed/simple;
	bh=Y3r6heTsj6eRcqphhDtmpCMPPg7Ycpi9YXltg/gp0ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubaqMdZ64WwCYiaklOV0NPzXtuNnfG6PjltcJM/pZNxBS0Z7+ZEQ+WbMI7u63KTsNZRglpfWXoPo21EgE3TJljXV7MayK8zPcpQrhD3ezzaW2phIfR/kVUiR89kEw0wp6Ks3BlFH3u+3dyWd+ROyIsd4bBhurkglkv4bMJlKbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGiBon4+; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e81749142b3so4165551276.3
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 17:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750121834; x=1750726634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pihQSZH7yjUSFnsT+x4T/Ou4qjhLlR5ruH4SZqEPMeQ=;
        b=AGiBon4+/a6VS9BK+Dr4usG0ZFfenk7GPiSyUFDFy5IVLN0w524KtTFolsiHx2aU2k
         DbLG8ARL4wZcpoIVgKc1kwr2tqJXI6C1eIDPlfTFrr92shuAYuAMD1RmWzayZidDu7JI
         8kLt2jhoN8B48o1J71Bb8ThOAqdO8rqXmSxa5yChxzlaMLEbi3IyB0y0oI1UBpxGXkZS
         f/12B0BdFD2G3nti1boCMDpC/C5S+i0z7lojSIyV5Z9JNEBFMvkEM4XkIiEZ7Vhqx17O
         Q969qn7UiIXN45VmNp9IV8O1XMdJV6jgbKzrzuohnHyEW2URGQ+zDouImhwJFUakNRCS
         7ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121834; x=1750726634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pihQSZH7yjUSFnsT+x4T/Ou4qjhLlR5ruH4SZqEPMeQ=;
        b=oD0eRo17dMn+78SmAwhxv3aUab+6AWDIwrkKX2NYRCyyevyEcGJBvzOleMu3Cuhsb5
         ZegiOdCwJuzujpt805ssCk6f3nNiPZNMoQzG6eCOvf74Ml7xS9q+YW+feHwmpF1eN7iw
         ITLzHfMtYTS+Ph3GXDGzkf4lklarf0xvNv4RGLwXPep0aTlHGSOH0S/hUpvLzHrG/0aQ
         Xv4WeorOV0xNHmm5m4XiNxfXWwmnMVnpZ06+3x/LN8fYfaYZzibouJBCIZCw2S3qIEIP
         88SNi+ip+jsQ8ZQ2PZlFtyKJ7+ESPNhQan0b4/qV4dRISssJaERgiSYMdJL9sKPbXru9
         SeHA==
X-Gm-Message-State: AOJu0YydjhbwT5wCRrbT4Pc4Y6BGIFyLw1cI8oGN5JyWTF/TVeZ4jgtE
	D1bv3gRPIRopwnyGZjgaYQhFkpa/NQ/HMF6dXg65l/ZneWtpDUaxYYLOHZn13L54
X-Gm-Gg: ASbGncsLNG6ald7utOKW80XAcSVRSVv7K4wZwHNa7ZEzJGlt7bUvkp85iRiIvby/4eG
	SHxF2bWFsp0E1nMCHennBhyUhr7dE+K7slMyEFz/VG2gU8LxCfMY1KS8Uha267ljWVAMRM3sYf/
	qaYmdkoamndgdIRlOU1DFHV9sqPrvVXAb0M6AJAKvF7reKXLLRsO6D7X/aDw2ebKQ1mNum4IN/o
	jqpakLNxkC85yyclOINJNlqqTyQxOmtQZaMJoLXR/S8o40ORIHya6kkuKPR9FP9kwi7qkkZsKKm
	NetFIE1nBJJvRpf/WJxNvNZSD5NbV7Ay5PzBi2sUWO+wgKRCDXv5AA==
X-Google-Smtp-Source: AGHT+IGEVe7ZXYRT1QBYktOaVtoP5aDwFadc7YCgHtesDr/cKD9FYXQTMlDbJ+4PnmirrOFU4tBFOg==
X-Received: by 2002:a05:690c:ec4:b0:710:f2a1:fa6 with SMTP id 00721157ae682-711754772a0mr150250977b3.29.1750121834234;
        Mon, 16 Jun 2025 17:57:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7119dec20c1sm3195107b3.100.2025.06.16.17.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:57:13 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	laoar.shao@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next v3 0/1] selftests/bpf: more precise cpu_mitigations state detection
Date: Mon, 16 Jun 2025 17:57:09 -0700
Message-ID: <20250617005710.1066165-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kernel executing selftests is configured with spectre mitigations
disabled, verification of unprivileged BPF won't emulate speculative
branches.

A number of selftests relies on speculative branches being visited.
In discussion [1] it was decided not to add additional tests
classification, but to execute unprivileged tests only when
mitigations are enabled.

Current mitigations status detection inspects /proc/cmdline,
which is not sufficient for some configurations.
This patch adds logic to also inspect /proc/config.gz and
/boot/config-$(uname -r).

Changelog:
v2: https://lore.kernel.org/bpf/20250614050617.4161083-1-eddyz87@gmail.com/
v2 -> v3:
- stylistic changes (Andrii).

v1: https://lore.kernel.org/bpf/20250610215221.846484-1-eddyz87@gmail.com/
v1 -> v2:
- added code to visit /boot/config-$(uname -r) (Yafang, Andrii)
- in case if config can't be read, print a warning and disable
  unprivileged tests execution.

[1] https://lore.kernel.org/bpf/20231025031144.5508-1-laoar.shao@gmail.com/

Eduard Zingerman (1):
  selftests/bpf: more precise cpu_mitigations state detection

 tools/testing/selftests/bpf/unpriv_helpers.c | 93 +++++++++++++++++++-
 1 file changed, 90 insertions(+), 3 deletions(-)

-- 
2.47.1


