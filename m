Return-Path: <bpf+bounces-14280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4575A7E1BA8
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0889428120B
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E281EFBF2;
	Mon,  6 Nov 2023 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB19F9C8
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:06:31 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB190;
	Mon,  6 Nov 2023 00:06:29 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so2990997276.1;
        Mon, 06 Nov 2023 00:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699257989; x=1699862789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEegE8ckZG10k1Ra1Y/drVVKgI3ZUf2FMeALzLcJgsk=;
        b=Y7Vbbyfwdp41G+/9MRhLWX9XrTnkUSW/jGsW3UDyoYaZVpb1zhZa7iJ+U/3iAQBgeQ
         MtU4HEnBIitTXL8JS8KOwzJq9DZ2AZOWBFJv3+DUgHq6Z3/074C4DmXXSSLDwvYFZIXI
         erDqrxvIDA4rnbr1UtYubHeXNP1KqGUMjJXquwDGJ7w8Xcm/l/MAX27DHhR6vx91X8T/
         qbEPPe8l0BlrHb9ouoBHhjhsg3e+sWoXaCAvbD/LU7+OMvewq6rs9pGM5p+1lewUnwIN
         nW5TzTEYScGLfTHlP4qE0XisMfenHiQjA4AiHZaedK5XNIKRZ5f2HWGdQ2whsgx800TR
         vBXA==
X-Gm-Message-State: AOJu0Ywy90DsfCbpHoU+BHCSKOZ4X7NStWfBHlQLjUmD0XMKzscw8reb
	zbElO/pzAoYWbC7XidU1NTk3Jn0U4mYFbg==
X-Google-Smtp-Source: AGHT+IFg9RQNjiQOpL049DiRTpAneWA1kKsJw01oZXkPJj4HuqwWC1buYHuV9YsiByr4J0TqCkf/3w==
X-Received: by 2002:a25:a422:0:b0:da0:94fb:fd7e with SMTP id f31-20020a25a422000000b00da094fbfd7emr26392374ybi.45.1699257988724;
        Mon, 06 Nov 2023 00:06:28 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 203-20020a2516d4000000b00d7745e2bb19sm3680396ybw.29.2023.11.06.00.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 00:06:28 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso4458136276.2;
        Mon, 06 Nov 2023 00:06:27 -0800 (PST)
X-Received: by 2002:a5b:748:0:b0:d9a:4bc3:226d with SMTP id
 s8-20020a5b0748000000b00d9a4bc3226dmr29092496ybq.34.1699257987652; Mon, 06
 Nov 2023 00:06:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101181601.1493271-1-jolsa@kernel.org>
In-Reply-To: <20231101181601.1493271-1-jolsa@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 6 Nov 2023 09:06:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUK4iRF7rTrSypEcbGTO0SnBUFDqT_HA9B7Pj62wTbYAw@mail.gmail.com>
Message-ID: <CAMuHMdUK4iRF7rTrSypEcbGTO0SnBUFDqT_HA9B7Pj62wTbYAw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] bpf: fix compilation error without CGROUPS
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, kernel test robot <lkp@intel.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 7:16=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
> From: Matthieu Baerts <matttbe@kernel.org>
> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> possible to build the kernel without CONFIG_CGROUPS:
>
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared =
(first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |              ^~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is repo=
rted only once for each function it appears in
>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclar=
ed (first use in this function)
>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' t=
o incomplete type 'struct css_task_iter'
>     927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(st=
ruct css_task_iter));
>         |                                                            ^~~~=
~~
>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function '=
css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=3Dimplicit-fu=
nction-declaration]
>     930 |         css_task_iter_start(css, flags, kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~~~
>         |         task_seq_start
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function =
'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=3Dimplic=
it-function-declaration]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~
>         |                class_dev_iter_next
>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function w=
ith return type 'struct task_struct *' makes pointer from integer without a=
 cast [-Werror=3Dint-conversion]
>     940 |         return css_task_iter_next(kit->css_it);
>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function '=
css_task_iter_end' [-Werror=3Dimplicit-function-declaration]
>     949 |         css_task_iter_end(kit->css_it);
>         |         ^~~~~~~~~~~~~~~~~
>
> This patch simply surrounds with a #ifdef the new code requiring CGroups
> support. It seems enough for the compiler and this is similar to
> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> been added in kernel/bpf/helpers.c and in the selftests.
>
> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs"=
)
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/666520=
6927
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@i=
ntel.com/
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> [ added missing ifdefs for BTF_ID cgroup definitions ]
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thank you, this (finally, reported first on Oct 20!) fixes the build of
e.g. m68k/defconfig.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

