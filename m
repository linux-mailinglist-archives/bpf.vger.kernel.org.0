Return-Path: <bpf+bounces-56947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCAFAA0C9D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D9F4830B1
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C897415747C;
	Tue, 29 Apr 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrCMNlVo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D94487BF
	for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931814; cv=none; b=ImAjqao9RkHmLbzBx6md7K6D8iG620T27GRbts5eKuomW0nJTl0ikH8JbgK8RvXIU24aTeNIZ7Rrdy6641Iby/jbanCKhzhbFz+px7uW+xG+FcBKLOGh7wy7drlIVzL5dJdrbhJQ1iUxv+bnGgD8A5hbHV3eF2/h5BUFwUKGURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931814; c=relaxed/simple;
	bh=UVkHcl3aQSvHbDA91XSP5SGl0J5Vx2IuuxjWhC23+VM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HgebdihqDc+zS5opsaeY62x6ppli6x8TFiHGTZkKOI4ZV7Yz1xXQKvXT36STa9+eu9VLEaForlR3fXjEY4qqWDBfPuojkEx5KxILWlgQyUxGnT/bDtYj/n49qM1EH1scvG2mnQUcCt27oW1D61zfXLS7TFr2X+YnbneGkNw4z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrCMNlVo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso9754085a12.2
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745931810; x=1746536610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq8ecgHUyxCS5ksWMNOwpQQuAqPncUrMeyNDshKPs1o=;
        b=HrCMNlVovpOgtz49qjs5/CcyOQDCs5eanqmT/vDcN38/zUexG5N3dApd43CERzjJwX
         5LfHxpU7exSHIyudtm1mQutAclGxdvHDii7fE9F4j7SvfrrtVbQmJMNtbawQAahLcIxS
         c4D30YIe8FmCA9fN8933+cggIkWlNC2xEz3zKbrDidiwy7lisvpRgHH8KsIrqYo+Exge
         8FVedPjFhAVBhUqcVWerBvA3YYaw4eA+VIuD0l9q94nWS9IRD5veA91q2eevovaoL307
         Z/+pSCagkZ1jQ9B/umRToLxELforByai0muNJ6vSiGidNA0XxKTlzQyC3zkhw85+/miW
         /tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745931810; x=1746536610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq8ecgHUyxCS5ksWMNOwpQQuAqPncUrMeyNDshKPs1o=;
        b=Xv/h9W3X2L4rxOxeK2znj3xqnVEB/ZcM486uuDAeJ2vcSJ3jFOLd31ZvwHUPWVW7in
         vfnl/MkvTfaAYha05HgBom8R2HGClC0ALEbU1ovKtEFL4JFEGUZqE25Panph+X/wZ1kC
         VwHWkG8dPZ8fkKbW04enh2bX2aOoHJUDCLbwUk7OU/tTSSuWKu+s1G51nozkzyKpZHWC
         IppDLhp9WJOd+R+atKCdhWtTpkN2hNHi5tupReslh/vFqVWHaYXXm3nS9Hs9MvvvgCHD
         k9EWPW1zzWXaH+x7Pgt3serWkmL6/6qqRZQxAovHS/4nxepFr3W3+a5aT9SILuQPqkEs
         xSqg==
X-Gm-Message-State: AOJu0YzftSGLCSDaM8Ae/Ga9Kcvy1i1JEubEELd/zmv4e7f07/1GaSsm
	Id0AsmoOt6nW8QrH77W2foUW/YyfKx4LiZizDj7MCNd4ecD9LGRXEIbZog==
X-Gm-Gg: ASbGnctr/lYLYiSiATKv83PqBAuKFwYZEfGS2B6OlDamDD7bihksnVTHrVorQXIS9Sx
	metxPQlbQNksJzVgIddqMyl3Eppfqs90h+D3i2pNah/cTcj9oE8iNkxd2YpNGzDRkHnvXA3s9wF
	eQrfIzSUf48iVZZLwt74IFYqo3VS+pB3SlwMwyVsJ7QOsNYAKP9OoiUzS1GlwKCIDsXErqnH7X4
	6N3H0P1l703+Lq2PSesFBVUghDhvoI+ffBcMBVEVTpjeotozhqRVs6uRq2sKsuiuwKI8JK8+976
	mVMK6tViJEDQQ1k7Lt+AgUVdfIy0AO+ckoDQRGTI2cDlEsQwsHTpCdrrxTu9e0egP4TtURg=
X-Google-Smtp-Source: AGHT+IF/57nlPBgOraUhKuRizmX38TFt2Q8u4/gOxDv2gBeK5+vfJ6nlOfiwpYAo/XSPPfNYDQ/BnQ==
X-Received: by 2002:a05:6402:350c:b0:5f7:eb1e:7f25 with SMTP id 4fb4d7f45d1cf-5f83b0c3d7fmr2211399a12.12.1745931809614;
        Tue, 29 Apr 2025 06:03:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7011fc653sm7335905a12.14.2025.04.29.06.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:03:29 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next] bpf: fix uninitialized values in BPF_{CORE,PROBE}_READ
Date: Tue, 29 Apr 2025 13:08:09 +0000
Message-Id: <20250429130809.1811713-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the latest LLVM bpf selftests build will fail:

    progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
      710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
          |                                      ^
    tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
      520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
          |                                          ^

Fix this by declaring __r to be an array of __u8 of a proper size.

Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/bpf_core_read.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index c0e13cdf9660..be556ccdc002 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -517,9 +517,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * than enough for any practical purpose.
  */
 #define BPF_CORE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
-	BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
+	BPF_CORE_READ_INTO(__r, (src), a, ##__VA_ARGS__);		    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /*
@@ -533,16 +533,16 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * input argument.
  */
 #define BPF_CORE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
-	BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
+	BPF_CORE_READ_USER_INTO(__r, (src), a, ##__VA_ARGS__);		    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /* Non-CO-RE variant of BPF_CORE_READ() */
 #define BPF_PROBE_READ(src, a, ...) ({					    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
-	BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);		    \
-	__r;								    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
+	BPF_PROBE_READ_INTO(__r, (src), a, ##__VA_ARGS__);		    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 /*
@@ -552,9 +552,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
  * not restricted to kernel types only.
  */
 #define BPF_PROBE_READ_USER(src, a, ...) ({				    \
-	___type((src), a, ##__VA_ARGS__) __r;				    \
-	BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);	    \
-	__r;								    \
+	__u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];		    \
+	BPF_PROBE_READ_USER_INTO(__r, (src), a, ##__VA_ARGS__);		    \
+	*(___type((src), a, ##__VA_ARGS__) *)__r;			    \
 })
 
 #endif
-- 
2.34.1


