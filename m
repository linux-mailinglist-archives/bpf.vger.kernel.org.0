Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1965A49EC52
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 21:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiA0UOI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 15:14:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37634 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiA0UOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 15:14:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00DD5B8210C;
        Thu, 27 Jan 2022 20:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE82C340E4;
        Thu, 27 Jan 2022 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643314445;
        bh=qC/sToCd37ePUJElRKoLB3ok7yAQpQWzRiK39nvgDZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GU/u3aN/+jg2tKNHvCGTzY6gFrbkkGBsQFtZEAyxQW6/QybW3mFpOie+9WkFz2+GI
         aHbzMf7LxJFhYGuUbejHpKoALLd7gf2lWzmyKwrX8wGa9O3J9I5a+epzgJXAbpqgz2
         hMDsLbc7iG1sUtnL1HvIokVjSaVqGZCF29n/2eDuAo75YZIpGCMmH9hp7L0Z9ezLz9
         qt9W6yXTDUh1m8pJ+e0TY4JXHXKpgMOf+O6jgbCQUIScQSJzgfOBNLD+cQvzkKJc+W
         a5fe5UEpXfdccqaZ2jyOsHA6+QjIi+KBzGRF7NQTnX/GMJwGt3+ybDqrJnrY/NAWHM
         ALX8pdY5m/l0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E89C240C99; Thu, 27 Jan 2022 17:12:02 -0300 (-03)
Date:   Thu, 27 Jan 2022 17:12:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Message-ID: <YfL8kjM30uHN3qxs@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-4-kuifeng@fb.com>
 <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jan 26, 2022 at 11:58:27AM -0800, Andrii Nakryiko escreveu:
> On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> >
> > Create an instance of btf for each worker thread, and add type info to
> > the local btf instance in the steal-function of pahole without mutex
> > acquiring.  Once finished with all worker threads, merge all
> > per-thread btf instances to the primary btf instance.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> 
> There are still unnecessary casts and missing {} in the else branch,
> but I'll let Arnaldo decide or fix it up.
> 
> Once this lands, can you please send kernel patch to use -j if pahole
> support it during the kernel build? See scripts/pahole-version.sh and
> scripts/link-vmlinux.sh for how pahole is set up and used in the
> kernel. Thanks!

I also tweaked this:

diff --git a/pahole.c b/pahole.c
index 8dcd6bf951fe1f93..1b2b19b2be45d30c 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2887,13 +2887,13 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
                static pthread_mutex_t btf_lock = PTHREAD_MUTEX_INITIALIZER;
                struct btf_encoder *encoder;

+               pthread_mutex_lock(&btf_lock);
                /*
                 * FIXME:
                 *
                 * This should be really done at main(), but since in the current codebase only at this
                 * point we'll have cu->elf setup...
                 */
-               pthread_mutex_lock(&btf_lock);
                if (!btf_encoder) {
                        /*
                         * btf_encoder is the primary encoder.
⬢[acme@toolbox pahole]$

As moving it to after that comment will only make the patch a bit
larger, changing nothing.

+++ b/pahole.c
@@ -2900,11 +2900,9 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
                         * And, it is used by the thread
                         * create it.
                         */
-                       btf_encoder = btf_encoder__new(cu, detached_btf_filename,
-                                                      conf_load->base_btf,
-                                                      skip_encoding_btf_vars,
-                                                      btf_encode_force,
-                                                      btf_gen_floats, global_verbose);
+                       btf_encoder = btf_encoder__new(cu, detached_btf_filename, conf_load->base_btf, skip_encoding_btf_vars,
+                                                      btf_encode_force, btf_gen_floats, global_verbose);
+
                        if (btf_encoder && thr_data) {
                                struct thread_data *thread = thr_data;

⬢[acme@toolbox pahole]$

i.e. cosmetic stuff to make the patch smaller by keeping preexisting
lines as-is.

And the missing {} Andrii noticed:

diff --git a/pahole.c b/pahole.c
index 7e2e37582f21c566..8c0a982f05c9ae3d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2937,8 +2937,9 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
                                thread->btf = btf_encoder__btf(thread->encoder);
                        }
                        encoder = thread->encoder;
-               } else
+               } else {
                        encoder = btf_encoder;
+               }

                if (btf_encoder__encode_cu(encoder, cu)) {
                        fprintf(stderr, "Encountered error while encoding BTF.\n");
⬢[acme@toolbox pahole]$

I'll look at the needless casts and push it to the 'next' and tmp.master
branches so that libbpf's CI can have a chance to test it.

I also added 'perf stat' results for 1.21 (the one in this fedora 34
workstation), 1.23 (parallel DWARF loading) and with your patches + the
libbpf update as a committer testing section, please add performance
numbers in in future work.

Thanks, applied!

- Arnaldo
