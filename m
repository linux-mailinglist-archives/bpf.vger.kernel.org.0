Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED02496A
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEUHxa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 03:53:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52017 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUHx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 03:53:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id c77so1842638wmd.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VmwFFsbqJK3+lRSkFVmV7bpMeUDcybN8WqYfoV1sqU=;
        b=fh/ODLpu818axlZwJplBcIXfLxWCw1MDDaMvyMdY7OZiqk5ux9ysGSuTc8ZdNtHQgw
         V0ZPljVgnSzv8u80v4/0gyOnK6DaRHzSyKhof2oW3wPv6Y2OtXPKPeDkr8665jqbPBTG
         fS7TQzE+1r8D0w4xOM3YBV8NXSZs6fQbZ0E08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1VmwFFsbqJK3+lRSkFVmV7bpMeUDcybN8WqYfoV1sqU=;
        b=T2jH+qVvdz6LcgTlUYW//AHMVU8r7q4W0vwm0D0cVmOMyKaJfucubaQAHNyaj5f4LE
         gsjVBtmY+o2i76RrZE54WEFjIz3iK3RYudqj3UIaOM8ukqqUL06SWipEFyD3JVgFuLh/
         D8GwTSDZvNgDHFh8m1lOIX6c7AAv/txhqJhFGNQdidGS49Dy+oHeL2TSgFM27u0xS/kq
         FntFFHAEG31zqVpAbY17OyaYdBcqtI2xMA/J1u1OUICoOisKI8oO8+57Nb11VXfka15G
         9GAEiweJcvxyPFjBOURtpUoZfW+b5Saxp9na4K5JILUneSPwj0fX3RmUDijxRvUNxxCA
         APTg==
X-Gm-Message-State: APjAAAU++xjyYCK3WMizN5rcbfzAz6e+WYSxMWoMyp3g3A4qNL2+ebpO
        XgR1zgdSKkdkFrfphdSKEIo7aw==
X-Google-Smtp-Source: APXvYqylOBVBlr4HUSfame1dJJqGIkr2/KIsfH7YcS0OSUKYlcLzyXSh3YrdTKiWRwlzdHNRuzvaKQ==
X-Received: by 2002:a1c:f507:: with SMTP id t7mr2308565wmh.149.1558425207226;
        Tue, 21 May 2019 00:53:27 -0700 (PDT)
Received: from antares.lan (0.1.1.1.3.c.d.b.3.8.f.6.0.5.4.d.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:d450:6f83:bdc3:1110])
        by smtp.gmail.com with ESMTPSA id d198sm2259295wmd.1.2019.05.21.00.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:53:26 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.com
Cc:     joe@isovalent.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] bpf: fix out-of-bounds read in __bpf_skc_lookup
Date:   Tue, 21 May 2019 08:52:38 +0100
Message-Id: <20190521075238.26803-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

__bpf_skc_lookup takes a socket tuple and the length of the
tuple as an argument. Based on the length, it decides which
address family to pass to the helper function sk_lookup.

In case of AF_INET6, it fails to verify that the length
of the tuple is long enough. sk_lookup may therefore access
data past the end of the tuple.

Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/filter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 55bfc941d17a..76f1d99640e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5304,7 +5304,13 @@ __bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	struct net *net;
 	int sdif;
 
-	family = len == sizeof(tuple->ipv4) ? AF_INET : AF_INET6;
+	if (len == sizeof(tuple->ipv4))
+		family = AF_INET;
+	else if (len == sizeof(tuple->ipv6))
+		family = AF_INET6;
+	else
+		return NULL;
+
 	if (unlikely(family == AF_UNSPEC || flags ||
 		     !((s32)netns_id < 0 || netns_id <= S32_MAX)))
 		goto out;
-- 
2.19.1

