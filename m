Return-Path: <bpf+bounces-21095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADA847C0F
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EBC28377E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8225E134CE4;
	Fri,  2 Feb 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKpwe5qZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AEE12F38D
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911527; cv=none; b=GaDn6gm6OCNFHrMuQDAfnB118pdMRvdxo6Amz9V4zUc7z3wyzLpegqRmnnBW/BXlFdIWkN4+KTrjxzC3W0DdQfwfY9aOTpfr1p0e1mz36qRUk6Wwr4czBXIlajvPIxT4q+4lJ3SfFHlMZAn5Hi+mm/thl/2yVcWMXc7TWvAITkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911527; c=relaxed/simple;
	bh=UoSvv2aGkNFX5PGmKIuAZzsWgScztNCtv54+o/yoBA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjJscnEfkk43+lH+LACEbbYOduwd3BWPHD7FtLyLuodf8gWisxlW+nCupj5EKlc/GHaUxvlRm3oTwMJ4Ab65/3hl0z+HYoEn8FyfCNYFji3gnJa66BXo3H8mNNWWwl9J+KbEBGIAgee1IG3qi/ACywQgWQkAepC0DNbteIGdo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKpwe5qZ; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e114e247a2so1300269a34.0
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911524; x=1707516324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN+COAn3MMdA18FMRuBoVqtzaYV8O7FmS+fJ8fCiMLo=;
        b=AKpwe5qZeltSSsSJqqdctgJH3XLNgVCuRHFwKwfjYvpCblv/bQe5FD5K38fDcwPjcz
         Vbj9pS0YD3kHCxTURlFdTIR6qHJyVayNr9RL2Jxz7I5YA29cEmL03dwaF1CU4A0leMv1
         j8jiU5IfybWZzQDucvFFw4YL4fyGz9mosZkXtE6tdKTwONKL5RvxrtLmuL5+m4YLv1UL
         lqjnxA43vp+r5NxEP5QBV1gPRO4KeRwOTtgyqZ4qlI6pcYSbfdIACYt8j58J7Gnq9CuE
         qsExf5ZHeEwPXgseGZdBx3TDjgDV0uCxKuLQKVDEqUog2hzwTdFJ+Ity6LVjwQV71ZaY
         tsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911524; x=1707516324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN+COAn3MMdA18FMRuBoVqtzaYV8O7FmS+fJ8fCiMLo=;
        b=B7oyD/xOZNpX9S417KYPnqQxd8VBwR/omDBysURcog+bNtlpURZvbIIQRYbgn6yaVP
         NPXsDyS4UPUZf2H9BjlyK2nigqeyfrSmnfS09zWlldQd535D8g1sIPnX7ThKwO4XVa0t
         D5CNHmrWYeD+tEUebBFIzk6/co8IGbSZbUHf2yL58Eji8R8/LfK2j8PNNq7HTaFH8Rz1
         s7lFyEVOjvhMEMo3RgdQW01miPBJoSuCaiEVtpuCgzDQ4UkWJcXkBVqmWmedshqelw6R
         rPBn2plIxczK5Qag8vrFLhK/VgmzIvXVVCty6sejjpBKMFw1WZC5bWu6XXXgMPeFmW9l
         EztA==
X-Gm-Message-State: AOJu0YzQTDMuJ+Z9ZrrM9TRUd0Q6rsL6ydowot3NNeHlzV5zRNkk7R6f
	HRDIWJpEta+DD/T4OxBF9yxrNhZYaxTV1E1EO5ZEI4IiuA1D8vQ5wOpJAgN/6Sc=
X-Google-Smtp-Source: AGHT+IH/fBkzmNBzfwjJvORGbbBnXtcc9jj3hPwUQVmsLxNAeXl065nFv+YRMddrHa/q26/AhfKr/g==
X-Received: by 2002:a05:6358:2606:b0:178:ba22:3cfd with SMTP id l6-20020a056358260600b00178ba223cfdmr8724169rwc.17.1706911524182;
        Fri, 02 Feb 2024 14:05:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuOXYx/fx9CM8MEWx42qALsfqESYE0A2K/D63IIYo4fLEZ0KrHcJPzQU0z6Zgu6zy7kAUa2PRlvbwRoWan+yZM04AQ4WX/tjF8yLTKSjmB3PXuF+/rwFsCu08pAfVcz7mK1y8O/BZ6URCvcTuMfhqhQls4LlkO6iw0mE4aqszDKJy0uVEaSYDQdjElxiKBHnQlgC5ITKNRMu4MjK2cHHWckocCINh3k5CO5wAVhcB0uS5Lvxu5QETBiZ31Tt68Rw8tt7bjfcMpq4yNILQts/ClSFh0hUzN1KYEl8dTR9tACqA=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:23 -0800 (PST)
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
Subject: [RFC bpf-next v4 4/6] bpf: add btf pointer to struct bpf_ctx_arg_aux.
Date: Fri,  2 Feb 2024 14:05:14 -0800
Message-Id: <20240202220516.1165466-5-thinker.li@gmail.com>
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

Enable the providers to use types defined in a module instead of in the
kernel (btf_vmlinux).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..9a2ee9456989 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1416,6 +1416,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d3f94d04c69d..20d2160b3db5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6263,7 +6263,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			}
 
 			info->reg_type = ctx_arg_info->reg_type;
-			info->btf = btf_vmlinux;
+			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
 			return true;
 		}
-- 
2.34.1


