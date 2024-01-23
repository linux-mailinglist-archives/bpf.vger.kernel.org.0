Return-Path: <bpf+bounces-20095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4408392AC
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9541F2107E
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD785FEEE;
	Tue, 23 Jan 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5NJWWPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAB5EE98
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023678; cv=none; b=qhhfkeFyAyWGeSCMpw2skv1VlGSUNBmh7MtGTtE3LREhs/W61yf5ybV9QabdLmrC6H9l5ifvdR0vMnhsMeBa6rSODmnxUWRA6ztzfn3DDSBgJs3n/SRIshJGdEeDTLDulhCSZW8Ez77bPWloc0Z100xQVEU7NfAdITbaXnR847U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023678; c=relaxed/simple;
	bh=tmSpYGrx1HGH8qBqI39OcRqschAxNsOALVf9IBkBNM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrZCnDbR4mXzM9Ynr8V2w/nYuDys8OJPwr/g+B/6N38jc3D60TT9SMdAC0+ALvoNDK1iUH3JOk3cXWXQg48sS+QjZoHU/ssFz6RzVMjzkMM52CVGRBBFzzqaEGH10MkzWuADU9WEt7B/DL+sKNHcOmD/hYs24AaS8c8aTh0ZnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5NJWWPM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6dbc6c48594so2554901b3a.2
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706023677; x=1706628477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8izWMNHceiwBv7TwdVsTvQeVd0EJCzrIGP1vBeou8E=;
        b=O5NJWWPMx8A0vAbRmMCxJ6jVqyuYbis+DY8fpwozJQo5o8SwjKAIQgUIXdZ5Ka0/l0
         eDwwyb7ccf4TeclGsvYWEf5nmsuTyPkZEL4wYmAtmxnw3pHBB+2A2V0wa9bRmWIrug3p
         AkcDktWQibvHmX/qX1OJvgZ2beXwE4n0f2HZFjJk0TT1KYfeyI4o7p7AmiufKh0/gKT1
         d1irRwcMNMaIhbpv6FEsyep3ukg1BUJY8ApkilQfqeMzUqPf82SEYcSVy0IGvGFIZPfJ
         parWz9w+N0OQjTWhDjJrb2D6w8zQi/S1lJ6kPpsOsb3pR2fOqOxzD8iiERvxAbbIGCPU
         ofBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706023677; x=1706628477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8izWMNHceiwBv7TwdVsTvQeVd0EJCzrIGP1vBeou8E=;
        b=W//2EH1JYXlYltxondL3n4OHOyA+oiEmCnL1+sI7t3DH3RUfGVf44I5AtoGXmgP7d6
         zd0ncc4cVBQ36bCI0w5ty9LTN6sBRegUCxXc80FodDhEjtl7+3oplYm+uRVXjPn09A8B
         xsdSvDD4Vx/UC2gVon1SKdQMNgh+yzMDLV4K1PBpsJbZ1iivXfSkJ8p2oXxzU/yKzqs4
         6iU5i0oc/tuqGPI7LkYuaknj1ngd3znWTbeDOjEuMIbT4cKuVHnDck7PPpRG7MRqmx0t
         qBhZFalbVmLykDK4aTAzSPkAnAFyeqtRYcQ3725lvBB+RMzpUtPhgBOS0oQOx1YLphKp
         xgmQ==
X-Gm-Message-State: AOJu0YyiDvsVCD4z+ujaIuEytHpjjXUp8y/hryWJZMg9Fgov/KKvrg0o
	YC1KE8d+0LwZeue7ybVSSNJG0AASTxIYDnKfh4Zi84gjKL2sMchz
X-Google-Smtp-Source: AGHT+IE3LCzzaGhuPfEjnNSHgcjFKtQi3t8BmMSuG/xqbZPRJGVjz0p+nN3R3lMmQ18MFwwTlenBhg==
X-Received: by 2002:a05:6a21:3394:b0:199:f335:449c with SMTP id yy20-20020a056a21339400b00199f335449cmr3235881pzb.45.1706023676886;
        Tue, 23 Jan 2024 07:27:56 -0800 (PST)
Received: from localhost.localdomain ([183.193.176.90])
        by smtp.gmail.com with ESMTPSA id s125-20020a625e83000000b006dae5e8a79asm12264233pfb.33.2024.01.23.07.27.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 07:27:56 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 2/3] bpf, doc: Add document for cpumask iter
Date: Tue, 23 Jan 2024 23:27:15 +0800
Message-Id: <20240123152716.5975-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240123152716.5975-1-laoar.shao@gmail.com>
References: <20240123152716.5975-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the document for the newly added cpumask iterator
kfuncs.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 Documentation/bpf/cpumasks.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index b5d47a04da5d..523f377afc6e 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -372,6 +372,23 @@ used.
 .. _tools/testing/selftests/bpf/progs/cpumask_success.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/cpumask_success.c
 
+3.3 cpumask iterator
+--------------------
+
+The cpumask iterator enables the iteration of percpu data, such as runqueues,
+system_group_pcpu, and more.
+
+.. kernel-doc:: kernel/bpf/cpumask.c
+   :identifiers: bpf_iter_cpumask_new bpf_iter_cpumask_next
+                 bpf_iter_cpumask_destroy
+
+----
+
+Some example usages of the cpumask iterator can be found in
+`tools/testing/selftests/bpf/progs/test_cpumask_iter.c`_.
+
+.. _tools/testing/selftests/bpf/progs/test_cpumask_iter.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/test_cpumask_iter.c
 
 4. Adding BPF cpumask kfuncs
 ============================
-- 
2.39.1


