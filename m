Return-Path: <bpf+bounces-50983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C52A2EED7
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB483A357A
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07570230991;
	Mon, 10 Feb 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyYpB4GQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D58221DA9
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195505; cv=none; b=p9zssp3+QIhgIK/L6zPesz0SVM8F0fAqJlIY64eIF5U3gHED7c4W53U00TIuiGlryeuzIL2K9X5NR0edXyvLTjlDZScyZsordHpHjHWzhA0SYJTNyyfEwhmRZdHhK7wQMg5l4uZypvVttB9VQcN1w8n6jr78rNTmoA1D6e/5heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195505; c=relaxed/simple;
	bh=Tf9r450ChA5z9HI79CiH14U1PithgzqkmbHEdUT6r4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bziz+yllnYR5RLRTfGtNbr1bfoBfahHj+1dXAJkm1siDmW5rgR08tW+AZcq9/j8gbZHHR0psStj5R+SxxYkftnx6W4QtC6PguRybpE+jSuf/y9VKZmskjZfZYL9cytP7kv+10heH02j8wMiWFuSQNekZZnt+Rg+qoCR47aeVMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyYpB4GQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5de6e26d4e4so2880130a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 05:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739195502; x=1739800302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6CkdA9Qi7r4Gc4LfLuQhDzXTrre/TCohh7LjRlmHtk=;
        b=TyYpB4GQvCwrcAKO+FTJ+Xpzujohkq2UxYKwVeCJ2XPmiosS7Rn4XG79NjXxF5xVp7
         FBbArZuwXN4Dfngy88PkHxfSxvnMoe0DAuAE2HZIJdfw8+hk5FcNxXJqk6RFIzVasvRb
         VkasH1QciXi/ns3mI8SktM0/volaGipkkYfiGb+TQkzMDaPHFGaTa5p616dsh3RtGWpN
         N3suqBiV404on9oyJd5QWCig1ZYmp9DozIwh2IJeSnYxkSx1PrkWMhmg9Nv2SLWeJsSx
         smhtM0ITBSc2CWVlbG0f1kQUZ38L+4kfhjgkJXJBWS0brLhsS80/q+swlls4wIS1BA/K
         z2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739195502; x=1739800302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6CkdA9Qi7r4Gc4LfLuQhDzXTrre/TCohh7LjRlmHtk=;
        b=f7YgSOysY27GvmB61Fuhy4zLZh13sK5aPJ90Y6t8T8IMrnHRT/hxpREkxUP+6vHbU/
         PHS0OQTK96p4orQlqkwiiPJkYrcCR1ra4SvshV2wjE9aTWrZIqixniyOcFs6+XMsaMP7
         YpLVYwY+mD3KpPhGBs1nqW38qySrftoFYJTtoJbCCLzqIOblYK9UtVbDPObgOSMWXIPS
         Q+3eNulxwtKydf3mCPnN0EbfYkGc2jeQ3xnJKUXlCPnKX4iGzjLCwIdW1micifqBpWjN
         Mydg0gKVqG62Azvi5ASz9imJUUFe0iooUirN66KLqz/C3CoKM+aeu+ynYg4jNDf2mpYu
         1AVg==
X-Gm-Message-State: AOJu0Yxoq8zb+s5aDFAjnxEwov+kCxVaYELwlv5gmplk4FY3fB3msjOi
	vUrjviXTxJIXjElJD1Jkco8TBgDgtOofrzosadq5qhcHxovne3+ImBp8zQ==
X-Gm-Gg: ASbGncuEwbFaAQjslVePKh1qhl6do9pOByZAo/mA9f45NUkNot7T4WQOlLFxPKtiPA6
	mLpOAm1CLBvf1FiUC3/NVvlT1hVBQdQR3bi9NGlrJtoIVF6zpQzhvyZYK5TvUUAPziNcMe2yVaq
	pIB7jn4E2DTHDYO2ACtwfG6PurYH17WyrDdsviDzse/yEy5eAKWK/uCWRoVNrcbjYoO+AwtgftR
	dKkyLJs1PRfgv3yaQgOYhfSeRz0uutYY8er8UHnN8UC4Jfix39otHbDX6f0sXtR6SqVioTS75Fi
	kILh+0kucoqh3HMQuJC9684HDfm/
X-Google-Smtp-Source: AGHT+IGT8AkuYaY+3klCxjCfw/FyUgsZDdt15wYpZSkOokXLbkRS2dN7b1vV5KT8DyqJaeREN4oitw==
X-Received: by 2002:a17:907:9628:b0:ab7:5fcd:d4e4 with SMTP id a640c23a62f3a-ab789c3ada8mr1695309366b.41.1739195501905;
        Mon, 10 Feb 2025 05:51:41 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:400::5:db8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7732e71f1sm878261566b.92.2025.02.10.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:51:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: implement setting global variables in veristat
Date: Mon, 10 Feb 2025 13:51:27 +0000
Message-ID: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

To better verify some complex BPF programs by veristat, it would be useful
to preset global variables. This patch set implements this functionality
and introduces tests for veristat.

Mykyta Yatsenko (2):
  selftests/bpf: implement setting global variables in veristat
  selftests/bpf: introduce veristat test

 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/test_veristat.c  | 120 +++++++
 .../selftests/bpf/progs/set_global_vars.c     |  47 +++
 tools/testing/selftests/bpf/veristat.c        | 319 +++++++++++++++++-
 4 files changed, 475 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_veristat.c
 create mode 100644 tools/testing/selftests/bpf/progs/set_global_vars.c

-- 
2.48.1


