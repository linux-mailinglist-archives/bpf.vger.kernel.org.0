Return-Path: <bpf+bounces-6083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750627655F9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3091E2822CD
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615D1775B;
	Thu, 27 Jul 2023 14:30:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557BB171AB
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 14:30:01 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1FD30DC
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:29:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d23473ed5so6587446d6.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468198; x=1691072998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEKBqk82IU+MYWRUbhA1F8wN5qnI2wG4J9mhD707rs8=;
        b=eDV4EJiyLnUQFOku/s0s+GbjCa1kpzDp6Zk3EcU5u7Epq+dd+qCX5ekuZJByOFsGjN
         Q/R+4g7Z3JjggGZPmNtwu3qu0UYJjMOxur2WKQi5Qj4KaUsYshiUdjp7mrhW8e2Z6axI
         aWzJwTO5j61kJKJWQ/tfVtktijUmOx8/Q1YJeg2G3qIGB+V923S89uXV3mwqFo/dzW/+
         hjjNJBUEeBTjx2PVIwChw5BSXuaPOaPNOmQyWNYLyHIqI+oFai2jcK5b1SF47mC328UG
         PpP/FCgrtl0dl8syPdLudmaisbmnIY6xzkAWhh6cLZoT2hGlM6pFagZvkm6/OJNQtzK7
         xJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468198; x=1691072998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEKBqk82IU+MYWRUbhA1F8wN5qnI2wG4J9mhD707rs8=;
        b=Jwhh4yDtEPqGK2ji5QBcgLSbiCUcRI7gL7Hnb61KSppzGzKceWfPXGXaR6geBHbZZg
         j8BT1w/xS4dRKdA8C9Zky8QpP1tde/CXjiXCsIqn4esfJXBRlpo9WolvwGwB8gWbuF6T
         FVwfTGe31PkG0nmjIxWeMfvFOzzCHepVhZ4hBOCVqoorhRx8H4wU6/ijQb8/IFUgOHd9
         FA2T5V0duWvOK4OmDnZjMQfQD5qsNv1zEXlh6pQObmSILPbuuydNIwJxK6hBUjkAxEvY
         veWzHHaa2T12YgiAhYGzcKmjGpxRgYNEvnPoVFhLiJNKxXiwHgNLWrkzlU67jPBPBOgD
         aJ/g==
X-Gm-Message-State: ABy/qLZ5cRvO7R5SxUzhSLpEbzxRYK5+Xj7hM3/EYVZ0EwbyOSGQ7Ebz
	eB2jfDqI166LTu/Wqw9ac/cDUMEqoL4wWQslD34=
X-Google-Smtp-Source: APBJJlFV8nWhez0tN6sRBSdCVNSXEgi0vAyDLzjX85cnd/4HQCxz5uunoDcuvMzztn1D+pcT9C8z3x6akTEOvO34iJ0=
X-Received: by 2002:a05:6214:5b0e:b0:632:15e6:a75e with SMTP id
 ma14-20020a0562145b0e00b0063215e6a75emr128094qvb.46.1690468198098; Thu, 27
 Jul 2023 07:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230716121046.17110-1-laoar.shao@gmail.com>
In-Reply-To: <20230716121046.17110-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 27 Jul 2023 22:29:22 +0800
Message-ID: <CALOAHbC3_b=T4mcWrQNgMQ=vCnmbuNve6YrbLZCYZO_WLfXArg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/4] bpf: Introduce cgroup_task iter
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 8:10=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> This patch introduces cgroup_task iter, which allows for efficient
> iteration of tasks within a specific cgroup. For example, we can effientl=
y
> get the nr_{running,blocked} of a container with this new feature.
>
> The cgroup_task iteration serves as an alternative to task_iter in
> container environments due to certain limitations associated with
> task_iter.
>
> - Firstly, task_iter only supports the 'current' pidns.
>   However, since our data collector operates on the host, we may need to
>   collect information from multiple containers simultaneously. Using
>   task_iter would require us to fork the collector for each container,
>   which is not ideal.
>
> - Additionally, task_iter is unable to collect task information from
> containers running in the host pidns.
>   In our container environment, we have containers running in the host
>   pidns, and we would like to collect task information from them as well.
>
> - Lastly, task_iter does not support multiple-container pods.
>   In a Kubernetes environment, a single pod may contain multiple
>   containers, all sharing the same pidns. However, we are only interested
>   in iterating tasks within the main container, which is not possible wit=
h
>   task_iter.
>
> To address the first issue, we could potentially extend task_iter to
> support specifying a pidns other than the current one. However, for the
> other two issues, extending task_iter would not provide a solution.
> Therefore, we believe it is preferable to introduce the cgroup_task iter =
to
> handle these scenarios effectively.
>
> Patch #1: Preparation
> Patch #2: Add cgroup_task iter
> Patch #3: Add support for cgroup_task iter in bpftool
> Patch #4: Selftests for cgroup_task iter
>
> Yafang Shao (4):
>   bpf: Add __bpf_iter_attach_cgroup()
>   bpf: Add cgroup_task iter
>   bpftool: Add support for cgroup_task
>   selftests/bpf: Add selftest for cgroup_task iter
>
>  include/linux/btf_ids.h                       |  14 ++
>  kernel/bpf/cgroup_iter.c                      | 181 ++++++++++++++--
>  tools/bpf/bpftool/link.c                      |   3 +-
>  .../bpf/prog_tests/cgroup_task_iter.c         | 197 ++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_task_iter.c    |  39 ++++
>  5 files changed, 419 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_task_it=
er.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_task_iter.c
>

Just a kind reminder.

Anyone is interested in this idea ?

--=20
Regards
Yafang

