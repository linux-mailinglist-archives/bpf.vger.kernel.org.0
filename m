Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E58710A71A
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2019 00:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfKZX2W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Nov 2019 18:28:22 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37816 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKZX2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Nov 2019 18:28:22 -0500
Received: by mail-pl1-f201.google.com with SMTP id w17so8628816plp.4
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2019 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VDZqM1iojgFZUCYrHNzPRvpM2lTnxWFPVSbwolce2xQ=;
        b=D08ZOJIZtFfBsctfgxLgpWHDfInaQEqGQykJ8Uo8f9Fj3MY4yyPmFfbisQhlHtZNSW
         hsApKcsQ1fRYKV3RL0DiHFvFrv7wpwnL+gG6Ibu8DQpQzbUQbHXCR/LQdSEfYEgohxrC
         mS9g976WGt0Fy5RXHKwFAXwox3q5syPBta84MgzjXdRYALKPxRonqFG3lls9B4KdkATE
         4YZ2YVa5b+nT7CoN8k1PLPwIM72Ace39u6WH04ZEFHEqNVeUPIzulOC7oS7SbipgkOh/
         Wrf3amdEIC2JpshDWRpYGEtTu4oLbwmPqA0vzyNTT/DDvgBlbO08usr//RlsOHOzOVpn
         I0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VDZqM1iojgFZUCYrHNzPRvpM2lTnxWFPVSbwolce2xQ=;
        b=LAQgecrEWB7HT32OB0tsDnccNwC3osB3mi4W2vjUM0GHtcP8ggQGAWOmW7p+PPDDx7
         9K3EWrulaR9oY7BAyL/ET1okqe1zrcfvLC1NO/gH92pFgrnRecyvGAaT8XwV03RBtzdO
         gH8PS3rOGb1MgC3Nn29XubrY8kRICqaGGv52Scjz2Fa0Y+coXsFQ2badvLU61Hcr9Fb3
         YeWMR8c6UyA+6tXpGKGnDoDwAtYFywE4YdS3UvHKSHpFYTblcweNvVFmS++8Tdf5hF7V
         kPqoLl03Tzky5d7u5GUBB7pafk/Cy/vmIn15zenuUtvHOypxX8OpLul277v3SUqMu1K2
         3gjQ==
X-Gm-Message-State: APjAAAUxxW6ehfrKxcpZOK/Ff1517aqfisqAISYMSyvgokUDcJEV1K/N
        VtvRwCOIYw5CIvEuEXX6oNSqRtw=
X-Google-Smtp-Source: APXvYqys17Q47p4LoALIoE05qH+lx+rls48bt8VihVQH0ktok1EKTIGLiiRn/o73BrloNEDrRUH5Nh0=
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr1228739pgj.17.1574810901241;
 Tue, 26 Nov 2019 15:28:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:28:18 -0800
Message-Id: <20191126232818.226454-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf v2] bpf: support pre-2.25-binutils objcopy for vmlinux BTF
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
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

v2:
* exit and print an error if gen_btf fails (John Fastabend)

Cc: Andrii Nakryiko <andriin@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Fixes: 341dfcf8d78ea ("btf: expose BTF info through sysfs")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 scripts/link-vmlinux.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 06495379fcd8..2998ddb323e3 100755
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
@@ -253,6 +254,10 @@ btf_vmlinux_bin_o=""
 if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
 	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
 		btf_vmlinux_bin_o=.btf.vmlinux.bin.o
+	else
+		echo >&2 "Failed to generate BTF for vmlinux"
+		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
+		exit 1
 	fi
 fi
 
-- 
2.24.0.432.g9d3f5f5b63-goog

