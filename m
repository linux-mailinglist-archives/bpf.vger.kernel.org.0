Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0466675BC4
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjATRlT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 12:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjATRlS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 12:41:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B62DBC3
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 09:41:17 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o7so6265744ljj.8
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYq5tcuon8t75nn0BoioPzi3615uH3zFBisghBVqchM=;
        b=Y+Mif95YqnT02S9xc1EkcnetpAHTX0a3OaDI0PyzkIIB5EnOxgATzcjYyggr1+GBSN
         jiURrN9ozfTknWjW3SrAFxtuF+gataJeOO3jZULO6d3uw0CRgPHzdeZpnbIyuEF6WBSk
         dmPSBVaYqHy+OMywn07xtv9fYFw5EtrDoFx8N5iwJkyvbecfAy/zx7s8pGstXwCSNBv1
         s7JI9TWhGCoy2Nh242Fb2hft+pTtqkSACGG3b53P+XiS1Vv/dGGlm9z/rrwriK40HBOi
         PV7BSSk/1ZTpwBL1uC4kIUb+9nJLfFjQY8Giau2bUQrc7ChUUyUebAgxNjnIGl69HsiP
         eoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FYq5tcuon8t75nn0BoioPzi3615uH3zFBisghBVqchM=;
        b=eS6MtZtZzabsRu6Q2reYP7uLVeX/zv+8LWoYjAy+kf/W4fZ46WrDtyY71Mp6Gm0lO/
         Mt2h8ccfjNxhe+P5Jk/6YSyUmxtiO5nk2I09G1+6KBPpd7BV1EcnHY7t2jKr/LnHR7Ym
         TsNPerVa04YcMsWZG91j4On1HF4JcniZlH13ayE8qvaEn/4wyEsP/5q+ID3B+W4Djg7D
         bvEVdCqeoGWqjvpA3qoTmTYV3yphhHPRZye/z/alOFmrIbUR7z/iaRyt3lFi6YIR9M0N
         VIMAm8q4SGUnk2CmHfaAU9JH0eyXRCky8wYpXyu4mx/O1ZpL2DuUHJioz+Avg2C2adz0
         /yzA==
X-Gm-Message-State: AFqh2kqhHUDE4E3ORwMVh8t1/Zmr/qyq9oOeJADK+aGZV34CvQY5bR5K
        z1gUjLsoyHvgJDOq6AGTYaInV71gy5ctdIUlOlU=
X-Google-Smtp-Source: AMrXdXsBzRYEsY7MuEchNmWixdnNSVm0OVxFONUInsggBWlcNnhnRDViKbyMWNeklFbvxTuHBSK5Ar52bj2td+8bdeQ=
X-Received: by 2002:a2e:9e0d:0:b0:28b:88da:35b with SMTP id
 e13-20020a2e9e0d000000b0028b88da035bmr1392641ljk.364.1674236475611; Fri, 20
 Jan 2023 09:41:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Jan 2023 18:40:38 +0100
Message-ID: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
Subject: pahole: New version 1.25 release?
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000663d2e05f2b58eb5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000663d2e05f2b58eb5
Content-Type: text/plain; charset="UTF-8"

Hi Arnaldo,

I use CONFIG_DEBUG_INFO_BTF=y with LLVM-15.

Darkly, I remember I needed some post-v1.24 fixes.

Currently, I use:

$ git describe
v1.24-26-gb72f5188856d

commit b72f5188856d
"dwarves: Zero-initialize struct cu in cu__new() to prevent incorrect BTF types"

Any plans to release a pahole version 1.25?

Thanks.

Best regards,
-Sedat-

P.S.: I still carry this diff around (attached as diff as Gmail might
truncate the following lines):

$ cd /path/to/pahole.git

$ git diff dwarf_loader.c
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5a74035c5708..96ce5db4f5bc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2808,8 +2808,8 @@ static int __cus__load_debug_types(struct
conf_load *conf, Dwfl_Module *mod, Dwa
       return 0;
}

-/* Match the define in linux:include/linux/elfnote.h */
-#define LINUX_ELFNOTE_BUILD_LTO                0x101
+/* Match the define in linux:include/linux/elfnote-lto.h */
+#define LINUX_ELFNOTE_LTO_INFO         0x101

static bool cus__merging_cu(Dwarf *dw, Elf *elf)
{
@@ -2827,7 +2827,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
                       size_t name_off, desc_off, offset = 0;
                       GElf_Nhdr hdr;
                       while ((offset = gelf_getnote(data, offset,
&hdr, &name_off, &desc_off)) != 0) {
-                               if (hdr.n_type != LINUX_ELFNOTE_BUILD_LTO)
+                               if (hdr.n_type != LINUX_ELFNOTE_LTO_INFO)
                                       continue;

                               /* owner is Linux */

$ cd /path/to/linux.git

$ git describe
v6.2-rc4-77-gd368967cb103

$ git grep LINUX_ELFNOTE_LTO_INFO include/linux/elfnote-lto.h
include/linux/elfnote-lto.h:#define LINUX_ELFNOTE_LTO_INFO      0x101
include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 1)
include/linux/elfnote-lto.h:#define BUILD_LTO_INFO
ELFNOTE32("Linux", LINUX_ELFNOTE_LTO_INFO, 0)
dileks@iniza:~/src/linux/git$ git describe
v6.2-rc4-195-gf609936e078d

-EOT-

--000000000000663d2e05f2b58eb5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="dwarf_loader-LINUX_ELFNOTE_LTO_INFO.diff"
Content-Disposition: attachment; 
	filename="dwarf_loader-LINUX_ELFNOTE_LTO_INFO.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ld4t4bx20>
X-Attachment-Id: f_ld4t4bx20

ZGlmZiAtLWdpdCBhL2R3YXJmX2xvYWRlci5jIGIvZHdhcmZfbG9hZGVyLmMKaW5kZXggNWE3NDAz
NWM1NzA4Li45NmNlNWRiNGY1YmMgMTAwNjQ0Ci0tLSBhL2R3YXJmX2xvYWRlci5jCisrKyBiL2R3
YXJmX2xvYWRlci5jCkBAIC0yODA4LDggKzI4MDgsOCBAQCBzdGF0aWMgaW50IF9fY3VzX19sb2Fk
X2RlYnVnX3R5cGVzKHN0cnVjdCBjb25mX2xvYWQgKmNvbmYsIER3ZmxfTW9kdWxlICptb2QsIER3
YQogCXJldHVybiAwOwogfQogCi0vKiBNYXRjaCB0aGUgZGVmaW5lIGluIGxpbnV4OmluY2x1ZGUv
bGludXgvZWxmbm90ZS5oICovCi0jZGVmaW5lIExJTlVYX0VMRk5PVEVfQlVJTERfTFRPCQkweDEw
MQorLyogTWF0Y2ggdGhlIGRlZmluZSBpbiBsaW51eDppbmNsdWRlL2xpbnV4L2VsZm5vdGUtbHRv
LmggKi8KKyNkZWZpbmUgTElOVVhfRUxGTk9URV9MVE9fSU5GTwkJMHgxMDEKIAogc3RhdGljIGJv
b2wgY3VzX19tZXJnaW5nX2N1KER3YXJmICpkdywgRWxmICplbGYpCiB7CkBAIC0yODI3LDcgKzI4
MjcsNyBAQCBzdGF0aWMgYm9vbCBjdXNfX21lcmdpbmdfY3UoRHdhcmYgKmR3LCBFbGYgKmVsZikK
IAkJCXNpemVfdCBuYW1lX29mZiwgZGVzY19vZmYsIG9mZnNldCA9IDA7CiAJCQlHRWxmX05oZHIg
aGRyOwogCQkJd2hpbGUgKChvZmZzZXQgPSBnZWxmX2dldG5vdGUoZGF0YSwgb2Zmc2V0LCAmaGRy
LCAmbmFtZV9vZmYsICZkZXNjX29mZikpICE9IDApIHsKLQkJCQlpZiAoaGRyLm5fdHlwZSAhPSBM
SU5VWF9FTEZOT1RFX0JVSUxEX0xUTykKKwkJCQlpZiAoaGRyLm5fdHlwZSAhPSBMSU5VWF9FTEZO
T1RFX0xUT19JTkZPKQogCQkJCQljb250aW51ZTsKIAogCQkJCS8qIG93bmVyIGlzIExpbnV4ICov
Cg==
--000000000000663d2e05f2b58eb5--
