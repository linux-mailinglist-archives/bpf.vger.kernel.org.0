Return-Path: <bpf+bounces-58504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817C0ABC887
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 22:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1117D7A3DDB
	for <lists+bpf@lfdr.de>; Mon, 19 May 2025 20:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750621ADDB;
	Mon, 19 May 2025 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7qt5Lrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8121A444;
	Mon, 19 May 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687015; cv=none; b=MhXFYlKv5iMrPcjBtMxyHCXrQLIwUzu1wMgD+RO1EAZPGi2Ps2bcIei28/BsP+kCc7fhWHXACrGx7mPoX1TUUbOZGcLA+c9DhhJjzjomFDhbq5108PHX8heknvA+DHCG/NPw2aHqwrajDSic+YeFDuBXBkV8zEYNgTC1UFFTS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687015; c=relaxed/simple;
	bh=NZNkBAwQbsUxrtMZrOEp6ge8DpXMzhulB2bC4tpr02A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFg6EgiptWmap+wQOFO7VOcrLkIkvoHsYoo/kyqgvCVhGwyf5/ZfvDlGaD/fMzINFiXE5pCjYHsRw8L7U7GlS6aoi1kirMOOKa7W7mnoNf2lY6BgO7KKAExNP1me6Dh1ZPdHHQFhbXjQKXzsRDw3mkSgnxTRZkCFw6NctZ43lHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7qt5Lrv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73972a54919so4625919b3a.3;
        Mon, 19 May 2025 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747687013; x=1748291813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mz7s+ZJoM3aBynkNWzUTB18vUlVlu4ivuZhF6UuKwc=;
        b=G7qt5LrvxqWbhgAJO2h6WjgsPzzTbfSEoceuQizvm+zKnvf5GCu7zVGxhwXo2dQEgn
         bh/5pyhHpSOaSJ3xJH454H1Jq+Rub1qrT00XTbjLZAMhEXZtKUGt6Ff4DkaLPSrdnZ/i
         hzCZILgi/PNzNhK3s+TKAF5yOZLMmPVJX9FWHaXyrN2Vd29ggdBi2L7Iw6yuZo1OpRsM
         wVLB+J+BD8fK5FKQtC7qBM9DtIMrWHy0Qd9WOf+ERNOZsYLO+8VWn81rslwu3aroIaQG
         sa45ZNxFCGMUzJYaeFHc7GyIgNP/MRnkJ3FvPI1R2wOIPp4acXO6DlEWWnB2vSLUvCE+
         Z3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687013; x=1748291813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mz7s+ZJoM3aBynkNWzUTB18vUlVlu4ivuZhF6UuKwc=;
        b=LPsXT9Pzml2GACxRgdrNFUHpYijvOYhPOfR19WxzBM+YiFS9YvDztHYAo52BmD00s6
         2w7KzrKuflZD70s9w8wOTbmG6Oqb0epAxvl1IdAP+nRVIaI28nFSlKh8JGDjy+nIU4OT
         dNPNEgHDtWZHeQPYO45xXqWdkJWtdTPV/AxKgR2Ic+i/sxcO6fXy+F6Qh8CC9sbEGxba
         0XMgYSlxN4gQKwgEhS0ISlFNYvPUPSsgRpIk8xbSxoiMCsasftD/UZxNUVNLw403hpnd
         9+rupzUzjDUEDGEZd4rKgs13mH9wROBoyCqF3nGaFi17IBHcjzVHnxUsRs7robIG4lR6
         J3Mg==
X-Gm-Message-State: AOJu0Yza/K6skon1o4JGGKinQxfpCdeltSHjOO6k0Fv2LO3Z48x0BhpX
	YcMQG2y1mw+oQu+3zgJR6FWjeKj9cbYnDQKtHh3I3HfELDwEvuDGsxU1MJpagQ==
X-Gm-Gg: ASbGnctkr5qns5yxWXZMaMC4OXNLbrywHmAry/czM8RNWvBUkX8y+Hm5a3w6FmZDpuU
	MelTLB7AXyhLLFSmA+9+Ifs2UE3G0EojdV0mY1GzwhRWFEXq65VleENdl/xpHmHJGDPqTC2BXNn
	NEyCtt9aVCGF0wxvlZ8HoIWR1oUfGKhjqW1BRH8V+4fWLE7ngJWJ5E+slwO3InY+VEn+BgPdV6a
	SAtoT/3GYKa2mh3hFrkD9n9eapLuSt8ubbavkx2gCLaTk5V1VLTokN7VboOKwOjoTci/5I9mJIh
	amK7Cqc/qUecfYHlQvFvn7zuo3b6KuvXvCGG5FL7doH2JNdiZA+3e9vf0tJ2dw==
X-Google-Smtp-Source: AGHT+IHXESR300CO8mk71uQvmpKIhALLIel3UyQcKlgXG8aumwrcviYrMGB8qkfCU+bjXwYjI/g0jg==
X-Received: by 2002:a05:6a00:2d19:b0:736:41ec:aaad with SMTP id d2e1a72fcca58-742a97e6b2dmr19286152b3a.14.1747687012726;
        Mon, 19 May 2025 13:36:52 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970d5aasm6865112b3a.63.2025.05.19.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:36:52 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	zhoufeng.zf@bytedance.com,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v3 3/4] skmsg: save some space in struct sk_psock
Date: Mon, 19 May 2025 13:36:27 -0700
Message-Id: <20250519203628.203596-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
References: <20250519203628.203596-1-xiyou.wangcong@gmail.com>
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


