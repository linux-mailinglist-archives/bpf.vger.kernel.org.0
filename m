Return-Path: <bpf+bounces-9237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD67920AF
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 09:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280D9280EFF
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 07:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED7ECE;
	Tue,  5 Sep 2023 07:20:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6CA38
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 07:20:26 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869312A
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 00:20:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so2914627a12.0
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693898423; x=1694503223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XSFm3/urpcj8vqtLaEyv7z3A0/BbGmrc1WJ35Cy/pec=;
        b=kNS6IeOlO9eB/vSlhkejg2/1wDc6mMGneh7bUrTOMlDzu6CxT/SQ/EnvpfhttEwt5W
         kuj5fzBbDtcCLdySpZ/Gphm6q0POmn08BF7ufbolT3sGrXC0SpFEcccexwDXamooSPO9
         AKyZ2D82lZJFhOMNuTuzypxK6h24e+9Ks6gO4izFbjaaoyayJdOyc2DWBstP7QCJ3ftq
         hFt8rsLhv9lmkyvHz2NqXAG6S7zQSt/LtPPKGM2+u5xH8f232kDnXVJ9x0ulLI0/X1JN
         ZrATJA+IC+nbr9/e5oZx1cfIxBGOlVlh+hE1n9tnj4EPjbWwN/v9zpsHCHu65xDVbw5L
         i1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693898423; x=1694503223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSFm3/urpcj8vqtLaEyv7z3A0/BbGmrc1WJ35Cy/pec=;
        b=IDGvsA2TtzYiCWMYw+ND0Xb1QPBc5PqRYC/8dSoTJ5XGMswRwqe6yUhEZAiiHBQx4B
         y0v/F6vDRY0xd3k6A/IB4rWIPYcoPGI2gR2pUrV/jslY75SckP0FKvKthu078XJoyCTi
         Z0R36Kazc5gx1nUUPHDsn82H9ko1NyklWPYdQnpsQ92Cscwy+6sze2WVAuZuwQfLKieD
         xReSXYqwiaJN2aayVajXqCP7awGC4jyqA3k/4BjH2aGxlkB1Kc2g2GH7igdA5ZO19qHT
         KWnwJq0M36bUkcIYrOzoI+kHnuy3x3FBAo5+VYKgy6mz4zudgBWcWwgIc+gcQJyrbdl+
         rK2A==
X-Gm-Message-State: AOJu0YyLX9qxGNfa+XCf6G9jhNNCUJ9+5sFyotPLm/lxmtJqUcgW6YLH
	TRu/NlFNqaZ+L1/O98++qaw=
X-Google-Smtp-Source: AGHT+IHy+F3/pIMOGl9Gvz1a5xSwiA2FnQ7x2xVrvoSCDvJvSVJyIM3rosReycqNUeTssdxSyv8Ymw==
X-Received: by 2002:a17:906:5349:b0:9a6:1eab:9c84 with SMTP id j9-20020a170906534900b009a61eab9c84mr8153309ejo.9.1693898423410;
        Tue, 05 Sep 2023 00:20:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id pv9-20020a170907208900b00993470682e5sm7127714ejb.32.2023.09.05.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:20:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Sep 2023 09:20:20 +0200
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 00/12] bpf: Add missed stats for kprobes
Message-ID: <ZPbWtN77sKUTj8U6@krava>
References: <20230828075537.194192-1-jolsa@kernel.org>
 <85f528b3-f1bc-fdcf-d816-d2d20d7ce24f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f528b3-f1bc-fdcf-d816-d2d20d7ce24f@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 11:30:54AM +0800, Hou Tao wrote:
> Hi,
> 
> On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> > hi,
> > at the moment we can't retrieve the number of missed kprobe
> > executions and subsequent execution of BPF programs.
> >
> > This patchset adds:
> >   - counting of missed execution on attach layer for:
> >     . kprobes attached through perf link (kprobe/ftrace)
> >     . kprobes attached through kprobe.multi link (fprobe)
> >   - counting of recursion_misses for BPF kprobe programs
> 
> Because trace_call_bpf() is used for both kprobe and trace-point bpf
> program, so I think it is better to add one selftest for missed counter
> for trace-point program as well.

ok, will try to add some

thanks,
jirka

> >   - counting runtime stats (kernel.bpf_stats_enabled=1) for BPF programs
> >     executed through bpf_prog_run_array - kprobes, perf events, trace
> >     syscall probes
> >
> >
> > It's still technically possible to create kprobe without perf link (using
> > SET_BPF perf ioctl) in which case we don't have a way to retrieve the kprobe's
> > 'missed' count. However both libbpf and cilium/ebpf libraries use perf link
> > if it's available, and for old kernels without perf link support we can use
> > BPF program to retrieve the kprobe missed count.
> >
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   bpf/missed_stats
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > Jiri Olsa (12):
> >       bpf: Move update_prog_stats to syscall object
> >       bpf: Move bpf_prog_start_time to linux/filter.h
> >       bpf: Count stats for kprobe_multi programs
> >       bpf: Add missed value to kprobe_multi link info
> >       bpf: Add missed value to kprobe perf link info
> >       bpf: Count missed stats in trace_call_bpf
> >       bpf: Move bpf_prog_run_array down in the header file
> >       bpf: Count run stats in bpf_prog_run_array
> >       bpftool: Display missed count for kprobe_multi link
> >       bpftool: Display missed count for kprobe perf link
> >       selftests/bpf: Add test missed counts of perf event link kprobe
> >       elftests/bpf: Add test recursion stats of perf event link kprobe
> >
> >  include/linux/bpf.h                                         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
> >  include/linux/trace_events.h                                |   6 ++++--
> >  include/uapi/linux/bpf.h                                    |   2 ++
> >  kernel/bpf/syscall.c                                        |  36 +++++++++++++++++++++++++------
> >  kernel/bpf/trampoline.c                                     |  45 +++++----------------------------------
> >  kernel/trace/bpf_trace.c                                    |  17 ++++++++++++---
> >  kernel/trace/trace_kprobe.c                                 |   5 ++++-
> >  tools/bpf/bpftool/link.c                                    |   8 ++++++-
> >  tools/include/uapi/linux/bpf.h                              |   2 ++
> >  tools/testing/selftests/bpf/DENYLIST.aarch64                |   1 +
> >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       |   5 +++++
> >  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |   2 ++
> >  tools/testing/selftests/bpf/prog_tests/missed.c             |  97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/missed_kprobe.c           |  30 ++++++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c |  48 +++++++++++++++++++++++++++++++++++++++++
> >  15 files changed, 327 insertions(+), 83 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
> >
> > .
> 

