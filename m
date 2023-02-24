Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1356A143F
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 01:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBXASo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 19:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBXASn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 19:18:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BA4A1C8
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 16:18:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f13so48137445edz.6
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 16:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7owTxeAjjE8Ext3wBWAYOCH+jZdZHl8UO6pYN7WJT8I=;
        b=bp4hzkNtiHrsM5uLWRsheua0HF7UxRvlslL7bl131FPDCxDOEHziJY3n13d0AQ5gMZ
         b6e5GDnmv1K+Hy9/h+/Tv8xOFi8AkUQCViDgL8iPdWNNdIKlXBk7MtS8DO24HsOX2tE4
         s/HkQISz/BvYqzHn87Lb9d8r8VOWC85C3PxNkcbfS7iNV9mIfjh7nlqu+0z5lADW62go
         bPN3fTG3AoSNGEjqYtXJYt88f/9mswdMVJifaueKHu5GEHJHcGw94/RU6TV/cgpVL+Vz
         lEeRZg++Rnoj2pUxxBMZcRL0ZdWXc1/wSKxHcXReJMBDrZhoCChG6vr8X6lNJP0zXpn6
         4how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7owTxeAjjE8Ext3wBWAYOCH+jZdZHl8UO6pYN7WJT8I=;
        b=NTzB0LbvGCrHUP5i9rGxsX5n5122OaE9LbAWAvM+3TaH6Qgu+xVhLodJJo1Wq4XB3W
         vPHI0eWhvnX/7dR/FakKkzhc04ubWD9pQuHnCFTrkWYZK2VONvEnrtDpkZWXF4ijV4Gy
         N6aDGWbpQK3WrVCZPUvwKUaQYk9Ar6es6XGAdiM8k9QipuTbd20V4B/WbyLiE+d1uoo8
         UF9VhwVn0LR170fI1q6Fxye4vFpbLsM2P2wCag88aCc1UXdSfCG+8oYULHpLVbb35TmI
         bJgHErcP7806ul6dKO+41kvXyv0fEK0mIh+s9Q9XDYPOF85+sHepEclUDABH/CqS761o
         7d0A==
X-Gm-Message-State: AO0yUKWTF0m1XjW0rTUjhCZWFCIWwwoIN5nsW+ONnPPLs3FHwUsXE3QH
        yIT4vkVJzxu5CUBkJWbvEdnGY/b9StRSa482qzM=
X-Google-Smtp-Source: AK7set92RmN8SPCH617qs+NMfTlQiZCr9lRUe9wqeFgyytkozvvrmAwr2yPqncOcU0zT0Xn/m6VwPgG7Sm2woS/HXLI=
X-Received: by 2002:a17:907:1dda:b0:8b0:fbd5:2145 with SMTP id
 og26-20020a1709071dda00b008b0fbd52145mr9897010ejc.15.1677197920693; Thu, 23
 Feb 2023 16:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20230217191908.1000004-1-deso@posteo.net> <20230217191908.1000004-4-deso@posteo.net>
 <CAEf4BzasONdYA6JPvF=pAjBW9hotVw34itVG3AoGRJV5pjERBA@mail.gmail.com> <20230221213655.zu7zl77damfzxeat@muellerd-fedora-PC2BDTX9>
In-Reply-To: <20230221213655.zu7zl77damfzxeat@muellerd-fedora-PC2BDTX9>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Feb 2023 16:18:28 -0800
Message-ID: <CAEf4BzbwoAtQO6BWm1tBe51VE_BvS+mfVdcjC+uzi5s4A=L4-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Add support for attaching uprobes to
 shared objects in APKs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 21, 2023 at 1:37 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Fri, Feb 17, 2023 at 04:32:05PM -0800, Andrii Nakryiko wrote:
> > On Fri, Feb 17, 2023 at 11:19 AM Daniel M=C3=BCller <deso@posteo.net> w=
rote:
> > >
> > > This change adds support for attaching uprobes to shared objects loca=
ted
> > > in APKs, which is relevant for Android systems where various librarie=
s
> >
> > Is there a good link with description of APK that we can record
> > somewhere in the comments for future us?
>
> Perhaps
> https://en.wikipedia.org/w/index.php?title=3DApk_(file_format)&oldid=3D11=
39099120#Package_contents.
>
> Will add it.
>
> > Also, does .apk contains only shared libraries, or it could be also
> > just a binary?
>
> It probably could also be for a binary, judging from applications being
> available for download in the form of APKs.
>
> > > may reside in APKs. To make that happen, we extend the syntax for the
> > > "binary path" argument to attach to with that supported by various
> > > Android tools:
> > >   <archive>!/<binary-in-archive>
> > >
> > > For example:
> > >   /system/app/test-app/test-app.apk!/lib/arm64-v8a/libc++_shared.so
> > >
> > > APKs need to be specified via full path, i.e., we do not attempt to
> > > resolve mere file names by searching system directories.
> >
> > mere?
>
> Yes?

I'm just confused what "resolve mere file names" means in this
context. Like, which file names are not "mere"?

>
> > >
> > > We cannot currently test this functionality end-to-end in an automate=
d
> > > fashion, because it relies on an Android system being present, but th=
ere
> > > is no support for that in CI. I have tested the functionality manuall=
y,
> > > by creating a libbpf program containing a uretprobe, attaching it to =
a
> > > function inside a shared object inside an APK, and verifying the sani=
ty
> > > of the returned values.
> > >
> > > Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>
> > > ---
> > >  tools/lib/bpf/libbpf.c | 84 ++++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 80 insertions(+), 4 deletions(-)
> > >

[...]

> > > +               return -LIBBPF_ERRNO__FORMAT;
> > > +       }
> > > +
> > > +       if (zip_archive_find_entry(archive, file_name, &entry)) {
> > > +               pr_warn("zip: could not find archive member %s in %s\=
n", file_name, archive_path);
> > > +               ret =3D -LIBBPF_ERRNO__FORMAT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (entry.compression) {
> > > +               pr_warn("zip: entry %s of %s is compressed and cannot=
 be handled\n", file_name,
> > > +                       archive_path);
> > > +               ret =3D -LIBBPF_ERRNO__FORMAT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       elf =3D elf_memory((void *)entry.data, entry.data_length);
> > > +       if (!elf) {
> > > +               pr_warn("elf: could not read elf file %s from %s: %s\=
n", file_name, archive_path,
> >
> > I kind of like preserving the "archive/path!/file/path" consistently
> > through error messages when referring to file within APK, WDYT?
>
> It seems valuable to me to make it clear that we "parsed" the string corr=
ectly
> and split it into the expected parts.

it's debatable, if the user doesn't trust libbpf to handle
"archive/path!/file/path" spec correctly, then it's too bad. My point
here is to keep it consistent with the way that user is specifying it
in SEC("") definition

>
> > > +                       elf_errmsg(-1));
> > > +               ret =3D -LIBBPF_ERRNO__FORMAT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       ret =3D elf_find_func_offset(elf, file_name, func_name);
> > > +       if (ret > 0) {
> > > +               ret +=3D entry.data_offset;
> > > +               pr_debug("elf: symbol address match for '%s' in '%s':=
 0x%lx\n", func_name,
> > > +                        archive_path, ret);
> >
> > so for debugging I feel like we'll want to know both entry.data_offset
> > and original ELF offset, let's report all three offset (including the
> > final calculated one)?
>
> I added one more pr_debug() printing the entry offset. The ELF offset is
> reported by elf_find_func_offset() and the final offset here.

sure, but here we can have all of that conveniently in a single
(debug) log message, so why not?

>
> > > +       }
> > > +       elf_end(elf);
> > > +
> > > +out:
> > > +       zip_archive_close(archive);
> > > +       return ret;
> > > +}
> > > +
> > >  static const char *arch_specific_lib_paths(void)
> > >  {
> > >         /*
> > > @@ -10789,6 +10844,9 @@ bpf_program__attach_uprobe_opts(const struct =
bpf_program *prog, pid_t pid,
> > >  {
> > >         DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
> > >         char errmsg[STRERR_BUFSIZE], *legacy_probe =3D NULL;
> > > +       const char *archive_path =3D NULL;
> > > +       const char *archive_sep =3D NULL;
> >
> > nit: combine on a single line?
> >
> > > +       char full_archive_path[PATH_MAX];
> > >         char full_binary_path[PATH_MAX];
> > >         struct bpf_link *link;
> > >         size_t ref_ctr_off;
> > > @@ -10806,9 +10864,21 @@ bpf_program__attach_uprobe_opts(const struct=
 bpf_program *prog, pid_t pid,
> > >         if (!binary_path)
> > >                 return libbpf_err_ptr(-EINVAL);
> > >
> > > -       if (!strchr(binary_path, '/')) {
> > > -               err =3D resolve_full_path(binary_path, full_binary_pa=
th,
> > > -                                       sizeof(full_binary_path));
> > > +       /* Check if "binary_path" refers to an archive. */
> > > +       archive_sep =3D strstr(binary_path, "!/");
> > > +       if (archive_sep) {
> > > +               if (archive_sep - binary_path >=3D sizeof(full_archiv=
e_path)) {
> >
> > very unlikely to happen, I wouldn't bother checking, especially that
> > strncpy will just truncate and make us fail anyways
>
> How will it "make us fail"? It will silently truncate the path, no?

right, it will be invalid path. But we don't expect this, because we
allocated PATH_MAX, so it's only if user goes crazy and makes up some
huge invalid path, which never was going to succeed anyways. So I'd
drop this check altogether.

>
> > > +                       return libbpf_err_ptr(-EINVAL);
> > > +               }
> > > +
> > > +               strncpy(full_archive_path, binary_path, archive_sep -=
 binary_path);
> >
> > let's use saner libbpf_strlcpy() instead of strncpy, we stopped using
> > strncpy relatively recently
>
> Okay.
>

[...]
