Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9C67DD81
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 07:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjA0GkT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 01:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjA0GkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF82F69B07;
        Thu, 26 Jan 2023 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qAnULDD1Vs1l03vDvUPK8RqKC6ytHJz1xxwBhM6tUO4=; b=0ZUQU5LIvCy39LLL5XeAlXIm0F
        Dvbaq23/vB+7gEYFQevqFXt33fqiTWGIQ/AKWV88URjF9ar6z7F/OoxMv0Pw3cdwvcrhdKr+tIemn
        DT2uW3jnvw1wrtyBBwI5aeCOUCcyMieT/9ge/uh7d6gh5vyr6DbihhCZirRa5RtV3RU2thefc8Dzy
        s5f4E3/GGb+mnCjaCxMVrSSbRIqnYFAit+z1PyhnHBjWZ7tbnjVshLVA9LWf9eiMlKw2mLNye2AHU
        5Isj8DVvjzE2KmhhcpRVMS8bkitntxJzbfGwxYFSmTRMulbOb3Q6k4ZCSw80tINkH4GTk8wtkJD9G
        nORumjLA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPD-00DM0u-Ea; Fri, 27 Jan 2023 06:40:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 04/35] Documentation: bpf: correct spelling
Date:   Thu, 26 Jan 2023 22:39:34 -0800
Message-Id: <20230127064005.1558-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
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
---
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
