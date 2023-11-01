Return-Path: <bpf+bounces-13774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713B7DDAE3
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA601B21084
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57598ED1;
	Wed,  1 Nov 2023 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rb6jenUB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB7EA6
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 02:18:28 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B779ED
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:18:27 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66cfc96f475so40556126d6.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698805106; x=1699409906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcNXIfr3erAyA40rSBKRGRUHZVsDZwYTmCC3ddsje6I=;
        b=Rb6jenUBaiSbpAztR1c+xy+XxicTFfyVrGF8EAF4IAGr3/EM9sN8CpsXybZHiK7Wm2
         WYf0rUp7hW7ecZ6RTDJyRj9oVVMZeFW+O5HtNpJyK7uphtLEe2nEZrFSpZuqtcW4amT/
         krP3DBB0XOh+9HTTCaSjbBe1VWP/4zg36SuvItJuozQhsFvIbtVy6GZcv+wQVDUkp9Ht
         wlsBvcJ52jbyq0FSKqGZ9MiypGR1yN6r5bfipt9p8M/WLpER+0SNEVH16Xvz2jZkpmrn
         NGI/DpcZcfQSEwoHp5ChDu4goXre9i2aj2BtLfJFiZ5QWSFf4XaLARGRcTshs7+m3AxV
         2bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698805106; x=1699409906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcNXIfr3erAyA40rSBKRGRUHZVsDZwYTmCC3ddsje6I=;
        b=nb5c4Zm66wsgSuMdPhbcrDSvRP73zUrfYGrOl3ICVuqfHxHQCzNUr0q7FIaVn8hO8+
         24x4s6f7FaZevZmpWgKillUoVObW18jN2OCoffJIgHJtefyhTkMCMsCJmQ+aSljEfU2f
         v6bT9t6ezuhPY4N8rVowqGgVM3olCQXC13FSbAnWkU9BzY/7UxHomilqkxv+QKGLhWMc
         lTM/Ug0vmPeuuV49Y063ZTAXBCzlHQd3s0LXKaV/3indBGVZ3VPVSsN7XpF8LEKvqtQU
         60jdg5/2ZZYke9NWE+nHuv5hBKk7lNLu2wBInOuSdefhRBQhvWEf89oDhkQ8MQuwa1m7
         BMIg==
X-Gm-Message-State: AOJu0YwpXY+C6S0Jy5vwawSt3DLCvgrske6AvhEhmlemGQv20uySQMlv
	7x8LxcKDRb5mmBJPV8Uee8pN5fhPIu66HO7B2dI=
X-Google-Smtp-Source: AGHT+IEceHUUtab5DW4nNcRNKfMljYxPcU/u6HCXSecln+Qkfo5P4HVkLxx7Zyc6AL69uaAVk5lu5RfWFpvtJtUu7/w=
X-Received: by 2002:a05:6214:d8a:b0:671:ab5c:d14a with SMTP id
 e10-20020a0562140d8a00b00671ab5cd14amr10721768qve.52.1698805106134; Tue, 31
 Oct 2023 19:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
 <20231031215625.2343848-2-davemarchevsky@fb.com> <ZUGH0Hat81I7AH9s@krava>
In-Reply-To: <ZUGH0Hat81I7AH9s@krava>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 1 Nov 2023 10:17:50 +0800
Message-ID: <CALOAHbA_oddu8GmfgzVpjta7ms8-9+RrJ=sOUyRs77AiTqxN=A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf: Add __bpf_hook_{start,end} macros
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 7:03=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Oct 31, 2023 at 02:56:25PM -0700, Dave Marchevsky wrote:
> > Not all uses of __diag_ignore_all(...) in BPF-related code in order to
> > suppress warnings are wrapping kfunc definitions. Some "hook point"
> > definitions - small functions meant to be used as attach points for
> > fentry and similar BPF progs - need to suppress -Wmissing-declarations.
> >
> > We could use __bpf_kfunc_{start,end}_defs added in the previous patch i=
n
> > such cases, but this might be confusing to someone unfamiliar with BPF
> > internals. Instead, this patch adds __bpf_hook_{start,end} macros,
> > currently having the same effect as __bpf_kfunc_{start,end}_defs, then
> > uses them to suppress warnings for two hook points in the kernel itself
> > and some bpf_testmod hook points as well.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Cc: Yafang Shao <laoar.shao@gmail.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

>
> jirka
>
> > ---
> >
> > This patch was added in v2 in response to convo on v1's thread.
> >
> >  include/linux/btf.h                                   | 2 ++
> >  kernel/cgroup/rstat.c                                 | 9 +++------
> >  net/socket.c                                          | 8 ++------
> >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 6 ++----
> >  4 files changed, 9 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index dc5ce962f600..59d404e22814 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -92,6 +92,8 @@
> >                         "Global kfuncs as their definitions will be in =
BTF")
> >
> >  #define __bpf_kfunc_end_defs() __diag_pop()
> > +#define __bpf_hook_start() __bpf_kfunc_start_defs()
> > +#define __bpf_hook_end() __bpf_kfunc_end_defs()
> >
> >  /*
> >   * Return the name of the passed struct, if exists, or halt the build =
if for
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index d80d7a608141..c0adb7254b45 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -156,19 +156,16 @@ static struct cgroup *cgroup_rstat_cpu_pop_update=
d(struct cgroup *pos,
> >   * optimize away the callsite. Therefore, __weak is needed to ensure t=
hat the
> >   * call is still emitted, by telling the compiler that we don't know w=
hat the
> >   * function might eventually be.
> > - *
> > - * __diag_* below are needed to dismiss the missing prototype warning.
> >   */
> > -__diag_push();
> > -__diag_ignore_all("-Wmissing-prototypes",
> > -               "kfuncs which will be used in BPF programs");
> > +
> > +__bpf_hook_start();
> >
> >  __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
> >                                    struct cgroup *parent, int cpu)
> >  {
> >  }
> >
> > -__diag_pop();
> > +__bpf_hook_end();
> >
> >  /* see cgroup_rstat_flush() */
> >  static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
> > diff --git a/net/socket.c b/net/socket.c
> > index c4a6f5532955..cd4d9ae2144f 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -1685,20 +1685,16 @@ struct file *__sys_socket_file(int family, int =
type, int protocol)
> >   *   Therefore, __weak is needed to ensure that the call is still
> >   *   emitted, by telling the compiler that we don't know what the
> >   *   function might eventually be.
> > - *
> > - *   __diag_* below are needed to dismiss the missing prototype warnin=
g.
> >   */
> >
> > -__diag_push();
> > -__diag_ignore_all("-Wmissing-prototypes",
> > -               "A fmod_ret entry point for BPF programs");
> > +__bpf_hook_start();
> >
> >  __weak noinline int update_socket_protocol(int family, int type, int p=
rotocol)
> >  {
> >       return protocol;
> >  }
> >
> > -__diag_pop();
> > +__bpf_hook_end();
> >
> >  int __sys_socket(int family, int type, int protocol)
> >  {
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/to=
ols/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index a5e246f7b202..91907b321f91 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -39,9 +39,7 @@ struct bpf_testmod_struct_arg_4 {
> >       int b;
> >  };
> >
> > -__diag_push();
> > -__diag_ignore_all("-Wmissing-prototypes",
> > -               "Global functions as their definitions will be in bpf_t=
estmod.ko BTF");
> > +__bpf_hook_start();
> >
> >  noinline int
> >  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b=
, int c) {
> > @@ -335,7 +333,7 @@ noinline int bpf_fentry_shadow_test(int a)
> >  }
> >  EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
> >
> > -__diag_pop();
> > +__bpf_hook_end();
> >
> >  static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init =
=3D {
> >       .attr =3D { .name =3D "bpf_testmod", .mode =3D 0666, },
> > --
> > 2.34.1
> >
> >



--=20
Regards
Yafang

