Return-Path: <bpf+bounces-6666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150376C30D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 04:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF5F281C95
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D7A47;
	Wed,  2 Aug 2023 02:46:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2239A3D
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:46:13 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECB1BFD
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 19:46:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so81525361fa.2
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690944369; x=1691549169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pQYaecfVLGZ+Li6T9igKR8xZ9yuYVsnZtcXmVSUnAY=;
        b=G8+vjwue/Mjj/Rb6MkAqIbIAgrY3KtAstvwe0d4Gs2Ru8ce4HZt+0HkrS9eohtiCZW
         JSe+P+G7Y1zWn6sDYZhVpnbGogqV0qGmqv9MMure+ZGr4IW2KE6nt4e2gIc0yU+5Jsi5
         1J/yMnDvaGie3Zzxvcd25vaRLl6NKYWqLkDLTTq4JwUmCtp3i3FdA9M8n65GIM1S9DGK
         kZrwU0c8PXkCWrCHSW5YMM2EPS6arbnsK20CvNM9Ig3oAUaT2gNQJcSfG4DOOKhrh5po
         q7CgdaWD+V7x8NctvS+UQpqKrdbTAyFbzrEXNJ8vDl9BmVpXvKqI8ADfSPKYolguMle5
         uaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944369; x=1691549169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pQYaecfVLGZ+Li6T9igKR8xZ9yuYVsnZtcXmVSUnAY=;
        b=Y89kpcUTITuALitTBtMn2WO3LJPzw85Qxm62FQPuY2MuIcqPXDzVvFg/T9ZnBu8Kub
         HL6Lzgo/AVj9gAmQ4+9nQlY1W49hBL2QNqbRPPpZ6o4/42nVGAWLzwn9+7KoBnbovwcX
         jPdzTEBwB406gbD4qc8/BBnpu5MAFm9QonsmMY9Ubzovpvd3Exi6FZOM5yJvQm0aaKd6
         1BvV3VdwSRohknjTtBRyf+uhDgdujpwEnLhIhmmIVdGVig/6knIdT7z5QgsiB4HXQnYH
         XxFq/ksBy2Zul40E111OvQGdvbffIhbw2x8av96J67zUxS0GXcbWnsK6DJ478ZJ3pFoe
         K0QQ==
X-Gm-Message-State: ABy/qLbX+bPQVa6panb40FszxpOLraUdDOe6IcJzzHZ93QyWddUZcPNH
	KrP490e7s3Y8kNwn2hnNSqZ203+Q5QdWN72g0Og=
X-Google-Smtp-Source: APBJJlECKEZDUQNTcYgOvAnjg9MBf5Ee5cQOfmiQ6vUd7WztPZxhk1cdRGddpZNQNhGqJjv7h/wGpUacHVqatza4jQg=
X-Received: by 2002:a2e:92c8:0:b0:2b7:2ea:33c9 with SMTP id
 k8-20020a2e92c8000000b002b702ea33c9mr4034204ljh.20.1690944368989; Tue, 01 Aug
 2023 19:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
In-Reply-To: <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Aug 2023 19:45:57 -0700
Message-ID: <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: Yafang Shao <laoar.shao@gmail.com>, David Vernet <void@manifault.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 7:34=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> >
> > In kernel, we have a global variable
> >     nr_cpu_ids (also in kernel/bpf/helpers.c)
> > which is used in numerous places for per cpu data struct access.
> >
> > I am wondering whether we could have bpf code like
> >     int nr_cpu_ids __ksym;
> >
> >     struct bpf_iter_num it;
> >     int i =3D 0;
> >
> >     // nr_cpu_ids is special, we can give it a range [1, CONFIG_NR_CPUS=
].
> >     bpf_iter_num_new(&it, 1, nr_cpu_ids);
> >     while ((v =3D bpf_iter_num_next(&it))) {
> >            /* access cpu i data */
> >            i++;
> >     }
> >     bpf_iter_num_destroy(&it);
> >
> >  From all existing open coded iterator loops, looks like
> > upper bound has to be a constant. We might need to extend support
> > to bounded scalar upper bound if not there.
>
> Currently the upper bound is required by both the open-coded for-loop
> and the bpf_loop. I think we can extend it.
>
> It can't handle the cpumask case either.
>
>     for_each_cpu(cpu, mask)
>
> In the 'mask', the CPU IDs might not be continuous. In our container
> environment, we always use the cpuset cgroup for some critical tasks,
> but it is not so convenient to traverse the percpu data of this cpuset
> cgroup.  We have to do it as follows for this case :
>
> That's why we prefer to introduce a bpf_for_each_cpu helper. It is
> fine if it can be implemented as a kfunc.

I think open-coded-iterators is the only acceptable path forward here.
Since existing bpf_iter_num doesn't fit due to sparse cpumask,
let's introduce bpf_iter_cpumask and few additional kfuncs
that return cpu_possible_mask and others.

We already have some cpumask support in kernel/bpf/cpumask.c
bpf_iter_cpumask will be a natural follow up.

