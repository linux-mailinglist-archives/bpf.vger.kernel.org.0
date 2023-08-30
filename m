Return-Path: <bpf+bounces-8987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E678D623
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553A71C20342
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA263AB;
	Wed, 30 Aug 2023 13:27:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4C538A
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 13:27:32 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB6137
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:27:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso7108155a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402050; x=1694006850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjWlxw8p+B9MpyoOy1Jyhj/xK2ehhjkLqxLOyKeNY1A=;
        b=YiSFRBLwIpIzIbpdy4cbSwwjBUWxsAfqFmm97bgCgfj0MIdiCNmbNutDcs/6M4p2qz
         1wIR7GLY3hZyRKF4/HhKnPyHBWBiIzJZiXdhJwLHsOtZOHgicW2ZzWdYJiaxSAU9r/2H
         QOidDgUm9bcTSvz98wf/rAP2EslEJpNGaSq668AV79J/y1ozBmczx/lSsm7ehVdYhmyO
         EtUgTQBHCAI7vwtM2tfkAuOKwKk6ZSeOZDksxDeAJ+6gYIyNhJjyPNZ0S1DUuE2g39ny
         IaHfoEWJr9jmee1w3uM/rTb3KP2KPXjwrQTcH8kqpCLHcyCtY9Pw5NBCnasvxR2Z0Ei7
         y1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402050; x=1694006850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjWlxw8p+B9MpyoOy1Jyhj/xK2ehhjkLqxLOyKeNY1A=;
        b=g9oTrhVm+xorzXQRjHRASaam/o9C6hJKgi79w6NASJF8Y5kxYLbwQmov76rdiGuynX
         lNa7B+yyVVSrRIoAERcBh5t/c1xlzzKvC72zstA1543Kg68D5S4pTP6uVkyNJs8EiFgn
         jTgOvYUvt+4Gnavyw1DPVjbVB0uPlUbRMzW8DA9JGhzw6ThmOZoltoOonfuk00Br4ZXD
         DNDfIUBY8y1wppxagXDyhIfriN+NY31jzYV/stS32MVJWWw6voEPvuu7R8ehGLTDA2v4
         Q7mHYauQj3ibTXyspckHH1V6bFtgALqptdOzO3guobsWDOSKZfnlAMq/je3oEgJs33Jw
         jDrQ==
X-Gm-Message-State: AOJu0YyDtHVqYURudxEl8srupP/Q1P0w0hdX7O8skui8GDj184hHvumr
	68Gy/CeuAAN2JZDTA+DVIaA=
X-Google-Smtp-Source: AGHT+IG+qBpxkqQYFYFR9JP421ndoqbSTlwjwensyycHKWiw93J4TBvEBgUbds28yNuJoMvg0WoY0w==
X-Received: by 2002:a17:906:3287:b0:9a1:ca55:b668 with SMTP id 7-20020a170906328700b009a1ca55b668mr1652947ejw.59.1693402049362;
        Wed, 30 Aug 2023 06:27:29 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id k25-20020a170906129900b0099caf5bed64sm7277247ejb.57.2023.08.30.06.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:27:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Aug 2023 15:27:26 +0200
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZO9DvsaOImg4Dt5r@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830093502.1436694-1-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> Recent commit [1] broken d_path test, because now filp_close is not
> called directly from sys_close, but eventually later when the file
> is finally released.
> 
> I can't see any other solution than to hook filp_flush function and
> that also means we need to add it to btf_allowlist_d_path list, so
> it can use the d_path helper.
> 
> But it's probably not very stable because filp_flush is static so it
> could be potentially inlined.

looks like llvm makes it inlined (from CI)

  Error: #68/1 d_path/basic
  libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3

jirka

> 
> Also if we'd keep the current filp_close hook and find a way how to 'wait'
> for it to be called so user space can go with checks, then it looks
> like d_path might not work properly when the task is no longer around.
> 
> thoughts?
> jirka
> 
> 
> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> ---
>  kernel/trace/bpf_trace.c                        | 1 +
>  tools/testing/selftests/bpf/progs/test_d_path.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..c829e24af246 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, filp_flush)
>  BTF_SET_END(btf_allowlist_d_path)
>  
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..3467d1b8098c 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>  	return 0;
>  }
>  
> -SEC("fentry/filp_close")
> -int BPF_PROG(prog_close, struct file *file, void *id)
> +SEC("fentry/filp_flush")
> +int BPF_PROG(prog_close, struct file *file)
>  {
>  	pid_t pid = bpf_get_current_pid_tgid() >> 32;
>  	__u32 cnt = cnt_close;
> -- 
> 2.41.0
> 

