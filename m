Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D7E55283E
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347421AbiFTXXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 19:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiFTXWo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 19:22:44 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292245FF1
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 16:17:52 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8E54E240028
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 01:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655767070; bh=99zNdqlo8R46wTYQGC58/P3RDaRr+yek5vt1JniASgA=;
        h=From:To:Subject:Date:From;
        b=Pgx5tzVJe1SsBvdeWx29x24+igaRV4p69oYxZo6SbEztkZ2vERFFPrm8cBS77DcSR
         NfInH17NOnnb7kC7nuKdcAfg+NY4qgqWqUd8l6caVaMyX92jfpv8bnncRlUIc49k6n
         BaOCXTAs3OztIK1sVMMuG+G5zXTFyuVLt7IF0XlMLmjo6Ks/gRaiBMAaXOCtWAy7Z5
         TrN5L1Ntz3/wVT69yA6QNqpJm6l2PiQuga/931G1LOmTAz/9z3Wi5CnhzEEEZQL+2h
         K26aOGdigc+JOXGFL2QIa9pkHeTUnFIBCJmCwibkkk3AbMevRc1l6fRXoTmq1vzw+H
         t6erlPSDtDU5g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LRltP6lJmz6tmS;
        Tue, 21 Jun 2022 01:17:49 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: [PATCH bpf-next 1/7] bpf: Introduce TYPE_MATCH related constants/macros
Date:   Mon, 20 Jun 2022 23:17:07 +0000
Message-Id: <20220620231713.2143355-2-deso@posteo.net>
In-Reply-To: <20220620231713.2143355-1-deso@posteo.net>
References: <20220620231713.2143355-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to provide type match support we require a new type of
relocation which, in turn, requires toolchain support. Recent LLVM/Clang
versions support a new value for the last argument to the
__builtin_preserve_type_info builtin, for example.
With this change we introduce the necessary constants into relevant
header files, mirroring what the compiler may support.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 include/uapi/linux/bpf.h       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/bpf_core_read.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e81362..42605c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6782,6 +6782,7 @@ enum bpf_core_relo_kind {
 	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
 	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+	BPF_CORE_TYPE_MATCHES = 12,          /* type match in target kernel */
 };
 
 /*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e81362..42605c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6782,6 +6782,7 @@ enum bpf_core_relo_kind {
 	BPF_CORE_TYPE_SIZE = 9,              /* type size in bytes */
 	BPF_CORE_ENUMVAL_EXISTS = 10,        /* enum value existence in target kernel */
 	BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
+	BPF_CORE_TYPE_MATCHES = 12,          /* type match in target kernel */
 };
 
 /*
diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index fd48b1..2308f49 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -29,6 +29,7 @@ enum bpf_type_id_kind {
 enum bpf_type_info_kind {
 	BPF_TYPE_EXISTS = 0,		/* type existence in target kernel */
 	BPF_TYPE_SIZE = 1,		/* type size in target kernel */
+	BPF_TYPE_MATCHES = 2,		/* type match in target kernel */
 };
 
 /* second argument to __builtin_preserve_enum_value() built-in */
-- 
2.30.2

