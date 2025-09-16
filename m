Return-Path: <bpf+bounces-68530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1FB59CAB
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 17:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F306E17707C
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E34371E9F;
	Tue, 16 Sep 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjxFln4l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060B371EA0
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038218; cv=none; b=CLgmVAupIrSrLpovZRwKyYIEAdXHJia2DAvZtszNmQxGaRtPiD7R6gFWHwz1j3wZ2ZxJHYAgA6aDbOyXOkY36G45WgAaVgPZ1S1VrCzm5NNiWaheKW0vYa0TR+rXv5JxArNY4kw2UVpCcM35ZZTJPKx5pgaqXWQNXVAfgTChsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038218; c=relaxed/simple;
	bh=IRzTmLRNWRkXwuFptgz6+mmRL3Z2PH68tG2vbcPSId8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qb8EDTc9jFDAdL4mYUvwW3Ne4/ewmU+E+3EvTyDk9MJ+2Hkv24Q7mkvtTSoyOnFoYNgcB/dJORgRGFXqvmi9/Itczn/4L3nto1xPtNV5ixwPYNxY2z8YO6L9cjBVdJISMJ7UL1WJkchK3mxQ/BzfJ/G/BbrKF3Y1EN00rScFooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjxFln4l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24458272c00so60081315ad.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038216; x=1758643016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yiAINEhVsjWg8ki6Sy+j8WcDazb+q524Nc68fNbvg74=;
        b=AjxFln4lyiTGkSRtI44zl8OPox8ykTfyKO8IHj77PjF+kr9+8XCbQt9/ar5iJMOxyW
         TTFWMjXMoCgJr/Q4XnHIrEH6zsy1ucwq4wHkvBHJrauAf7YADvJcnI+bNnZonYVBC4io
         HkZAgZq9Et8xxa6cK1aBHy5nzwqK3vUzKk0+PpK8sJmYfo4o+YxSJ4eCi1bg2piAuxz5
         WuOYYnljvwsZEje/hmQ5kEp3Qw2ZE874Q91WRJZHKDaDOqmQ6DViAejw0Bu8cIJDbMF5
         1NzGPXtuTdGmeU3QOWgKX5JRWJ5YdoX9i42Qst9Odij6AduPpKQjBXtNMcgf5gTNcw0y
         VHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038216; x=1758643016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiAINEhVsjWg8ki6Sy+j8WcDazb+q524Nc68fNbvg74=;
        b=dxOp4uY9gJgABl/ZXxduN2vcdHM6cqP2n/SYKchLGYt9G/6AnaZHvqVNE9zGuPUm6i
         mt9e26rPOobLBTXOdCVpD4HMcCHuN8yIn6HBf0YrVpnBwP+oV+RbSCKGOztbxqMPZ9qp
         6r7oCJC1ewYfw4ZPfsJJII+WMLEyHiuK/XT8b9/hGtL2T58hnLG3TBzR1dfxlMaAknp2
         omjuwMt23AJ+QJAhXK2Qes3iAvHaQ53op9LKoAN2AHCRvJQxdLxezvjYQDO9kdARUzNR
         Nc3aVLYlbZb0g+MIlU1VnL4GopI9dZfoNm3g2MeQ/rq5xNEf3uXC66ve00H5mKXGpL0x
         yqBQ==
X-Gm-Message-State: AOJu0YymRhUo5xdvubPM6cokbrRP6QtUi01g9SXNk2rr5atJroWEpIr2
	YOu+bHdCDODhoeU/OSVltQvSHiX/VapWJP7OV2zqOE4XQ49QFVONf4j2Sn6VTYGHijzFUuL8
X-Gm-Gg: ASbGnctDaRK1/BvbgEUjE19OPFxXlU/Q6qv/u479PS5AYrdjqwg5DUjvShLxMGmxdoG
	o3/Iqu8f8SbzH7pj6Z36e3PFMDmra8bKGBD2050o6fM1fUUZz7GqrwNbSKZvAGtQPwu6D4aMDo8
	LpVzuIffXiJDryT8HWy2eAqLoIxebr2PfSPcLsx9ebxo5INNjtVE4DswhpBIZy3zsnk76Y/nIES
	RrO8RlIdmmASR7/zKN5g7TeeMcizOR46dY7bN6zepMFcqyoNc26aZUXdL/PIS5Wok8r5CgBc8fr
	OFwb4THjB9dyI//vjOpzbl3Qwfryil/LyiYlrUSmDVvh5KFXaN53wbqDBRY8bHgECpJuyZXqMps
	ZJMztQ5x+u7de2thUKsux9l4zYhF9i99kSeO+8wIDHmIrMxbF7EU4BvkGZoZF
X-Google-Smtp-Source: AGHT+IE/gas2vRtfvf0jFsXNDu2Tg/is10TY7CsOk25OmfpGAOAy9tXtVXYdoht/7haciXVgTf44kA==
X-Received: by 2002:a17:902:e545:b0:267:e097:7a9c with SMTP id d9443c01a7336-267e0977cd1mr24188785ad.53.1758038216190;
        Tue, 16 Sep 2025 08:56:56 -0700 (PDT)
Received: from laptop.localdomain ([104.250.148.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261d3dd029bsm101320645ad.25.2025.09.16.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:56:55 -0700 (PDT)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	ameryhung@gmail.com,
	Xing Guo <higuoxing@gmail.com>
Subject: [PATCH] selftests/bpf: Add back removed kfuncs declarations
Date: Tue, 16 Sep 2025 23:56:49 +0800
Message-ID: <20250916155649.54991-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These kfuncs are removed in commit 2f9838e25790
("selftests/bpf: Cleanup bpf qdisc selftests"), but they are still
referenced by multiple tests.  Otherwise, we will get the following errors.

```
progs/bpf_qdisc_fail__incompl_ops.c:13:2: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   13 |         bpf_qdisc_skb_drop(skb, to_free);
      |         ^
1 error generated.
progs/bpf_qdisc_fifo.c:38:3: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   38 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
progs/bpf_qdisc_fq.c:280:11: error: call to undeclared function 'bpf_skb_get_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  280 |                         hash = bpf_skb_get_hash(skb) & q.orphan_mask;
      |                                ^
progs/bpf_qdisc_fq.c:287:11: error: call to undeclared function 'bpf_skb_get_hash'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  287 |                         hash = bpf_skb_get_hash(skb) & q.orphan_mask;
      |                                ^
progs/bpf_qdisc_fq.c:375:3: error: call to undeclared function 'bpf_qdisc_skb_drop'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  375 |                 bpf_qdisc_skb_drop(skb, to_free);
      |                 ^
progs/bpf_qdisc_fifo.c:71:2: error: call to undeclared function 'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   71 |         bpf_qdisc_bstats_update(sch, skb);
      |         ^
progs/bpf_qdisc_fifo.c:106:4: error: call to undeclared function 'bpf_kfree_skb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  106 |                         bpf_kfree_skb(skb);
      |                         ^
3 errors generated.
progs/bpf_qdisc_fq.c:614:3: error: call to undeclared function 'bpf_qdisc_bstats_update'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  614 |                 bpf_qdisc_bstats_update(sch, skb);
      |                 ^
progs/bpf_qdisc_fq.c:619:3: error: call to undeclared function 'bpf_qdisc_watchdog_schedule'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  619 |                 bpf_qdisc_watchdog_schedule(sch, cb_ctx.expire, q.timer_slack);
      |                 ^
5 errors generated.
```

Fixes: 2f9838e25790 ("selftests/bpf: Cleanup bpf qdisc selftests")
Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 3754f581b328..7e7f2fe04f22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -14,6 +14,12 @@
 
 struct bpf_sk_buff_ptr;
 
+u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
+void bpf_kfree_skb(struct sk_buff *p) __ksym;
+void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
+void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64 delta_ns) __ksym;
+void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym;
+
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
-- 
2.51.0


