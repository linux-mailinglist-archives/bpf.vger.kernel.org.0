Return-Path: <bpf+bounces-79646-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBU3BXCyb2nHMAAAu9opvQ
	(envelope-from <bpf+bounces-79646-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:50:56 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE2047F6B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3E896858B
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464D31CA46;
	Tue, 20 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiIk7Pfr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A322C3256
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924771; cv=none; b=c6aSOnQ3W7nyuhGcVpEdqaaQYr++l4Ho86TkAbt7CLZkk7huHWF8xBh6U2a9/D1EzOV5o/AmcW0EJXdKp0Q0tLjvEubfFb7c8j4DXCY0xdosX+UCvymWnpoP/VNqi3gvTxwPOfxASWoVC4tv2WLSLF7SNVcSNpNSiKXYKIyGiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924771; c=relaxed/simple;
	bh=WFyfCdFZSc39/k5H49myNCriXwVVsZ3R/PPu+Rg7vaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nkz6spNB+gqZ04IKVBVdjA6P+5EXMnGIFCnt62rlZbd9MSfBeYojHi2F+AicRdK9HcmR64BLuVk3ZjPfIC2Kb+IkrBXtAilDuI/7kKCzlthOtbk3fGpcYWoqd+BAvnyJP2Qw9bia+Vq1Qey5IfR5/joQYFlJaQQPfw4FRsiD65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiIk7Pfr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801bc328easo47344745e9.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924768; x=1769529568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JbmK/RJvEWmpHkRk+ZhC+1Oyd2c57i0SiusSqSY7AQ=;
        b=UiIk7PfrswgzWYfxcknJWDVf6+/cnUTUonYBu8kEcuXOkWtrVE1pdtNMKLjffcAwTB
         I8ortoSCOjuyj49NWJhzdQmhKjNWm1EJjhfCc7ty+Mv2f8w8zpVnmd4gVm49xXFZkYw/
         xs255okrB4U9UhkMrbuUbtjihgqVV4Tl5spkS8d7A2naUcXHwF+JniE6u4dHyPs7DRw6
         9k79t+s9QelsaxfESyFpU06oENlBpbGB30TchWcFFjCUzuh8ifc2dZqqzlzsWDlv3vYD
         2sg8RXGJN9yWdjPC6bRugrK60EQRAqZen7CXOJIO7RCypGY8rJq97cMn4ufk72PjBhsN
         GHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924768; x=1769529568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4JbmK/RJvEWmpHkRk+ZhC+1Oyd2c57i0SiusSqSY7AQ=;
        b=WX2S+lxzQh1QgQW3xYPAxUxvmSzPy0QnHhTfLcpbZKeZ60sUUPPcyxAgnhIzjilMD5
         i/jl0/9TAUF53B+nKcKp1Ks6SDaRyANuax+11pTLM+SM6V1WRAX+atpih5XZpewuqP40
         zhSR9dXnnZ/QJTnAAhcgqGQkwtCl0DlB7HfclmTTyMa7ZZJ0YyyZ5rlj+cgGhefiBnU9
         kGkvQUh3zWA3fpiLnFRlGl+dsXopzdIMnAVU3xjCHGrQDCW75Vp0z9NFydvkSXIdVyDJ
         2sdMS2QmBZWtjrfYbsr1pHQdFXRIstvYE/cdP4ABdumR+av5wD8f7R6L1rgI2X1UPg77
         gTEA==
X-Gm-Message-State: AOJu0Yx57tPxC+b6BCEMNL9/f7iVflhKBandUFGemkqARJ7PRqIgAqwN
	OSXMpey3EKkINbbZ0g8EIX+8nDOz811WuE9wI6rPMI9RyiWppDSnjBjV
X-Gm-Gg: AY/fxX5jGILeE/mJJFWH6wcalFspqKNtD3Tw73otyMHtcvDk3PC+AwUP+fq/f8I0i+2
	DlpgCP3gGjtVpF0HEfZ9aRv3XRrWuI/n4JGkq1WWAfiFfIt8Rv973hJNdj56HPVxQkDJQEW69lK
	PSXM7bgemzl0nsPqu4u8mJyB1C41yq+hcnvOVAodpUppHihqQdJdkUXz/gXYJ9uJg2QUtNKVLaf
	Fep0w8KnrzAfIzEhcR3QrSjZBZuC6BioOHovNH6S+BkGDjGxayz8bAU+s9G9Bzg0hPuLf2YBBTS
	xI1bl+pWITQLj9mOL9NnDGAKanMrDIVwocBWKKHmBqfis4iNUq8sB024EwElrQpor56RzohHqXA
	/lPBFhsej4xpv4j3C8Vp6fQk3lCPnWvw9s8XZhTRtkyZRCvXcNnTnqqYcRyg0KJBjnoM0p7E+/Q
	oDmw1CtdgNioqrbB45QAxVhePE
X-Received: by 2002:a05:600c:3581:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-4801eb03348mr220157725e9.21.1768924768341;
        Tue, 20 Jan 2026 07:59:28 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997df75sm30285728f8f.29.2026.01.20.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:27 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:11 +0000
Subject: [PATCH bpf-next v6 02/10] bpf: Remove unnecessary arguments from
 bpf_async_set_callback()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-2-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=1646;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=r2UITbW0avcD8EPt5OHr+nR3+S9ZgpWwFjHyPTa5Mq4=;
 b=pMvfgI2PZlbITb68i55U11yoefoQwmSEGTbiSBdnvRC0k8ZzoDR1zgBdgLkw7sLnjwLa+yAxQ
 c9UAcvDWcEwCRhGK6cEPVehz78z2ojf5B29cfqcRANXLh3aD9wm7Dgm
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79646-lists,bpf=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 7CE2047F6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove unused arguments from __bpf_async_set_callback().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cbacddc7101a82b2f72278034bba4188829fecd6..962b7f1b81b05d663b79218d9d7eaa73679ce94f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1355,10 +1355,9 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
 };
 
 static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
-				    struct bpf_prog_aux *aux, unsigned int flags,
-				    enum bpf_async_type type)
+				    struct bpf_prog *prog)
 {
-	struct bpf_prog *prev, *prog = aux->prog;
+	struct bpf_prog *prev;
 	struct bpf_async_cb *cb;
 	int ret = 0;
 
@@ -1403,7 +1402,7 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 BPF_CALL_3(bpf_timer_set_callback, struct bpf_async_kern *, timer, void *, callback_fn,
 	   struct bpf_prog_aux *, aux)
 {
-	return __bpf_async_set_callback(timer, callback_fn, aux, 0, BPF_ASYNC_TYPE_TIMER);
+	return __bpf_async_set_callback(timer, callback_fn, aux->prog);
 }
 
 static const struct bpf_func_proto bpf_timer_set_callback_proto = {
@@ -3138,7 +3137,7 @@ __bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
 	if (flags)
 		return -EINVAL;
 
-	return __bpf_async_set_callback(async, callback_fn, aux, flags, BPF_ASYNC_TYPE_WQ);
+	return __bpf_async_set_callback(async, callback_fn, aux->prog);
 }
 
 __bpf_kfunc void bpf_preempt_disable(void)

-- 
2.52.0


