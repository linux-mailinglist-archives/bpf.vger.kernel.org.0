Return-Path: <bpf+bounces-12519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47BC7CD56D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C21281B3F
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A13A1171E;
	Wed, 18 Oct 2023 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6SeqXZr"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F131F7495;
	Wed, 18 Oct 2023 07:21:58 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152CC6;
	Wed, 18 Oct 2023 00:21:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso6747242e87.1;
        Wed, 18 Oct 2023 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697613714; x=1698218514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6G8urhdBc1eZTqmtV0ApQqIzJAH2N7GQh3AvU6FGmiw=;
        b=e6SeqXZrz9v7qVp6ReTxXfPsBGf4xrQy0O/HdJNyCCj/QE1cYz6mXDs2sBo7jp5YeN
         FaBQZYMFaxCb7LAUJxOLiu7yvTKzbwDqzlg/ygZdTzzPVseyasQS3PjZkuhXEJ0yO9Js
         3SUR5TI4D3OAFEdvVJbdSualXwJ3Xk9E7VCxtByhBlLm57aQ8hc/8TH7jLLD6qHD9FZ7
         WVIOswFvzHos2RlAVzC/X9OcC6/YFHAXlpQ+1xlczb26tEx95gzXZ+9TR+9UgeRfFKC6
         XSdjOWEAMoA3qdU5ILycikjvWTt0lo2RtGXiicNGOQc9Py5sTbDjXgOzTXLVSDYjzC4I
         yHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697613714; x=1698218514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6G8urhdBc1eZTqmtV0ApQqIzJAH2N7GQh3AvU6FGmiw=;
        b=d8r1O9O5upHxL9cNTujcDc0ZFd9Mx1fIcuiMkNi7r8DLICtCQDlEYFixVw6PRkN5p/
         7kDjdxqOsJs6z+ak6stfQ0Dj0fcmnpjhXpy7+v4to73H50Cn+ntVitRG+aKwM6tKOnha
         GP1H+AWHjeE2FzCPLRod9PvGpKL9i4b4yXknbUlLQPFHpSXFODGGh07ELn6IWrIFOLpk
         5WnA258vSndAnA35diwdA76sLSbsa3CMWgH03LwdJORWPzGFarWEyYwWHUFPwTo4hnWb
         i4gm7zzngj0uTG1/lc/w+zo8saNQW+M6Bka0elMy/BYUbK2t/V3fK11FJ4WALA6BWv0t
         Msog==
X-Gm-Message-State: AOJu0YwNxZZWZ2iWij/SwuJJnINkmvxqDhAR190YVTxvLBeGbEvmdCQl
	jQ/GUsqHd9re4MCzP0T4IBWmiF4P4W02Jg==
X-Google-Smtp-Source: AGHT+IFoonVRP81816NJAlLxAEodcFQZefwPN2L3xJAVPhzMjlSX0hk88mhFbgZ2iQuyX6Zd7Uv+gQ==
X-Received: by 2002:a05:6512:313a:b0:503:364d:b93d with SMTP id p26-20020a056512313a00b00503364db93dmr3529129lfd.20.1697613713890;
        Wed, 18 Oct 2023 00:21:53 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v23-20020a056402175700b0053dd8898f75sm2289694edx.81.2023.10.18.00.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 00:21:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 18 Oct 2023 09:21:51 +0200
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
Message-ID: <ZS+Hj3aDWoCV/ckr@krava>
References: <20231008212251.236023-1-jolsa@kernel.org>
 <20231008212251.236023-2-jolsa@kernel.org>
 <CAM9d7cjYCrTkOTOmBHry-95nivmkGv1g0wp=+TSA0xPXJW_QvQ@mail.gmail.com>
 <ZSjlk99UOV2tTMWO@krava>
 <CAM9d7cjqvEs6262GfuF18mtFsWEznqNOWP_NqZN99Ys3MxCXqg@mail.gmail.com>
 <ZS5JHuwxL200M09H@krava>
 <CAM9d7chq125TOtnWFVKUC6PwRJqmXwNbfs7Dhm_04B3ZbA4jdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chq125TOtnWFVKUC6PwRJqmXwNbfs7Dhm_04B3ZbA4jdw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:16:28PM -0700, Namhyung Kim wrote:
> On Tue, Oct 17, 2023 at 1:43 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 06:36:10PM -0700, Namhyung Kim wrote:
> > > On Thu, Oct 12, 2023 at 11:37 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Thu, Oct 12, 2023 at 08:57:33PM -0700, Namhyung Kim wrote:
> > > > > Hi Jiri,
> > > > >
> > > > > On Sun, Oct 8, 2023 at 2:23 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > >
> > > > > > As Dmitry described in [1] changelog the current way of detecting
> > > > > > -s option is broken for new make.
> > > > >
> > > > > I'm not sure what -s option does for perf (at least).
> > > > > It doesn't seem much different whether I give it or not.
> > > > > Am I missing something?
> > > >
> > > > what's your make version? the wrong output is visible when running
> > > > with make version > 4.4 .. basicaly the -s is wrongly detected and
> > > > you either get no output at all from some builds or overly verbose
> > > > output
> > > >
> > > > it's mentioned in the [1] commit changelog, I can put it to the
> > > > changelog in new version
> > >
> > > IIUC it's about detecting `make -s` properly and not being confused
> > > by `make a=s` or something.  I'm not objecting on it but I don't see
> > > what `make -s` does actually.
> >
> > so the tools/build/Makefile.build and tools/scripts/Makefile.include detect
> > make -s option, which puts make into silent mode, so both makefiles switch
> > off the output by setting quiet=silent_ or silent=1
> >
> > the problem is that the detection of make -s option changed in make > 4.4
> > and current code could be tricked to switch to silent mode just by having
> > 's' persent on the command line, like with 'a=s'
> 
> I think our talk is circulating :-).  Anyway I'm ok with the change, so

:) ok, thanks

> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Which tree do you want to route it?

I think perf tree is the best one to route it

thanks,
jirka

