Return-Path: <bpf+bounces-46499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB919EB00B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 12:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FBA162B17
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F432080D2;
	Tue, 10 Dec 2024 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MHQ9SKnH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598823DEA1
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830858; cv=none; b=b/HxNiqX/yaqsPbXJv+xln8BZfWpnDZD8YGc4Fq18+AqSDko7MUeYDotkNJm//TGRBhN2z7s9iY1lFbTCTjGHkKstyMIPX7xFw/pGbmXKXMc0YoxTW2aMOI1ZbU1yCiCoJwrpcGebohCdCPyDswgFm65CpDH7X3nCm+s0jkMva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830858; c=relaxed/simple;
	bh=Ss6LSDSI3HUgkt46RXSiQ36I5KWmMAj1lyp/E3yUBkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEpqzh9Bjy1vJCUmcxWacTqTeZeosrApeYwveWxXw997tCSsMlFsaXmLRVN0noDStmNDgb8ScHwQ7hRKgoiznBboIEEv9cehSsgyUx8cznf2O+MjGvTQ8L6H95JXHRmhQGzs5VQgfzIhtKY+cXPkZKM0A0WH91mnWwl4U2vVLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MHQ9SKnH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3400315f8f.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 03:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733830854; x=1734435654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RN/WyHIUArALpl7qsdgPWxpsRM2L0MSejGpbRBuKuw4=;
        b=MHQ9SKnH6M7E2IuErZnBOqIP3QZ7Hj078D7lv/x8Gu+8YnPP4pFmUj9Bs6Cj8NrCpr
         eqTVc5zomMnpsoL/1efhwDJHKQ093okiBy14+0AnF/MJtIfSce7NpKIbUr/igCk2fOh7
         udRpq8x2J8ZtT09QIVqfhKn+rgU17L0n3g6dVHTnE0IlZJAQX0WCBA89H0a0N1KP0Ewj
         ocjxB9RV6iC5JgWRr8yFDzRMy0XhEFcEzCBSyspUOgs8s7DvEbYh+FoAX/Jbajyz0VJ+
         LH87lnhniNHK4+CAV8RGDI02K9bubVoYlWdEWk6spIIO/RsaHmW0G63ZuCpBI2H6ExtW
         PTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830854; x=1734435654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RN/WyHIUArALpl7qsdgPWxpsRM2L0MSejGpbRBuKuw4=;
        b=OCVx5hK9KH4I6yFZb2sTdsxAa9LHgwbVCu82PKb2/5ZiBxkDw1/IIIUWXDr48nRA+f
         Xh6IHpw9VwlfyIA/bNP5aWSNJ/lB8Sqd9wKjfJ3IbT5IHa9wuyHhd2ZgLPwO3ov4fMDy
         pP7k32szSuSrUJYlqxNRfbz9tRhLHGwg6jkdwDStFbbD2gtOd1ICqBu8THpw20d3c/Mi
         4cHtzq870TVuPMO7/mELNJrhPrIdfLYtq8S1//WLUvcnSDpRAAeBPzvYRjG1jXQEcj9Y
         TTYqDC+m99Ks8EWR3IUXaN6pE2HQjunCKyE/rYmettqJO+2fa7nudjAqLp0S/vviBwfm
         VwuQ==
X-Gm-Message-State: AOJu0YzxZSeQTzJuJTIcNwBfpNpBUqr27p253r6E3VsxuDqYqg865suP
	yBb0AfCJOPfeXI8CFtidfXx2slGBPmZQPMI6qZd6eC4Q9lpjFNlj/vVl0AkJcdKBPnBbRs7oznc
	l
X-Gm-Gg: ASbGncs3MvJowzKj5N2QT//fPgM8xyPx/ZazFYIO7bx+CUkQPTsVopVws8xGCnCMKHi
	w/1ZtYHXQDo/1VyAREAJOzRBiCyk0M8Qg9JLxzzpdp58a8c3eY71BnfEb4dFHhhOpKCYPfjwwj/
	0MMN4HNajzOWZO2mzyoQ/vvfvvUEoxE4ta1RCUIgJ2sfmFJDdFrzcSd/3Rv9U9THANNFTNEOF5P
	+9LvqYvbu1JlnCcMFV9r66zm6fW+7BSakDUYYP2Xmo5FoZkvjIYBvrMLwOSvRSgOGc=
X-Google-Smtp-Source: AGHT+IHlRTU0cepLr/wD0CPh2AZv3wFK5CyvHu5qVzEAiOidzdW1dawDaoPaowP0zmFHz/bmP/pFVQ==
X-Received: by 2002:a5d:5f48:0:b0:386:459f:67e0 with SMTP id ffacd0b85a97d-386459f687dmr2558816f8f.21.1733830854332;
        Tue, 10 Dec 2024 03:40:54 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da119a96sm190903535e9.40.2024.12.10.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 03:40:53 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf] bpf: fix potential error return
Date: Tue, 10 Dec 2024 11:42:45 +0000
Message-Id: <20241210114245.836164-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_remove_insns() function returns WARN_ON_ONCE(error), where
error is a result of bpf_adj_branches(), and thus should be always 0
However, if for any reason it is not 0, then it will be converted to
boolean by WARN_ON_ONCE and returned to user space as 1, not an actual
error value. Fix this by returning the original err after the WARN check.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a2327c4fdc8b..8b9711e6da6c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -539,6 +539,8 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 
 int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 {
+	int err;
+
 	/* Branch offsets can't overflow when program is shrinking, no need
 	 * to call bpf_adj_branches(..., true) here
 	 */
@@ -546,7 +548,9 @@ int bpf_remove_insns(struct bpf_prog *prog, u32 off, u32 cnt)
 		sizeof(struct bpf_insn) * (prog->len - off - cnt));
 	prog->len -= cnt;
 
-	return WARN_ON_ONCE(bpf_adj_branches(prog, off, off + cnt, off, false));
+	err = bpf_adj_branches(prog, off, off + cnt, off, false);
+	WARN_ON_ONCE(err);
+	return err;
 }
 
 static void bpf_prog_kallsyms_del_subprogs(struct bpf_prog *fp)
-- 
2.34.1


