Return-Path: <bpf+bounces-37145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D00951316
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9781C21478
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA223D3B8;
	Wed, 14 Aug 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4mr6TJG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A712BB1C
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606218; cv=none; b=r/+jPP0fGI5Erk+lreu9r5mfjfCrXIB3bWG2Nd7CnmsFJMZTBI+e9J688JWKiL47cDXcLOSYCO/A0bGmwlPg9/NMzosTeQEf8hXlCsTcwqNN8It4oxFqRrZsAFvEelwar9cdf7pq4NdSlVFGZvRw837NrPGuYl/Wpx9mQX5P1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606218; c=relaxed/simple;
	bh=Wg4qmiKbu07OPOW7gvELVSHVyPKbKWmHubbg6/DTWLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0ykYV+SVyP/bfsnIZbfDw07H3h1V0x5sQVEFZkC/7ZcdedlKy9MzvUSpGRtEd1LtvFrzJOjXPiBu1H4k7IRTuCVq8Flyv1TcvxPbzkaiNDhEa1ghyRsvaeAgae6JF+6/J/9kKeHQJnL4g8RotMlCJiRU3o9uRfvyy8td/mIOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4mr6TJG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66108213e88so55030317b3.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606215; x=1724211015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbLF3v+0Qr91UjWGKHwc1e2DoPoHow16O9w04Ex1jM4=;
        b=b4mr6TJG9Ma6XD0wGYXQwdTE1nDF4qk2gI2/t25CXeC0YONPWqdeXbImbwe6XRV3wT
         p1N4zoC9Dp1Nym9e2uwd0cJku/M4hvfLFWMuFIG9wL3lNGOFyUh/ve3P5QAjSNW/xt4I
         6MAN7CFTVEL8iizsVRG7U00McA+t1kY5Q+Ke6TTQ8CyBU2aScw7SxtZnkVA0q/8HMEZC
         YMjML6vMan12qIB65uyTlTFaXznYVeM6uZjm1I4IsyShRjy24uz7una99FqF9JoxNRq6
         vRLGV/l6W294/rX7+AwQhmfB2X4CDgVWCFNqHmYs4NlJIeXChx9b9ig138YLZyPqFQdW
         qJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606215; x=1724211015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbLF3v+0Qr91UjWGKHwc1e2DoPoHow16O9w04Ex1jM4=;
        b=jvqrmHAnc8GWNynCi1G/bw9NPRCFv3URgNVh4WhqBxD5ls6AE2FbPYCmRgJzVejDFq
         KbnuaG4Zt6J1CVIvhnMyW7Vxk9jCm53Dul6Qnpap02390Hxy9bHBfadelmT5TjznmzLJ
         yjlK5X6ShDDyI5dj9N8HDIf/iaQUprmsUXSzZHu+OS1UA4XkF6tpt2tre1r1mq/+XBh8
         71XA86fTzQaLulEwXW8MkU/l/TKghFWV6AT28IEf5BIhIGUn8Ijwkdh+cuOs7lDxYkic
         QZ81HVc3t8Ee95mcUGOjy0+YT6tPONGKBEbJtGiPZ8CsH0OJCLraOtyryoVVeWJIaXem
         y+LQ==
X-Gm-Message-State: AOJu0Yzg8vwQ4MLa8aaRFQf893ryOUfXZRtBrNrFadBX4XJE5mI4cucr
	CS6w1npkYXSOqpiRMgTlFiKO79Qg0jYGQBItuDYvi07MKPnJKOwWfyUyvktW
X-Google-Smtp-Source: AGHT+IGTIpShZBciimQolUrUozrkWhFYBhHqtyVo5mwskzG2Ekiy5rjAxwnSTlVq5uOLMyXP/JVXZA==
X-Received: by 2002:a05:690c:4787:b0:65b:cdab:2678 with SMTP id 00721157ae682-6ac96bb55e1mr14475297b3.15.1723606215504;
        Tue, 13 Aug 2024 20:30:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:15 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v3 2/7] bpf: Parse and support "uptr" tag.
Date: Tue, 13 Aug 2024 20:30:05 -0700
Message-Id: <20240814033010.2980635-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse "uptr" tag from BTF, map it to BPF_UPTR, and support it in related
functions. "uptr" tag is used to annotate a field in a struct type is a
uptr, which is used to share a block memory between user programs and BPF
programs.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c     | 5 +++++
 kernel/bpf/syscall.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4506d788c85..9db3e7d2fa66 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3361,6 +3361,8 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 		type = BPF_KPTR_REF;
 	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off)))
 		type = BPF_KPTR_PERCPU;
+	else if (!strcmp("uptr", __btf_name_by_offset(btf, t->name_off)))
+		type = BPF_UPTR;
 	else
 		return -EINVAL;
 
@@ -3538,6 +3540,7 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			break;
@@ -3664,6 +3667,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		ret = btf_find_kptr(btf, var_type, off, sz,
 				    info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -3988,6 +3992,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 65dcd92d0b2c..fed4a2145f81 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -548,6 +548,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
 			btf_put(rec->fields[i].kptr.btf);
@@ -596,6 +597,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
 				ret = -ENXIO;
-- 
2.34.1


