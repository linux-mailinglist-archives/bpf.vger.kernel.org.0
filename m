Return-Path: <bpf+bounces-60113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C08AD2A82
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233277A17EF
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5964822B8B8;
	Mon,  9 Jun 2025 23:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS9W9Zak"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42F22B59A
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511672; cv=none; b=dTRw7QJvqVhUHfCz8M5Q+hJGddrGi17FG2FW+YuWdx9I/ZjA4ygY7k5AirmNCZ3DnzX/VS6ocY380u1P5RvIu0Vt2F933k76nsGk9X9TugY/Yt+j5ZHXtp78Hc3iuuNTTRGiA7KcNkzLEjTHEsnhc3unBXHNRPc6GA6p1pbiGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511672; c=relaxed/simple;
	bh=T6BtH/CwOqvXgVgazN/uhHVUV8bDNYDAcyAfUK3aMR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+1HZ4jWqZxQxKwGdDRnv/6OipjXJVazQ1Y6mIuza55ygaT+qVVfGI9h8zFdLR9PQAhrrjbNwFkhBAHdVuYRZyGauAWaT4rrrNsIr5Xz2vnbsu0wkz80q2tsN0ejSTnveq/2qVGEkcfre7O1aiWqXMAZmRc5b5qLouCRh+Q95tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DS9W9Zak; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236377f00easo2066905ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511670; x=1750116470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQMBVI3mTQDa8X11nRb6ckI3qCM5vsjq/l4rlnebqfA=;
        b=DS9W9Zak0Uu51XxPwimnQJ96w9hQi7TApGdWfMX6ddcHM/lV2Pl67jxnRfov2wBIOG
         KbgUQKDoeW5N/++2NWJyfA+OCLBY6TSAs6fHo5teKu+RebT1VLPaLMofo+OLf/LzhCOv
         NbOR66jesj1iHJ42IZtDF8X/Q3J5PWZWJGKA2fL+rfFZlyXAUA4mXbL8GtvWMbpWznH8
         CN/OfEYcZqtV4yr7ghXyMEJAUqPqKkrkR0R9z+8E4mFvOTGNFiKwRw0gSLRInutGcV1K
         0Mix3awP2OhzRqi81pbQ81hmBEFjqC73cX9Wl4zkQa4MVtyCtT1Ico7IT1JZWvvqMZBg
         d5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511670; x=1750116470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQMBVI3mTQDa8X11nRb6ckI3qCM5vsjq/l4rlnebqfA=;
        b=Zkzxb+jTFylrpbPeBTOkB+uZkJ4QYIwzf+rWBJi0DO+/KZHfBvK44Zzs1htW6hxlNn
         HUMc15HDXiRsBbGxlNesxCykPYNJFmMgRVO/7okIEwBVyiOfEQUHjQd2eEKhjVMJBYfL
         q87sQsURRZGP7qYBbMX3O8H3V3ZXjVB/+FEML/1HFh4xREXdtzplVlauNr3t34ZP5adx
         oXRj3Esr8pMZjSUIh9FrHHIUqCvkDJaAnsO46VGfPc+L3dvYO5uicNvPGlJZfJvRILi/
         IbHWR4t4BVrePDDw5ZFA6FhKH+2auOg0D+wrjEoMT7KShh1gwdWexho0ut57kKwSem6Z
         LVpg==
X-Gm-Message-State: AOJu0Yy7SkKpOD9MBXLu7DqUjvVC1Z2C5SfetOOgUzX/fNYTIxLJzLE1
	8b+ktS3hCKt8HYwi0aVAIU+G7WxhTW3ztG+kJh8RsV+Xmz5YOQqtG2WbAMOhfw==
X-Gm-Gg: ASbGncuGH2IQLoeOBkb2joMxitgbr+Mawu3sKUEp0/LDhlIvtpTv9pre/Zi2fbycZu0
	P+WnpuZ5Y1VKnAjT+b+OTks6W7VSBHKUX6cSLZ57bjDEBgbaLl2jcK0QMaRSCHklsBTjjYwU/bE
	2TY9WpcNryEcBHaS08X66/6+RGGWRc0KfngiQ4iKqMQzuxYpS0GDYWFlhrP7pug23HJcXW5tgQI
	vNe0Q1jMErnl39meGoQG+fz27GJzzTByNQPj1zZUIyY7Ksd/gxj1oq3PXDl7es08ToZ0nmuZ+fS
	CEYcrmnwsaB2NVIUQTHuBSR1JdBc8w01DSZtTBdrMzUrGRa2ayRg
X-Google-Smtp-Source: AGHT+IEXsvcPOZhI0QzfiJOb00lW5emMvXHsSVLjcnO+OCJ7I8QYV0UEU9fc7+7OXbhMKUx91HRJOg==
X-Received: by 2002:a17:902:e890:b0:235:e942:cb9c with SMTP id d9443c01a7336-23601ced1e1mr213580355ad.5.1749511670505;
        Mon, 09 Jun 2025 16:27:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603096829sm59742505ad.75.2025.06.09.16.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:27:50 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/4] bpf: Allow verifier to fixup kernel module kfuncs
Date: Mon,  9 Jun 2025 16:27:44 -0700
Message-ID: <20250609232746.1030044-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609232746.1030044-1-ameryhung@gmail.com>
References: <20250609232746.1030044-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow verifier to fixup kfuncs in kernel module to support kfuncs with
__prog arguments. Currently, special kfuncs and kfuncs with __prog
arguments are kernel kfuncs. As there is no safety reason that prevents
a kernel module kfunc from accessing prog->aux, allow it by removing the
kernel BTF check.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6d3655b3a7a..54adb479315b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21467,8 +21467,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
-	if (insn->off)
-		return 0;
+
 	if (desc->func_id == special_kfunc_list[KF_bpf_obj_new_impl] ||
 	    desc->func_id == special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.47.1


