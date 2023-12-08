Return-Path: <bpf+bounces-17097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4148809A3E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 04:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3791C209B3
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CED4A25;
	Fri,  8 Dec 2023 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKfPD1UV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60D1712
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 19:25:33 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4259cd18f85so2546481cf.3
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 19:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702005932; x=1702610732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXfZYb2/FBAU3Oc7Jc6HA1dp32VQc1zzYbSIQHUxODM=;
        b=UKfPD1UVv1ybRfgCpV74pVDpsvv+HD+axqPSBnIAhWgfV2TBdpuVM8ppiPN5FjS17m
         mRzhimeyS046r2du9XxakQWkiqQc2pIqeVziUpVdBvsynazmMuZ3EBx4OycEwBy+kWMM
         bAFUkwnXc7uslKGUfLWRU5Jh97dvFtVubr9/X9fyZWZK0GjqGot67us2TOJ5DUNoarLq
         q1dGdo+jT5MdaBrfsgheB5qecxJau7dyBR1kSLkgcW2gPkRbUjHo2GJ3quEzICtKQZ6V
         7FDjK2UOyUWRTpYyRjc1ITgm7wmX8a/moHQyjSOuSDv4417f84zdFRosKz7mdUlMi8i6
         AyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005932; x=1702610732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXfZYb2/FBAU3Oc7Jc6HA1dp32VQc1zzYbSIQHUxODM=;
        b=md8JUZNDAHFuXixtK+BIuYJ5b2j3hC2jyeX3dICvFopL3Xx3Jj11hkb5ixgPWiKb4s
         18QvPP4+1NE0qeY8hAPY/7DoSHMns4jhR6lgJ/0/qOAPK1pBi4AUXtqmHyiDa5cZ088A
         pHx6x0uPTMdHQpZuBnUeMkIT8PBsKbDv2pA/7hR1VK0CH+I3Sd3Qszqv41kgAic6bfzZ
         6/mJtqVbmfihcUXfnJWdBDAqrKb0zzWJuiKFDXkLTiWBXx6/j4vvxdIjURkl7/fqKpgp
         FuJNzhUowxE+t9W76zxD7c4Gysrkz/fjeiHHXlOOhg8g9mgSu4bQp8oFPMxZwP0lqPKB
         MY/Q==
X-Gm-Message-State: AOJu0Yzm6d/oRzeiVytCJvUAQ379qpfIAjSDj/4rpO/nBPa3ceJ06Yux
	hvLU5wBLgF5TQrB6826lYBS9Zak46K7F1w==
X-Google-Smtp-Source: AGHT+IH1Q25aOTfqluTf4zuKIIChHRPpJispg1vAmWG9Eg49SW1YNrd2F0ydoCb+WHiKUqIjpsiTAg==
X-Received: by 2002:a05:622a:15d1:b0:425:4043:7651 with SMTP id d17-20020a05622a15d100b0042540437651mr4061845qty.121.1702005931844;
        Thu, 07 Dec 2023 19:25:31 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id l2-20020ac848c2000000b00424030566b5sm448266qtr.17.2023.12.07.19.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 19:25:31 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v5 3/3] bpf: minor cleanup around stack bounds
Date: Thu,  7 Dec 2023 22:25:19 -0500
Message-Id: <20231208032519.260451-4-andreimatei1@gmail.com>
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

Push the rounding up of stack offsets into the function responsible for
growing the stack, rather than relying on all the callers to do it.
Uncertainty about whether the callers did it or not tripped up people in
a previous review.

Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de1e29fa467e..fb690539d5f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1264,7 +1264,11 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
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
@@ -6638,7 +6642,10 @@ static int check_stack_access_within_bounds(
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


