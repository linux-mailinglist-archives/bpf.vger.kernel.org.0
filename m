Return-Path: <bpf+bounces-45742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4E9DAD66
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DEC166AAA
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A64B14430E;
	Wed, 27 Nov 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7usNwen"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C5201245
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732733506; cv=none; b=D5ZU0Un7OrlVupDKHhbYMfj1vWN+nUsrr8EsrPrn/H5lMq8ezIk5WqI4DZDLCywDmio3wKoY9JipFanGiiZAcZp8Q9DIanhetq8/VtVc+l/WN/bBlbcyu6k0KWSThgvJrJDrsqAsyhfITuTPqBo8MOgMuXh6RG00jgBuwPdgxw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732733506; c=relaxed/simple;
	bh=2FOS0xjqxxsi/1gBQ1MbMP4C8VFEzjd8RBAbMWCi588=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgeZzfNWm4elkpU6wA/GF29fLcloQZBUv0pOY1bw6iZzjBzCCp9IQn3qUufo047UZe4FeGEHcxtef4OeBKwGOm/QPf1gjTDhdPDtcFGPmp1YofPJbJuR6MYzdhlrRdb5gHuVHk+MtsHAbpmxdr/IoRFhCCLD1QnAmXew/8lsMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7usNwen; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so50702f8f.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732733503; x=1733338303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRpbv9js8KCoCZabbKH2/W39iYnr0jK4lGEDrMimA70=;
        b=B7usNwentRzrp5fdDwHu8Ib61mrILHt1kScI/QIJUjKxhsq7PbzeAQQVKDRDAqaggJ
         avYa/sYVQnTad2B3pcMxAfw2XUQpiVND9YCjMREnGJ5iFgJpIDKmSWumGnA6vE/g4QAr
         niWJNvpe6CTm2cahmHDTY5BSEDHJOxvjiGqdqHhJ7EKYmOQhQojnSX+APFUOUPAd3YMJ
         irgbFf3sqSPYGNJ+YgetLMvZLMfa8uEIc6wK4SubkkGcZ+t0KR7p910qxBuzGMQVQwM6
         G/hbNUsGqZpKj/AXfIO1qqWGlQSJKllE3KTBjHEPIXN42K95A1LbdSSTvlJ1hqYK1w4H
         9pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732733503; x=1733338303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRpbv9js8KCoCZabbKH2/W39iYnr0jK4lGEDrMimA70=;
        b=RXnDaAM06o4WnFjLTzjoZyeYLgRInMB/9tIBht504TndwT4jOcuXX1G4DzWf3iY3bP
         vea4k/UomSrLlwLLbOFuaFtKVM9NuTZAYCBJBuUL/cHaPJ9DWGKRUx0t90vTzmRGMCyM
         i55fE6J1Q7p9Uw6AJM10KQSRNpM9Au1tVMQGk4Rc2gHezqfnNQBRMmhQ3iGrM7XQ8sF7
         8hEWQQeWsgMQjCwpx5bB47NR+n7tb2bWPQbjPZUzmI7c0WI1Cao+UXeNXl0QeaZVnVvq
         Rvit1JumS/YJMQ2Kn2jFlfzX4GyvG2KpAtxCZfZGJ8z8tuI+b4aJfrC9yi2NKjNEtiul
         wuPA==
X-Gm-Message-State: AOJu0Yx1ZCynnwAzy9TWJr99Oca1K1gTX6p9xY+e6yPpaCmbA25Aqrtz
	tc8Edcr7jc+xEpoxm818mnV+0FQnZ4ZvMeslPwYPX+2/BQ8rEh9OzjoMvgnMi0Y=
X-Gm-Gg: ASbGnctGUtUAFPeVa2P8bp50QMeJiGkkzExZDadC+bAN3MDByme8WWGMbrMPY4KgL4L
	V0wRUicvlbwJyl35Dn8MKj5SIHpsj1x/W4tKuS8fuoeOgtSd4+19p2socm3IhOJCXeMgeBSN6sK
	Ahm/wJDWsxkifds8P0NHUceY9Lv1I4BJ47Zvh8V0iu4mUuDfzH1eZiv44aHqYfPXc3XGBEO4/hk
	GnEDNMVHTagfMFrMQZAAhixynNBP90ERWGYqBvRYyK9LW5Df385/nowuG+09ofejWDaDStGUFcU
X-Google-Smtp-Source: AGHT+IG5Dl0z/ltjfQh9ZQu2s3EW4FtjjDs3zC72vwq55BrqT3w0olAj3bIpeT4g271BgzuiDU7Ghw==
X-Received: by 2002:a05:6000:1f85:b0:382:2492:3218 with SMTP id ffacd0b85a97d-385c6edda02mr2960274f8f.47.1732733502879;
        Wed, 27 Nov 2024 10:51:42 -0800 (PST)
Received: from localhost (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc34bdsm17481480f8f.78.2024.11.27.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 10:51:42 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add test for narrow spill into 64-bit spilled scalar
Date: Wed, 27 Nov 2024 10:51:35 -0800
Message-ID: <20241127185135.2753982-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241127185135.2753982-1-memxor@gmail.com>
References: <20241127185135.2753982-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; h=from:subject; bh=2FOS0xjqxxsi/1gBQ1MbMP4C8VFEzjd8RBAbMWCi588=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR2oyVYLS78CFW9bds7B7rpERenIUzbd3hsoUrkrN zCmjbCWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dqMgAKCRBM4MiGSL8RyqVqD/ 93leyq/VL+vKqBiy4+QkAUgd/p+gm83wuFd6vAjMWBY36GvDZfiZCHxJyRQsnoHuHuNuOhwq3ZZ0O+ LnS99m807CjZcObdSFZUCfOYT7E7uU8lHKk9djBvdhjFs3/J3riUqIVedU7qkX4vqebgmXgm6BIm9l CuKvLqJhbXqfK01p5Z73Z8OfGM5wLNW+SpmMB3CSZOtZk5bCzQvmyOWFu4JiFn41IlIsccRYCSCkCO QiSpPWFKmiwH6eFlCML4vsU8cUjYOpiohNDu4hZJZmJPugvsC+5DDgAREBMiHhCBwxaXcioe7hwdse nEmTJB9I1794D2jMhsQkv8JaDlP6nkeip3My2CMLlYp0AAgwEu/PDv1uwSsxzrzHB2IFTfjSnQKpT+ oAXyZ9RD6JgB/47qDDPnVHYBC9s145SS0oC4RtmqGTmaEQBf7oHISAkeydP+2i7zf/Rj08UGWLI6My 4sUO1ilp561D6i8N/Mlwb4a9MPLyH7jZUSPS8ZrnnPWEp5BwKjXgDq+3JYV/+ycXznbaoXR5jqPQs/ /sAIa8yTzjYB9Ndf9N6KWurwkZRV+v3RrsA30wLXyTyCg+WLipt9pW3WzoCKP8DlO2VCAnOkvJaJbH gQ7nvBDdrf91EIMXLDOGdWZxn6IUpUZHATbQPHBhCdOIJIx9Q3I2JMPrMZ/g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a test case to verify that without CAP_PERFMON, the test now
succeeds instead of failing due to a verification error.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_stack_noperfmon.c          | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
index 52da836d47a6..f6d5fa76c90c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_noperfmon.c
@@ -19,3 +19,18 @@ __naked void stack_noperfmon_rejecte_invalid_read(void)
 	exit;						\
 "	::: __clobber_all);
 }
+
+SEC("socket")
+__description("stack_noperfmon: narrow spill onto 64-bit scalar spilled slots")
+__success
+__naked void stack_noperfmon_spill_32bit_onto_64bit_slot(void)
+{
+	asm volatile("					\
+	*(u64*)(r10 - 8) = 1;				\
+	*(u32*)(r10 - 8) = 1;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
-- 
2.43.5


