Return-Path: <bpf+bounces-21092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCD847C0B
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818B21F2D90C
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC3885933;
	Fri,  2 Feb 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY/hXZNv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B037136984
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911523; cv=none; b=EdgFlZe+K+PDIpev35AGfULvo4IqCPA2L2azKMv8qzze0UjDUVzWvNI4nXMB1SRly75WraStxl37XvVbgojKX8j428uMN8M+mrXdMu5Yq4vHro7aiIR4oJNr/zVl/EJyebpkUa6fpDynB+c8zqWgEJId5mo/VmIETjJ/OojY5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911523; c=relaxed/simple;
	bh=Ny24tvBhyZ3dB3ySo1Lq9f4pvkPYuB9jcIDUqmP0AgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvUyqoriZWVY46wiepx9kCd4YJYFf8rI0tKKIkQ6sfjNg/uzlxvLQNZyze+k2PE8Lo1ZnnHxwXggMVSad+r6/yiKExQPOSO5QzVf+GPPdr0DPYzozhCihX5CCBZYHPaGCNoY5dFMVgwvZECZ4AJDS3YSuNgIFHjxUQqtHoNQRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY/hXZNv; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-604055e48a3so27641607b3.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911521; x=1707516321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGT9jLe359IgV5BY3wwOAF0jhl296naPo76q2f8Vyfc=;
        b=OY/hXZNvLr/oEImrj941QdvMAaE94QjVM9yk3sHGFKRuF3F0HNWM5Mw6eLEQq7lfFb
         XrZWSNld+gvDnxHFHTPhoabmRP0rTyG/QADnlKHrVl5j6bZSh5rVHlmIpZpZxlOY9/Zz
         fKe1CfQIl2Qi00Z6EOSiOhS3aVMTmMHCBtZzL0Pc1qOlGALN1uY58IUmPPj6KaDtE7Kr
         U1ZC8YCOUB038yezo7qmIYtCE89+QwfTFv011zdTeEwHVxbjHnFt8ZY6OJPiOO2E1lkG
         WRkUH5GzMmNwVPca864FKhn3zuY+Paz/Is64MTddXdbsvFCxMadAHTM5RvAi4Wy9TRIv
         8s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911521; x=1707516321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGT9jLe359IgV5BY3wwOAF0jhl296naPo76q2f8Vyfc=;
        b=k74EMpCuZBZph54h7qk7/6bcUqf0J39g4/dt++yC7WXeJqAJGsQORb7BS+TVGf8fyO
         NJPfv9/xkhoZL6jxsofTG8hY7DZGQgURJxo7c5QJPVi+KsWxlvaLt8Rz6/Hde2DAJMlV
         Y6Hlqdet0DLBmkZTYMTgpOoDGFJ0QGEME43hBKCKpPMHFQsmLxH4jus6wyT2dz7TTTjB
         trz5OAnRPIVFitZaWLrtokCPAiQtLNrB4tleJVUAXdpKU4jR3WSS5gn3TfXSlSdvirPX
         WFE5JVx0q5ddlW9W9SchODk9ZPSmy/DWeMTF3obUdaz4cYT9qYtwKMfmAZj/0aig+KGw
         7t2g==
X-Gm-Message-State: AOJu0Yyi1xLY0v9Nm1B+ATqNSI/t0v51qjjiKp8D9PR1P5J5VL5vJS6d
	mZ4Ha6Gj440QwfHkD5a11UzoXoy+pR1GI8WEjy2vIRG7DBxeXm5owzDCLDY1cqE=
X-Google-Smtp-Source: AGHT+IFu23aLQ75v5YDYNDO/zosmKlVcr39+NDcwvgLu1xpQeiQfHItTsSOdN9D+Kw5HWoxRfK515A==
X-Received: by 2002:a81:4508:0:b0:602:b5dc:1091 with SMTP id s8-20020a814508000000b00602b5dc1091mr3424686ywa.3.1706911520591;
        Fri, 02 Feb 2024 14:05:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXjDuFcUWwfdytApJX4CfQH8kMZu/A78cDTh/GcF05ms5JyrMq7BFfQ2zpH4/UzN6hqVidWh+Hj0XXOTRzPEet4ReMnjyhc1l5E0xU2ycdqW3itSjw1vdTj6VyYknYDa1W8hOLFfpvuSWNoDA+i5MWqUufYA0ac/pYp+pQ3qzE6mC8ntxxERTRazGd1PKiY5auk8sR6iexXx+ljV2ketf0xs3FpQmfH5JjmiVEOu94puC8NlH5G5+0q3OnRMAqLzFROnL6n6sq6yIjm6UnzAw999aGR7I4nGApiBhjlt3C+RH0=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:20 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 1/6] bpf: Allow PTR_TO_BTF_ID even for pointers to int.
Date: Fri,  2 Feb 2024 14:05:11 -0800
Message-Id: <20240202220516.1165466-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202220516.1165466-1-thinker.li@gmail.com>
References: <20240202220516.1165466-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Pointers to int are always accepted when checking accesses of a context in
btf_ctx_access(). However, we are going to support pointers to scalar types
with PTR_TO_BTF_ID.  Changing the order of checking prog->aux->ctx_arg_info
and checking is_int_ptr() enables the extension in the following patches.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef380e546952..0847035bba99 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6252,9 +6252,6 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		 */
 		return true;
 
-	if (is_int_ptr(btf, t))
-		return true;
-
 	/* this is a pointer to another type */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
@@ -6272,6 +6269,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
+	if (is_int_ptr(btf, t))
+		return true;
+
 	info->reg_type = PTR_TO_BTF_ID;
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
-- 
2.34.1


