Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21A397A6F
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFATJQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 15:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFATJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 15:09:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB266611CA;
        Tue,  1 Jun 2021 19:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622574454;
        bh=L2UfCuZdh3bYpjGqac8bml/rp6oPqGoD9WBWvOT8i04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTjaVSCwJy4p6ptS6WkSklhEawUZRo+zByYngAsGiozlZRrVUmSfiQh82Ve+sqXBT
         Tr+xAezHyQBGBocBuXCuGjEwep2NUK6wd+csd0b5+QUTPl/jEpQKKvv/LsbbPcgHIn
         5L7wCXYQqykV2rM0PT3sTG/Y6tSde46agF3YWjcuDTNVsINwlhn9DDxpFxtWtuMI0+
         xs3Z5oHGYsNkEg9xI3n1Lr8eG+dcjdKEsgLqwEppYCKCM71Fn99MbsmV2bav/MAXEy
         A+YpZXFDQg8eBRqG0J7mQjgZl4kxqmZC5BbUoKnXjAwx2qzL6y4btCk192v90I0o+t
         YBaqnqSOMzI/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB9214011C; Tue,  1 Jun 2021 16:07:30 -0300 (-03)
Date:   Tue, 1 Jun 2021 16:07:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YLaFcvvizHjkaz9x@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <YLQHax7hZqfFS4Tf@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLQHax7hZqfFS4Tf@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, May 30, 2021 at 11:45:15PM +0200, Jiri Olsa escreveu:
> On Fri, May 28, 2021 at 04:45:31PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 27, 2021 at 01:41:13PM -0700, Andrii Nakryiko escreveu:
> > > On Thu, May 27, 2021 at 12:57 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
> > > > On May 27, 2021 4:14:17 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > >If we make 1.22 mandatory there will be no good reason to make 1.23
> > > > >mandatory again. So I will have absolutely no inclination to work on
> > > > >this, for example. So we are just wasting a chance to clean up the
> > > > >Kbuild story w.r.t. pahole. And we are talking about just a few days
> > > > >at most, while we do have a reasonable work around on the kernel side.
> > 
> > > > So there were patches for stop using objcopy, which we thought could
> > > > uncover some can of worms, were there patches for the detached BTF
> > > > file?
> >  
> > > No, there weren't, if I remember correctly. What's the concern,
> > > though? That detached BTF file isn't even an ELF, so it's
> > > btf__get_raw_data() and write it to the file. Done.
> > 
> > See patch below, lightly tested, now working on making pahole accept raw
> > BTF files out of /sys/kernel/btf/
> > 
> > Please test, and if works as expected, try to bolt this into the kbuild
> > process, as intended.
> > 
> > - Arnaldo
> > 
> > commit b579a18a1ea0ee84b90b5302f597dda2edf2f61b
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Fri May 28 16:41:30 2021 -0300
> > 
> >     pahole: Allow encoding BTF into a detached file
> >     
> >     Previously the newly encoded BTF info was stored into a ELF section in
> >     the file where the DWARF info was obtained, but it is useful to just
> >     dump it into a separate file, do it.
> >     
> >     Requested-by: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 033c927b537dad1e..bc3ac72968cea826 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -21,6 +21,14 @@
> >  #include <stdlib.h> /* for qsort() and bsearch() */
> >  #include <inttypes.h>
> >  
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +
> > +#include <unistd.h>
> > +
> > +#include <errno.h>
> > +
> >  /*
> >   * This corresponds to the same macro defined in
> >   * include/linux/kallsyms.h
> > @@ -267,14 +275,62 @@ static struct btf_elf *btfe;
> >  static uint32_t array_index_id;
> >  static bool has_index_type;
> >  
> > -int btf_encoder__encode()
> > +static int btf_encoder__dump(struct btf *btf, const char *filename)
> > +{
> > +	uint32_t raw_btf_size;
> > +	const void *raw_btf_data;
> > +	int fd, err;
> > +
> > +	/* Empty file, nothing to do, so... done! */
> > +	if (btf__get_nr_types(btf) == 0)
> > +		return 0;
> > +
> > +	if (btf__dedup(btf, NULL, NULL)) {
> > +		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
> > +		return -1;
> > +	}
> > +
> > +	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > +	if (raw_btf_data == NULL) {
> > +                fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);
> > +		return -1;
> > +	}
> > +
> > +	fd = open(filename, O_WRONLY | O_CREAT);
> 
> I think you need to specify file mode as 3rd param:

Right you are! I've read this comment from you and, left it for later
and then when I used btf__parse_split("vmlinux.btf", NULL) as Andrii
suggested, I got a EPERM, erm? tried
btf__parse-split("/sys/kernel/btf/vmlinux", NULL), it worked, humm,
yeah, Jiri mentioned something about weird modes... Fixed it using
'chmod 644' and it worked.

Now fixing it by adding the 3rd param, thanks!

- Arnaldo
 
> 	$ ./pahole -j krava vmlinux 
> 	$ ~/linux/tools/bpf/bpftool/bpftool btf dump file ./krava 
> 	Error: failed to load BTF from ./krava: Permission denied
> 	$ ll krava 
> 	--w-r-Sr-T. 1 jolsa jolsa 4525734 May 30 23:38 krava
> 
> jirka
> 

-- 

- Arnaldo
