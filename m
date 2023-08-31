Return-Path: <bpf+bounces-9031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A21278E767
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D421C209CE
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8916D1B;
	Thu, 31 Aug 2023 07:52:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C86FA1
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:52:45 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35E1A4
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:52:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so582053a12.2
        for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693468362; x=1694073162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiz38p9J3XUNLntThmMZ3XRHG+zoOU+W24goti/33dQ=;
        b=CesRrJgf050QhgWRPZKLZt9NRKni9+AtdkKTNz93MBX3UAMCWe4GFLTcEauI4qRKQq
         sJ7p/Qa4xHEqTk2y5f3CTyRuOlmtwHy0+6oUQ5/0ANI0WJIsJ+5sPpT/xkUO6AxsM/gt
         4e1Iv9eONewgpt6CmztWFzwAVHrEY4A+eXf1ijNGHODRCkZtJegXT+6Cd5HOIYA7HP5f
         2CR4WFIMj4nv0bOJ2OVtjBpfp6wNkHy21tkn4fo4AkQyIC/FbQtTIjC0Qh1SNtYvhqUX
         HxPMvPfUzpw/jpHhW5YFD1Z+4Tifqvs25+YbeneYJRrDH39k/pqI7Iy1ER4q6DOSZrrn
         qk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693468362; x=1694073162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiz38p9J3XUNLntThmMZ3XRHG+zoOU+W24goti/33dQ=;
        b=lOfEFKTRfDEBkMEXOP9u/oax/EuJdkiDrgohPBmsT1vqM6pqnyYRaHgPYVnFLQK8So
         HvrhzRDp0ASmVtAcEKRGjHa0rAcZ5GzsMaNbj3zlS15nDgZq1CxkOG5lktDKpKqPO4Hx
         dzPVyqI5c/MAOMlwqDmY1M+pHvoMQdw1Y5uws4JAXot0H0nWoAMCxUBBSZsyEOqaPizE
         EFs/9vO3jN+tdZNeVEVlNh0SnsFcSzg6hGgIuFHd+uzkuhVMuvV7Rb57rbtlB8Vy0QSy
         QVOeR3fyQd6GzsO6a/X2+BX9C1O8dVkbQkc53no929vLKDrHH1271dLYf7HMhPQVjSQw
         +axQ==
X-Gm-Message-State: AOJu0YwDin30GFSBjnulsxXU9Fk5BTCYc8iJ/fxoWv0yr0xvB68qUFCh
	sN9Zk2d59CM/fYfz/3SFcnM=
X-Google-Smtp-Source: AGHT+IGTsO+VQCKF6PHECtoxvXSQUISDvkNY47KYZ3HAGKTldcuCOW6X+7aOlXWhx/ACEd9MdAz4+w==
X-Received: by 2002:a17:906:51d1:b0:9a1:f46c:ffc5 with SMTP id v17-20020a17090651d100b009a1f46cffc5mr4026755ejk.41.1693468361842;
        Thu, 31 Aug 2023 00:52:41 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id jw26-20020a17090776ba00b00982a92a849asm461167ejc.91.2023.08.31.00.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 00:52:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 09:52:38 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Hou Tao <houtao1@huawei.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
Message-ID: <ZPBGxqFL3LdJ87dV@krava>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <ZO9DvsaOImg4Dt5r@krava>
 <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 06:11:52PM -0400, Yonghong Song wrote:
> 
> 
> On 8/30/23 9:27 AM, Jiri Olsa wrote:
> > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> > > Recent commit [1] broken d_path test, because now filp_close is not
> > > called directly from sys_close, but eventually later when the file
> > > is finally released.
> > > 
> > > I can't see any other solution than to hook filp_flush function and
> > > that also means we need to add it to btf_allowlist_d_path list, so
> > > it can use the d_path helper.
> > > 
> > > But it's probably not very stable because filp_flush is static so it
> > > could be potentially inlined.
> > 
> > looks like llvm makes it inlined (from CI)
> > 
> >    Error: #68/1 d_path/basic
> >    libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3
> > 
> > jirka
> > 
> > > 
> > > Also if we'd keep the current filp_close hook and find a way how to 'wait'
> > > for it to be called so user space can go with checks, then it looks
> > > like d_path might not work properly when the task is no longer around.
> > > 
> > > thoughts?
> 
> Jiri,
> 
> The following patch works fine for me:
> 
> $ git diff
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..fdeec712338f 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, __fput_sync)

hum right, that should work.. there are several callers of that,
but AFAICT they all seem ok (not holding mount_lock or rename_lock)
to run d_path helper

I'll send patch with the change

thanks,
jirka


>  BTF_SET_END(btf_allowlist_d_path)
> 
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c
> b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..672897197c2a 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat
> *stat,
>         return 0;
>  }
> 
> -SEC("fentry/filp_close")
> -int BPF_PROG(prog_close, struct file *file, void *id)
> +SEC("fentry/__fput_sync")
> +int BPF_PROG(prog_close, struct file *file)
>  {
>         pid_t pid = bpf_get_current_pid_tgid() >> 32;
>         __u32 cnt = cnt_close;
> 
> > > jirka
> > > 
> > > 
> > > [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> > > ---
> > >   kernel/trace/bpf_trace.c                        | 1 +
> > >   tools/testing/selftests/bpf/progs/test_d_path.c | 4 ++--
> > >   2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index a7264b2c17ad..c829e24af246 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
> > >   BTF_ID(func, dentry_open)
> > >   BTF_ID(func, vfs_getattr)
> > >   BTF_ID(func, filp_close)
> > > +BTF_ID(func, filp_flush)
> > >   BTF_SET_END(btf_allowlist_d_path)
> > >   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> > > diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> > > index 84e1f883f97b..3467d1b8098c 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> > > @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
> > >   	return 0;
> > >   }
> > > -SEC("fentry/filp_close")
> > > -int BPF_PROG(prog_close, struct file *file, void *id)
> > > +SEC("fentry/filp_flush")
> > > +int BPF_PROG(prog_close, struct file *file)
> > >   {
> > >   	pid_t pid = bpf_get_current_pid_tgid() >> 32;
> > >   	__u32 cnt = cnt_close;
> > > -- 
> > > 2.41.0
> > > 
> > 

