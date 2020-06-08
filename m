Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB81F1CFD
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgFHQLz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgFHQLy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:11:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6202E2063A;
        Mon,  8 Jun 2020 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591632714;
        bh=5iBPmL/VaZp2yDxe19nlMgBARsfJrpmyX/uXreSE6s4=;
        h=Date:From:To:Cc:Subject:From;
        b=FqMES/74tLwdfEcstzqlW1bpCj4STuxaIxv6VybgT2a2O9VFJj1dLdeyE5baFBY14
         OsP0B9SGy9kq0nu6HfJB0usy5yEdp0ndg1/7UAZHvdTiytTSk5wwLXUnX9pb5VO+Lm
         xon6F+I0xVyU3E51oWkMQJWhLa1f9/zr2TmlKBwA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E3C2940AFD; Mon,  8 Jun 2020 13:11:50 -0300 (-03)
Date:   Mon, 8 Jun 2020 13:11:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: libbpf's hashmap use of __WORDSIZE
Message-ID: <20200608161150.GA3073@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

	We've got that hashmap.[ch] copy from libbpf so that we can
build perf in systems where libbpf isn't available, and to make it build
in all the containers I regularly test build perf I had to add the patch
below, I test build with many versions of both gcc and clang and
multiple libcs.

  https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

The way that tools/include/linux/bitops.h has been doing since 2012 is
explained in:

  http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5

Please take a look and see if you find it acceptable,

Thanks,

- Arnaldo
  
  Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
  diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h

$ diff -u tools/lib/bpf/hashmap.h tools/perf/util/hashmap.h
--- tools/lib/bpf/hashmap.h	2020-06-05 13:25:27.822079838 -0300
+++ tools/perf/util/hashmap.h	2020-06-05 13:25:27.838079794 -0300
@@ -10,10 +10,9 @@
 
 #include <stdbool.h>
 #include <stddef.h>
-#ifdef __GLIBC__
-#include <bits/wordsize.h>
-#else
-#include <bits/reg.h>
+#include <limits.h>
+#ifndef __WORDSIZE
+#define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
 
 static inline size_t hash_bits(size_t h, int bits)
