Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB54631880
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 03:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKUCHs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 21:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKUCHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 21:07:47 -0500
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB83D18B10
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 18:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1668996461;
        bh=ysg/xE0/jB77a1d48gs8ohec4NWgPszsHFjZvUt7cfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Li1YsYqRmbsjWjv7Br5bcCvpD2QwrGqLJP6QaIt7pptSVgRkVe5RO767zQ4O/ifFA
         r3BXmg6tMLFCMtFtEPCaDZWY8ZvQiY1OIiifd0IsdUVj8AntJe6hjYqpXzxKlSSIil
         24nZ1MRi9f78zieo1IOV8DtztwqaLAGpmk+gpfZ0=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 1E48CEB0; Mon, 21 Nov 2022 10:07:36 +0800
X-QQ-mid: xmsmtpt1668996456ts4u9u6od
Message-ID: <tencent_A24996F06584CAF86BC2A822E2A2C1BA1006@qq.com>
X-QQ-XMAILINFO: M7uElAZZZMmF6Oo5VlGWjFJ8jVcfwmDl11vVfqT7M/4lcZM+EGoSmgCgmClyT4
         VoJRMz5vn8lCzLVFWSHkhdsm61bAd1qCe7BIWIhnSAFxkx4YORGIWet+W6Xeh0+FRrl40ElL5WKh
         y0RcASU2nli806o1fHQriEQS4GQTpg0x3TYAcKw8V1wrVXj1C8Ddk2YB0R63MEZwr9be2qJhu7Pd
         zLaMFAetT5YvdtoZkEY4gEfQVCWzfPZ1wtYlQvJKaPiVD5287nrtdW8F1eRH8TQp2WksO8UnDD4W
         Udac2bVksfRItmUeFw/OTRYYGWEQLpe05c/Kf/eaC7gMkU2h9NDia3LHngGZ0Z21XPGMyAqrIOv8
         bSs19rv/SByNkjxkNJr3tFSPg/kxfGcKEYvXG6acLQ0G6aW1J7QMC/9aOcWyDi6pzjLSU8N+GeWm
         1X/t+nKPrPnylX9VBE//Y6cF6hIu2Hn5Q5j2gmbBDex6JJPX+jUh1kbz/SauJl8nfh8W8SpjixE7
         +ok4yyU62A6W07ZXKmAMBWmO7Q3UNyj1cyINnLTnWP4Tgd05NxOlUHmvzsNBboHLa9c7vIyIk2lj
         StD9qDnBtoyphBXMg8TP/whuXC5Llnxz3s3C0zPsJ1tMF4B5Hw4A4QERN8+pdYiFlCWAN3fQ4VNH
         YRrxJHu+qN9fU/f1wF6vUk6FN4AOb/kI6sz5KYh6yqp30Fv/L8/6tcT3JUsrcP662oXCml9FrktJ
         JQAnPDsQ4vDvDV3hoD2KKgokLBk8/lwN8wz4yFKVwGAO+n9sb4wYVsHsTWF0HoBNR8ZbxP19QDOE
         bXUDKnSXex46irQ3xp8/9zckuDVyvhzSkFMkwUk0z9b5+i/tI2iBhJ9M/qotc/4aW23q3z2R2XjI
         RoNz7IO2ciGyrqAevSXmij6Vp+XzoiR10sK94vivyR1giOL1iJL4iImMs9Y2mrEJxqFI8VWVJojj
         orC1kXi5LEexiYJIepOHiv5NSiJGoZBTOavItgDzO0PYS/pVM3VmZIAI0X3wiY
From:   Rong Tao <rtoax@foxmail.com>
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] docs/bpf: Update btf selftests program and add link
Date:   Mon, 21 Nov 2022 10:07:34 +0800
X-OQ-MSGID: <20221121020734.5246-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y3pj9FCI5SOEHZXz@maniforge.lan>
References: <Y3pj9FCI5SOEHZXz@maniforge.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit c64779e24e88("selftests/bpf: Merge most of test_btf into
test_progs") rename selftests/bpf btf test from 'test_btf.c' to
'prog_tests/btf.c'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 Documentation/bpf/btf.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..dca0b0e9dd35 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1062,4 +1062,9 @@ format.::
 7. Testing
 ==========
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
+Kernel bpf selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_ provides
+extensive set of BTF-related tests.
+
+.. Links
+.. _tools/testing/selftests/bpf/prog_tests/btf.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
-- 
2.38.1

