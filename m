Return-Path: <bpf+bounces-13798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B447DE0D6
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1350228137C
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FA26FDC;
	Wed,  1 Nov 2023 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Hr7hNm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8033125B9
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 12:34:02 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B06DC;
	Wed,  1 Nov 2023 05:34:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so55502355e9.3;
        Wed, 01 Nov 2023 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842038; x=1699446838; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0HGql/B87mI38HpufuxtQHzy9hkZZUidYFckvwt7Pc=;
        b=l0Hr7hNm5zlepONXZAUGzIguo/Bc9mAjHUrixECPBQOnhjFEepqxNttIbsEC2pB6uR
         k1vxN1o1CcGqyeS27HM2grH0AfLQ5/HAhFhaoROSUbraeuSrRlbXKVah6a3659gd1/GM
         8O5xSIRauWURt5skKEkMj2Rm+LjudAez6k6l/201pHkcgAOk9a6Hd1TtNwX8/j8D6evw
         NOWlHmPrllZKV9zdiDVpDZkqWaCkEA38r5UJmpGVFaZ/nkhYDNgHADjfLgX4Sbygqqqn
         8jLq+uipku7osLdWsoWAbcrWVD6sM5kKHnO7ejfWSiXZff3UgTWxmiFehgOoN5s42ino
         6z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842038; x=1699446838;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0HGql/B87mI38HpufuxtQHzy9hkZZUidYFckvwt7Pc=;
        b=edn1pxykyAcXV1iIIGHfYqJr9jtd5q1ePuoB594o7KwGogNPRk4H1syyxjDA5kFHvT
         YP7HHf/5wK2D22XGKulRQpj7W2JKBIjc30HB866107HA2guvKOT/azRdPf0cmfilxXLS
         XnZNw2JE8/nh59gDI+aT1RngQeEhzCL+xZSF4+c5Mn+u3AUMmonSU7LXEE+Xk8F5nXPY
         7HWG7y+7KEcH7AFGs/PF6vJBLvHSFQiPxCjSO15RMee5NbhowQMZBU/bsTxzmPxXFLBV
         1fgH7lo0guzY7a5gEH4zwab8I86zIh4BrnqfU6mPd10napDyLV6YneAUmqtSeBgaeYrL
         RMmQ==
X-Gm-Message-State: AOJu0YzDC4FLNDoTRJDLWgGA2F7XVzm0kzbrK3nlkgcMcPegjDq303is
	2Rsn4sFO+F+JngnJH9fXtg==
X-Google-Smtp-Source: AGHT+IEzRnpvupbJqurKPYdvU+myaEym12O4RXMuH1rWvhgrbrgYScghO9HRhp/aqYPhEjbD85XmRg==
X-Received: by 2002:a05:600c:4fcb:b0:405:367d:4656 with SMTP id o11-20020a05600c4fcb00b00405367d4656mr13435076wmq.29.1698842038162;
        Wed, 01 Nov 2023 05:33:58 -0700 (PDT)
Received: from amdsuplus2.inf.ethz.ch (amdsuplus2.inf.ethz.ch. [129.132.31.88])
        by smtp.gmail.com with ESMTPSA id fk15-20020a05600c0ccf00b0040849ce7116sm1453505wmb.43.2023.11.01.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:33:57 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix incorrect immediate spill
Date: Wed, 01 Nov 2023 13:33:50 +0100
Message-Id: <20231101-fix-check-stack-write-v3-0-f05c2b1473d5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK5FQmUC/4XNyQ7CIBAG4FdpOIthqVQ8+R7GA9ChnWiXQIOap
 u8u4aIX42WSf5ZvVhIhIERyqlYSIGHEacxB7iriejN2QLHNmQgmJGdCUY9P6npwNxoXk+sj4AL
 U1UxrpXTdekPy7RwgLxb3QuzsyTU3e4zLFF7lV+Jl9IdNnDKqrBQH8NJBA+duMHjfu2koYhIfh
 TP+SxFZcbZxvLFHpS37VrZtewPZ+MbMBQEAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698842036; l=1098;
 i=sunhao.th@gmail.com; s=20231009; h=from:subject:message-id;
 bh=CUeu8WtS2D2jLPuVS3vfrplsl4FSe1lavxbwEiYGSdE=;
 b=31NfOkAbG9wCe0NTj/U14t+isRdZEBPMletRT483lLPjeWK1EvT0v7pnKiE1KcstOSA3w+VK6
 UXAb+dCiOJwBiayfTUzgCWQqDfoUFtFPCGp/loEHzQdEeHSTbBswodu
X-Developer-Key: i=sunhao.th@gmail.com; a=ed25519;
 pk=AHFxrImGtyqXOuw4f5xTNh4PGReb7hzD86ayyTZCXd4=

Immediate is incorrectly cast to u32 before being spilled, losing sign
information. The range information is incorrect after load again. Fix
immediate spill by remove the cast. The second patch add a test case
for this.

Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
Changes in v3:
- Change the expected log to fix the test case
- Link to v2: https://lore.kernel.org/r/20231101-fix-check-stack-write-v2-0-cb7c17b869b0@gmail.com

Changes in v2:
- Add fix and cc tags.
- Link to v1: https://lore.kernel.org/r/20231026-fix-check-stack-write-v1-0-6b325ef3ce7e@gmail.com

---
Hao Sun (2):
      bpf: Fix check_stack_write_fixed_off() to correctly spill imm
      selftests/bpf: Add test for immediate spilled to stack

 kernel/bpf/verifier.c                             |  2 +-
 tools/testing/selftests/bpf/verifier/bpf_st_mem.c | 32 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
---
base-commit: f2fbb908112311423b09cd0d2b4978f174b99585
change-id: 20231026-fix-check-stack-write-c40996694dfa

Best regards,
-- 
Hao Sun <sunhao.th@gmail.com>


