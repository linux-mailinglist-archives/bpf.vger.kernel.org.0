Return-Path: <bpf+bounces-20938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F848455AC
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C911F23AA4
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD315A48D;
	Thu,  1 Feb 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5jnN+Wu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120A2747F
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784232; cv=none; b=Du32LfyjhUQxt6vPp1wUj5kvTcFuIjJne52GaIk1eMxPty2xvBzXsCjg6oxFlOwTxZyvGasyZ9DUdWNdTZvhgmRpqcnNA55NX4So4S4oAiwtVfU2/4gd6KPVOueSR6BNsbJeFzHPu6t532W6ZPvbb5t2eYnLdiGBSh1Sqc1S+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784232; c=relaxed/simple;
	bh=CMgx5aALmjK+ghZqd7BOCYu1oEjQ3rDE7hB4LdtFjTA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hTRfjHhK2+V8vrA5K6GEfkcbeYhqieNbLd0mhC97PjUdPhcmzoPgvoVYOvlHLHIU3/MymINVNFXGg/XAGI2h2A0YfeqU5nBZUXE5yDWjHENMSah0OPcYGcgfyjEKqCN4iCTIKgdILaDqSgZQocuctrOEiaor4ZhkaSn0J78gM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5jnN+Wu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a35e65df2d8so91733466b.0
        for <bpf@vger.kernel.org>; Thu, 01 Feb 2024 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706784229; x=1707389029; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0aRI7hj+p1GCbvTFCayTjKPrWnsjNYSBu+GnIAzp3w=;
        b=e5jnN+WuFCAouEx5tTkKizX4WIf3odiFCuLyTichlAKwrIUWt0Y7yz3uAh/7ZbsY4m
         dMRbC0hs0HrmSeZAZT986B22HWAL0kXGw4kX+XULVwAn6FK335BqgnA4zcutqN0BG6Ng
         VaKQiuVoxkm1h6y1Orjjpp5AItQgqNBCumOGaTM5eGhyPCX2tWT9j2Cy35BfCt+BojgR
         SRRD56iDDaB9bdCTaSaf2k9KZXTFofDlk+Jd5Di1jDrRMXDKJOk35tL2PB5Z/tHkrHs7
         pGSgxJ1BXTX6h2mTNYe4xSGbpkZHTIsBh5eEMD0JUFSxPL96QZvag852QfxcQjmCFMHC
         YzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784229; x=1707389029;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0aRI7hj+p1GCbvTFCayTjKPrWnsjNYSBu+GnIAzp3w=;
        b=XqJyYdTnZCQ+y8fqBvPmTla9jY5BwoxUTEr6vqyQkO8qx3pn+xJyGfwWpVhqcieSmB
         hjbSDqA7QMcwnpIEGc/PHGbWxNiZ4VI8vJIt9zkOjLJ6vqdvUTBt6MJ2ETKgvhs7OsEN
         FKkJM2T+n8s4AL8r35vs7kNcC5hwaaLijFlg4UQQTPVGHL22uXbZ95u25N/Hp+pcoYvT
         Et9Nz6TSO1QSGyeoKIyxw00qcZtBgEg5Xc8CghpoILZeH4mDU8zNOVfKb5vq7KklaIjO
         5P1SzG+HkBM7dKK3ETvwXBzxsMXfPAnngzec8K7bDl49dHy8L8V9j3L/OzaP1YOKsZPG
         7LUQ==
X-Gm-Message-State: AOJu0YxbjA4v7PtCUdi7W9GQEiCc3peyTY+hO+7oLONFUBLYj4I4PGP2
	ZDqq7LpVuExxfTVv1vGoSevjcxeeXEOdXR1UQcAB2ToXGsMH9pPVSmSAAuZq6w==
X-Google-Smtp-Source: AGHT+IFpVxb9c+wYwIBR8Jzn9yHhuAP+gh32+bDUY0ldzqioaLkzCYp5vQtWjX5VPf4+/Kxun+FOMA==
X-Received: by 2002:a17:906:e0cd:b0:a35:6b83:2a0a with SMTP id gl13-20020a170906e0cd00b00a356b832a0amr2615820ejb.36.1706784228999;
        Thu, 01 Feb 2024 02:43:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV82/i07p1Jmh8JTqC15O7Dui4z9uvEWlYvjPyzTLUQLWMxvoRrbgBjyNORhQdn6VRqCKp7LBrDTvdIDQxZpeQRCeDF8QMP3jJMiBfbWkZ29T9BJgA9C9Yq0Bm+3VpUiZphbxTeMlTEfkuw/aJrWR8Dmxrmrm0OzlNx9LvcFlDQrxNJ+czoX1JI/QAMhS6N3L6wKGt3PJS4qSyEehEOzCrlLGsK8cSEwmpFUEZYusL9iQYTo/kVtgiVNl7M75Ref122RFz7+S0Xj9BdP2/wqxmo
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906064d00b00a316d360ac3sm7053771ejb.8.2024.02.01.02.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:43:48 -0800 (PST)
Date: Thu, 1 Feb 2024 10:43:40 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: revest@chromium.org, jackmanb@chromium.org, yonghong.song@linux.dev,
	gnoack@google.com, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next] bpf: minor clean-up to sleepable_lsm_hooks BTF set
Message-ID: <Zbt1smz43GDMbVU3@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There's already one main CONFIG_SECURITY_NETWORK ifdef block within
the sleepable_lsm_hooks BTF set. Consolidate this duplicated ifdef
block as there's no need for it and all things guarded by it should
remain in one place in this specific context.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/bpf_lsm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 63b4dc495125..68240c3c6e7d 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -282,10 +282,6 @@ BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
 
-#ifdef CONFIG_SECURITY_NETWORK
-BTF_ID(func, bpf_lsm_inet_conn_established)
-#endif /* CONFIG_SECURITY_NETWORK */
-
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
@@ -336,6 +332,8 @@ BTF_ID(func, bpf_lsm_sb_umount)
 BTF_ID(func, bpf_lsm_settime)
 
 #ifdef CONFIG_SECURITY_NETWORK
+BTF_ID(func, bpf_lsm_inet_conn_established)
+
 BTF_ID(func, bpf_lsm_socket_accept)
 BTF_ID(func, bpf_lsm_socket_bind)
 BTF_ID(func, bpf_lsm_socket_connect)
-- 
2.43.0.429.g432eaa2c6b-goog

/M

