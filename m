Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F0E10A379
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2019 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfKZRm0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 12:42:26 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:45341 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKZRmZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 12:42:25 -0500
Received: by mail-pl1-f202.google.com with SMTP id k17so5785506pll.12
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2019 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=koHXHkycCC0RdtCRZro1StIOslXq5D+D62eiHw9Flhk=;
        b=M9osQM3xupebKiarCbBfaEBDCeRxLqS0ovX0pUR3Sa9DQ+2nYS8TRN0vYb74sAX4X8
         nEFBfEen0wg4+sPtWZ16NcSMYgq6Ne6v2GwCVfw9ogIox2HpGK4uHw+w4LLPpMUrMLHN
         OVOoVOPLgSdwIhpsHOU4OxoxSq3OmnUs0kPZp+1IEYYgeE8kQadAwrdkFL+N1iNB/buy
         jSZUkTWMW6EJh+/5kWP+55yxCczt1TSvJU0W6Myehc9aAGABL/uJ8ZwZa+Ev44UCLR6h
         nnQzoHSEj3eyFwZA+h9RAaD//8N1X1a81eLQEwkYq4kV3AlW1G3HzSNrL+yzlRgJXXh4
         RXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=koHXHkycCC0RdtCRZro1StIOslXq5D+D62eiHw9Flhk=;
        b=pyN+GvnQVGLqLblFOCPt+if99x8lFDR7fYgqVw5bp7/iNiWBAbbcm0MCcCrd8SH4Hd
         pTJFglrtlrkvwSXAyhx+IxiltqwsvIUoV62VfP4Ky4o/A89J2zcyTpgNMYxCdxXTslTO
         sEVFD2MUHvxeuUdwrPMrS8X+RPAQcdBsJxIvjBpKTDtYz7DPmoWSVFXGxNtuQSd9L34Q
         TxB1pOsDYj4OSqZZd013q7Is8Dh57d53cCikER9ZCi4PxOQVjNywktMhAFToeCaATUtl
         HW+sqhw2lIgLQ1sQZvy849xYTEEU+RCU5BieMrjgYk51gKhq+vD334l+DHDGIVL3PCgZ
         gtPw==
X-Gm-Message-State: APjAAAWi8HE1Dcypz6/EwfY3UpEALZQkGU9+LSNSWsZ3MdsRnqPdMhWi
        odtyV210lCy9qsXVA4aMJrlt/NY=
X-Google-Smtp-Source: APXvYqxUNd/vab7H1MJ9YeZ6yNLacHCJmUTYhxrtASbw9nQ2yktSp6GU9aeQiPpp/2yQClDJbgbnd9s=
X-Received: by 2002:a63:1d0a:: with SMTP id d10mr40133518pgd.242.1574790144653;
 Tue, 26 Nov 2019 09:42:24 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:42:21 -0800
Message-Id: <20191126174221.200522-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf] bpf: support pre-2.25-binutils objcopy for vmlinux BTF
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If vmlinux BTF generation fails, but CONFIG_DEBUG_INFO_BTF is set,
.BTF section of vmlinux is empty and kernel will prohibit
BPF loading and return "in-kernel BTF is malformed".

--dump-section argument to binutils' objcopy was added in version 2.25.
When using pre-2.25 binutils, BTF generation silently fails. Convert
to --only-section which is present on pre-2.25 binutils.

Documentation/process/changes.rst states that binutils 2.21+
is supported, not sure those standards apply to BPF subsystem.

Fixes: 341dfcf8d78ea ("btf: expose BTF info through sysfs")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 scripts/link-vmlinux.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 06495379fcd8..c56ba91f52b0 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -127,7 +127,8 @@ gen_btf()
 		cut -d, -f1 | cut -d' ' -f2)
 	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
 		awk '{print $4}')
-	${OBJCOPY} --dump-section .BTF=.btf.vmlinux.bin ${1} 2>/dev/null
+	${OBJCOPY} --set-section-flags .BTF=alloc -O binary \
+		--only-section=.BTF ${1} .btf.vmlinux.bin 2>/dev/null
 	${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
 		--rename-section .data=.BTF .btf.vmlinux.bin ${2}
 }
-- 
2.24.0.432.g9d3f5f5b63-goog

