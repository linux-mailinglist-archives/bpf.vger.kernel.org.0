Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E24A691F
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 01:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbiBBAQg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 19:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiBBAQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 19:16:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C51C061714;
        Tue,  1 Feb 2022 16:16:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B430DB82FDC;
        Wed,  2 Feb 2022 00:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26694C340E9;
        Wed,  2 Feb 2022 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643760992;
        bh=B7fkvLlyyPJefhPM/sjI7DHmR1jImbJstKCoGfEeUTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBFX593LEwW01QZhVtsF9RmP+U3E90Qb/cwDEZAcuv4Tp/r9DEZTqRSygU6UwHg1K
         +QkNqdfesubzUb55YGY/TQOGNO6s9Lw7Aizl6HqfU0hiMwRr/POCIaqAT1naF5E+D6
         rOXKEAGArbmSU910MqLILV5IOlWTVm4Hh/PZeTXyfQ3TbU5RvDwFa14MBL6xZ5e84h
         QzT8ZQmGB9aKwCJKQAlPt1nY3d5YTSBqP1LrdGNH38+SfUagi2J1rOXoveeNDBlD7U
         IYOQeWKOPA4CLIHuJVqraLmvDRqt6/gVselNk0JjcI7jYHKIAr8+58aGJPf71IBPZF
         yIfh4f065HNiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC74940466; Tue,  1 Feb 2022 21:16:29 -0300 (-03)
Date:   Tue, 1 Feb 2022 21:16:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Mark Wielaard <mjw@redhat.com>, Kui-Feng Lee <kuifeng@fb.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
Message-ID: <YfnNXZPFRra3kmhb@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-4-kuifeng@fb.com>
 <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
 <YfL8kjM30uHN3qxs@kernel.org>
 <YfRJGJ35SQCy+98H@kernel.org>
 <CAEf4BzZJzbRZAKgg=Kjg+G2AmD8-H_Pk9j26umicDVAtyWes+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZJzbRZAKgg=Kjg+G2AmD8-H_Pk9j26umicDVAtyWes+g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 31, 2022 at 10:56:16PM -0800, Andrii Nakryiko escreveu:
> On Fri, Jan 28, 2022 at 11:52 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Jan 27, 2022 at 05:12:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, Jan 26, 2022 at 11:58:27AM -0800, Andrii Nakryiko escreveu:
> > > > On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > > > Create an instance of btf for each worker thread, and add type info to
> > > > > the local btf instance in the steal-function of pahole without mutex
> > > > > acquiring.  Once finished with all worker threads, merge all
> > > > > per-thread btf instances to the primary btf instance.
> >
> > > > There are still unnecessary casts and missing {} in the else branch,
> > > > but I'll let Arnaldo decide or fix it up.
> >
> > So its just one unneeded cast as thr_data here is just a 'void *':
> >
> > diff --git a/pahole.c b/pahole.c
> > index 8c0a982f05c9ae3d..39e18804100dbfda 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -2924,7 +2924,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >                  * avoids copying the data collected by the first thread.
> >                  */
> >                 if (thr_data) {
> > -                       struct thread_data *thread = (struct thread_data *)thr_data;
> > +                       struct thread_data *thread = thr_data;
> >
> >                         if (thread->encoder == NULL) {
> >                                 thread->encoder =
> >
> >
> > This other is needed as it is a "void **":
> >
> > @@ -2832,7 +2832,7 @@ static int pahole_thread_exit(struct conf_load *conf, void *thr_data)
> >  static int pahole_threads_collect(struct conf_load *conf, int nr_threads, void **thr_data,
> >                                   int error)
> >  {
> > -       struct thread_data **threads = (struct thread_data **)thr_data;
> > +       struct thread_data **threads = thr_data;
> >         int i;
> >         int err = 0;
> >
> >
> > Removing it:
> >
> > /var/home/acme/git/pahole/pahole.c: In function ‘pahole_threads_collect’:
> > /var/home/acme/git/pahole/pahole.c:2835:40: warning: initialization of ‘struct thread_data **’ from incompatible pointer type ‘void **’ [-Wincompatible-pointer-types]
> >  2835 |         struct thread_data **threads = thr_data;
> >       |                                        ^~~~~~~~
> >
> >
> > And I did some more profiling, now the focus should go to elfutils:
> >
> > ⬢[acme@toolbox pahole]$ perf report --no-children -s dso --call-graph none 2> /dev/null | head -20
> > # To display the perf.data header info, please use --header/--header-only options.
> > #
> > #
> > # Total Lost Samples: 0
> > #
> > # Samples: 27K of event 'cycles:u'
> > # Event count (approx.): 27956766207
> > #
> > # Overhead  Shared Object
> > # ........  ...................
> > #
> >     46.70%  libdwarves.so.1.0.0
> >     39.84%  libdw-0.186.so
> >      9.70%  libc-2.33.so
> >      2.14%  libpthread-2.33.so
> >      1.47%  [unknown]
> >      0.09%  ld-2.33.so
> >      0.06%  libelf-0.186.so
> >      0.00%  libcrypto.so.1.1.1l
> >      0.00%  libk5crypto.so.3.1
> > ⬢[acme@toolbox pahole]$
> >
> > $ perf report -g graph,0.5,2 --stdio --no-children -s dso --dso libdw-0.186.so
> >
> 
> [...]
> 
> >
> > #
> > # (Tip: If you have debuginfo enabled, try: perf report -s sym,srcline)
> > #
> >
> > This find_attr thing needs improvements, its a linear search AFAIK, some
> > hashtable could do wonders, I guess.
> >
> > Mark, was this considered at some point?
> 
> This would be a great improvement, yes!
> 
> But strange that you didn't see any BTF-related functions, are you
> sure you profiled the entire DWARF to BTF conversion process? BTF
> encoding is not dominant, but noticeable anyways (e.g., adding unique
> strings to BTF is relatively expensive still).

It appears under the 

> >     46.70%  libdwarves.so.1.0.0

line, since we statically link libbpf. So yeah, it was unfortunate the
way I presented the profiling output, I was just trying to point to what
I think is the low hanging fruit, i.e. optimizing find_attr routines in
libdw-0.186.so.
 
> >
> > ⬢[acme@toolbox pahole]$ rpm -q elfutils-libs
> > elfutils-libs-0.186-1.fc34.x86_64
> >
> > Andrii https://github.com/libbpf/libbpf/actions/workflows/pahole.yml is
> > in failure mode for 3 days, and only yesterday I pushed these changes,
> > seems unrelated to pahole:
> >
> > Tests exit status: 1
> > Test Results:
> >              bpftool: PASS
> >           test_progs: FAIL (returned 1)
> >  test_progs-no_alu32: FAIL (returned 1)
> >        test_verifier: PASS
> >             shutdown: CLEAN
> > Error: Process completed with exit code 1.
> >
> > Can you please check?
> 
> Yes, it's not related to pahole. This is the BPF selftests issue which
> I already fixed last week, but didn't get a chance to sync everything
> to Github repo before leaving for a short vacation. I'll do another
> sync tonight and it should be all green again.

I'll check tomorrow.

Going green I'll do some more tests and work towards releasing 1.24.

- Arnaldo
