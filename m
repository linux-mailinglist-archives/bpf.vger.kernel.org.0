Return-Path: <bpf+bounces-19705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB682FEF1
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 03:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC4228A032
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5E4439;
	Wed, 17 Jan 2024 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDMTEigB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D101FA2
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 02:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459805; cv=none; b=chrAOuCEHsrAurJgKf2WCG71Nl7aJsO1xKDVrqALz1fOTxrwvIb5E2h1SrtoUR0nVnArUyoMQhiyKYjaS+TXUm1+Oa+yNa7foQtSe4CtUsZ9S1y8SD5x2eS7YWYDfOHRZR7ew5pEn97u/zOsyzzv+fRhil/sIciJ1n5ntyD3Zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459805; c=relaxed/simple;
	bh=tmSpYGrx1HGH8qBqI39OcRqschAxNsOALVf9IBkBNM4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=u1LrXuQZXOvC/bx/NYoXxycwDKXV3e0He9zGL8/yeLntfSE1CbinQen6YuXxnUMPmhZCq+00ZCgPH0UVycWp1QRpStk763FxuLMyHhvb9ejqZD1Y7r2gbFEE2iLQdfO1CY63X/rakalRzswBsQz3q2rR7SCJsMSUJM/6P0Vti58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDMTEigB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d6efee006bso1117665ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705459804; x=1706064604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8izWMNHceiwBv7TwdVsTvQeVd0EJCzrIGP1vBeou8E=;
        b=IDMTEigBxGNT477r/sreZznG873KZ+iR05cpg+uw8Bu/WedlGUGJiuoXnaEaVsHR2j
         m1eVdM8n3ZjKzEidgHopaYkPmSCpD8/GSuOSboGoCt3ylPaOPDBXwdj/jjM46X6zT3gd
         lsvmVGCb7hAfN+4Ze5u+T+8aZOuIe7MCq8FlGYaHBpIYuGuh6AK9ZAfQoTcmoHkbIQ6j
         wbmKK2PshvZsKyv6dTp8vOgmkj4J+W7FPEJ/kYA/dzbLctI6yboAuY9CayJIH3EaLy0Q
         X6NPbjpQGt/aSP9c5rabr1fmS8mmdQZvattmDTRA8PAV/T4Pb83UXg7HAiRjldtVPEXW
         QYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705459804; x=1706064604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8izWMNHceiwBv7TwdVsTvQeVd0EJCzrIGP1vBeou8E=;
        b=glpNqE8DSfHfU/MWBq/I+3GzU2TjlBqTg/Jwz5RCW7gc+8SC5O1NMJV9kAkRm5VxY1
         iVbYFDdD+fQbhuLYriycJCiHxRDvRkXzVCOgmb3lkF3l7UAWA3ZYal8OnMxPrPYu15j4
         HG56HkyYhXPwhH43on9c/KR4m/hFBWXFfKbi3eszvwW9SBOld5KRqr3I9aF79O51rTe3
         cA+BBWCbBWLzzET3YtRd/UoCJa8UtjvYWZm4ISjRGP7gqFhdvjXdim7DQ4aUa7vv1aVt
         JOq6LHvCM2qOMa06GJUOdWzvPSwqTnK8WiCcLSP3s5WbNmAgPAy80Z3MXgOsg9d+8kzX
         Rsvw==
X-Gm-Message-State: AOJu0YzMOOswryHjBFUtT5eMJIn52li0NBHsE3TWCSDcxi5NcJerPfp6
	/X8XVSZqLUSVUkoxVvawlLKIoFK0iqEM6In8vZTGObMJR0stHFSI
X-Google-Smtp-Source: AGHT+IGFacZ7Z0qUn5UL7QfG2kL8QPWnZI28i/iRkbrqcEFygs6HVGSBQrMHwmIe1okrGdpMYD90rg==
X-Received: by 2002:a17:902:c949:b0:1d5:6600:3d96 with SMTP id i9-20020a170902c94900b001d566003d96mr292369pla.0.1705459803858;
        Tue, 16 Jan 2024 18:50:03 -0800 (PST)
Received: from vultr.guest ([2001:19f0:ac02:50f:5400:4ff:feba:a83e])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001d0cfd7f6b9sm9996883pla.54.2024.01.16.18.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:50:03 -0800 (PST)
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
	lkp@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 2/3] bpf, doc: Add document for cpumask iter
Date: Wed, 17 Jan 2024 02:48:22 +0000
Message-Id: <20240117024823.4186-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240117024823.4186-1-laoar.shao@gmail.com>
References: <20240117024823.4186-1-laoar.shao@gmail.com>
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


