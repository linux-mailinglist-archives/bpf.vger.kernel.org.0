Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21D626ED7
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiKMKDe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 05:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMKDd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 05:03:33 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E0735F40;
        Sun, 13 Nov 2022 02:03:31 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:58:36 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:58:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] samples/seccomp: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2b3f2420.130.184706d34e6.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnu+HMv3BjEh0DAA--.78W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAds4
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6CgpzYW1wbGVzL3NlY2NvbXAvYnBmLWZh
bmN5LmM6ODM6MzktNDA6IFdBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCnNhbXBsZXMvc2VjY29tcC9i
cGYtZmFuY3kuYzo4Njo0NC00NTogV0FSTklORzogVXNlIEFSUkFZX1NJWkUKClNpZ25lZC1vZmYt
Ynk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBzYW1wbGVzL3NlY2Nv
bXAvYnBmLWZhbmN5LmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2FtcGxlcy9zZWNjb21wL2JwZi1mYW5jeS5j
IGIvc2FtcGxlcy9zZWNjb21wL2JwZi1mYW5jeS5jCmluZGV4IDFjY2I0MzUwMjViNi4uNTQ4ZjAz
ODkyNGQ2IDEwMDY0NAotLS0gYS9zYW1wbGVzL3NlY2NvbXAvYnBmLWZhbmN5LmMKKysrIGIvc2Ft
cGxlcy9zZWNjb21wL2JwZi1mYW5jeS5jCkBAIC04MCwxMCArODAsMTAgQEAgaW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQogCX07CiAJc3RydWN0IHNvY2tfZnByb2cgcHJvZyA9IHsKIAkJ
LmZpbHRlciA9IGZpbHRlciwKLQkJLmxlbiA9ICh1bnNpZ25lZCBzaG9ydCkoc2l6ZW9mKGZpbHRl
cikvc2l6ZW9mKGZpbHRlclswXSkpLAorCQkubGVuID0gKHVuc2lnbmVkIHNob3J0KShBUlJBWV9T
SVpFKGZpbHRlcikpLAogCX07CiAJc3NpemVfdCBieXRlczsKLQlicGZfcmVzb2x2ZV9qdW1wcygm
bCwgZmlsdGVyLCBzaXplb2YoZmlsdGVyKS9zaXplb2YoKmZpbHRlcikpOworCWJwZl9yZXNvbHZl
X2p1bXBzKCZsLCBmaWx0ZXIsIEFSUkFZX1NJWkUoZmlsdGVyKSk7CiAKIAlpZiAocHJjdGwoUFJf
U0VUX05PX05FV19QUklWUywgMSwgMCwgMCwgMCkpIHsKIAkJcGVycm9yKCJwcmN0bChOT19ORVdf
UFJJVlMpIik7Ci0tIAoyLjI1LjEK
