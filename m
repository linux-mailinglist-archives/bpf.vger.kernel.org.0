Return-Path: <bpf+bounces-70693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8C6BCAC35
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE6D14E5F03
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F52690D9;
	Thu,  9 Oct 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJIhDZ5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C17267B94
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040688; cv=none; b=JE1+AHUQBCm8kDmWhH03GVkbuSDGYjbIjIaY0ZzBlucY/rFZcegWbiWR2wXQEpZiDHb6Xytij0LyedIko4z51mPjjeN/A6liBqdCxpbdQFSHgyuEkChDLSFcimHdrNabQwdDe541t3ihBvqUluoD5hoFkQdNASL5rkQM2TFUyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040688; c=relaxed/simple;
	bh=twzbDbSVuVLCL/1mLMV3Wl1fFF8tKjKbJU8UKnqo1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdhzi2EZxQEgrBobLI33i4311BtxLoscZ2NtSxF/TmiKWDQ7FJmDX8i83oGc6xKlpG+AyA+otPP9rNKsj0EU+uYUOeZYTi2XfIylQ1R+pk6/vbUuv3v7cnqBC15ejwPuR005mE/bBTOO46fl+S//00uElyqoAjU28o66puFtNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJIhDZ5Q; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so14978285e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760040685; x=1760645485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=WJIhDZ5Q5pS4OoSDKX6SENpYaT14uv+8gTpNmUNeQ0MQLWL8UXsaNGJsqE4bqIezzC
         Z0NfjL6/pMwxoBxqeFmWGfYnRQlJhpfArU8nQs2bXW3WaNmWsfDtIZ8T02T1eVjH6JqW
         afcHpoO0KLZsm6hOLWo424aIhLDrFCpaCNqMGMlEAjYIV86TlGourfi/RBsM79TludhF
         uKXiiZYILNSl2C5sYBLRfuFbO6SyCZOgtwiHyq1M+F4IvHjBd9PAg3mipWsOlPkMXQJl
         E3VhdM33SQNoOGbSFd3XQ0ePcHOqtg1sDGOp2CuuxOkfgR9+rTp0me0y2tyzi2VuvhoI
         biFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760040685; x=1760645485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzlzTjT2+jjbmV9yu+MbxV5HiwIZ7aN89TxY+AUizoI=;
        b=Rol8o6zcaSyYcyErFmzyP4OJUGlB/TPzxabJNpgZDJi4kE6t9IsMKFQZpRvPGhWD7f
         ueMr0dTw2ecF5u93porRWvqPgFAOIJc6gxLsDAuJuEOIMjbnSIN5y5QUVWDQShenwhe1
         7fMRhRbf4uK12rfZO0p8Om7REcLDUihp1BIbj8ZproqeUBHbBy+LazpXsIMh8XWq5aFT
         m6XirG7CH5+kUbkfXEEsg38k49bI8ItGQZmA5yf30m163Ei630mB7W03COg7PNoFOsK3
         MgpS0HGvmVcGDsp1cJXxRGYceAnsU+aGpejtH5dcKt0rUVDanWQlEYEvdVZFYIixZqXT
         LECg==
X-Gm-Message-State: AOJu0YyERdb1nWRD3IaUYacqyPnism+2xsmFkv/pv9nI42eWJ38lb3fB
	T6lE7DRRxfzROF5Ow7pIM5xtEC5zjzgqLiE5/dLM8Nhwgq/XpXIOrxDSlZXV/Q==
X-Gm-Gg: ASbGncuWdsy80V3mdSxcgmjd3SWwPVFvausrJDxcQc6F9TKvYRSivU5802T+aLOKawA
	2CukWROGDV4MyAi2OvXFjALk9GTDGFmLkyWCH8KESNeqLHK0VtJlzJG5jb2v3GCVQ1Qz7swKnS1
	6++c7PPd2Dmax6vD5fa4WJwec/HAnU2e9oLCMGvQ00kfdDEPBeNKSfVGOWX6N4CvVKK3ByCGvVS
	orcDDjPSatT5KP8zUTZT09gTQRoGDKQQbRXeEqO/W7NjtGcf70WWFHllMDfJPN8HO3mz97rHmHU
	qlcu+tYiNc4KM+bnroRJEeFbBhFyeBl9j6MkqeL6v5MDI9ZUsu4+grrHKD/3wmQUroOZeTeWbhv
	6qSAtRD9JMd1Pwds+zmWKDpE6f1JYdCluqsDvknuW8u9C0GPne8Hx1Ik7QJunnFUca7PL3Rgbrk
	OVhIW2LDYxtlzWHtFqgQaJsiBfbCVAEVL9W7827HJ1qRw/DA==
X-Google-Smtp-Source: AGHT+IFaqhMT4EoqLW+EPG3Lz6cWd8FudqeIzD63khEWfccoGfNmgNCuA//XZKTellgYMbfT5i5aSA==
X-Received: by 2002:a05:6000:2910:b0:3ea:bccc:2a2c with SMTP id ffacd0b85a97d-42666ab96aamr6599016f8f.11.1760040685049;
        Thu, 09 Oct 2025 13:11:25 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583424sm611728f8f.21.2025.10.09.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:11:24 -0700 (PDT)
Date: Thu, 9 Oct 2025 22:11:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v8 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <063475176f15828a882c07846017394baf72f682.1760037899.git.paul.chaignon@gmail.com>
References: <cover.1760037899.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760037899.git.paul.chaignon@gmail.com>

This patch reorders the initialization of bpf_prog_test_run_skb to
simplify the subsequent patch. Program types are checked first, followed
by the ctx init, and finally the data init. With the subsequent patch,
program types and the ctx init provide information that is used in the
data init. Thus, we need the data init to happen last.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index a39b26739a1e..b9b49d0c7014 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1004,19 +1004,6 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
-	if (IS_ERR(ctx)) {
-		ret = PTR_ERR(ctx);
-		ctx = NULL;
-		goto out;
-	}
-
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -1032,6 +1019,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
+	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	data = bpf_test_init(kattr, kattr->test.data_size_in,
+			     size, NET_SKB_PAD + NET_IP_ALIGN,
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
+		data = NULL;
+		goto out;
+	}
+
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		ret = -ENOMEM;
-- 
2.43.0


