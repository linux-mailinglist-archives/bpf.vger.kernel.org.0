Return-Path: <bpf+bounces-65141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3FFB1C9C0
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 18:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A166216990A
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235D29B200;
	Wed,  6 Aug 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm4oc2ce"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFA2989BF;
	Wed,  6 Aug 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497546; cv=none; b=qQ96q7+NOFOFo1tyj90VPAcTeG3xU3p08vIEt5igSLuua8kAY8pst9hV/unHo+nollPn2INS0GPqgj8WiTRF5s7PCP1VGCZGJAd9fblEx93XzjQQtKUZdR38czvuo2Fk2cIT+T7qfK4Ht4ZLStWL758xQrkErI6ZH6QOhb0ReMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497546; c=relaxed/simple;
	bh=2xzEIs+ySHsgLAvE5FdVLnku2MAQDIrXHz8FzwKo8Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcIGKDIkQk9DqTRTMZuRmopig0oBBe7mwu9ZJIXzimfEtoN4I/cL8LNbN8l1C4HvO7nWzNhUfN9+QKHl6/cjsNERV104zvtk5HuYLhL3/eJdj8J0ueWxOkPCZrxlp+SiEMe03fk6AhvaWzf52LfiXcn7Zo6scXxslzYpiVcT2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm4oc2ce; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so4277088a12.3;
        Wed, 06 Aug 2025 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754497543; x=1755102343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QPNql6Ck4jlunvfI/4/5xCBwcdX4JNF0tneR4UWKCs=;
        b=hm4oc2cebi+4xrvYVbq/3F9nm3aWznETJ8kspZwva3jdp6l4165lVaEt3CGhct5QZZ
         Mu0A6K5IzexUu58mWP74gNkUjksQ6Fp0G7FtteGBWWZPcsJsQt3kVRKvwY9rFW3W24kv
         Yg7TW6WzcLQjnW3dwdaEs3AbM3FZIYv1+wZJnTdkyW5W3cw6F6aCwiBnowZzhE41JkF5
         MYxkJgufg3XarM2JIx0MK8PvE477SBz0FRCkAvppskIIaEkNy6ygeab187p+7DgY5U6s
         o+82qJkUwqHGc156qa6EScAT4BAXBcw0huctxbjig7IBsObEBU29VqSy6XDj2JNvRQts
         15uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497543; x=1755102343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QPNql6Ck4jlunvfI/4/5xCBwcdX4JNF0tneR4UWKCs=;
        b=T+KBZ35QNUpjZJwUhZh7A/wXTo2kwLd/qnemlEgcYh8652wYdZ1PdhnRoYB6SDgR+x
         ht6PS7uXJVNiuBFYLetHoZqf52xtKI6maJfcqaN5TaCr71sInDHxJE8I49XjofyiSbIH
         gM/9QCD1kgQJMci8siLYrNjKeXClAFqii1hob48sTv0fcGrmF1Zi7ICCTFrK9dB0NJZN
         WuaddZ7sd+v1tK3WyKbsFnhjXdR7K7izLKnTohvWrLjOJZ7F8UY7qIbvGcgYmntjYeKv
         DWcewcAeZTZ0mcAqS6t5qvU7Pxc5IE7j6uxaVf7zoaAAvfS9d/w5lRc7PIrzrGtPOgi7
         H6tA==
X-Gm-Message-State: AOJu0YwOHPUbsZfvLgCUbHGTdveW/vfJyYOiBzOvIKJc3Pr1Hcrm03bp
	joHr6hBKaNrh8y5BrrynwukQ7oXJutEomVJqvHuFUoqU3c0vLaGrw5pXoLjg3g==
X-Gm-Gg: ASbGncusSvGfqD8tLLZ0W1ocSt115NS3Q6dJH5eeoy4isd1PnymunU4t/mu65iExSsh
	M8p9Fk9W34oINWVWT0WpMcyd/IXHkX4I6i2AQEePkUf6LChv2GOh0t6Vt5zBbljJdu48Jt/DqnV
	Kr+E+N+Z/mhmHMXwNp8W+3V0d5rPbFFoXzhoR5B5OCPOFVkWzJrBYmJNjvODbT0hf4tirE8RqGR
	kNjg6ffCMQKKjifozOcfcLQ1VRI3suaOtuUywb+mXwyrn8vZnjap4KV9PK8MByd1UQLmAunPAd8
	WyTdxjIHzhrqkr2A3Rw3PtxWyzzR1oHf1FauiPJ50GL37AYVQth1yICVYhmOJPBY/XILN7/rQDf
	VTdvKVAeUUGDK6A==
X-Google-Smtp-Source: AGHT+IEm0neq/WbeeN1TuVmNvvlcfCCrcMGP9A7zye15Xdybi3+zjReZKYYgtrt3LCco6P1LZb2GAA==
X-Received: by 2002:a17:903:1ae8:b0:234:b123:b4ff with SMTP id d9443c01a7336-242a0adef82mr45715635ad.21.1754497543260;
        Wed, 06 Aug 2025 09:25:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:42::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f76bsm162788395ad.59.2025.08.06.09.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:25:42 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	tj@kernel.org,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/3] bpf: Allow struct_ops to get map id by kdata
Date: Wed,  6 Aug 2025 09:25:38 -0700
Message-ID: <20250806162540.681679-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250806162540.681679-1-ameryhung@gmail.com>
References: <20250806162540.681679-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_struct_ops_id() to enable struct_ops implementors to use
struct_ops map id as the unique id of a struct_ops in their subsystem.
A subsystem that wishes to create a mapping between id and struct_ops
instance pointer can update the mapping accordingly during
bpf_struct_ops::reg(), unreg(), and update().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..aa5347dee78c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1975,6 +1975,7 @@ static inline void bpf_module_put(const void *data, struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+u32 bpf_struct_ops_id(const void *kdata);
 
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 687a3e9c76f5..a41e6730edcf 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -1174,6 +1174,18 @@ void bpf_struct_ops_put(const void *kdata)
 	bpf_map_put(&st_map->map);
 }
 
+u32 bpf_struct_ops_id(const void *kdata)
+{
+	struct bpf_struct_ops_value *kvalue;
+	struct bpf_struct_ops_map *st_map;
+
+	kvalue = container_of(kdata, struct bpf_struct_ops_value, data);
+	st_map = container_of(kvalue, struct bpf_struct_ops_map, kvalue);
+
+	return st_map->map.id;
+}
+EXPORT_SYMBOL_GPL(bpf_struct_ops_id);
+
 static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
 {
 	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
-- 
2.47.3


