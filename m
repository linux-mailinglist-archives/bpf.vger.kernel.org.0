Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40468683997
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjAaWup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 17:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjAaWuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 17:50:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0FD4A230
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 14:50:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg26so5577923wmb.0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 14:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0LDbERO12laLmPDWTi8+TGflh7aG4vAdRmgw8+IF1Q=;
        b=jlnWnt7nSMwLcUXQIhXN2JEVq6iNDvdZivkhZrKhvuL2zuEqI+h3WB7BXQ28OQhb/C
         AURJ0HL3jIWx/O+QzijM8jTN5IYhVZJBURl0EhogFM5yVaMxpj0sCwW9UrzTmj5ABYe7
         S2Ok1UIKDjdLSmMkWz0BD12N0bOyDVMlN/5r2AZSLPue3wrQQwD5qUUNyw9eFMiNPZhG
         YF1dcVf3EIbvyQeKHTpQnUzTdVGkvBEKD3pZMVIzKVAYDVv6k/jC3BHntfQ5HHKSrytl
         IE4FnQXfJUsA0/rt+KtW5rnjP7SQR2BYeI+6EbhePhKRCMO0npsyQADS7Xem0dezaiBw
         UbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0LDbERO12laLmPDWTi8+TGflh7aG4vAdRmgw8+IF1Q=;
        b=UeqOCgsrjZhFWEC6WRMwXWGmcu1bcLKoS3uY3RN17zCXvngH4CuMb+JXfgBr61tQDO
         HnwzGqQWRanB1NNpB8d18oGurfqLhRR/JGhVs9UQuguCpZycMj8h1hE9lBKmUvO0L8kN
         pNgEmRowxeA1Yov+BMfWLKF5f2uVyhAizpYBafaYLLTOMaAiTHtaf+51w1hRoZ3PaXaJ
         TGp50mZS+bvc02/tqO/7pN5S8wK1FnsSAHIv3vuoOHWUHe6PcAs7YLAFJuDUG76dExub
         tGTEjxu/yxeuqN+FwZfXqeRb5nAGHb7yLFUSztxpX/2wfFV7YUVdCGZ6PF2201wWno7R
         WhkQ==
X-Gm-Message-State: AFqh2krLYw1Z8rZA1LT1IPECvfAGWdOxgo2NSTvO8MME1eB2JGqg5e1v
        jrEj7Rea/ThsxIxH1fhA8W/zGJWRVnF1AbNOfXV72g==
X-Google-Smtp-Source: AMrXdXsILaDRFMCzV7v+w7tHyqSBq005Ff7hC4ApPZB8W6if6HOnW0wrkCggvzAbdIwKg065Q+wT0Ly5b6YI6PpIel4=
X-Received: by 2002:a05:600c:6020:b0:3da:1bb6:ed44 with SMTP id
 az32-20020a05600c602000b003da1bb6ed44mr3915205wmb.149.1675205439446; Tue, 31
 Jan 2023 14:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20230124064324.672022-1-irogers@google.com> <20230124064324.672022-2-irogers@google.com>
 <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X> <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
 <CAP-5=fWJzTOYj167maEP8=k=iWQJcrF-zOdbkTAUw94qrVOL5g@mail.gmail.com>
 <Y9ls+nWTwE5we5ah@dev-arch.thelio-3990X> <CAP-5=fWbd2gNhWXkffQQmVrLY6dzHxH68zumNwp4_a0b83D7qg@mail.gmail.com>
 <Y9mFVNEi5wAINARY@dev-arch.thelio-3990X> <Y9mY5woe+45nTvTM@krava>
In-Reply-To: <Y9mY5woe+45nTvTM@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 Jan 2023 14:50:27 -0800
Message-ID: <CAP-5=fVDE6a+1rxOFhFjheg3ybUMRxE51NPW=kKLc=O98TQHHA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 2:40 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 02:17:08PM -0700, Nathan Chancellor wrote:
> > On Tue, Jan 31, 2023 at 12:59:04PM -0800, Ian Rogers wrote:
> > > On Tue, Jan 31, 2023 at 11:33 AM Nathan Chancellor <nathan@kernel.org=
> wrote:
> > > >
> > > > On Tue, Jan 31, 2023 at 11:25:38AM -0800, Ian Rogers wrote:
> > > > > On Tue, Jan 31, 2023 at 10:08 AM Ian Rogers <irogers@google.com> =
wrote:
> > > > > >
> > > > > > On Tue, Jan 31, 2023 at 9:21 AM Nathan Chancellor <nathan@kerne=
l.org> wrote:
> > > > > > >
> > > > > > > Hi Ian,
> > > > > > >
> > > > > > > On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> > > > > > > > HOSTCC is always wanted when building. Setting CC to HOSTCC=
 happens
> > > > > > > > after tools/scripts/Makefile.include is included, meaning f=
lags are
> > > > > > > > set assuming say CC is gcc, but then it can be later set to=
 HOSTCC
> > > > > > > > which may be clang. tools/scripts/Makefile.include is neede=
d for host
> > > > > > > > set up and common macros in objtool's Makefile. Rather than=
 override
> > > > > > > > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the=
 libsubcmd
> > > > > > > > builds and the linkage step. This means the Makefiles don't=
 see things
> > > > > > > > like CC changing and tool flag determination, and similar, =
work
> > > > > > > > properly.
> > > > > > > >
> > > > > > > > Also, clear the passed subdir as otherwise an outer build m=
ay break by
> > > > > > > > inadvertently passing an inappropriate value.
> > > > > > > >
> > > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > > > ---
> > > > > > > >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> > > > > > > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/=
resolve_btfids/Makefile
> > > > > > > > index 1fe0082b2ecc..daed388aa5d7 100644
> > > > > > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > > > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > > > > > @@ -18,14 +18,11 @@ else
> > > > > > > >  endif
> > > > > > > >
> > > > > > > >  # always use the host compiler
> > > > > > > > -AR       =3D $(HOSTAR)
> > > > > > > > -CC       =3D $(HOSTCC)
> > > > > > > > -LD       =3D $(HOSTLD)
> > > > > > > > -ARCH     =3D $(HOSTARCH)
> > > > > > > > +HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=
=3D"$(HOSTLD)" ARCH=3D"$(HOSTARCH)" \
> > > > > > > > +               EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOST=
CFLAGS)"
> > > > > > > > +
> > > > > > > >  RM      ?=3D rm
> > > > > > > >  CROSS_COMPILE =3D
> > > > > > > > -CFLAGS  :=3D $(KBUILD_HOSTCFLAGS)
> > > > > > > > -LDFLAGS :=3D $(KBUILD_HOSTLDFLAGS)
> > > > > > > >
> > > > > > > >  OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> > > > > > > >
> > > > > > > > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_=
OUT):
> > > > > > > >
> > > > > > > >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > > > > > > >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=3D$(SUBCMD_OUT) \
> > > > > > > > -                 DESTDIR=3D$(SUBCMD_DESTDIR) prefix=3D \
> > > > > > > > +                 DESTDIR=3D$(SUBCMD_DESTDIR) $(HOST_OVERRI=
DES) prefix=3D subdir=3D \
> > > > > > > >                   $(abspath $@) install_headers
> > > > > > > >
> > > > > > > >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/M=
akefile) | $(LIBBPF_OUT)
> > > > > > > >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=
=3D$(LIBBPF_OUT)    \
> > > > > > > > -                 DESTDIR=3D$(LIBBPF_DESTDIR) prefix=3D EXT=
RA_CFLAGS=3D"$(CFLAGS)" \
> > > > > > > > +                 DESTDIR=3D$(LIBBPF_DESTDIR) $(HOST_OVERRI=
DES) prefix=3D subdir=3D \
> > > > > > > >                   $(abspath $@) install_headers
> > > > > > > >
> > > > > > > >  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflag=
s 2>/dev/null)
> > > > > > > > @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
> > > > > > > >  include $(srctree)/tools/build/Makefile.include
> > > > > > > >
> > > > > > > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > > > > > > -     $(Q)$(MAKE) $(build)=3Dresolve_btfids
> > > > > > > > +     $(Q)$(MAKE) $(build)=3Dresolve_btfids $(HOST_OVERRIDE=
S)
> > > > > > > >
> > > > > > > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > > > > > > >       $(call msg,LINK,$@)
> > > > > > > > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(S=
UBCMDOBJ) $(LIBS)
> > > > > > > > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $=
@ $(BPFOBJ) $(SUBCMDOBJ) $(LIBS)
> > > > > > > >
> > > > > > > >  clean_objects :=3D $(wildcard $(OUTPUT)/*.o               =
 \
> > > > > > > >                              $(OUTPUT)/.*.o.cmd           \
> > > > > > > > --
> > > > > > > > 2.39.0.246.g2a6d74b583-goog
> > > > > > > >
> > > > > > >
> > > > > > > I just bisected a linking failure when building resolve_btfid=
s with
> > > > > > > clang to this change as commit 13e07691a16f ("tools/resolve_b=
tfids:
> > > > > > > Alter how HOSTCC is forced") in the bpf-next tree.
> > > > > > >
> > > > > > > It appears to be related to whether or not CROSS_COMPILE is s=
pecified,
> > > > > > > which we have to do for certain architectures and configurati=
ons still.
> > > > > > > arm64 is not one of those but it helps demonstrate the issue.
> > > > > > >
> > > > > > >   # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEB=
UG_INFO_BTF
> > > > > > >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-=
linux-gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 defconfig menuconfig
> > > > > > >
> > > > > > >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-=
linux-gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 prepare
> > > > > > >   ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve=
_btfids-in.o is incompatible with elf64-x86-64
> > > > > > >   clang-17: error: linker command failed with exit code 1 (us=
e -v to see invocation)
> > > > > > >   ...
> > > > > > >
> > > > > > > Before your change, with V=3D1, I see:
> > > > > > >
> > > > > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -=
Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototype=
s -Wstrict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11 -Wdeclaration-a=
fter-statement -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uap=
i -I$LINUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/b=
pf/resolve_btfids/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/=
tools/bpf/resolve_btfids/main.o main.c
> > > > > > >
> > > > > > > After, I see:
> > > > > > >
> > > > > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -=
Wp,-MT,$LINUX_SRC/tools/bpf/resolve_btfids/main.o --target=3Daarch64-linux-=
gnu -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_=
SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_=
btfids/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/r=
esolve_btfids/main.o main.c
> > > > > > >
> > > > > > > We seem to have taken on a '--target=3Daarch64-linux-gnu' (ch=
anging the
> > > > > > > target of resolve_btfids-in.o) and we dropped the warning fla=
gs.
> > > > > > >
> > > > > > > I think this comes from the clang block in
> > > > > > > tools/scripts/Makefile.include, which is included into the
> > > > > > > resolve_btfids Makefile via tools/lib/bpf/Makefile.
> > > > > > >
> > > > > > > I am not super familiar with the tools build system, otherwis=
e I would
> > > > > > > try to provide a patch. I tried moving CROSS_COMPILE from a r=
ecursive to
> > > > > > > simple variable ('=3D' -> ':=3D') and moving it to HOST_OVERR=
IDES but those
> > > > > > > did not appear to resolve it for me.
> > > > > > >
> > > > > > > If there is any other information I can provide or patches I =
can test,
> > > > > > > please let me know.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > Nathan
> > > > > >
> > > > > > Thanks Nathan, and thanks for all the details in the bug report=
. I'm
> > > > > > looking into this.
> > > > > >
> > > > > > Ian
> > > > >
> > > > > Given the somewhat complicated cross compile I wasn't able to get=
 a
> > > > > reproduction. Could you see if the following addresses the proble=
m:
> > > >
> > > > As long as you have an LLVM toolchain that targets AArch64 and your
> > > > host, you should be able to reproduce this issue with those command=
s
> > > > verbatim, as that command should not use any GNU binutils. I am pre=
tty
> > > > sure I tried it in a fresh container before reporting it but it is
> > > > possible that I did not.
> > >
> > > Thanks, do you have instructions on setting up the container?
> >
> > Sure thing, this worked for me in the Linux source you would like to
> > build (I marked it readonly to make sure any modifications were done in
> > my host environment, remove the ':ro' if you would like to make edits t=
o
> > the source within the container). Docker should work as well but I did
> > not test it.
> >
> > $ podman run --rm -ti -v $PWD:/linux:ro docker.io/archlinux:base-devel
> > # pacman -Syyu --noconfirm bc clang lib32-glibc lld llvm python
> > ...
> >
> > # To turn on CONFIG_DEBUG_INFO_BTF
> > # make -C /linux -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-li=
nux-gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 O=3D/build defconfig menucon=
fig
> >
> > # make -C /linux -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-li=
nux-gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 O=3D/build prepare
> > ld.lld: error: /build/tools/bpf/resolve_btfids//resolve_btfids-in.o is =
incompatible with elf64-x86-64
> > clang-15: error: linker command failed with exit code 1 (use -v to see =
invocation)
> >
> > > > > ```
> > > > > diff --git a/tools/bpf/resolve_btfids/Makefile
> > > > > b/tools/bpf/resolve_btfids/Makefile
> > > > > index daed388aa5d7..a06966841df4 100644
> > > > > --- a/tools/bpf/resolv
> > >
> > > Ian
> > > e_btfids/Makefile
> > > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > > @@ -19,10 +19,9 @@ endif
> > > > >
> > > > > # always use the host compiler
> > > > > HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOS=
TLD)"
> > > > > ARCH=3D"$(HOSTARCH)" \
> > > > > -                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLA=
GS)"
> > > > > +                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLA=
GS)"
> > > > > CROSS_COMPILE=3D""
> > > > >
> > > > > RM      ?=3D rm
> > > > > -CROSS_COMPILE =3D
> > > > >
> > > > > OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> > > > > ```
> > > > >
> > > >
> > > > Unfortunately, it does not. I still see '--target=3D' end up in the
> > > > CFLAGS of those files.
>
> hi,
> I can reproduce that and I think the reason is that the patch removes
> CFLAGS setup
>
>   CFLAGS  :=3D $(KBUILD_HOSTCFLAGS)
>
> so now the 'include ../../scripts/Makefile.include' will set CFLAGS
> with the  --target=3D... and we fail
>
> I can compile with the change below.. we could also set CROSS_COMPILE
> before including tools/scripts/Makefile.include ... not sure which
> on is better
>
> also I need to check if we should keep LDFLAGS setup as well
>
> jirka

Right, but the code shouldn't be doing that - it was the purpose of
the patch to remove it. If you include tools/scripts/Makefile.include,
which is done on line 2, then a bunch of warnings, cflags, etc. are
set based on CC. To then overwrite those values with various HOST
values is at best confusing - CC no longer being CC but HOSTCC, but
other values may or may not have changed. As we build using submakes,
the goal here was to push the problem into the submake which will only
ever see CC and other values being passed in.

So perhaps:
HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"
ARCH=3D"$(HOSTARCH)" \
  EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)" CROSS_COMPILE=3D""

should be:
HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"
ARCH=3D"$(HOSTARCH)" \
  CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)" CROSS_COMPILE=3D""

I'm still trying to get a reproduction.

Thanks,
Ian

>
> ---
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids=
/Makefile
> index daed388aa5d7..875e3fcce7cd 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -64,6 +64,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC=
)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null ||=
 echo -lelf)
>
> +CFLAGS :=3D $(KBUILD_HOSTCFLAGS)
>  CFLAGS +=3D -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>
