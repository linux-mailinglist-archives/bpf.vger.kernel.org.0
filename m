Return-Path: <bpf+bounces-39452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32298973A27
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF151C20DAA
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5F19884B;
	Tue, 10 Sep 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZhnnAIg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29CF196D9D;
	Tue, 10 Sep 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979282; cv=none; b=PSG4od7FANea0qQ+D5pcMSskkw5z1T2tOblJeUpuacJWYYCOtPODUzfyqg+PKTZJckuYK1QyUw8jLLA+WnGkWaR/0th8WI6XBdt4B4td6j57d+zNrEfzYp3LJqOTPTa7p0PWd9Mo4KBVduQmxVwllKzZtaKo2vPE0Zte1V08q1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979282; c=relaxed/simple;
	bh=PpD05954nnxBVZxuYesivDXuQr5KszMF/qiXMGW+GF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMHVuzmIebs/Aa8O67qh6vbIwQZBQEa4pxCdCt1YMp+G3bb/AmpCqLNceilWkpyA8fvNEH5NGiPM0sZPMHtyvflP6Liuenzv7NPWTclDZqjp4X8QY1Vw67csG8haFHrV7uUVk9jAsEpQ4d2oPUJCEZYK6VnFGkqzbx1y8m8ay84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZhnnAIg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054feabfc3so50136465ad.1;
        Tue, 10 Sep 2024 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725979280; x=1726584080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAcIP6yyaAZJRPAhebVyDvt/NZWnopt98DEX8XwAkmk=;
        b=EZhnnAIgN3y/bFwp4vOVs7eDQA2iabFu+1F3wa41hwa6KckdDeCjIhCpqjRaUqU9X/
         /TL+/hvSxLdbDK0pizViuiVpdKg/qBWK5iazwfxXm8C5Xjj6dTY/RvRhBfJOg3ycUwnO
         hUzL8dM0spSBUjx5s88kchYHgINsM20YGVWl+CIm5K1+pvypKo88c3m62lcPg12XYq70
         3V27R6gtAUbCVcVoffkxgACQM5T/2Oxs3DHw7DSeAFZWcFl9LRC7+H+GHuu6oU5TYngv
         5kQTjTAYiaCEOj7rK2ynW7hycTk2/R5md9iMpovv78Ez1drOF9/V1yG/xnG/fxUgu+5Y
         isuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979280; x=1726584080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAcIP6yyaAZJRPAhebVyDvt/NZWnopt98DEX8XwAkmk=;
        b=XG+0PenK6fNjL/20W/bryzqzPBr5S24oieoIkGVYzzhG/Zo47ZuK3edXPxqB5pto+w
         PF9pISKSTMeIS8KZ71zhabnSNXNdrVqlq9fw6+9Am1c/6wLfxFxXq9CP2oTLFCkIJ9NR
         05+6x8BZQGcz3MApcDxl+zHl5fsQjSUuxn94WRm/l8T3bEAsPI7uCE4QVoiD2pjzZrJo
         cV4UVSZ1tbufavDmYPSLP/pdH+ySlE2x7ym3DLPlVuzDONqoNxU+UmCb6PR17MPs51ta
         VruDYg4n2GDTfr+jHicdIIEbeLXVxbyk2mZHXqX+VP9jCHSboc7WWDCKlrDWYCW1xn+s
         DGpA==
X-Forwarded-Encrypted: i=1; AJvYcCW0a+iEy9L83Cd+j9CzJCgeqt0BWNedMrFvbnTC5OoDnWlq1xE/W+mP8/uj7y53dLlupro=@vger.kernel.org, AJvYcCXQDD3Umna2PpRuD4FRjkWRdDCPk/svzC/WROT6vuUIuLUKAhdk+dC4/fDwg0MJhvhLUDOv1ba8vCT7hdSW@vger.kernel.org
X-Gm-Message-State: AOJu0YwC0n3OFzDMGLTC/fhUHGnu1tVywd0mI3IRyTE6Pfau2opNljc9
	bZ9bK6VObCp+f/2Ct8+dFqwIQcmQTCZE8TAjaSErXhTiffpcVjiy
X-Google-Smtp-Source: AGHT+IHmvUBz7fk/UCIXIZ//0faoJOq2TX3I8JkxJznk+y/j/c6zzfsoyEBVe0TEHViH2yp9X/a0Sw==
X-Received: by 2002:a17:902:c40c:b0:203:a046:c676 with SMTP id d9443c01a7336-2074c37971amr10873635ad.0.1725979279811;
        Tue, 10 Sep 2024 07:41:19 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e353ecsm49775845ad.116.2024.09.10.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:41:19 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Tao Chen <chen.dylane@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinke Han <jinkehan@didiglobal.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [v3 PATCH bpf-next 1/2] bpf: Check percpu map value size first
Date: Tue, 10 Sep 2024 22:41:10 +0800
Message-Id: <20240910144111.1464912-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910144111.1464912-1-chen.dylane@gmail.com>
References: <20240910144111.1464912-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Percpu map is often used, but the map value size limit often ignored,
like issue: https://github.com/iovisor/bcc/issues/2519. Actually,
percpu map value size is bound by PCPU_MIN_UNIT_SIZE, so we
can check the value size whether it exceeds PCPU_MIN_UNIT_SIZE first,
like percpu map of local_storage. Maybe the error message seems clearer
compared with "cannot allocate memory".

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: Jinke Han <jinkehan@didiglobal.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/arraymap.c | 3 +++
 kernel/bpf/hashtab.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index a43e62e2a8bb..79660e3fca4c 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -73,6 +73,9 @@ int array_map_alloc_check(union bpf_attr *attr)
 	/* avoid overflow on round_up(map->value_size) */
 	if (attr->value_size > INT_MAX)
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 45c7195b65ba..b14b87463ee0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -462,6 +462,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 		 * kmalloc-able later in htab_map_update_elem()
 		 */
 		return -E2BIG;
+	/* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
+	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
+		return -E2BIG;
 
 	return 0;
 }
-- 
2.43.0


