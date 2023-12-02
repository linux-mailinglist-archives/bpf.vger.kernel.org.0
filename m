Return-Path: <bpf+bounces-16525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A44801FA6
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 00:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCA2B20AC0
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E022333;
	Sat,  2 Dec 2023 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktzZsXzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A2F3
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 15:06:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4254853d4d6so3889771cf.0
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 15:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701558405; x=1702163205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GTrWxRAoa3xIVG0uwowftKOB3tW0DpUZO1LUI931Hc=;
        b=ktzZsXzhyuIHC2zSezTE9ac3HygDbNdLNJwyfbYW5ZYQTfUVNQayzaPZJ3zD2Tl8eY
         KLJ1gkMp/Toer5G8PhuiZbeZwrr9ynvYEZ4HLipeQJBrPiA6AyaE3/zjdv/31s7LIQj6
         jOgqksgJ1pia/rVI+DKeMzIOnSX3+3peCsyPtjXCRJb5yg8FzsxQeQroTWHMx2zDglkY
         QIx5/1WluI9z9yqA4lq4XMxDTDAP0MH5kKlhcYjeKhZyt6B0fvdD+eSYWNWZp2W+l8z2
         F4xV1DJOxAghwi7ugqQJcIWMDXW4U2LNZb31g/iJP4arMknhVXlcGsDKtMN2V4jCApWE
         wRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701558405; x=1702163205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GTrWxRAoa3xIVG0uwowftKOB3tW0DpUZO1LUI931Hc=;
        b=V/ucoXoG1swuIuj7ZY49TRoJYM2C2+75ko7ncuwSnuv+Oo8BT252YW5Zei3LCpDq+L
         2cgLHiSzQ2c/udVKLEQIX9PrEpizNPAcp2Z4B8t1hxw2Hr6Nn5KghkQnKafae450vpRk
         zuRwxa7ELNB8wM5UOLi/XlNkiTwpYh8q9g+8sKChCiIiN4n16ZddUiMG6yprwery4wsE
         pNVvpRrgpNtuIo0w9rflf2zDa9A409u806M8Wx/e28n6whKUbDFNvk440QxkiJvNPZeV
         JuWoqn5EYRF67LHp9rIdO49yirhTEbB2A8E8oRJPi/U3XNaXGDsKrFIGWnwEiC3URs0B
         86Ig==
X-Gm-Message-State: AOJu0YzGZE7Ts89yuiZAAtUeXzJEsObXkq/+fqjaAk5Afq/XmzXKD4TC
	5nGIkzqrgXqFoT84NB3U0qL2HggZPbf5Fw==
X-Google-Smtp-Source: AGHT+IFrejo/Yq3HHlyRZ0wiwErfrfRNZlerX5kphV5uWitXfn71nBGAbH4ftplk50HpDWjV+lMNOg==
X-Received: by 2002:ac8:5d4e:0:b0:423:95ff:8753 with SMTP id g14-20020ac85d4e000000b0042395ff8753mr2628771qtx.55.1701558404913;
        Sat, 02 Dec 2023 15:06:44 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:fcf6:1739:7af2:33dd])
        by smtp.gmail.com with ESMTPSA id c4-20020ac85184000000b004194c21ee85sm2815417qtn.79.2023.12.02.15.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 15:06:44 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 1/3] bpf: add some comments to stack representation
Date: Sat,  2 Dec 2023 18:05:56 -0500
Message-Id: <20231202230558.1648708-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231202230558.1648708-1-andreimatei1@gmail.com>
References: <20231202230558.1648708-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 include/linux/bpf_verifier.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa4d19d0bc94..ec3612c2b057 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -316,7 +316,17 @@ struct bpf_func_state {
 	/* The following fields should be last. See copy_func_state() */
 	int acquired_refs;
 	struct bpf_reference_state *refs;
+	/* Size of the current stack, in bytes. The stack state is tracked below, in
+	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
+	 */
 	int allocated_stack;
+	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
+	 * (i.e. 8) bytes worth of stack memory.
+	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
+	 * stack[1] represents bytes [*(r10-16)..*(r10-9)]
+	 * ...
+	 * stack[allocated_stack/8 - 1] represents [*(r10-allocated_size)..*(r10-allocated_size+7)]
+	 */
 	struct bpf_stack_state *stack;
 };
 
@@ -630,6 +640,10 @@ struct bpf_verifier_env {
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


