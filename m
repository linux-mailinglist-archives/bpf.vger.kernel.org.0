Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D032B557FF
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 21:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfFYTng (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 15:43:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35452 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbfFYTmw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id f15so9335481wrp.2
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=S6FLBGyhiUGRPfx8AIEOgrRMwJ0Zlq/FBeyMZ0NVbAecl9fre+tB9eolB83gg1d8Fh
         UlmK2b4GOhZ97HObqFlkwkfXZfsB0ImP+WPsm1elSj1LTHnsYfiGttSSjEkDiFVdmrmE
         fgoi5c6CiMiOHOLoQSAcHEE+eYN9VSUR6pLh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=i68EFqFhuBEbCv77vMS+jr95GT0wfA+/rwJ+V/BwxJIkCqXwLcO6Faip6+ceInDWYc
         TvuhWGLoi7AC+JuTjCOXDMwknoeWso8hxynCAgtTJkUyV7tct1yl6D8AHNQKutGOFh7H
         Cd9aY2A0AaG2c6uaH2FPsDPp6Z8qT4XM5xSnCmt/5LK+UZbdpjvbx+htNBimnDlqWNwD
         V7v+r9hUmCfixeXHOYaXzSSmDwP4O/3iYckysvPBZF2B9QkX3XFQZ6ldVxi/qKwEqmOI
         JpTECqLJFs1rNMXQaaRRh80+82Siv17t3NmpaGv889CgUc6hdz9FIYBpYKlWUFPhjt/B
         cn3w==
X-Gm-Message-State: APjAAAVrWQNbMxLKmegppVHRtGSyY3+RVKc4UrrSNA+WKvx2oblIlbyt
        AbUtGJVGeQoRiuI9NQhrSk0erA==
X-Google-Smtp-Source: APXvYqxARSUICUN82WqUy1X4NpQ/y8QyvqnKc7YfYnnYme1U189+Tncy8JdzCrbo/FkmDrNfs4SIog==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr111481467wra.261.1561491770947;
        Tue, 25 Jun 2019 12:42:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:50 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     netdev@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v2 06/10] tools headers: Adopt compiletime_assert from kernel sources
Date:   Tue, 25 Jun 2019 21:42:11 +0200
Message-Id: <20190625194215.14927-7-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This will come in handy to verify that the hardcoded size of the
context data in bpf_test struct is high enough to hold some struct.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/include/linux/compiler.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 1827c2f973f9..b4e97751000a 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -172,4 +172,32 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 # define __fallthrough
 #endif
 
+
+#ifdef __OPTIMIZE__
+# define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		extern void prefix ## suffix(void) __compiletime_error(msg); \
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#else
+# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
+#endif
+
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+
+/**
+ * compiletime_assert - break build and emit msg if condition is false
+ * @condition: a compile-time constant condition to check
+ * @msg:       a message to emit if condition is false
+ *
+ * In tradition of POSIX assert, this macro will break the build if the
+ * supplied condition is *false*, emitting the supplied error message if the
+ * compiler has support to do so.
+ */
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
+
+
 #endif /* _TOOLS_LINUX_COMPILER_H */
-- 
2.20.1

