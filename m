Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7F686E81
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 19:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBAS61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 13:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjBAS6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 13:58:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDCD93E9
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 10:57:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so2135763wma.1
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q3IAMhIwNLrciFwllaBjaR+vmlZO7D0Y/8ie0l3aNQg=;
        b=SnR0Zk65zxLSjl6vcNRd1x3dxl/fK/9yAvGdA4UEM+ggQwQY0QVdCI99hsLTABpLA9
         w0KCLlDdS1tBqs/QKu+GH9iooL8boyO0wA5A5R2WDUgJox9pdiL0z4wc8WCRpJN1nwCv
         /8fxc3LXIsB5zO7/IocNNRqHntqrgFAq6Tv0tyHc6ZOwFanf3v6KUXMBxXNh5ucOIYvz
         pPy3VVBFusIUxR60pBI1gBXVAm9Sb7BvRfpz3+PutKU9FtlGKDarKVv1oLVXKHQ6MPBk
         GP3cKg2yl/GAyYXCWg6nWWdPLNHLWiGru7Cgc5cBPQcFVfiD7cnerutoZkCKH7bf8bAk
         vhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3IAMhIwNLrciFwllaBjaR+vmlZO7D0Y/8ie0l3aNQg=;
        b=Y5qSS73WLEoykQzK7W7yjQB2aO00OwIc3leNkmD9VG1wmEBvzLDHhU51SrYE6s9jFy
         h1MacoXL8VPZOwPITkZBW/Un/Z41RUDFFgWYhe7Qc4uM5vRLzXxMKmwxjT/fqQCL9nNo
         eq9YoRpA9JD+jJk6pqV3dn4umQ2mcS2lYWtUPpHuY9J9sSgikU77e6bjXxfYf6oalQc5
         nL9TKF+usWmHHPL2g5qJ+2DaKLIkrSSS64xhJsOjzx5BoTjR2aD5AW6fLOj/7MEPdkVW
         GySStkeejzbOXzgpZHGiMavwdT2apb2rCrQVO3GEKyN9rH3f3xTG8Rv4r1lsJIph+ndt
         xKEA==
X-Gm-Message-State: AO0yUKW5OFGeEM0OfNjrEqZOMdFPY3Bu7MBI5+eEW15MH5O8gNBFsoQu
        goDyriIe9CTF8AZESN46obF5HBB6Rcwg92AutzKjpw==
X-Google-Smtp-Source: AK7set9fG6m6jicnYHZKozAN6onD2aFpDdwM7Z7v8Esmd2eKGLw6cuYHA8Qe33K1zo8+ukKxjYGo68U2r2vkYN5jRu0=
X-Received: by 2002:a05:600c:3d8f:b0:3db:1d5e:699 with SMTP id
 bi15-20020a05600c3d8f00b003db1d5e0699mr213758wmb.195.1675277872969; Wed, 01
 Feb 2023 10:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20230201015015.359535-1-irogers@google.com> <Y9o4H61YmbOSCDOG@krava>
 <Y9pCY5IcYEqfNgBX@krava>
In-Reply-To: <Y9pCY5IcYEqfNgBX@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 1 Feb 2023 10:57:40 -0800
Message-ID: <CAP-5=fVHFMJvaY_UE4QdV-PW+gy1EuyiHDXqWJmHVxS9Mr3XEQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools/resolve_btfids: Tidy host CFLAGS forcing
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Feb 1, 2023 at 2:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Feb 01, 2023 at 11:00:02AM +0100, Jiri Olsa wrote:
> > On Tue, Jan 31, 2023 at 05:50:15PM -0800, Ian Rogers wrote:
> > > Avoid passing CROSS_COMPILE to submakes and ensure CFLAGS is forced to
> > > HOSTCFLAGS for submake builds. This fixes problems with cross
> > > compilation.
> > >
> > > Tidy to not unnecessarily modify/export CFLAGS, make the override for
> > > prepare and build clearer.
> > >
> > > Fixes: 13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > hum, that seems to build just the fixdep and skip the resolve_btfids binary
> >
> > make[1]: Entering directory '/home/jolsa/kernel/linux-qemu/build'
> >   GEN     Makefile
> >   CALL    ../scripts/checksyscalls.sh
> >   DESCEND bpf/resolve_btfids
> >   HOSTCC  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep.o
> >   HOSTLD  /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep-in.o
> >   LINK    /home/jolsa/kernel/linux-qemu/build/tools/bpf/resolve_btfids/fixdep
> >   UPD     include/generated/utsversion.h
> >   CC      init/version-timestamp.o
> >   LD      .tmp_vmlinux.btf
> >   BTF     .btf.vmlinux.bin.o
> > die__process_unit: DW_TAG_label (0xa) @ <0x4f0d4> not handled!
> >
> >   ...
> >
> > die__process_unit: DW_TAG_label (0xa) @ <0xaf91cc3> not handled!
> > die__process_unit: DW_TAG_label (0xa) @ <0xb032fa7> not handled!
> >   LD      .tmp_vmlinux.kallsyms1
> >   NM      .tmp_vmlinux.kallsyms1.syms
> >   KSYMS   .tmp_vmlinux.kallsyms1.S
> >   AS      .tmp_vmlinux.kallsyms1.S
> >   LD      .tmp_vmlinux.kallsyms2
> >   NM      .tmp_vmlinux.kallsyms2.syms
> >   KSYMS   .tmp_vmlinux.kallsyms2.S
> >   AS      .tmp_vmlinux.kallsyms2.S
> >   LD      .tmp_vmlinux.kallsyms3
> >   NM      .tmp_vmlinux.kallsyms3.syms
> >   KSYMS   .tmp_vmlinux.kallsyms3.S
> >   AS      .tmp_vmlinux.kallsyms3.S
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > ../scripts/link-vmlinux.sh: line 277: ./tools/bpf/resolve_btfids/resolve_btfids: No such file or directory
> > make[2]: *** [../scripts/Makefile.vmlinux:35: vmlinux] Error 127
> > make[2]: *** Deleting file 'vmlinux'
> > make[1]: *** [/home/jolsa/kernel/linux-qemu/Makefile:1264: vmlinux] Error 2
> > make[1]: Leaving directory '/home/jolsa/kernel/linux-qemu/build'
> > make: *** [Makefile:242: __sub-make] Error 2
> >
> > we actually have the hostprogs support in tools/build and we use it for
> > fixdep, I think we should use it also here, I'll check
>
> it doesn't look that bad.. the change below fixes the build for me,
> perhaps we should do that for all the host tools
>
> jirka

I don't mind this. The fixdep vs all thing is just cause by the
ordering in the Makefile, you can fix by specifying the target or add
this patch:
```
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -58,11 +58,11 @@ HOST_OVERRIDES_BUILD := $(HOST_OVERRIDES_PREPARE) \

LIBS = $(LIBELF_LIBS) -lz

+all: $(BINARY)
+
export srctree OUTPUT Q
include $(srctree)/tools/build/Makefile.include

-all: $(BINARY)
-
prepare: $(BPFOBJ) $(SUBCMDOBJ)

$(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
```

Should we do this and the hostprogs migration as a follow up? There
isn't that much use of hostprogs in tools, but I like that your change
will show HOSTCC rather than CC during compilation. If we use
hostprogs can we just avoid the overrides altogether?

Thanks,
Ian

>
> ---
> diff --git a/tools/bpf/resolve_btfids/Build b/tools/bpf/resolve_btfids/Build
> index ae82da03f9bf..077de3829c72 100644
> --- a/tools/bpf/resolve_btfids/Build
> +++ b/tools/bpf/resolve_btfids/Build
> @@ -1,3 +1,5 @@
> +hostprogs := resolve_btfids
> +
>  resolve_btfids-y += main.o
>  resolve_btfids-y += rbtree.o
>  resolve_btfids-y += zalloc.o
> @@ -7,4 +9,4 @@ resolve_btfids-y += str_error_r.o
>
>  $(OUTPUT)%.o: ../../lib/%.c FORCE
>         $(call rule_mkdir)
> -       $(call if_changed_dep,cc_o_c)
> +       $(call if_changed_dep,host_cc_o_c)
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index daed388aa5d7..de513fd08535 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -22,6 +22,9 @@ HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)
>                   EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
>
>  RM      ?= rm
> +HOSTCC  ?= gcc
> +HOSTLD  ?= ld
> +HOSTAR  ?= ar
>  CROSS_COMPILE =
>
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
> @@ -64,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>
> -CFLAGS += -g \
> +HOSTCFLAGS += -g \
>            -I$(srctree)/tools/include \
>            -I$(srctree)/tools/include/uapi \
>            -I$(LIBBPF_INCLUDE) \
> @@ -73,7 +76,7 @@ CFLAGS += -g \
>
>  LIBS = $(LIBELF_LIBS) -lz
>
> -export srctree OUTPUT CFLAGS Q
> +export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
>  include $(srctree)/tools/build/Makefile.include
>
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
