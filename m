Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7510C078
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2019 23:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK0W6D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Nov 2019 17:58:03 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:41331 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfK0W6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Nov 2019 17:58:03 -0500
Received: by mail-qv1-f73.google.com with SMTP id m12so15777916qvv.8
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2019 14:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mo5o+Ecd/yLI7tHcwQjCfzTu2XUere/oZo1lhAcUfOo=;
        b=PLqUksAJNKMrDkQktb55ZRr5VGYVQe5v+6KLWNXAPiQtZXRgMJQaHYUAXVG4i4n6J/
         XTJx8vOFoR+xki8GZ4sHnd9YSBRDHN5RSe+wRsm9qXlpht39a8vxo7oJ0ySWtsboMwEY
         JN4yot1nZvxM1ybgdIk4JenF4E4qemb/TrwwxiQAtuQpH0spHZQBKgzX8lmdAQtG7P5R
         01u8KoyRs6cLORQtT1R3DWKYbm3a9+/78w99JFhx2igCJvrJKmN1Usa+OUQ74UNl+/6k
         WpmTOhYJF56CthrgEk86v5hhb5XeXG+V96L9ICHsWM4UHhYhkXz3nNEJ73dWoT+e0sBj
         jSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mo5o+Ecd/yLI7tHcwQjCfzTu2XUere/oZo1lhAcUfOo=;
        b=ZoZWBHn23fywYUQaF+Yq29JebzK6+9tvok5gzfwicRB839UpVBaAj4YbP/kM8m2liX
         7w+E/qnH/bH0Ej1UlUuvuf5PZ4MxMq32tA+VOl9KB4fnZayMMfANMANxzwh/SmOgQtor
         JMB/ap/+NY/ZQ+Pem8DEyS+VqEoDdA64x52LOP4+ByZXm63Kk0aI8bm96plTym/6IFxO
         fWnkO6AobfZbxwcQ0lQ2NeJqzFv31wgJRDmY0EOEdpV0J8WR8Ext5xGz0+aI3ez5urqr
         9xFSoQj5xTiJKBrn1GhvtxicQPTgWP1mMu3RVlazyRhq+gGBEakb5pWWvsK9Br98VxqC
         Ga/w==
X-Gm-Message-State: APjAAAWrWVbWTiLD+xhfnqRReoPfr9ZWPMRtFcyiM2w9RcLuYKjC1Pii
        4WSDw3w6dg5K/EY1YCvk5mbdB8E=
X-Google-Smtp-Source: APXvYqxqRrQck2Qg1SazChf5GGQyDSK+xKWIcVcoD5+klqd5qbdi9axf0rFQG4/RD2nh+N9PdFj0dJI=
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr7037653qkl.115.1574895481604;
 Wed, 27 Nov 2019 14:58:01 -0800 (PST)
Date:   Wed, 27 Nov 2019 14:57:59 -0800
Message-Id: <20191127225759.39923-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf] bpf: force .BTF section start to zero when dumping from vmlinux
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While trying to figure out why fentry_fexit selftest doesn't pass for me
(old pahole, broken BTF), I found out that my latest patch can break vmlinux
.BTF generation. objcopy preserves section start when doing --only-section,
so there is a chance (depending on where pahole inserts .BTF section) to
have leading empty zeroes. Let's explicitly force section offset to zero.

Before:
$ objcopy --set-section-flags .BTF=alloc -O binary \
	--only-section=.BTF vmlinux .btf.vmlinux.bin
$ xxd .btf.vmlinux.bin | head -n1
00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................

After:
$ objcopy --change-section-address .BTF=0 \
	--set-section-flags .BTF=alloc -O binary \
	--only-section=.BTF vmlinux .btf.vmlinux.bin
$ xxd .btf.vmlinux.bin | head -n1
00000000: 9feb 0100 1800 0000 0000 0000 80e1 1c00  ................
          ^BTF magic

As part of this change, I'm also dropping '2>/dev/null' from objcopy
invocation to be able to catch possible other issues (objcopy doesn't
produce any warnings for me anymore, it did before with --dump-section).

Cc: Andrii Nakryiko <andriin@fb.com>
Fixes: da5fb18225b4 ("bpf: Support pre-2.25-binutils objcopy for vmlinux BTF")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 scripts/link-vmlinux.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 2998ddb323e3..436379940356 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -127,8 +127,9 @@ gen_btf()
 		cut -d, -f1 | cut -d' ' -f2)
 	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
 		awk '{print $4}')
-	${OBJCOPY} --set-section-flags .BTF=alloc -O binary \
-		--only-section=.BTF ${1} .btf.vmlinux.bin 2>/dev/null
+	${OBJCOPY} --change-section-address .BTF=0 \
+		--set-section-flags .BTF=alloc -O binary \
+		--only-section=.BTF ${1} .btf.vmlinux.bin
 	${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
 		--rename-section .data=.BTF .btf.vmlinux.bin ${2}
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

