Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B13A7E3E
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhFOMgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhFOMga (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 08:36:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB4C061574
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 05:34:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i34so11297341pgl.9
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfFlHKJITuq7m+jRiQdNWWro2JXr4O8Tyzgo1BmbNJI=;
        b=L7cRujILruevBnL1v/m9WoOJSjbJMk5RLal3bWFxNGmGy4B6QaP2T02KaNHLXusGnG
         6IKDMbJ3oT61qNVw9aH+5GZfuIU5iKo9iu9CB4xFthSEt8J2ZOh7tPIfthMCWgqHohtH
         OmCnRPHv4vTLim0fMViF8taY1Er40s4kvngQ+bs8z+aJ59y9vSv/xa8/T3tuvtxemenT
         Jpq35432aBHZaSKphxy3DQb6Rkzb3u/hJAZ3uwwTARO1zs5SpGsa/VFDNCviXIpva93c
         FsrN2i6Qtol9HyASPSUkKJuGz/8iqkgZQZ4v5n26XoiErdn3RlJKScQo13YIP9YFHnZj
         gM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfFlHKJITuq7m+jRiQdNWWro2JXr4O8Tyzgo1BmbNJI=;
        b=GBS5YK8HM/FGkUkg24eIxNMikitshQLXqXbfdD8bAoj7m3i/Zn7yVnnOY6FxjQZTi0
         uc4A3DiNchgY5W7+PT1HRt+pHl4LcJVYMUEXGawaZANDDpB7dsOI5hGocED2yx3/6SE6
         b+2adi+sbj3VyCZ6NbTxk8dkGElo9l959IJ+F/jncfJK0jplQ9n3Jzr3c9gpOPWalksn
         sozJ1bt8tNyJHK7G6Zn7bUDAOF1O9VasgLDiUYiF+N0YOgB6qi8ZEgFOVAfHOYDMYanH
         Uv6/MwH1l6Z4h+q87XVUlJh1uYR0JmAH/YSMqkJcmu1Ap35jD1bKlsJjfs+g2HVZwhez
         ONVw==
X-Gm-Message-State: AOAM532smFb1lETUuSzA1p6WNrC8kB46IVEsLbxERwo2yB47d73VPBLl
        l9rZycAkInYR/iuEN2G5z1nl39g9tOR3B5O3VIM=
X-Google-Smtp-Source: ABdhPJw1hkvFJhNneHt44JyU3TeIQZsOdP37x1xRtKi0lxKyO/WVYaVFilN7oDGxrD5yLzjKoiazTt+tKRidNU6G9Rk=
X-Received: by 2002:aa7:8dd8:0:b029:2f8:5408:77f2 with SMTP id
 j24-20020aa78dd80000b02902f8540877f2mr4178854pfr.22.1623760463815; Tue, 15
 Jun 2021 05:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
 <CAEf4BzZkK9X2RadSYUWV5oh960iwaw3y5EKr7zu8WZ7XnRYz6g@mail.gmail.com>
 <CAHn8xc==x92fXpOM42-FJ_ondhGPdMOrTmgYr3K=w8WvZqXEVQ@mail.gmail.com> <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
In-Reply-To: <CACYkzJ59tvKKxaG9S+QLVbC=4szbFjouDUDaaTCNUytQBT7nSg@mail.gmail.com>
From:   "Geyslan G. Bem" <geyslan@gmail.com>
Date:   Tue, 15 Jun 2021 09:32:33 -0300
Message-ID: <CAGG-pUQTTBtqJgMo07bFdJS-nKBZDi9UzSYVQ200tsKP6iuTVQ@mail.gmail.com>
Subject: Re: kernel bpf test_progs - vm wrong libc version
To:     KP Singh <kpsingh@kernel.org>
Cc:     Jussi Maki <joamaki@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 06:58, KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 10:06 AM Jussi Maki <joamaki@gmail.com> wrote:
> >
> > On Tue, Jun 15, 2021 at 8:28 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > It seems kind of silly to update our perfectly working image just
> > > because a new version of glibc was released. Is there any way for you
> > > to down-grade glibc or build it in some compatibility mode, etc?
> > > selftests don't really rely on any bleeding-edge features of glibc.
> >
> > I've also hit this issue as Ubuntu 21.04 ships with glibc 2.33. I
> > ended up solving it the hard way by rebuilding the image (I needed few
> > other tools at the time anyway). Definitely agree it's a bit silly if
> > we'd need to bump the image every time there's a new glibc version out
> > there. I did try and see if there's a way to build against newer
> > glibc, but target older versions and I didn't find a way to do that.
> > Would statically linking test-progs be an option to avoid this kind of
> > breakage in the future?
>
> I think static linking tests_progs is the only real way one can solve this.
> Even if we keep updating the image, there will still be users that will hit
> glibc version issues.

I agree once the image remains static.

>
> Andrii, Maybe we can have a mode for vmtest.sh can build test_progs
> statically?
>
> maybe something like:

These changes generates the output:

  BINARY   test_maps
/usr/bin/ld: cannot find -lcap
collect2: error: ld returned 1 exit status
make: *** [Makefile:492:
/home/uzu/code/bpf-next/tools/testing/selftests/bpf/test_maps] Error 1

libcap and acl are installed

$ ld --version
GNU ld (GNU Binutils) 2.36.1

$ ld.lld --version
LLD 13.0.0 (/home/uzu/.cache/yay/llvm-git/llvm-project
ad381e39a52604ba07e1e027e7bdec1c287d9089) (compatible with GNU
linkers)

>
> git diff
> diff --git a/tools/testing/selftests/bpf/Makefile
> b/tools/testing/selftests/bpf/Makefile
> index f405b20c1e6c..5ab0b7e6a95d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -450,7 +450,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)
>                  \
>                              $(RESOLVE_BTFIDS)                          \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a
> %.o,$$^) $$(LDLIBS) -o $$@
>         $(Q)$(RESOLVE_BTFIDS) --no-fail --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
>
>  endef
> diff --git a/tools/testing/selftests/bpf/vmtest.sh
> b/tools/testing/selftests/bpf/vmtest.sh
> index 8889b3f55236..331072074014 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -138,7 +138,7 @@ update_selftests()
>         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
>
>         cd "${selftests_dir}"
> -       ${make_command}
> +       TRUNNER_LDFLAGS=-static ${make_command}
>
>         # Mount the image and copy the selftests to the image.
>         mount_image
>
> file test_progs
> test_progs: ELF 64-bit LSB executable, x86-64, version 1 (GNU/Linux),
> statically linked,
> BuildID[sha1]=b1915565b344c412f3eaa07eef4bfdd4a0fc672e, for GNU/Linux
> 3.2.0, with debug_info, not stripped
>
> I tried with simply doing LDFLAGS=-static but that breaks other binaries:

Earlier I tried just that too. Same results.

>
> /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/10/crtbeginT.o: relocation
> R_X86_64_32 against hidden symbol `__TMC_END__' can not be used when
> making a shared object
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile:167:
> /home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.so.0.5.0]
> Error 1
> make[1]: *** [Makefile:135: all] Error 2
> make: *** [Makefile:228:
> /home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a]
> Error 2
> make: *** Deleting file
> '/home/kpsingh/projects/krsi/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a'
>
> Let me know if this works for you.
>
>
>
>
> -



-- 
Regards,

Geyslan G. Bem
