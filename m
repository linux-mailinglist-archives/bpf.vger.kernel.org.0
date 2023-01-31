Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7136B6834C4
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjAaSIu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjAaSIt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:08:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF661D916
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:08:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n13so3966183wmr.4
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3HmVJerFzkpeb8F8VIoRLz10S/UGvYmUy1GfvChxFY=;
        b=bPqnDf0zMlABjuoFQa/6wpGy7pgFqfWQlHErUc/iSZkdKjNWcm8szh5petXGd2ohse
         KRe86Zy6hL4PdXY8coIW9kV3zWm9mVt9xYo8V2eMzrEH4V8Kfnth4n6XqlOCfNdj/D/F
         UvyvVvBWat33yqGZI40lSYC2olv79CICnVE7lHKwkPuco+OhNOUiWuZZYR78/RK8dwoN
         gQ1BsN4TCnUzncb2au5v+KzG50AFAwklSaE5LJZMDdAyHAX/kcaHNzaq67S/Or6zBQuR
         ndGc1wE6VNs2Nq5I/fcKWSoODGM/ly0ReGrB0mtWrM0iaCAdqZBXluzAoQYfQxs0tkhp
         psjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3HmVJerFzkpeb8F8VIoRLz10S/UGvYmUy1GfvChxFY=;
        b=jg8BFkirE5jR84W1Wqk3nrG5QHxd4Y+UpU9cYJPU3miZ01sLnol6kd3b1tNpdt3BFp
         yWWtyy/XRmOvTO7Qe7sdaIKE2iEYOI/RcGdWXczTLZQoZOs1g/QimGKOVPiRp7Y+gXfI
         HPfH5X3ULMOxNdRPRFUKGh30qmNePh7hs27W1nahlZSZFiu0OkD/2n+GQTlv5Hmpakbn
         db5o4D64b+XXsqRuJIABJbZN/tsga5u7l9LlPO1cfq7wpyeyIO3INGGmlmHyS9aL2aUj
         pKehwLRWDEzS1NQ0BvDDRNxPil/4wjqw2jnTNa7X9P+SFHB6QXFQqMgNMoMFBl38PpGD
         d0bA==
X-Gm-Message-State: AFqh2koSke/SQI6Gik6Q9zHwkp/iOV2+67AolK2HQ6ABCOCTz9QJt4Zz
        P0wU6vknpAfFZlLJa2zpkwo8SA9Dq/DTrbZ+1rwExw==
X-Google-Smtp-Source: AMrXdXu4Q1XIm4ddS3d8Vr4z1BzBOlUP3KRITTyoLaWKe61xsL8nWqaIzj4tMCq0DDfs9YT7jjr6zZ+zfNJDvjEcESw=
X-Received: by 2002:a1c:7404:0:b0:3da:b40f:c734 with SMTP id
 p4-20020a1c7404000000b003dab40fc734mr4502674wmc.115.1675188525655; Tue, 31
 Jan 2023 10:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20230124064324.672022-1-irogers@google.com> <20230124064324.672022-2-irogers@google.com>
 <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X>
In-Reply-To: <Y9lN+H3ModGwwKV6@dev-arch.thelio-3990X>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 31 Jan 2023 10:08:33 -0800
Message-ID: <CAP-5=fWvmEJ3DuKkhOEVg6zoiSKDGW-n=GFqRhse=2dP=C6i3Q@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 9:21 AM Nathan Chancellor <nathan@kernel.org> wrote=
:
>
> Hi Ian,
>
> On Mon, Jan 23, 2023 at 10:43:24PM -0800, Ian Rogers wrote:
> > HOSTCC is always wanted when building. Setting CC to HOSTCC happens
> > after tools/scripts/Makefile.include is included, meaning flags are
> > set assuming say CC is gcc, but then it can be later set to HOSTCC
> > which may be clang. tools/scripts/Makefile.include is needed for host
> > set up and common macros in objtool's Makefile. Rather than override
> > CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the libsubcmd
> > builds and the linkage step. This means the Makefiles don't see things
> > like CC changing and tool flag determination, and similar, work
> > properly.
> >
> > Also, clear the passed subdir as otherwise an outer build may break by
> > inadvertently passing an inappropriate value.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/resolve_btfids/Makefile | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfi=
ds/Makefile
> > index 1fe0082b2ecc..daed388aa5d7 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -18,14 +18,11 @@ else
> >  endif
> >
> >  # always use the host compiler
> > -AR       =3D $(HOSTAR)
> > -CC       =3D $(HOSTCC)
> > -LD       =3D $(HOSTLD)
> > -ARCH     =3D $(HOSTARCH)
> > +HOST_OVERRIDES :=3D AR=3D"$(HOSTAR)" CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)"=
 ARCH=3D"$(HOSTARCH)" \
> > +               EXTRA_CFLAGS=3D"$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> > +
> >  RM      ?=3D rm
> >  CROSS_COMPILE =3D
> > -CFLAGS  :=3D $(KBUILD_HOSTCFLAGS)
> > -LDFLAGS :=3D $(KBUILD_HOSTLDFLAGS)
> >
> >  OUTPUT ?=3D $(srctree)/tools/bpf/resolve_btfids/
> >
> > @@ -56,12 +53,12 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> >
> >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> >       $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=3D$(SUBCMD_OUT) \
> > -                 DESTDIR=3D$(SUBCMD_DESTDIR) prefix=3D \
> > +                 DESTDIR=3D$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix=
=3D subdir=3D \
> >                   $(abspath $@) install_headers
> >
> >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $=
(LIBBPF_OUT)
> >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=3D$(LIBBPF_=
OUT)    \
> > -                 DESTDIR=3D$(LIBBPF_DESTDIR) prefix=3D EXTRA_CFLAGS=3D=
"$(CFLAGS)" \
> > +                 DESTDIR=3D$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix=
=3D subdir=3D \
> >                   $(abspath $@) install_headers
> >
> >  LIBELF_FLAGS :=3D $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/nul=
l)
> > @@ -80,11 +77,11 @@ export srctree OUTPUT CFLAGS Q
> >  include $(srctree)/tools/build/Makefile.include
> >
> >  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> > -     $(Q)$(MAKE) $(build)=3Dresolve_btfids
> > +     $(Q)$(MAKE) $(build)=3Dresolve_btfids $(HOST_OVERRIDES)
> >
> >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> >       $(call msg,LINK,$@)
> > -     $(Q)$(CC) $(BINARY_IN) $(LDFLAGS) -o $@ $(BPFOBJ) $(SUBCMDOBJ) $(=
LIBS)
> > +     $(Q)$(HOSTCC) $(BINARY_IN) $(KBUILD_HOSTLDFLAGS) -o $@ $(BPFOBJ) =
$(SUBCMDOBJ) $(LIBS)
> >
> >  clean_objects :=3D $(wildcard $(OUTPUT)/*.o                \
> >                              $(OUTPUT)/.*.o.cmd           \
> > --
> > 2.39.0.246.g2a6d74b583-goog
> >
>
> I just bisected a linking failure when building resolve_btfids with
> clang to this change as commit 13e07691a16f ("tools/resolve_btfids:
> Alter how HOSTCC is forced") in the bpf-next tree.
>
> It appears to be related to whether or not CROSS_COMPILE is specified,
> which we have to do for certain architectures and configurations still.
> arm64 is not one of those but it helps demonstrate the issue.
>
>   # Turn off CONFIG_DEBUG_INFO_REDUCED and turn on CONFIG_DEBUG_INFO_BTF
>   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- H=
OSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 defconfig menuconfig
>
>   $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- H=
OSTLDFLAGS=3D-fuse-ld=3Dlld LLVM=3D1 prepare
>   ld.lld: error: $LINUX_SRC/tools/bpf/resolve_btfids//resolve_btfids-in.o=
 is incompatible with elf64-x86-64
>   clang-17: error: linker command failed with exit code 1 (use -v to see =
invocation)
>   ...
>
> Before your change, with V=3D1, I see:
>
> clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINU=
X_SRC/tools/bpf/resolve_btfids/main.o -Wall -Wmissing-prototypes -Wstrict-p=
rototypes -O2 -fomit-frame-pointer -std=3Dgnu11 -Wdeclaration-after-stateme=
nt -g -I$LINUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_S=
RC/tools/bpf/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_b=
tfids/libsubcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/re=
solve_btfids/main.o main.c
>
> After, I see:
>
> clang -Wp,-MD,$LINUX_SRC/tools/bpf/resolve_btfids/.main.o.d -Wp,-MT,$LINU=
X_SRC/tools/bpf/resolve_btfids/main.o --target=3Daarch64-linux-gnu -g -I$LI=
NUX_SRC/tools/include -I$LINUX_SRC/tools/include/uapi -I$LINUX_SRC/tools/bp=
f/resolve_btfids/libbpf/include -I$LINUX_SRC/tools/bpf/resolve_btfids/libsu=
bcmd/include -D"BUILD_STR(s)=3D#s" -c -o $LINUX_SRC/tools/bpf/resolve_btfid=
s/main.o main.c
>
> We seem to have taken on a '--target=3Daarch64-linux-gnu' (changing the
> target of resolve_btfids-in.o) and we dropped the warning flags.
>
> I think this comes from the clang block in
> tools/scripts/Makefile.include, which is included into the
> resolve_btfids Makefile via tools/lib/bpf/Makefile.
>
> I am not super familiar with the tools build system, otherwise I would
> try to provide a patch. I tried moving CROSS_COMPILE from a recursive to
> simple variable ('=3D' -> ':=3D') and moving it to HOST_OVERRIDES but tho=
se
> did not appear to resolve it for me.
>
> If there is any other information I can provide or patches I can test,
> please let me know.
>
> Cheers,
> Nathan

Thanks Nathan, and thanks for all the details in the bug report. I'm
looking into this.

Ian
