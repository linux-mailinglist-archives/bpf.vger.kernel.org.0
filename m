Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8567566C
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjATOK7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 09:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjATOK4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 09:10:56 -0500
Received: from fx306.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C0FC79C5
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 06:10:29 -0800 (PST)
Received: from localhost (fx306.security-mail.net [127.0.0.1])
        by fx306.security-mail.net (Postfix) with ESMTP id C069D35CF31
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 15:10:27 +0100 (CET)
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id 8C9A535CEB1; Fri, 20 Jan
 2023 15:10:27 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx306.security-mail.net (Postfix) with ESMTPS id CF40835CE76; Fri, 20 Jan
 2023 15:10:26 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 915E327E043E; Fri, 20 Jan 2023
 15:10:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 76ED427E043A; Fri, 20 Jan 2023 15:10:26 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 bkqmCC_I0G-S; Fri, 20 Jan 2023 15:10:26 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id E117627E0439; Fri, 20 Jan 2023
 15:10:25 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <1626f.63caa0d2.ce20a.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 76ED427E043A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223826;
 bh=WsdsMgF+9wdt2RCH1Xf3svKE0DGavKlRxJdrjiN4Uh8=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=P23x+LKcvEP+IKZLbkuicGs3Pej5mBdo8yQYkaxT3SdD6c0GM19pKDj+ase6ViEKo
 uPexGp9XpE0T3huFfEVD6e4MSK+6FZ4VooRCJ6oBEHDNAQPNIZeWLmd6d5qSRBL22D
 of29euZL+icynxeO+ubhAeSadnZtlOlSeb48YA+Q=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 04/31] Documentation: Add binding for
 kalray,kv3-1-apic-mailbox
Date:   Fri, 20 Jan 2023 15:09:35 +0100
Message-ID: <20230120141002.2442-5-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jules Maselbas <jmaselbas@kalray.eu>

Add documentation for `kalray,kv3-1-core-intc` binding.

Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: new patch

 .../kalray,kv3-1-apic-mailbox.yaml            | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml
new file mode 100644
index 000000000000..e1eb1c9fda0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kalray,kv3-1-apic-mailbox.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kalray,kv3-1-apic-mailbox#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray kv3-1 APIC-Mailbox
+
+description: |
+  Each cluster in the Coolidge SoC includes an Advanced Programmable Interrupt
+  Controller (APIC) which is split in two part:
+    - a Generic Interrupt Controller (referred as APIC-GIC)
+    - a Mailbox Controller           (referred as APIC-Mailbox)
+  The APIC-Mailbox contains 128 mailboxes of 8 bytes (size of a word),
+  this hardware block is basically a 1 KB of smart memory space.
+  Each mailbox can be independently configured with a trigger condition
+  and an input mode function.
+
+  Input mode are:
+   - write
+   - bitwise OR
+   - add
+
+  Interrupts are generated on a write when the mailbox content value
+  match the configured trigger condition.
+  Available conditions are:
+   - doorbell: always raise interruption on write
+   - match: when the mailbox's value equal the configured trigger value
+   - barrier: same as match but the mailbox's value is cleared on trigger
+   - threshold: when the mailbox's value is greater than, or equal to, the
+     configured trigger value
+
+  Since this hardware block generates IRQs based on writes to some memory
+  locations, it is both an interrupt controller and an MSI controller.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: kalray,kv3-1-apic-mailbox
+  "#interrupt-cells":
+    const: 1
+    description:
+      The IRQ number.
+  interrupt-controller: true
+  interrupt-parent: true
+  interrupts:
+    maxItems: 128
+    description: |
+     Specifies the interrupt line(s) in the interrupt-parent controller node;
+     valid values depend on the type of parent interrupt controller
+  msi-controller: true
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+  - interrupt-parent
+  - interrupts
+  - msi-controller
+
+examples:
+  - |
+    apic_mailbox: interrupt-controller@a00000 {
+        compatible = "kalray,kv3-1-apic-gic";
+        reg = <0 0xa00000 0 0x0f200>;
+        #interrupt-cells = <1>;
+        interrupt-controller;
+        interrupt-parent = <&apic_gic>;
+        interrups = <0 1 2 3 4 5 6 7 8 9>;
+    };
+
+...
-- 
2.37.2





