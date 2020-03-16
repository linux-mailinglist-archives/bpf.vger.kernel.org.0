Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0D187620
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 00:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbgCPXPV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 19:15:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732855AbgCPXPU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 19:15:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so10820519pfj.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VACBqMmuUHfZrQljDnWjeCAmWzgBMaH+KCVaAAAuZ6c=;
        b=Ey+kZ0U3AoQghEc3SuVArCyPBPxt7yimndQxfwskBMnLhbnKQi07BybzhXY7U6XNxz
         cLMWgNfZNPTodPDTkEcqZZ4/7rR18JBHqtngALreNvHfzlw4VqBD10eXk+W5WoG5Qkyp
         0GoJxLhOGnOc0hwy8DS6arS8cVt9dpGmwH/lNjSFTgJpnrJVkWsRs/gRtsogKmKI3dPT
         JvBZZuOfT75TAJOhT3mtjKxIv/AEVcm2Q6BksP/N8Rp/BCYXOJM+tdfSYn4X+eKHcun1
         I+OVW177TXn74IDNBp1crl/s+vx1H+UuVuB4ywewunehTfomH61sCpn3ImIMqyx0gFz1
         WAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VACBqMmuUHfZrQljDnWjeCAmWzgBMaH+KCVaAAAuZ6c=;
        b=WXvvy97cm8ejtDRagrymkEmkqvz7JuzK1YEoeyWPXmD1GssKllvvDfqWhD3gn4Q/xJ
         5X53ltMris6uiGn8wsnzCUwCa6cfSxJxHeHF44pgiwinY6iZ2tr/5H5y+003vzAiKA5v
         XJjuH66CkVnxukYezRrduf3JJfQmuci3MKhv0/FBu09WcNUSATpn1ni8TQdo60T4qx/s
         7Wu2Z1cBDxsdebdnsFt9VaAO6XgTYBEoLmbLJCZsWog/ID4NpPNn52UJOorV4ZQ7Q/Bf
         hsmibNah33YoeA+d1WsNQkGlEs3LDiMBi/fnG1IjuuIfVTQB9HOjIp73iDLKAHvA4l9O
         9tIw==
X-Gm-Message-State: ANhLgQ1boXxXIwpO5dExCIffEqRr5oSNF7d5+vAqlYxeqPB//Gla7oph
        n+8L2xKLIGMdts4xbKcVgXBEFg==
X-Google-Smtp-Source: ADFU+vtOEp3XMRzlaAAAde3I8gauHnqMXs8TtoJ5bmzo7Tf3J86OjOK42DLsh7tmCkVM5ho7aX3FSA==
X-Received: by 2002:a65:458e:: with SMTP id o14mr2137643pgq.323.1584400519503;
        Mon, 16 Mar 2020 16:15:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id b10sm846844pfo.215.2020.03.16.16.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 16:15:18 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:15:16 -0700
From:   Fangrui Song <maskray@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf] bpf: Support llvm-objcopy for vmlinux BTF
Message-ID: <20200316231516.kakoiumx4afph34t@google.com>
References: <20200316222518.191601-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200316222518.191601-1-sdf@google.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-03-16, Stanislav Fomichev wrote:
>Commit da5fb18225b4 ("bpf: Support pre-2.25-binutils objcopy for vmlinux
>BTF") switched from --dump-section to
>--only-section/--change-section-address for BTF export assuming
>those ("legacy") options should cover all objcopy versions.
>
>Turns out llvm-objcopy doesn't implement --change-section-address [1],
>but it does support --dump-section. Let's partially roll back and
>try to use --dump-section first and fall back to
>--only-section/--change-section-address for the older binutils.
>
>1. https://bugs.llvm.org/show_bug.cgi?id=45217
>
>Fixes: df786c9b9476 ("bpf: Force .BTF section start to zero when dumping from vmlinux")
>Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>Reported-by: Nathan Chancellor <natechancellor@gmail.com>
>Link: https://github.com/ClangBuiltLinux/linux/issues/871
>Signed-off-by: Stanislav Fomichev <sdf@google.com>
>---
> scripts/link-vmlinux.sh | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
>index dd484e92752e..8ddf57cbc439 100755
>--- a/scripts/link-vmlinux.sh
>+++ b/scripts/link-vmlinux.sh
>@@ -127,6 +127,16 @@ gen_btf()
> 		cut -d, -f1 | cut -d' ' -f2)
> 	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
> 		awk '{print $4}')
>+
>+	# Compatibility issues:
>+	# - pre-2.25 binutils objcopy doesn't support --dump-section
>+	# - llvm-objcopy doesn't support --change-section-address, but
>+	#   does support --dump-section
>+	#
>+	# Try to use --dump-section which should cover both recent
>+	# binutils and llvm-objcopy and fall back to --only-section
>+	# for pre-2.25 binutils.
>+	${OBJCOPY} --dump-section .BTF=$bin_file ${1} 2>/dev/null || \
> 	${OBJCOPY} --change-section-address .BTF=0 \
> 		--set-section-flags .BTF=alloc -O binary \
> 		--only-section=.BTF ${1} .btf.vmlinux.bin
>-- 
>2.25.1.481.gfbce0eb801-goog

So let me take advantage of this email to ask some questions about
commit da5fb18225b4 ("bpf: Support pre-2.25-binutils objcopy for vmlinux BTF").

Does .BTF have the SHF_ALLOC flag?
Is it a GNU objcopy<2.25 bug that objcopy --set-section-flags .BTF=alloc -O binary --only-section=.BTF does not skip the content?
Non-SHF_ALLOC sections usually have 0 sh_addr. Why do they need --change-section-address .BTF=0 at all?

Regarding

>Turns out llvm-objcopy doesn't implement --change-section-address [1],

This option will be difficult to implement in llvm-objcopy if we intend
it to have a GNU objcopy compatible behavior.
Without --only-section, it is not very clear how
--change-section-{address,vma,lma} will affect program headers.
There will be a debate even if we decide to implement them in llvm-objcopy.

Some PT_LOAD rewriting examples:

   objcopy --change-section-address .plt=0 a b
   objcopy --change-section-address .text=0 a b

There is another bug related to -B
(https://github.com/ClangBuiltLinux/linux/issues/871#issuecomment-599790909):

+ objcopy --change-section-address .BTF=0 --set-section-flags .BTF=alloc
-O binary --only-section=.BTF .tmp_vmlinux.btf .btf.vmlinux.bin
+ objcopy -I binary -O elf64-x86-64 -B x86_64 --rename-section .data=.BTF .btf.vmlinux.bin .btf.vmlinux.bin.o
objcopy: architecture x86_64 unknown
+ echo 'Failed to generate BTF for vmlinux'

It should be i386:x86_64.
