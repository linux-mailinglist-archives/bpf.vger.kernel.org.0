Return-Path: <bpf+bounces-16527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E2801FA8
	for <lists+bpf@lfdr.de>; Sun,  3 Dec 2023 00:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD8FB20B06
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993182233C;
	Sat,  2 Dec 2023 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb8bpQjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB47116
	for <bpf@vger.kernel.org>; Sat,  2 Dec 2023 15:07:25 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-425430fe8d1so6848761cf.1
        for <bpf@vger.kernel.org>; Sat, 02 Dec 2023 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701558444; x=1702163244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8SpVW3CkZNhXsBqm6EqoOoA9b75VhXRO1afVON+oRA=;
        b=Lb8bpQjHrSe0fRzSl+poaDFtRGSFEbgDZumSLcVTLme2/AkFz7M8L9rN2BlRVHln0S
         qsrZ5Q6jmzxX36Kw/TnfvWhOpLZ2WxhMVyKGQ9RIaj2lVR7oQwDKbAmUDVueBH2WOu7J
         V4QmteAQe69TMcgMWoNhZdPG9thpgPPeYmy3hYiZA1RAA4AvwcACgTCszzXZljj3EC7F
         uWqn70aFT3/UEPJZIdYc7TxuMryDf5Al06iNyueXuOnzToh9Qz8NjbfsZoqNdVX74Ap5
         VtQGwagWoNGwfKuQVuCqJ5NxIgcpHWhEgyXkSmfFe1IkkU81OcdI7upx8D/zzFDPMUIu
         Oryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701558444; x=1702163244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8SpVW3CkZNhXsBqm6EqoOoA9b75VhXRO1afVON+oRA=;
        b=NGRCnrQOw59eP1lpQijUnRQsu9xC7Wh3RBl8OH5FnPHh3WSZ6heD8+1DNrf3PNQMrf
         xvpm6GpBNlr80FeVR7BiKJkXnX3Dkk4Wfx8LbDQYPdql8mhy8SYQSKf45Wqn06z01nX8
         ZgjpV5fdbuAUAJw7+rslfcn02CiR8xhK2BIQicXRogjTENZ40T73eXPK6jtS04D+I0kl
         gW8zyC9XksNOc6OXTAmc3KPwzZKcrL1Fw5/4iTFKO+GMYseKvB95gPr5BvgjvTTbYoul
         roCU1SWCwNcGXP4zABbTCkOFHkfSHF4oBn3ZV1mjLGYQJa2HnMxBYlRMOiU2TOFAOyg/
         Rf3g==
X-Gm-Message-State: AOJu0YxwnX0+RdHSiFc6p3eE/+ZlOp9exHoNl/OjoYq7BE2OVdRBMEQ9
	xXu2OjXsLmilo2F7BgsMpdDaqC8VfxtaMQ==
X-Google-Smtp-Source: AGHT+IH2ng7yT1h8Jt3oWYo5SR9WGvBEsrMKKJ1ygXsvhCh86+7tU6wXSlXkOzUFlRxT3KfseS27kA==
X-Received: by 2002:ac8:5c90:0:b0:425:4043:18ce with SMTP id r16-20020ac85c90000000b00425404318cemr3319687qta.129.1701558444053;
        Sat, 02 Dec 2023 15:07:24 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:fcf6:1739:7af2:33dd])
        by smtp.gmail.com with ESMTPSA id c4-20020ac85184000000b004194c21ee85sm2815417qtn.79.2023.12.02.15.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 15:07:23 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 3/3] bpf: minor cleanup around stack bounds
Date: Sat,  2 Dec 2023 18:05:58 -0500
Message-Id: <20231202230558.1648708-4-andreimatei1@gmail.com>
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

Push the rounding up of stack offsets into the function responsible for
growing the stack, rather than relying on all the callers to do it.
Uncertainty about whether the callers did it or not tripped up people in
a previous review.
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdef4e981dc0..5417c5ad3d88 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1690,6 +1690,9 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
  */
 static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
+	// The stack size is always a multiple of BPF_REG_SIZE.
+	size = round_up(size, BPF_REG_SIZE);
+
 	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
 
 	if (old_n >= n)
@@ -6828,7 +6831,10 @@ static int check_stack_access_within_bounds(
 		return err;
 	}
 
-	return grow_stack_state(env, state, round_up(-min_off, BPF_REG_SIZE));
+	/* Note that there is no stack access with offset zero, so the needed stack
+	 * size is -min_off, not -min_off+1.
+	 */
+	return grow_stack_state(env, state, -min_off /* size */);
 }
 
 /* check whether memory at (regno + off) is accessible for t = (read | write)
-- 
2.40.1


