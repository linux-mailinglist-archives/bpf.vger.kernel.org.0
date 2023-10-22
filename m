Return-Path: <bpf+bounces-12948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70E7D2420
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 18:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177581C209A8
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 16:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75910974;
	Sun, 22 Oct 2023 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK1hIKKq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECEB6133
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 16:04:14 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9826ADE
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 09:04:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d9d8284abso1707659f8f.3
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697990651; x=1698595451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoYiAH1OnvbAZXhFtreaTPgu1XDekONIFALk35396as=;
        b=nK1hIKKqq+92KFFcC3zvGP90CHes367hW9I8HT6bfTGb/NBsdCpidZcEcRE9s1qyzw
         +/hcs+sn9aOhFc+6pNLGNXobM+jLdZ0nCKEaNyKFcwaC9lu7EgIlFUfBFbrXLTjB2cem
         CegCLojl30u2Br1fiw2MM38+QvbX3YAfoH/MvL32OdjnDLtoSLc0O0dNgZydDmb7W+p+
         UUu5PXyXTAEknslF+m2IzPHOfDgOF2YBNUUWhACUSZ/BF262+61H1DjRJlKCuNjrs+P4
         FjZzDYfbg6pDSdlEqgEDRINtbH8thIE6jTXKGl+44x+twec/yJrK7hR4FHIb12Ibub3B
         ny/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697990651; x=1698595451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoYiAH1OnvbAZXhFtreaTPgu1XDekONIFALk35396as=;
        b=IjgyYUPANTaM9BygRGp0kTBu6cyiRVcbXU2uePIUfXVJa68+4eTrQujJleiGmSAxyG
         wi5s4osTYsGjC5hd3ZSD3t4FBitNUmo8c0ClBUupVfCVoxxIS5NI20zNz8xWZIl2hXcf
         Sai8dUGpjFpr+9fWcAcuUSBZWOEf0mudklmmajMOxbiCUJuEwAsCirGV182lVEg50liE
         I8lHuNIGejqDnWNrSAL9WAfi9K3HrGrsaPCcdCfYT8+jvJ7J/nORDM8VZLPDMTJIZ+Z2
         nxJUiwU38QTBDjUGS3gzDzK4KEVe1OG/hChOYrIbwUvrIqAGdm5+19apEsdLEZ2uY1xs
         0bWA==
X-Gm-Message-State: AOJu0YzxSvNPoBAW4ADCtpvQhS6KGJOZ30KPbXevRV33boVkS9UX8xjI
	kfjRFoUaDhnfcEAlwygo+7fjzatlqulkOkI9+hg=
X-Google-Smtp-Source: AGHT+IFmd0EM2/0xDtZl6dMw65skFPp6XUeSpNYwCzSpBdh/fX5radxIR/lZo1SSmlkKEa73ZamDdsUCABx8gTOa+Ek=
X-Received: by 2002:a5d:5229:0:b0:32d:1258:dc98 with SMTP id
 i9-20020a5d5229000000b0032d1258dc98mr4506856wra.11.1697990650792; Sun, 22 Oct
 2023 09:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022154527.229117-1-zhouchuyi@bytedance.com> <20231022154527.229117-3-zhouchuyi@bytedance.com>
In-Reply-To: <20231022154527.229117-3-zhouchuyi@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 22 Oct 2023 09:03:59 -0700
Message-ID: <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 8:45=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> This patch adds a test which demonstrates how css_task iter can be combin=
ed
> with cgroup iter and it won't cause deadlock, though cgroup iter is not
> sleepable.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
>  .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools=
/testing/selftests/bpf/prog_tests/cgroup_iter.c
> index e02feb5fae97..3679687a6927 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
> @@ -4,6 +4,7 @@
>  #include <test_progs.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> +#include "iters_css_task.skel.h"
>  #include "cgroup_iter.skel.h"
>  #include "cgroup_helpers.h"
>
> @@ -263,6 +264,35 @@ static void test_walk_dead_self_only(struct cgroup_i=
ter *skel)
>         close(cgrp_fd);
>  }
>
> +static void test_walk_self_only_css_task(void)
> +{
> +       struct iters_css_task *skel =3D NULL;
> +       int err;
> +
> +       skel =3D iters_css_task__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.cgroup_id_printer, true);
> +
> +       err =3D iters_css_task__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +       err =3D join_cgroup(cg_path[CHILD2]);
> +       if (!ASSERT_OK(err, "join_cgroup"))
> +               goto cleanup;
> +
> +       skel->bss->target_pid =3D getpid();
> +       snprintf(expected_output, sizeof(expected_output),
> +               PROLOGUE "%8llu\n" EPILOGUE, cg_id[CHILD2]);
> +       read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[CHILD2=
],
> +               BPF_CGROUP_ITER_SELF_ONLY, "test_walk_self_only_css_task"=
);
> +       ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
> +cleanup:
> +       iters_css_task__destroy(skel);
> +}
> +
>  void test_cgroup_iter(void)
>  {
>         struct cgroup_iter *skel =3D NULL;
> @@ -293,6 +323,9 @@ void test_cgroup_iter(void)
>                 test_walk_self_only(skel);
>         if (test__start_subtest("cgroup_iter__dead_self_only"))
>                 test_walk_dead_self_only(skel);
> +       if (test__start_subtest("cgroup_iter__self_only_css_task"))
> +               test_walk_self_only_css_task();
> +
>  out:
>         cgroup_iter__destroy(skel);
>         cleanup_cgroups();
> diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/t=
esting/selftests/bpf/progs/iters_css_task.c
> index 5089ce384a1c..0974e6f44328 100644
> --- a/tools/testing/selftests/bpf/progs/iters_css_task.c
> +++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
> @@ -10,6 +10,7 @@
>
>  char _license[] SEC("license") =3D "GPL";
>
> +struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
>  struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
>  void bpf_cgroup_release(struct cgroup *p) __ksym;
>
> @@ -45,3 +46,43 @@ int BPF_PROG(iter_css_task_for_each, struct vm_area_st=
ruct *vma,
>
>         return -EPERM;
>  }
> +
> +static inline u64 cgroup_id(struct cgroup *cgrp)
> +{
> +       return cgrp->kn->id;
> +}
> +
> +SEC("?iter/cgroup")
> +int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
> +{
> +       struct seq_file *seq =3D ctx->meta->seq;
> +       struct cgroup *cgrp, *acquired;
> +       struct cgroup_subsys_state *css;
> +       struct task_struct *task;
> +
> +       cgrp =3D ctx->cgroup;
> +
> +       /* epilogue */
> +       if (cgrp =3D=3D NULL) {
> +               BPF_SEQ_PRINTF(seq, "epilogue\n");
> +               return 0;
> +       }
> +
> +       /* prologue */
> +       if (ctx->meta->seq_num =3D=3D 0)
> +               BPF_SEQ_PRINTF(seq, "prologue\n");
> +
> +       BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
> +
> +       acquired =3D bpf_cgroup_from_id(cgroup_id(cgrp));

You're doing this dance, because a plain cgrp pointer is not trusted?
Maybe let's add
BTF_TYPE_SAFE_RCU_OR_NULL(struct bpf_iter__cgroup) {...}
to the verifier similar to what we do for bpf_iter__task.

After if (cgrp =3D=3D NULL) check the pointer is safe to iterate on.

> +       if (!acquired)
> +               return 0;
> +       css =3D &acquired->self;
> +       css_task_cnt =3D 0;
> +       bpf_for_each(css_task, task, css, CSS_TASK_ITER_PROCS) {
> +               if (task->pid =3D=3D target_pid)
> +                       css_task_cnt++;
> +       }
> +       bpf_cgroup_release(acquired);
> +       return 0;
> +}
> --
> 2.20.1
>

