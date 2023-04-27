Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A876F0EDD
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 01:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjD0X2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 19:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbjD0X2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 19:28:12 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411C272E
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 16:28:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b9a6869dd3cso2692445276.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682638090; x=1685230090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCNur8ye00lfwuEn8aqgDObynVvMHHHZO3F1ug6RXms=;
        b=eqilKu2foh+ZS+T8W9A4VyDLeS3SBrTOUZ7cfPK5BuHwK0nGmYOPYb6fNyc5YAwKug
         aeUV8N45wDdWNqp2/Xl0MtdYBeYVbhtBuuWI61df/RdGun32D1j087ODb5g1k1ILQApE
         8IploToxkcBFMGetLa4S0rmERG3UMbqGgMEsowdh+N08oUJILJCmWm55+SATGpnPDDvM
         DBpSZ/440VlaKOZo5ldDZ6bKsJWCyz8A5KP2TBYldtqf6Ycnvju20coHBfXLqPpc8efc
         KAdrwZa7/g0eDeD4CdGCoKVLc/51r0wgTjptUef74QTz3hzzKKHofjQSfg4A9SgMkxo3
         FH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638090; x=1685230090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCNur8ye00lfwuEn8aqgDObynVvMHHHZO3F1ug6RXms=;
        b=fnX+YyYC5aeUtIxkibAz9HadrE3SgoWxfhLxa7tnua8zlkfUP2WHZA9gv9nk6H2FSB
         FzXHCNAigR5W/1g12vf2OSNQOId5YrP+1qY22vd7qqklbK4qNgTzyW8JjCNpPtaH27kD
         17JkgCUSVilpDPZbvfa3+M6nchyQcunSBXfqZmpsxwW9hCm91rEzHjTRDoLWOnTplTGw
         iFuK383vc+ScBjxLnRCebX0gp0xmHY57ga9H1zOK6HFsOL960+xR3BDnS7z0erzC/Wds
         yC7Sfoq96udj7YXO0v1Pd0HnR8mHScmIe+Qh0vKG3Rve7bJ1gMFtDuZp/6y1eJwGU8gE
         ymCA==
X-Gm-Message-State: AC+VfDzvkUc7XVY7J/lo8gVG+ebAwll8gBUQMCqBS4in5FtxZfVYa93b
        jONQk+A0OJGzkIRlKeDjtCP6V0rs/p3PHOYKxEI=
X-Google-Smtp-Source: ACHHUZ7/D4mY0md+2Pdoms2gl7DWZzFxYpmvN+UrYuDuDdadu2RnJ2pFzjePhW75qScD53DXmfWkVrI7t1d6IdFOS4A=
X-Received: by 2002:a25:19d4:0:b0:b9a:7b56:bcb4 with SMTP id
 203-20020a2519d4000000b00b9a7b56bcb4mr2210008ybz.42.1682638090065; Thu, 27
 Apr 2023 16:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org> <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
 <CAM9d7ci3xAcnqdkpb-J4rv7yfiB2Trb-e2h7gfj6Wu5N_V7a-Q@mail.gmail.com>
 <CAEf4BzaZhjgPNaNH2yFxjZ-C+ZaSJRg9EWzOCcMOP-CV7kDHBA@mail.gmail.com>
 <ZEn/EOnsH2RP//24@google.com> <CAEf4BzZHS5NprN2ya03Re_1hvC0nNyz_qYEhbD=sGou+m=OWHw@mail.gmail.com>
In-Reply-To: <CAEf4BzZHS5NprN2ya03Re_1hvC0nNyz_qYEhbD=sGou+m=OWHw@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Thu, 27 Apr 2023 16:27:59 -0700
Message-ID: <CAM9d7chFp42ar3dMmhHxhHR=CVRg64cMvNQDE98M-EuRmU5EfQ@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 3:15=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> Ok, I didn't manage to force compiler to behave as long as
> `&rq_old->lock` pattern was used. So I went for a different approach.
> This works:

Thanks!  It works for me too!

Can I use this patch with your Co-developed-by tag ?

Thanks,
Namhyung


>
> $ git diff
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 8911e2a077d8..8d3cfbb3cc65 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -418,32 +418,32 @@ int contention_end(u64 *ctx)
>
>  extern struct rq runqueues __ksym;
>
> -struct rq__old {
> +struct rq___old {
>         raw_spinlock_t lock;
>  } __attribute__((preserve_access_index));
>
> -struct rq__new {
> +struct rq___new {
>         raw_spinlock_t __lock;
>  } __attribute__((preserve_access_index));
>
>  SEC("raw_tp/bpf_test_finish")
>  int BPF_PROG(collect_lock_syms)
>  {
> -       __u64 lock_addr;
> +       __u64 lock_addr, lock_off;
>         __u32 lock_flag;
>
> +       if (bpf_core_field_exists(struct rq___new, __lock))
> +               lock_off =3D offsetof(struct rq___new, __lock);
> +       else
> +               lock_off =3D offsetof(struct rq___old, lock);
> +
>         for (int i =3D 0; i < MAX_CPUS; i++) {
>                 struct rq *rq =3D bpf_per_cpu_ptr(&runqueues, i);
> -               struct rq__new *rq_new =3D (void *)rq;
> -               struct rq__old *rq_old =3D (void *)rq;
>
>                 if (rq =3D=3D NULL)
>                         break;
>
> -               if (bpf_core_field_exists(rq_new->__lock))
> -                       lock_addr =3D (__u64)&rq_new->__lock;
> -               else
> -                       lock_addr =3D (__u64)&rq_old->lock;
> +               lock_addr =3D (__u64)(void *)rq + lock_off;
>                 lock_flag =3D LOCK_CLASS_RQLOCK;
>                 bpf_map_update_elem(&lock_syms, &lock_addr,
> &lock_flag, BPF_ANY);
>         }
>
>
> > Thanks,
> > Namhyung
> >
> >
