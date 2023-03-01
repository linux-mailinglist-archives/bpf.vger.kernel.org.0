Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2606A736C
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCAS1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 13:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAS1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 13:27:36 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8743948E36
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:27:34 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 12CCE2405B2
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 19:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677695253; bh=+oetHsEM3wy3QRucmSjtCwm2kJARXySARNKFB5nKk+s=;
        h=Date:From:To:Cc:Subject:From;
        b=CGbZivH088+k83laczwNJ76akHXTDSBebhzrHZr/WZmpQnGNoLcYEwCGqBUFp9rff
         r32Q4NF8Ww6hNd0BuaCyhWB6KDamgiY3SdffEfpjgEevMCHNKjr5MmgW2Rvbpn3L+q
         /3mp7olmGzvIyVQ01OIXWjb/84ucppIbRxQAIuGFeyKgKuVxaUDOjb5Z/3df8zDzpd
         NHNLdqOacW89j/OvYG/38Pni3DhvsQTSQ5a8lJG6nFH4S7fzTJQjSW6vaUPzKuo/O9
         4oCXSsN3I/Vn4F85mnxqki7C1ymL4d993ia/+zuc2fJLKz6yMh4fBsIcl2DlXuuo/S
         K+P2brhJdFf0A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRjQB0mkjz9rxK;
        Wed,  1 Mar 2023 19:27:29 +0100 (CET)
Date:   Wed,  1 Mar 2023 18:27:26 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: Add support for attaching
 uprobes to shared objects in APKs
Message-ID: <20230301182726.xnz2zedf5u6q4p6y@muellerd-fedora-PC2BDTX9>
References: <20230221234500.2653976-1-deso@posteo.net>
 <20230221234500.2653976-4-deso@posteo.net>
 <CAEf4BzbBc_YjED3qyfBdVCDcz_vWpDwMoc3zh-MhoVekx8qXUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbBc_YjED3qyfBdVCDcz_vWpDwMoc3zh-MhoVekx8qXUw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 24, 2023 at 01:19:25PM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 21, 2023 at 3:45 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change adds support for attaching uprobes to shared objects located
> > in APKs, which is relevant for Android systems where various libraries
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
> >  tools/lib/bpf/libbpf.c | 87 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 80 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4543e9..a41993b 100644
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
> > @@ -10702,6 +10703,65 @@ static long elf_find_func_offset_from_file(const char *binary_path, const char *
> >         return ret;
> >  }
> >
> > +/* Find offset of function name in archive specified by path. Currently
> > + * supported are .zip files that do not compress their contents, as used on
> > + * Android in the form of APKs, for example. "file_name" is the name of the ELF
> > + * file inside the archive. "func_name" matches symbol name or name@@LIB for
> > + * library functions.
> > + *
> > + * An overview of the APK format specifically provided here:
> > + * https://en.wikipedia.org/w/index.php?title=Apk_(file_format)&oldid=1139099120#Package_contents
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
> > +               pr_warn("zip: failed to open %s\n", archive_path);
> > +               return -LIBBPF_ERRNO__FORMAT;
> 
> we don't preserve errno inside zip_archive_open, it might be useful,
> though, because there is a difference between "file not found", "file
> has invalid format", "we don't have permission", which is where errno
> comes in handy

Changed.

> > +       }
> > +
> > +       if (zip_archive_find_entry(archive, file_name, &entry)) {
> > +               pr_warn("zip: could not find archive member %s in %s\n", file_name, archive_path);
> > +               ret = -LIBBPF_ERRNO__FORMAT;
> 
> let's preserve error code returned from zip_archive_find_entry and log
> it in above pr_warn. It's not always format problem, requested
> binary/library might be just missing from APK

Okay.

> > @@ -10806,21 +10867,33 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >         if (!binary_path)
> >                 return libbpf_err_ptr(-EINVAL);
> >
> > -       if (!strchr(binary_path, '/')) {
> > -               err = resolve_full_path(binary_path, full_binary_path,
> > -                                       sizeof(full_binary_path));
> > +       /* Check if "binary_path" refers to an archive. */
> > +       archive_sep = strstr(binary_path, "!/");
> > +       if (archive_sep) {
> > +               full_path[0] = '\0';
> > +               libbpf_strlcpy(full_path, binary_path, archive_sep - binary_path + 1);
> 
> that's probably the bug you mentioned offline, should be
> sizeof(full_path) for the third arg, right?

Correct. The problem is that binary_path is not NUL terminated where we want it
to be, but that is what libbpf_strlcpy expects. Changed it as per your offline
suggestion.

Thanks,
Daniel
