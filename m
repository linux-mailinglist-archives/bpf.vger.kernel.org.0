Return-Path: <bpf+bounces-40317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB169863A5
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 17:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BE1C24E3E
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 15:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC21AACB;
	Wed, 25 Sep 2024 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSBIZlpq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9681D5AB5;
	Wed, 25 Sep 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278221; cv=none; b=W7eN/QjiWDf8Gu4tLvh/+UNkv4emeFQRj+eKHZCbMbmguN2jCJ+X06aeedKlo0QScdYjJcWANvq9CiuReuQFBtuhVHq7olBw1d+TGdSRftOVWv0Jl7uAgXuLeDQuwJSgJqLlbvvXQZxRUGPWEe5C0adj3XelRjSxH9bQYlStcsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278221; c=relaxed/simple;
	bh=malUig89NeChM+qVHquLi7LMYSW5FYmMIjlUg/kZyj0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQxu3oXXHUC8VPC0C7iilhBrrubc9UhnTrFctSLHnTUnnWpTg6t9HmPJx0r7BvqsZ60kiaxrWG1AHHbHvxGjcRAGRKKpT/BZRHuHfzir/tmudsUwwV61APN1QFIQ3VmX9ZzAUcpKz+oJjYiNy8QUSEXdJxWx4BIVvUNUBbRv4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSBIZlpq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a0cad8a0a5so27264335ab.1;
        Wed, 25 Sep 2024 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278219; x=1727883019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wy30SQD1ENIWTPN9yMx/+ebAJKSjTfpHvofyTUnSNpA=;
        b=kSBIZlpq8UEMoCqX+bNU/tsn3uOt7f2gKd7S5xeKzRNk5IhT34Jwp/9twfPERR+IZK
         NdMm4Zp3rLXXTRiSYTjimBSjhpNSgIDkBpQZcZg1q/jleKY2Jyksg2omqxPVWLaFC8BS
         aPEmOu7Za4JUdmmuRoZh10azSTMmETpR9lTF6m9v1hXucG06vXxpFsY+ONjj8KSBZygU
         u6XTbThQnWkfmPcJmai/lg8cW4zED0FBXp0PqqWfcxvOqdV0xxzhVgTI9yPkzAobAvmE
         tt7vB8feGRnQ+jvbXFYewKhkHbbVkifZ0S68B20jwU8OW/qELyBI2AJB9useWnt8XoXH
         5FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278219; x=1727883019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wy30SQD1ENIWTPN9yMx/+ebAJKSjTfpHvofyTUnSNpA=;
        b=f1hjaT5e6aO5bKnVh1Rmx78ES1Kb1Er0vkOEDAaeOSlsEURmzsMG0eM+aukan5536P
         UkTnZwwctPEWc5Rbv8d4FHihvIWUv7SUwxoYwWtpEQ6LnYv7H7sCXgOZqNfZntCc4bBX
         /JPOEZCwdEqOuKbB0ETcrWAMxyq04a5XmmwwMgzk21WoOTcfEkXPyg94QM9IBL4cnxmo
         shSQ6UK9p5JLvy2JymWdVdMUTmapszruP9MRRLYUZ3zdlhgjEYaPxtNBqT3LXhhHZC/6
         e739sLIH2cV0F5CIOeHN5dTrdK19XwXer02fX5rxX0uaXUsF3viQ3eefUezkIbPdFvte
         5wFw==
X-Forwarded-Encrypted: i=1; AJvYcCUzmcOnTGxvonD08sRchwabz04Bb64KzqJ/UGC8Tg9ILVDOmccLuuRwG8UaQmhkGZThLGYR4nE9b2HkbFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwIhdYXDI6G0lc2YVK3LStqNsnMiZY3R0kFMAk759AGM1ZGvF
	RdOQbkAg3MtV3gGeGc/8XE4OZO9sbzjQY5K86bhwlPa1J5D9wHH0
X-Google-Smtp-Source: AGHT+IFlegXREGRke0UC+wjN9U/8NAQ5KzPof82ogZf9upE9hpC3GX7msAHbZzZ1le0Tx2S53QaE7Q==
X-Received: by 2002:a05:6e02:17cd:b0:3a0:bf6b:6bca with SMTP id e9e14a558f8ab-3a26d72cc69mr36490425ab.9.1727278218783;
        Wed, 25 Sep 2024 08:30:18 -0700 (PDT)
Received: from localhost ([117.147.91.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c32875sm2840764a12.11.2024.09.25.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:30:18 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next v4] libbpf: Fix expected_attach_type set when kernel not support
Date: Wed, 25 Sep 2024 23:30:12 +0800
Message-Id: <20240925153012.212866-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit "5902da6d8a52" set expected_attach_type again with
field of bpf_program after libbpf_prepare_prog_load, which makes
expected_attach_type = 0 no sense when kernel not support the
attach_type feature, so fix it.

Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Change list:
- v3 -> v4:
    - fix some typo
- v2 -> v3:
    - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggested by
      Andrri
- v1 -> v2:
    - restore the original initialization way suggested by Jiri

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..a78e24ff354b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
 	/* special check for usdt to use uprobe_multi link */
-	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
+	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
+		/* for BPF_TRACE_UPROBE_MULTI, user might want to query expected_attach_type
+		 * in prog, and expected_attach_type we set in kernel is from opts, so we
+		 * update both.
+		 */
 		prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		opts->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+	}
 
 	if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
 		int btf_obj_fd = 0, btf_type_id = 0, err;
@@ -7443,6 +7449,7 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.attach_btf_id = prog->attach_btf_id;
 	load_attr.kern_version = kern_version;
 	load_attr.prog_ifindex = prog->prog_ifindex;
+	load_attr.expected_attach_type = prog->expected_attach_type;
 
 	/* specify func_info/line_info only if kernel supports them */
 	if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
@@ -7474,9 +7481,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 		insns_cnt = prog->insns_cnt;
 	}
 
-	/* allow prog_prepare_load_fn to change expected_attach_type */
-	load_attr.expected_attach_type = prog->expected_attach_type;
-
 	if (obj->gen_loader) {
 		bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
 				   license, insns, insns_cnt, &load_attr,
-- 
2.25.1


