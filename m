Return-Path: <bpf+bounces-57803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC4CAB05CA
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CF1C24906
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0AA2248BF;
	Thu,  8 May 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMmSmVuX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0B1A2390
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741993; cv=none; b=cQIjsjN498Q/1hvsl7wZ78MxvGQpP2LXZACM+g0Jrk3XH8i/lqSR8l5oAqivzhbc8anr14jS/n0epQDOdrsX41Zqg8n5X5lrKaDeONSIVnnvuDvVqh5rHTyiV2V+zI8oP3/TW4xMWoIPPnV+l3dxP7YpAvv4AEG20xT/5eMYDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741993; c=relaxed/simple;
	bh=/YBJzMCuwSZ0gD5vHQwTzc1+xHodKRNMR4TAKZzDNf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky7WGKEgrjnczYDVjJhnav+ZM+/pH3gKxRfgQmu+fsbj5XnPdQ7ZU+gyxNxWV3ed1JVjwbRsE78ucFgNqSfHsc2nL8pnDZdKJNOwDk1Fq9Dl6F6mhMDbUa2ednokYv16xgqx0OCVnYSaYqemGiddhHRVApgUwJCI8CEagxrTcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMmSmVuX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c1efc4577so886908f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746741990; x=1747346790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxloM9IOCjp0UomopLAB2NwRnG+M0cJkHPr1ytY8yTY=;
        b=VMmSmVuXeG5JUI7fDXq4ya/TgUsjuMvbwWOC4lUgljLcaRHTwGn+SZNR6vHBJhbGfv
         e287pZZhGA7JPyuG9HCBF7DcfF0/05w7e52FqaNO7HbZ5IhViuVsQ6hqbJFGQrIkgfeM
         +3l+Aw+NDmHr6bup/MreYky0cHEJTdqk/uK0xuPxGmaUSO6WS1T7DW/lbE7rIO+tez8A
         HQbKPmejloNoShOfdz2W5bCFK7FKXM6yEVy1vQFL0Fd3lMS/ar9ZBuSSmv6Pobulwd1T
         NkK9AKXPaB2azf75D0uYsilBPsSMphRznhacbhPuAdP6V9KI4oE863ruXl/+/iSa9Jsu
         k10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741990; x=1747346790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxloM9IOCjp0UomopLAB2NwRnG+M0cJkHPr1ytY8yTY=;
        b=Ta/hwjbvh1pvmB5w6sqCz84fD1yFcAAtyvl5AvzPoDehfzveW/dvvOzXfWYnhvGMsK
         wV5Ld3lM66ve1Bbweg3rlxI6dQ6nPirr0J6pvjLb7u+3DZRy1aj4pwvLSw9RM0BsNQ6c
         Kh1VEsL6qsujPBGODdU2fz0rVjW7yCcBSj0UpOSpaHqQJgEVqnONWg8NyWSbR2uN1mTD
         FqRCocPAMCTv7g6A5312z1cdpj4iOMvGKjI7qkO9n0rAFGcLMiU+d+uowYKi5p+3McXH
         AthkDolVUxdooAm7MjVESIzw1Nt17cgAXSInqKltkyDUMqVe3IPJEaSilx+/iXLevve9
         UeQA==
X-Gm-Message-State: AOJu0YxLOrX9onS81XjvRa59IxUS8pLOWLW30y/p66mFmcsaCq1nHx8d
	G+nh3nxQ3KdkQ2kSZAcxEhmh21V/qsyHKPWrunfculuGTAskTZWAIKZG2A==
X-Gm-Gg: ASbGnctDqwhxjcRuWpbgJwbJDc7ePpivIyDlD4jP8Yg9D/DZexSwzqeC3G8Ko8sAd0r
	rgfijVFM6Yny9Mt4YroDkg9e541mIZr/RC0F0ZlMPH16vXvo8xknmsUCa8eIHljOluVLvZrkcxD
	iPSei2MWrmPCpUE+f7CCEI/B3H7/5qs0vcJLj3ALlbiicAvpv10/7IUJ08myCrB9PJbc2+4i/rw
	en8uCTVJS2Mi/BE7VY/EYGVYjxVEHGaNMFM6u2C3ncT7ruVMSMnRh5U0DVR+noRLR74un6oDEO2
	A/rMH+X2m9oygrhA8rSAhq1B6aTnUIdn4l2Oqwyr76yxYw8gP8YOvmrdEGQBQuXZsgCdoA==
X-Google-Smtp-Source: AGHT+IHzyaS0R7VSnTpg5Q6Wd2P1X2AzVpRGJciPidG62xQuDFSbMWY+xBJeFbh0n5kRsKTS7+Z6Cg==
X-Received: by 2002:a05:6000:40dc:b0:3a0:b23c:15b9 with SMTP id ffacd0b85a97d-3a1f6429883mr871583f8f.4.1746741989989;
        Thu, 08 May 2025 15:06:29 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ed0a5sm1168830f8f.21.2025.05.08.15.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:06:29 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 0/3] Introduce kfuncs for memory reads into dynptrs
Date: Thu,  8 May 2025 23:06:21 +0100
Message-ID: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

Mykyta Yatsenko (3):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs

 include/linux/bpf.h                           |  14 ++
 kernel/bpf/helpers.c                          |  22 +-
 kernel/trace/bpf_trace.c                      | 193 +++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 +
 .../selftests/bpf/progs/dynptr_success.c      | 230 ++++++++++++++++++
 6 files changed, 461 insertions(+), 12 deletions(-)

-- 
2.49.0


