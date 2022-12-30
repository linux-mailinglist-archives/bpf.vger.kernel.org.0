Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE376597CB
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiL3LjA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 06:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiL3Li7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 06:38:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED91AD9E
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 03:38:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n12so9125297pjp.1
        for <bpf@vger.kernel.org>; Fri, 30 Dec 2022 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/zHQ7C/1hwR4uoIgftTGe8gWm7LYuzkWgGstoQ9CsfM=;
        b=dx0C/DbyadxlXvzgiQwGswsxfpXQ1fLCXYdyaB9BlOHNqOOA7Tifncz4KkvCvd8zHC
         /LCbGx8FLVLOhxwyk3zTKDmfH9DhmnyPq5BBERPvIzevTyz2x1D+pbPAetQqYwJw08Lv
         PGwPI3XhSBnbeEr7rX8JItAQxcQBdMxTLRkOKjnPbeG6vcnLKBMtpSVo9Zbv5wS15xnD
         MwKOqXQVCA2XbkmIzwFRrkjD4jAi5WpULPRZvtcCgdjnV6ykgtxXocfvAHNfFXsshaDn
         VSVZCOIqbXzr83w2pMxpiMrpLlg09zsOUFI1Gj/jMGbfHuO7D3fK+FHgqsz82IHWztFJ
         CPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zHQ7C/1hwR4uoIgftTGe8gWm7LYuzkWgGstoQ9CsfM=;
        b=4t0prYv0unfiv9JDjQdF2vbDqiolEwCOjBk5DZxI3wdf4krzppIWeGBJhm8KngqMJG
         TXAXH9YfQ4poGG2p6NDL3pOLTclL2neujZB2kHoiszpgy9cIXfEWbPsWj9/rblvPYyAK
         lz/mEIirNuHvZ9t+fp9zG0gSmc8bFwtiyQm+xmmQrLFskdDWxbCwKMh/1WNshRV7DwOc
         DYfvtkYycYY0C6UxKPEaRMlEW8M45mAFAz77dd2MbjVAyWFZDTNP4+MGQr3QCNaXztrG
         Rv+4FQptF1zUKKhEOVnZJPGRNm59IH9qM18RCHiaWJtqnE3TJRGkBJJz7TKsLzW6R8Ew
         eG6Q==
X-Gm-Message-State: AFqh2krVQgdW78wC5L2fe2j3Er4rBAeNdP+BWIRrjfLgpKt6DsuKWwkD
        FAvgw/KisbIN1uhMxH40kTqg6t0MMsw=
X-Google-Smtp-Source: AMrXdXtOvsR7JNfRGdzk1kjRYofW18Twcn7Q7nKqRazx1APDSN73mkJNrDgXCK2P9KlpiVlmZi0olw==
X-Received: by 2002:a17:902:b60d:b0:192:6464:f433 with SMTP id b13-20020a170902b60d00b001926464f433mr22642675pls.1.1672400331329;
        Fri, 30 Dec 2022 03:38:51 -0800 (PST)
Received: from localhost.localdomain ([1.202.165.115])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001897e2fd65dsm10855254plb.9.2022.12.30.03.38.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Dec 2022 03:38:50 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next] bpf, x86_64: fix JIT to dump the valid insn
Date:   Fri, 30 Dec 2022 19:38:32 +0800
Message-Id: <20221230113832.22938-1-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

With bpf_jit_binary_pack_finalize invoked, we copy
rw_header to header and then image/insn is valid.

Write a test BPF prog which include subprog:

$ llvm-objdump -d subprog.o
Disassembly of section .text:
0000000000000000 <subprog>:
       0:	18 01 00 00 73 75 62 70 00 00 00 00 72 6f 67 00	r1 = 29114459903653235 ll
       2:	7b 1a f8 ff 00 00 00 00	*(u64 *)(r10 - 8) = r1
       3:	bf a1 00 00 00 00 00 00	r1 = r10
       4:	07 01 00 00 f8 ff ff ff	r1 += -8
       5:	b7 02 00 00 08 00 00 00	r2 = 8
       6:	85 00 00 00 06 00 00 00	call 6
       7:	95 00 00 00 00 00 00 00	exit
Disassembly of section raw_tp/sys_enter:
0000000000000000 <entry>:
       0:	85 10 00 00 ff ff ff ff	call -1
       1:	b7 00 00 00 00 00 00 00	r0 = 0
       2:	95 00 00 00 00 00 00 00	exit

Without this patch, kernel print message:
[  580.775387] flen=8 proglen=51 pass=3 image=ffffffffa000c20c from=kprobe-load pid=1643
[  580.777236] JIT code: 00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  580.779037] JIT code: 00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  580.780767] JIT code: 00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
[  580.782568] JIT code: 00000030: cc cc cc

$ bpf_jit_disasm
51 bytes emitted from JIT compiler (pass:3, flen:8)
ffffffffa000c20c + <x>:
   0:	int3
   1:	int3
   2:	int3
   3:	int3
   4:	int3
   5:	int3
   ...

To fix this issue:
[  260.016071] flen=3 proglen=20 pass=1 image=ffffffffa000c11c from=kprobe-load pid=1568
[  260.018094] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 e8 38 00 00 00
[  260.020124] JIT code: 00000010: 31 c0 c9 c3
[  260.021229] flen=8 proglen=51 pass=1 image=ffffffffa000c164 from=kprobe-load pid=1568
[  260.023132] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 08 00
[  260.025129] JIT code: 00000010: 00 00 48 bf 73 75 62 70 72 6f 67 00 48 89 7d f8
[  260.027199] JIT code: 00000020: 48 89 ef 48 83 c7 f8 be 08 00 00 00 e8 9e 19 1d
[  260.029226] JIT code: 00000030: e1 c9 c3

$ bpf_jit_disasm
51 bytes emitted from JIT compiler (pass:1, flen:8)
ffffffffa000c164 + <x>:
   0:	nopl   0x0(%rax,%rax,1)
   5:	xchg   %ax,%ax
   7:	push   %rbp
   8:	mov    %rsp,%rbp
   b:	sub    $0x8,%rsp
  12:	movabs $0x676f7270627573,%rdi
  1c:	mov    %rdi,-0x8(%rbp)
  20:	mov    %rbp,%rdi
  23:	add    $0xfffffffffffffff8,%rdi
  27:	mov    $0x8,%esi
  2c:	callq  0xffffffffe11d19cf
  31:	leaveq
  32:	retq

$ bpf_jit_disasm
20 bytes emitted from JIT compiler (pass:1, flen:3)
ffffffffa000c11c + <x>:
   0:	nopl   0x0(%rax,%rax,1)
   5:	xchg   %ax,%ax
   7:	push   %rbp
   8:	mov    %rsp,%rbp
   b:	callq  0x0000000000000048
  10:	xor    %eax,%eax
  12:	leaveq
  13:	retq

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 36ffe67ad6e5..4e017102cc16 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2543,9 +2543,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		cond_resched();
 	}
 
-	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, proglen, pass + 1, image);
-
 	if (image) {
 		if (!prog->is_func || extra_pass) {
 			/*
@@ -2561,6 +2558,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 				goto out_image;
 			}
 
+			if (bpf_jit_enable > 1)
+				bpf_jit_dump(prog->len, proglen, pass + 1, image);
+
 			bpf_tail_call_direct_fixup(prog);
 		} else {
 			jit_data->addrs = addrs;
-- 
2.27.0

