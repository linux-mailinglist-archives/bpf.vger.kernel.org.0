Return-Path: <bpf+bounces-53984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94035A6005D
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F816C906
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667821F180E;
	Thu, 13 Mar 2025 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+tpF3M8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F078C9C;
	Thu, 13 Mar 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892602; cv=none; b=oYdD7vUGtbDOl3StzzcKhkHQHkvevZpqMTYFFm/FvbMVWvJzLH145DUeI6ld9pcMxatZapI/GKeDyauNRKuQpkNYKWC5UjmHTEmRl8Z2b9ICJiYVEwcY5ZwJL0f3g9awBSR/QKzYrCdLHTiQWttXvq6P0rwC0JorYtNgkKfcwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892602; c=relaxed/simple;
	bh=7ZdIUWwy2ZwCtyLTE2CZpC1ML5KbxUCT89YsXIcUQK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9uG6muvQPAhMXZxw3oqv73x07K4i2gF33SRtkPwhHQDUG9CkR6FHL1w2Hv9lXrAMEzHoHneSk+ic13dUO34Rm1VbrK9W8FzZROUSTKfcA5F7EIlezTTTEZ5fymIZSS5nwpLJ4w3IAs6lArWSYYpIlwjGi/+2QQBL0C/zXKIP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+tpF3M8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so40016555ad.0;
        Thu, 13 Mar 2025 12:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892600; x=1742497400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBe2Vn5705Uoga5BCF8FrreTJ3KADBCQ6CgS8nbEEIo=;
        b=R+tpF3M89UPyHq6zHIbZwGlu6HBRDXR9qaCOBgUkG24vEeNgUSqW+AKFwkM1qQ+eb0
         iqhmBN1jJhRbbUO3Vseq5mRIPcQUpZ3J4g+B6ZzQMVHgIhTDLehZBlWADWnjl6pjDhf5
         /L4W7iEfD3lw2lqVqWAJQ68R8YJYJzBqpdlDSMbU3spzIgGXZjClcHrlG1yP4DF+NOAK
         OQoX3juZ1/6KdZgJJUJNBwD2yMp5Lg4k2n9KBpCTXTPb6yxGx6qy82da9N0hJwlS3WLo
         J+xSbKOOrvOrm+gUbIc0HSKA/5RpKns/Q+2EqpXhj2ygahHIYXwuOCGjZdB9FdLX1E5z
         V8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892600; x=1742497400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBe2Vn5705Uoga5BCF8FrreTJ3KADBCQ6CgS8nbEEIo=;
        b=YBWb/forV8zj2ZEevLAU0Tn5i+pWNVwCbS9yTQdOkz3+ZE+IT8s94VCXxkFZWPW6vY
         dNw699eC8rH5mXLI5AHqOq8jMXiWv4imYRkAXb+Oe1VO8vSogTyQTkFer1yMOMBJwLy4
         lYyDLm7sTHXZPHCXSZ5FJD1RNlHPUkq8N1N6dpHcoAW4SRTIkkgsxKSmwjD/AmN/XeIz
         QbR41hjJ79mb5qQnty3ZdpSayYFKdvdXjB3MTfkRGBJIKuzuuNC4N770v8rFZRG7utrK
         zCSwFF1YiITgNHS8MbITahsOsL8YWKxEP1RngxnyWBZTfjxmLLmkEWS6vRTBhm6WnhP9
         9+jg==
X-Gm-Message-State: AOJu0YyUq+Q5z5eibgHFvjgJszvFX+dFnyxbnGWKUIZ0W6R6Mant4EAb
	/DysNLUV8jdymmGcQB3uqdXKm/RKOM0USSfB8nsEhWhVYjxI9s4f7oam0nymW6C1hw==
X-Gm-Gg: ASbGncsvHPDjdKNl8gIxCYw2jMi9YIok1R0mjI0i9gb3/4hx3A9c/AsVmU8GCk86zTu
	rW9noSutbXr4rJ8v6ptGEM0U8MCk4KQypULtoyZojEPLZB60JPAcFK3+OsTzfx811nOAQDdu+jG
	X7WZI+eUeA30z0EN4TKdoWD/e6g3EgbPXM/G0sd4XoYK2EwwRHB+lLOcAUWuH0KLHKqrGqeJO/I
	PuZTaYlsKNFQlEYu1UiXGGFCTRSn/3kFr7X2MuCyQNNg/z4/NVWiG1pXIvtuyMreD05N2DGulEj
	uHTrUtXWXAyZuGCrUfMUfQMbbw309DlzilaWhz+LGy+uKo2TwtKFVvLUoz0285iPPbn6PhCdBHp
	Z3dVRgRScJFQkVnqhWr0=
X-Google-Smtp-Source: AGHT+IHQ/8YYRG+tDimUOLk60GZkFEfmf/gUmjBVadwddfwBlZtGq0wpmLQxn9WK4LusuND5l69Q2Q==
X-Received: by 2002:a05:6300:67ca:b0:1f5:8903:860f with SMTP id adf61e73a8af0-1f5bd7d4fb3mr1243941637.14.1741892599624;
        Thu, 13 Mar 2025 12:03:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 01/13] bpf: Prepare to reuse get_ctx_arg_idx
Date: Thu, 13 Mar 2025 12:02:55 -0700
Message-ID: <20250313190309.2545711-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename get_ctx_arg_idx to bpf_ctx_arg_idx, and allow others to call it.
No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..b2983706292f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -522,6 +522,7 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 519e3f5e9c10..9a4920828c30 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6369,8 +6369,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
@@ -6649,7 +6649,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
-- 
2.47.1


