Return-Path: <bpf+bounces-79651-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONq2MePLb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79651-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:39:31 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3894999A
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9EE8CAD8A
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64C8320CA3;
	Tue, 20 Jan 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng1dUEab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1131D375
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924776; cv=none; b=RR55kEglr9xryovtXfPU3DPR5p7c+BEriuxPW3znBdd0V2hQTDPNFnRsaH+PWj6d9pTMJgmgFfmd5B4frq4w10tQOXIW2NBzzshVG/gbrQQPY40xUHqd6BRg08ub4hsFYP3Ui9++CaUvfcSjR1IcnwmLgs+iqM8y3WtIQ0vRTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924776; c=relaxed/simple;
	bh=VT3lkObv9wc/2yucsktqjX5LWKI6++1PvfOcrsr0N0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAhcZxYXzo0NYtKFnJxnO1f2D32iQh5Mdx0yb+9Q3JkiWGf7es5NmLW+uyvOyzz3D62v/Ob5WuU8WBqxXlhybudY78nbO09yt/6koB3UOItGxZbTstnvcYV5R00xhC3T8JnmPRUbrNHS9h0E161fo9mS9Jz8mJ/TjztONAhQFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng1dUEab; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359108fd24so454397f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768924773; x=1769529573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn4vtjS7QPs9576AvBT3MSfvVWPawxdePoL0QKSjiR4=;
        b=ng1dUEabthO9v+woGfu5gJy0lVmvZmsJAW9CDVeo7vd2XGJjuMp8ky8gGJT1rT2vvN
         qi9N9TEkCzZcivXEWgS2MNdKwS3UkPG63AtIq4D7C26wWnGu8Sg50AXgEKZFs4E5WqaH
         z61miERoOZzXX7WkR3phXDtLhPrdwBg6omXZRG5imF9SgJHt2VdbzWGg7xK57nMt1vSP
         xKzFap82VpFYv2R/NZL+ggzocBLM51zwMC11PuAnuyJ6Bv1teKRmtv+cupJM+HAXMyoj
         7HTx4cLxGxYnhjVOtsBLfclHSUM6jb4hHt2bt5aHQRqvi5Ua7284XoLOufSSe2FGaS/Y
         HXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768924773; x=1769529573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yn4vtjS7QPs9576AvBT3MSfvVWPawxdePoL0QKSjiR4=;
        b=FlueATs0ZU8k/TexhK/HP8UHANSz/YT3atRLHLuSBHxPAiH+erSBdFnbcRP3WvJrjy
         hTlTtirgUylHGPJmJZY7H8rNkZ0QAKEINTf4KTAajU9Icn+8P5ZO34uUiIkMTgGZ09Ct
         db8mcfIDmLE05KAzpUQZxsmnSLUwqxSwNT3KOvyiJu0pKBhl+fSideKlC8XhXlNWtJ+E
         WK1PCYYtBqe5eXzrAQHDUu/vSh7daOZui084kP3Z51H7/zduTVmjywZzwfDpTBkY8ilM
         5eHMkjUyi7tRE9wWo+vbNX9rIqvVO2pdU3SBhWeYgm21xoYfbDjnuqK60WOzxc1z1khO
         FJrA==
X-Gm-Message-State: AOJu0Yz5ds4gh1+LywYucgNv663zgT9wY8SQgSf0+dOyLbR1SyalvQwL
	6nY2ZTW4Z8gbKfqurEWtXkg7Jz/5QJCShG1fD2uqLXev9B3MBHRD1eYa
X-Gm-Gg: AZuq6aI5aQr+RCGYzRCsQdKXUIkSKXys+Pq91lfZnYEV1rSBT3gz80gH4uNZ28xUBIS
	npCiSFMzdcM41GSAC70p2FhQGo9EuEuIpcjNxUPxWDMxC2/LPaLOnDfVVW0ka+hB2js2aLNgMRY
	YxgLFeunKl9b243Lh3UhlYVJ2IPwdRmL7bagdTlp56tOjikelm7cJcZXPKrn4gq/mV9BsQHjnUn
	jUfLeYakf28eifve941bCLC8I1mDYyXQXt3mo49sVifWXMOlTiZl34b1NOWX3GiaFTMPuPP9lKX
	mbdFx6hspRTNGKnArdWGXOpxZdUkmSdKRtSpHA9pKr1B+8jGDaePPl0Q36Sro9BEliISYSGShPw
	4/qy3vU7ZmUeK+ejyltii519SBAXehrVlQQnBcrV84WzEYLOZlaaqJOVgvohke6cv6VQt4Ysof7
	cF8odznQdBIawPtA==
X-Received: by 2002:a05:6000:3109:b0:430:96bd:411b with SMTP id ffacd0b85a97d-43569bd47e7mr22181158f8f.58.1768924772929;
        Tue, 20 Jan 2026 07:59:32 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm29513207f8f.4.2026.01.20.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:59:32 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 20 Jan 2026 15:59:16 +0000
Subject: [PATCH bpf-next v6 07/10] bpf: Introduce bpf_timer_cancel_async()
 kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-timer_nolock-v6-7-670ffdd787b4@meta.com>
References: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
In-Reply-To: <20260120-timer_nolock-v6-0-670ffdd787b4@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768924764; l=1347;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=y2jTZOKHHT4CaVUapMPQ7MROns+nzqDKrEL3NPsA0VQ=;
 b=krXBZ2MbDNIMMiLbw0d5nUnl9RHC4yJlLVSgBzJ0I1e1uh00EH/qUZDjsCNzLEJRK9oaURQy0
 rd+0ULHOFp8C59yn4eVdRaHndJOU70ElygubhMb6niH7WGleHVCFreF
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79651-lists,bpf=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 5E3894999A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 297723d3f146a6e2f2e3e2dbf249506ae35bf3a2..2acab81599b6d9f4dc6c5ba636b9f9bd46be9d81 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4425,6 +4425,18 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4606,6 +4618,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0


