Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E06427E2B
	for <lists+bpf@lfdr.de>; Sun, 10 Oct 2021 02:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhJJA1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 20:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhJJA13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 20:27:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16254C061762
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 17:25:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so42282431wrc.10
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaEBWnN7KGr2n63duW+rw+8/bgZ3SGchgUY0qU4URic=;
        b=7gbjH53shg/8N6ikpTkld4Z6I9g75HQ9RdvzsbwX8487yFnFosHpEe9O8ta8ROwcpp
         8XPSypp2C6CDZ1QcqbP+4dQK/EitHU+6T0NDZdUtsfmLFKrtcFnVujq0VXk2MUPQMSL0
         w1Nr6sPK6daA1Lg/2PZzVAIPD1e4p/Rv4THjGzBcen/wl3GsdF0G8FI1Fg5m1norHYWA
         AXc7Y8eb3C2qLiX9rIKgAJwUJ9n+LE5TjMSduFhYGHs/qOmxkIwADTUojfgkxRsauqap
         uKGZNbhzmqkeePhaoStnczNIaeRgQAVp3JFAK7VVmDBceTseUCOyDFzqCKFd5EnjbkGP
         cWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gaEBWnN7KGr2n63duW+rw+8/bgZ3SGchgUY0qU4URic=;
        b=BDvm40sYgG7yiMnuwAkXgCwuFJR/M69/L2IeA3Rty+DU75Vq5BIxvy+QeIF/NKygtG
         Knxe3smdH19P3roPfumtQhG6Vo1vJz9xCoJD3Iu1NuiaHjAxR4gW9qxUkXgdaYC5oirP
         au4AmHdiPr2ioLjS38tD6IClm0Ut+U5Lw+pdpsfInkDQnLWQFIiF9FJ7uKHtslFgK3BR
         A9gxLuhNYQt5bEg1FSZGYpLS33UrrKI5Hw6xOWzRLMewRwrqsIdM3OItcPzWCMScRdEZ
         zcm3FOjtFvPfhtEMVIZfaKW6g62YyP/o610YRmYzJDt4+DCpJtFg6cjXbzp8ZC+2zd9y
         1JBA==
X-Gm-Message-State: AOAM533ommV2ec3PO3ht4KphEnRE1YPDkukqKYdqdTpVVopvMrNRsvgP
        VyyXU/i2R1zna7d65xwLS7PpeBEhHq+OM21J
X-Google-Smtp-Source: ABdhPJx1+aBr+jCl6Rcyb63yaa7VV8hB0xUoDN1Elve6/WpNSXGszjkQQWYIyEjgcoe4mXGZuOtjKQ==
X-Received: by 2002:a05:600c:1c93:: with SMTP id k19mr12397456wms.80.1633825530715;
        Sat, 09 Oct 2021 17:25:30 -0700 (PDT)
Received: from localhost.localdomain ([149.86.86.59])
        by smtp.gmail.com with ESMTPSA id q12sm6633707wmj.6.2021.10.09.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 17:25:30 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] libbpf: Remove Makefile warnings on out-of-sync netlink.h/if_link.h
Date:   Sun, 10 Oct 2021 01:25:28 +0100
Message-Id: <20211010002528.9772-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Although relying on some definitions from the netlink.h and if_link.h
headers copied into tools/include/uapi/linux/, libbpf does not need
those headers to stay entirely up-to-date with their original versions,
and the warnings emitted by the Makefile when it detects a difference
are usually just noise. Let's remove those warnings.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 9c6804ca5b45..b393b5e82380 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -146,12 +146,6 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
 	@(test -f ../../include/uapi/linux/bpf_common.h -a -f ../../../include/uapi/linux/bpf_common.h && ( \
 	(diff -B ../../include/uapi/linux/bpf_common.h ../../../include/uapi/linux/bpf_common.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf_common.h' differs from latest version at 'include/uapi/linux/bpf_common.h'" >&2 )) || true
-	@(test -f ../../include/uapi/linux/netlink.h -a -f ../../../include/uapi/linux/netlink.h && ( \
-	(diff -B ../../include/uapi/linux/netlink.h ../../../include/uapi/linux/netlink.h >/dev/null) || \
-	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/netlink.h' differs from latest version at 'include/uapi/linux/netlink.h'" >&2 )) || true
-	@(test -f ../../include/uapi/linux/if_link.h -a -f ../../../include/uapi/linux/if_link.h && ( \
-	(diff -B ../../include/uapi/linux/if_link.h ../../../include/uapi/linux/if_link.h >/dev/null) || \
-	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h' differs from latest version at 'include/uapi/linux/if_link.h'" >&2 )) || true
 	@(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../include/uapi/linux/if_xdp.h && ( \
 	(diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/linux/if_xdp.h >/dev/null) || \
 	echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
-- 
2.30.2

