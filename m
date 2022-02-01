Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0174A5765
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 07:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiBAG42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 01:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBAG41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 01:56:27 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C2C061714;
        Mon, 31 Jan 2022 22:56:27 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o10so13521481ilh.0;
        Mon, 31 Jan 2022 22:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=efmXgSHow+DrqHYcYhOYUkAMNZE0Nqdd6w1KvEV5vEc=;
        b=jmFnOFyNLjMA14trFefq4Nbfm7XUNFBFNiDVR03PmIm+qevygDCMvXEslBtlPoGQJR
         AHBiFwB250ATZVFU/8ix03lXQoMpWT9xjMVPYha2g38HFwApvBaQZt6VkvPgRIopwpAo
         6Vp00GfpqMAMWUziFK/Qxr7HctR+D0Ctb/Gf+8iEihmFV9qgO+dXv87f2xLnDtCZdmrE
         QiX3XGFMekz7BXeHvTTzeraX5hQkjMmFyQDnXv3cOaCTsSU/tjU052Up5xCaUkBySYgj
         1vn0pNImqME2151KQ8uyrCNvObGhMEoa6DiKTJRxIQgV/I6lwkAOJxizaw8CtYJXPesJ
         ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=efmXgSHow+DrqHYcYhOYUkAMNZE0Nqdd6w1KvEV5vEc=;
        b=lMi3zEep4jlQsD69schP3133oMyBrFjgy8/+adpibERCMn636te/tWHmMgF3+YSeEf
         aHDJOfRn4YTY4wAoNmmsA222YOVLijANJFwj99RShgeITvJoVTLwEAeSbzXgxC45eGnk
         TPOpl2n13pOXoENBLjTsZwKK2doFZp+8yHe13b5kVWJErNwPX7ajZq76M2i0Gfz8gba6
         IHIpi838KPI2MHgofjyi5Gxf/NLT4L1P2J//8oC7htjBBhFqOOyCyGRKajYK0eETUaLz
         dkraORHPMqLOxhwHQQoHZZ08SzJgdnjQ9ZYstoEZLboQdrXJu95BVP4+wM8KbhOnmRiA
         sU6A==
X-Gm-Message-State: AOAM5327A+x/NrBh5ENxIcDBQ63wiLBJVGgyTKemLsVRWkdwGCW/uU10
        degVrJsm4O60rNOr/VSFtA30DyE8COXpIt8j98s=
X-Google-Smtp-Source: ABdhPJwU0qLA1fiEv5ZJFv+f43vg0gAX41c6ZeNKQ+HkuvcZ4HQJ4f05YB26g3wkjusgCeRTpWUcRtDwuVMhp6Mlark=
X-Received: by 2002:a05:6e02:2163:: with SMTP id s3mr13530641ilv.252.1643698587108;
 Mon, 31 Jan 2022 22:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20220126192039.2840752-1-kuifeng@fb.com> <20220126192039.2840752-4-kuifeng@fb.com>
 <CAEf4BzYwOWJsfYMOLPt+cX=AB2pFSbcesH-6q_O-AqVT8=CnsQ@mail.gmail.com>
 <YfL8kjM30uHN3qxs@kernel.org> <YfRJGJ35SQCy+98H@kernel.org>
In-Reply-To: <YfRJGJ35SQCy+98H@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 22:56:16 -0800
Message-ID: <CAEf4BzZJzbRZAKgg=Kjg+G2AmD8-H_Pk9j26umicDVAtyWes+g@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 3/4] pahole: Use per-thread btf instances to
 avoid mutex locking.
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mark Wielaard <mjw@redhat.com>, Kui-Feng Lee <kuifeng@fb.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 11:52 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Jan 27, 2022 at 05:12:02PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Wed, Jan 26, 2022 at 11:58:27AM -0800, Andrii Nakryiko escreveu:
> > > On Wed, Jan 26, 2022 at 11:21 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
> > > > Create an instance of btf for each worker thread, and add type info=
 to
> > > > the local btf instance in the steal-function of pahole without mute=
x
> > > > acquiring.  Once finished with all worker threads, merge all
> > > > per-thread btf instances to the primary btf instance.
>
> > > There are still unnecessary casts and missing {} in the else branch,
> > > but I'll let Arnaldo decide or fix it up.
>
> So its just one unneeded cast as thr_data here is just a 'void *':
>
> diff --git a/pahole.c b/pahole.c
> index 8c0a982f05c9ae3d..39e18804100dbfda 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2924,7 +2924,7 @@ static enum load_steal_kind pahole_stealer(struct c=
u *cu,
>                  * avoids copying the data collected by the first thread.
>                  */
>                 if (thr_data) {
> -                       struct thread_data *thread =3D (struct thread_dat=
a *)thr_data;
> +                       struct thread_data *thread =3D thr_data;
>
>                         if (thread->encoder =3D=3D NULL) {
>                                 thread->encoder =3D
>
>
> This other is needed as it is a "void **":
>
> @@ -2832,7 +2832,7 @@ static int pahole_thread_exit(struct conf_load *con=
f, void *thr_data)
>  static int pahole_threads_collect(struct conf_load *conf, int nr_threads=
, void **thr_data,
>                                   int error)
>  {
> -       struct thread_data **threads =3D (struct thread_data **)thr_data;
> +       struct thread_data **threads =3D thr_data;
>         int i;
>         int err =3D 0;
>
>
> Removing it:
>
> /var/home/acme/git/pahole/pahole.c: In function =E2=80=98pahole_threads_c=
ollect=E2=80=99:
> /var/home/acme/git/pahole/pahole.c:2835:40: warning: initialization of =
=E2=80=98struct thread_data **=E2=80=99 from incompatible pointer type =E2=
=80=98void **=E2=80=99 [-Wincompatible-pointer-types]
>  2835 |         struct thread_data **threads =3D thr_data;
>       |                                        ^~~~~~~~
>
>
> And I did some more profiling, now the focus should go to elfutils:
>
> =E2=AC=A2[acme@toolbox pahole]$ perf report --no-children -s dso --call-g=
raph none 2> /dev/null | head -20
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 27K of event 'cycles:u'
> # Event count (approx.): 27956766207
> #
> # Overhead  Shared Object
> # ........  ...................
> #
>     46.70%  libdwarves.so.1.0.0
>     39.84%  libdw-0.186.so
>      9.70%  libc-2.33.so
>      2.14%  libpthread-2.33.so
>      1.47%  [unknown]
>      0.09%  ld-2.33.so
>      0.06%  libelf-0.186.so
>      0.00%  libcrypto.so.1.1.1l
>      0.00%  libk5crypto.so.3.1
> =E2=AC=A2[acme@toolbox pahole]$
>
> $ perf report -g graph,0.5,2 --stdio --no-children -s dso --dso libdw-0.1=
86.so
>

[...]

>
> #
> # (Tip: If you have debuginfo enabled, try: perf report -s sym,srcline)
> #
>
> This find_attr thing needs improvements, its a linear search AFAIK, some
> hashtable could do wonders, I guess.
>
> Mark, was this considered at some point?

This would be a great improvement, yes!

But strange that you didn't see any BTF-related functions, are you
sure you profiled the entire DWARF to BTF conversion process? BTF
encoding is not dominant, but noticeable anyways (e.g., adding unique
strings to BTF is relatively expensive still).

>
> =E2=AC=A2[acme@toolbox pahole]$ rpm -q elfutils-libs
> elfutils-libs-0.186-1.fc34.x86_64
>
> Andrii https://github.com/libbpf/libbpf/actions/workflows/pahole.yml is
> in failure mode for 3 days, and only yesterday I pushed these changes,
> seems unrelated to pahole:
>
> Tests exit status: 1
> Test Results:
>              bpftool: PASS
>           test_progs: FAIL (returned 1)
>  test_progs-no_alu32: FAIL (returned 1)
>        test_verifier: PASS
>             shutdown: CLEAN
> Error: Process completed with exit code 1.
>
> Can you please check?

Yes, it's not related to pahole. This is the BPF selftests issue which
I already fixed last week, but didn't get a chance to sync everything
to Github repo before leaving for a short vacation. I'll do another
sync tonight and it should be all green again.

>
> - Arnaldo
