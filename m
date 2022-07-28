Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C15847EE
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 00:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiG1WFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiG1WFK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 18:05:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FE2B52
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 15:05:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id va17so5502058ejb.0
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RoCs+NEzlCqK8aLkJt2gBMB9EF+7Lb5BgGnx2FJ4gGM=;
        b=K4GLNaPZFM8U+swrzypASI27bdbJ7w77Z4sAKVkjVULnqHLf9Wf9JS9mPjIvK/AL81
         7lRwzWkNetUxPLblN/gS6awV1lcc1IMVZPVRRMA161q1ntjva89ZSin3VOa/mo0WUpfU
         jc8w7TPx8caHdY0yHM8PTh/7Au2KPkW5fRDiv18po/3xkKqshfQdu0AnqO3EPsak6FKZ
         s1iD6elkRtahzgaDWSSFWKnQAX9ENFKxfhO1Q7JsTivAj51Ao5ObM7v9MwC+gmCqGyNh
         h9NVPDomzFuCzuYblNK3LDGl27N8YxnKe5UGKc4AUHKWP8hmBJJdW2MirOD3v4In5NxO
         tDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RoCs+NEzlCqK8aLkJt2gBMB9EF+7Lb5BgGnx2FJ4gGM=;
        b=LSpCRb65dSJD/W0QS6VVTOdefh0hRx6zQdFKbY6uF5pQFaHrJifPcZGpPmtBhlgJe5
         z7AeGKryDHuNGK/y7QkL/L6GSJGwnwZ1MLrKxecaBJMdzWsDGiimqBU/so2OrQsnP2tf
         C5S9LgeHWlNnJvR0TWQmwTzRICWDlwB7M+jbDgc1ANvILLvc/UR6SPZdSOTeiIK3Ir9n
         GpYpNGLeN2/hTR2Q1/PA1ZUP871w7LpsHEI4nRgNy9fkDGR0IuHf+1T8KpAEK3xwIgP3
         NbPONbwvp8VCxs2Mg34a3/hsR/VE7yd1imhIvpToMfb3Vg4aysD7LMnPD3qq0t2teZFq
         hXAQ==
X-Gm-Message-State: AJIora+qQfH0XVOzu2TNs6Sf5afN1kmLngqTQiJidpmZHa+DA0IyuyjC
        ZnPGsna7vS4OJllYZeS4Dw6qhyTXyrReW5XBdJo9kIe/
X-Google-Smtp-Source: AGRyM1vpY1coDGr7auWTNGG2cWoyQ5BPBexwFhRh+itW7/0zAuwb2d1a4svNfKp6ESeC/X9WWW/ZgnsVj+Rs1BCXRMs=
X-Received: by 2002:a17:907:6e1d:b0:72f:20ad:e1b6 with SMTP id
 sd29-20020a1709076e1d00b0072f20ade1b6mr662142ejc.545.1659045906773; Thu, 28
 Jul 2022 15:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220616055543.3285835-1-andrii@kernel.org> <87lesnyeph.fsf@cloudflare.com>
 <87czdzy6k2.fsf@cloudflare.com>
In-Reply-To: <87czdzy6k2.fsf@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Jul 2022 15:04:55 -0700
Message-ID: <CAEf4BzZmDMb1NWcbiu0PZpU21S0C+Ozyi=tRUyHt-3D=tazwfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix internal USDT address translation
 logic for shared libraries
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        kernel-team <kernel-team@cloudflare.com>
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

On Wed, Jul 20, 2022 at 11:37 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Wed, Jul 20, 2022 at 05:32 PM +02, Jakub Sitnicki wrote:
>
> [...]
>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index 8ad7a733a505..e08e8e34e793 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -172,13 +172,15 @@ $(OUTPUT)/%:%.c
> >>  # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
> >>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
> >>      $(call msg,LIB,,$@)
> >> -    $(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS) -fPIC -shared -o $@
> >> +    $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
> >> +                 -fuse-ld=lld -Wl,-znoseparate-code -fPIC -shared -o $@
> >>
> >>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
> >>      $(call msg,BINARY,,$@)
> >> -    $(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)  \
> >> -              liburandom_read.so $(LDLIBS)                                 \
> >> -              -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
> >> +    $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> >> +                 liburandom_read.so $(LDLIBS)                              \
> >> +                 -fuse-ld=lld -Wl,-znoseparate-code                        \
> >> +                 -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
> >
> > [...]
> >
> > Not sure if this was considered - adding a dependency on Clang for the
> > target platform makes cross-compiling bpf selftests much harder than it
> > was.
> >
> > Maybe we could use $(CLANG) only when not cross-compiling, and execute
> > $(CC) like before otherwise?
>
> OTOH, there seems to be nothing Clang specific about the build
> recipe. We just want t use LLVM lld. GCC accepts -fuse-ld as well (bfd
> vs lld).
>
> Perhaps we could partially revert to something as below? It "fixes" the
> cross-compilation build of bpf selftests for arm64 for me.
>
> WDYT?
>
> --8<--
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 8d59ec7f4c2d..541e2b0de27a 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -170,24 +170,24 @@ $(OUTPUT)/%:%.c
>
>  # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>  ifeq ($(SRCARCH),x86)
> -LLD := lld
> +ALT_LD := lld
>  else
> -LLD := ld
> +ALT_LD := bfd
>  endif
>
>  # Filter out -static for liburandom_read.so and its dependent targets so that static builds
>  # do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
>         $(call msg,LIB,,$@)
> -       $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)   \
> -                    -fuse-ld=$(LLD) -Wl,-znoseparate-code -fPIC -shared -o $@
> +       $(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS)       \
> +                 -fuse-ld=$(ALT_LD) -Wl,-znoseparate-code -fPIC -shared -o $@
>
>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>         $(call msg,BINARY,,$@)
> -       $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> -                    liburandom_read.so $(LDLIBS)                              \
> -                    -fuse-ld=$(LLD) -Wl,-znoseparate-code                     \
> -                    -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
> +       $(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)   \
> +                 liburandom_read.so $(LDLIBS)                                  \
> +                 -fuse-ld=$(ALT_LD) -Wl,-znoseparate-code                      \
> +                 -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
>

I tried building with CC locally and I still see ELF layout that would
exercise the logic that was fixed with my original patchset:

$ readelf -l liburandom_read.so | grep LOAD -A1
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x00000000000005ec 0x00000000000005ec  R      0x1000
  LOAD           0x00000000000005f0 0x00000000000015f0 0x00000000000015f0
                 0x0000000000000130 0x0000000000000130  R E    0x1000
  LOAD           0x0000000000000720 0x0000000000002720 0x0000000000002720
                 0x0000000000000200 0x0000000000000200  RW     0x1000
  LOAD           0x0000000000000920 0x0000000000003920 0x0000000000003920
                 0x0000000000000028 0x0000000000000029  RW     0x1000

So sure, sounds good to me, please send a patch with a change.



>  $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
>         $(call msg,MOD,,$@)
