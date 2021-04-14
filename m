Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04BC35F026
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhDNIto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 04:49:44 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45150 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345437AbhDNItl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 04:49:41 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax7ch_rHZgjukHAA--.10739S2;
        Wed, 14 Apr 2021 16:49:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH bpf-next] bpf: Fix some invalid links in bpf_devel_QA.rst
Date:   Wed, 14 Apr 2021 16:49:01 +0800
Message-Id: <1618390141-4817-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Ax7ch_rHZgjukHAA--.10739S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUKrWfJr1fWF13Cw4xtFb_yoWrCF4xpa
        1fGr1akr18XF13Wwn7GrWUurySqas3GFWUCF18Jr95Zw1jvryktr1IgrWfXa98Jr909ay3
        Za4SkryYka18ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfU8Z2-UUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There exist some errors "404 Not Found" when I click the link
of "MAINTAINERS" [1], "samples/bpf/" [2] and "selftests" [3]
in the documentation "HOWTO interact with BPF subsystem" [4].

Use correct link of "MAINTAINERS" and just remove the links of
"samples/bpf/" and "selftests" because there are not related
documentations.

[1] https://www.kernel.org/doc/html/MAINTAINERS
[2] https://www.kernel.org/doc/html/samples/bpf/
[3] https://www.kernel.org/doc/html/tools/testing/selftests/bpf/
[4] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/bpf/bpf_devel_QA.rst | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 2ed89ab..4fd4c8c 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -29,7 +29,7 @@ list:
 This may also include issues related to XDP, BPF tracing, etc.
 
 Given netdev has a high volume of traffic, please also add the BPF
-maintainers to Cc (from kernel MAINTAINERS_ file):
+maintainers to Cc (from kernel :ref:`MAINTAINERS <maintainers>` file):
 
 * Alexei Starovoitov <ast@kernel.org>
 * Daniel Borkmann <daniel@iogearbox.net>
@@ -217,11 +217,11 @@ page run by David S. Miller on net-next that provides guidance:
 Q: Verifier changes and test cases
 ----------------------------------
 Q: I made a BPF verifier change, do I need to add test cases for
-BPF kernel selftests_?
+BPF kernel selftests?
 
 A: If the patch has changes to the behavior of the verifier, then yes,
 it is absolutely necessary to add test cases to the BPF kernel
-selftests_ suite. If they are not present and we think they are
+selftests suite. If they are not present and we think they are
 needed, then we might ask for them before accepting any changes.
 
 In particular, test_verifier.c is tracking a high number of BPF test
@@ -234,11 +234,11 @@ be subject to change.
 
 Q: samples/bpf preference vs selftests?
 ---------------------------------------
-Q: When should I add code to `samples/bpf/`_ and when to BPF kernel
-selftests_ ?
+Q: When should I add code to ``samples/bpf/`` and when to BPF kernel
+selftests?
 
-A: In general, we prefer additions to BPF kernel selftests_ rather than
-`samples/bpf/`_. The rationale is very simple: kernel selftests are
+A: In general, we prefer additions to BPF kernel selftests rather than
+``samples/bpf/``. The rationale is very simple: kernel selftests are
 regularly run by various bots to test for kernel regressions.
 
 The more test cases we add to BPF selftests, the better the coverage
@@ -246,9 +246,9 @@ and the less likely it is that those could accidentally break. It is
 not that BPF kernel selftests cannot demo how a specific feature can
 be used.
 
-That said, `samples/bpf/`_ may be a good place for people to get started,
+That said, ``samples/bpf/`` may be a good place for people to get started,
 so it might be advisable that simple demos of features could go into
-`samples/bpf/`_, but advanced functional and corner-case testing rather
+``samples/bpf/``, but advanced functional and corner-case testing rather
 into kernel selftests.
 
 If your sample looks like a test case, then go for BPF kernel selftests
@@ -413,7 +413,7 @@ Testing patches
 Q: How to run BPF selftests
 ---------------------------
 A: After you have booted into the newly compiled kernel, navigate to
-the BPF selftests_ suite in order to test BPF functionality (current
+the BPF selftests suite in order to test BPF functionality (current
 working directory points to the root of the cloned git tree)::
 
   $ cd tools/testing/selftests/bpf/
@@ -645,10 +645,7 @@ when:
 
 .. Links
 .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
-.. _MAINTAINERS: ../../MAINTAINERS
 .. _netdev-FAQ: ../networking/netdev-FAQ.rst
-.. _samples/bpf/: ../../samples/bpf/
-.. _selftests: ../../tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
    https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
 .. _Documentation/bpf/btf.rst: btf.rst
-- 
2.1.0

