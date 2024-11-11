Return-Path: <bpf+bounces-44543-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3F9C480D
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 22:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D699F1F223A2
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC01B86F7;
	Mon, 11 Nov 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2giizAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12C156644
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360572; cv=none; b=PCM4p0xaAuJ+BxdTO5aeCdWQIHhiHVLdgonEJ6mJIbSSEvt0//mGOJrViwi/pgQLF9XIyuv68u6HBX0Ttl3G11nVQNec8I+sGkHfxmgKBKnh3aVi7oU+zkstZJy50c74BwfNDq96htziJkzXy9e12/B6eiznlFV2hgAN4wUCb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360572; c=relaxed/simple;
	bh=RSYyNiZIi6mO3JMMfCl1AZGQVGHJvI2MkKk3T0ygrX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNDW57Rc8YjHH1/mntSndbQa5W2oPenovTfUBowgx5z8vox2CEFLKKdnVfgW/oPZiBvDJUP56TufK/fz0VzqbgZ4l03hVsUMMY7cHqPJKGwV5zz+wawbPZPf9VAoRbV65ULdic1LDUH7P7SpwaFEr7trMcJ/uiv0RljgC+V5URs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2giizAE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99e3b3a411so1032649566b.0
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731360569; x=1731965369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beH5iaxbGlcBFcC2AvDILXcT9XOS9MS2kCicKxJu2cY=;
        b=R2giizAEiKMJ9JoMglGB5EvTdHD05UHJJS7APQxE4/NuM6P6woRJEJnqVHWbS4jJ3u
         rtn9BaT/wNOcZxFtEJ1TRDDybJLSjZT9o9cT5FPb8jTT4f5xKWi4mpEadJk+yhVsEXNu
         +TMA93ir25F8BJsXPabKlLsZmajQbfWcwbYJXCFmPWB9j8iPnMVtDXqpspmAiKJ1gte0
         XtwWCnhJMABMfwqGxCcZPMcQ9YVv1fE2+yPQDvas7Ue3sDgqbovu6kK3OyOpL8SFnL8P
         JShqBjGFl8DeSDJV1+l8Fg/gIMWUvWPwmpv+fb6zvlxOH+fmYeuVnP2OLfenQC+tKCrx
         8mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360569; x=1731965369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beH5iaxbGlcBFcC2AvDILXcT9XOS9MS2kCicKxJu2cY=;
        b=bsr4uHjEtgks9sg5K2xhwFqSXbJrL79lI9zXS7/QNLVZZNvmcgvQbAswegnZ0NxgaI
         WejFyVXL3mnSVsZd0UyFxJ4Ona8rsp0Cx9P1VEhr3LYTnbeLY+N7KMDsO3gfdDfk7u1C
         9E/HpRU062ABW+kffAiFxrBzF8kHFKa6n0A+0S9jldB89NrIm4e3ctFXtzUIFq5YIdzS
         ZfDqKZ0lw2xxyln41iuyHwiC+KEE2k55Cylz99v2+hOv5/d1tqoNbkXpVflsDCjcwIiu
         r++2KTBbC+Gt3PVWsNVqTKjzQH8xYiRiUdDs+uzrMkKhgIqC6iXhwCp7KOnuQMa1/F0q
         AP6w==
X-Gm-Message-State: AOJu0Yy+IwaHg19+f8W2tSLkRncXzN9xRuWmG69FLnTci4JbfuWj9uaI
	0WJ6uy0ktB7B8CnsciMElDfz10nvdVfmw89HE6GFjnH1KruxyfmmLjQTgw==
X-Google-Smtp-Source: AGHT+IFbZJ6g/U7x2fY8RyjXaWkOWAmF4j6zgxw/V9iN2h+hHXj50NYJqpAXf2hNfewbbHjVXm8sRA==
X-Received: by 2002:a17:907:1c0f:b0:a9e:df83:ba57 with SMTP id a640c23a62f3a-a9eeca83660mr1352284766b.22.1731360569258;
        Mon, 11 Nov 2024 13:29:29 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::5:3961])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0defc3csm629570266b.166.2024.11.11.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:29:28 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v3 1/4] libbpf: introduce errstr() for stringifying errno
Date: Mon, 11 Nov 2024 21:29:16 +0000
Message-ID: <20241111212919.368971-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
References: <20241111212919.368971-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Add function errstr(int err) that allows converting numeric error codes
into string representations.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/str_error.c | 59 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/str_error.h |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 5e6a1e27ddf9..cf817c0c7ddd 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -5,6 +5,10 @@
 #include <errno.h>
 #include "str_error.h"
 
+#ifndef ENOTSUPP
+#define ENOTSUPP	524
+#endif
+
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
@@ -31,3 +35,58 @@ char *libbpf_strerror_r(int err, char *dst, int len)
 	}
 	return dst;
 }
+
+const char *errstr(int err)
+{
+	static __thread char buf[12];
+
+	if (err > 0)
+		err = -err;
+
+	switch (err) {
+	case -EINVAL: return "-EINVAL";
+	case -EPERM: return "-EPERM";
+	case -ENXIO: return "-ENXIO";
+	case -ENOMEM: return "-ENOMEM";
+	case -ENOENT: return "-ENOENT";
+	case -E2BIG: return "-E2BIG";
+	case -EEXIST: return "-EEXIST";
+	case -EFAULT: return "-EFAULT";
+	case -ENOSPC: return "-ENOSPC";
+	case -EACCES: return "-EACCES";
+	case -EAGAIN: return "-EAGAIN";
+	case -EBADF: return "-EBADF";
+	case -ENAMETOOLONG: return "-ENAMETOOLONG";
+	case -ESRCH: return "-ESRCH";
+	case -EBUSY: return "-EBUSY";
+	case -ENOTSUPP: return "-ENOTSUPP";
+	case -EPROTO: return "-EPROTO";
+	case -ERANGE: return "-ERANGE";
+	case -EMSGSIZE: return "-EMSGSIZE";
+	case -EINTR: return "-EINTR";
+	case -ENODATA: return "-ENODATA";
+	case -ENODEV: return "-ENODEV";
+	case -ENOLINK:return "-ENOLINK";
+	case -EIO: return "-EIO";
+	case -EUCLEAN: return "-EUCLEAN";
+	case -EDOM: return "-EDOM";
+	case -ELOOP: return "-ELOOP";
+	case -EPROTONOSUPPORT: return "-EPROTONOSUPPORT";
+	case -EDEADLK: return "-EDEADLK";
+	case -EOVERFLOW: return "-EOVERFLOW";
+	case -EOPNOTSUPP: return "-EOPNOTSUPP";
+	case -EINPROGRESS: return "-EINPROGRESS";
+	case -EBADFD: return "-EBADFD";
+	case -EADDRINUSE: return "-EADDRINUSE";
+	case -EADDRNOTAVAIL: return "-EADDRNOTAVAIL";
+	case -ECANCELED: return "-ECANCELED";
+	case -EILSEQ: return "-EILSEQ";
+	case -EMFILE: return "-EMFILE";
+	case -ENOTTY: return "-ENOTTY";
+	case -EALREADY: return "-EALREADY";
+	case -ECHILD: return "-ECHILD";
+	default:
+		snprintf(buf, sizeof(buf), "%d", err);
+		return buf;
+	}
+}
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index 626d7ffb03d6..66ffebde0684 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -6,4 +6,11 @@
 
 char *libbpf_strerror_r(int err, char *dst, int len);
 
+/**
+ * @brief **errstr()** returns string corresponding to numeric errno
+ * @param err negative numeric errno
+ * @return pointer to string representation of the errno, that is invalidated
+ * upon the next call.
+ */
+const char *errstr(int err);
 #endif /* __LIBBPF_STR_ERROR_H */
-- 
2.47.0


