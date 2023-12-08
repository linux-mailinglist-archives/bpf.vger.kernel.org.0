Return-Path: <bpf+bounces-17089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E17D809934
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A5F282234
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37211FC8;
	Fri,  8 Dec 2023 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbIuFnZA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1771708
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:32:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f04969d2eso71287285a.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002745; x=1702607545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+lEngjm0gdW+8fPByYsck9TfM0M//m2JuXxDohq+ww=;
        b=nbIuFnZAbfh/B/djgmv4ZoAcRnY+pe9YjbCaZa2T8+HSpbncT8EaseibZFusXTOm0Q
         UsLwxGei/tAUnArgAbnr7W7be9yZTCOTzTbYTmfV228PaedlQh9DQvG/xtwVaCRISbsE
         bEFpt2xwu97ADzWi4xVOuQxu5vmyi470bkTD+xZ/YJFKj3+yLMkfDiTbql5AFYOWZg7N
         8drqOsmH2RYG5tHDx2TnWg0qTwVqur+vzDa3yKv6irAPLDohjhww3ZYWD54yRfPrVMkm
         Icx60Bk929GRq0m1ajO5zw/hzhdirr6lMEZLP1PgIW/G3D1Jak/fKRkV7FRVYqxgzVWr
         hGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002745; x=1702607545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+lEngjm0gdW+8fPByYsck9TfM0M//m2JuXxDohq+ww=;
        b=nk4KMvAjf7T8NkOSlgUxfiMLIlqQDAkK+JGWt00tWPaLd7QaCf6Uathaw98BI6pQj3
         T2OGungtUznh6YHHKqkfXiIXc0GXim1nJXN6a9q4KDuLxGO4byO7ss8zz6O6KumqwoEQ
         NmKbFmbXlrkHdJVa9zfMfvhRYeRk3y1hAm0duKiPPUk003M6CLDyjBKLbo3lOWwh6e8e
         uvqy6uOGa5v8B4Vv4y1Ikh6JX5eTEUSQTxZoKYjbxs/AlbkqDc6TxsEgVN+GNoTBwAtY
         5NlcYJtCKz0XDNF7pp1Po6ip86+ebTFfpPSI+SfEcefZEf7k2MQSo5F7+013r/iXbyWF
         yDyw==
X-Gm-Message-State: AOJu0YxXIZIzu2Brbcp+l8QtzaeKRfPLKOYaaNX3F+1XH0ClxrqDE/Vq
	VtXmZ9egT3bP5g2MXnXd8hoTykx209527g==
X-Google-Smtp-Source: AGHT+IFwTkNJb0ZtOe1GlPB29+LewlLtXftSBgspCM/7/y3zpZ2TeIrKI5cOCjIiBXxsisZ3/l5uzw==
X-Received: by 2002:a0c:e7c1:0:b0:67a:a721:cb16 with SMTP id c1-20020a0ce7c1000000b0067aa721cb16mr3136890qvo.119.1702002745230;
        Thu, 07 Dec 2023 18:32:25 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id g5-20020ad45105000000b0067ac80bb33fsm408063qvp.125.2023.12.07.18.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:32:24 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v4 3/3] bpf: minor cleanup around stack bounds
Date: Thu,  7 Dec 2023 21:31:50 -0500
Message-Id: <20231208023150.254207-4-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208023150.254207-1-andreimatei1@gmail.com>
References: <20231208023150.254207-1-andreimatei1@gmail.com>
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

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdef4e981dc0..a5848d9837aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1690,7 +1690,11 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
  */
 static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
-	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
+	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n;
+
+	/* The stack size is always a multiple of BPF_REG_SIZE. */
+	size = round_up(size, BPF_REG_SIZE);
+	n = size / BPF_REG_SIZE;
 
 	if (old_n >= n)
 		return 0;
@@ -6828,7 +6832,10 @@ static int check_stack_access_within_bounds(
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


