Return-Path: <bpf+bounces-53252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E250A4F157
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 00:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AEB3AA334
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 23:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1E27817D;
	Tue,  4 Mar 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY+qot5n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCC1FAC4C;
	Tue,  4 Mar 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130393; cv=none; b=KxvyRRvWsBuGxG6VcW8BPkiSt7EGQPiYDBKIVzA5dz9yyvWHJBa6rkAUH2983Mtyof9UrsInREUhWl7CXErfWqcsPnuWM16vd/qPeIsIy9pRM5qHZ/d2REY2pw/vbS+AaOSj1+cE8kmO46NKUldUeMi6YdpGsDu0mzZpKCxfQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130393; c=relaxed/simple;
	bh=i8SL8gO+OIlTYJRgMlSgO0oRB4ZwIsNjVvyGrMEu5PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWbQh73zwySNUvBm13SzwdZfUDMCugBQWt1S0EVo2oxiXffyhBLzTwvJmN0y0msLVaKh737GRCfIHqXdPtNht5EpZrx50OtgeUws45CMTdhVhnmeIql87PjOGOWTUONLXSlPwlkUGW60vP3rpeCgQzSA9kjYWGcXKONeKE6jH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY+qot5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93F8C4CEE9;
	Tue,  4 Mar 2025 23:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741130393;
	bh=i8SL8gO+OIlTYJRgMlSgO0oRB4ZwIsNjVvyGrMEu5PU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AY+qot5nFtHrn4nfwbaT/9+XzyaPP3sz6wnmahpRr6nx4Lg4r8ULLdhC2pW7vPIKc
	 SAN5iKmwuY8Ehva6O/0G5T3Jmla2ulnwlznXlsE2ubnwa16pMxFurqwa+POlXenbLS
	 YGQetWtRCHyRo22oijRH+9yC+3o6sz+QaVORQn9awssYzCDw2HmgpF0Fd/kPqt5hiK
	 R7/CQCLhleU3NJ3Gz7XQF56QUqvbUrY4sKsGPFPyg5U1ICiGkNO1Uu4FwixN6AajBL
	 B3urex3lv4tzyqVTku8dJmOGZwp7XEGST+1c5nCTgAs0PAzIemkPbPR89RpIGY9L/a
	 xQfC5rzyBwUuA==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d2af701446so50769375ab.2;
        Tue, 04 Mar 2025 15:19:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUH1ZeXXnmLbbv6kRLBYy5u9G2a5Vw02YjDKLzX9e75W2QgmZryC/LdSBZD1kXpJBwKgtlZu2kWe8YDxsS3wUpHlsLilcMm@vger.kernel.org, AJvYcCUst5HlRkSFL9s/KF3oClPJhEgIK1rCvy2s54HxSLuWHdzmFxHokeuoehtmzDCzQHx8YzU=@vger.kernel.org, AJvYcCV6QXtGQmqPtqe1zLU60tWRRzNH30nJOvyaZCxh5uJCj0UY4sYDnk3/KHc3eFFwWBPETGmRJTZEVg==@vger.kernel.org, AJvYcCWY8aDyz/U/vgs1hRZcAHUyhy6Bz49ZWUbLWqFG0HYkwq9WZf4Xrvx8/BpjhOnUPv9cOaSN6GCc1beYWuPL@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqEfvpWU/vsA2C3jDKv2D7Jj6Ao9cfI/g51ow1VgwT/m3+5yj
	n/CnRl5+G3Ipus6pPERZNgVFyBKbZn3db4uRIbUkjP7l7bi4rD9LytCHVCSDjLl8lcjXB3VCuCb
	32d5lpkaa+TalHZDNMVwfvwyRF0Q=
X-Google-Smtp-Source: AGHT+IGms9dqXKMXqsx3hVWMrs+Z8rdj1LzypWR2n2n7rHwNxaraGVvP4jdONEO1NrkicQNJScsH92+aLsVP1+7xLc0=
X-Received: by 2002:a05:6e02:3f8a:b0:3d3:ce83:527c with SMTP id
 e9e14a558f8ab-3d42b879d19mr16194865ab.1.1741130392941; Tue, 04 Mar 2025
 15:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com> <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250304203123.3935371-3-bboscaccy@linux.microsoft.com>
From: Song Liu <song@kernel.org>
Date: Tue, 4 Mar 2025 15:19:41 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5HJuRYPucfvDbs25un7_D8JJnt=7zNUJ1utY3O_VMeSw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo9WUD2lq83UkjMIXC2XZlbrUncq1aeaThvdFPiq6BN9fGcI0gy7DMvJMs
Message-ID: <CAPhsuW5HJuRYPucfvDbs25un7_D8JJnt=7zNUJ1utY3O_VMeSw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:31=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> The security_bpf LSM hook now contains a boolean parameter specifying
> whether an invocation of the bpf syscall originated from within the
> kernel. Here, we update the function signature of relevant test
> programs to include that new parameter.
>
> Signed-off-by: Blaise Boscaccy bboscaccy@linux.microsoft.com
^^^ The email address is broken.

> ---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c           | 3 ++-
>  tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c | 6 +++---
>  tools/testing/selftests/bpf/progs/test_lookup_key.c         | 2 +-
>  tools/testing/selftests/bpf/progs/test_ptr_untrusted.c      | 2 +-
>  tools/testing/selftests/bpf/progs/test_task_under_cgroup.c  | 2 +-
>  tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c   | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)

It appears you missed a few of these?

tools/testing/selftests/bpf/progs/rcu_read_lock.c:SEC("?lsm.s/bpf")
tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm/bpf")
tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s/bpf=
")
tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("?lsm.s/bpf=
")
tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c:SEC("lsm.s/bpf"=
)
tools/testing/selftests/bpf/progs/test_libbpf_get_fd_by_id_opts.c:SEC("lsm/=
bpf_map")
tools/testing/selftests/bpf/progs/test_lookup_key.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/test_ptr_untrusted.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/test_task_under_cgroup.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_capable")
tools/testing/selftests/bpf/progs/token_lsm.c:SEC("lsm/bpf_token_cmd")
tools/testing/selftests/bpf/progs/verifier_global_subprogs.c:SEC("?lsm/bpf"=
)
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")
tools/testing/selftests/bpf/progs/verifier_ref_tracking.c:SEC("lsm.s/bpf")

>
> diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/te=
sting/selftests/bpf/progs/rcu_read_lock.c
> index ab3a532b7dd6d..f85d0e282f2ae 100644
> --- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> +++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
> @@ -242,7 +242,8 @@ int inproper_sleepable_helper(void *ctx)
>  }
>
>  SEC("?lsm.s/bpf")
> -int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, un=
signed int size)
> +int BPF_PROG(inproper_sleepable_kfunc, int cmd, union bpf_attr *attr, un=
signed int size,
> +            bool is_kernel)
>  {
>         struct bpf_key *bkey;
>
> diff --git a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c b=
/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> index 44628865fe1d4..0e741262138f2 100644
> --- a/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> +++ b/tools/testing/selftests/bpf/progs/test_cgroup1_hierarchy.c
> @@ -51,13 +51,13 @@ static int bpf_link_create_verify(int cmd)
>  }
>
>  SEC("lsm/bpf")
> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, =
bool is_kernel)
>  {
>         return bpf_link_create_verify(cmd);
>  }
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size=
)
> +int BPF_PROG(lsm_s_run, int cmd, union bpf_attr *attr, unsigned int size=
, bool is_kernel)
>  {
>         return bpf_link_create_verify(cmd);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c =
b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> index cd4d752bd089c..ce36a55ba5b8b 100644
> --- a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> +++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
> @@ -36,7 +36,7 @@ char _license[] SEC("license") =3D "GPL";
>
>  SEC("?lsm.s/bpf")
>  __failure __msg("cannot pass in dynptr at an offset=3D-8")
> -int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned i=
nt size)
> +int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool is_kernel)
>  {
>         unsigned long val;
>
> @@ -46,7 +46,7 @@ int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr =
*attr, unsigned int size)
>
>  SEC("?lsm.s/bpf")
>  __failure __msg("arg#0 expected pointer to stack or const struct bpf_dyn=
ptr")
> -int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size)
> +int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool is_kernel)
>  {
>         unsigned long val =3D 0;
>
> @@ -55,7 +55,7 @@ int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr =
*attr, unsigned int size)
>  }
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned i=
nt size)
> +int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned i=
nt size, bool is_kernel)
>  {
>         struct bpf_key *trusted_keyring;
>         struct bpf_dynptr ptr;
> diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools/=
testing/selftests/bpf/progs/test_lookup_key.c
> index c73776990ae30..c46077e01a4ca 100644
> --- a/tools/testing/selftests/bpf/progs/test_lookup_key.c
> +++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
> @@ -23,7 +23,7 @@ extern struct bpf_key *bpf_lookup_system_key(__u64 id) =
__ksym;
>  extern void bpf_key_put(struct bpf_key *key) __ksym;
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool=
 is_kernel)
>  {
>         struct bpf_key *bkey;
>         __u32 pid;
> diff --git a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c b/too=
ls/testing/selftests/bpf/progs/test_ptr_untrusted.c
> index 2fdc44e766248..21fce1108a21d 100644
> --- a/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
> +++ b/tools/testing/selftests/bpf/progs/test_ptr_untrusted.c
> @@ -7,7 +7,7 @@
>  char tp_name[128];
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, =
bool is_kernel)
>  {
>         switch (cmd) {
>         case BPF_RAW_TRACEPOINT_OPEN:
> diff --git a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c b=
/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
> index 7e750309ce274..18ad24a851c6c 100644
> --- a/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
> +++ b/tools/testing/selftests/bpf/progs/test_task_under_cgroup.c
> @@ -49,7 +49,7 @@ int BPF_PROG(tp_btf_run, struct task_struct *task, u64 =
clone_flags)
>  }
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
> +int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size, =
bool is_kernel)
>  {
>         struct cgroup *cgrp =3D NULL;
>         struct task_struct *task;
> diff --git a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c b/=
tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> index 12034a73ee2d2..135665f011c7e 100644
> --- a/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> +++ b/tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> @@ -37,7 +37,7 @@ struct {
>  char _license[] SEC("license") =3D "GPL";
>
>  SEC("lsm.s/bpf")
> -int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
> +int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool=
 is_kernel)
>  {
>         struct bpf_dynptr data_ptr, sig_ptr;
>         struct data *data_val;
> --
> 2.48.1
>

