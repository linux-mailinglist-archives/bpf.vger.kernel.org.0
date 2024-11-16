Return-Path: <bpf+bounces-45014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E299CFD35
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 09:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEACB24AD5
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44A192B63;
	Sat, 16 Nov 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="ns0BAJ6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21507B64A
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744672; cv=none; b=hF4os9DUCeJ+zM46DZ+3/PyH00bQ/mX69Qth0f/7Ce2Z87cEuzG3hBQMVpG082T18aNZnMSFzZZXtKoS4NqYqEUo80V6jUANjerEW22gUMbdxY6DtTKQNqsdvf7SHd88QRuEh4PPBTAUO2KlWSMbBGXkhCfi2a2/ZQ3m75UEVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744672; c=relaxed/simple;
	bh=I5d6xq8yApFLD3lqBQul4LMzk21YrsqnImFrxksSgCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmTqCPnDpdXjn2nTC5u5wI5Ihs/3WY/5yccoMPUwOn+hejN5LVkjEbY6Dvc08yq8zWop7lFj0oknx0kGfryvBOSNcCpxXRT4y1hFQXlUjg2GSdkvRFICTWVuUG9Z2evE9rRcmXSOc6h6Cep52gZ/uhAm2objXL/EKOn1eNjzjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=ns0BAJ6L; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso331432a12.3
        for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 00:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1731744670; x=1732349470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96+ITd4Yn9GceeD6WwWI1juRk5f17FxOFIRFnl0ul0k=;
        b=ns0BAJ6LhrQ+QXzoKO1fuDfYAfkqdLKT1RchI2RjJeetwET4vKDe1mBXdr4diTnBRL
         /Ya9frbJDr9sjB//OPU+aPZ8ZfgPSKIUfR3nf48RfMKhxA/jn0waEYVzuo60HC0UyGHh
         wrOUPD4ZK1gNsCcYJs8Tbc8oV3NT99hX0TMQLT/848qilMEHvW1N+hENCs9KhjA29jln
         Vrlhs0+IYAyCBkcqk1xBCT/eABsI+Ro1eOU1XTEI35MrH5ueOChGQo1BhxfIviM76NjK
         lj+tR1w4mRpEkwpBJRco7bj0AF/W9R1iCuBaubG2z3A6d2rql6uyek5xV/J4TLTiODM1
         dVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744670; x=1732349470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96+ITd4Yn9GceeD6WwWI1juRk5f17FxOFIRFnl0ul0k=;
        b=dqYNunuXhngZ4ADCAZykYuOA15OlfWIhYCj4UUpgcloKDv0qJkosxM31Pe2D9maC99
         eWTVRtafI+ceUG1gUqXRGPJEGfGPTQp0wgzvWIiQTx3wmPz01NMoPE1eIZJU83JcTFQD
         ppb/g43+1Z6yFhAv1j55Oh5ANFU9bbEXyyCzsx67g9PHeM8zABSk7KZ1/6aYAdnU7tp2
         xECyt6tG5NPLVocOYyNEnZD/fscVr06jqOA9r7l+iMldcQLrdS5Z8MM8UNVjjPR4pf9S
         OAEflq+JeOo9ZsLNaibOhF6HBMu8cZtZsemWZkZeQ2JDv+FOHKffU4VnTJlDB1tk6/74
         y5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWF3Oc/Sjga1A3mEl5KNOX4pHq08k6hjrGv1u1UVszCOlQT+soR0q4WtJJCsSRuiBuu9lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqM3BWNxGoxfVhRInRI0quStOrm67RWUSS/K0Bugr4RBEyE4p0
	d3grDKAtY+l/QVhBRQ9M6dtRY31OYSC9SQKm92jXFsL30sdM49P+EM+NBqFb2qM=
X-Google-Smtp-Source: AGHT+IEbav/q6nbtcpi6jdgXPqNXxpTkVa7JXKPtww5C9bR4QElLwnA5phd49NQB6khRf9cPHWGSBg==
X-Received: by 2002:a17:902:ecca:b0:211:ce94:866a with SMTP id d9443c01a7336-211d0ebf214mr78997325ad.40.1731744670439;
        Sat, 16 Nov 2024 00:11:10 -0800 (PST)
Received: from localhost.localdomain ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211eca09906sm8106475ad.246.2024.11.16.00.11.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Nov 2024 00:11:10 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH] libbpf: Change hash_combine parameters from long to unsigned long
Date: Sat, 16 Nov 2024 17:10:52 +0900
Message-ID: <20241116081054.65195-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hash_combine() could be trapped when compiled with sanitizer like "zig cc"
or clang with signed-integer-overflow option. This patch parameters and return
type to unsigned long to remove the potential overflow.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8befb8103e32..12468ae0d573 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3548,7 +3548,7 @@ struct btf_dedup {
 	struct strset *strs_set;
 };
 
-static long hash_combine(long h, long value)
+static unsigned long hash_combine(unsigned long h, unsigned long value)
 {
 	return h * 31 + value;
 }
-- 
2.42.0


