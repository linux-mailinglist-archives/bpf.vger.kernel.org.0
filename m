Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3100120C067
	for <lists+bpf@lfdr.de>; Sat, 27 Jun 2020 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgF0JHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Jun 2020 05:07:15 -0400
Received: from mail.qboosh.pl ([217.73.31.61]:57656 "EHLO mail.qboosh.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0JHP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Jun 2020 05:07:15 -0400
Received: by mail.qboosh.pl (Postfix, from userid 1000)
        id C5C491A26DA9; Sat, 27 Jun 2020 11:07:13 +0200 (CEST)
Date:   Sat, 27 Jun 2020 11:07:13 +0200
From:   Jakub Bogusz <qboosh@pld-linux.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] fix libbpf hashmap with size_t shorter than long long
Message-ID: <20200627090713.GA9141@mail>
References: <20200621142559.GA25517@stranger.qboosh.pl> <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com> <20200623192917.GA6342@mail> <CAEf4BzbKo1-61emwL5nWHRVTeabvedZC6QX01u=pthgkcL3iag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <CAEf4BzbKo1-61emwL5nWHRVTeabvedZC6QX01u=pthgkcL3iag@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 12:40:02PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 23, 2020 at 12:29 PM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> >
> > On Mon, Jun 22, 2020 at 10:44:56PM -0700, Andrii Nakryiko wrote:
> > > On Sun, Jun 21, 2020 at 7:34 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I noticed that _bpftool crashes when building kernel tools (5.7.x) for
> > > > 32-bit targets because in libbpf hashmap implementation hash_bits()
> > > > function returning numbers exceeding hashmap buckets capacity.
> > > >
> > > > Attached patch fixes this problem.
> > > >
> > >
> > > Thanks! But this was already fixed by Arnaldo Carvalho de Melo <acme@kernel.org>
> > > in 8ca8d4a84173 ("libbpf: Define __WORDSIZE if not available").
> >
> > No, it's not:
> > This change worked around __WORDSIZE not always being available.
> >
> > But the issue on (I)LP32 platforms is that 64-bit value is shifted by
> > (32-bits) instead of (64-bits).
> >
> > (__SIZEOF_LONG__ * 8) is 32 on such architectures (i686, arm).
> > I used __SIZEOF_LONG_LONG__ to get proper bit shift both on (I)LP32 and
> > LP64 architectures.
> >
> 
> Ah, I see. I actually mentioned __SIZEOF_ constants on the original
> fix patch. But I think in this case it has to use __SIZEOF_SIZE_T,
> which on 32-bit should be 4, right?

After changing constant to 32-bit, yes (to be precise, it should use maximum
of __SIZEOF_SIZE_T__ and __SIZEOF_LONG__ if constant is specified with
UL suffix; there is no constant suffix available for size_t).

> > Should I provide an updated patch to apply on top of acme change?
> 
> Yes, that would be good. But I think there is no need to penalize
> 32-bit arches with use of 64-bit long longs, and instead it's better
> to use #ifdef for 32-bit case vs 64-bit case. The multiplication
> constant will change, of course, should be 2654435769. I'd appreciate
> it if you can do the patch, thanks!

OK, so now the patch provides two variants:
- "long long" case for LP64 architectures
- "long" case for (I)LP32 architectures
(selected basing of __SIZEOF_ constants)
matter)


Regards,

-- 
Jakub Bogusz    http://qboosh.pl/

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-tools-bpf-hashmap.patch"

Fix libbpf hashmap on (I)LP32 architectures

On ILP32, 64-bit result was shifted by value calculated for 32-bit long type
and returned value was much outside hashmap capacity.
As advised by Andrii Nakryiko, this patch uses different hashing variant for
architectures with size_t shorter than long long.

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux/tools/lib/bpf/hashmap.h.orig	2020-06-01 01:49:15.000000000 +0200
+++ linux/tools/lib/bpf/hashmap.h	2020-06-21 15:22:07.298466419 +0200
@@ -11,14 +11,18 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <limits.h>
-#ifndef __WORDSIZE
-#define __WORDSIZE (__SIZEOF_LONG__ * 8)
-#endif
 
 static inline size_t hash_bits(size_t h, int bits)
 {
 	/* shuffle bits and return requested number of upper bits */
-	return (h * 11400714819323198485llu) >> (__WORDSIZE - bits);
+#if (__SIZEOF_SIZE_T__ == __SIZEOF_LONG_LONG__)
+	/* LP64 case */
+	return (h * 11400714819323198485llu) >> (__SIZEOF_LONG_LONG__ * 8 - bits);
+#elif (__SIZEOF_SIZE_T__ <= __SIZEOF_LONG__)
+	return (h * 2654435769lu) >> (__SIZEOF_LONG__ * 8 - bits);
+#else
+#	error "Unsupported size_t size"
+#endif
 }
 
 typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);

--huq684BweRXVnRxX--
