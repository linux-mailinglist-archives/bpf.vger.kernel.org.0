Return-Path: <bpf+bounces-6208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFF767080
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D271C218EA
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 15:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924FE6129;
	Fri, 28 Jul 2023 15:27:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA314005
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:27:09 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483DF1717
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:27:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40631c5b9e9so288311cf.1
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690558026; x=1691162826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2cHEglOBw7vOs0ctBUQxyK7WvVIZxui8AGCj214fFw=;
        b=e6XRIlLbdnBV3L+drIGrJ9hpPuszKL9KcdkNU3ekaiyj9oPIi424yCtahEr5IejeLS
         DVaJsKY6P2gQinDqRDKpkG2Cqzp2iZRE+SuDVrql/sUVH/V6fLH1tcS6jVzZSIYiUExw
         4mjNGLaKuaNSZpM9kj6StV2PQjstWNDxKKSjF++SSDOHr9RgtdhJON6K/z0E0sdf+HIw
         GcV0Zs60/0lvk9ceXcscQ7QwYgzn3piuNUGWX3RqXqTt0Bx+NowyQrbj+pniVwxrEnPB
         eG6jturlsiIsowf+LA6PWNH3FuS9c7Kix3RXflkIjjNKYHtE+5Jk+A2pw/05jXC99LK1
         QPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558026; x=1691162826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2cHEglOBw7vOs0ctBUQxyK7WvVIZxui8AGCj214fFw=;
        b=aa35PqsCSQlqrKil9IioujFfjJDp9jiVcbkiFxVBvouRvQfXqTzgdWLOYm/z6s1WjW
         m407cJ5yaVUKvp8D1p2uEuyZD5Ktz44ACSzQPOD9fXEDrlKc+SeEzmYq3vpv6oTmVzgH
         MdWB8zaMmODNMe+QoGuqHhQfuMaWG3u00aGdPmkd4VFHPUl1fDXs8oFwihz6LSa5ui+0
         kL8R3ychMSxztZIhyd+xsP9hQBamnKZ7uGHOhfy8n//UK7lVkbtZR37aNPQWfddQJbi6
         PSRytT65utn5Ufn1U5n20vGAMCl5MzDbESz39CIq5pKJ6WjkaaVb3X4lUN3VIuuWO7cR
         qKIg==
X-Gm-Message-State: ABy/qLZR1amX9EBdD7USbVDVTQK23kA6/wb/d8xhwscP+hhDaFnGmrdK
	o1dn47vHORkncH6PtUyseWd3eR+PLNQ2JZYiKvWXNg==
X-Google-Smtp-Source: APBJJlHIpT7XpTvB/yptY7dE3r/zPa8AQ/d9BXKIIJ1YOjIrDkWpf9UIHP7aBlLDk/kRbpYfjgdYrYdtNRjivLcW300=
X-Received: by 2002:a05:622a:448:b0:3f8:5b2:aef0 with SMTP id
 o8-20020a05622a044800b003f805b2aef0mr297197qtx.24.1690558026249; Fri, 28 Jul
 2023 08:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728064917.767761-1-irogers@google.com> <20230728064917.767761-5-irogers@google.com>
 <a8833945-3f0a-7651-39ff-a01e7edc2b3a@arm.com> <ZMPJym7DnCkFH7aA@kernel.org> <ZMPKekDl+g5PeiH8@kernel.org>
In-Reply-To: <ZMPKekDl+g5PeiH8@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Jul 2023 08:26:54 -0700
Message-ID: <CAP-5=fX2LOdd_34ysAYYB5zq5tr7dMje35Nw6hrLXTPLsOHoaw@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf build: Disable fewer flex warnings
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Gaosheng Cui <cuigaosheng1@huawei.com>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 7:02=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jul 28, 2023 at 10:59:38AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Jul 28, 2023 at 09:50:59AM +0100, James Clark escreveu:
> > >
> > >
> > > On 28/07/2023 07:49, Ian Rogers wrote:
> > > > If flex is version 2.6.4, reduce the number of flex C warnings
> > > > disabled. Earlier flex versions have all C warnings disabled.
> > >
> > > Hi Ian,
> > >
> > > I get a build error with either this one or the bison warning change:
> > >
> > >   $ make LLVM=3D1 -C tools/perf NO_BPF_SKEL=3D1 DEBUG=3D1
> > >
> > >   util/pmu-bison.c:855:9: error: variable 'perf_pmu_nerrs' set but no=
t
> > > used [-Werror,-Wunused-but-set-variable]
> > >     int yynerrs =3D 0;
> > >
> > > I tried a clean build which normally fixes these kind of bison errors=
.
> > > Let me know if you need any version info.
> >
> > Trying to build it with the command line above I get:
> >
> >   CC      util/expr.o
> >   CC      util/parse-events.o
> >   CC      util/parse-events-flex.o
> > util/parse-events-flex.c:7503:13: error: misleading indentation; statem=
ent is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
> >             if ( ! yyg->yy_state_buf )
> >             ^
> > util/parse-events-flex.c:7501:9: note: previous statement is here
> >         if ( ! yyg->yy_state_buf )
> >         ^
>
> I added this to the patch to get it moving:
>
> make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> =E2=AC=A2[acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 32239c4b0393c319..afa93eff495811cf 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -281,7 +281,7 @@ $(OUTPUT)util/bpf-filter-bison.c $(OUTPUT)util/bpf-fi=
lter-bison.h: util/bpf-filt
>
>  FLEX_GE_264 :=3D $(shell expr $(shell $(FLEX) --version | sed -e  's/fle=
x \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\=3D 264)
>  ifeq ($(FLEX_GE_264),1)
> -  flex_flags :=3D -Wno-redundant-decls -Wno-switch-default -Wno-unused-f=
unction
> +  flex_flags :=3D -Wno-redundant-decls -Wno-switch-default -Wno-unused-f=
unction -Wno-misleading-indentation
>  else
>    flex_flags :=3D -w
>  endif
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
>
> > 1 error generated.
> > make[4]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:97: util/parse-events-flex.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >   LD      util/scripting-engines/perf-in.o
> > make[3]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.b=
uild:140: util] Error 2
> > make[2]: *** [Makefile.perf:682: perf-in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC      pmu-events/pmu-events.o
> >   LD      pmu-events/pmu-events-in.o
> > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> >
> > =E2=AC=A2[acme@toolbox perf-tools-next]$ clang --version
> > clang version 14.0.5 (Fedora 14.0.5-2.fc36)
> > Target: x86_64-redhat-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> > =E2=AC=A2[acme@toolbox perf-tools-next]$

Thanks James/Arnaldo, I was trying to be aggressive in having more
flags, but it seems too aggressive. We should probably bring back the
logic to make this flag only added if it is supported:
  CC_HASNT_MISLEADING_INDENTATION :=3D $(shell echo "int main(void) {
return 0 }" | $(CC) -Werror -Wno-misleading-indentation -o /dev/null
-xc - 2>&1 | grep -q -- -Wno-misleading-indentation ; echo $$?)
  ifeq ($(CC_HASNT_MISLEADING_INDENTATION), 1)
    flex_flags +=3D -Wno-misleading-indentation
  endif
Arnaldo, is the misleading indentation in the bison generated code or
something copy-pasted from the parse-events.l ? If the latter we may
be able to fix the .l file to keep the warning.

Thanks,
Ian

> --
>
> - Arnaldo

