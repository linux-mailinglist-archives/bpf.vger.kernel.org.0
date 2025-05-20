Return-Path: <bpf+bounces-58523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3EABCEFA
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CB216A017
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7125C83E;
	Tue, 20 May 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anGFJpU4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515C25C81C
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747721190; cv=none; b=Rw1zwmDhIsnLHF85y2T6Xsmd94mSDuguCJlaLY+HbEAplJ7ieeJeznxl2aV8FrJAchzEBzDgA0DFatntHuxqMWHjiFJ5sFS+Ni00SyJNpGt1xh4nBuAk5LLYx9qoimZbgQdcciqMmcqMfTN1MG0xJxedjTggQGPN0h1P3TWXlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747721190; c=relaxed/simple;
	bh=X1COTfDqbRYx+FNGj0Yoi0TOYgSJUKzDHmjhYRCpmts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+SM2dw+wmlm3sHr9cagndwRAdLNe/CPuhGFXkkHKkji8jeQegyJIhH709rplk75HDj49XwnxQxHkB9CnAE9aRJWwDJkb5Z92iUzsjup5qwjRC1P61+0mQSRNQuajvXaz5Z/1XyfkBqrDw69CraPSOD2Ft00AGvKqHh1b8eVnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anGFJpU4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c3d06de3so2703203b3a.0
        for <bpf@vger.kernel.org>; Mon, 19 May 2025 23:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747721188; x=1748325988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLlyy/UZRnAtNH2XrxsgKTjHykE43LTaLXGEoC9fS1U=;
        b=anGFJpU4MOshxAbviHmCk12eZjCbcbhf1Qnm/h8/c1Ju9vFoA4skphed3t1mG4E9Xu
         szN9s4nqxiIBb1f0L7QI2k0sqrZX5XZ3nToDlRzp3HMna+w8IGv9oPI6PzAnaXUWDGnE
         fhLHQ7AGEf7O0y36AKd5rST38v3UNIFcMA30F1wt5alLBzjSAzE+ZEVAX0NOhEvI96oL
         f5uy4KpLkv1fkbS9S4V3qjAN3aDXP6Mx4B7Va9azATSYtCSzrG8pPe7Z8A+Ue4cvDMSo
         UitmIPS54ffaCHYpqTBVv2i7dRMlMI4dq4Ikde0tdDwmR7jxXvEIXrwrtku8ZKYzUlbH
         LHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747721188; x=1748325988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLlyy/UZRnAtNH2XrxsgKTjHykE43LTaLXGEoC9fS1U=;
        b=lpOwdqwJVUFCS2habkfUqeC4iAjCCNzrkIYypLD3rtClrN4Fcit0uUJqHcYlS5UTjK
         it/isi1ThXdUmZws7v0DmcJ89D+XLizAk9x9wIXo5ASdqRFbX0VP51udsURaYJ0QvUHJ
         Yz44js2fEWxB8eK7/vihc7Ctma4OxG5DjMSuWBlFNFkW5/QI/19Eo6gXyMan0Mt9Epyv
         PBVTI5T35+tico3f+gOrNe6ECy1T0FLovppb6nHGYTUMhXw/NoOiaTZ+pOuVZyKRr97q
         dF1ZK641miKB9pKy5jY7bE1zJVE2gOjsvTxZbPPld5647l0K/k1gKNxJsiqoqSL3K/WI
         dTCA==
X-Gm-Message-State: AOJu0YznXsjjzvRCRU0nRGO8cY/LkM4DaJBdsi/dn0VtM6KZTiyNpMjK
	4+QVJxezV5LFl8Sk0Oex6oogjvviYmaoJuthK7o47Rmbj35K6jDKMfV2
X-Gm-Gg: ASbGncuDZiZA/xxarMU5JcFpwC58xXP5wOMMS/m/6DiF03qCojmij1zlf8Ge58q9I3N
	Sq3YoDsByZBlpjyab2Va2R0j4zRy9p44X0ST82tuWTBZDzx/xQCYmaPC7jA8ITB4AHRW6NetFzs
	sLjAIx8WTuX+RDwZXJ7XJ6PkK+7g9Owl73HEMkQqCqZ6IURawBOb+u3JTFhN5YiMzc3vqZXbIjH
	guZC4/p4T1a2J2nwpWjN1gNxu6v5y4hDYMmgn3jQ90+MJQd+g2tYhPdAFfdQ5baaAQPd9x9PRg0
	TYSAPnO7dQPsNBSXDSKCR2pSdFSceKQa8lltzCasH/WVj+zy7qG4dCT3pKmWj9uMipnWdZywn4x
	XKAMQc8dMjQ==
X-Google-Smtp-Source: AGHT+IEI1MdA5SoNJuyGCfg4JYCT7gUFmev8sbp55Ffyrn3O8qIJnSgQIK1Ngte46gY0h9orkCa8YA==
X-Received: by 2002:a05:6a21:9208:b0:209:251d:47d2 with SMTP id adf61e73a8af0-2170cb2609dmr19049821637.11.1747721187990;
        Mon, 19 May 2025 23:06:27 -0700 (PDT)
Received: from localhost.localdomain ([39.144.103.61])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36385e91sm823428a91.12.2025.05.19.23.06.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 May 2025 23:06:27 -0700 (PDT)
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
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v2 4/5] bpf: Add get_current_comm to bpf_base_func_proto
Date: Tue, 20 May 2025 14:05:02 +0800
Message-Id: <20250520060504.20251-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250520060504.20251-1-laoar.shao@gmail.com>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing the BPF based THP adjustment feature, I noticed
bpf_get_current_comm() isn't available in bpf_base_func_proto. As this is a
commonly used helper, we should add it to bpf_base_func_proto.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cgroup.c  | 2 --
 kernel/bpf/helpers.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..22cd4f54d023 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2609,8 +2609,6 @@ cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..2a60522cd66f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1965,6 +1965,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_ns_current_pid_tgid:
 		return &bpf_get_ns_current_pid_tgid_proto;
+	case BPF_FUNC_get_current_comm:
+		return &bpf_get_current_comm_proto;
 	default:
 		break;
 	}
-- 
2.43.5


