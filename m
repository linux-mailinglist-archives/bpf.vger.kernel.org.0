Return-Path: <bpf+bounces-31544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F608FF796
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 00:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594F41F250D1
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44977345D;
	Thu,  6 Jun 2024 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo6LXVvF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9B624;
	Thu,  6 Jun 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712150; cv=none; b=ipg9VI9jO4csCAmZXtTrpp5StYcpQeChTN07y9kX6pLFnSTyQNVijC6Ed23mvPFd2nLHfKjMJ9BRNHEZFIzr+UlUlvlnU6MY3NlaI2K57dZE6OXO2mnKk5cAV5jtxwYA666NDrwOChSXFKvODrUOweE6RpuSV1JVRjI4DqwID/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712150; c=relaxed/simple;
	bh=Fc2YZeHN/bTTfW77yQIGrKV+Kv8gDPA0lyFVNo2RbhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q5XrsFiAtOScqW9ZmaUBRBIMkU+p34SWBPCy0X9XgOYXJiCdvI0lcnr5vKV7LN0Fc/oC7WEylZlH2rGm+xhGf0QGYzmKcUEzOK4Zi3t/pafRLUupMUBceVnIX4SvT9/httDDL3t/KXokKf9TTS+OR3ZlWTYKCYwqYIgodCNGMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo6LXVvF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c57fa82fdbso1110872a12.0;
        Thu, 06 Jun 2024 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717712148; x=1718316948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3Oe//qFnHgPV57RQMFgPj07R5Pj8Tqj/EDp692VzDU=;
        b=Wo6LXVvF4CGwDnav7I/+J59xNUYaFDQGeCQ9V9PlNbm6dnhqpJepXBUiyl0fhyL37N
         OBcyJIjzNuZpycvSLb50ARzbCI+2JE8xdL3vYBHhU56X+cQ6bpHn/pvk6Iy2q9ehJ0Kx
         sadBXE/BWwzI7VTkxxy87tUOvNS/Q85kfnN4mejmIfi4xrZjqObPwoj5zf0ZSca6bXHr
         28M3xqs6j20dvtdJg8bS8/xYTP7OdYiHlfQaEQ81CX3deYGEaCYVPWDBDILCVpu6Sun4
         RWX6LE+6CgreV+ypVDQVpWQPDTF1QhA7TQWJGOdo8aEV3ArPFoY21znyjIvlxlpnKOlZ
         8KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712148; x=1718316948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3Oe//qFnHgPV57RQMFgPj07R5Pj8Tqj/EDp692VzDU=;
        b=i3WDlRYIxUGV0tYzsvA/cPeTqd5shj5bwLKoj3TZpYKaR4pK9NKR5cV3k9mtfiBMBx
         6BmU5H0lKE7bplZGck1EpK1JzySTtdC+G+ory60gmShn14UFdS9IZaj3KPVNLxJpDt+1
         qOtO8VuujkjwiXXiVvKxAeG/8AgTqhcB5+t34VrxjIr4kU3g1SABHQwCR6bGS3DncVqo
         AUuWGa6tbPsAyZV+yDOtVZfv7Qf/d8KKFxgLuGiiHY3ZC6+0+tOK89H24GC1d0dPrayM
         9tdcr0a3Zsq/Nbii02A7ViT2Xr5A9PLX6Z11ybKr6xLhhelV9rjXys9/xVqTuTEXoCOg
         bI+g==
X-Gm-Message-State: AOJu0YxQtcCYRBUNZpX5qEwzic4XTN7uJMZkZGOUO6UMDC1erbWVxU6P
	9d6nfTso9w5xuUNfjUTN9hRuHytsPB7XKHTls0042g14j4nUfRus0b2eVA==
X-Google-Smtp-Source: AGHT+IGeSEj6XOrW4m7S6BxJ+o4772z1HEmdfgMfUsC4MwdO/mIPBmdlOegdFqAi6qK8cOeYlak1LQ==
X-Received: by 2002:a17:902:e84d:b0:1f6:8466:e4d7 with SMTP id d9443c01a7336-1f6d03c0d9bmr11290055ad.51.1717712147551;
        Thu, 06 Jun 2024 15:15:47 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:d837:6817:7898:4ff7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd774bf4sm20405235ad.114.2024.06.06.15.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:15:46 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>
Subject: [Patch net] net: remove the bogus overflow debug check in pskb_may_pull()
Date: Thu,  6 Jun 2024 15:15:31 -0700
Message-Id: <20240606221531.255224-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
helpers") introduced an overflow debug check for pull/push helpers.
For __skb_pull() this makes sense because its callers rarely check its
return value. But for pskb_may_pull() it does not make sense, since its
return value is properly taken care of. Remove the one in
pskb_may_pull(), we can continue rely on its return value.

Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push helpers")
Reported-by: syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skbuff.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 1c2902eaebd3..9fd49bab6595 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2735,8 +2735,6 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 static inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
-	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
-
 	if (likely(len <= skb_headlen(skb)))
 		return SKB_NOT_DROPPED_YET;
 
-- 
2.34.1


