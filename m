Return-Path: <bpf+bounces-9033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E745E78E7D1
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0509A1C209E7
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 08:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337586FCE;
	Thu, 31 Aug 2023 08:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E272733D7
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 08:23:32 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1120EE
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 01:23:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so60476666b.0
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693470209; x=1694075009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sGhVjICNp2r7nAxj/sJDaszyYlfOjqPg0f6TjFt1SNs=;
        b=QNsLMU4dtt8h5KtLUVaGyn7waQ4n6YkrvQ7lMDxFnEYAvL85WJ+wkwcOVVU5mOO4zh
         Kjd7RiJPt6P2plQaaCnQ2mn5E4nqXiycfhglL+dFLAWEP/lRsHOvjro+HgtF1br6N50M
         emeg4y6Ran6NgHzyz6mYpKFFqL1tL4RoDU4nJuntpDcW5LdIwhQD8wJVNMAaIk6FaWJv
         19SSWA1zX/Ia9a8CM+W0VjxJ4Iws4LceAtUX0ZX6kwyZzCzJfVOFdmEpAEa1rFmRgkQc
         2Q0ng9IgH1d6Tj0WJpZ2GElWwgCGFSWKpzFN7bZJ8b0HBMM1o3uY3G3z3h4pHK8zbqX4
         X81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470209; x=1694075009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGhVjICNp2r7nAxj/sJDaszyYlfOjqPg0f6TjFt1SNs=;
        b=A8h2JTDLQTd4pEmsvpvuIqNgj4oM63QqOjDxbcOomWa9sXb7rTgspdecErbyanZdf9
         oQZnoGXjZaqg4SagoZmigJPE5L2OMDy+ZPIFl0lN91dzxUWoYrFETVQKUhFn0aa7E1Gm
         tA4ca0EEQw5NJCKIVUaeB0k7FNHmaZvIxVqgKYIJ1QYuJOyN2I+XtkSM/WZD5gRnTGIq
         MtCLQxmt6kHr4KURrhSy9pSqBRDuarPcFSXuekywDqjyr/MapFG2Rk01BP5azj8i2j7m
         E46IfI+zPKqYS1o2Ue6eotFUcxEE15GYHcXfzH0XCGnYzLhJW6JLWMKC23spjpyyQXGw
         YrWg==
X-Gm-Message-State: AOJu0Yzfpak/59u25chq3IeRQ3xbZBNsXXePKsQ/hgT13rZHKmpHhFkT
	GYO76JoGUuwKG9GsCz3OvLg=
X-Google-Smtp-Source: AGHT+IHIUWVRCR2oSM0XAqCwBu3/zExsCviINz4fuAgsOwXP5iXKQqMpEH/mmYpBzfq7CY6uLZInCQ==
X-Received: by 2002:a17:907:7610:b0:9a1:b84d:fa58 with SMTP id jx16-20020a170907761000b009a1b84dfa58mr3595616ejc.1.1693470209073;
        Thu, 31 Aug 2023 01:23:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009a5f7fb51d1sm489421ejw.40.2023.08.31.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:23:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 10:23:26 +0200
To: Song Liu <song@kernel.org>
Cc: yonghong.song@linux.dev, Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZPBN/ii7M1Y1JlS1@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <ZO9DvsaOImg4Dt5r@krava>
 <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
 <CAPhsuW4qdB1kQM_6gP9WCpymw15-1=gDFU1KApWzQ_A8oC7thA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4qdB1kQM_6gP9WCpymw15-1=gDFU1KApWzQ_A8oC7thA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 01:24:10AM -0400, Song Liu wrote:
> On Wed, Aug 30, 2023 at 6:17 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> >
> >
> >
> > On 8/30/23 9:27 AM, Jiri Olsa wrote:
> > > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > >> Recent commit [1] broken d_path test, because now filp_close is not
> > >> called directly from sys_close, but eventually later when the file
> > >> is finally released.
> > >>
> > >> I can't see any other solution than to hook filp_flush function and
> > >> that also means we need to add it to btf_allowlist_d_path list, so
> > >> it can use the d_path helper.
> > >>
> > >> But it's probably not very stable because filp_flush is static so it
> > >> could be potentially inlined.
> > >
> > > looks like llvm makes it inlined (from CI)
> > >
> > >    Error: #68/1 d_path/basic
> > >    libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3
> > >
> > > jirka
> > >
> > >>
> > >> Also if we'd keep the current filp_close hook and find a way how to 'wait'
> > >> for it to be called so user space can go with checks, then it looks
> > >> like d_path might not work properly when the task is no longer around.
> > >>
> > >> thoughts?
> >
> > Jiri,
> >
> > The following patch works fine for me:
> >
> > $ git diff
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a7264b2c17ad..fdeec712338f 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
> >   BTF_ID(func, dentry_open)
> >   BTF_ID(func, vfs_getattr)
> >   BTF_ID(func, filp_close)
> > +BTF_ID(func, __fput_sync)
> >   BTF_SET_END(btf_allowlist_d_path)
> >
> >   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> > diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c
> > b/tools/testing/selftests/bpf/progs/test_d_path.c
> > index 84e1f883f97b..672897197c2a 100644
> > --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> > +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> > @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct
> > kstat *stat,
> >          return 0;
> >   }
> >
> > -SEC("fentry/filp_close")
> > -int BPF_PROG(prog_close, struct file *file, void *id)
> > +SEC("fentry/__fput_sync")
> > +int BPF_PROG(prog_close, struct file *file)
> >   {
> >          pid_t pid = bpf_get_current_pid_tgid() >> 32;
> >          __u32 cnt = cnt_close;
> 
> Yeah, I guess this is the easiest fix at the moment.
> 
> Related, shall we have resolve_btfids fail for missing ID? Something
> like:
> 
> diff --git i/scripts/link-vmlinux.sh w/scripts/link-vmlinux.sh
> index a432b171be82..9a194152da49 100755
> --- i/scripts/link-vmlinux.sh
> +++ w/scripts/link-vmlinux.sh
> @@ -274,7 +274,10 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
>  # fill in BTF IDs
>  if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
>         info BTFIDS vmlinux
> -       ${RESOLVE_BTFIDS} vmlinux
> +       if ! ${RESOLVE_BTFIDS} vmlinux ; then
> +               echo >&2 Failed to resolve BTF IDs
> +               exit 1
> +       fi

IIUC link-vmlinux.sh will fail when ${RESOLVE_BTFIDS} returns != 0,
and now the unresolved symbol is just a warning

we used to have that but we decided to just warn:
  5aad03685185 tools/resolve_btfids: Emit warnings and patch zero id for missing symbols

jirka

