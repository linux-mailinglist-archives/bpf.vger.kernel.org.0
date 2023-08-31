Return-Path: <bpf+bounces-9025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE978E5A1
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C3B28122A
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5967F1861;
	Thu, 31 Aug 2023 05:24:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DA1846
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC057C433C7
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 05:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693459465;
	bh=feioVZnKBPcjrXP1rkr2QlMJ2zPqWMlprKytxA7GrWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b07VtRmT+0+LJhdb2aFGm7MhX6MQdbVd7M0mVuHFFbnB3RZoO8lD+p+lHxWL7lWkv
	 d9HoyiQ0W3w7KYk19NsUfQMAWnBtGNezKTzezxE3lwBDu/xYDFNqGAqFIfTsGYSN6Y
	 QfG6/Y/zuGmJgeOEAnx7h/kEL9m95GmjMgqC/P1GRyKMPAF33Yz3tnMRWfo5ICzL5m
	 VI2ni8CmrinGk2TTB9/PWYyIr6lR6e9Wphaj9LO4GbREN8W1zvmbrr7krWDq1QnpM5
	 zzHbOBGGrKI3wgCXSh1wkG+EWEQ0hsLD8IWUT1XluXZJyfiizX+/QWAZboSFQBhbdh
	 wEtBtpwWnTPjw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5007616b756so895314e87.3
        for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 22:24:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwiAr4HAp7GWvyVL42G6rqvIMruQE4hkMuZtTTKXburmD46GNI
	80H4NqHxFoMJy1mag1rbxwTMSbCbilztaXbkF74=
X-Google-Smtp-Source: AGHT+IHtNp5IivOeeed+v26MqcZ5k3RYwcndrb5W2VHIGpixL6pRT97GGY42n5Oz50uGR4lsN9Ua08N2bZ9e4MlKi1w=
X-Received: by 2002:a05:6512:31d2:b0:500:918c:d5a2 with SMTP id
 j18-20020a05651231d200b00500918cd5a2mr3460447lfe.16.1693459462925; Wed, 30
 Aug 2023 22:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830093502.1436694-1-jolsa@kernel.org> <ZO9DvsaOImg4Dt5r@krava>
 <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
In-Reply-To: <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
From: Song Liu <song@kernel.org>
Date: Thu, 31 Aug 2023 01:24:10 -0400
X-Gmail-Original-Message-ID: <CAPhsuW4qdB1kQM_6gP9WCpymw15-1=gDFU1KApWzQ_A8oC7thA@mail.gmail.com>
Message-ID: <CAPhsuW4qdB1kQM_6gP9WCpymw15-1=gDFU1KApWzQ_A8oC7thA@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
To: yonghong.song@linux.dev
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 6:17=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/30/23 9:27 AM, Jiri Olsa wrote:
> > On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
> >> Recent commit [1] broken d_path test, because now filp_close is not
> >> called directly from sys_close, but eventually later when the file
> >> is finally released.
> >>
> >> I can't see any other solution than to hook filp_flush function and
> >> that also means we need to add it to btf_allowlist_d_path list, so
> >> it can use the d_path helper.
> >>
> >> But it's probably not very stable because filp_flush is static so it
> >> could be potentially inlined.
> >
> > looks like llvm makes it inlined (from CI)
> >
> >    Error: #68/1 d_path/basic
> >    libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'fil=
p_flush': -3
> >
> > jirka
> >
> >>
> >> Also if we'd keep the current filp_close hook and find a way how to 'w=
ait'
> >> for it to be called so user space can go with checks, then it looks
> >> like d_path might not work properly when the task is no longer around.
> >>
> >> thoughts?
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
>   BTF_ID(func, dentry_open)
>   BTF_ID(func, vfs_getattr)
>   BTF_ID(func, filp_close)
> +BTF_ID(func, __fput_sync)
>   BTF_SET_END(btf_allowlist_d_path)
>
>   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c
> b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..672897197c2a 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct
> kstat *stat,
>          return 0;
>   }
>
> -SEC("fentry/filp_close")
> -int BPF_PROG(prog_close, struct file *file, void *id)
> +SEC("fentry/__fput_sync")
> +int BPF_PROG(prog_close, struct file *file)
>   {
>          pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
>          __u32 cnt =3D cnt_close;

Yeah, I guess this is the easiest fix at the moment.

Related, shall we have resolve_btfids fail for missing ID? Something
like:

diff --git i/scripts/link-vmlinux.sh w/scripts/link-vmlinux.sh
index a432b171be82..9a194152da49 100755
--- i/scripts/link-vmlinux.sh
+++ w/scripts/link-vmlinux.sh
@@ -274,7 +274,10 @@ vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_=
o}
 # fill in BTF IDs
 if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
        info BTFIDS vmlinux
-       ${RESOLVE_BTFIDS} vmlinux
+       if ! ${RESOLVE_BTFIDS} vmlinux ; then
+               echo >&2 Failed to resolve BTF IDs
+               exit 1
+       fi
 fi

 mksysmap vmlinux System.map ${kallsymso}
diff --git i/tools/bpf/resolve_btfids/main.c w/tools/bpf/resolve_btfids/mai=
n.c
index 27a23196d58e..2940fe004220 100644
--- i/tools/bpf/resolve_btfids/main.c
+++ w/tools/bpf/resolve_btfids/main.c
@@ -599,8 +599,10 @@ static int id_patch(struct object *obj, struct btf_id =
*id)
        int i;

        /* For set, set8, id->id may be 0 */
-       if (!id->id && !id->is_set && !id->is_set8)
-               pr_err("WARN: resolve_btfids: unresolved symbol %s\n",
id->name);
+       if (!id->id && !id->is_set && !id->is_set8) {
+               pr_err("FAILED resolve_btfids: unresolved symbol
%s\n", id->name);
+               return -1;
+       }

        for (i =3D 0; i < id->addr_cnt; i++) {
                unsigned long addr =3D id->addr[i];

Thanks,
Song

