Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C8187583
	for <lists+bpf@lfdr.de>; Mon, 16 Mar 2020 23:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgCPWZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 18:25:22 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54779 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPWZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 18:25:22 -0400
Received: by mail-pf1-f201.google.com with SMTP id v14so13872125pfm.21
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CDSTXSoz8JLvnbI4Rvpwb3UtnFj/UPBOq4cipKiHAa8=;
        b=mfudS3gFLjCVkxeKqKuIti5kPRwYSFzRUQXaEKSHT2SBuaKTMjz4B2nEV0DChQ09hs
         jSStQPdDtrxV/y9xuUa4fv0Vqi0LjNFMjlXKBMfWhmZ914PhJowPNwAAZQhvfgjJwVCD
         3CuKszPZEhXOVFK+RYTRwlW8lXDHKZsua/wTvL0umNojwdAncQOeQHYO+KT//TjLcilb
         Y4TsaV1va7HT4Z9CZrCMDxVbXkQdALo30MEPdokZ3wHKdvVu/jWllq2ieItEXavSYc+y
         PAEyGtKkZyqTAAl+lvSIMbzAOAddDp9Cwq68S8V+ZIfLE8Ks8GSEowoDFHFo75Q3LKEw
         y2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CDSTXSoz8JLvnbI4Rvpwb3UtnFj/UPBOq4cipKiHAa8=;
        b=H5Ueg8yjWCp3uo8ux5J51265XBanJRtvBWiXNaS6ggjrnjVuuXvIP7x5BSIJ8/TPJc
         ASpuBuXuIIpCP47PMLPZUVLS14puSrv7u1YWkEOpo6AECejphJL07zsdcN/MEBkleQXl
         1i49xeMhWD5gCTXns7ZVDZAalWELP+nCGRJSvk+tPg8RNdLK/YbQFy4DZzXKjAcFLvSi
         0LCvtguSpnaM0S6QM4wwkeiEjuL/7ZLnPo3nrY5mESv0VmP/yZihn8ojpPHqnQ6lQBuO
         waIWbuzKr+WtxCsYxExv1BjCZFG++/l0th3Phk7uHLUBULoRZ3/KUycKqoI/S6H1D8vv
         OfTw==
X-Gm-Message-State: ANhLgQ2i5ZyvFE+bycmbYOGcWmS8o+z3JjRW4Bf6frVVJX2xigP8ROug
        RqrWJKz1+JmiP8DDao1dmcsoK0Q=
X-Google-Smtp-Source: ADFU+vtg+o9KJH/sNGo1ZSxUm97WYU4MunF3koiZCvSAQPSsFPYxKlf2EL51qt/hdH3VSOSoTO5/z+s=
X-Received: by 2002:a63:8342:: with SMTP id h63mr2003915pge.141.1584397521541;
 Mon, 16 Mar 2020 15:25:21 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:25:18 -0700
Message-Id: <20200316222518.191601-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH bpf] bpf: Support llvm-objcopy for vmlinux BTF
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit da5fb18225b4 ("bpf: Support pre-2.25-binutils objcopy for vmlinux
BTF") switched from --dump-section to
--only-section/--change-section-address for BTF export assuming
those ("legacy") options should cover all objcopy versions.

Turns out llvm-objcopy doesn't implement --change-section-address [1],
but it does support --dump-section. Let's partially roll back and
try to use --dump-section first and fall back to
--only-section/--change-section-address for the older binutils.

1. https://bugs.llvm.org/show_bug.cgi?id=45217

Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/871
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 scripts/link-vmlinux.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index dd484e92752e..8ddf57cbc439 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -127,6 +127,16 @@ gen_btf()
 		cut -d, -f1 | cut -d' ' -f2)
 	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
 		awk '{print $4}')
+
+	# Compatibility issues:
+	# - pre-2.25 binutils objcopy doesn't support --dump-section
+	# - llvm-objcopy doesn't support --change-section-address, but
+	#   does support --dump-section
+	#
+	# Try to use --dump-section which should cover both recent
+	# binutils and llvm-objcopy and fall back to --only-section
+	# for pre-2.25 binutils.
+	${OBJCOPY} --dump-section .BTF=$bin_file ${1} 2>/dev/null || \
 	${OBJCOPY} --change-section-address .BTF=0 \
 		--set-section-flags .BTF=alloc -O binary \
 		--only-section=.BTF ${1} .btf.vmlinux.bin
-- 
2.25.1.481.gfbce0eb801-goog

