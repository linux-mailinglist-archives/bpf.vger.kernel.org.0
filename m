Return-Path: <bpf+bounces-17096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EE3809A3D
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F061B1F21144
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4BB46B4;
	Fri,  8 Dec 2023 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqrl8e3d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428DF1712
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:25:30 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-425952708afso7669961cf.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702005929; x=1702610729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFq4wNtT7zE3Gz+c8yblUyyecsVM1ncUZIroLE/6ru8=;
        b=Mqrl8e3dL+S5QAerMQlY8UikG93YFQy4pRXw5juKnXuie8ExEECSXD8At3Q11Gtwxi
         nYyv+bNd/iMZybWfDIlHAtS2uav31MhS9MWkHERFe8PnPykMpC3OySt89J14ktSIYrD4
         HsgO6TVkqwX8gnrnxpmMl9dldDE31gjxtUqylj2PoLw4k2IwMRREeP7TgHESxE0H6AMk
         zIT6VdLiLbDLc+YLGapUOE180mJJMRmP9cKIW6s0wCcYVYO6sYKX36pAWGNwJHImUn1F
         dZvqTPEZsmyOTWCn3orHFgg88vAXHNX8x9ivLlE6QWv+kWA0YzIL1BFv1zyNviAKMOep
         kF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005929; x=1702610729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFq4wNtT7zE3Gz+c8yblUyyecsVM1ncUZIroLE/6ru8=;
        b=B0ibkaBx6c0b/zlfrxJagSEr+0tB0gNWxlx1VVnZSgGDsrAjAtPfNrobW8l6IKxsQL
         1H7PPRrXd6/buz0o0NlQvHqKuwmoTc/B5HZVQ8DPU6ykX8RM335VwFD1hVpSUew3DoSy
         Oh9xsA7juMbTMKgHNHQPgLQE1IZZCObQMi1+zOa4oXNbBVbQSUtev4gBfXBmhvZHG8kl
         1GxpuohVpY7Mq9gTmIXZO+T0ZuvA1m7tQEcIsdTPyq5AYOMLC8K7QXVhFvCNd56g20e/
         j+0R/nyYIOiCQybZrU2r9UMyzNYOgoUy++xtJNh09Ct1HIr+rm8KpTPJsV3Flx4J5o9f
         KjSw==
X-Gm-Message-State: AOJu0YwYpqeTqDqvvTv6+mxCQxuvW5BNAv/P7PBhIQdZaCRhq1coftvZ
	7OBTaGoj8WHtZr40LiCZuf+7Qk2pKsAP+w==
X-Google-Smtp-Source: AGHT+IF8w5GgNutVhGQyYJT+11Iw8eUiu+s5PHlWbp6gY1StnHIJzsDqX9IkVB7kduxQ7rfv8HvIPQ==
X-Received: by 2002:ac8:7f02:0:b0:403:abf5:6865 with SMTP id f2-20020ac87f02000000b00403abf56865mr377847qtk.18.1702005928943;
        Thu, 07 Dec 2023 19:25:28 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id l2-20020ac848c2000000b00424030566b5sm448266qtr.17.2023.12.07.19.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 19:25:28 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v5 1/3] bpf: add some comments to stack representation
Date: Thu,  7 Dec 2023 22:25:17 -0500
Message-Id: <20231208032519.260451-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208032519.260451-1-andreimatei1@gmail.com>
References: <20231208032519.260451-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments to the datastructure tracking the stack state, as the
mapping between each stack slot and where its state is stored is not
entirely obvious.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 include/linux/bpf_verifier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bada59812e00..314b679fb494 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -321,7 +321,17 @@ struct bpf_func_state {
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
 	struct bpf_reference_state *refs;
+	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
+	 * (i.e. 8) bytes worth of stack memory.
+	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
+	 * stack[1] represents bytes [*(r10-16)..*(r10-9)]
+	 * ...
+	 * stack[allocated_stack/8 - 1] represents [*(r10-allocated_stack)..*(r10-allocated_stack+7)]
+	 */
 	struct bpf_stack_state *stack;
+	/* Size of the current stack, in bytes. The stack state is tracked below, in
+	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
+	 */
 	int allocated_stack;
 };
 
@@ -658,6 +668,10 @@ struct bpf_verifier_env {
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
+	/* Allow access to uninitialized stack memory. Writes with fixed offset are
+	 * always allowed, so this refers to reads (with fixed or variable offset),
+	 * to writes with variable offset and to indirect (helper) accesses.
+	 */
 	bool allow_uninit_stack;
 	bool bpf_capable;
 	bool bypass_spec_v1;
-- 
2.40.1


