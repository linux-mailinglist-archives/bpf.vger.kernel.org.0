Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCA644BF8
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLFSn1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 13:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFSn0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 13:43:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349B1055E;
        Tue,  6 Dec 2022 10:43:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z92so21630089ede.1;
        Tue, 06 Dec 2022 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2snLCws/RM2eA60PzTbMvOMr3J4g1WQ3UMeSotnN7Y=;
        b=nM+iw6Q34Bd3S6n2XkSjDGQ8b8uitiND1x+c1yKER/P71FYlZSNCaefkYKdMmNKcEr
         +M5YvmgQ6ULfj09UB+KuJ0STQA8cUIuQ/ZpUQhatQg89W48tFGWVkpZivYa5pQ3gzfs+
         fp/zGDHiXK6cNKiZY/pv5VOpxrG+nDOggHenwS/z9guAT8D84fVsqsEgf3XC9qkXb/tx
         KfpABc0wxsK/sSMiKynAZcRwOW8ohFIdWP/8npOpy6UQzp7LPmQ1U0kCvSkOMMnEDh2L
         zQ38UPIO4z1Pp8mg3F/AhVf+UsbBlK5A8D+I2FKpqfc/r1Tl/jdR2/Yc0vyrzkgX2ON8
         T5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2snLCws/RM2eA60PzTbMvOMr3J4g1WQ3UMeSotnN7Y=;
        b=mioF0GSk39va+oV0KWyXO3U3KZbztTqKzRBReXlGUvU5FkgZEhv1Pwy7GbLjHYmTiz
         3j3b3WvrpJUDx/1DQqLJOzKrFKUQ0H3vNpS5CofAiFWYE6cWRTnH5/jiQr3B+w3yTGxt
         h3zron7IRH+nnbXkxgqZf9MO1TBCK8mZDjPyrlBfW0IpFBQwI0P6NfmgE9IYCQEhcwDl
         HZ7SeBUk2skxZXfTiiauEUnvwlI+fuZrvBLqhOI5NjMtUjYR/AkU9zjQ73Xsb0hP0b63
         hjWLPhVgPpOgNp2wiEys3AxKMrOsSDctEgxVwNVUkyoEc2H/cPjz3alaAFYIwFhi0hsH
         6q2A==
X-Gm-Message-State: ANoB5pmArzVDlvLC81OCzNuJi/ZabfIgdtEFQezX7FHwFAdIg4KPvFMz
        y/hapXZ2FAqnAdHVpEXhYsuPvdCML47iQkQ7yQLuwKF+
X-Google-Smtp-Source: AA0mqf7ZMqY67M8joLjVSaFw2s13DvbrSyQupNsHCC6tpN30pG25aOlc4UIFceTx83evY6fZnW7R3WwCQ6xXUhc2LWk=
X-Received: by 2002:a05:6402:124a:b0:46b:8e9e:876 with SMTP id
 l10-20020a056402124a00b0046b8e9e0876mr28281423edw.232.1670352202836; Tue, 06
 Dec 2022 10:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com> <20221122000011.241697-2-morbo@google.com>
 <CAEf4BzYiHx0gAgJsam4usy23UTGwN-a-nyJa2+jzG+RzUFiWEQ@mail.gmail.com>
 <CAGG=3QWGAepDQmSxarrMENOX79srigF48xYOsOjOPO-YuvFr1g@mail.gmail.com>
 <CAEf4Bzb38BXEL_mKuqRdUrvQVTXLH9TmOdwZbrVa_10YmdhoTw@mail.gmail.com>
 <CAGG=3QVC_qOFWRi4sf88Ct3Tz5_N6j_GUwj+Dk11Oi9AJYNm-A@mail.gmail.com> <CAEf4BzYs4h0ya7MbQ9P96293XkyW4ab3f+nYeJU6D=LFsrm6-w@mail.gmail.com>
In-Reply-To: <CAEf4BzYs4h0ya7MbQ9P96293XkyW4ab3f+nYeJU6D=LFsrm6-w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 10:43:10 -0800
Message-ID: <CAEf4BzZFw04LdgpyNocnnr9h2uTdQW+RCcFBaFJ7hgqRriL=fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
To:     Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cc bpf@vger as this isn't strictly pahole issue

On Tue, Dec 6, 2022 at 10:38 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 1, 2022 at 12:20 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Thu, Dec 1, 2022 at 11:56 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Nov 30, 2022 at 4:21 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Wed, Nov 30, 2022 at 2:59 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > On Mon, Nov 21, 2022 at 4:00 PM Bill Wendling <morbo@google.com> wrote:
> > > > > >
> > > > > > LLD generates a zero-length .BTF section (BFD doesn't generate this
> > > > > > section). It shares the same address as .BTF_ids (or any section below
> > > > > > it). E.g.:
> > > > > >
> > > > > >   [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > > > > >   [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634
> > > > > >
> > > > > > Writing new data to that section doesn't adjust the addresses of
> > > > > > following sections. As a result, the "-J" flag produces a corrupted
> > > > > > file, causing further commands to fail.
> > > > > >
> > > > > > Instead of trying to adjust everything, just add a new section with the
> > > > > > .BTF data and adjust the name of the original .BTF section. (We can't
> > > > > > remove the old .BTF section because it has variables that are referenced
> > > > > > elsewhere.)
> > > > > >
> > > > >
> > > > > Have you tried llvm-objcopy --update-section instead? Doesn't it work?
> > > > >
> > > > I gave it a quick try and it fails for me with this:
> > > >
> > > > llvm-objcopy: error: '.tmp_vmlinux.btf': cannot fit data of size
> > > > 4470718 into section '.BTF' with size 0 that is part of a segment
> > >
> > > .BTF shouldn't be allocatable section, when added by pahole. I think
> > > this is the problem. Can you confirm that that zero-sized .BTF is
> > > marked as allocated and is put into one of ELF segments? Can we fix
> > > that instead?
> > >
> > I think it does:
> >
> > [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
> > 00  WA  0   0  1
> >
>
> So this allocatable .BTF section, could it be because of linker script
> in include/asm-generic/vmlinux.lds.h? Should we add some conditions
> there to not emit .BTF if __startt_BTF == __stop_BTF (i.e., no BTF
> data is present) to avoid this issue in the first place?
>
> > Fangrui mentioned something similar to this in a previous message:
> >
> >   https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/T/#u
> >
> > > Also, more generally, newer paholes (not that new anymore, it's been a
> > > supported feature for a while) support emitting BTF as raw binary
> > > files, instead of embedding them into ELF. I think this is a nicer and
> > > simpler option and we should switch link-vmlinux.sh to use that
> > > instead, if pahole is new enough.
> > >
> > > Hopefully eventually we can get rid of all the old pahole version
> > > cruft, but for now it's inevitable to support both modes, of course.
> > >
> >
> > Ah technical debt! :-)
>
> Yep, it would be good to get contributions to address it ;) It's
> better than hacks with renaming of sections, *wink wink* :)
>
> >
> > -bw
> >
> > > > btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux.btf': 2!
> > > > Failed to encode BTF
> > > >
> > > > -bw
> > > >
> > > > > > Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
> > > > > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > > > Cc: Fangrui Song <maskray@google.com>
> > > > > > Cc: dwarves@vger.kernel.org
> > > > > > Signed-off-by: Bill Wendling <morbo@google.com>
> > > > > > ---
> > > > > >  btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
> > > > > >  1 file changed, 54 insertions(+), 34 deletions(-)
> > > > > >
> > > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > > index a5fa04a84ee2..bd1ce63e992c 100644
> > > > > > --- a/btf_encoder.c
> > > > > > +++ b/btf_encoder.c
> > > > > > @@ -1039,6 +1039,9 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >         Elf_Data *btf_data = NULL;
> > > > > >         Elf_Scn *scn = NULL;
> > > > > >         Elf *elf = NULL;
> > > > > > +       const char *llvm_objcopy;
> > > > > > +       char tmp_fn[PATH_MAX];
> > > > > > +       char cmd[PATH_MAX * 2];
> > > > > >         const void *raw_btf_data;
> > > > > >         uint32_t raw_btf_size;
> > > > > >         int fd, err = -1;
> > > > > > @@ -1081,42 +1084,58 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >
> > > > > >         raw_btf_data = btf__raw_data(btf, &raw_btf_size);
> > > > > >
> > > > > > +       llvm_objcopy = getenv("LLVM_OBJCOPY");
> > > > > > +       if (!llvm_objcopy)
> > > > > > +               llvm_objcopy = "llvm-objcopy";
> > > > > > +
> > > > > > +       /* Use objcopy to add a .BTF section */
> > > > > > +       snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > > > > > +       close(fd);
> > > > > > +       fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > > > > > +       if (fd == -1) {
> > > > > > +               fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > > > > > +                       tmp_fn);
> > > > > > +               goto out;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > > > > > +               fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > > > > > +                       __func__, raw_btf_size, tmp_fn, errno);
> > > > > > +               goto unlink;
> > > > > > +       }
> > > > > > +
> > > > > >         if (btf_data) {
> > > > > > -               /* Existing .BTF section found */
> > > > > > -               btf_data->d_buf = (void *)raw_btf_data;
> > > > > > -               btf_data->d_size = raw_btf_size;
> > > > > > -               elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> > > > > > -
> > > > > > -               if (elf_update(elf, ELF_C_NULL) >= 0 &&
> > > > > > -                   elf_update(elf, ELF_C_WRITE) >= 0)
> > > > > > -                       err = 0;
> > > > > > -               else
> > > > > > -                       elf_error("elf_update failed");
> > > > > > -       } else {
> > > > > > -               const char *llvm_objcopy;
> > > > > > -               char tmp_fn[PATH_MAX];
> > > > > > -               char cmd[PATH_MAX * 2];
> > > > > > -
> > > > > > -               llvm_objcopy = getenv("LLVM_OBJCOPY");
> > > > > > -               if (!llvm_objcopy)
> > > > > > -                       llvm_objcopy = "llvm-objcopy";
> > > > > > -
> > > > > > -               /* Use objcopy to add a .BTF section */
> > > > > > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
> > > > > > -               close(fd);
> > > > > > -               fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
> > > > > > -               if (fd == -1) {
> > > > > > -                       fprintf(stderr, "%s: open(%s) failed!\n", __func__,
> > > > > > -                               tmp_fn);
> > > > > > -                       goto out;
> > > > > > -               }
> > > > > > -
> > > > > > -               if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
> > > > > > -                       fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
> > > > > > -                               __func__, raw_btf_size, tmp_fn, errno);
> > > > > > +               /*
> > > > > > +                * Existing .BTF section found. LLD creates a zero-sized .BTF
> > > > > > +                * section. Adding data to that section doesn't change the
> > > > > > +                * addresses of the other sections, causing an overwriting of
> > > > > > +                * data. These commands are a bit convoluted, but they will add
> > > > > > +                * a new .BTF section with the proper size. Note though that
> > > > > > +                * the __start_btf and __stop_btf variables aren't affected by
> > > > > > +                * this change, but then they aren't added when using
> > > > > > +                * "--add-section" either.
> > > > > > +                */
> > > > > > +               snprintf(cmd, sizeof(cmd),
> > > > > > +                        "%s --add-section .BTF.new=%s "
> > > > > > +                        "--rename-section .BTF=.BTF.old %s",
> > > > > > +                        llvm_objcopy, tmp_fn, filename);
> > > > > > +               if (system(cmd)) {
> > > > > > +                       fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> > > > > > +                               __func__, filename, errno);
> > > > > >                         goto unlink;
> > > > > >                 }
> > > > > >
> > > > > > +               snprintf(cmd, sizeof(cmd),
> > > > > > +                        "%s --rename-section .BTF.new=.BTF %s",
> > > > > > +                        llvm_objcopy, filename);
> > > > > > +               if (system(cmd)) {
> > > > > > +                       fprintf(stderr, "%s: failed to rename .BTF section to '%s': %d!\n",
> > > > > > +                               __func__, filename, errno);
> > > > > > +                       goto unlink;
> > > > > > +               }
> > > > > > +
> > > > > > +               err = 0;
> > > > > > +       } else {
> > > > > >                 snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
> > > > > >                          llvm_objcopy, tmp_fn, filename);
> > > > > >                 if (system(cmd)) {
> > > > > > @@ -1126,10 +1145,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
> > > > > >                 }
> > > > > >
> > > > > >                 err = 0;
> > > > > > -       unlink:
> > > > > > -               unlink(tmp_fn);
> > > > > >         }
> > > > > >
> > > > > > +unlink:
> > > > > > +       unlink(tmp_fn);
> > > > > > +
> > > > > >  out:
> > > > > >         if (fd != -1)
> > > > > >                 close(fd);
> > > > > > --
> > > > > > 2.38.1.584.g0f3c55d4c2-goog
> > > > > >
