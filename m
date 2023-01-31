Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1B68367A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 20:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjAaT0A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 14:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaTZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 14:25:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7979123C79
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 11:25:52 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o36so5097146wms.1
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 11:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NufJ/Gm2hWIMuXWS7/Yr4/bvV59aXKh8fWz/B+yUXao=;
        b=NNpPQJIvzEVa7JHxZGX3t1feIq6c+thiHUtAfF58mqvN/SKhXzHPXZDa1vvjAWzVmg
         AY5pQHc2ITTj2y17FefwAgR460L72mY9jKlq8ppU+mJOzeybhSDyxieBE2VVjQrujDhR
         eLSjBS+ymIrF0qhuvun9NsVguCaa2qyU0K8RHHEThbXQY6Buw4hhyiDeTX1+3ZEOpcmv
         y3nRL1v/5W5hSmRwYeltSz054mTMMu2hXeb8Vp2NKJhqkMhIEj3EAPq6tjrjQcS18auc
         JPg8ccJ72q8hokUwIijLnZg89yENXnBj42qB39Nji0aNZhPDnLsSupHPNSdG+4oiaRZJ
         naOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NufJ/Gm2hWIMuXWS7/Yr4/bvV59aXKh8fWz/B+yUXao=;
        b=tyseZh/Jxdu0f7YZ+Bi+DZcLd4dkdm6hKkYmznBeV1QD88h329Dvk5txgmZyeiDumj
         KD3qIdYrUuLAVAFvjJq8i2o8Cd/o0cTdx2g1tAkhLOAm87+jgIxjVjcP5sOw0ssOHr/q
         X0eIidsbQHVjIlncz85Jgl8M9yZEdQaD72u8bMA4VByrcUImVNNiJZuuGx4arK48ldHL
         wKaqa0p0yyjsIG89P3loYDO/1TfyJwrQvC4KMPOqmGUWvPDpltqbKwzxlpXi7+P/cS0C
         QZVupqzBQh0UJSEC2og0wXR4VfoTEM7VAEIgXJ4d5b/NfTq5b+tvHJ4nThP/7C8dsotZ
         LQkQ==
X-Gm-Message-State: AFqh2kpUPNjJrjWY9iz7saxhuJEO9IJaAxKfovqd40yofMz6PH0PE/fh
        zRGaO25h3je2DBuC2f/0nHi+JOwGBJqD16SJbpZkQA==
X-Google-Smtp-Source: AMrXdXv0AzrWKGFqX1wNssEzgbOFOBooSuSAhIG9PlOWhXZjk4mHGGjT2qTdWvY0YXD8lWYOrXMfm4GToReLbdC73sU=
X-Received: by 2002:a05:600c:5405:b0:3d0:50c4:432c with SMTP id
 he5-20020a05600c540500b003d050c4432cmr3093884wmb.67.1675193150731; Tue, 31
 Jan 2023 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20230124064324.672022-1-irogers@google.com> <20230124064324.672022-2-irogers@google.com>
 <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X> <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
In-Reply-To: <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 Jan 2023 11:25:38 -0800
Message-ID: <CAP-5=fWJzTOYj167maEP8=k=iWQJcrF-zOdbkTAUw94qrVOL5g@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 10:08 AM Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Jan 31, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org> wro=
te:
> >
> > Hi Ian,
> >
> > On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> > > HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> > > after tools/scripts/Makefile.include is included, meaning flags are
> > > set assuming say CC is gcc, but then it can be later set to HOSTCC
> > > which may be clang. tools/scripts/Makefile.include is needed for host
> > > set up and common macros in objtool's Makefile. Rather than override
> > > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> > > builds and the linkage step. This means the Makefiles don't see thing=
s
> > > like CC changing and tool flag determination, and similar, work
> > > properly.
> > >
> > > Also, clear the passed subdir as otherwise an outer build may break b=
y
> > > inadvertently passing an inappropriate value.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_bt=
fids/Makefile
> > > index 1fe0082b2ecc..daed388aa5d7 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -18,14 +18,11 @@ else
> > >  endif
> > >
> > >  # always use the host compiler
> > > -AR       =3D $(HOSTAR)
> > > -CC       =3D $(HOSTCC)
> > > -LD       =3D $(HOSTLD)
> > > -ARCH     =3D $(HOSTARCH)
> > > +HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD=
)" ARCH=3D"$(HOSTARCH)" \
> > > +               EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > > +
> > >  RM      ?=3D rm
> > >  CROSS_COMPILE =3D
> > > -CFLAGS  :=3D $(KBUILD_HOSTCFLAGS)
> > > -LDFLAGS :=3D $(KBUILD_HOSTLDFLAGS)
> > >
> > >  OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> > >
> > > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> > >
> > >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=3D$(SUBCMD_OUT) \
> > > -                 DESTDIR=3D$(SUBCMD_DESTDIR) prefix=3D \
> > > +                 DESTDIR=3D$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefi=
x=3D subdir=3D \
> > >                   $(abspath $@) install_headers
> > >
> > >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) |=
 $(LIBBPF_OUT)
> > >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=3D$(LIBBP=
F_OUT)    \
> > > -                 DESTDIR=3D$(LIBBPF_DESTDIR) prefix=3D EXTRA_CFLAGS=
=3D"$(CFLAGS)" \
> > > +                 DESTDIR=3D$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefi=
x=3D subdir=3D \
> > >                   $(abspath $@) install_headers
> > >
> > >  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/n=
ull)
> > > @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
> > >  include $(srctree)/tools/build/Makefile.include
> > >
> > >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > > -     $(Q)$(MAKE) $(build)=3Dresolve_btfids
> > > +     $(Q)$(MAKE) $(build)=3Dresolve_btfids $(HOST_OVERRIDES)
> > >
> > >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > >       $(call msg,LINK,$@)
> > > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) =
$(LIBS)
> > > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ=
) $(SUBCMDOBJ) $(LIBS)
> > >
> > >  clean_objects :=3D $(wildcard $(OUTPUT)/*.o                \
> > >                              $(OUTPUT)/.*.o.cmd           \
> > > --
> > > 2.39.0.246.g2a6d74b583-goog
> > >
> >
> > I just bisected a linking failure when building resolve_btfids with
> > clang to this change as commit 13e07691a16f ("tools/resolve_btfids:
> > Alter how HOSTCC is forced") in the bpf-next tree.
> >
> > It appears to be related to whether or not CROSS_COMPILE is specified,
> > which we have to do for certain architectures and configurations still.
> > arm64 is not one of those but it helps demonstrate the issue.
> >
> >   # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEBUG_INFO_BT=
F
> >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-=
 HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 defconfig menuconfig
> >
> >   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu-=
 HOSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 prepare
> >   ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve_btfids-in=
.o is incompatible with elf64-x86-64
> >   clang-17: error: linker command failed with exit code 1 (use -v to se=
e invocation)
> >   ...
> >
> > Before your change, with V=3D1, I see:
> >
> > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LI=
NUX_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototypes -Wstrict=
-prototypes -O2 -fomit-frame-pointer -std=3Dgnu11 -Wdeclaration-after-state=
ment -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX=
_SRC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve=
_btfids/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/=
resolve_btfids/main.o main.c
> >
> > After, I see:
> >
> > clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LI=
NUX_SRC/tools/bpf/resolve_btfids/main.o --target=3Daarch64-linux-gnu -g -I$=
LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/=
bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/lib=
subcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/resolve_btf=
ids/main.o main.c
> >
> > We seem to have taken on a '--target=3Daarch64-linux-gnu' (changing the
> > target of resolve_btfids-in.o) and we dropped the warning flags.
> >
> > I think this comes from the clang block in
> > tools/scripts/Makefile.include, which is included into the
> > resolve_btfids Makefile via tools/lib/bpf/Makefile.
> >
> > I am not super familiar with the tools build system, otherwise I would
> > try to provide a patch. I tried moving CROSS_COMPILE from a recursive t=
o
> > simple variable ('=3D' -> ':=3D') and moving it to HOST_OVERRIDES but t=
hose
> > did not appear to resolve it for me.
> >
> > If there is any other information I can provide or patches I can test,
> > please let me know.
> >
> > Cheers,
> > Nathan
>
> Thanks Nathan, and thanks for all the details in the bug report. I'm
> looking into this.
>
> Ian

Given the somewhat complicated cross compile I wasn't able to get a
reproduction. Could you see if the following addresses the problem:

```
diff --git a/tools/bpf/resolve_btfids/Makefile
b/tools/bpf/resolve_btfids/Makefile
index daed388aa5d7..a06966841df4 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -19,10 +19,9 @@ endif

# always use the host compiler
HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"
ARCH=3D"$(HOSTARCH)" \
-                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+                 EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
CROSS_COMPILE=3D""

RM      ?=3D rm
-CROSS_COMPILE =3D

OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
```

Thanks,
Ian
