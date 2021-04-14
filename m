Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64035F21B
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348287AbhDNLVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 07:21:11 -0400
Received: from mail.loongson.cn ([114.242.206.163]:50682 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229886AbhDNLVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 07:21:11 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3+8B0HZg8_MHAA--.897S2;
        Wed, 14 Apr 2021 19:20:33 +0800 (CST)
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
Subject: [PATCH bpf-next v2] bpf: Fix some invalid links in bpf_devel_QA.rst
Date:   Wed, 14 Apr 2021 19:20:32 +0800
Message-Id: <1618399232-17858-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx3+8B0HZg8_MHAA--.897S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUKrWfJr1fWF1xtF1DWrg_yoWrZF1Upa
        1fGrnIkr18XF13Wwn7GrWUurySqas3GayUCF18Jr95Zw1jvryktr1IgrWfXa98Gr909ay3
        Za4SkryYka18ZrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfU589NDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There exist some errors "404 Not Found" when I click the link
of "MAINTAINERS" [1], "samples/bpf/" [2] and "selftests" [3]
in the documentation "HOWTO interact with BPF subsystem" [4].

Use correct link of "MAINTAINERS" and just remove the links of
"samples/bpf/" and "selftests" because there are no related
documentations.

[1] https://www.kernel.org/doc/html/MAINTAINERS
[2] https://www.kernel.org/doc/html/samples/bpf/
[3] https://www.kernel.org/doc/html/tools/testing/selftests/bpf/
[4] https://www.kernel.org/doc/html/latest/bpf/bpf_devel_QA.html

Fixes: 542228384888 ("bpf, doc: convert bpf_devel_QA.rst to use RST formatting")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: Add Fixes: tag

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

