Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F176A761E
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 22:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCAVYj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 16:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAVYj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 16:24:39 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE58342BD0
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 13:24:37 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2ABBE2405D2
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 22:24:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1677705876; bh=XfrU7/42V9sfsqa+TwtsfaXz+boVPMG659c05Tsk/OQ=;
        h=Date:From:To:Cc:Subject:From;
        b=l1XmrQUhSdDHKA6HYwBzKLQH1cpQ3T2rJDBRraXU5qOMA1qPytgGq9C8T+xvB2IfC
         y8xAZ+/DU4kZqnxnLCxXoX/2UGjmqs0sZjfb/tMXLVaaZH2MflMKSNo0BSOZlCXwTr
         AwrR0udreeZjyV6CQdQk3HWMVP8j9NSXIQYpIZ7pKF5ZisN4ENPtHy4VvAi9ReH0SC
         iRpdMA2rbrCUZIgxpzhsi+QFGhyRTWBS3q23WE/lbd4RgLud2k20jDp+VnHf+4UZTG
         7DTrDZzlP0oeLICHB2Mudptp91pLni2W4coKFN24CSW4s4qGrXmahgVQv3VRzS9APD
         fdCgop3Hk3EZA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PRnLT3hqQz9rxH;
        Wed,  1 Mar 2023 22:24:33 +0100 (CET)
Date:   Wed,  1 Mar 2023 21:24:29 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 3/3] libbpf: Add support for attaching
 uprobes to shared objects in APKs
Message-ID: <20230301212429.ecwivofzfvq6zjbl@muellerd-fedora-PC2BDTX9>
References: <20230301184026.800691-1-deso@posteo.net>
 <20230301184026.800691-4-deso@posteo.net>
 <CAEf4BzYcRjvXhBnsJEWP0YDoDpaVyeBUeyz+LbNWmi-5VL7hoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYcRjvXhBnsJEWP0YDoDpaVyeBUeyz+LbNWmi-5VL7hoA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 01, 2023 at 11:31:09AM -0800, Andrii Nakryiko wrote:
> On Wed, Mar 1, 2023 at 10:40 AM Daniel Müller <deso@posteo.net> wrote:
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
> >  tools/lib/bpf/libbpf.c | 92 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 85 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4543e9..e6b99a 100644
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
> > @@ -10702,6 +10703,69 @@ static long elf_find_func_offset_from_file(const char *binary_path, const char *
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
> > +       int err;
> > +       Elf *elf;
> > +
> > +       archive = zip_archive_open(archive_path);
> > +       if (IS_ERR(archive)) {
> 
> Unfortunately, this won't work with the libbpf_err_ptr() approach that
> you used inside zip_archive_open(). Since libbpf v1.0 libbpf_err_ptr()
> will return NULL on error (and so this IS_ERR() check will always be
> false, and subsequent PTR_ERR() would be returning 0) and only set
> errno to actual error. This was meant to be used mostly for
> user-facing APIs.

Thanks for pointing that out.

> Given zip_archive_open() is internal, explicit PTR_ERR() use as you do
> below makes most sense. Please update and respin.

Sure.

> > +               pr_warn("zip: failed to open %s: %ld\n", archive_path, PTR_ERR(archive));
> > +               return PTR_ERR(archive);
> 
> err = PTR_ERR(archive); and use err in pr_warn() and return?
> 
> and it's not clear why you need both ret and err, it should be fine to
> just use ret (long vs int doesn't hurt error propagation)

Changed.

Thanks,
Daniel
