Return-Path: <bpf+bounces-79645-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFszD9TOb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79645-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:52:04 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76949D05
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8B4C968464
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE82D5A13;
	Tue, 20 Jan 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9QsLRe1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810C2D592C
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924771; cv=none; b=fjh/XnrF+7dX/LavS0BUNRQu5zAVnfMlJUTiPrEgrRrK4zzSPyVW/7Il2eJUUQaPGd4Z/XtNK0s4KktZAnFCr0iPDYlcym1PMlaY7RbteLrdJMUrzhfELDVZn2w9T67hz4GB3b7cgBrFquGyTqvQS8uonKCy72K8/yrsgImRZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924771; c=relaxed/simple;
	bh=Xrh866lO9Q9Gw9NVx6h31GetXA7JuZchQIhHdCPjI6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4Y38v0Kpar6mIN2AFJVG3OJg50TqVLLH5BsoAxgfxlkCQC5Ldb8zOYkuKr4GsXFwzhw2Zbir7lXJ0wXebAndrsAZnpTvmdHc0zcyG8SnXErKuF603l7bUz3bbKug4XgGqLGuwb/MBj508mj1/BYp1YKbIYjWgnKAccsRBnGKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9QsLRe1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee0291921so37810785e9.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924767; x=1769529567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y2YciIDqINvptvqpnDVSnqCpvHT9rE0wPor3lGb6Uo=;
        b=B9QsLRe1KHzq/tKsHBlsBqsdgQLOVXHMIYIs97JziW4DP2LHWatSPUtoCInex29XaW
         ZivJg3/ycoawa7S7F1tt9yO/xs3Tka/YtnuCM/+n3+u5veDbzpJarEhuhDIEeLyPaorC
         FlrP3kup+CVHWa4pnBnY7hdmt6ut2ttsAMxK+La1/n+bFmKp393xrmGPsoYGrH+wGsg8
         L5k/WF6CGDNwMCbBKM3lXiHinfw8dp9NUPetAscDmBPd2k1Y9JWws1evUtjmfZQihjgI
         sZyQIyKdFSfR5kz3as8IrSRKmwb8DN0yae+4SV+7KgfH5pQt1UCf46xpFfA996T0L6B+
         KVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924767; x=1769529567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5y2YciIDqINvptvqpnDVSnqCpvHT9rE0wPor3lGb6Uo=;
        b=NjF5mGV7vq7d5a7MfgwwMg+skDM4xD7eVWxRXdmVAh/5tU72wF7Ko8h8dNBGNjavGb
         fbD+RMQdSLNc05X9tOiD0pFN+zMhzoBoQpjmUE9Rk+dBQ4wdsVLSNa5MXTR11WtMoX0h
         5rHLh7jRIsJrCNc7m5zta2HHFZFkMwyskya8+XujBazmAYkuNKRGijEoHKpNAC7NenK7
         uQZ3bAPnMRkVvBXMOgxBCOYSbS+8cBikvvKyBA4OmzPPAYyzaRMcg0iRD4Xi6+XwV7Yl
         CjZh0I5pLbr+g8DHhIv6OWS5h/y5yAv7SWQGQECt91b9LEwzNy4rcQAwvoYOkIRlCho/
         DgAw==
X-Gm-Message-State: AOJu0Yxrn2EgAOHKfl87ZOrOX0BcIOqM1c2xzMwf7KkLVVpnid28X7Nx
	9eKlMHyTErwfguM4iNTie0CejWDZm0NzoHT784l4kANKrpTqhLKjfEGV
X-Gm-Gg: AY/fxX7W5hflzecfInYQGL/2k9bP5C8cKFh4ihpW6/DFdGPvaWb7WNSoRVJUd1v1RhX
	M9vPMyXj6+fOrxOPyRPQZYJekfwbYjXHLSNKDZS1mZ9w3Z5f5788mzcUCtOUnXYTZ3k8/EOdXCF
	+lHjnP0GVr9AepR2tEJWp9zHor4n0sAbI3118ec2c33b9IYpaxfFKI2hKVk4dZfXmgtOEZ+k1XG
	fWX5oAUTKLcHFGZvR5w2n6sC2UMsQl7TcmHMUxqzJ061JBZQqR88GeHP5hi/pCGdFGrXC4c43Ed
	CUDzNL4uyLvAyFGivEaUjvrhh8D0oxE9HSyna/1vueb2+jBN6FcSgTB9jDUgzcs91dPt/JgtJNR
	uhEvsgZ1jOQidZVf2ZmKVLzf9GRUXGVvhdWWrR6ytnb92Y/2vaXpZ7A6aDgVKpUMZyK18erasu0
	nhwFniHaGkaWXRHFl5JADrdg8E
X-Received: by 2002:a05:600c:c16b:b0:47e:e78a:c831 with SMTP id 5b1f17b1804b1-4801eb14ff0mr179783175e9.36.1768924767242;
        Tue, 20 Jan 2026 07:59:27 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f3b7a5f94sm329500145e9.0.2026.01.20.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:26 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:10 +0000
Subject: [PATCH bpf-next v6 01/10] bpf: Factor out timer deletion helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-1-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=2124;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=2LgyEZStd7a1UjwT4akf05ZIGBI70+FuPFC71y6FwOI=;
 b=NlXl+nc2j2A7+ZD8GbAi0HvPxL8bpESib6mIYGRxGBDwEo+rXRoWRUPhMAx0FZaFankYoZb3T
 HatwvjHrgEgDbvwvbLWleyN02kG3ZGvBSYN1z4F2bBRdUVP2w2oFV1g
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79645-lists,bpf=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,iogearbox.net,meta.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,bpf@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[bpf];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9A76949D05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Move the timer deletion logic into a dedicated bpf_timer_delete()
helper so it can be reused by later patches.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a79b903c6fc2ccb310f521a4b14a1d..cbacddc7101a82b2f72278034bba4188829fecd6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1558,18 +1558,10 @@ static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *a
 	return cb;
 }
 
-/* This function is called by map_delete/update_elem for individual element and
- * by ops->map_release_uref when the user space reference to a map reaches zero.
- */
-void bpf_timer_cancel_and_free(void *val)
+static void bpf_timer_delete(struct bpf_hrtimer *t)
 {
-	struct bpf_hrtimer *t;
-
-	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
-
-	if (!t)
-		return;
-	/* We check that bpf_map_delete/update_elem() was called from timer
+	/*
+	 * We check that bpf_map_delete/update_elem() was called from timer
 	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
 	 * will deadlock) and don't call hrtimer_try_to_cancel() (since it will
 	 * just return -1). Though callback_fn is still running on this cpu it's
@@ -1618,6 +1610,21 @@ void bpf_timer_cancel_and_free(void *val)
 	}
 }
 
+/*
+ * This function is called by map_delete/update_elem for individual element and
+ * by ops->map_release_uref when the user space reference to a map reaches zero.
+ */
+void bpf_timer_cancel_and_free(void *val)
+{
+	struct bpf_hrtimer *t;
+
+	t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
+	if (!t)
+		return;
+
+	bpf_timer_delete(t);
+}
+
 /* This function is called by map_delete/update_elem for individual element and
  * by ops->map_release_uref when the user space reference to a map reaches zero.
  */

-- 
2.52.0


