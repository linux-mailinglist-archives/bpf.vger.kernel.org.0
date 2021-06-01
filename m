Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147F7397A1F
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 20:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFASdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 14:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFASdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 14:33:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8B5A60C3E;
        Tue,  1 Jun 2021 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622572321;
        bh=tfLmDoD2A/FjiUUim8kEno/O4lsMLZZbgYptzDIEhAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iAv7JeLlx9Q9r8k9em0BD0AfODxIV21NrIkSkCjnkke6gh4Aq9q/13GWqtd7ZPanp
         SGRZ7bEQxki91/yu/o00E+D0SGGoqok+aXZyeybskEh23AozZbUfDvpqBPPDytjAq+
         WXurkXR1T6RhN2++dN/bLaei/MJAbC/KpSsq5W20UHcLFVrrV1MP3FkZ1CIq6qZsH1
         KfsX9Z0jqeTTPpaknhg+DWnYK1ivNWPo8iiSYNFt3hJj+b3X7vZn1OtrNOhagU5ULC
         Wr+BeX43egZTk4aO4hFGc7dT2omPQb72awFWcjYgs32fa9VU8VHIDOmiE+gNnLZ41j
         TNVDtRgD5pLCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 508C74011C; Tue,  1 Jun 2021 15:31:58 -0300 (-03)
Date:   Tue, 1 Jun 2021 15:31:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YLZ9HiPoQDSV8X9V@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com>
 <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com>
 <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org>
 <CAEf4BzbathRWddRWGAFg2-dHwLNgd7nsYXYpb6NX1j1Wo8_LWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbathRWddRWGAFg2-dHwLNgd7nsYXYpb6NX1j1Wo8_LWQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, May 28, 2021 at 07:36:25PM -0700, Andrii Nakryiko escreveu:
> On Fri, May 28, 2021 at 12:45 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
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
> 
> btf__parse() handles both ELF and raw BTF transparently. Then there is
> btf__parse_elf() and btf__parse_raw() for specifically ELF or raw.
> 
> See all APIs at:
> https://github.com/libbpf/libbpf/blob/master/src/btf.h#L40

Ok, I was using:

int btf_elf__load(struct btf_elf *btfe)
{
        int err;

        libbpf_set_print(libbpf_log);

        /* free initial empty BTF */
        btf__free(btfe->btf);
        if (btfe->raw_btf)
                btfe->btf = btf__parse_raw_split(btfe->filename, btfe->base_btf);
        else
                btfe->btf = btf__parse_elf_split(btfe->filename, btfe->base_btf);

        err = libbpf_get_error(btfe->btf);
        if (err)
                return err;

        return 0;
}


but btf__parse(path, btfext_ptr) doesn't allow me to apss the base btf,
lemme see if there is a btf__parse_split...

- Arnaldo
 
> >
> > Please test, and if works as expected, try to bolt this into the kbuild
> > process, as intended.
> 
> I'm on PTO today, will try to get to this soon-ish.
> 
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
> > +       uint32_t raw_btf_size;
> > +       const void *raw_btf_data;
> > +       int fd, err;
> > +
> > +       /* Empty file, nothing to do, so... done! */
> > +       if (btf__get_nr_types(btf) == 0)
> > +               return 0;
> > +
> > +       if (btf__dedup(btf, NULL, NULL)) {
> > +               fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
> > +               return -1;
> > +       }
> > +
> > +       raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
> > +       if (raw_btf_data == NULL) {
> > +                fprintf(stderr, "%s: btf__get_raw_data failed!\n", __func__);
> > +               return -1;
> > +       }
> > +
> > +       fd = open(filename, O_WRONLY | O_CREAT);
> > +       if (fd < 0) {
> > +                fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));
> > +               return -1;
> > +       }
> > +       err = write(fd, raw_btf_data, raw_btf_size);
> > +       if (err < 0)
> > +                fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));
> > +
> > +       close(fd);
> > +
> > +       if (err != raw_btf_size) {
> > +                fprintf(stderr, "%s: Could only write %d bytes to %s of raw BTF info out of %d, aborting\n", __func__, err, filename, raw_btf_size);
> > +               unlink(filename);
> > +               err = -1;
> > +       } else {
> > +               /* go from bytes written == raw_btf_size to an indication that all went fine */
> > +               err = 0;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +int btf_encoder__encode(const char *filename)
> >  {
> >         int err;
> >
> >         if (gobuffer__size(&btfe->percpu_secinfo) != 0)
> >                 btf_elf__add_datasec_type(btfe, PERCPU_SECTION, &btfe->percpu_secinfo);
> >
> > -       err = btf_elf__encode(btfe, 0);
> > +       if (filename == NULL)
> > +               err = btf_elf__encode(btfe, 0);
> > +       else
> > +               err = btf_encoder__dump(btfe->btf, filename);
> > +
> >         delete_functions();
> >         btf_elf__delete(btfe);
> >         btfe = NULL;
> > @@ -412,7 +468,7 @@ static bool has_arg_names(struct cu *cu, struct ftype *ftype)
> >  }
> >
> >  int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > -                  bool skip_encoding_vars)
> > +                  bool skip_encoding_vars, const char *detached_btf_filename)
> >  {
> >         uint32_t type_id_off;
> >         uint32_t core_id;
> > @@ -425,7 +481,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >         btf_elf__force = force;
> >
> >         if (btfe && strcmp(btfe->filename, cu->filename)) {
> > -               err = btf_encoder__encode();
> > +               err = btf_encoder__encode(detached_btf_filename);
> >                 if (err)
> >                         goto out;
> >
> > diff --git a/btf_encoder.h b/btf_encoder.h
> > index 46fb2312fc0eea9b..bfc6085092028adc 100644
> > --- a/btf_encoder.h
> > +++ b/btf_encoder.h
> > @@ -11,9 +11,9 @@
> >
> >  struct cu;
> >
> > -int btf_encoder__encode();
> > +int btf_encoder__encode(const char *filename);
> >
> >  int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > -                  bool skip_encoding_vars);
> > +                  bool skip_encoding_vars, const char *detached_btf_filename);
> >
> >  #endif /* _BTF_ENCODER_H_ */
> > diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> > index 2659fe6f231405d8..6e7ded59595f5ea7 100644
> > --- a/man-pages/pahole.1
> > +++ b/man-pages/pahole.1
> > @@ -189,6 +189,10 @@ features such as BPF CO-RE (Compile Once - Run Everywhere).
> >
> >  See \fIhttps://nakryiko.com/posts/bpf-portability-and-co-re/\fR.
> >
> > +.TP
> > +.B \-j, \-\-btf_encode_detached=FILENAME
> > +Same thing as -J/--btf_encode, but storing the raw BTF info into a separate file.
> > +
> >  .TP
> >  .B \-\-btf_encode_force
> >  Ignore those symbols found invalid when encoding BTF.
> > diff --git a/pahole.c b/pahole.c
> > index 24659e2969c8fb85..1cbff6175b60af51 100644
> > --- a/pahole.c
> > +++ b/pahole.c
> > @@ -26,6 +26,7 @@
> >  #include "lib/bpf/src/libbpf.h"
> >  #include "pahole_strings.h"
> >
> > +static char *detached_btf_filename;
> >  static bool btf_encode;
> >  static bool ctf_encode;
> >  static bool first_obj_only;
> > @@ -1152,6 +1153,12 @@ static const struct argp_option pahole__options[] = {
> >                 .key  = 'J',
> >                 .doc  = "Encode as BTF",
> >         },
> > +       {
> > +               .name = "btf_encode_detached",
> > +               .key  = 'j',
> > +               .arg  = "FILENAME",
> > +               .doc  = "Encode as BTF in a detached file",
> > +       },
> >         {
> >                 .name = "skip_encoding_btf_vars",
> >                 .key  = ARGP_skip_encoding_btf_vars,
> > @@ -1223,6 +1230,7 @@ static error_t pahole__options_parser(int key, char *arg,
> >                   conf_load.extra_dbg_info = 1;         break;
> >         case 'i': find_containers = 1;
> >                   class_name = arg;                     break;
> > +       case 'j': detached_btf_filename = arg; // fallthru
> >         case 'J': btf_encode = 1;
> >                   conf_load.get_addr_info = true;
> >                   no_bitfield_type_recode = true;       break;
> > @@ -2458,7 +2466,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
> >
> >         if (btf_encode) {
> >                 if (cu__encode_btf(cu, global_verbose, btf_encode_force,
> > -                                  skip_encoding_btf_vars)) {
> > +                                  skip_encoding_btf_vars, detached_btf_filename)) {
> >                         fprintf(stderr, "Encountered error while encoding BTF.\n");
> >                         exit(1);
> >                 }
> > @@ -2872,7 +2880,7 @@ try_sole_arg_as_class_names:
> >         header = NULL;
> >
> >         if (btf_encode) {
> > -               err = btf_encoder__encode();
> > +               err = btf_encoder__encode(detached_btf_filename);
> >                 if (err) {
> >                         fputs("Failed to encode BTF\n", stderr);
> >                         goto out_cus_delete;

-- 

- Arnaldo
