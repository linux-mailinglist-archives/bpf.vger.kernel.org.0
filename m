Return-Path: <bpf+bounces-35111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A16937C75
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD531C214BB
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EF1474BF;
	Fri, 19 Jul 2024 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlpPdFxj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59612D76F;
	Fri, 19 Jul 2024 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413899; cv=none; b=Xwhi9HyjHJvB02dIggKVKQAWBdEry3P2IitP2GcjF7n6+Fn5oHVJp8PAitdDSW82DyhWo++JCXFlkwROoAzBbBQiogHSRI12ShAc1zfkkzNo3esOaKQySHoH6E+y8WI2ZS+y6tFJg1GiIwFvdjtDEaO3Qz+5Oh0c7xGjckoMBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413899; c=relaxed/simple;
	bh=VbrautQzlYWxEDaMWreoVPpn1tM5+hrKbq9WVHBo05A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sI6J3uLQ9YUvMtWR6KlTDdQcX47O4RfkAwxkOWoEemacncRW09pnyvXM+0Qd17EhNovMh717D9VSoQT2SQFdQ2cc2RsVyinqrdx394heOGX/c4XhZE9VT6aGPWyk5vlmg4wleQf4ZHB9/WgZP78sG4VZgtwIXiApzHn+99nsYL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlpPdFxj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b0d0fefe3so997664b3a.2;
        Fri, 19 Jul 2024 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413897; x=1722018697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERG/bcVtUtAwxhXuGRrT4r33YSase4i6uuVKdzOjEYs=;
        b=BlpPdFxjvQnqBQZ5H1uT7oI9rpiGCfjoVnmC4E8872DyiLrP6X8Nb4d2zDHAk0NYiH
         dH3/bvhB08ICFslYcf4wMOgT8iuUZITjQNjSU3T1Vlg7/Za4oZpGYEvccmUxS6DGZ7ex
         GcHnMGQlyURd/3IOc0SFs9I40H8KHHwMsTEeApR6IoWewJESjTywU7WxcLi7vpP9rn7F
         vucGQcn4LcygxRqCVTUG9mJV2Rib8nvwBHr4xgg+gycqan3apvCYqw7ffzIvQaf59peX
         5gQKmyqHaVkJMRBwMyI+Ct8vSenI/LEu7LmRXDzc512VmLA7P9Mwt2a3VtGL/EU3iTgK
         UpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413897; x=1722018697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERG/bcVtUtAwxhXuGRrT4r33YSase4i6uuVKdzOjEYs=;
        b=CfPEwSlBwkF85gG/tHOWdFmlYl18n97/MO/yna5ev5djq+HNl3H3RB5B9bxn2ioA2R
         ArL+gm/Usqs0beyOnUOMdKCsAIl/LzSqv4Y+yC4z6qhnsAj0F17igbSiIWT2vQwgBYlf
         CHMcKGqNFXEJ3oKEHlka973rr33qgt9tRw/CaDzm0N5XTznIPec5N4S2NM/C/8WyqrFC
         Y6BVLekvLao9oADSq5OvG+gT/BkgMQIJ3CpM1maYxpIBsQqvFMLYJXWuPZNMzazzehmC
         Jc5ZMoaonP4TrRTrPwzS5za8fOUbXEHxBk1US0VcWlBUmN4bmuOt9DmLVLvEusiWyjro
         O1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVPc44pF3m63iutsjpziTCTIrRP0U1wdbAT6pjR0fMRGqhNNZf5LWvqOSOK216xuhrt1euGP9aTIWwxp0BoSwKz20pIn30FvHYzr+9UYmg4MEWGPohdod7qdBkDSBuQpxFl2vR5wCY2IHvUbPe/St29kM+Xm+R0uMfB0g/qqji1
X-Gm-Message-State: AOJu0Yw8HyLUQSe75hZUIvdsmFtofiWDw4Hobq+XJGmRbjuMtPlKpY7S
	awMDwu+rVTPr5cZYfvRfQefNhU8qvT50VV0sIKrG37c6TwspcZaZP+PhnI09yDllBdZjrwjkX0E
	x0+Ke7w0476MetDrS4n1+DslJCUg=
X-Google-Smtp-Source: AGHT+IFZnmlJu75ejk4L6RUFX006ajbjLjQx94CEyPq6s5kR036q7vYz0eC0jKCQwGND765m7vJJTzEr4nlJ/xxKNOw=
X-Received: by 2002:a05:6a20:2453:b0:1c3:a9b8:a9bf with SMTP id
 adf61e73a8af0-1c3fdd592c7mr10678523637.51.1721413897551; Fri, 19 Jul 2024
 11:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715203325.3832977-1-briannorris@chromium.org> <20240715203325.3832977-4-briannorris@chromium.org>
In-Reply-To: <20240715203325.3832977-4-briannorris@chromium.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 11:31:25 -0700
Message-ID: <CAEf4BzaY=6dVShaXmnjKPLB6xRdMbM0Gtz08A=rwgq2SR66L9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tools build: Correct bpf fixdep dependencies
To: Brian Norris <briannorris@chromium.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 1:37=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> The dependencies in tools/lib/bpf/Makefile are incorrect. Before we
> recurse to build $(BPF_IN_STATIC), we need to build its 'fixdep'
> executable.
>
> I can't use the usual shortcut from Makefile.include:
>
>   <target>: <sources> fixdep
>
> because its 'fixdep' target relies on $(OUTPUT), and $(OUTPUT) differs
> in the parent 'make' versus the child 'make' -- so I imitate it via
> open-coding.
>
> I tweak a few $(MAKE) invocations while I'm at it, because
> 1. I'm adding a new recursive make; and
> 2. these recursive 'make's print spurious lines about files that are "up
>    to date" (which isn't normally a feature in Kbuild subtargets) or
>    "jobserver not available" (see [1])
>
> I also need to tweak the assignment of the OUTPUT variable, so that
> relative path builds work. For example, for 'make tools/lib/bpf', OUTPUT
> is unset, and is usually treated as "cwd" -- but recursive make will
> change cwd and so OUTPUT has a new meaning. For consistency, I ensure
> OUTPUT is always an absolute path.
>
> And $(Q) gets a backup definition in tools/build/Makefile.include,
> because Makefile.include is sometimes included without
> tools/build/Makefile, so the "quiet command" stuff doesn't actually work
> consistently without it.
>
> After this change, top-level builds result in an empty grep result from:
>
>   $ grep 'cannot find fixdep' $(find tools/ -name '*.cmd')
>
> [1] https://www.gnu.org/software/make/manual/html_node/MAKE-Variable.html
> If we're not using $(MAKE) directly, then we need to use more '+'.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> ---
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Changes in v4:
>  - update tools/lib/bpf/.gitignore to exclude 'fixdep'
>  - update tools/lib/bpf `make clean` target for fixdep
>  - combine $(SHARED_OBJDIR) and $(STATIC_OBJDIR) rules
>
> Changes in v3:
>  - add Jiri's Acked-by
>
> Changes in v2:
>  - also fix libbpf shared library rules
>  - ensure OUTPUT is always set, and always an absolute path
>  - add backup $(Q) definition in tools/build/Makefile.include
>
>  tools/build/Makefile.include | 12 +++++++++++-
>  tools/lib/bpf/.gitignore     |  1 +
>  tools/lib/bpf/Makefile       | 13 ++++++++++---
>  3 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/build/Makefile.include b/tools/build/Makefile.include
> index 8dadaa0fbb43..0e4de83400ac 100644
> --- a/tools/build/Makefile.include
> +++ b/tools/build/Makefile.include
> @@ -1,8 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  build :=3D -f $(srctree)/tools/build/Makefile.build dir=3D. obj
>
> +# More than just $(Q), we sometimes want to suppress all command output =
from a
> +# recursive make -- even the 'up to date' printout.
> +ifeq ($(V),1)
> +  Q ?=3D
> +  SILENT_MAKE =3D +$(Q)$(MAKE)
> +else
> +  Q ?=3D @
> +  SILENT_MAKE =3D +$(Q)$(MAKE) --silent
> +endif
> +
>  fixdep:
> -       $(Q)$(MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D $(OUTP=
UT)fixdep
> +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D $(O=
UTPUT)fixdep
>
>  fixdep-clean:
>         $(Q)$(MAKE) -C $(srctree)/tools/build clean
> diff --git a/tools/lib/bpf/.gitignore b/tools/lib/bpf/.gitignore
> index 0da84cb9e66d..f02725b123b3 100644
> --- a/tools/lib/bpf/.gitignore
> +++ b/tools/lib/bpf/.gitignore
> @@ -5,3 +5,4 @@ TAGS
>  tags
>  cscope.*
>  /bpf_helper_defs.h
> +fixdep
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 2cf892774346..1b22f0f37288 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -108,6 +108,8 @@ MAKEOVERRIDES=3D
>
>  all:
>
> +OUTPUT ?=3D ./
> +OUTPUT :=3D $(abspath $(OUTPUT))/
>  export srctree OUTPUT CC LD CFLAGS V
>  include $(srctree)/tools/build/Makefile.include
>
> @@ -141,7 +143,10 @@ all: fixdep
>
>  all_cmd: $(CMD_TARGETS) check
>
> -$(BPF_IN_SHARED): force $(BPF_GENERATED)
> +$(SHARED_OBJDIR) $(STATIC_OBJDIR):
> +       $(Q)mkdir -p $@
> +
> +$(BPF_IN_SHARED): force $(BPF_GENERATED) | $(SHARED_OBJDIR)
>         @(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/u=
api/linux/bpf.h && ( \
>         (diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/lin=
ux/bpf.h >/dev/null) || \
>         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf=
.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || tr=
ue
> @@ -151,9 +156,11 @@ $(BPF_IN_SHARED): force $(BPF_GENERATED)
>         @(test -f ../../include/uapi/linux/if_xdp.h -a -f ../../../includ=
e/uapi/linux/if_xdp.h && ( \
>         (diff -B ../../include/uapi/linux/if_xdp.h ../../../include/uapi/=
linux/if_xdp.h >/dev/null) || \
>         echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_=
xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 ))=
 || true
> +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D OUT=
PUT=3D$(SHARED_OBJDIR) $(SHARED_OBJDIR)fixdep
>         $(Q)$(MAKE) $(build)=3Dlibbpf OUTPUT=3D$(SHARED_OBJDIR) CFLAGS=3D=
"$(CFLAGS) $(SHLIB_FLAGS)"
>
> -$(BPF_IN_STATIC): force $(BPF_GENERATED)
> +$(BPF_IN_STATIC): force $(BPF_GENERATED) | $(STATIC_OBJDIR)
> +       $(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS=3D LDFLAGS=3D OUT=
PUT=3D$(STATIC_OBJDIR) $(STATIC_OBJDIR)fixdep
>         $(Q)$(MAKE) $(build)=3Dlibbpf OUTPUT=3D$(STATIC_OBJDIR)
>
>  $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
> @@ -263,7 +270,7 @@ install_pkgconfig: $(PC_FILE)
>
>  install: install_lib install_pkgconfig install_headers
>
> -clean:
> +clean: fixdep-clean
>         $(call QUIET_CLEAN, libbpf) $(RM) -rf $(CMD_TARGETS)             =
    \
>                 *~ .*.d .*.cmd LIBBPF-CFLAGS $(BPF_GENERATED)            =
    \
>                 $(SHARED_OBJDIR) $(STATIC_OBJDIR)                        =
    \
> --
> 2.45.2.993.g49e7a77208-goog
>
>

