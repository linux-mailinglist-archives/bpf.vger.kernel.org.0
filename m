Return-Path: <bpf+bounces-56227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3ACA933A7
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548458E45E5
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA323ED76;
	Fri, 18 Apr 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ex/j+x9C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714BA19D898
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962417; cv=none; b=IXZsqjNwav/zLXSJrBr2RXUNp8A1Owz6O2ZfsD5omBclz7gFIAS5F+HNSkMe1YkZgStCxpP8+sRMD4zsphiwEeb8Vuapwe4gnVc7NPhBQp/hXLHM/LSiodf4PmOdeCkA/OieoLlKi+HCg5jz8zUX6+ORZ3I1Q3VLilTu5WHMgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962417; c=relaxed/simple;
	bh=3GhLiSMxls0A/YAi2B2DYLCR0bDvaFo1q4uXctL8vNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mhmce7EuX/V8wquZfuMlD62F3HzA7sWHHW7rpMcF3CY23NugLRAenZnSQjl5N6PIhU+H29tekVVEEIdzKYJOLyIxmC3x19JR2DIRs90DIK3xwUK1mDaWrEwYB/5yzEH72vYKn1o4HoCt7icqhwGKYmYB9e9x4CiwlM0DzXzUOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ex/j+x9C; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39c266c1389so1123031f8f.1
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744962412; x=1745567212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5+E2zXG/nziXKULY0gjHljIJJ/Eg15tV1NU/Whmn1U=;
        b=Ex/j+x9C639CVkFdbPNbG8qUA9edzilKNysVdXmiw+85t3qGttdtokwkPEJOowZREt
         0TdYSoNRdtIpgjLQmLPsV6auoyiZrufwqlJwhPjtNnu0uAEDGou2X96Bk+2BhS20Y+ys
         4xkaCdHoFr73lCjoIyqquifnijrotjVYkwC0LhwmxurkpBD0g+OUbJ6/AUwFxxnxJ5QE
         qKWl+E5Xg+NCPv4+JCSTnW9l/0RojJnN0PG3n5g3Ib14gQp8sP77fsWspXrRuFwKOQL8
         SHzUjV2+0aV2mclg5dGcZLfm9mQbANZNgQVsHgo7rz7c0Qp6ZedrRaHetfBK/HVKRn+H
         RCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962412; x=1745567212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5+E2zXG/nziXKULY0gjHljIJJ/Eg15tV1NU/Whmn1U=;
        b=X6dMJXnyfKgB5R0jf2aduZBC5WWrXPBFsz3hccdctaBrdOXa2vlpbDuEMS61E1qvkT
         axAgF4Zh92S6FIz3OueL2/HOJyoklGdfW9Od2hpDtq35jv1PNEIpxLGtQFy1URCF3cnD
         Y6hAWrlCEmxfdTe+xlVhwx1Oz68n7aht7JWLVdfxDRutRatgiAyvffrAS6GeeURC53Dz
         Cf/6EqES149zoeFj8FKQab/W4gy44rsxf3piFLxQFSztGJvkDWCXVB89eFszdgFlgJF1
         cBIaj5vfPUwBhDRtYi3PYGz5asiJx6ojXcnq1baUBTJXQ08DjEbTZMMaK3+xss9/ua56
         LDZw==
X-Gm-Message-State: AOJu0YyhXVki/5jjuFK1yozy+J2FJglH80Ps2fYGHOZ5KH0BmTNsxU+z
	YsfHwbKGffI3Ytl051BMftB+1Vxsjkmm8KrDQCr494yUE00a5HaZ/m2rc6Pww94B33fMq5xdb20
	4KhtJGA==
X-Gm-Gg: ASbGncsr4+LWSQcaPXZOoGaxtGec/rQe45ZvjrO5D32+ahTwAZM9BReohBjhv8wmAEB
	8mdQ5FoyxlDR8mmHpmJiRsyNsUaN0Vffz7kb8Idu5vwV9XJY/+KqEHjCKG1BkqC6c6en8mJJgYt
	5OdxLTs5e0dWVUQy6AzegOCAPpaEuubs6lXEHWNIQ5iM4MclPmGk7I6SgUXmjNdCcfwXH1V0QAE
	/KWrvkArrm8NTzX6/B1ZKAen1TK0LSKWCtBdRfc2RB6XCKXNKTZtT91IsSys3EsW4y9ivZ4DSlS
	uHen+YPd2R8tJCUgB54gDGAHbxQE4Lp/EcDc9sG0CtYx1lTvmA+7aRqvrDZbTylky1NfQOhJKuC
	E+hEs7TI=
X-Google-Smtp-Source: AGHT+IEhqMqaClIXR4nDy8igckV5YFUlektgJcTSmMdl7VM9aZtrKQb3K1veIPg0B2dxBs3Gag0tVQ==
X-Received: by 2002:a5d:6da1:0:b0:39e:e259:91fd with SMTP id ffacd0b85a97d-39efba3cbbbmr1335215f8f.17.1744962412520;
        Fri, 18 Apr 2025 00:46:52 -0700 (PDT)
Received: from localhost (27-240-201-113.adsl.fetnet.net. [27.240.201.113])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4235dasm1952686f8f.9.2025.04.18.00.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:46:52 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: 
Date: Fri, 18 Apr 2025 15:46:31 +0800
Message-ID: <20250418074633.35222-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From bda8bb8011d865cebf066350c8625e8be1625656 Mon Sep 17 00:00:00 2001
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 18 Apr 2025 15:22:00 +0800
Subject: [PATCH bpf-next 1/1] bpf: use proper type to calculate
 bpf_raw_tp_null_args.mask index

The calculation of the index used to access the mask field in 'struct
bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
the tracepoint being attached has more than 8 arguments.

While none of the tracepoints mentioned in raw_tp_null_args[] currently
have more than 8 arguments, there do exist tracepoints that had more
than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
type for calculation and avoid Smatch static checker warning.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..656ee11aff67 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6829,10 +6829,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
-- 
2.49.0


