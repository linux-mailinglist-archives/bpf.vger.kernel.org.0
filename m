Return-Path: <bpf+bounces-78023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC64CFB5B1
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 00:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 645EC304F519
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 23:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFB303CB0;
	Tue,  6 Jan 2026 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="DDR+XWbc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D62D7DF6
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742632; cv=none; b=qNhDhfoAkxe+9s1gtRzvsHsEaPywpUJe5vzZ+R4weEy/FKkGj8XkHvn99RReaZUs22DfzYQ812dHso0qgVxWJ2KPm1vC8EksD6xp25S08Nr/nX8XwjB9pcBVWboI7nzetSdA2DVuuwXPV7zfNHSmL1EuHCp6vk7i9UkFSojTptQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742632; c=relaxed/simple;
	bh=4orF0VFoVlgyE20ve7vnEJbQo8WlSXVCfqKF/5kORUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwxPH7FjhZwBL2HCEtIQKkAU5pgiU7xadB6Sa0M+xRyaJ9y2Dm7M9H74Fhff0h9dCb25FpAXapovngrtano0leqmGzdnH7g73Erik+n8rIE9PIk4/wQ2hWKotf6LZzEi133xx+yQ7Pbkg6fvIG8UG4jospkAQ/wperswlA9Kzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=DDR+XWbc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed861eb98cso16188271cf.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767742629; x=1768347429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bx3Sb+U9AcS65PTbSPsETeB9XJNjmwm7iKYzRjyz6Ng=;
        b=DDR+XWbc7wD0s3b2E+TCWxYMp1/bsUKTUdsqhnzni1+yyJ+N5mhG/mu1ehkJMLdV4f
         PtDMu49v5MMp+lVlAgIlp0sCIkVNfDI1rZaUN5HeojFxMzcA2sR7h6/g9HWhJ8HALXvd
         4IQg18vjXLuhLMkmCf8Q/d99aFe+I7sHa1/Nikr8KzrMXo6U874d8VMAkRgXbCgmnvYw
         2Nu4qI7U73uaywF5dtl7kHN82tkWCk2Zi7Q68nBXdtp9HE85iiwjru/Ip9Do2966ntyZ
         ad5123YfCT0F+C0za1CNj75R0oRE97MurCqFGu9u4GjDgWTs8k+xnfKInguXd/LbcW7K
         cLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767742629; x=1768347429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bx3Sb+U9AcS65PTbSPsETeB9XJNjmwm7iKYzRjyz6Ng=;
        b=DMhj5iJyRvLtah3srhaPXKPgPxhyjxKw9tkxijeqMMZbi1dkXHtDs401P4OKo+jXzd
         7Q9XJKIOlTm3TC54+5luw1H92dw2cgsK8OdPgRSHHcygcpmJEXLx1I/if+/gmlIaw48M
         OCf3Yqm9cp0C3BVf3b3Cn1gvAgruigOP/5yDnPvn1jSLG+yNK0xnq4/mRU3LeSQZDrht
         bhxp/joPbEzeEtmd2XDApmk5n0AIsEw2tL34KHenX7JCwGOtQOyUUhp0NSaTuWJB+Ph3
         n5zF+QwbtePH0+tTJ2jOh0jDylyCd71EtvBRN3aGb5SVoYXSiVcK8i2UDYf4RYjfCKTP
         G4zQ==
X-Gm-Message-State: AOJu0YzxpqZQb/CeRzEN3dZmXJ98Plb3K+jh313MJEsJfekkcV1pJcdi
	GXav1Fq1Cxau5uzV+L9Jo3FjPV8KV9O8nE8CuNypu4crikRdSWL6VDTrtLKlBHIgWT41qdGAYFX
	yIFESkNg=
X-Gm-Gg: AY/fxX6XUnsmsqe8/2l22bwnbQZZiYYnoLomihuFDp+tY6c01z0YE7LIqto0F21WVLw
	Sysveh+TMcNSyLPV9CRugqp7NAuaozLAsNkZuK78oBhFUoTF/yrDVPwO6gkrD7kSembvqFz1u35
	9y5FIzvCj0Bed9epN5vyQ0c4p9NPlb+Y1nRRKR00R0xyCVfRb2WrreJLJm4EAjCoqP4IEmcmluU
	sbP41JR+D9GH2Mlj72vzAexKleo0GzQW+LP3asBK3TI6FR61Dz5QGTzevbAxTbWWv7gRRg+gwDa
	qOCYT/Z2Wkw6iNqVOcpfjFUWKoFWoZChpGCKGsLu9/WuDHedCwBcZS5khy5Mrv4CP4I4WsO1yLI
	uoKNrlyPmVDYUDwK3T8OZBvlni3aiLQBCjknh8C7HROJsrZySMQ88WLTtLMzy5gAe9kbHsY6vQG
	L6yjQLTw90SAg2KJRI
X-Google-Smtp-Source: AGHT+IEldlL4XImBuFMAjBp4T25yUaW48TRNAyLVhtwzVD29cxk+FeX8sp2GoQG4qO902cy0mCNZdQ==
X-Received: by 2002:a05:622a:480a:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-4ffb47ed367mr11107161cf.13.1767742629545;
        Tue, 06 Jan 2026 15:37:09 -0800 (PST)
Received: from [192.168.0.7] ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907724ef8fsm22590116d6.42.2026.01.06.15.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 15:37:09 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Tue, 06 Jan 2026 18:36:43 -0500
Subject: [PATCH v2 1/3] bpf/verifier: check active lock count in
 in_sleepable_context
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-arena-under-lock-v2-1-378e9eab3066@etsalapatis.com>
References: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
In-Reply-To: <20260106-arena-under-lock-v2-0-378e9eab3066@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>, ast@kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
 eddyz87@gmail.com, song@kernel.org, memxor@gmail.com, 
 yonghong.song@linux.dev, puranjay@kernel.org
X-Mailer: b4 0.14.2

The in_sleepable_context function is used to specialize the BPF code
in do_misc_fixups(). With the addition of nonsleepable arena kfuncs,
there are kfuncs whose specialization depends on whether we are
holding a lock: We should use the nonsleepable version while
holding a lock and the sleepable one when not.

Add a check for active_locks to account for locking when specializing
arena kfuncs.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0085690b0a0052f82cd48d8722e89..7f82e27dd7e7c3e8328a5c4aa629b79db2dbe03f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11466,6 +11466,7 @@ static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
 	return !env->cur_state->active_rcu_locks &&
 	       !env->cur_state->active_preempt_locks &&
+	       !env->cur_state->active_locks &&
 	       !env->cur_state->active_irq_id &&
 	       in_sleepable(env);
 }

-- 
2.49.0


