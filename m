Return-Path: <bpf+bounces-66514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6DFB35578
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C61B65BDD
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD72FE567;
	Tue, 26 Aug 2025 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="modqTOge"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489C3009FD;
	Tue, 26 Aug 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192858; cv=none; b=l1m3PlmkIItQAdzgE7zbf3JHzg29sl0RG9lJYd4o8LtY20eTZR/OUKpTUkr2D6o5t98uQTlDr3avP8xs/VJ8y2/w8Ze+GPrtuOZvTMzL8oiYyWFNa9u0Rq0V6iI+ZeFbXPug5GJywsdf4POLCgZ06JIExTGX42NUveYmemDoPRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192858; c=relaxed/simple;
	bh=rX8e9NsQYk4BL/Ik+7nAY1xej8+yPJZtHsuQYW2oEdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkt6kmhv4Nue3KD0cECDVzOw9FZDzxIwBZ3JG5YRNheEtQSoFWsXsA3DaXW0TgW7NxlBcWFvQgmP3bTzIMASOLH4emVmU2atXkHTu7sOHSoNbmEd2hQ+Yxx9p5+FiUd5t82pAXQbeAkhl7So1w6mI4ZdIzWLp67zchksYT4/Ino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=modqTOge; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77057266cb8so1666165b3a.0;
        Tue, 26 Aug 2025 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756192856; x=1756797656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFHLpr6FcX/Wx3J31OLqW186GX8K2s1j2kcuC3aNVeM=;
        b=modqTOgeeFym9OUW9c8trEX7/C2Wg3eXgFx4Zyp/Htu9i/fiscxWqTJ5a2X6CQF8VC
         /799dlc9prqaMYLvquwg8BTsIKSGuy5Q3nGWQVZm8HkK5ftZPLODCMH1lu7cFdAT2DKm
         AejTZa2VCqKlqV+rTSylcCz+BPj329l0HuUkMsdYP+HxWQbUM599I6SdGG3YDhio/CIj
         Rn21k4W17+VOsuLabFGCs4muk6CPy2TfXLk1GbSnikrvtsaxi/RdT06Y8cAxuyLtT475
         dSPAZWp3Xj0uxBPXdz1+b18QJj/Hq1J3TY2CUrtfdkIcTcUL+4V8yoiKdUlbM8lSCXb7
         DzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192856; x=1756797656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFHLpr6FcX/Wx3J31OLqW186GX8K2s1j2kcuC3aNVeM=;
        b=PYQNUIKfGD4Hce8k+wJocf0QCC+8OIC4Cr90bQ4swR+EHrYeNrq2XRHkeT8EI27HAw
         +TxA/JG6LcViRDEwMuGlIZU/McdFPaPszUEH5VhEh/vcTTb8r6RiDwqHe+AM09OWNQQk
         5D+YBtwiDVUHNt/r0o1r1F6th+Qu9+yt9JAwPpJdBGaqI8fHkCjbHobfndmX6z43c1ZK
         soghoK386r7qz3Jkjr9qz7S1noe5bP+qdWKTirBTfU4mJdGvYh5KbSuje3ipeOmE70Wz
         RGZZ7T3MBSHi4G517PZ1rveXUhEF3xOr1C+YhZoilJARrsdmC0D0ik9o1oerXRNu54KH
         HHuw==
X-Forwarded-Encrypted: i=1; AJvYcCVlWb10e/IKil5n48+LztaCheTfPJ5NuRv0zluCuGhh8C1TptOl1DYF2AbnWWRUS8jxHYe4mgZSJkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46VMp5uDeTWJaUOrOuy/C7rBKAnYJghhR6XRAgXv90R86UF+o
	PPWtlNPa9fXyL4jwUG03oqOvJ/rTr5yT/HpMMLMBxmWBhxqKxCu1Sqpx
X-Gm-Gg: ASbGncsYdXMCNeIhiTgmmmqeRp2ZIBPWFZ2SAEZyONcvgaaS1XI+GkJu5lGUSg0lig0
	bIvBpwRftbDJLKLkUzQQ7GvG8qxbdp1oa0298wSkkLjUTd1dPcLt6mq/tn7W4SfPew4JzqDShcn
	dSg+NziYtOZY9op0eXwyUwDP6SNZALRpR/001ozqsDDGC66k2Hk8HNq7XCTIb3gwiSX5UcBvnT8
	hU8GcamN91LltdWMxLWKAYaaiQ+m2LVJ1hu3be0cdl8XOFLnkCnlIfUZHrMEpKjlr/X2IlJ69R5
	HPrqKwUidLHWn0K5z+tnWGZBZpe8z3sTHOWLyuCgWzQOtGYhq7KWNk7KLrDkubrc/N+eZn8isyd
	p0Yz3/2E2vALJURjNQnRRlyltFO4upB9DzxH2OgDcbWgYTKtite7K5+yUIuEoXEojes33jZFpQl
	fBfJc=
X-Google-Smtp-Source: AGHT+IEmmZ+P2cW6+dn1oHu17l4+iy2IHTfCaLsUk4rpmP0+qhz3tPhrdJeYge0DcysCptQ8/nMPPw==
X-Received: by 2002:a05:6a20:160f:b0:243:6dd0:9bf with SMTP id adf61e73a8af0-2436dd02547mr9068214637.53.1756192855650;
        Tue, 26 Aug 2025 00:20:55 -0700 (PDT)
Received: from localhost.localdomain ([101.82.213.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm9686052b3a.75.2025.08.26.00.20.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 00:20:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	hannes@cmpxchg.org,
	usamaarif642@gmail.com,
	gutierrez.asier@huawei-partners.com,
	willy@infradead.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ameryhung@gmail.com,
	rientjes@google.com,
	corbet@lwn.net
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
Date: Tue, 26 Aug 2025 15:19:42 +0800
Message-Id: <20250826071948.2618-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every VMA must have an associated mm_struct, and it is safe to access
outside of RCU. Thus, we can mark it as trusted. With this change, BPF
helpers can safely access vma->vm_mm to retrieve the associated task
from the VMA.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..984ffbca5cbe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7154,6 +7154,10 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
 	struct inode *f_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct) {
+	struct mm_struct *vm_mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
@@ -7193,6 +7197,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
 }
-- 
2.47.3


