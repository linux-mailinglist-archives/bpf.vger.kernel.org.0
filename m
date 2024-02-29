Return-Path: <bpf+bounces-22996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DA86C13A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 07:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D84281B49
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1670481B2;
	Thu, 29 Feb 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALSIISQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1D47F78
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189131; cv=none; b=Wc3/3g4rzJwHLWvXQ0w7YAHdky86OR/XtpWyNvc2mbjPdtH2fp+/dVN/NGbVa48xhy0f9Awfc/S9i/A46Fpk6C7UwHdvni/5/lZ+TpzVOSM15SikfAqnEqCH1hNZQVYMw6nFun5qDYn4xJYMseMYJWBfQkZoyRGqzqBe0NQ0rCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189131; c=relaxed/simple;
	bh=DFX+ihDo2Zn7mJTEEux7j4QOeT4Apcu3M8CrgxfyqvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RqmVkfg5jGUBkdGqJR8llouLIIi+PNbg9Vzq5WP+j21sJohKMzXvKzWCyxYuO4GedRNR2armV9E6R9HNWBYyX4I4vLVKx4EsQHNj5XgSrdd/GTxk/WjgidqtSn8rmUkQSoDJWTD1fO5qyL97LPoGuz9blpH4+z6lLtPFaw0+ekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALSIISQi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608c40666e0so5804227b3.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 22:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709189128; x=1709793928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oo5m2I2ifSRO9gRtoJHToYuPS7HsymoHDVePc8UJK8=;
        b=ALSIISQihyHv8sAKkqzVj6WgHwqY7xL6pwtfzrAwr01torl+nv3u4FvHhrtSoFKTcA
         mcJmftA+23Qpfyp99cqkMgpoSnEWuzHJZPP6tthR79PnhDaV7HoClZwKGPXuWOr0aRbg
         ESDNoOOhnKXnSUPsDX198OfLVwpI/avn9O4v0/augMm3dm2lZhd1PCvEV5nqSYVU4s7w
         v/6XLKXuHSCsEy3MPrGH+jc1jjEwoZyAC0eo5jteUpQy59jKOxU5EVu5Fc1tDdo95kJi
         jWZFK9bb6ZdzowS4mubJXW0JlrhWQmN0e6JimD53+JBBniVprD8QBt5NAq0/TsaXccJd
         d96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709189128; x=1709793928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oo5m2I2ifSRO9gRtoJHToYuPS7HsymoHDVePc8UJK8=;
        b=BiK3A+TpU/E0wDWl3Y2Qag1iPPWj6oT8UKR9ECo3PPmPeyT4sbqYEmZ39FH47JyFuc
         FJdK0EP4/z7TqrpECnl2eakliKB12aqS77mEuKQcKPz2sGO+z+ZZ42wh6BkF+G9f6ugp
         OG4mQiwV+QzRwWO4vGMFyI1odi57vxXn5dOh3wEjX/vU8bEpcmNG0L7Mgr8tXZWhdR+i
         LmHmcH1wKHbbCsjEvW4hfpDLXW42/3NQ3B4i/VM0l0IqPipQm22WhB+IvH1b2jKmahg3
         YD89tLyMhYXKuV9t45HCc8Fs8fUQgGf5Gj4BsHqzuQPE/jrxE/tILbHOS+eOFpXCnGk5
         setA==
X-Gm-Message-State: AOJu0YzW1fo2zMaHV/9q6k/SyRa/TvuYTBExdzWsSkvqUlf+7TbZ9zBg
	ZSnG1l7rq5pn66HVHz93XpkJsHENWiA40u6bYzQzUYMUYWOfXnUE5hW6jPK9
X-Google-Smtp-Source: AGHT+IGThTmpWDRxbQ6edvGWfj9YVn5S0BvOiH/vAV6gQkQuMmxlXS+zVmzz8TjU0FLQnfkwj3H1xA==
X-Received: by 2002:a0d:dd97:0:b0:608:b2b4:9b13 with SMTP id g145-20020a0ddd97000000b00608b2b49b13mr1391729ywe.27.1709189127954;
        Wed, 28 Feb 2024 22:45:27 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc86:35de:12f4:eec9])
        by smtp.gmail.com with ESMTPSA id p14-20020a817e4e000000b006048e2331fcsm208581ywn.91.2024.02.28.22.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:45:27 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 1/5] libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
Date: Wed, 28 Feb 2024 22:45:19 -0800
Message-Id: <20240229064523.2091270-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229064523.2091270-1-thinker.li@gmail.com>
References: <20240229064523.2091270-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a struct_ops map, btf_value_type_id is the type ID of it's struct
type. This value is required by bpftool to generate skeleton including
pointers of shadow types. The code generator gets the type ID from
bpf_map__btf_value_type_id() in order to get the type information of the
struct type of a map.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..4c322dd65e10 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1229,6 +1229,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->name = strdup(var_name);
 		if (!map->name)
 			return -ENOMEM;
+		map->btf_value_type_id = type_id;
 
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
@@ -4857,6 +4858,12 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 		create_attr.btf_value_type_id = 0;
 		map->btf_key_type_id = 0;
 		map->btf_value_type_id = 0;
+		break;
+
+	case BPF_MAP_TYPE_STRUCT_OPS:
+		create_attr.btf_value_type_id = 0;
+		break;
+
 	default:
 		break;
 	}
-- 
2.34.1


