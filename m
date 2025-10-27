Return-Path: <bpf+bounces-72294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A6C0BBBA
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 04:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBBD189E741
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 03:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605822D4B4B;
	Mon, 27 Oct 2025 03:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yom07kO5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A1F9C1
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535219; cv=none; b=T2ODBKIm5WArwiusPByKplV6jz5ZbqexMOP5sayvmFnwVgVShXeTdzG6QrkEdpRST7ibDt/TcKzLoAHwfteG7AKjz6nxzuQTaFow7k4jlN27mcXF869UOOcmsmNPFrb2gCk4v4cA305MPhj5Kv0ZsMN78icMu/xViCLtufsxtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535219; c=relaxed/simple;
	bh=AuU11ztRLK+I5zI4UsmWzBs/U3j0i/HFOVRM2mlnTZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A6F3fwFtp1tX5GFuQRY0FRelgSxx/mQXnciZHmyL5O2Ce5Z0q6/g0mK1yOeqdC9S4vQDCpu1OsHJ0IU/HHfW0Ok4tsV7DrZ51CAel9FFQaP/XGTEkDBYwR80WyPO3wHXicg5kT1XFsGNXLkR0sQE/2oNfpV+Wpt9Cu6aM2CU9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yom07kO5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so2809454a12.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761535218; x=1762140018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12OL70/9rabscg9vqPO/maQtcokUUc3ZtNtaJUA8Pmw=;
        b=Yom07kO5iWL51I3wkaPeA/kki5/G2zuxK8EBI3F273AcptEZ8CevluMrqlIq80A1K0
         YqhNXhkkidXRj8E8XU9nSBS3ZCztAiMcR3eTII9wJObjUIqvu3Sj8uSyxJr6e11qhebj
         wAPieB5C5GappQpzTuTPFeFz4VifG2RIu0chS9FhPrECpM2SCib2Mq4MidXtQJKbkwoK
         Q3/Dl/DJSz067JVSkOpVsM3nUiL/oWsMjYWFHYHg2IrLMcwt9ToBgELCh5G0Uh7/Rb3t
         jCKJGTKlic67izH6QZ+EuP9s/h6RzeDxZxSctrwP4zD/vGdVxUg0X+gQQKRnN/NfH3Q5
         y8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761535218; x=1762140018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12OL70/9rabscg9vqPO/maQtcokUUc3ZtNtaJUA8Pmw=;
        b=CU3rNf11tilLpIS9w88YexsRh50PP5delOBK/maZqRUrMvegrU7DwALH3SkTdSJ1NA
         MMT7CrOPjK0KPNF9zPGy10Ell5KfVF/s8qf3v2b2eXCP7Q7zORrDfNmmn/6/6NvJzse1
         Rr5yIzhGaX1mABTyBVkxzooGiO1qREIVQ78AVckrCwZKPocBD0jJPtnvw0tI713Z6mHm
         0z0X1ZXryYYnTyivdpFFPA6+wXNHMWGOWmFdBo41WWoZXk5xZaFysPOVvq2Auxps4ku8
         NT0sMy+vi3PVsPUZQuo3oC9CWibD9IhdbHN2it2IuUaTONtvd0/soMdGi7dxdrQLguxL
         RSOA==
X-Forwarded-Encrypted: i=1; AJvYcCUBdKtLrA1jO4iLvagrAL7LOLZWLXk8aEG9iWcA0uGGJXokXZpNUs7q5DCgfcBZPZPwbCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcG7mAvN6zFcnb6z7v8sV4OX45GM1Dl3a/Uc1CdNm7nvOTIFuC
	j7bT000OrO8i+VIUoHfPiURwhqORTU0B0zl+w2otaSnVn/SMP7QZoM7k
X-Gm-Gg: ASbGncskH397P44ZTnNucfJGG5uifqrE8vDbMeqhZXtrE6Dd0ZF7v0tZhCMZX6EPSrH
	lfBKF0zji3IO7sKHRUt9wojEadDeViepUpmOzJ8PoxTOyK0VPmgiTsmK5+gz2hMyuEntAcJWGW6
	S4IJiL4dtKk/eM12c0MLS0p6ZJCRL5t7QmcFjGLK1K3HZw3EUljvDYL6MfuSXPy52UO1dR3wg+u
	wbSityHtsTihGYfasQJaO4MsQj3OM+d6eut/ujMNpnVorGch+ZrMvdJ86ND8gkgr8BiHhIRFJca
	WaIJ14sOvLliq3WCh5QLbZl+Mt8E4h3FwL52tNfGWldzH527LbSxSBgXvcfdhoupJa7gvAOOu1b
	7jnCbVuZz2Ayb4Ts178Cub3I+iAIkmQNozfJ8OAHJH3c0UVvrD6Los1GeU51J6XFqVnb2lGPTni
	+ZA6eontBudU9+ACAMPqbCLcUwd0H9
X-Google-Smtp-Source: AGHT+IHuLOPOeurzXjn4p7N7tty4UzvfTmJ8rBSm68O+2HbFxuRVi7P8jHfgVtGar/wcCIOxQ2aXrw==
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id d9443c01a7336-290cba4efb1mr468009825ad.35.1761535217715;
        Sun, 26 Oct 2025 20:20:17 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3e8530sm3454102a91.0.2025.10.26.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 20:20:17 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH] libbpf: fix the incorrect reference to the memlock_rlim variable in the comment.
Date: Mon, 27 Oct 2025 11:20:08 +0800
Message-Id: <20251027032008.738944-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable "memlock_rlim_max" referenced in the comment does not exist.
I think that the author probably meant the variable "memlock_rlim". So,
correct it.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..b66f5fbfbbb2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -154,7 +154,7 @@ int bump_rlimit_memlock(void)
 
 	memlock_bumped = true;
 
-	/* zero memlock_rlim_max disables auto-bumping RLIMIT_MEMLOCK */
+	/* zero memlock_rlim disables auto-bumping RLIMIT_MEMLOCK */
 	if (memlock_rlim == 0)
 		return 0;
 
-- 
2.34.1


