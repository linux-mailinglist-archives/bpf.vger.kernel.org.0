Return-Path: <bpf+bounces-37106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9955A950F1E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AF21C21AA5
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F311EA84;
	Tue, 13 Aug 2024 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O/UOcICH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289443155
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 21:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723584274; cv=none; b=uNvO4sXc2jBrPy/axgkVIw9qORI2y6zQSspdO3ooRZma+IVNzexlyCQjMQvZuxtXtEGz8UecfN8kEQj7WTsHsMuJYAQBKbiAAFp6N+lju/xVdhwJXbD5+YsqsOdPafm79SHlBnuk8FgOoTquGH58vw6eMTRtDX6H7iEsLW5Kx+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723584274; c=relaxed/simple;
	bh=jMdhYVwjomP9CrFL2w+7rS734zB9bEh9rnY1Yd9RqFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjVQKaS4X49xO2VgbQB6rD/IgE+JlnHQfl0wyq2x8YJ3hgo0+yv0baxgjUbzvANUldVEcCphRys6XQ0R81Q+ROplbLGa3v4TdTFDT2Ka+pisvz6kfcJAA9ZQYT9rudJfiWeR89sVs4t2DC+dwFEzwmb79ABOnphl9EgEah+7S2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O/UOcICH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0e88873825so5859099276.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723584271; x=1724189071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWxNuRa0wj8S8v/LOzoSw3WgU9BkUVUiTpq+NL0RSZI=;
        b=O/UOcICHTYHJwXeFx3AmivdvPYd4oRQvcVFRwoG9to3shU+haJElYgtsFMzup7fSTp
         VGXyxjNYnAhxcjI835ds8hvbU/ihmw9GZSFMIpURxEkEKVmfcwYUDZ55LoNqMHsp6bJT
         0w6rrOGRg8h4CJIpy0evp8fqQ4uQMVzSojwIH17wtZXK/PaLkjOI40mYNYCYrl8DpfMk
         ebVeKThLSmHsTIsr98/CLtZWW0wBk+88mX7edX4PqQLZXqLgr7uZSiUst+Qi4Ftb1RYg
         ze2y6Sn+MfUXxVXPSWmKwjQJsNXO18HmffdnPMeIRGMGtQ8RQVOO23tzzg6RJz4OxvOA
         skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723584271; x=1724189071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWxNuRa0wj8S8v/LOzoSw3WgU9BkUVUiTpq+NL0RSZI=;
        b=Figm+EbBtOiBdhDeGO296pyJKaR7f1sXlaMDPanLyT4ZmcTwlt4T+PZfoMEfI7PszU
         9Fwi9Fr9tp7YyXgXkshMPi3famkGZ06ul25/5OLr1lk1Cak/GsagyfllPGozVrjgC0V1
         1f49SelqDmviN0LbFu3915P+cSus2e0p9vQ49aR9vCTEkbHp6K2XjlrJEQko0mgxU6Xr
         hWPRnY/5Q3MLV3r/nMLzVTnQ2mQz8rsMa8OAc7moEgIQRpmhcVd0gs3RfdzEEVSCjlfA
         dq/DKGsfor6snTMUK/5QK/glrBqv0x8HpqT/fiEkhLUhkekgmCF4NaF65Yxbug41hdzr
         V9oA==
X-Gm-Message-State: AOJu0YyHvkh4BRFjrd+C3GkI2y9UrRyn3gm6F8TYF0n8ZdY4Ae9VFGko
	TGMtiiPIkqFYbZgVxDMWy5xQBAtePCi/RQQCvMxABDKFZrmxH9k1EZ+eMzNeS0IP/JeYVfb40cP
	1ca4=
X-Google-Smtp-Source: AGHT+IFVRgte7lcTqZ4sDEteGXsw9tThPddTYjz9atG4v5/olvXu6Fdby1Ey6rnP5w6gpNbskjMVRA==
X-Received: by 2002:a05:6902:1881:b0:e0b:5b37:d0c9 with SMTP id 3f1490d57ef6-e1155ab1330mr1125143276.14.1723584271407;
        Tue, 13 Aug 2024 14:24:31 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.116])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf432fb61dsm21390786d6.52.2024.08.13.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:24:31 -0700 (PDT)
From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH v4 bpf-next 1/5] bpf: Let callers of btf_parse_kptr() track life cycle of prog btf
Date: Tue, 13 Aug 2024 21:24:20 +0000
Message-Id: <20240813212424.2871455-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240813212424.2871455-1-amery.hung@bytedance.com>
References: <20240813212424.2871455-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_parse_kptr() and btf_record_free() do btf_get() and btf_put()
respectively when working on btf_record in program and map if there are
kptr fields. If the kptr is from program BTF, since both callers has
already tracked the life cycle of program BTF, it is safe to remove the
btf_get() and btf_put().

This change prevents memory leak of program BTF later when we start
searching for kptr fields when building btf_record for program. It can
happen when the btf fd is closed. The btf_put() corresponding to the
btf_get() in btf_parse_kptr() was supposed to be called by
btf_record_free() in btf_free_struct_meta_tab() in btf_free(). However,
it will never happen since the invocation of btf_free() depends on the
refcount of the btf to become 0 in the first place.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c     | 2 +-
 kernel/bpf/syscall.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..deacf9d7b276 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3759,6 +3759,7 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
 	return -EINVAL;
 }
 
+/* Callers have to ensure the life cycle of btf if it is program BTF */
 static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 			  struct btf_field_info *info)
 {
@@ -3787,7 +3788,6 @@ static int btf_parse_kptr(const struct btf *btf, struct btf_field *field,
 		field->kptr.dtor = NULL;
 		id = info->kptr.type_id;
 		kptr_btf = (struct btf *)btf;
-		btf_get(kptr_btf);
 		goto found_dtor;
 	}
 	if (id < 0)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d51..4003e1025264 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -550,7 +550,8 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_PERCPU:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
-			btf_put(rec->fields[i].kptr.btf);
+			if (btf_is_kernel(rec->fields[i].kptr.btf))
+				btf_put(rec->fields[i].kptr.btf);
 			break;
 		case BPF_LIST_HEAD:
 		case BPF_LIST_NODE:
@@ -596,7 +597,8 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
-			btf_get(fields[i].kptr.btf);
+			if (btf_is_kernel(fields[i].kptr.btf))
+				btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
 				ret = -ENXIO;
 				goto free;
-- 
2.20.1


