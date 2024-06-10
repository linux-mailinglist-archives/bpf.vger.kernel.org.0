Return-Path: <bpf+bounces-31709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760F9021C9
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D50B1C2142B
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3580611;
	Mon, 10 Jun 2024 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naUio1S0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDD81AD2
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023356; cv=none; b=Dy27Y1207Jdd7yLjHSi0tDC7c/goF7Yq4kwuY2a5xA+kDQIzUrE5saCvrq6i287XaXRRk9Ie0fyVcxtwL5njjoqRpMIAdzVbelXjPcAPaI1kLakRMAhnuwXuzG06PRqquOhjHBffeB1IIWDxorVO6Gv4sGWOln3m3nZZYZUOCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023356; c=relaxed/simple;
	bh=xHAucL/XglNqXYbJhwML2Lzhsv80Q9USL9mlOD25nK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PaTK+PyxYCArqFHzB+NmJBIO74LdRJcy+mAF3dXS9PDbbXA5e7eqEzkqHkN/tVCQcPOqjH8UrY545nwlHIaUap6kGXG9wv0dtgu1XCGD+CeoN4c8mk1xUF5baYn5H47UqiGRuWXKSVUveCcID5ck+wgjux6KvkSiFEs8fi9XWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naUio1S0; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c4926bf9bbso2859372a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718023353; x=1718628153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lLm+nRQIoxUudiu8C+xljXuJbpU4KNBNZKGSCQS/69Y=;
        b=naUio1S0WkOXFIa+MokHkKm8yqkKj2FMNT0WJMxjSWyUcVACc9HWDO2Gi7dR+uiSqJ
         /2HFLgrjN7BR8CnrT7pVt8nfwnTrNQws+KsPSet/XK893J/LZeoaweCd+i/JawJfKZxs
         HLsJR6TvHQK17rWRyKtnpR4DgAc6zC4pSJYVWG3r1eeIc62a5GJq26jRs8gY7yvxqdRh
         tWDkdNgLbTW58lRF3SEtaZSeltW4b2XhQmtseOJQw/Abbo9fv3eykaqae2amepTbYeNn
         VormfVvao6LUeCgMHSt1cbxv3ky9EVEJdVfTpG0FHGiLdkPknqEE/GBqDRfu0aQhSLRH
         Mzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023353; x=1718628153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLm+nRQIoxUudiu8C+xljXuJbpU4KNBNZKGSCQS/69Y=;
        b=YVLfLiSkkfvlc+tBFb65f514Pis//znK1qntn/lTuEQsM8hnCC4OyiTKYxAVXIkPEY
         ZK7B0HqQwFgVWEkhw2BHDyXpekU7MkzOBO2JP20YOHEEkueO1+afXHGfuE0/7/hEtY1L
         klnx4UcjYmux+skzWxdh+LSBsNa78N+nULhaO/kX3bSjyuTLS2TpdIwwflOC673pM16a
         UBwkto4LyfrYZMgpZqKx1XcDpbX00HH/l68UEqJ+GE9nkrEYscVdQsHY6azhd1IoZJyb
         AM06us7oFoe5wibgjL+G+zXTw4p2EsLDcjyeWjW98hsmRc2wypm5OtSFaGKpRdyIDOpc
         ig3g==
X-Gm-Message-State: AOJu0Yzf0HItMutUHtJ9o5999FSt0FlFvydUocdIH0YyGjiW2cXgdBvx
	ppOUlTrOous2j+cAAMKN1Cw+IMcRUW9kNh5CqXlgZnViezQrXas+zfk0TA==
X-Google-Smtp-Source: AGHT+IEGxiN7uj+Suqe8Tzs/nYwBXxrDzE8sKgQXBXETjmt5eydtBRQpLun2F08Px196x+y72OZ9xw==
X-Received: by 2002:a17:903:1105:b0:1f6:fcd9:5b8d with SMTP id d9443c01a7336-1f6fcd95f02mr48932075ad.9.1718023353539;
        Mon, 10 Jun 2024 05:42:33 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6d859ea3csm61578855ad.178.2024.06.10.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:42:33 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v2 bpf-next 0/2] bpf, verifier: Correct tail_call_reachable for bpf prog
Date: Mon, 10 Jun 2024 20:42:22 +0800
Message-ID: <20240610124224.34673-1-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
when bpf prog has tail call but 'tail_call_reachable' is false.

This patch corrects 'tail_call_reachable' when bpf prog has tail call.

Therefore, it's unnecessary to detect tail call in x86 jit. Let's remove
it.

Changes:
v1 -> v2:
* Address comment from Yonghong:
  * Remove unnecessary tail call detection in x86 jit.

---

Links:
[0] https://github.com/osandov/drgn

Leon Hwang (2):
  bpf, verifier: Correct tail_call_reachable for bpf prog
  bpf, x64: Remove tail call detection

 arch/x86/net/bpf_jit_comp.c | 11 ++---------
 kernel/bpf/verifier.c       |  4 +++-
 2 files changed, 5 insertions(+), 10 deletions(-)


base-commit: 2c6987105026a4395935a3db665c54eb1bafe782
-- 
2.44.0


