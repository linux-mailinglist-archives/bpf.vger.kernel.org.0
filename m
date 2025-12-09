Return-Path: <bpf+bounces-76347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 870DDCAF5EB
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 10:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8710301462B
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687C2192F9;
	Tue,  9 Dec 2025 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4KigoNH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FA2CCB9
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270813; cv=none; b=ok5gwoLOUxlGOLk2i23pJCWjjG6YaferKOlqqiL2kkAgqnoFu9Yep8cl4Kfh6OcO+6fgS6SKWTgeA24V0RP3qtLTAHmZ2VQi0zrsADdUs8n9zg0ao3bHwQ1Q0BpDLlUzEVcuBgdAf8xeOmwZCfPg9iXwdc+Z4pT32z3bAJb10uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270813; c=relaxed/simple;
	bh=epDzpJaC0kIlgC9TA040OsDbzt5g3cUfjj2MoVX4oOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4ax/0KqjtHuJg+nxjpX9J+IFc/Jq3B54AAQdquWnNtXUQKQPwTVCuB8yb2K7gL4d0BYM5HPLjQiw6hs15jyeCFyFWYCQJYrIyMJGxlpqNsELGNDXgpEXNdgfaQNeFOWWhHumKXSxyFpIFGENVrNJYRl2ae2VanjKmQsiQx3V/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4KigoNH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5860120b3a.3
        for <bpf@vger.kernel.org>; Tue, 09 Dec 2025 01:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765270811; x=1765875611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbH4EuzhAJD5LMzglUJe49YvZPtTt4GT06nkKNw9fJk=;
        b=I4KigoNHJIe+JfYMbaSer7airfyyatSFFwUyms6ubKgvZevQ3g4JtAKyRyD/tfHMQv
         amFmcJebpWfegAMvg3rq00aPNYHhvnoOGd2uZq7fzkMVXQyW25nwOL6fvEltyV/Imw+K
         xCTYQzvdSf8pX78Vme6mUC0o+sKFC01rQUKkaWt418fzrClLHuN2yedZ9VgR5jbpQY5u
         77YM4QU8Ct4oyNDWYlIArLZw23tZ/cqWjzwnBMuw/plvluDNbt5bjWijiwfGDB9cbz/t
         nRSuY4quRMHnRC4tk1d6m5VXQ7IP6fUy6tVfxq4X0HxU87KdKR7NlPKJYiTUs/5DB3oJ
         CUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765270811; x=1765875611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbH4EuzhAJD5LMzglUJe49YvZPtTt4GT06nkKNw9fJk=;
        b=kwrJIf6BVHvRdbUoaTpEZt3p0FxK3YbNjs41wFvNmELeE7KQYwalIAiiRhvSIdGqmy
         EYE8zYIyFnktq3dgl7eXkfeASDMBhq0+uDYhSXUmf8Yx+xgDAKbyH9NQ+JIY7ck4RVR9
         jNGWBCMG0TSA7e+rjgYdabT5fJb/B/otXlzGOCPRzAlbODKY8uNpmQgNA2dwl273itH9
         8/0k69sPMslESn0vg7annzWEEhtjOHEtv/8ZsqLLtq44yLThI5XZC8wyvppMRLzsgXTX
         ZALxxYaXxBFN/Q89c9bk7EwmhHWmFnEVjeV/3fUxSot/Gf1CpekJDLOEDKKvQDCX2dlx
         LsVQ==
X-Gm-Message-State: AOJu0YxObfo/Z9Sut4PAT8Kt13/3/rFMBs5fWMbxysTsJnD+7vMN8txs
	BTUUxjSp0JbgdrtmiSVq6amRAQT8NkqJmMPZmVgcTQZS73Qbu9aDAeuB
X-Gm-Gg: ASbGncsOIe5TeUV027ULTehiOZDEEZ4D3tm5shs2xtF2Wd2tCh7dh4uhf/OhqSzTnJZ
	ZeB1em+byxIYiAPJ0rgWu5O6EzelD+GgKDL8iU4G6n7Xgew7r3GAJnYsIMlgMJsORvRcxLk+8xM
	NkvEOqaWBJaQzjaCzQKW99yJ395KnAgajeIJeNMdIze0n6JSLrcCvf6ltTuHa6lAu5ACODTLYMD
	hf4ruea3WSSx2iAD4WPmm2vY1vWbUE1Vp6Hs/Wu+PtFVamY4phbrlJIYGskNjocgmffsvuLTSlX
	beX0aIv1rSjVCSgdjuiCgChfjyBJbC4glq3ejhMKpQ6V7ngrirS8Ln4+7X/dQlvBK/ZfgqHz9vE
	ve5di0EVZBPO4MkZcp6ECI/QPEZstu2UHXTt9W7gZqPnwMecsnoCJgE/hpjX7/mEQf/Xn+/Yl/K
	XYH2OIBr4WW/wOuCf+5bfcT+EHaEgPRMU11mi93o5curFlXC9i6gGVQkTIoQ==
X-Google-Smtp-Source: AGHT+IELImggGpczVDmXVc6H21DKcAc/fDQH57HKydbvBHbvUF8y0P+L1Qncty5ki2h43Lq6lJWfwA==
X-Received: by 2002:a05:6a00:18a2:b0:7e8:450c:61ce with SMTP id d2e1a72fcca58-7e8c63bbfe6mr10197623b3a.62.1765270811096;
        Tue, 09 Dec 2025 01:00:11 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e29f2ee0b3sm15529015b3a.7.2025.12.09.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 01:00:10 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH bpf-next v1 0/2] xsk: introduce pre-allocated memory per xsk CQ
Date: Tue,  9 Dec 2025 16:59:48 +0800
Message-Id: <20251209085950.96231-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series was made based on the previous work[1] to fix the issue
without causing too much performance impact through adding a
pre-allocated memory for each xsk.

[1]: commit 30f241fcf52a ("xsk: Fix immature cq descriptor production")

Jason Xing (2):
  xsk: introduce local_cq for each af_xdp socket
  xsk: introduce a dedicated local completion queue for each xsk

 include/net/xdp_sock.h |   8 ++
 net/xdp/xsk.c          | 202 ++++++++++++++++++++---------------------
 2 files changed, 105 insertions(+), 105 deletions(-)

-- 
2.41.3


