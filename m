Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBE202B0D
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgFUOeN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Jun 2020 10:34:13 -0400
Received: from mail.qboosh.pl ([217.73.31.61]:58107 "EHLO mail.qboosh.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgFUOeM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Jun 2020 10:34:12 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 10:34:12 EDT
Received: from stranger.qboosh.pl (159-205-219-225.adsl.inetia.pl [159.205.219.225])
        by mail.qboosh.pl (Postfix) with ESMTPSA id 24FE61A26DA9;
        Sun, 21 Jun 2020 16:24:48 +0200 (CEST)
Received: from stranger.qboosh.pl (localhost [127.0.0.1])
        by stranger.qboosh.pl (8.15.2/8.15.2) with ESMTP id 05LEQ0WP025677;
        Sun, 21 Jun 2020 16:26:00 +0200
Received: (from qboosh@localhost)
        by stranger.qboosh.pl (8.15.2/8.15.2/Submit) id 05LEPxrr025675;
        Sun, 21 Jun 2020 16:25:59 +0200
Date:   Sun, 21 Jun 2020 16:25:59 +0200
From:   Jakub Bogusz <qboosh@pld-linux.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] fix libbpf hashmap with size_t shorter than long long
Message-ID: <20200621142559.GA25517@stranger.qboosh.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I noticed that _bpftool crashes when building kernel tools (5.7.x) for
32-bit targets because in libbpf hashmap implementation hash_bits()
function returning numbers exceeding hashmap buckets capacity.

Attached patch fixes this problem.


Regards,

-- 
Jakub Bogusz    http://qboosh.pl/

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-tools-bpf-hashmap.patch"

Ensure that hash_bits returns value fits in given bits (for bits > 0):
multiplier is long long (which is the same or wider than size_t), so shift bits
must be based on long long size, not __WORDSIZE.

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-5.7/tools/lib/bpf/hashmap.h.orig	2020-06-01 01:49:15.000000000 +0200
+++ linux-5.7/tools/lib/bpf/hashmap.h	2020-06-21 15:22:07.298466419 +0200
@@ -10,17 +10,12 @@
 
 #include <stdbool.h>
 #include <stddef.h>
-#ifdef __GLIBC__
-#include <bits/wordsize.h>
-#else
-#include <bits/reg.h>
-#endif
 #include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
-	return (h * 11400714819323198485llu) >> (__WORDSIZE - bits);
+	return (h * 11400714819323198485llu) >> (__SIZEOF_LONG_LONG__ * 8 - bits);
 }
 
 typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);

--huq684BweRXVnRxX--
