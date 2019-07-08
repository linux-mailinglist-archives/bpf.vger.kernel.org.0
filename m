Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40046263B
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbfGHQb5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 12:31:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbfGHQb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so164411wmj.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=f3sofSU/bXru9qax++aOgBk+uAlSYw6diTvQz4Zb6xU+ePOE1k+PF6XybmrF8zA8Lm
         cxUhOmVfIKOmnI0trsImIeXpuUUW+sKjTOhPWo3MCCGcHCf+iQIseb8AfeR7KKbyPnKH
         4z9UWgWFHpp2PrqssJUgvo0yyedi5hHUcIboQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2q/9DY/eMlLakYA2goJPIRtdbZUH+0KxlPnLmYNTOY=;
        b=qHnruRPu9lhAs3VqTQyVXfUVuNlPDeJ9Vmn+CvJ22MguUM74yYupJM8nr2W2SxVlyv
         bRPQdxxS1SnXLNQvXnb8FxI1XwL3xWAZG2p0aACdvxofYO+cunlon7sUzVKVewrOA/X+
         1H4WPZih/3uQkw0ETt7yO8xmgU3A6erlq7awXXaF/K33rHKeroYZSfg/0eXi52C1JEpq
         bes6qWy/YDpGRPHdDa7rEphcR+ZFOQVHvuxSdjb86wCjlcY5D/c40AgaZGN2dVTWYXcD
         BemNxsKmZMLkHaqJGHHUAMIUh7VcJvhCRton1tLg2yh+XXVcexvv6Q+XCWvMmOHi2IJn
         hOAw==
X-Gm-Message-State: APjAAAVQ/ZFVYfBhSPXpLPPvCSrnPyPZr1NZfH7HlhsFlegUwr+eowXE
        7PZy/PRIeDuwyVqsJfCtQ4NpGA==
X-Google-Smtp-Source: APXvYqwgF4eK6PEywYbJMZghzfU39cx60C67Re6v5ey3Aa4/20vDkjnYdTfyPjo4Ljm9od9zONwd/g==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr17401953wmj.152.1562603514984;
        Mon, 08 Jul 2019 09:31:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:54 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 07/12] tools headers: Adopt compiletime_assert from kernel sources
Date:   Mon,  8 Jul 2019 18:31:16 +0200
Message-Id: <20190708163121.18477-8-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
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

