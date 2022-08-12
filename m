Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8CD59132A
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiHLPhe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiHLPhd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 11:37:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0285D0CA
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bv3so1598703wrb.5
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Xoy1p5z8P//trig7g6VZH1J2ewMMUyo/uGyyr8wSAg4=;
        b=G8t7RDH7i6B+zu98kzeVQaAP0yNuGTxpZSH4AEwwRtbUAU5xmNsTYhhWOEndEDU8y8
         T2ddNhIZCqnitjAH4eHbRyRtcAYTW/XxEcDI6exurOmAsgljryzlW9X/J/RhHVAdx7dN
         cbd4xcKHY/YcuE9LLesqwjJJTfRGyX8sZ4L0WGJO1+2MXDE6yZirx1Mx9PN+mb4YDO4n
         nsgSL7OXOuz/xmCoU3G0OZhls/VM/8coqjThVqsC/AsXfJ935k5rrHTvGW8vHCUrDGKC
         9NSX5blpRU+kOZm7PKwWyjp665+TkGsa+7u81lZqwCEvyrIn3bt4RA/wBVCDZqwtRilm
         hd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Xoy1p5z8P//trig7g6VZH1J2ewMMUyo/uGyyr8wSAg4=;
        b=wL0GtlM5zVOLNLG4Tn0lM7XCd7Xty0SKs8os1w9kKSLB06GvFhP+c7qAEKi5Lu2MCZ
         A1jYhSZfQwsb+NOm/0+R4xORrp7bchEGSTat1+pc+q7UqEsT8pql49Jlb8K5hu+4pBi2
         S94/c0EBZmW8X8idyrrZsD//DoXyjSjpXEhL0Zjb1sC9zpvW/9TV0bGHkcZRQuCjraxG
         a+l+miLsI2XV7pd3MlbJDgGoxJY+uA5qPJsFIywTFoDETFszpwmudjLpTUqf9wYUsabA
         NId7BYbZbWwSNpSlvKTl3Eh/q08EzTjiQQ1mxHbSTyj21Eub5rqDzsR+Ydh88EEYQxat
         OedQ==
X-Gm-Message-State: ACgBeo0ltUCpM8gxcIuOrylGXgp4hmEBhkO/3jfoLQ7Zb3O4Bh7qJA+f
        3fRR2Nr+HqZIRn3Fi17swOCQ5w==
X-Google-Smtp-Source: AA6agR5kJM/HhTOgf+mbyT8SzG4gEVOxIIfWKZAvNqKmuTqQ5Zq6qBcJ9co31H5WNAXvqf9L6ShgtQ==
X-Received: by 2002:a5d:6e0d:0:b0:21e:72e2:a9da with SMTP id h13-20020a5d6e0d000000b0021e72e2a9damr2423322wrz.169.1660318651469;
        Fri, 12 Aug 2022 08:37:31 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l25-20020a1ced19000000b003a502c23f2asm9410138wmh.16.2022.08.12.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:37:31 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next] bpftool: Clear errno after libcap's checks
Date:   Fri, 12 Aug 2022 16:37:26 +0100
Message-Id: <20220812153727.224500-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When bpftool is linked against libcap, the library runs a "constructor"
function to compute the number of capabilities of the running kernel
[0], at the beginning of the execution of the program. As part of this,
it performs multiple calls to prctl(). Some of these may fail, and set
errno to a non-zero value:

    # strace -e prctl ./bpftool version
    prctl(PR_CAPBSET_READ, CAP_MAC_OVERRIDE) = 1
    prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, CAP_CHECKPOINT_RESTORE) = 1
    prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
    prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
    ** fprintf added at the top of main(): we have errno == 1
    ./bpftool v7.0.0
    using libbpf v1.0
    features: libbfd, libbpf_strict, skeletons
    +++ exited with 0 +++

Let's clean errno at the beginning of the main() function, to make sure
that these checks do not interfere with the batch mode, where we error
out if errno is set after a bpftool command.

[0] https://git.kernel.org/pub/scm/libs/libcap/libcap.git/tree/libcap/cap_alloc.c?h=v1.2.65#n20

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 451cefc2d0da..c0e2e4fedbe8 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -435,6 +435,9 @@ int main(int argc, char **argv)
 
 	setlinebuf(stdout);
 
+	/* Libcap */
+	errno = 0;
+
 	last_do_help = do_help;
 	pretty_output = false;
 	json_output = false;
-- 
2.25.1

