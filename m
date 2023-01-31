Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72268382A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 21:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjAaU7Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 15:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjAaU7W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 15:59:22 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7D9EE0
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 12:59:17 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id v5so8006635vkc.10
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWhna/Hba4ISz0fCxKP0EiS7JmjiNyE/gZLSSMBsSUE=;
        b=g/InC7c0ETS6vp4IQnTz2rvHoCh/7UeqaHq/SOo3kcgRJ3e/Z1nto1zis3hrvULPNH
         ZfA+Z6rSJCXkayn/pxbSv7KzU+SF+6DAwA4YL8ClPxEQcT7H+zdNVaR0AI49txe/PZne
         qMDZJABWEMXF9iI72+us2P2P8FM6S/BcADyIfvU1qhvgH54ixUZQcB2cYmS5JF8eAqus
         9BFPw89URcOiqwOlQ8Ue3kgqESOuj+Zvjmz99zj+F37MscryE98eHrrSKep263vu53F0
         JENKlfS3rMmu9Yx/5lqWrnR9TNvaYbEJRwgjSFPwxBszkOvh0hy5/6BZjxofwmTkGYqV
         VOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWhna/Hba4ISz0fCxKP0EiS7JmjiNyE/gZLSSMBsSUE=;
        b=beQUBXASv3Y+aYILgvoDIYxYyhA35UShaYB3uWMU4J8MtbcmytNJP17rPJUX+I9yCH
         2fBmOU07tNsMSi0wOJKnu5A75OJQb7b6nW9nE85BtrdTnx6e5t3m7mTOYyyCmeq/UKBy
         8fr35gKwhCx+P2FFfoZc4I1l/VlFNsZm09+og16r757j8mhFnWzEf3VcRsrhKvMn0CSE
         RaRzyBg15rAZyrWA4XKOGMMzX1drBpu3i+UVKhCif7hxBMoYgr/wOLuylzaNg29F0d3t
         Xs3Lrh5aV+/fsfMmnF4AFSh/944dOk2ZeDhczEGlvUgKSi+VeAjtJcDCDHO4/5zUPvmK
         vDLQ==
X-Gm-Message-State: AO0yUKWTY8w7twYpn1JOdoVjsHCi7hTDrPOGoC3jWeGWQGDx0ubtbt1V
        OwJ3yQYIM6hdFL+mvj0Ofd64QPR4RcX0xK6jp4Nk4g==
X-Google-Smtp-Source: AK7set92dDyn3VfFxJm5tt2dLK7NYKHQrq5tdwF3BAHNwWWT+SQEJyPJGa/cxOzFTnF7DC2APGdmuR1jShGrjTXDw4E=
X-Received: by 2002:a1f:b442:0:b0:3da:bbe7:c9a5 with SMTP id
 d63-20020a1fb442000000b003dabbe7c9a5mr131108vkf.30.1675198755957; Tue, 31 Jan
 2023 12:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20230124064324.672022-1-irogers@google.com> <20230124064324.672022-2-irogers@google.com>
 <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X> <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
 <CAP-5=fWJzTOYj167maEP8=k=iWQJcrF-zOdbkTAUw94qrVOL5g@mail.gmail.com> <Y9ls+nWTwE5we5ah@dev-arch.thelio-3990X>
In-Reply-To: <Y9ls+nWTwE5we5ah@dev-arch.thelio-3990X>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 Jan 2023 12:59:04 -0800
Message-ID: <CAP-5=fWbd2gNhWXkffQQmVrLY6dzHxH68zumNwp4_a0b83D7qg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] tools/resolve_btfids: Alter how HOSTCC is forced
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Connor OBrien <connoro@google.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 11:33 AM Nathan Chancellor <nathan@kernel.org> wrot=
e:
>
> On Tue, Jan 31, 2023 at 11:25:38AM -0800, Ian Rogers wrote:
> > On Tue, Jan 31, 2023 at 10:08 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Jan 31, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org>=
 wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> > > > > HOSTCC is always wanted when building. Setting CC to HOSTCC happe=
ns
> > > > > after tools/scripts/Makefile.include is included, meaning flags a=
re
> > > > > set assuming say CC is gcc, but then it can be later set to HOSTC=
C
> > > > > which may be clang. tools/scripts/Makefile.include is needed for =
host
> > > > > set up and common macros in objtool's Makefile. Rather than overr=
ide
> > > > > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsu=
bcmd
> > > > > builds and the linkage step. This means the Makefiles don't see t=
hings
> > > > > like CC changing and tool flag determination, and similar, work
> > > > > properly.
> > > > >
> > > > > Also, clear the passed subdir as otherwise an outer build may bre=
ak by
> > > > > inadvertently passing an inappropriate value.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> > > > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolv=
e_btfids/Makefile
> > > > > index 1fe0082b2ecc..daed388aa5d7 100644
> > > > > --- a/tools/bpf/resolve_btfids/Makefile
> > > > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > > > @@ -18,14 +18,11 @@ else
> > > > >  endif
> > > > >
> > > > >  # always use the host compiler
> > > > > -AR       =3D $(HOSTAR)
> > > > > -CC       =3D $(HOSTCC)
> > > > > -LD       =3D $(HOSTLD)
> > > > > -ARCH     =3D $(HOSTARCH)
> > > > > +HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HO=
STLD)" ARCH=3D"$(HOSTARCH)" \
> > > > > +               EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS=
)"
> > > > > +
> > > > >  RM      ?=3D rm
> > > > >  CROSS_COMPILE =3D
> > > > > -CFLAGS  :=3D $(KBUILD_HOSTCFLAGS)
> > > > > -LDFLAGS :=3D $(KBUILD_HOSTLDFLAGS)
> > > > >
> > > > >  OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> > > > >
> > > > > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > > > >
> > > > >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > > > >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=3D$(SUBCMD_OUT) \
> > > > > -                 DESTDIR=3D$(SUBCMD_DESTDIR) prefix=3D \
> > > > > +                 DESTDIR=3D$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) p=
refix=3D subdir=3D \
> > > > >                   $(abspath $@) install_headers
> > > > >
> > > > >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefil=
e) | $(LIBBPF_OUT)
> > > > >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=3D$(L=
IBBPF_OUT)    \
> > > > > -                 DESTDIR=3D$(LIBBPF_DESTDIR) prefix=3D EXTRA_CFL=
AGS=3D"$(CFLAGS)" \
> > > > > +                 DESTDIR=3D$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) p=
refix=3D subdir=3D \
> > > > >                   $(abspath $@) install_headers
> > > > >
> > > > >  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/d=
ev/null)
> > > > > @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
> > > > >  include $(srctree)/tools/build/Makefile.include
> > > > >
> > > > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > > > -     $(Q)$(MAKE) $(build)=3Dresolve_btfids
> > > > > +     $(Q)$(MAKE) $(build)=3Dresolve_btfids $(HOST_OVERRIDES)
> > > > >
> > > > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > > > >       $(call msg,LINK,$@)
> > > > > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDO=
BJ) $(LIBS)
> > > > > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BP=
FOBJ) $(SUBCMDOBJ) $(LIBS)
> > > > >
> > > > >  clean_objects :=3D $(wildcard $(OUTPUT)/*.o                \
> > > > >                              $(OUTPUT)/.*.o.cmd           \
> > > > > --
> > > > > 2.39.0.246.g2a6d74b583-goog
> > > > >
> > > >
> > > > I just bisected a linking failure when building resolve_btfids with
> > > > clang to this change as commit 13e07691a16f ("tools/resolve_btfids:
> > > > Alter how HOSTCC is forced") in the bpf-next tree.
> > > >
> > > > It appears to be related to whether or not CROSS_COMPILE is specifi=
ed,
> > > > which we have to do for certain architectures and configurations st=
ill.
> > > > arm64 is not one of those but it helps demonstrate the issue.
> > > >
> > > >   # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEBUG_INF=
O_BTF
> > > >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-=
gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 defconfig menuconfig
> > > >
> > > >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-=
gnu- HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 prepare
> > > >   ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve_btfid=
s-in.o is incompatible with elf64-x86-64
> > > >   clang-17: error: linker command failed with exit code 1 (use -v t=
o see invocation)
> > > >   ...
> > > >
> > > > Before your change, with V=3D1, I see:
> > > >
> > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT=
,$LINUX_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototypes -Wst=
rict-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11 -Wdeclaration-after-s=
tatement -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$L=
INUX_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/res=
olve_btfids/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/=
bpf/resolve_btfids/main.o main.c
> > > >
> > > > After, I see:
> > > >
> > > > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT=
,$LINUX_SRC/tools/bpf/resolve_btfids/main.o --target=3Daarch64-linux-gnu -g=
 -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/to=
ols/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids=
/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/resolve=
_btfids/main.o main.c
> > > >
> > > > We seem to have taken on a '--target=3Daarch64-linux-gnu' (changing=
 the
> > > > target of resolve_btfids-in.o) and we dropped the warning flags.
> > > >
> > > > I think this comes from the clang block in
> > > > tools/scripts/Makefile.include, which is included into the
> > > > resolve_btfids Makefile via tools/lib/bpf/Makefile.
> > > >
> > > > I am not super familiar with the tools build system, otherwise I wo=
uld
> > > > try to provide a patch. I tried moving CROSS_COMPILE from a recursi=
ve to
> > > > simple variable ('=3D' -> ':=3D') and moving it to HOST_OVERRIDES b=
ut those
> > > > did not appear to resolve it for me.
> > > >
> > > > If there is any other information I can provide or patches I can te=
st,
> > > > please let me know.
> > > >
> > > > Cheers,
> > > > Nathan
> > >
> > > Thanks Nathan, and thanks for all the details in the bug report. I'm
> > > looking into this.
> > >
> > > Ian
> >
> > Given the somewhat complicated cross compile I wasn't able to get a
> > reproduction. Could you see if the following addresses the problem:
>
> As long as you have an LLVM toolchain that targets AArch64 and your
> host, you should be able to reproduce this issue with those commands
> verbatim, as that command should not use any GNU binutils. I am pretty
> sure I tried it in a fresh container before reporting it but it is
> possible that I did not.

Thanks, do you have instructions on setting up the container?

> > ```
> > diff --git a/tools/bpf/resolve_btfids/Makefile
> > b/tools/bpf/resolve_btfids/Makefile
> > index daed388aa5d7..a06966841df4 100644
> > --- a/tools/bpf/resolv

Ian
e_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -19,10 +19,9 @@ endif
> >
> > # always use the host compiler
> > HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"
> > ARCH=3D"$(HOSTARCH)" \
> > -                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > +                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > CROSS_COMPILE=3D""
> >
> > RM      ?=3D rm
> > -CROSS_COMPILE =3D
> >
> > OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> > ```
> >
>
> Unfortunately, it does not. I still see '--target=3D' end up in the
> CFLAGS of those files.
>
> Cheers,
> Nathan

Hmm.. I can see the issue. We avoid this in places like libsubcmd
because the Makefile there includes tools/scripts/Makefile.include,
but here the Makefile.build inclusion is direct and we have CC set up
for cross compilation. This is messy and it will take some playing
around to come up with a simple fix.

Thanks,
Ian
