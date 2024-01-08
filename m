Return-Path: <bpf+bounces-19225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB1827A55
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C5A284B39
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0A56456;
	Mon,  8 Jan 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YNVQz9d8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABE5644C
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28c9d424cceso1550893a91.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 13:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1704750156; x=1705354956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Om0H2b9haCAXEMP5FMDOFAJIVidhFwipddb5hPJUKls=;
        b=YNVQz9d8iSNjXMqjQrQEBPgpe+2EXd+y6hoRahQ8R1jCBp9gAXUi5D+iKd0kJ1Ky76
         1aBhRm+mtm4gPmAHpiPHskBYZvC8IT6CJZvB2sImxyf71Yp2f2qmqq11m49+5e2WHncr
         R5Oqk3CFHxFHKu7qtdzg3DqY8c5n++RdkBVDVOO4+a6Dgq/uo8aX3Yakl4/zRvZWJYyJ
         XwjBuyLs8kw9a7FBuGRlJrbG9Tu5JQk5jxmzHT7KmFjpdKjQPtel6h+fV0CXe6Hc3mZn
         tg0hTQGC8UhZolZT9gA8WrRb1Q91zZab8IzfYo6VV2jL4DvqXR+wnHejIWcDiO7JbCfI
         BoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704750156; x=1705354956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Om0H2b9haCAXEMP5FMDOFAJIVidhFwipddb5hPJUKls=;
        b=CppQvQrZRLnXIOrXM3C9xg1FkHOtHwemOUhKidz905Y45dIU7XfZTkUSO8AGhaPh2e
         V8CzyApr8dnWoQ3k4vNvXnhKn1ROBQQsIEDSXvn3kER2Ddm+hERNkNY7vzIhN74TYTRI
         oLpZpuWz4vXYx90jT3Id+BFbuUmW6OrBSqjVTBZX0wwrG/wMSMsfM4zANX6HOYJCaBfS
         N9mBKiLrM7+tO7R/xARPhtXS6mpi6rA5rlyK/wRQZP/icWv9Z0N4MU/NbA6sT9X+M2uQ
         1J4a5W1ownqWuym13Cusvq/j9HCPqnl1bFRH8AYUOa7xIfEEGtzkulC2qsEIc7bfzi6P
         Nuww==
X-Gm-Message-State: AOJu0YwDIlm4pJWOqpPozLnO6e1RRjxfFbCzG+yybiDQxXsULdPU/dYw
	LTIcM5kBcjHNI2v2nIYZH7iW4PH3BHE2WJQb
X-Google-Smtp-Source: AGHT+IGqQ6p8gcYov8oECSdLI5LOB0wUi9ASVwIz98KzjcZzSG4XyOh009NeniuMLGNZ0eMDSnbgfw==
X-Received: by 2002:a17:90a:2bce:b0:28c:f3f9:ccb7 with SMTP id n14-20020a17090a2bce00b0028cf3f9ccb7mr426217pje.41.1704750155693;
        Mon, 08 Jan 2024 13:42:35 -0800 (PST)
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a01d700b0028098225450sm7668476pjd.1.2024.01.08.13.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 13:42:35 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] Introduce concept of conformance groups
Date: Mon,  8 Jan 2024 13:42:31 -0800
Message-Id: <20240108214231.5280-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The discussion of what the actual conformance groups should be
is still in progress, so this is just part 1 which only uses
"legacy" for deprecated instructions and "basic" for everything
else.  Subsequent patches will add more groups as discussion
continues.

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 .../bpf/standardization/instruction-set.rst   | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 245b6defc..eb0f234a8 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -97,6 +97,28 @@ Definitions
     A:          10000110
     B: 11111111 10000110
 
+Conformance groups
+------------------
+
+An implementation does not need to support all instructions specified in this
+document (e.g., deprecated instructions).  Instead, a number of conformance
+groups are specified.  An implementation must support the "basic" conformance
+group and may support additional conformance groups, where supporting a
+conformance group means it must support all instructions in that conformance
+group.
+
+The use of named conformance groups enables interoperability between a runtime
+that executes instructions, and tools as such compilers that generate
+instructions for the runtime.  Thus, capability discovery in terms of
+conformance groups might be done manually by users or automatically by tools.
+
+Each conformance group has a short ASCII label (e.g., "basic") that
+corresponds to a set of instructions that are mandatory.  That is, each
+instruction has one or more conformance groups of which it is a member.
+
+The "basic" conformance group includes all instructions defined in this
+specification unless otherwise noted.
+
 Instruction encoding
 ====================
 
@@ -610,4 +632,6 @@ Legacy BPF Packet access instructions
 
 BPF previously introduced special instructions for access to packet data that were
 carried over from classic BPF. However, these instructions are
-deprecated and should no longer be used.
+deprecated and should no longer be used.  All legacy packet access
+instructions belong to the "legacy" conformance group instead of the "basic"
+conformance group.
-- 
2.40.1


