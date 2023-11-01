Return-Path: <bpf+bounces-13781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A17DDBB5
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 04:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E15A1C20DB2
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109401374;
	Wed,  1 Nov 2023 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZm8vkKK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233E1845
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 03:55:11 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30BAC1;
	Tue, 31 Oct 2023 20:55:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313e742a787so253735f8f.1;
        Tue, 31 Oct 2023 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698810908; x=1699415708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=fZm8vkKKqOSIcofsxbkKBs6gKtm0G3nysJnpwn+UOhJoKHGqj0j+PCQZRxiMR6gkT/
         xJVoAJbND+xKOLjbbWybqNcq74dHq95jUBogQxHSipU7h7/CKegi01QvjPbXXC5p0ZmJ
         etoPn/014get5N9KDSG/NV0TVh8ayU2FXN4hfTP+yumVx6vXmL0Lfadw5BFDlrwk8JDg
         LVt5lu1VHgaia9z9LqL10vpskqJ8cqKXOECXw2wDnrmjGfL9/mR+L7XAI4ZKW1Ipcy5O
         FDLybJxxT/KmYjvS6jzTlh4a9Lg1LEyfHOypXq3gk64LaTaNvwKVjO85L/u9ZC1DNGzf
         rwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698810908; x=1699415708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB0/maXrKhTyio7d/n+oJLiXoE4Nk47OqpdEbHEpM+Q=;
        b=v6E2BrViqzedMnnCZJv4QrvUzuTsIVRZsblundj+4lDsNNOvSA/7OFjz0MKMqH/9/C
         OieSFTfIiGoNj2iPo/cXw5vcu/qOIwz+XpDMkYA2iDN/CyQ4DgbHElFbxLUZ/44yKaTQ
         RPLQ6hA20wELqwCY+is8Wnz9j1DDdAif97BpoTXiytQakZz1JBSePpzbDRtF8pMtAKjy
         kfO7oq6+IZM60Wj1/eBMEsSi1KrViYCXJT7p1GmRsxrOg36zl4F9H1tVKAHs73Ek3+Yu
         qetIs79f7efqsu7TgEn4vL0eemczDZ55cOFrJxxcnjNO5xSJ2IFYp543B6dpOu14EQBi
         SwzA==
X-Gm-Message-State: AOJu0YxGFm+y2w7QzUBLzVTEV3VYrgkZPbfWh+8ms1/XHgVKQx5jt/6c
	+Vi8M6LLy06eYQomjudcIo9TEj/eS2AK9DnuDu4=
X-Google-Smtp-Source: AGHT+IEr7KyXAJEpInft+c9ZhQlYvVmFJWyLpzhcsVLEkhcHWsrXKsLbILhZlE1rMBSUuUxgrsGXTN9cMIGNRYTrhyM=
X-Received: by 2002:a05:6000:154b:b0:32f:811c:dfc4 with SMTP id
 11-20020a056000154b00b0032f811cdfc4mr5397720wry.4.1698810907910; Tue, 31 Oct
 2023 20:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org> <ZUEzzc/Sod8OR28B@krava>
In-Reply-To: <ZUEzzc/Sod8OR28B@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 20:54:56 -0700
Message-ID: <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> > Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> > possible to build the kernel without CONFIG_CGROUPS:
> >
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> >   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclare=
d (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |              ^~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is re=
ported only once for each function it appears in
> >   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undecl=
ared (first use in this function)
> >     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >         |                                    ^~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof'=
 to incomplete type 'struct css_task_iter'
> >     927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma, sizeof(=
struct css_task_iter));
> >         |                                                            ^~=
~~~~
> >   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function=
 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=3Dimplicit-=
function-declaration]
> >     930 |         css_task_iter_start(css, flags, kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~~~
> >         |         task_seq_start
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> >   kernel/bpf/task_iter.c:940:16: error: implicit declaration of functio=
n 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=3Dimpl=
icit-function-declaration]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~
> >         |                class_dev_iter_next
> >   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function=
 with return type 'struct task_struct *' makes pointer from integer without=
 a cast [-Werror=3Dint-conversion]
> >     940 |         return css_task_iter_next(kit->css_it);
> >         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> >   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function=
 'css_task_iter_end' [-Werror=3Dimplicit-function-declaration]
> >     949 |         css_task_iter_end(kit->css_it);
> >         |         ^~~~~~~~~~~~~~~~~
> >
> > This patch simply surrounds with a #ifdef the new code requiring CGroup=
s
> > support. It seems enough for the compiler and this is similar to
> > bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> > been added in kernel/bpf/helpers.c and in the selftests.
> >
> > Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfunc=
s")
> > Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665=
206927
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp=
@intel.com/
> > Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
>
> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

I believe this patch has the same issue as Arnd's patch:
https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpo=
R1RQ@mail.gmail.com/

I'd like to merge the fix asap. Please make it a complete fix.

