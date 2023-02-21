Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E9469E98D
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBUVhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 16:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjBUVhF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 16:37:05 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606FC28D1A
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 13:37:03 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E374B240737
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 22:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677015421; bh=6xC58Q8TvHzvU3r4etDmEpxXdhWLUYA9ylmoJJKivZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=niWYyIA0+6l3octyBal/agiDl8MT86S75Kg58QGRj+sKNmEhKiB4JLqhz1RiOVdp3
         K6Gk+BY60ajWdW3msOmBJcYz1yaQ5ZivkNWsiDyDR2hmr6eUChVMPpSovnJCyRhGrn
         mKhe8X6CV2tbrnhV43eNFyGLQJP2BDOE25ebY7B8WPzuntQfXSXV4p62QODbiyEnKZ
         v3jclaZa26ASYa4597dIJLHvI7aBFhJaJ9IcKEUUqDJRVomiUDia2Pu+TEnAGjJ8eL
         gAYxksNfKvQ8T1jqhYwZbVz2bzYGJrKHg+Ibh8fw8NZHOkezCMXtneUNowYs/vHueO
         d4/U4JknjJOQw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PLt0W2TLmz9rxD;
        Tue, 21 Feb 2023 22:36:59 +0100 (CET)
Date:   Tue, 21 Feb 2023 21:36:55 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes
 to shared objects in APKs
Message-ID: <20230221213655.zu7zl77damfzxeat@muellerd-fedora-PC2BDTX9>
References: <20230217191908.1000004-1-deso@posteo.net>
 <20230217191908.1000004-4-deso@posteo.net>
 <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 17, 2023 at 04:32:05PM -0800, Andrii Nakryiko wrote:
> On Fri, Feb 17, 2023 at 11:19 AM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change adds support for attaching uprobes to shared objects located
> > in APKs, which is relevant for Android systems where various libraries
> 
> Is there a good link with description of APK that we can record
> somewhere in the comments for future us?

Perhaps
https://en.wikipedia.org/w/index.php?title=Apk_(file_format)&oldid=1139099120#Package_contents.

Will add it.

> Also, does .apk contains only shared libraries, or it could be also
> just a binary?

It probably could also be for a binary, judging from applications being
available for download in the form of APKs.

> > may reside in APKs. To make that happen, we extend the syntax for the
> > "binary path" argument to attach to with that supported by various
> > Android tools:
> >   <archive>!/<binary-in-archive>
> >
> > For example:
> >   /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.so
> >
> > APKs need to be specified via full path, i.e., we do not attempt to
> > resolve mere file names by searching system directories.
> 
> mere?

Yes?

> >
> > We cannot currently test this functionality end-to-end in an automated
> > fashion, because it relies on an Android system being present, but there
> > is no support for that in CI. I have tested the functionality manually,
> > by creating a libbpf program containing a uretprobe, attaching it to a
> > function inside a shared object inside an APK, and verifying the sanity
> > of the returned values.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/lib/bpf/libbpf.c | 84 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 80 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index a474f49..79ab85f 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -53,6 +53,7 @@
> >  #include "libbpf_internal.h"
> >  #include "hashmap.h"
> >  #include "bpf_gen_internal.h"
> > +#include "zip.h"
> >
> >  #ifndef BPF_FS_MAGIC
> >  #define BPF_FS_MAGIC           0xcafe4a11
> > @@ -10702,6 +10703,60 @@ static long elf_find_func_offset_from_elf_file(const char *binary_path, const ch
> >         return ret;
> >  }
> >
> > +/* Find offset of function name in archive specified by path. Currently
> > + * supported are .zip files that do not compress their contents (as used on
> > + * Android in the form of APKs, for example).  "file_name" is the name of the
> > + * ELF file inside the archive.  "func_name" matches symbol name or name@@LIB
> > + * for library functions.
> 
> These double spaces after dot were not intended, let's not add more.

Sure.

> > + */
> > +static long elf_find_func_offset_from_archive(const char *archive_path, const char *file_name,
> > +                                             const char *func_name)
> > +{
> > +       struct zip_archive *archive;
> > +       struct zip_entry entry;
> > +       long ret = -ENOENT;
> > +       Elf *elf;
> > +
> > +       archive = zip_archive_open(archive_path);
> > +       if (!archive) {
> > +               pr_warn("failed to open %s\n", archive_path);
> 
> add "zip: " prefix?

Added.

> > +               return -LIBBPF_ERRNO__FORMAT;
> > +       }
> > +
> > +       if (zip_archive_find_entry(archive, file_name, &entry)) {
> > +               pr_warn("zip: could not find archive member %s in %s\n", file_name, archive_path);
> > +               ret = -LIBBPF_ERRNO__FORMAT;
> > +               goto out;
> > +       }
> > +
> > +       if (entry.compression) {
> > +               pr_warn("zip: entry %s of %s is compressed and cannot be handled\n", file_name,
> > +                       archive_path);
> > +               ret = -LIBBPF_ERRNO__FORMAT;
> > +               goto out;
> > +       }
> > +
> > +       elf = elf_memory((void *)entry.data, entry.data_length);
> > +       if (!elf) {
> > +               pr_warn("elf: could not read elf file %s from %s: %s\n", file_name, archive_path,
> 
> I kind of like preserving the "archive/path!/file/path" consistently
> through error messages when referring to file within APK, WDYT?

It seems valuable to me to make it clear that we "parsed" the string correctly
and split it into the expected parts.

> > +                       elf_errmsg(-1));
> > +               ret = -LIBBPF_ERRNO__FORMAT;
> > +               goto out;
> > +       }
> > +
> > +       ret = elf_find_func_offset(elf, file_name, func_name);
> > +       if (ret > 0) {
> > +               ret += entry.data_offset;
> > +               pr_debug("elf: symbol address match for '%s' in '%s': 0x%lx\n", func_name,
> > +                        archive_path, ret);
> 
> so for debugging I feel like we'll want to know both entry.data_offset
> and original ELF offset, let's report all three offset (including the
> final calculated one)?

I added one more pr_debug() printing the entry offset. The ELF offset is
reported by elf_find_func_offset() and the final offset here.

> > +       }
> > +       elf_end(elf);
> > +
> > +out:
> > +       zip_archive_close(archive);
> > +       return ret;
> > +}
> > +
> >  static const char *arch_specific_lib_paths(void)
> >  {
> >         /*
> > @@ -10789,6 +10844,9 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >  {
> >         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> >         char errmsg[STRERR_BUFSIZE], *legacy_probe = NULL;
> > +       const char *archive_path = NULL;
> > +       const char *archive_sep = NULL;
> 
> nit: combine on a single line?
> 
> > +       char full_archive_path[PATH_MAX];
> >         char full_binary_path[PATH_MAX];
> >         struct bpf_link *link;
> >         size_t ref_ctr_off;
> > @@ -10806,9 +10864,21 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >         if (!binary_path)
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > -       if (!strchr(binary_path, '/')) {
> > -               err = resolve_full_path(binary_path, full_binary_path,
> > -                                       sizeof(full_binary_path));
> > +       /* Check if "binary_path" refers to an archive. */
> > +       archive_sep = strstr(binary_path, "!/");
> > +       if (archive_sep) {
> > +               if (archive_sep - binary_path >= sizeof(full_archive_path)) {
> 
> very unlikely to happen, I wouldn't bother checking, especially that
> strncpy will just truncate and make us fail anyways

How will it "make us fail"? It will silently truncate the path, no?

> > +                       return libbpf_err_ptr(-EINVAL);
> > +               }
> > +
> > +               strncpy(full_archive_path, binary_path, archive_sep - binary_path);
> 
> let's use saner libbpf_strlcpy() instead of strncpy, we stopped using
> strncpy relatively recently

Okay.

> > +               full_archive_path[archive_sep - binary_path] = 0;
> 
> strlcpy makes sure the resulting string is zero-terminated.
> 
> But note that full_archive_path[0] is not guaranteed to be zero, so
> strncpy/strlcpy might preserve some garbage in front. Let's make sure
> full_archive_path[0] = '\0'; before manipulating that buffer

Sure.

> > +               archive_path = full_archive_path;
> > +
> > +               strcpy(full_binary_path, archive_sep + 2);
> > +               binary_path = full_binary_path;
> 
> no need to copy, just `binary_path = archive_sep + 2;`? And thus we
> can reuse full_binary_path buffer for archive path (we can rename it
> to be more generic "full_path" name or something)

Okay.

> > +       } else if (!strchr(binary_path, '/')) {
> > +               err = resolve_full_path(binary_path, full_binary_path, sizeof(full_binary_path));
> >                 if (err) {
> >                         pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
> >                                 prog->name, binary_path, err);
> > @@ -10820,7 +10890,13 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >         if (func_name) {
> >                 long sym_off;
> >
> > -               sym_off = elf_find_func_offset_from_elf_file(binary_path, func_name);
> > +               if (archive_path) {
> > +                       sym_off = elf_find_func_offset_from_archive(archive_path, binary_path,
> > +                                                                   func_name);
> > +                       binary_path = archive_path;
> > +               } else {
> > +                       sym_off = elf_find_func_offset_from_elf_file(binary_path, func_name);
> > +               }
> >                 if (sym_off < 0)
> >                         return libbpf_err_ptr(sym_off);
> >                 func_offset += sym_off;
> > --
> > 2.30.2
> >
