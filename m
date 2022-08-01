Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F639586252
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiHABit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiHABim (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089ECE3C;
        Sun, 31 Jul 2022 18:38:41 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 02136320076F;
        Sun, 31 Jul 2022 21:38:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 31 Jul 2022 21:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317919; x=1659404319; bh=HJ
        dDL6MBfDtps+1FT1nNKF79Ei+JMVz6uOUMAR+aJpk=; b=cQL9ePY+LFViB1DpCe
        cHvRZsGx14+Ndw/4yX38qdhWdgx2Ybv7SS1O20Q+qNbqORfZwTmmf15wiwhMjN5r
        F6kU4/7tjm6+nJ1KngqwrW3ifVHaH+fVHr/ZcWFfnDEWRl+HwYd7iKc5j6EUtc4M
        MW8ncj9nYQJMyV51Sj1NEZzMo4yuXinkemgB4VgfXA0uGdQxifx1b/ooqh0Eko3l
        WQT8J66kWz/YlPo+5MexQtZ/kR4kg9b4Y1bV7nGUjsVBjIDto0X0mbNHS1JPb3dk
        cRWeWYmLzYUxUt3WD4KWGhUxmAL1sssvcLxMJslJK/DHpw6LPbYVXtxpUxHX9gBo
        bHHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317919; x=1659404319; bh=HJdDL6MBfDtps
        +1FT1nNKF79Ei+JMVz6uOUMAR+aJpk=; b=BfuICqjjk9YC0N7sBU4Fv+/YpDRKC
        3ZO1GnJ6g1Y6efm0QwZHKwoFKlFWYUrbQ3Rt0SJzePN9VhIi0FXzSaM0O5ZYTWnb
        b3gSUn8AIcryQdtT5bpo7bg5ePfl4YJPfWU2HUCPio/AZppNXrDpxsznhLKcPWK3
        yd25XIq/P8I38IltjBRGo9OqA8+2UORHvlPMt6gO0RUHe48CxI6d/WT0Lo9Y+JjQ
        epih7hrv95N7p0jc/OWri0IyQ6zUBuv6G8PZuF4pCu87wz3YvOIcggvFGcR3jLn/
        7IZbDYc27RLyefW/oKAIa1h+73ryFcDPfgKtCwqy6n1qQfMq8VnxOSoMA==
X-ME-Sender: <xms:ny7nYqOPZvE3xZZo801GAU-SLz5edfshWDkuxSkLm8NZpB7IvsTQlQ>
    <xme:ny7nYo-28fnY-F3THTxjk2Cpr9rqBSKgdx80RB9akJY48gwB166UDDiLoizXhb7Dj
    _7XrO8DiVABkrPg3A>
X-ME-Received: <xmr:ny7nYhSNI9tPFFhUhm7lfIhw1OufFB4s9hcjbUgQpt7VAyEvQbExzqbCUgOkrgK1pzE7ryghNB7R1dCwgXgcwTjO80mE_ZgeWiJZvCdmEupB74RRGU1kG-yKxe3b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:ny7nYqt1NurZFreTjJMemfRdg13hp7R__Bfy3vLEYvc8GkhNRovU0w>
    <xmx:ny7nYieAz6Z_npzIl13ppcPfbsjHcMYExFdl2om5AhVJ1Sc8Shj99A>
    <xmx:ny7nYu02V-r_-k2c1pNaj1UNOtqQQqOMMQ_IggiTavBRrslK1A7TxQ>
    <xmx:ny7nYosCAqXfa-f6FW34iiTiaiQU_BgnLR8LlBAN8M7ZtmV8mEL8JA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:38 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v3 5/8] tools bpf_jit_disasm: Fix compilation error with new binutils
Date:   Sun, 31 Jul 2022 18:38:31 -0700
Message-Id: <20220801013834.156015-6-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220801013834.156015-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

binutils changed the signature of init_disassemble_info(), which now causes
compilation to fail for tools/bpf/bpf_jit_disasm.c, e.g. on debian
unstable. Relevant binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

Wire up the feature test and switch to init_disassemble_info_compat(),
which were introduced in prior commits, fixing the compilation failure.

I verified that bpf_jit_disasm can still disassemble bpf programs, both
with the old and new dis-asm.h API. With old binutils there's no change in
output before/after this patch. When comparing the output from old
binutils (2.35) to new bintuils with the patch (upstream snapshot) there
are a few output differences, but they are unrelated to this patch. An
example hunk is:
   f4:	mov    %r14,%rsi
   f7:	mov    %r15,%rdx
   fa:	mov    $0x2a,%ecx
-  ff:	callq  0xffffffffea8c4988
+  ff:	call   0xffffffffea8c4988
  104:	test   %rax,%rax
  107:	jge    0x0000000000000110
  109:	xor    %eax,%eax
- 10b:	jmpq   0x0000000000000073
+ 10b:	jmp    0x0000000000000073
  110:	cmp    $0x16,%rax

However, I had to use an older kernel to generate the bpf_jit_enabled = 2
output, as that has been broken since 5.18 / 1022a5498f6f:
https://lore.kernel.org/20220703030210.pmjft7qc2eajzi6c@alap3.anarazel.de

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/Makefile         | 5 ++++-
 tools/bpf/bpf_jit_disasm.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index b11cfc86a3d0..664601ab1705 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -34,7 +34,7 @@ else
 endif
 
 FEATURE_USER = .bpf
-FEATURE_TESTS = libbfd disassembler-four-args
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
 FEATURE_DISPLAY = libbfd disassembler-four-args
 
 check_feat := 1
@@ -56,6 +56,9 @@ endif
 ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
+ifeq ($(feature-disassembler-init-styled), 1)
+CFLAGS += -DDISASM_INIT_STYLED
+endif
 
 $(OUTPUT)%.yacc.c: $(srctree)/tools/bpf/%.y
 	$(QUIET_BISON)$(YACC) -o $@ -d $<
diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index c8ae95804728..a90a5d110f92 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <limits.h>
+#include <tools/dis-asm-compat.h>
 
 #define CMD_ACTION_SIZE_BUFFER		10
 #define CMD_ACTION_READ_ALL		3
@@ -64,7 +65,9 @@ static void get_asm_insns(uint8_t *image, size_t len, int opcodes)
 	assert(bfdf);
 	assert(bfd_check_format(bfdf, bfd_object));
 
-	init_disassemble_info(&info, stdout, (fprintf_ftype) fprintf);
+	init_disassemble_info_compat(&info, stdout,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	info.buffer = image;
-- 
2.37.0.3.g30cc8d0f14

