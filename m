Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562744A0121
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 20:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiA1Tw4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 14:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiA1Twz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 14:52:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EF4C061714;
        Fri, 28 Jan 2022 11:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE937B826F4;
        Fri, 28 Jan 2022 19:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF19C340E7;
        Fri, 28 Jan 2022 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643399572;
        bh=v3Wcxo183ymd1gi0izPA2SQvu3G31sfPXNjD61VK7jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q7ON/jIOC7vcyczl00y4UE3e+p3wxL8WoKl3ztesIJ9SsP46QiDP8LdqsAyB+i+WP
         eq+YI+r+ig3dXdvYdddhQ1xnrOM5uE7a+DxdipzRq90/+NC0ujfansMuvu0648VT9E
         WxgU9IA1JBPvth0u/VGP8WDmnSUVpmX6xCf/FW5haRmtBucCRcX1DhI9QK5VTd9cGB
         9S/Is1QC22/qAr3ec1AzeJv0CmKU3IEcPuM1uwSnmADzVbEGNcEUbROxRwbA/MnuUj
         0hWHFOnV+UHz0gUmcnFjeDXvrBw7KviPI+AHJfE3GCTHJcYlO89QQJhdhmlgZcjNx1
         brdxQYqkUk09A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AC2E40C99; Fri, 28 Jan 2022 16:50:48 -0300 (-03)
Date:   Fri, 28 Jan 2022 16:50:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mark Wielaard <mjw@redhat.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Message-ID: <YfRJGJ35SQCy+98H@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-4-kuifeng@fb.com>
 <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
 <YfL8kjM30uHN3qxs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfL8kjM30uHN3qxs@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 27, 2022 at 05:12:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 26, 2022 at 11:58:27AM -0800, Andrii Nakryiko escreveu:
> > On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > Create an instance of btf for each worker thread, and add type info to
> > > the local btf instance in the steal-function of pahole without mutex
> > > acquiring.  Once finished with all worker threads, merge all
> > > per-thread btf instances to the primary btf instance.

> > There are still unnecessary casts and missing {} in the else branch,
> > but I'll let Arnaldo decide or fix it up.

So its just one unneeded cast as thr_data here is just a 'void *':

diff --git a/pahole.c b/pahole.c
index 8c0a982f05c9ae3d..39e18804100dbfda 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2924,7 +2924,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
                 * avoids copying the data collected by the first thread.
                 */
                if (thr_data) {
-                       struct thread_data *thread = (struct thread_data *)thr_data;
+                       struct thread_data *thread = thr_data;

                        if (thread->encoder == NULL) {
                                thread->encoder =


This other is needed as it is a "void **":

@@ -2832,7 +2832,7 @@ static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
 static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void **thr_data,
                                  int error)
 {
-       struct thread_data **threads = (struct thread_data **)thr_data;
+       struct thread_data **threads = thr_data;
        int i;
        int err = 0;


Removing it:

/var/home/acme/git/pahole/pahole.c: In function ‘pahole_threads_collect’:
/var/home/acme/git/pahole/pahole.c:2835:40: warning: initialization of ‘struct thread_data **’ from incompatible pointer type ‘void **’ [-Wincompatible-pointer-types]
 2835 |         struct thread_data **threads = thr_data;
      |                                        ^~~~~~~~


And I did some more profiling, now the focus should go to elfutils:

⬢[acme@toolbox pahole]$ perf report --no-children -s dso --call-graph none 2> /dev/null | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 27K of event 'cycles:u'
# Event count (approx.): 27956766207
#
# Overhead  Shared Object
# ........  ...................
#
    46.70%  libdwarves.so.1.0.0
    39.84%  libdw-0.186.so
     9.70%  libc-2.33.so
     2.14%  libpthread-2.33.so
     1.47%  [unknown]
     0.09%  ld-2.33.so
     0.06%  libelf-0.186.so
     0.00%  libcrypto.so.1.1.1l
     0.00%  libk5crypto.so.3.1
⬢[acme@toolbox pahole]$

$ perf report -g graph,0.5,2 --stdio --no-children -s dso --dso libdw-0.186.so

# To display the perf.data header info, please use --header/--header-only options.
#
# dso: libdw-0.186.so
#
# Total Lost Samples: 0
#
# Samples: 27K of event 'cycles:u'
# Event count (approx.): 27956766207
#
# Overhead  Shared Object 
# ........  ..............
#
    39.84%  libdw-0.186.so
            |          
            |--25.66%--__libdw_find_attr
            |          |          
            |          |--20.96%--__dwarf_attr_internal (inlined)
            |          |          |          
            |          |          |--10.94%--attr_numeric
            |          |          |          |          
            |          |          |          |--9.96%--die__process_class
            |          |          |          |          __die__process_tag
            |          |          |          |          die__process_unit
            |          |          |          |          die__process
            |          |          |          |          dwarf_cus__create_and_process_cu
            |          |          |          |          dwarf_cus__process_cu_thread
            |          |          |          |          start_thread
            |          |          |          |          __GI___clone (inlined)
            |          |          |          |          
            |          |          |           --0.61%--type__init
            |          |          |                     __die__process_tag
            |          |          |                     die__process_unit
            |          |          |                     die__process
            |          |          |                     dwarf_cus__create_and_process_cu
            |          |          |                     dwarf_cus__process_cu_thread
            |          |          |                     start_thread
            |          |          |                     __GI___clone (inlined)
            |          |          |          
            |          |          |--5.43%--attr_type
            |          |          |          |          
            |          |          |           --4.94%--tag__init
            |          |          |                     |          
            |          |          |                     |--2.60%--die__process_class
            |          |          |                     |          __die__process_tag
            |          |          |                     |          die__process_unit
            |          |          |                     |          die__process
            |          |          |                     |          dwarf_cus__create_and_process_cu
            |          |          |                     |          dwarf_cus__process_cu_thread
            |          |          |                     |          start_thread
            |          |          |                     |          __GI___clone (inlined)
            |          |          |                     |          
            |          |          |                     |--0.99%--__die__process_tag
            |          |          |                     |          |          
            |          |          |                     |           --0.98%--die__process_unit
            |          |          |                     |                     die__process
            |          |          |                     |                     dwarf_cus__create_and_process_cu
            |          |          |                     |                     dwarf_cus__process_cu_thread
            |          |          |                     |                     start_thread
            |          |          |                     |                     __GI___clone (inlined)
            |          |          
            |          |--4.01%--__dwarf_siblingof_internal (inlined)
            |          |          |          
            |          |          |--1.41%--die__process_class
            |          |          |          __die__process_tag
            |          |          |          die__process_unit
            |          |          |          die__process
            |          |          |          dwarf_cus__create_and_process_cu
            |          |          |          dwarf_cus__process_cu_thread
            |          |          |          start_thread
            |          |          |          __GI___clone (inlined)
            |          |          |          
            |          |          |--1.02%--die__process
            |          |          |          dwarf_cus__create_and_process_cu
            |          |          |          dwarf_cus__process_cu_thread
            |          |          |          start_thread
            |          |          |          __GI___clone (inlined)
            |          
            |--2.38%--__libdw_form_val_compute_len
            |          __libdw_find_attr
            |          |          
            |           --1.86%--__dwarf_attr_internal (inlined)
            |                     |          
            |                     |--0.94%--attr_numeric
            |                     |          |          
            |                     |           --0.83%--die__process_class
            |                     |                     __die__process_tag
            |                     |                     die__process_unit
            |                     |                     die__process
            |                     |                     dwarf_cus__create_and_process_cu
            |                     |                     dwarf_cus__process_cu_thread
            |                     |                     start_thread
            |                     |                     __GI___clone (inlined)
            |                     |          
            |                      --0.56%--attr_type
            |                                |          
            |                                 --0.53%--tag__init



#
# (Tip: If you have debuginfo enabled, try: perf report -s sym,srcline)
#

This find_attr thing needs improvements, its a linear search AFAIK, some
hashtable could do wonders, I guess.

Mark, was this considered at some point?

⬢[acme@toolbox pahole]$ rpm -q elfutils-libs
elfutils-libs-0.186-1.fc34.x86_64

Andrii https://github.com/libbpf/libbpf/actions/workflows/pahole.yml is
in failure mode for 3 days, and only yesterday I pushed these changes,
seems unrelated to pahole:

Tests exit status: 1
Test Results:
             bpftool: PASS
          test_progs: FAIL (returned 1)
 test_progs-no_alu32: FAIL (returned 1)
       test_verifier: PASS
            shutdown: CLEAN
Error: Process completed with exit code 1.

Can you please check?

- Arnaldo
