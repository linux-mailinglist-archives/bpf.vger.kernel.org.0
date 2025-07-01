Return-Path: <bpf+bounces-61926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27C7AEEBD7
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 03:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EDF3B7FB0
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 01:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B21CAB3;
	Tue,  1 Jul 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4j7p5G5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19A19D8BC;
	Tue,  1 Jul 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332350; cv=none; b=QqKhXQOe6k/x/Kt95Q+BVMArhoZw6ak6Rvu9p2nrBvBDlgayUM7zviy3Attm29nWwDxNSX3SrfcVVODzvEzSUePeJc1OhXrEjtn2uBimTbwTisnjKrpjMXFu/uUw3fYFojAl+qMVpJ87tZZETwx5A4DE0xqsNXF0aeoSBvyUsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332350; c=relaxed/simple;
	bh=dHRNNSENZILB/RsESwGc4hB80PCAslDtv9owC5VxRRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/C4TKPrsdVv93lXu2uGUGsQAE66afrnh4lv+lL6k0GMZ47r0IULkR2avyHmmHc6vHwFGYZXbBeZJxZYzY50ijA1OCXNBlTSfKaSQbD8HxhE2yuMHABxdUa90vRZxAIkA9QDTIP8jMJHDesMUkB2oSpN1VzbFwgccItBcUmkf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4j7p5G5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-236377f00a1so50298735ad.3;
        Mon, 30 Jun 2025 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332348; x=1751937148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB192qEi92T78puw7fWM6TcIgYAnqo1aJRWlEYSOERE=;
        b=l4j7p5G5F6P4UObZ5gUb+d1+S7G/2D5xBptS5Vm1Cq899sL9XpFnLCFqpuochhmJ2m
         6ccdCRtqUoL2yBenbiDvY64Zlb3HowIPl6bTPplgWJydOkpCEfD9Xzm4uRkQvhm+5fOy
         PzsC2o1aCJgqhrjAyt1lOKKo66zeOBxrYbxP1kmRtS8+uvocyzqLDfT8irEv1WH5Y3X4
         aRCF+pumvvnr/aO4Wt2tjBx4e2eSwci/U+mOJEZPWQGWXmtSz5waoJxpzIfZITeQ8JTk
         HldZ+qAezzC6Z37GAsWvJqzQEbs6vHZsgwhtptOf1D4U/v2+/vR4sD9w5jeQU4yVxiTC
         6eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332348; x=1751937148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB192qEi92T78puw7fWM6TcIgYAnqo1aJRWlEYSOERE=;
        b=xC9iU4gh2pgQpZreqLeld4u91XVxQoyeWITML14aaqjztws2gdrBgchR3g4vestXhs
         T3Q5Nt3sm52kgKGanNCZ0hFi1NBYABhkde7GwBX6fyGfrw2TJWwNFlUDGV9fseh2kV/G
         ymowIvKyR6QLqa5abB2SSdX1zcvPKNetmDLWgmhTNQzz66XJv2eQAk7/kxoAEbyNirO7
         1A7mgyS7woe65xkG4J1Q8zkP3rvw5QWZ0RmHNrDbEQpU3w4xvKiTaLHnRDxNNSI/IXDD
         KBd0amg3Jdzw0wU7+YaZpIK5xQx5t0q+VCQwQjRioJjVCl9zlCDQnQJqMJZNa7OooWuG
         I6vA==
X-Gm-Message-State: AOJu0Yxlg4lGAyWhE9h6UKtHFDfvBZemAzOcm85hdlX65zwwfg+VSaUM
	wKeiweBt+zedDHKHF6WnNFn6oMWvSdS7B1o3Kc2S5Mzl/+1VnrU3Z612FdBrMQ==
X-Gm-Gg: ASbGncvOb7KXXrvjJODi5EwT43DUYQSs+ptfcr7h7COcaeWRG+WSTKFwPzt8seH+//A
	QaHqTLtrru7y9ABIJ3pOI5OUS5G07dPm7IdHbVUOxWGxKnLpDC7gBdxxk9G6xhAKy29OgyqfndI
	qEjAbQCyuQriUpVUCEYn+RarCUirOWEJhXFX5enUd6sjpRmzQRNtSeBR/2lHGSbulb3qNlHQNM9
	M5uQsCUchCdTyK4V4I2D764/fOsiqbOaU1gwIdGuwxzXvJhRlDHP8XRZXMAt2IKVJ4S1cwvXf8U
	QR+XkXFeSa5OYGqlmne/7vvZQMYGnZ8/C9uvr0np0EHdxgt6aV1sjdGMM7rXupaOOr4HE6/+
X-Google-Smtp-Source: AGHT+IEzldSoHpbFJ8LyTzhwZvLfFVTdY8X99oMH42Te6kruGNMvLONB9qbuJk+r6d2HB1pbm18lmw==
X-Received: by 2002:a17:902:fc44:b0:234:9374:cfae with SMTP id d9443c01a7336-23ac40f4d78mr236022925ad.19.1751332348107;
        Mon, 30 Jun 2025 18:12:28 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bfbesm100007455ad.109.2025.06.30.18.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:12:27 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v4 3/4] skmsg: save some space in struct sk_psock
Date: Mon, 30 Jun 2025 18:12:00 -0700
Message-Id: <20250701011201.235392-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patch aims to save some space in struct sk_psock and prepares for
the next patch which will add more fields.

psock->eval can only have 4 possible values, make it 8-bit is
sufficient.

psock->redir_ingress is just a boolean, using 1 bit is enough.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index bf28ce9b5fdb..7620f170c4b1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
+	u8				eval;
+	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-- 
2.34.1


