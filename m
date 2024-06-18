Return-Path: <bpf+bounces-32428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8656590DC6D
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E552869D5
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DEB1662F1;
	Tue, 18 Jun 2024 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bb5GdZVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B57158DB9
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738986; cv=none; b=kbcNuE810C/a9pJCsJfBJac9s4mo9eu/0sm/O1gWPoeAg9uGlNFgCkFl4/7aGHdvLPHudyGg/LourJMTv9dAsoVsVtF8f6/+yW+ZrM6LNoEP+lztBgAaJ1KiJQ9JTWrjVh6fR0wKgTiaR70C6Cod9k4dY7OZfZSLXH+6bIJpqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738986; c=relaxed/simple;
	bh=gwPtthh6i+NZ2jx3VSDUre1kVZhqeNMD0tEoUGRPQ4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZaMyc5ranKq7pD6zMfy6n5fFBlHMdnoXJcQpI2sXs4AyhWiTqQYsbksIJMNGRxnEXXuorSuMueTdErQ2EPunX/MiyF8Mh8hHrCq9FAcBcRG5TLs6bWYdEkuyPjfQADBqcZbNYocJuNOPSXpQ+aFLoAARrx0uLHdjEzCXhsg6K5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bb5GdZVN; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a6f0f7d6eaaso15272966b.1
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718738983; x=1719343783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMT0Vj3Og3/+TzoScymy5ubyKR8ozimRkOFGuiYFp7w=;
        b=bb5GdZVNdnej2vvbVz/nVz4c0fGqIjRHYpObigmhDv/+f33FvsVyWHjzXyVEswgo+P
         gngRBmAs5gAb5CxIKG5h9wHvkAguvv8Gl9U786DdGZbYL07pbmMY8HnzX6obDeaKpREm
         T9SNOyVKqPOtNCkCI3P3qZiGna+mcF5DX/bN3g7C9d3arr6HufVrF6/a/1UeWGib9c7a
         Fasx53jLss/abIkD9R7XG9KN5ZvF1cCwU46LBGOWfmJKmgmJEuZ4jr3eKHQTJx3Ms+D2
         OWFRLWY03bnkXIffIBFqwX9hNA76PITBYCk4u88rnLNGTtidZRMN93yjz5XtTVkSJ9kC
         GfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718738983; x=1719343783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMT0Vj3Og3/+TzoScymy5ubyKR8ozimRkOFGuiYFp7w=;
        b=Yu7UN65gc9BCua2UmQRBJmXLACLi/yRPSm/N23o99kRSD/6ggikSl9RNiJbGaIpV2Y
         MRGNX1oInQYkoLMi5g20+MM0grLyI5Zkzm0oLGErK9c6DhBcfW0R1k8oeYvXI/FDZRfH
         QrMAE8j/Wi8YLMQWj2+UGsaeQTLn73yq4tFHcCLO2L4Fp10eN/PUK3q2f0ID9xHO69k9
         mk/ltA32vbKfAhtsRohJLQyNl1nb+KDZV06YHe+G55ff4QFvABFmsvl5WEzCucBog0EL
         qbQtU2Oi68bLQaQydhQKf2AQyWOoaMmwfKSOaFLeJkBezuNHOK+M6wBo+IeltRzrz5GT
         zJFA==
X-Gm-Message-State: AOJu0YyChgcUoFb396vNBonGWc2YFAfG05CHYl+Qhd6HatcBzCmML8t1
	6GIxO2yAnU5MCkVg9gaxXCclc+HrucvKxKfHcijZIGoP13jO1RAydnVr5gwI9l+EP5pL2DjjCq5
	AdD5DBLQEoTlLnIFd4i2ZI5FL5xSRuVxAAscoXEj7IlUXcg3NSDRzaAoRXeAWzCizO0gONwYl7w
	vJBBvs2QjsyJCgxGHNEmmoQHwLyd/dAtWav4AfrsnKDDXbFsdwwNv8gQelQs4BcVLybg==
X-Google-Smtp-Source: AGHT+IHWFkCTOsx6jq6O6V150GKhHFIFGyW7luuPTHJ8JHEeaq9jhRn3MOOizxrvaBAKybko1wDZmYVFNtquzQttz3hr
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a17:907:7215:b0:a6f:9f9f:fabb with
 SMTP id a640c23a62f3a-a6fa449538cmr72766b.5.1718738982773; Tue, 18 Jun 2024
 12:29:42 -0700 (PDT)
Date: Tue, 18 Jun 2024 19:29:22 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618192923.379852-1-mattbobrowski@google.com>
Subject: [PATCH] bpf: add security_file_post_open() LSM hook to sleepable_lsm_hooks
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org, kpsingh@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

The new generic LSM hook security_file_post_open() was recently added
to the LSM framework in commit 8f46ff5767b0b ("security: Introduce
file_post_open hook"). Let's proactively add this generic LSM hook to
the sleepable_lsm_hooks BTF ID set, because I can't see there being
any strong reasons not to, and it's only a matter of time before
someone else comes around and asks for it to be there.

security_file_post_open() is inherently sleepable as it's purposely
situated in the kernel that allows LSMs to directly read out the
contents of the backing file if need be. Additionally, it's called
directly after securuty_file_open(), and that LSM hook in itself
already exists in the sleepable_lsm_hooks BTF ID set.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/bpf_lsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 68240c3c6e7d..08a338e1f231 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -280,6 +280,7 @@ BTF_ID(func, bpf_lsm_cred_prepare)
 BTF_ID(func, bpf_lsm_file_ioctl)
 BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
+BTF_ID(func, bpf_lsm_file_post_open)
 BTF_ID(func, bpf_lsm_file_receive)
 
 BTF_ID(func, bpf_lsm_inode_create)
-- 
2.45.2.627.g7a2c4fd464-goog


