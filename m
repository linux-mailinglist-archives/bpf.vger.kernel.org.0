Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E760669942
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 15:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241230AbjAMOAS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 09:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjAMN7k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 08:59:40 -0500
X-Greylist: delayed 430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 05:56:35 PST
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197E76EC0
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 05:56:34 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5b2e8e20.dip0.t-ipconnect.de [91.46.142.32])
        by mail.itouring.de (Postfix) with ESMTPSA id 94754CF1A9D;
        Fri, 13 Jan 2023 14:49:21 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 57B18F01581;
        Fri, 13 Jan 2023 14:49:21 +0100 (CET)
To:     bpf@vger.kernel.org
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: [PATCH] bpftool: Always disable stack protection for clang
Organization: Applied Asynchrony, Inc.
Cc:     Sam James <sam@gentoo.org>
Message-ID: <74cd9d2e-6052-312a-241e-2b514a75c92c@applied-asynchrony.com>
Date:   Fri, 13 Jan 2023 14:49:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


When the clang toolchain has stack protection enabled in order to be consistent
with gcc - which just happens to be the case on Gentoo - the bpftool build
fails:

clang \
	-I. \
	-I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
	-I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
	-g -O2 -Wall -target bpf -c skeleton/pid_iter.bpf.c -o pid_iter.bpf.o
clang \
	-I. \
	-I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/include/uapi/ \
	-I/tmp/portage/dev-util/bpftool-6.0.12/work/linux-6.0/tools/bpf/bpftool/bootstrap/libbpf/include \
	-g -O2 -Wall -target bpf -c skeleton/profiler.bpf.c -o profiler.bpf.o
skeleton/profiler.bpf.c:40:14: error: A call to built-in function '__stack_chk_fail' is not supported.
int BPF_PROG(fentry_XXX)
              ^
skeleton/profiler.bpf.c:94:14: error: A call to built-in function '__stack_chk_fail' is not supported.
int BPF_PROG(fexit_XXX)
              ^
2 errors generated.

Since stack-protector makes no sense for the BPF bits just unconditionally
disable it.

Bug: https://bugs.gentoo.org/890638
Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>

--snip--

diff a/src/Makefile b/src/Makefile
--- a/src/Makefile
+++ b/src/Makefile
@@ -205,7 +205,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
  		-I$(or $(OUTPUT),.) \
  		-I$(srctree)/include/uapi/ \
  		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
-		-g -O2 -Wall -target bpf -c $< -o $@
+		-g -O2 -Wall -fno-stack-protector -target bpf -c $< -o $@
  	$(Q)$(LLVM_STRIP) -g $@
  
  $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
