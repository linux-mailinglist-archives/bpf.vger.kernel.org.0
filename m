Return-Path: <bpf+bounces-12394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E187CBDFB
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DFA1C20C46
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF33AC24;
	Tue, 17 Oct 2023 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmTOjFUp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E81F606;
	Tue, 17 Oct 2023 08:43:17 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE010B;
	Tue, 17 Oct 2023 01:43:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so869075766b.3;
        Tue, 17 Oct 2023 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697532193; x=1698136993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmXtbs5NMYB9LI1tgRNdArFkByrjFJziSGw8e2TFAUE=;
        b=VmTOjFUppIwvkllTbx70USk4Jmps2Y6qlL9tsd4Pf0th9y1bj8Si6OL8MYlFcmoEMO
         KV/JHIDCWXzt9GB84fUyehpxQpFIZ7ItxNAffv1LsBYb3mLXfXOeG+VefjrBHf73c4+W
         VrUD2ZkrO2O+8B0kpvPJuy7k3T1f/6liShbqHWM7NLPwkbpRP4BO1KEuz6XLQ1tdcD8m
         7hzOhdPIAQfZ7ZduMBQiTgov4fl0mliosig8zMgBLl9+rPklpgc0gpmYeesB+qdP8WDQ
         KIDlO6q6sSygj3rPsxewZj71yCiWwsp5aH4zmO6Mss82yN1LCTUzBuTYJLFDsqlRGDW5
         akDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532193; x=1698136993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmXtbs5NMYB9LI1tgRNdArFkByrjFJziSGw8e2TFAUE=;
        b=su6r2Bk+kbR2+TftjkC91i/RoqZMEJCZ2K4YxlA28/xEHlrb7DreHJTs4pfhCBNlgB
         xz0Weio65ckrElVTcaXrOZEr4HrhX6ydRQ7iLPfAH5K/UAOK8U6Xk6Bh40MjJRpGWxfh
         Z9XQePSWdL5oyvCDAr2WHVgJB7pwSDIuThMNgoiwoY4tU3xjs5Kj1MciTbJAob5RO+Ap
         Z3tw3K0XjObp4jLK3znptcMDmequMpeolGYWxModqhjRHB7BLBcPYq2LRkBfyWN0xKkO
         HFVsap56Q2QXPZOlDNketq+tg8GZFKS7PjvxiJIn8JJHsyGqyjqm9BtFZb8Y7rXLj5nm
         purA==
X-Gm-Message-State: AOJu0Yyvu0jRM4QJt7kB712T9Rsa2uTLlByWkVw3QmDyynqSeIHltS7R
	+V1x3n2BSCNqd2z228JkKCs=
X-Google-Smtp-Source: AGHT+IEsiJ4oh8KTCipzTc2zZVw60mM8/gBLn8pXmtCt6EQKwvBpf0pGtZIMEi3w5TJcACGwt0F2Kg==
X-Received: by 2002:a17:907:3e8c:b0:9ad:8aac:362b with SMTP id hs12-20020a1709073e8c00b009ad8aac362bmr1432783ejc.23.1697532192489;
        Tue, 17 Oct 2023 01:43:12 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090635ce00b009ae0042e48bsm803734ejb.5.2023.10.17.01.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:43:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Oct 2023 10:43:10 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Dmitry Goncharov <dgoncharov@users.sf.net>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Ian Rogers <irogers@google.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCHv2 1/2] tools/build: Fix -s detection code in
 tools/build/Makefile.build
Message-ID: <ZS5JHuwxL200M09H@krava>
References: <20231008212251.236023-1-jolsa@kernel.org>
 <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
 <ZSjlk99UOV2tTMWO@krava>
 <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 06:36:10PM -0700, Namhyung Kim wrote:
> On Thu, Oct 12, 2023 at 11:37 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> > > Hi Jiri,
> > >
> > > On Sun, Oct 8, 2023 at 2:23 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > As Dmitry described in [1] changelog the current way of detecting
> > > > -s option is broken for new make.
> > >
> > > I'm not sure what -s option does for perf (at least).
> > > It doesn't seem much different whether I give it or not.
> > > Am I missing something?
> >
> > what's your make version? the wrong output is visible when running
> > with make version > 4.4 .. basicaly the -s is wrongly detected and
> > you either get no output at all from some builds or overly verbose
> > output
> >
> > it's mentioned in the [1] commit changelog, I can put it to the
> > changelog in new version
> 
> IIUC it's about detecting `make -s` properly and not being confused
> by `make a=s` or something.  I'm not objecting on it but I don't see
> what `make -s` does actually.

so the tools/build/Makefile.build and tools/scripts/Makefile.include detect
make -s option, which puts make into silent mode, so both makefiles switch
off the output by setting quiet=silent_ or silent=1

the problem is that the detection of make -s option changed in make > 4.4
and current code could be tricked to switch to silent mode just by having
's' persent on the command line, like with 'a=s'

jirka

> 
> Anyway, my make version is 4.3.
> 
> Thanks,
> Namhyung

