Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EF67FA90
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjA1Tuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Jan 2023 14:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1Tuu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Jan 2023 14:50:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B535A20069;
        Sat, 28 Jan 2023 11:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=qEnfDf+BQe2kIPxLJiV7OZn4deC6AGOYYXUZSW1pSOU=; b=WNESInrEGQ4hgPJTNesLKzpYcK
        Pd0RAQ4pe+sxVn9f2bquTCMoTbiw+Wq0Xrj4FcUvppge8BH+8/Zch2EsODoEsQ0WiwY4+HzMIu0kb
        1XkGijy+NtOvuCqxLsp1drtvlw7rlyptGzKEajl8Pui9Z3uihAu7Qo5rF985WgoH/XXUwEAhHdexx
        weyQmk5nVQ768Ep/mnmNUg0mYhGENa/HnJW8QdAfc4ciur8Nq6hw9BugJM4SsW8nwOG2l0g5FGcKv
        lvP1KEgS6qHBogL3tRbM2Jo2raFwzBtDx9R7UNayG8jmAIn+tLVLQnomOA8QP4ihLg+MiA7qM5PLe
        fcAWDVwQ==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLrDq-000cy2-RU; Sat, 28 Jan 2023 19:50:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH bpf-next v2] Documentation: bpf: correct spelling
Date:   Sat, 28 Jan 2023 11:50:46 -0800
Message-Id: <20230128195046.13327-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Correct spelling problems for Documentation/bpf/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
v2: independent patch targeting bpf-next

 Documentation/bpf/libbpf/libbpf_naming_convention.rst |    6 +++---
 Documentation/bpf/map_xskmap.rst                      |    2 +-
 Documentation/bpf/ringbuf.rst                         |    4 ++--
 Documentation/bpf/verifier.rst                        |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff -- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
--- a/Documentation/bpf/libbpf/libbpf_naming_convention.rst
+++ b/Documentation/bpf/libbpf/libbpf_naming_convention.rst
@@ -83,8 +83,8 @@ This prevents from accidentally exportin
 to be a part of ABI what, in turn, improves both libbpf developer- and
 user-experiences.
 
-ABI versionning
----------------
+ABI versioning
+--------------
 
 To make future ABI extensions possible libbpf ABI is versioned.
 Versioning is implemented by ``libbpf.map`` version script that is
@@ -148,7 +148,7 @@ API documentation convention
 The libbpf API is documented via comments above definitions in
 header files. These comments can be rendered by doxygen and sphinx
 for well organized html output. This section describes the
-convention in which these comments should be formated.
+convention in which these comments should be formatted.
 
 Here is an example from btf.h:
 
diff -- a/Documentation/bpf/map_xskmap.rst b/Documentation/bpf/map_xskmap.rst
--- a/Documentation/bpf/map_xskmap.rst
+++ b/Documentation/bpf/map_xskmap.rst
@@ -178,7 +178,7 @@ The following code snippet shows how to
 
 For an example on how create AF_XDP sockets, please see the AF_XDP-example and
 AF_XDP-forwarding programs in the `bpf-examples`_ directory in the `libxdp`_ repository.
-For a detailed explaination of the AF_XDP interface please see:
+For a detailed explanation of the AF_XDP interface please see:
 
 - `libxdp-readme`_.
 - `AF_XDP`_ kernel documentation.
diff -- a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
--- a/Documentation/bpf/ringbuf.rst
+++ b/Documentation/bpf/ringbuf.rst
@@ -124,7 +124,7 @@ buffer.  Currently 4 are supported:
 
 - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
 - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
-- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical possition
+- ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical position
   of consumer/producer, respectively.
 
 Returned values are momentarily snapshots of ring buffer state and could be
@@ -146,7 +146,7 @@ Design and Implementation
 This reserve/commit schema allows a natural way for multiple producers, either
 on different CPUs or even on the same CPU/in the same BPF program, to reserve
 independent records and work with them without blocking other producers. This
-means that if BPF program was interruped by another BPF program sharing the
+means that if BPF program was interrupted by another BPF program sharing the
 same ring buffer, they will both get a record reserved (provided there is
 enough space left) and can work with it and submit it independently. This
 applies to NMI context as well, except that due to using a spinlock during
diff -- a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
--- a/Documentation/bpf/verifier.rst
+++ b/Documentation/bpf/verifier.rst
@@ -192,7 +192,7 @@ checked and found to be non-NULL, all co
 As well as range-checking, the tracked information is also used for enforcing
 alignment of pointer accesses.  For instance, on most systems the packet pointer
 is 2 bytes after a 4-byte alignment.  If a program adds 14 bytes to that to jump
-over the Ethernet header, then reads IHL and addes (IHL * 4), the resulting
+over the Ethernet header, then reads IHL and adds (IHL * 4), the resulting
 pointer will have a variable offset known to be 4n+2 for some n, so adding the 2
 bytes (NET_IP_ALIGN) gives a 4-byte alignment and so word-sized accesses through
 that pointer are safe.
