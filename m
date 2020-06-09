Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBDF1F48B4
	for <lists+bpf@lfdr.de>; Tue,  9 Jun 2020 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFIVQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jun 2020 17:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgFIVQ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jun 2020 17:16:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 499FB20734;
        Tue,  9 Jun 2020 21:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591737415;
        bh=Nvv8tC18TUn2Q9L9nrl6b3syykFOx699ZvIEzmFTvkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAey2MCrH+shtwqDVjPk5GWl+5+piGcpOqGmSRjQng3Zjr9jbGXxihky8QWIcbWWJ
         GLkfSGvgJavOsSm7mQQVRHc3dXM0wgLALsD6WvkiOQXH402rcbj3K++akJ6wQSJIAX
         d+k4NWoKJ9tLJJ8bUwNdjaCddNi6YGDFL7kD74Ys=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B4ED40AFD; Tue,  9 Jun 2020 18:16:53 -0300 (-03)
Date:   Tue, 9 Jun 2020 18:16:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libbpf: Define __WORDSIZE if not available
Message-ID: <20200609211653.GI24868@kernel.org>
References: <20200608161150.GA3073@kernel.org>
 <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
 <20200609153445.GF24868@kernel.org>
 <d8baea0a-7358-a15b-38e5-850e84eae702@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8baea0a-7358-a15b-38e5-850e84eae702@iogearbox.net>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jun 09, 2020 at 10:37:48PM +0200, Daniel Borkmann escreveu:
> Hey Arnaldo,
> 
> On 6/9/20 5:34 PM, Arnaldo Carvalho de Melo wrote:
> > Some systems, such as Android, don't have a define for __WORDSIZE, do it
> > in terms of __SIZEOF_LONG__, as done in perf since 2012:
> > 
> >    http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5
> > 
> > For reference: https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
> > 
> > I build tested it here and Andrii did some Travis CI build tests too.
> > 
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Diff missing?

Oh well, sorry about that, EBADCOFFEE or something:

From: Arnaldo Carvalho de Melo <acme@kernel.org>

Some systems, such as Android, don't have a define for __WORDSIZE, do it
in terms of __SIZEOF_LONG__, as done in perf since 2012:

   http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5

For reference: https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html

I build tested it here and Andrii did some Travis CI build tests too.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

---

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index e823b35e7371..df59fd4fc95b 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
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
