Return-Path: <bpf+bounces-39080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302DE96E5CB
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519A1F24971
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2F1B12E1;
	Thu,  5 Sep 2024 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTfURdRf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413091A704E
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575902; cv=none; b=pguB+mEDyncP97ezA9IGSWS25B96oc1smMmDDT7kd9liUWrh3M4e0HzsFLEanA4YpwNVJEEu4lUMh2yHB/x3zso/JIaWKeVaPsHpLLEAyrvCrmxIKa1WkyFeWrL3lpdutvwV9tlGP6iNx0T9bxeh2+vkyWt7sHqyAoqpsezYrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575902; c=relaxed/simple;
	bh=8jeGWgKOQAXE5VjCyaCwaRNkb2W3U0U4kfO6EmbwEy8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0J9PPXLSXQn1AFs37BkcGkNi7O+Bdfb7Q6/VzQYlkti+sgZF86ilsR15I2TKM7oW1LYX0hNg3XLBF5W0uxhe8fG/1KzjRORRLOf7lMcjYX962jHMQTygeApIEp21v2Z0T5ivgDvUR7tsqzbUTSXzHFqk6xZnyhIMm4mcPzYioE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTfURdRf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718d704704aso111885b3a.3
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 15:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575900; x=1726180700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubSsd2Xu3Qm5YFUYkJEW6g7MTtn59x0j0GaDeBbkL0o=;
        b=dTfURdRfrMOE4BnD7uCb3CmotTbluZdhsJFxwWzRh/cUUH8nKaJBZk7eyHe6Q3xmsB
         cUDa366kqLXOy+VG7Ts8yMukq4GIQbuvnCKE9kZ6xbJaQUdAEPfZHlpTK1urBZH6o2hr
         pu8bPrCaX9+OjD825MCSHznJMhTZEWOpEESXrsasX4A3bg6fNFvF/ahZOi+VEuQ20TC+
         5qYkNXV2yE7Kp8XXcyih+5gEujBtzNr4thwRp5mHz7ad1kp9y+sODc8phS0MR086L44a
         6wiLy0BsmJZlpLzFIA59ScGY2pY+lhtMcKJJ040/n5oYNn2bBYEi2etwnIVd9oSwU6Ds
         oXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575900; x=1726180700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubSsd2Xu3Qm5YFUYkJEW6g7MTtn59x0j0GaDeBbkL0o=;
        b=UtO9dIi++GCBLoNNHaMQI4GS23oivY7boGMRZaK+80THvbNjedjaOgwTLMzgVyO/Wt
         o0J43MKZ60JzHE+mj4oNmpR7wTo3ZnFSfcFsSGSbEF0u0JjGFeKYV2I+L98epFPqefUw
         WkdK/MURhX78e0XEQYhtd+jWXjcdqXamvIjvoaEgzQc3ibQJwv8qPPdY/f8bvHZo2oa5
         ymRTdNqfdjqigDkxGzAGrIGIVIIb5OPjR9dxmSUxkQtTmhV/jVZV0qV8ObPjG14eOgYW
         fOUFczFwW2O9TrCsV3VW/NIU0wmn3+sUfA0okfgXfwBfZMelmO3TiV63Rao0VzhKoNAn
         4+nA==
X-Forwarded-Encrypted: i=1; AJvYcCURC/AoSKEwMLq/4QkShnQAMGXaESs9ph/ZuwNn3LYGAvWrnEhIZjs9bhnYV+RcBqGrnLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4ZC5vPOE+jFoW0TCipxktEx9TP7cRg8CCWwBtFWzHEXyytnv
	IiyBC3hQRBBDV6XI/GrJuWh0OqimFDhqJn+kqup1/4E/Cb41qyV0
X-Google-Smtp-Source: AGHT+IHMuA/IuLbB33tq1u0+c0VssrqVj0XuQthYsR5pvxfL+OZu9PyUVQSpNTsW8HGU1Zx65ffm/A==
X-Received: by 2002:a05:6a20:491c:b0:1cc:e43e:3a01 with SMTP id adf61e73a8af0-1cce43e3e74mr20924929637.33.1725575900413;
        Thu, 05 Sep 2024 15:38:20 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505acsm33067225ad.66.2024.09.05.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 15:38:19 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/2] bpf: allow kfuncs within tracepoint and perf event programs
Date: Thu,  5 Sep 2024 15:38:11 -0700
Message-ID: <20240905223812.141857-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905223812.141857-1-inwardvessel@gmail.com>
References: <20240905223812.141857-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Associate tracepoint and perf event program types with the kfunc tracing
hook. This allows calling kfuncs within these types of programs.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..7d25ecd195ba 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8304,6 +8304,8 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
 	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_PERF_EVENT:
 	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
 	case BPF_PROG_TYPE_SYSCALL:
-- 
2.46.0


